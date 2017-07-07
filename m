Received: from eggs.gnu.org ([2001:4830:134:3::10]:38103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dTbgw-0006Qi-Gh
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 18:25:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dTbgt-0003Mk-P6
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 18:25:38 -0400
References: <1499351806-3359-1-git-send-email-kchamart@redhat.com>
	<1499351806-3359-3-git-send-email-kchamart@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <bf8b230f-15be-9468-20d2-09f8f9ae12fa@redhat.com>
Date: Fri, 7 Jul 2017 18:25:24 -0400
MIME-Version: 1.0
In-Reply-To: <1499351806-3359-3-git-send-email-kchamart@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 2/2] live-block-ops.txt: Rename, rewrite,
 and improve it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, berto@igalia.com, qemu-block@nongnu.org, mreitz@redhat.com

Last time, on DRAGON BALL Q:

On 07/06/2017 10:36 AM, Kashyap Chamarthy wrote:

[A lot of good documentation]

> +
> +So, the following is the flow for `block-commit_Case-3`_ -- to convert a
> +disk image chain such as this::
> +

Maybe drop the "So, "

"The following is the flow for 'Block Commit Case 3' to convert a disk
image chain such as this:"

> +    [A] <-- [B] <-- [C] <-- [D]
> +
> +Into (where content from all the subsequent overlays, [B], and [C],
> +including the active layer, [D], is committed back to [A] -- which is
> +where live QEMU is performing all its current writes)::
> +

"Into: "

> +    [A]
> +

"Where content from all [...] its current writes."

> +Start the "active ``block-commit``" operation::
> +
> +    (QEMU) block-commit device=node-D base=a.qcow2 top=d.qcow2 job-id=job0
> +    {
> +        "execute": "block-commit",
> +        "arguments": {
> +            "device": "node-D",
> +            "job-id": "job0",
> +            "top": "d.qcow2",
> +            "base": "a.qcow2"
> +        }
> +    }
> +
> +
> +Once the synchronization has completed, the event ``BLOCK_JOB_READY`` will
> +be emitted.
> +
> +Then, (optionally) query for the status of the active block operations
> +(we can see the 'commit' job is now ready to be completed, as indicated
> +by the line *"ready": true*)::
> +

Then, optionally query for the status of the active block operations. We
can see the 'commit' job is now ready to be completed, as indicated by
the line *"ready": true*.

> +    (QEMU) query-block-jobs
> +    {
> +        "execute": "query-block-jobs",
> +        "arguments": {}
> +    }
> +    {
> +        "return": [
> +            {
> +                "busy": false,
> +                "type": "commit",
> +                "len": 1376256,
> +                "paused": false,
> +                "ready": true,
> +                "io-status": "ok",
> +                "offset": 1376256,
> +                "device": "job0",
> +                "speed": 0
> +            }
> +        ]
> +    }
> +
> +Gracefully complete the 'commit' block device job::
> +
> +    (QEMU) block-job-complete device=job0
> +    {
> +        "execute": "block-job-complete",
> +        "arguments": {
> +            "device": "job0"
> +        }
> +    }
> +    {
> +        "return": {}
> +    }
> +
> +Finally, once the above job is completed, an event
> +``BLOCK_JOB_COMPLETED`` will be emitted.
> +
> +.. note::
> +    The invocation for rest of the cases (2, 4, and 5), discussed in the
> +    previous section, is omitted for brevity.
> +

As a joke I almost want to write "The invocation for cases 2, 4, and 5
are left as an exercise to the reader."

> +
> +Live disk synchronization --- ``drive-mirror`` and ``blockdev-mirror``
> +----------------------------------------------------------------------
> +
> +Synchronize a running disk image chain (all or part of it) to a target
> +image.
> +
> +Again, given our familiar disk image chain::
> +
> +    [A] <-- [B] <-- [C] <-- [D]
> +
> +The ``drive-mirror`` (and its newer equivalent ``blockdev-mirror``) allows
> +you to copy data from the entire chain into a single target image (which
> +can be located on a different host).
> +
> +Once a 'mirror' job has started, there are two possible actions when a
> +``drive-mirror`` job is active:
> +
> +(1) Issuing the command ``block-job-cancel``, after it emits the event

nix the comma

