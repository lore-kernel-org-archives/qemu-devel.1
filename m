Received: from eggs.gnu.org ([2001:4830:134:3::10]:53135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fTUVN-0000jD-0n
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 11:49:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fTUVI-0003nQ-5v
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 11:49:45 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 14 Jun 2018 18:48:57 +0300
Message-Id: <cover.1528991017.git.berto@igalia.com>
Subject: [Qemu-devel] [RFC PATCH 00/10] Add a 'x-blockdev-reopen' QMP command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alberto Garcia <berto@igalia.com>

Hi,

here's my first attempt to implement a bdrv_reopen() QMP command. I'm
tagging this as RFC because there are still several important things
that need to be sorted out before I consider this stable enough. And
I'd still prefix the command with an "x-" for a while. But let's get
to the details.

The new command is called x-blockdev-reopen, and it's designed to be
similar to blockdev-add. It also takes BlockdevOptions as a
parameter. The "node-name" field of BlockdevOptions must be set, and
it is used to select the BlockDriverState to reopen.

In this example "hd0" is reopened with the given set of options:

    { "execute": "x-blockdev-reopen",
      "arguments": {
          "driver": "qcow2",
          "node-name": "hd0",
          "file": {
              "driver": "file",
              "filename": "hd0.qcow2",
              "node-name": "hd0f"
          },
          "l2-cache-size": 524288
       }
    }

Changing options
================
The general idea is quite straightforward, but the devil is in the
detail. Since this command tries to mimic blockdev-add, the state of
the block device after being reopened should generally be equivalent
to that of a block device added with the same set of options.

There are two important things with this:

  a) Some options cannot be changed (most drivers don't allow that, in
     fact).
  b) If an option is missing, it should be reset to its default value
     (rather than keeping its previous value).

Example: the default value of l2-cache-size is 1MB. If we set a
different value (2MB) on blockdev-add but then omit the option in
x-blockdev-reopen, then it should be reset back to 1MB. The current
bdrv_reopen() code keeps the previous value.

Trying to change an option that doesn't allow it is already being
handled by the code. The loop at the end of bdrv_reopen_prepare()
checks all options that were not handled by the block driver and sees
if any of them has been modified. There was at least one case where a
block driver silently ignores new values for some options (I fixed
that in the series) but otherwise this works generally well.

However, as I explained earlier in (b), omitting an option is supposed
to reset it to its default value, so it's also a way of changing
it. If the option cannot be changed then we should detect it and
return an error. What I'm doing in this series is making every driver
publish its list of run-time options, and which ones of them can be
modified.

Backing files
=============
This command allows reconfigurations in the node graph. Currently it
only allows changing an image's backing file, but it should be
possible to implement similar functionalities in drivers that have
other children, like blkverify or quorum.

Let's add an image with its backing file (hd1 <- hd0) like this:

    { "execute": "blockdev-add",
      "arguments": {
          "driver": "qcow2",
          "node-name": "hd0",
          "file": {
              "driver": "file",
              "filename": "hd0.qcow2",
              "node-name": "hd0f"
          },
          "backing": {
              "driver": "qcow2",
              "node-name": "hd1",
              "file": {
                  "driver": "file",
                  "filename": "hd1.qcow2",
                  "node-name": "hd1f"
              }
          }
       }
    }

Removing the backing file can be done by simply passing the option
{ ..., "backing": null } to x-blockdev-reopen.

Replacing it is not so straightforward. If we pass something like
{ ..., "backing": { "driver": "foo" ... } } then x-blockdev-reopen
will assume that we're trying to change the options of the existing
backing file (and it will fail in most cases because it'll likely
think that we're trying to change the node name -among other options).

So I decided to use a reference instead: { ..., "backing": "hd2" },
where "hd2" is of an existing node that has been added previously.

If the "backing" option is left out then we simply keep the existing
backing file. I have doubts about this, because it differs from what
blockdev-add would do (open the default backing file stored in the
image header), but I don't think we want to do that on reopen. Perhaps
we could force the user to specify "backing" in these cases? I haven't
explored this option much yet.

There are some tricky things with this: bs->options keeps the
effective set of options for a given BlockDriverState (*), including
the options of the backing file.

    (*) not quite, because that dict is not updated at all in
        bdrv_reopen_commit(). That looks like a bug to me and I'll
        probably need to fix that.

So on one hand the options for a given BDS can appear at least twice:
on the BDS itself an on its parent(s). If you reopen the child then
both sets are out of sync. On the other hand the graph can be
reconfigured by means other than x-blockdev-reopen: if you do
block-stream you are changing a BDS's backing file. That command
includes a call to bdrv_reopen(), keeping the same options, but now
some of those options are invalid because they refer to a BDS that is
no longer part of the backing chain.

Another tricky part is that we could be reopening a BDS while there's
an implicit node in the middle of the chain (e.g. a "commit_top"
filter node). I added some code to handle this, but I fear that it can
still give us some headaches.

As you can see in the patch series, I wrote a relatively large amount
of tests for many different scenarios, including some of the tricky
ones that I mentioned here (check the ones with the FIXME comments).
I'll need to write many more to make sure that all these non-trivial
cases work fine before we can add this new command, but I think this
series is a good starting point to discuss this feature and see if we
need to change something or reconsider any of the design decisions.

As usual, feedback is more than welcome.

Thanks,

Berto

Alberto Garcia (10):
  file-posix: Forbid trying to change unsupported options during reopen
  block: Allow changing 'discard' on reopen
  block: Allow changing 'detect-zeroes' on reopen
  block: Allow changing 'force-share' on reopen
  block: Add 'keep_old_opts' parameter to bdrv_reopen_queue()
  block: Allow changing the backing file on reopen
  block: Add 'runtime_opts' and 'mutable_opts' fields to BlockDriver
  block: Add bdrv_reset_options_allowed()
  block: Add a 'x-blockdev-reopen' QMP command
  qemu-iotests: Test the x-blockdev-reopen QMP command

 block.c                    | 241 +++++++++++++--
 block/blkdebug.c           |   1 +
 block/crypto.c             |   1 +
 block/file-posix.c         |  19 +-
 block/iscsi.c              |   2 +
 block/null.c               |   2 +
 block/nvme.c               |   1 +
 block/qcow.c               |   1 +
 block/rbd.c                |   1 +
 block/replication.c        |   4 +-
 block/sheepdog.c           |   2 +
 block/vpc.c                |   1 +
 blockdev.c                 |  57 ++++
 include/block/block.h      |   5 +-
 include/block/block_int.h  |   4 +
 qapi/block-core.json       |  29 ++
 qemu-io-cmds.c             |   2 +-
 tests/qemu-iotests/220     | 724 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/220.out |   5 +
 tests/qemu-iotests/group   |   1 +
 20 files changed, 1065 insertions(+), 38 deletions(-)
 create mode 100755 tests/qemu-iotests/220
 create mode 100644 tests/qemu-iotests/220.out

-- 
2.11.0
