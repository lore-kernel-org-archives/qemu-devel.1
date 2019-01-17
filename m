Received: from eggs.gnu.org ([209.51.188.92]:39136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gk9gq-0001ua-Ad
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:34:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gk9go-0007qX-2X
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 10:34:44 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Thu, 17 Jan 2019 17:33:51 +0200
Message-Id: <cover.1547739122.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 00/13] Add a 'x-blockdev-reopen' QMP command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Hi,

here's a patch series to implement a QMP command for bdrv_reopen().
This is not too different from the previous iteration (RFC v2, see
changes below), but I'm not tagging it as RFC any longer.

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
details. Since this command tries to mimic blockdev-add, the state of
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
if any of them has been modified.

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

Removing the backing file can be done by simply passing the option {
..., "backing": null } to x-blockdev-reopen.

Replacing it is not so straightforward. If we pass something like {
..., "backing": { "driver": "foo" ... } } then x-blockdev-reopen will
assume that we're trying to change the options of the existing backing
file (and it will fail in most cases because it'll likely think that
we're trying to change the node name, among other options).

So I decided to use a reference instead: { ..., "backing": "hd2" },
where "hd2" is of an existing node that has been added previously.

Leaving out the "backing" option can be ambiguous on some cases (what
should it do? keep the current backing file? open the default one
specified in the image file?) so x-blockdev-reopen requires that this
option is present. For convenience, if the BDS doesn't have a backing
file then we allow leaving the option out.

As you can see in the patch series, I wrote a relatively large amount
of tests for many different scenarios, including some tricky ones.

Perhaps the part that I'm still not convinced about is the one about
freezing backing links to prevent them from being removed, but the
implementation was quite simple so I decided to give it a go. As
you'll see in the patches I chose to use a bool instead of a counter
because I couldn't think of a case where it would make sense to have
two users freezing the same backing link.

Thanks,

Berto

v1: 
- Patch 10: forbid setting a new backing file with a different
  AioContext.
- Patch 13 (new): Remove unused parameter from bdrv_reopen_multiple.
- Patch 14: Acquire the AioContext before calling
  bdrv_reopen_multiple().
- Patch 15: More test cases.
- Patches 3, 8, 9, 11, 12: scripts/checkpatch.pl is more picky now
  with the format of multi-line comments, so correct them.

RFCv2: https://lists.gnu.org/archive/html/qemu-block/2018-11/msg00901.html

Alberto Garcia (13):
  block: Allow freezing BdrvChild links
  block: Freeze the backing chain for the duration of the commit job
  block: Freeze the backing chain for the duration of the mirror job
  block: Freeze the backing chain for the duration of the stream job
  block: Add 'keep_old_opts' parameter to bdrv_reopen_queue()
  block: Handle child references in bdrv_reopen_queue()
  block: Allow omitting the 'backing' option in certain cases
  block: Allow changing the backing file on reopen
  block: Add 'runtime_opts' and 'mutable_opts' fields to BlockDriver
  block: Add bdrv_reset_options_allowed()
  block: Remove the AioContext parameter from bdrv_reopen_multiple()
  block: Add an 'x-blockdev-reopen' QMP command
  qemu-iotests: Test the x-blockdev-reopen QMP command

 block.c                    |  333 +++++++++++++--
 block/blkdebug.c           |    1 +
 block/commit.c             |    8 +
 block/crypto.c             |    1 +
 block/file-posix.c         |   10 +
 block/iscsi.c              |    2 +
 block/mirror.c             |    8 +
 block/null.c               |    2 +
 block/nvme.c               |    1 +
 block/qcow.c               |    1 +
 block/rbd.c                |    1 +
 block/replication.c        |    7 +-
 block/sheepdog.c           |    2 +
 block/stream.c             |   16 +
 block/vpc.c                |    1 +
 blockdev.c                 |   47 +++
 include/block/block.h      |   11 +-
 include/block/block_int.h  |   12 +
 qapi/block-core.json       |   42 ++
 qemu-io-cmds.c             |    4 +-
 tests/qemu-iotests/224     | 1001 ++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/224.out |    5 +
 tests/qemu-iotests/group   |    1 +
 23 files changed, 1484 insertions(+), 33 deletions(-)
 create mode 100644 tests/qemu-iotests/224
 create mode 100644 tests/qemu-iotests/224.out

-- 
2.11.0