> +    ``BLOCK_JOB_CANCELLED``: will (after completing synchronization of
> +    the content from the disk image chain to the target image, [E])
> +    create a point-in-time (which is at the time of *triggering* the
> +    cancel command) copy, contained in image [E], of the the entire disk
> +    image chain (or only the top-most image, depending on the ``sync``
> +    mode).
> +
> +(2) Issuing the command ``block-job-complete``, after it emits the event

nix the comma

> +    ``BLOCK_JOB_COMPLETED``: will, after completing synchronization of
> +    the content, adjust the guest device (i.e. live QEMU) to point to
> +    the target image, and, causing all the new writes from this point on
> +    to happen there.  One use case for this is live storage migration.
> +
> +A note on synchronization modes -- determines *what* part of the disk
> +image chain must be copied to the target.  Currently, there are four
> +different kinds:
> +

You've got a note here, followed by a note box. Maybe just:

"About synchronization modes: The synchronization mode determines
*which* part of the disk image chain will be copied to the target.
Currently, there are four different kinds:"

> +(1) ``full`` -- Synchronize the content of entire disk image chain to
> +    the target
> +
> +(2) ``top`` -- Synchronize only the contents of the top-most disk image
> +    in the chain to the target
> +
> +(3) ``none`` -- Synchronize only the new writes from this point on.
> +
> +    .. note:: In the case of ``drive-backup`` (or ``blockdev-backup``),
> +              the behavior of ``none`` sychronization mode is different.
> +              Normally, a ``backup`` job consists of two parts: Anything
> +              that is overwritten by the guest is first copied out to
> +              the backup, and in the background the whole image is
> +              copied from start to end. With ``sync=none``, it's only
> +              the first part.
> +
> +(4) ``incremental`` -- Synchronize content that is described by the
> +    dirty bitmap
> +
> +.. note::
> +    Refer to the :doc:`bitmaps` document in the QEMU source
> +    tree to learn about the detailed workings of the ``incremental``
> +    synchronization mode.
> +
> +
> +QMP invocation for ``drive-mirror``
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +To copy the contents of the entire disk image chain, from [A] all the
> +way to [D], to a new target (``drive-mirror`` will create the destination
> +file, if it doesn't already exist), call it [E]::
> +
> +    (QEMU) drive-mirror device=node-D target=e.qcow2 sync=full job-id=job0
> +    {
> +        "execute": "drive-mirror",
> +        "arguments": {
> +            "device": "node-D",
> +            "job-id": "job0",
> +            "target": "e.qcow2",
> +            "sync": "full"
> +        }
> +    }
> +
> +The ``"sync": "full"``, from the above, means: copy the *entire* chain
> +to the destination.
> +
> +Following the above, querying for active block jobs will show that a
> +'mirror' job is "ready" to be completed (and QEMU will also emit an
> +event, ``BLOCK_JOB_READY``)::
> +
> +    (QEMU) query-block-jobs
> +    {
> +        "execute": "query-block-jobs",
> +        "arguments": {}
> +    }
> +    {
> +        "return": [
> +            {
> +                "busy": false,
> +                "type": "mirror",
> +                "len": 21757952,
> +                "paused": false,
> +                "ready": true,
> +                "io-status": "ok",
> +                "offset": 21757952,
> +                "device": "job0",
> +                "speed": 0
> +            }
> +        ]
> +    }
> +
> +And, as noted in the previous section, there are two possible actions
> +at this point:
> +
> +(a) Create a point-in-time snapshot by ending the synchronization.  The
> +    point-in-time is at the time of *ending* the sync.  (The result of
> +    the following being: the target image, [E], will be populated with
> +    content from the entire chain, [A] to [D])::
> +
> +        (QEMU) block-job-cancel device=job0
> +        {
> +            "execute": "block-job-cancel",
> +            "arguments": {
> +                "device": "job0"
> +            }
> +        }
> +
> +(b) Or, complete the operation and pivot the live QEMU to the target
> +    copy::
> +
> +        (QEMU) block-job-complete device=job0
> +
> +In either of the above cases, if you once again run the
> +`query-block-jobs` command, there should not be any active block
> +operation.
> +
> +Comparing 'commit' and 'mirror': In both then cases, the overlay images
> +can be discarded.  However, with 'commit', the *existing* base image
> +will be modified (by updating it with contents from overlays); while in
> +the case of 'mirror', a *new* target image is populated with the data
> +from the disk image chain.
> +
> +
> +QMP invocation for live storage migration with ``drive-mirror`` + NBD
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Live storage migration (without shared storage setup) is one of the most
> +common use-cases that takes advantage of the ``drive-mirror`` primitive
> +and QEMU's built-in Network Block Device (NBD) server.  Here's a quick
> +walk-through of this setup.
> +
> +Given the disk image chain::
> +
> +    [A] <-- [B] <-- [C] <-- [D]
> +
> +Instead of copying content from the entire chain, synchronize *only* the
> +contents of the *top*-most disk image (i.e. the active layer), [D], to a
> +target, say, [TargetDisk].
> +
> +.. important::
> +    The destination host must already have the contents of the backing
> +    chain, involving images [A], [B], and [C], visible via other means
> +    -- whether by ``cp``, ``rsync``, or by some storage array-specific
> +    command.)
> +
> +Sometimes, this is also referred to as "shallow copy" -- because: only
> +the "active layer", and not the rest of the image chain, is copied to
> +the destination.
> +
> +.. note::
> +    In this example, for the sake of simplicity, we'll be using the same
> +    ``localhost`` as both, source and destination.
> +
> +As noted earlier, on the destination host the contents of the backing
> +chain -- from images [A] to [C] -- are already expected to exist in some
> +form (e.g. in a file called, ``Contents-of-A-B-C.qcow2``).  Now, on the
> +destination host, let's create a target overlay image (with the image
> +``Contents-of-A-B-C.qcow2`` as its backing file), to which the contents
> +of image [D] (from the source QEMU) will be mirrored to::
> +
> +    $ qemu-img create -f qcow2 -b ./Contents-of-A-B-C.qcow2 \
> +        -F qcow2 ./target-disk.qcow2
> +
> +And start the destination QEMU (we already have the source QEMU running
> +-- discussed in the section: `Interacting with a QEMU instance`_)
> +instance, with the following invocation.  (As noted earlier, for
> +simplicity's sake, the destination QEMU is started on the same host, but
> +it could be located elsewhere)::
> +
> +    $ ./x86_64-softmmu/qemu-system-x86_64 -display none -nodefconfig \
> +        -M q35 -nodefaults -m 512 \
> +        -blockdev node-name=node-TargetDisk,driver=qcow2,file.driver=file,file.node-name=file,file.filename=./target-disk.qcow2 \
> +        -device virtio-blk,drive=node-TargetDisk,id=virtio0 \
> +        -S -monitor stdio -qmp unix:./qmp-sock2,server,nowait \
> +        -incoming tcp:localhost:6666
> +
> +Given the disk image chain on source QEMU::
> +
> +    [A] <-- [B] <-- [C] <-- [D]
> +
> +On the destination host, it is expected that the contents of the chain
> +``[A] <-- [B] <-- [C]`` are *already* present, and therefore copy *only*
> +the content of image [D].
> +
> +(1) [On *destination* QEMU] As part of the first step, start the
> +    built-in NBD server on a given host (local host, represented by
> +    ``::``)and port::
> +
> +        (QEMU) nbd-server-start addr={"type":"inet","data":{"host":"::","port":"49153"}}
> +        {
> +            "execute": "nbd-server-start",
> +            "arguments": {
> +                "addr": {
> +                    "data": {
> +                        "host": "::",
> +                        "port": "49153"
> +                    },
> +                    "type": "inet"
> +                }
> +            }
> +        }
> +
> +(2) [On *destination* QEMU] And export the destination disk image using
> +    QEMU's built-in NBD server::
> +
> +        (QEMU) nbd-server-add device=node-TargetDisk writable=true
> +        {
> +            "execute": "nbd-server-add",
> +            "arguments": {
> +                "device": "node-TargetDisk"
> +            }
> +        }
> +
> +(3) [On *source* QEMU] Then, invoke ``drive-mirror`` (NB: since we're
> +    running ``drive-mirror`` with ``mode=existing`` (meaning:
> +    synchronize to a pre-created file, therefore 'existing', file on the
> +    target host), with the synchronization mode as 'top' (``"sync:
> +    "top"``)::
> +
> +        (QEMU) drive-mirror device=node-D target=nbd:localhost:49153:exportname=node-TargetDisk sync=top mode=existing job-id=job0
> +        {
> +            "execute": "drive-mirror",
> +            "arguments": {
> +                "device": "node-D",
> +                "mode": "existing",
> +                "job-id": "job0",
> +                "target": "nbd:localhost:49153:exportname=node-TargetDisk",
> +                "sync": "top"
> +            }
> +        }
> +
> +(4) [On *source* QEMU] Once ``drive-mirror`` copies the entire data, and the
> +    event ``BLOCK_JOB_READY`` is emitted, issue ``block-job-cancel`` to
> +    gracefully end the synchronization, from source QEMU::
> +
> +        (QEMU) block-job-cancel device=job0
> +        {
> +            "execute": "block-job-cancel",
> +            "arguments": {
> +                "device": "job0"
> +            }
> +        }
> +
> +(5) [On *destination* QEMU] Then, stop the NBD server::
> +
> +        (QEMU) nbd-server-stop
> +        {
> +            "execute": "nbd-server-stop",
> +            "arguments": {}
> +        }
> +
> +(6) [On *destination* QEMU] Finally, resume the guest vCPUs by issuing the
> +    QMP command `cont`::
> +
> +        (QEMU) cont
> +        {
> +            "execute": "cont",
> +            "arguments": {}
> +        }
> +
> +
> +.. note::
> +    Higher-level libraries (e.g. libvirt) automate the entire above
> +    process.
> +
> +
> +Notes on ``blockdev-mirror``
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The ``blockdev-mirror`` command is equivalent in core functionality to
> +``drive-mirror``, except that it operates at node-level in a BDS graph.
> +
> +Also: for ``blockdev-mirror``, the 'target' image needs to be explicitly
> +created (using ``qemu-img``) and attach it to live QEMU via
> +``blockdev-add``, which assigns a name to the to-be created target node.
> +
> +E.g. the sequence of actions to create a point-in-time backup of an
> +entire disk image chain, to a target, using ``blockdev-mirror`` would be:
> +
> +(0) Create the QCOW2 overlays, to arrive at a backing chain of desired
> +    depth
> +
> +(1) Create the target image (using ``qemu-img``), say, ``e.qcow2``
> +
> +(2) Attach the above created file (``e.qcow2``), run-time, using
> +    ``blockdev-add`` to QEMU
> +
> +(3) Perform ``blockdev-mirror`` (use ``"sync": "full"`` to copy the
> +    entire chain to the target).  And observe for the event
> +    ``BLOCK_JOB_READY``
> +
> +(4) Optionally, query for active block jobs, there should be a 'mirror'
> +    job ready to be completed
> +
> +(5) Gracefully complete the 'mirror' block device job, and observe for
> +    the event ``BLOCK_JOB_COMPLETED``
> +

"observe for the event" is slightly awkward

> +(6) Shutdown the guest, by issuing the QMP ``quit`` command, so that
> +    caches are flushed
> +

nix both commas

> +(7) Then, finally, compare the contents of the disk image chain, and
> +    the target copy with ``qemu-img compare``.  You should notice:
> +    "Images are identical"
> +
> +
> +QMP invocation for ``blockdev-mirror``
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Given the disk image chain::
> +
> +    [A] <-- [B] <-- [C] <-- [D]
> +
> +To copy the contents of the entire disk image chain, from [A] all the
> +way to [D], to a new target, call it [E].  The following is the flow.
> +
> +Create the overlay images, [B], [C], and [D]::
> +
> +    (QEMU) blockdev-snapshot-sync node-name=node-A snapshot-file=b.qcow2 snapshot-node-name=node-B format=qcow2
> +    (QEMU) blockdev-snapshot-sync node-name=node-B snapshot-file=c.qcow2 snapshot-node-name=node-C format=qcow2
> +    (QEMU) blockdev-snapshot-sync node-name=node-C snapshot-file=d.qcow2 snapshot-node-name=node-D format=qcow2
> +
> +Create the target image, [E]::
> +
> +    $ qemu-img create -f qcow2 e.qcow2 39M
> +
> +Add the above created target image to QEMU, via ``blockdev-add``::
> +
> +    (QEMU) blockdev-add driver=qcow2 node-name=node-E file={"driver":"file","filename":"e.qcow2"}
> +    {
> +        "execute": "blockdev-add",
> +        "arguments": {
> +            "node-name": "node-E",
> +            "driver": "qcow2",
> +            "file": {
> +                "driver": "file",
> +                "filename": "e.qcow2"
> +            }
> +        }
> +    }
> +
> +Perform ``blockdev-mirror``, and observe for the event
> +``BLOCK_JOB_READY``::
> +
> +    (QEMU) blockdev-mirror device=node-B target=node-E sync=full job-id=job0
> +    {
> +        "execute": "blockdev-mirror",
> +        "arguments": {
> +            "device": "node-D",
> +            "job-id": "job0",
> +            "target": "node-E",
> +            "sync": "full"
> +        }
> +    }
> +
> +Query for active block jobs, there should be a 'mirror' job ready::
> +
> +    (QEMU) query-block-jobs
> +    {
> +        "execute": "query-block-jobs",
> +        "arguments": {}
> +    }
> +    {
> +        "return": [
> +            {
> +                "busy": false,
> +                "type": "mirror",
> +                "len": 21561344,
> +                "paused": false,
> +                "ready": true,
> +                "io-status": "ok",
> +                "offset": 21561344,
> +                "device": "job0",
> +                "speed": 0
> +            }
> +        ]
> +    }
> +
> +Gracefully complete the block device job operation, and observe for the
> +event ``BLOCK_JOB_COMPLETED``::
> +
> +    (QEMU) block-job-complete device=job0
> +    {
> +        "execute": "block-job-complete",
> +        "arguments": {
> +            "device": "job0"
> +        }
> +    }
> +    {
> +        "return": {}
> +    }
> +
> +Shutdown the guest, by issuing the ``quit`` QMP command::
> +
> +    (QEMU) quit
> +    {
> +        "execute": "quit",
> +        "arguments": {}
> +    }
> +
> +
> +Live disk backup --- ``drive-backup`` and ``blockdev-backup``
> +-------------------------------------------------------------
> +
> +The ``drive-backup`` (and its newer equivalent ``blockdev-backup``) allows
> +you to create a point-in-time snapshot.
> +
> +In this case, the point-in-time is when you *start* the ``drive-backup``
> +(or its newer equivalent ``blockdev-backup``) command.
> +
> +
> +QMP invocation for ``drive-backup``
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Yet again, starting afresh with our example disk image chain::
> +
> +    [A] <-- [B] <-- [C] <-- [D]
> +
> +To create a target image [E], with content populated from image [A] to
> +[D], from the above chain, the following is the syntax.  (If the target
> +image does not exist, ``drive-backup`` will create it)::
> +
> +    (QEMU) drive-backup device=node-D sync=full target=e.qcow2 job-id=job0
> +    {
> +        "execute": "drive-backup",
> +        "arguments": {
> +            "device": "node-D",
> +            "job-id": "job0",
> +            "sync": "full",
> +            "target": "e.qcow2"
> +        }
> +    }
> +
> +Once the above ``drive-backup`` has completed, a ``BLOCK_JOB_COMPLETED`` event
> +will be issued, indicating the live block device job operation has
> +completed, and no further action is required.
> +
> +
> +Notes on ``blockdev-backup``
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The ``blockdev-backup`` command is equivalent in functionality to
> +``drive-backup``, except that it operates at node-level in a Block Driver
> +State (BDS) graph.
> +
> +E.g. the sequence of actions to create a point-in-time backup
> +of an entire disk image chain, to a target, using ``blockdev-backup``
> +would be:
> +
> +(0) Create the QCOW2 overlays, to arrive at a backing chain of desired
> +    depth
> +
> +(1) Create the target image (using ``qemu-img``), say, ``e.qcow2``
> +
> +(2) Attach the above created file (``e.qcow2``), run-time, using
> +    ``blockdev-add`` to QEMU
> +
> +(3) Perform ``blockdev-backup`` (use ``"sync": "full"`` to copy the
> +    entire chain to the target).  And observe for the event
> +    ``BLOCK_JOB_COMPLETED``
> +
> +(4) Shutdown the guest, by issuing the QMP ``quit`` command, so that
> +    caches are flushed
> +
> +(5) Then, finally, compare the contents of the disk image chain, and
> +    the target copy with ``qemu-img compare``.  You should notice:
> +    "Images are identical"
> +
> +The following section shows an example QMP invocation for
> +``blockdev-backup``.
> +
> +QMP invocation for ``blockdev-backup``
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Given, a disk image chain of depth 1, where image [B] is the active
> +overlay (live QEMU is writing to it)::
> +

Given a disk image chain of depth 1 where image [B] is the active
overlay (live QEMU is writing it)

> +    [A] <-- [B]
> +
> +The following is the procedure to copy the content from the entire chain
> +to a target image (say, [E]), which has the full content from [A] and
> +[B].
> +
> +Create the overlay, [B]::

the overlay [B]

> +
> +    (QEMU) blockdev-snapshot-sync node-name=node-A snapshot-file=b.qcow2 snapshot-node-name=node-B format=qcow2
> +    {
> +        "execute": "blockdev-snapshot-sync",
> +        "arguments": {
> +            "node-name": "node-A",
> +            "snapshot-file": "b.qcow2",
> +            "format": "qcow2",
> +            "snapshot-node-name": "node-B"
> +        }
> +    }
> +
> +
> +Create a target image, that will contain the copy::

sans comma

> +
> +    $ qemu-img create -f qcow2 e.qcow2 39M
> +
> +Then, add it to QEMU via ``blockdev-add``::
> +

and one more time

> +    (QEMU) blockdev-add driver=qcow2 node-name=node-E file={"driver":"file","filename":"e.qcow2"}
> +    {
> +        "execute": "blockdev-add",
> +        "arguments": {
> +            "node-name": "node-E",
> +            "driver": "qcow2",
> +            "file": {
> +                "driver": "file",
> +                "filename": "e.qcow2"
> +            }
> +        }
> +    }
> +
> +Then, invoke ``blockdev-backup``, to copy the contents from the entire
> +image chain, consisting of images [A], and [B], to the target image
> +'e.qcow2'::
> +

Then invoke bd-b to copy the contents from the entire image chain,
consisting of images [A] and [B] to the target image e.qcow2:

> +    (QEMU) blockdev-backup device=node-B target=node-E sync=full job-id=job0
> +    {
> +        "execute": "blockdev-backup",
> +        "arguments": {
> +            "device": "node-B",
> +            "job-id": "job0",
> +            "target": "node-E",
> +            "sync": "full"
> +        }
> +    }
> +
> +Once the above 'backup' operation has completed, an event,
> +``BLOCK_JOB_COMPLETED``, will be emitted, signalling successful
> +completion.
> +

"the event BLOCK_JOB_COMPLETED will be emitted, signalling"

> +Next, query for any active block device jobs (there should be none)::
> +
> +    (QEMU) query-block-jobs
> +    {
> +        "execute": "query-block-jobs",
> +        "arguments": {}
> +    }
> +
> +Shutdown the guest::
> +
> +    (QEMU) quit
> +    {
> +            "execute": "quit",
> +                "arguments": {}
> +    }
> +            "return": {}
> +    }
> +
> +.. note::
> +    The above step is really important; if forgotten, an error, "Failed
> +    to get shared "write" lock on e.qcow2", will be thrown when you do
> +    ``qemu-img compare`` to verify the integrity of the disk image
> +    with the backup content.
> +
> +
> +The end result will be, the image 'e.qcow2' containing a

Goodbye sweet comma, savor the void

> +point-in-time backup of the disk image chain -- i.e. contents from
> +images [A], and [B] at the time the ``blockdev-backup`` command was
> +initiated.
> +

images [A] and [B]

> +One way to confirm the backup disk image contains the identical content
> +with the disk image chain is to compare the backup, and the contents of

Could kill this comma too.

> +the chain, you should see "Images are identical".  (NB: this is assuming
> +QEMU was launched with `-S` option, which will not start the CPUs at
> +guest boot up)::
> +
> +    $ qemu-img compare b.qcow2 e.qcow2
> +    Warning: Image size mismatch!
> +    Images are identical.
> +
> +NOTE: The "Warning: Image size mismatch!" is expected, as we created the
> +target image (e.qcow2) with 39M size.

That's all I got for now. It's looking very good, thank you for your
time. Please consider all of my suggestions are just that. There is a
reason I am not an English professor :)

--js
