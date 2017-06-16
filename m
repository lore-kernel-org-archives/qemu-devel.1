Received: from eggs.gnu.org ([2001:4830:134:3::10]:46894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dLsRY-0001PV-0T
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 10:41:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1dLsRO-0007D2-Ts
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 10:41:48 -0400
From: Kashyap Chamarthy <kchamart@redhat.com>
Date: Fri, 16 Jun 2017 16:41:16 +0200
Message-Id: <1497624077-32614-1-git-send-email-kchamart@redhat.com>
Subject: [Qemu-devel] [PATCH] live-block-ops.txt: Rename, rewrite,
 and improve it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, stephen@that.guru, qemu-block@nongnu.org, Kashyap Chamarthy <kchamart@redhat.com>

This edition documents (including their QMP invocations) all four
operations:

  - `block-stream`
  - `block-commit`
  - `drive-mirror` (& `blockdev-mirror`)
  - `drive-backup` (& `blockdev-backup`)

Things considered while writing this document:

  - Use reStructuredText as markup language (with the goal of generating
    the HTML output using the Sphinx Documentation Generator).  It is
    gentler on the eye, and can be trivially converted to different
    formats.  (Another reason: upstream QEMU is considering to switch to
    Sphinx, which uses reStructuredText as its markup language.)

  - Raw QMP JSON output vs. 'qmp-shell'.  I debated with myself whether
    to only show raw QMP JSON output (as that is the canonical
    representation), or use 'qmp-shell', which takes key-value pairs.  I
    settled on the approach of: for the first occurence of a command,
    use raw JSON; for subsequent occurences, use 'qmp-shell', with an
    occasional exception.

  - Usage of `-blockdev` command-line.

  - Usage of 'node-name' vs. file path to refer to disks.  While we have
    `blockdev-{mirror, backup}` as 'node-name'-alternatives for
    `drive-{mirror, backup}`, the `block-commit` command still operate
    on file names for parameters 'base' and 'top'.  So I added a caveat
    at the beginning to that effect.

    Refer this related thread that I started (where I learnt
    `block-stream` was recently reworked to accept 'node-name' for 'top'
    and 'base' parameters):
    https://lists.nongnu.org/archive/html/qemu-devel/2017-05/msg06466.html
    "[RFC] Making 'block-stream', and 'block-commit' accept node-name"

All commands showed in this document were tested while documenting.

Thanks: Eric Blake for the section: "A note on points-in-time vs file
names".  This useful bit was originally articulated by Eric in his
KVMForum 2015 presentation, so I included that specific bit in this
document.

Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
---
* A Sphinx-rendered HTML version is here:
  https://kashyapc.fedorapeople.org/QEMU-docs/_build/html/docs/live-block-operations.html

* Changes in v2 [address content feedback from Eric; styling changes
  from Stephen Finucane]:
   - [Styling] Remove the ToC, as the Sphinx, ".. contents::" will take
     auto-generate it as part of the rendered version
   - [Styling] Replace ".. code-block::" with "::" as it depends on the
     external 'pygments' library and the syntaxes available vary between
     different versions. [Thanks to Stephen Finucane, who this tip on
     IRC, from experience of doing Sphinx documentation for the Open
     vSwitch project]
   - [Styling] Remove all needless hyperlinks, since ToC will take care
     of them
   - Fix commit message typos
   - Add Copyright / License boilerplate text at the top
   - Reword sentences in "Disk image backing chain notation" section
   - Fix descriptions of `block-{stream, commit}`
   - Rework `block-stream` QMP invocations to take its 'node-name'
     parameter 'base-node'
   - Add 'file.node-name=file' to the '-blockdev' command-line
   - s/shall/will/g
   - Clarify throughout the document, where appropriate,
     that we're starting afresh with the original disk image chain
   - Address mistakes in "Live block commit (`block-commit`)" and
     "QMP invocation for `block-commit`" sections
   - Describe the case of "shallow mirroring" (synchronize only the
     contents of the *top*-most disk image -- "sync": "top") for
     `drive-mirror`, as it's part of an important use case: live storage
     migration without shared storage setup.  (Add a new section: "QMP
     invocation for live storage migration with `drive-mirror` + NBD" as
     part of this)
   - Add QMP invocation example for `blockdev-{mirror, backup}`

* TODO (after feedback from John Snow):
   - Eric Blake suggested to consider documenting incremental backup
     policies as part of the section: "Live disk backup ---
     `drive-backup` and `blockdev-backup`"
---
 docs/live-block-operations.rst | 1105 ++++++++++++++++++++++++++++++++++++++++
 docs/live-block-ops.txt        |   72 ---
 2 files changed, 1105 insertions(+), 72 deletions(-)
 create mode 100644 docs/live-block-operations.rst
 delete mode 100644 docs/live-block-ops.txt

diff --git a/docs/live-block-operations.rst b/docs/live-block-operations.rst
new file mode 100644
index 0000000000000000000000000000000000000000..e1f57152130f66361399692b302a021a46840ece
--- /dev/null
+++ b/docs/live-block-operations.rst
@@ -0,0 +1,1105 @@
+============================
+Live Block Device Operations
+============================
+Copyright (C) 2017 Red Hat Inc.
+
+This work is licensed under the terms of the GNU GPL, version 2 or
+later.  See the COPYING file in the top-level directory.
+
+---
+
+QEMU Block Layer currently (as of QEMU 2.9) supports four major kinds of
+live block device jobs -- stream, commit, mirror, and backup.  These can
+be used to manipulate disk image chains to accomplish certain tasks,
+namely: live copy data from backing files into overlays; shorten long
+disk image chains by merging data from overlays into backing files; live
+synchronize data from a disk image chain (including current active disk)
+to another target image; point-in-time (and incremental) backups of a
+block device.  Below is a description of the said block (QMP)
+primitives, and some (non-exhaustive list of) examples to illustrate
+their use.
+
+NB: The file ``qapi/block-core.json`` in the QEMU source tree has the
+canonical QEMU API (QAPI) schema documentation for the QMP primitives
+discussed here.
+
+
+.. contents::
+
+Disk image backing chain notation
+---------------------------------
+
+A simple disk image chain.  (This can be created live, using QMP
+``blockdev-snapshot-sync``, or offline, via ``qemu-img``):
+
+::
+
+                   (Live QEMU)
+                        |
+                        .
+                        V
+
+            [A] <----- [B]
+
+    (backing file)    (overlay)
+
+The arrow can be read as: Image [A] is the backing file of disk image
+[B].  And live QEMU is currently writing to image [B], consequently, it
+is also referred to as the "active layer".
+
+There are two kinds of terminology that are common when referring to
+files in a disk image backing chain:
+
+(1) Directional: 'base' and 'top'.  Given the simple disk image chain
+    above, image [A] can be referred to as 'base', and image [B] as
+    'top'.  (This terminology can be seen in in QAPI schema file,
+    block-core.json.)
+
+(2) Relational: 'backing file' and 'overlay'.  Again, taking the same
+    simple disk image chain from the above, disk image [A] is referred
+    to as the backing file, and image [B] as overlay.
+
+    Throughout this document, we will use the relational terminology.
+
+NB: The base disk image can be raw format; however, all the overlay
+files must be of QCOW2 format.
+
+
+Brief overview of live block QMP primitives
+-------------------------------------------
+
+The following are the four different kinds of live block operations that
+QEMU block layer supports.
+
+- ``block-stream``: Live copy of data from backing files into overlay
+  files (with the optional goal of removing the backing file from the
+  chain).
+
+- ``block-commit``: Live merge of data from overlay files into backing
+  files (with the optional goal of removing the overlay file from the
+  chain).  Since QEMU 2.0, this includes "active ``block-commit``" (i.e.
+  merge the current active layer into the base image).
+
+- ``drive-mirror`` (and ``blockdev-mirror``): Synchronize running disk
+  to another image.
+
+- ``drive-backup`` (and ``blockdev-backup``): Point-in-time (live) copy
+  of a block device to a destination.
+
+
+.. _`Interacting with a QEMU instance`:
+
+Interacting with a QEMU instance
+--------------------------------
+
+To show some example invocations of command-line, we will use the
+following invocation of QEMU, with a QMP server running over UNIX
+socket:
+
+::
+
+    $ ./x86_64-softmmu/qemu-system-x86_64 -display none -nodefconfig \
+        -M q35 -nodefaults -m 512 \
+        -blockdev node-name=node-A,driver=qcow2,file.driver=file,file.node-name=file,file.filename=./a.qcow2 \
+        -device virtio-blk,drive=node-A,id=virtio0 \
+        -monitor stdio -qmp unix:/tmp/qmp-sock,server,nowait
+
+The ``-blockdev`` command-line option, used above, is available from
+QEMU 2.9 onwards.  In the above invocation, notice the 'node-name'
+parameter that is used to refer to the disk image a.qcow2 ('node-A') --
+this is a cleaner way to refer to a disk image (as opposed to referring
+to it by spelling out file paths).  So, we will continue to designate a
+'node-name' to each further disk image created (either via
+``blockdev-snapshot-sync``, or ``blockdev-add``) as part of the disk
+image chain, and continue to refer to the disks using their 'node-name'
+(where possible, because ``block-stream``, and ``block-commit`` do not
+yet, as of QEMU 2.9, take 'node-name' parameters) when performing
+various block operations.
+
+To interact with the QEMU instance launched above, we will use the
+``qmp-shell`` (located at: ``qemu/scripts/qmp``, as part of the QEMU
+source directory) utility, which takes key-value pairs for QMP commands.
+Invoke it as below (which will also print out the complete raw JSON
+syntax for reference -- examples in the following sections).
+
+::
+
+    $ ./qmp-shell -v -p /tmp/qmp-sock
+    (QEMU)
+
+NB: In the event we have to repeat a certain QMP command, we will: for
+the first occurrence of it, show the the ``qmp-shell`` invocation,
+*and* the corresponding raw JSON QMP syntax; but for subsequent
+invocations, present just the ``qmp-shell`` syntax, and omit the
+equivalent JSON output.
+
+
+Example disk image chain
+------------------------
+
+We will use the below disk image chain (and occasionally spelling it
+out where appropriate) when discussing various primitives.
+
+::
+
+    [A] <-- [B] <-- [C] <-- [D]
+
+Where [A] is the original base image; [B] and [C] are intermediate
+overlay images; image [D] is the active layer -- i.e. live QEMU is
+writing to it.  (The rule of thumb is: live QEMU will always be pointing
+to the right-most image in a disk image chain.)
+
+The above image chain can be created by invoking
+``blockdev-snapshot-sync`` command as following (which shows the
+creation of overlay image [B]) using the ``qmp-shell`` (our invocation
+also prints the raw JSON invocation of it):
+
+::
+
+    (QEMU) blockdev-snapshot-sync node-name=node-A snapshot-file=b.qcow2 snapshot-node-name=node-B format=qcow2
+    {
+        "execute": "blockdev-snapshot-sync",
+        "arguments": {
+            "node-name": "node-A",
+            "snapshot-file": "b.qcow2",
+            "format": "qcow2",
+            "snapshot-node-name": "node-B"
+        }
+    }
+
+Here, "node-A" is the name QEMU internally uses to refer to the base
+image [A] -- it is the backing file, based on which the overlay image,
+[B], is created.
+
+To create the rest of the two overlay images, [C], and [D] (omitted the
+raw JSON output for brevity):
+
+::
+
+    (QEMU) blockdev-snapshot-sync node-name=node-B snapshot-file=c.qcow2 snapshot-node-name=node-C format=qcow2
+    (QEMU) blockdev-snapshot-sync node-name=node-C snapshot-file=d.qcow2 snapshot-node-name=node-D format=qcow2
+
+
+A note on points-in-time vs file names
+--------------------------------------
+
+In our disk disk image chain:
+
+::
+
+    [A] <-- [B] <-- [C] <-- [D]
+
+We have *three* points in time and an active layer:
+
+- Point 1: Guest state when [B] was created is contained in file [A]
+- Point 2: Guest state when [C] was created is contained in [A] + [B]
+- Point 3: Guest state when [D] was created is contained in
+  [A] + [B] + [C]
+- Active layer: Current guest state is contained in [A] + [B] + [C] +
+  [D]
+
+Therefore, be aware with naming choices:
+
+- Naming a file after the time it is created is misleading -- the
+  guest data for that point in time is *not* contained in that file
+  (as explained earlier)
+- Rather, think of files as a *delta* from the backing file
+
+
+Live block streaming --- ``block-stream``
+-----------------------------------------
+
+The ``block-stream`` command allows you to do live copy data from backing
+files into overlay images.
+
+Given our original example disk image chain from earlier:
+
+::
+
+    [A] <-- [B] <-- [C] <-- [D]
+
+The disk image chain can be shortened in one of the following different
+ways (not an exhaustive list).
+
+(1) Merge everything into the active layer: I.e. copy all contents from
+    the base image, [A], and overlay images, [B] and [C], into [D],
+    _while_ the guest is running.  The resulting chain will be a
+    standalone image, [D] -- with contents from [A], [B] and [C] merged
+    into it (where live QEMU writes go to):
+
+    ::
+
+        [D]
+
+(2) Taking the same example disk image chain mentioned earlier, merge
+    only images [B] and [C] into [D], the active layer.  The result will
+    be contents of images [B] and [C] will be copied into [D], and the
+    backing file pointer of image [D] will be adjusted to point to image
+    [A].  The resulting chain will be:
+
+    ::
+
+        [A] <-- [D]
+
+(3) Intermediate streaming (available since QEMU 2.8): Starting afresh
+    with the original example disk image chain, with a total of four
+    images, it is possible to copy contents from image [B] into image
+    [C].  Once the copy is finished, image [B] can now be (optionally)
+    discarded; and the backing file pointer of image [C] will be
+    adjusted to point to [A].  I.e. after performing "intermediate
+    streaming" of [B] into [C], the resulting image chain will be (where
+    live QEMU is writing to [D]):
+
+    ::
+
+        [A] <-- [C] <-- [D]
+
+
+QMP invocation for ``block-stream``
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+For case (1), to merge contents of all the backing files into the active
+layer, where 'node-D' is the current active image (by default
+``block-stream`` will flatten the entire chain); ``qmp-shell`` (and its
+corresponding JSON output):
+
+::
+
+    (QEMU) block-stream device=node-D job-id=job0
+    {
+        "execute": "block-stream",
+        "arguments": {
+            "device": "node-D",
+            "job-id": "job0"
+        }
+    }
+
+For case (2), merge contents of the images [B] and [C] into [D], where
+image [D] ends up referring to image [A] as its backing file:
+
+::
+
+    (QEMU) block-stream device=node-D base-node=node-A job-id=job0
+
+And for case (3), of "intermediate" streaming", merge contents of images
+[B] into [C], where [C] ends up referring to [A] as its backing image:
+
+::
+
+    (QEMU) block-stream device=node-C base-node=node-A job-id=job0
+
+Progress of a ``block-stream`` operation can be monitored via the QMP
+command:
+
+::
+
+    (QEMU) query-block-jobs
+    {
+        "execute": "query-block-jobs",
+        "arguments": {}
+    }
+
+
+Once the ``block-stream`` operation has completed, QEMU will emit an
+event, ``BLOCK_JOB_COMPLETED``.  The intermediate overlays remain valid,
+and can now be (optionally) discarded, or retained to create further
+overlays based on them.  Finally, the ``block-stream`` jobs can be
+restarted at anytime.
+
+
+Live block commit --- ``block-commit``
+--------------------------------------
+
+The ``block-commit`` command lets you to live merge data from overlay
+images into backing file(s).  Since QEMU 2.0, this includes "live active
+commit" (i.e. it is possible to merge the "active layer", the right-most
+image in a disk image chain where live QEMU will be writing to, into the
+base image).  This is analogous to ``block-stream``, but in opposite
+direction.
+
+Again, starting afresh with our example disk image chain, where live
+QEMU is writing to the right-most image in the chain, [D]:
+
+::
+
+    [A] <-- [B] <-- [C] <-- [D]
+
+The disk image chain can be shortened in one of the following ways:
+
+(1) Commit content from only image [B] into image [A].  The resulting
+    chain is the following, where image [C] is adjusted to point at [A]
+    as its new backing file:
+
+    ::
+
+        [A] <-- [C] <-- [D]
+
+(2) Commit content from images [B] and [C] into image [A].  The
+    resulting chain, where image [D] is adjusted to point to image [A]
+    as its new backing file:
+
+    ::
+
+        [A] <-- [D]
+
+(3) Commit content from images [B], [C], and the active layer [D] into
+    image [A].  The resulting chain (in this case, a consolidated single
+    image):
+
+    ::
+
+        [A]
+
+(4) Commit content from image only image [C] into image [B].  The
+    resulting chain:
+
+    ::
+
+	[A] <-- [B] <-- [D]
+
+(5) Commit content from image [C] and the active layer [D] into image
+    [B].  The resulting chain:
+
+    ::
+
+	[A] <-- [B]
+
+
+QMP invocation for ``block-commit``
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+For case (1), from the previous section -- merge contents only from
+image [B] into image [A], the invocation is as following:
+
+::
+
+    (QEMU) block-commit device=node-D base=a.qcow2 top=b.qcow2 job-id=job0
+    {
+        "execute": "block-commit",
+        "arguments": {
+            "device": "node-D",
+            "job-id": "job0",
+            "top": "b.qcow2",
+            "base": "a.qcow2"
+        }
+    }
+
+Once the above ``block-commit`` operation has completed, a
+``BLOCK_JOB_COMPLETED`` event will be issued, and no further action is
+required.  The end result being, the backing file of image [C] is
+adjusted to point to image [A], and the original 4-image chain will end
+up being transformed to:
+
+::
+
+    [A] <-- [C] <-- [D]
+
+NB: The intermdiate image [B] is invalid (as in: no more further
+overlays based on it can be created) and, therefore, should be dropped.
+
+
+However, case (3), the "active ``block-commit``", is a *two-phase*
+operation: in the first phase, the content from the active overlay,
+along with the intermediate overlays, is copied into the backing file
+(also called, the base image); in the second phase, adjust the said
+backing file as the current active image -- possible via issuing the
+command ``block-job-complete``.  [Optionally, the operation can be
+cancelled, by issuing the command ``block-job-cancel``, but be careful
+when doing this.]
+
+Once the 'commit' operation (started by ``block-commit``) has completed,
+the event ``BLOCK_JOB_READY`` is emitted, signalling the synchronization
+has finished, and the job can be gracefully completed, by issuing
+``block-job-complete``.  (Until such a command is issued, the 'commit'
+operation remains active.)
+
+So, the following is the flow for case (3), "active ``block-commit``" --
+-- to convert a disk image chain such as this:
+
+::
+
+    [A] <-- [B] <-- [C] <-- [D]
+
+Into (where content from all the subsequent overlays, [B], and [C],
+including the active layer, [D], is committed back to [A] -- which is
+where live QEMU is performing all its current writes):
+
+::
+
+    [A]
+
+Start the "active ``block-commit``" operation:
+
+::
+
+    (QEMU) block-commit device=node-D base=a.qcow2 top=d.qcow2 job-id=job0
+    {
+        "execute": "block-commit",
+        "arguments": {
+            "device": "node-D",
+            "job-id": "job0",
+            "top": "d.qcow2",
+            "base": "a.qcow2"
+        }
+    }
+
+
+Once the synchronization has completed, the event ``BLOCK_JOB_READY`` will
+be emitted.
+
+Then, (optionally) query for the status of the active block operations
+(we can see the 'commit' job is now ready to be completed, as indicated
+by the line *"ready": true*):
+
+::
+
+    (QEMU) query-block-jobs
+    {
+        "execute": "query-block-jobs",
+        "arguments": {}
+    }
+    {
+        "return": [
+            {
+                "busy": false,
+                "type": "commit",
+                "len": 1376256,
+                "paused": false,
+                "ready": true,
+                "io-status": "ok",
+                "offset": 1376256,
+                "device": "job0",
+                "speed": 0
+            }
+        ]
+    }
+
+Gracefully, complete the 'commit' block device job:
+
+::
+
+    (QEMU) block-job-complete device=job0
+    {
+        "execute": "block-job-complete",
+        "arguments": {
+            "device": "job0"
+        }
+    }
+    {
+        "return": {}
+    }
+
+Finally, once the above job is completed, an event ``BLOCK_JOB_COMPLETED``
+will be emitted.
+
+[The invocation for rest of the cases, discussed in the previous
+section, is omitted for brevity.]
+
+
+Live disk synchronization --- ``drive-mirror`` and ``blockdev-mirror``
+----------------------------------------------------------------------
+
+Synchronize a running disk image chain (all or part of it) to a target
+image.
+
+Again, given our familiar disk image chain:
+
+::
+
+    [A] <-- [B] <-- [C] <-- [D]
+
+The ``drive-mirror`` (and its newer equivalent ``blockdev-mirror``) allows
+you to copy data from the entire chain into a single target image (which
+can be located on a different host).
+
+Once a 'mirror' job has started, there are two possible actions when a
+``drive-mirror`` job is active:
+
+(1) Issuing the command ``block-job-cancel``: will -- after completing
+    synchronization of the content from the disk image chain to the
+    target image, [E] -- create a point-in-time (which is at the time of
+    *triggering* the cancel command) copy, contained in image [E], of
+    the backing file.
+
+(2) Issuing the command ``block-job-complete``: will, after completing
+    synchronization of the content, adjust the guest device (i.e. live
+    QEMU) to point to the target image, and, causing all the new writes
+    from this point on to happen there.  One use case for this is live
+    storage migration.
+
+
+QMP invocation for ``drive-mirror``
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+To copy the contents of the entire disk image chain, from [A] all the
+way to [D], to a new target (``drive-mirror`` will create the destination
+file, if it doesn't already exist), call it [E]:
+
+::
+
+    (QEMU) drive-mirror device=node-D target=e.qcow2 sync=full job-id=job0
+    {
+        "execute": "drive-mirror",
+        "arguments": {
+            "device": "node-D",
+            "job-id": "job0",
+            "target": "e.qcow2",
+            "sync": "full"
+        }
+    }
+
+The ``"sync": "full"``, from the above, means: copy the *entire* chain
+to the destination.
+
+Following the above, querying for active block jobs will show that a
+'mirror' job is "ready" to be completed (and QEMU will also emit an
+event, ``BLOCK_JOB_READY``):
+
+::
+
+    (QEMU) query-block-jobs
+    {
+        "execute": "query-block-jobs",
+        "arguments": {}
+    }
+    {
+        "return": [
+            {
+                "busy": false,
+                "type": "mirror",
+                "len": 21757952,
+                "paused": false,
+                "ready": true,
+                "io-status": "ok",
+                "offset": 21757952,
+                "device": "job0",
+                "speed": 0
+            }
+        ]
+    }
+
+And, as mentioned in the previous section, the two possible options can
+be taken:
+
+(a) Create a point-in-time snapshot by ending the synchronization.  The
+    point-in-time is at the time of *ending* the sync.  (The result of
+    the following being: the target image, [E], will be populated with
+    content from the entire chain, [A] to [D].)
+
+::
+
+    (QEMU) block-job-cancel device=job0
+    {
+        "execute": "block-job-cancel",
+        "arguments": {
+            "device": "job0"
+        }
+    }
+
+(b) Or, complete the operation and pivot the live QEMU to the target
+    copy:
+
+::
+
+    (QEMU) block-job-complete device=job0
+
+In either of the above cases, if you once again run the
+`query-block-jobs` command, there should not be any active block
+operation.
+
+Comparing 'commit' and 'mirror': In both then cases, the overlay images
+can be discarded.  However, with 'commit', the *existing* base image
+will be modified (by updating it with contents from overlays); while in
+the case of 'mirror', a *new* target image is populated with the data
+from the disk image chain.
+
+
+QMP invocation for live storage migration with ``drive-mirror`` + NBD
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Live storage migration (without shared storage setup) is one of the
+common use-cases.  I.e. given the disk image chain:
+
+::
+
+    [A] <-- [B] <-- [C] <-- [D]
+
+Instead of copying content from the entire chain, synchronize *only* the
+contents of the *top*-most disk image (i.e. the active layer), [D], to a
+target, say, [TargetDisk]. (**NB**: The destination must already have
+the contents of the backing chain (involving images [A], [B], and [C])
+visible via other means, whether by ``cp``, or ``rsync`` or by some
+storage-array-specific command.)  Sometimes, this is also referred to as
+"shallow copy" (because: only the "active layer", and not the rest of
+the image chain, is copied to the destiniation).
+
+The following is the sequence of QMP commands to achieve this setup.
+
+On the destination (for the sake of simplicity, we're using the same
+local host as both, source and destination), we expect the contents
+
+::
+
+    $ qemu-img create -f qcow2 -b ./Contents-of-A-B-C.qcow2 \
+    -F qcow2 ./target-disk.qcow2
+
+We need a destination QEMU (we already have a source QEMU running, that
+was discussed in the section: `Interacting with a QEMU instance`_)
+instance, with the following invocation.  (For the sake of simplicity
+we're using a destination QEMU on the same host, but it could be located
+on a different host):
+
+::
+
+    $ ./x86_64-softmmu/qemu-system-x86_64 -display none -nodefconfig \
+        -M q35 -nodefaults -m 512 \
+        -blockdev node-name=node-TargetDisk,driver=qcow2,file.driver=file,file.node-name=file,file.filename=./target-disk.qcow2 \
+        -device virtio-blk,drive=node-TargetDisk,id=virtio0 \
+        -S -monitor stdio -qmp unix:./qmp-sock2,server,nowait \
+        -incoming tcp:localhost:6666
+
+Given the disk image chain on source QEMU:
+
+::
+
+    [A] <-- [B] <-- [C] <-- [D]
+
+On the destination host, it is expected that the contents of the chain
+"[A] <-- [B] <-- [C]" is *already* present, and therefore copy *only*
+the contents of image [D].
+
+(1) [On *destination* QEMU] As part of the first step, start the built-in
+    NBD server on given host and port:
+
+    ::
+
+        (QEMU) nbd-server-start addr={"type":"inet","data":{"host":"::","port":"49153"}}
+        {
+            "execute": "nbd-server-start",
+            "arguments": {
+                "addr": {
+                    "data": {
+                        "host": "::",
+                        "port": "49153"
+                    },
+                    "type": "inet"
+                }
+            }
+        }
+
+(2) [On *destination* QEMU] And export the destination disk image using
+    QEMU's built-in NBD server:
+
+    ::
+
+        (QEMU) nbd-server-add device=node-TargetDisk writable=true
+        {
+            "execute": "nbd-server-add",
+            "arguments": {
+                "device": "node-TargetDisk"
+            }
+        }
+
+(3) [On *source* QEMU] Then, invoke ``drive-mirror`` (NB: since we're runing
+    ``drive-mirror`` with ``mode=existing`` (meaning: synchronize to a
+    pre-created file, therefore 'existing', file on the target host),
+    with the synchronization mode as 'top' (``"sync: "top"``):
+
+    ::
+
+        (QEMU) drive-mirror device=node-D target=nbd:localhost:49153:exportname=node-TargetDisk sync=top mode=existing job-id=job0
+        {
+            "execute": "drive-mirror",
+            "arguments": {
+                "device": "node-D",
+                "mode": "existing",
+                "job-id": "job0",
+                "target": "nbd:localhost:49153:exportname=node-TargetDisk",
+                "sync": "top"
+            }
+        }
+
+(4) [On *source* QEMU] Once ``drive-mirror`` copies the entire data, and the
+    event ``BLOCK_JOB_READY`` is emitted, issue ``block-job-cancel`` to
+    gracefully end the synchronization, from source QEMU:
+
+    ::
+
+        (QEMU) block-job-cancel device=job0
+        {
+            "execute": "block-job-cancel",
+            "arguments": {
+                "device": "job0"
+            }
+        }
+
+(5) [On *destination* QEMU] Then, stop the NBD server:
+
+    ::
+
+        (QEMU) nbd-server-stop
+        {
+            "execute": "nbd-server-stop",
+            "arguments": {}
+        }
+
+(6) [On *destination* QEMU] Finally, resume the guest vCPUs by issuing the
+    QMP command `cont`:
+
+    ::
+
+        (QEMU) cont
+        {
+            "execute": "cont",
+            "arguments": {}
+        }
+
+
+NOTE: Higher-level libraries (e.g. libvirt) automate the entire above
+process.
+
+
+Notes on ``blockdev-mirror``
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The ``blockdev-mirror`` command is equivalent in core functionality to
+``drive-mirror``, except that it operates at node-level in a BDS graph.
+
+Also: for ``blockdev-mirror``, the 'target' image needs to be explicitly
+created (using ``qemu-img``) and attach it to live QEMU via
+``blockdev-add``, which assigns a name to the to-be created target node.
+
+E.g. the sequence of actions to create a point-in-time backup of an
+entire disk image chain, to a target, using ``blockdev-mirror`` would be:
+
+(0) Create the QCOW2 overlays, to arrive at a backing chain of desired
+    depth
+
+(1) Create the target image (using ``qemu-img``), say, backup.qcow2
+
+(2) Attach the above created backup.qcow2 file, run-time, using
+    ``blockdev-add`` to QEMU
+
+(3) Perform ``blockdev-mirror`` (use ``"sync": "full"`` to copy the
+    entire chain to the target).  And observe for the event
+    ``BLOCK_JOB_READY``
+
+(4) Optionally, query for active block jobs, there should be a 'mirror'
+    job ready to be completed
+
+(5) Gracefully complete the 'mirror' block device job, and observe for
+    the event ``BLOCK_JOB_COMPLETED``
+
+(6) Shutdown the guest, by issuing the QMP ``quit`` command, so that
+    caches are flushed
+
+(7) Then, finally, compare the contents of the disk image chain, and
+    the target copy with ``qemu-img compare``.  You should notice:
+    "Images are identical"
+
+
+QMP invocation for ``blockdev-mirror``
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Given the disk image chain:
+
+::
+
+    [A] <-- [B] <-- [C] <-- [D]
+
+To copy the contents of the entire disk image chain, from [A] all the
+way to [D], to a new target, call it [E].  The following is the flow.
+
+Create the overlay images, [B], [C], and [D]:
+
+::
+
+    (QEMU) blockdev-snapshot-sync node-name=node-A snapshot-file=b.qcow2 snapshot-node-name=node-B format=qcow2
+    (QEMU) blockdev-snapshot-sync node-name=node-B snapshot-file=c.qcow2 snapshot-node-name=node-C format=qcow2
+    (QEMU) blockdev-snapshot-sync node-name=node-C snapshot-file=d.qcow2 snapshot-node-name=node-D format=qcow2
+
+Create the target image, [E]:
+
+::
+
+    $ qemu-img create -f qcow2 e.qcow2 39M
+
+Add the above created target image to QEMU, via ``blockdev-add``:
+
+::
+
+    (QEMU) blockdev-add driver=qcow2 node-name=node-E file={"driver":"file","filename":"e.qcow2"}
+    {
+        "execute": "blockdev-add",
+        "arguments": {
+            "node-name": "node-E",
+            "driver": "qcow2",
+            "file": {
+                "driver": "file",
+                "filename": "e.qcow2"
+            }
+        }
+    }
+
+Perform ``blockdev-mirror``, and observe for the event
+``BLOCK_JOB_READY``:
+
+::
+
+    (QEMU) blockdev-mirror device=node-B target=node-E sync=full job-id=job0
+    {
+        "execute": "blockdev-mirror",
+        "arguments": {
+            "device": "node-D",
+            "job-id": "job0",
+            "target": "node-E",
+            "sync": "full"
+        }
+    }
+
+Query for active block jobs, there should be a 'mirror' job ready:
+
+::
+
+    (QEMU) query-block-jobs
+    {
+        "execute": "query-block-jobs",
+        "arguments": {}
+    }
+    {
+        "return": [
+            {
+                "busy": false,
+                "type": "mirror",
+                "len": 21561344,
+                "paused": false,
+                "ready": true,
+                "io-status": "ok",
+                "offset": 21561344,
+                "device": "job0",
+                "speed": 0
+            }
+        ]
+    }
+
+Gracefully complete the block device job operation, and observe for the
+event ``BLOCK_JOB_COMPLETED``:
+
+::
+
+    (QEMU) block-job-complete device=job0
+    {
+        "execute": "block-job-complete",
+        "arguments": {
+            "device": "job0"
+        }
+    }
+    {
+        "return": {}
+    }
+
+Shutdown the guest, by issuing the ``quit`` QMP command:
+
+::
+
+    (QEMU) quit
+    {
+        "execute": "quit",
+        "arguments": {}
+    }
+
+
+Live disk backup --- ``drive-backup`` and ``blockdev-backup``
+-------------------------------------------------------------
+
+The ``drive-backup`` (and its newer equivalent ``blockdev-backup``) allows
+you to create a point-in-time snapshot.
+
+In this case, the point-in-time is when you *start* the ``drive-backup``
+(or its newer equivalent ``blockdev-backup``) command.
+
+
+QMP invocation for ``drive-backup``
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Yet again, starting afresh with our example disk image chain:
+
+::
+
+    [A] <-- [B] <-- [C] <-- [D]
+
+To create a target image [E], with content populated from image [A] to
+[D], from the above chain, the following is the syntax.  (If the target
+image does not exist, ``drive-backup`` will create it.)
+
+::
+
+    (QEMU) drive-backup device=node-D sync=full target=e.qcow2 job-id=job0
+    {
+        "execute": "drive-backup",
+        "arguments": {
+            "device": "node-D",
+            "job-id": "job0",
+            "sync": "full",
+            "target": "copy-drive-backup.qcow2"
+        }
+    }
+
+Once the above ``drive-backup`` has completed, a ``BLOCK_JOB_COMPLETED`` event
+will be issued, indicating the live block device job operation has
+completed, and no further action is required.
+
+
+Notes on ``blockdev-backup``
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The ``blockdev-backup`` command is equivalent in functionality to
+``drive-backup``, except that it operates at node-level in a Block Driver
+State (BDS) graph.
+
+E.g. the sequence of actions to create a point-in-time backup
+of an entire disk image chain, to a target, using ``blockdev-backup``
+would be:
+
+(0) Create the QCOW2 overlays, to arrive at a backing chain of desired
+    depth
+
+(1) Create the target image (using ``qemu-img``), say, backup.qcow2
+
+(2) Attach the above created backup.qcow2 file, run-time, using
+    ``blockdev-add`` to QEMU
+
+(3) Perform ``blockdev-backup`` (use ``"sync": "full"`` to copy the
+    entire chain to the target).  And observe for the event
+    ``BLOCK_JOB_COMPLETED``
+
+(4) Shutdown the guest, by issuing the QMP ``quit`` command, so that
+    caches are flushed
+
+(5) Then, finally, compare the contents of the disk image chain, and
+    the target copy with ``qemu-img compare``.  You should notice:
+    "Images are identical"
+
+The following section shows an example QMP invocation for
+``blockdev-backup``.
+
+QMP invocation for ``blockdev-backup``
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Given, a disk image chain of depth 1, where image [B] is the active
+overlay (live QEMU is writing to it):
+
+::
+
+    [A] <-- [B]
+
+The following is the procedure to copy the content from the entire chain
+to a target image (say, [E]), which has the full content from [A] and
+[B].
+
+Create the overlay, [B]:
+
+::
+
+    (QEMU) blockdev-snapshot-sync node-name=node-A snapshot-file=b.qcow2 snapshot-node-name=node-B format=qcow2
+    {
+        "execute": "blockdev-snapshot-sync",
+        "arguments": {
+            "node-name": "node-A",
+            "snapshot-file": "b.qcow2",
+            "format": "qcow2",
+            "snapshot-node-name": "node-B"
+        }
+    }
+
+
+Create a target image, that will contain the copy:
+
+::
+
+    $ qemu-img create -f qcow2 e.qcow2 39M
+
+Then, add it to QEMU via ``blockdev-add``:
+
+::
+
+    (QEMU) blockdev-add driver=qcow2 node-name=node-E file={"driver":"file","filename":"e.qcow2"}
+    {
+        "execute": "blockdev-add",
+        "arguments": {
+            "node-name": "node-E",
+            "driver": "qcow2",
+            "file": {
+                "driver": "file",
+                "filename": "e.qcow2"
+            }
+        }
+    }
+
+Then, invoke ``blockdev-backup``, to copy the contents from the entire
+image chain, consisting of images [A], and [B], to the target image
+'e.qcow2':
+
+::
+
+    (QEMU) blockdev-backup device=node-B target=node-E sync=full job-id=job0
+    {
+        "execute": "blockdev-backup",
+        "arguments": {
+            "device": "node-B",
+            "job-id": "job0",
+            "target": "node-E",
+            "sync": "full"
+        }
+    }
+
+Once the above 'backup' operation has completed, an event,
+``BLOCK_JOB_COMPLETED``, will be emitted, signalling successful
+completion.
+
+Next, query for any active block device jobs (there should be none):
+
+::
+
+    (QEMU) query-block-jobs
+    {
+        "execute": "query-block-jobs",
+        "arguments": {}
+    }
+
+Shutdown the guest (**NB**: the following step is really important; if not
+done, an error, "Failed to get shared "write" lock on e.qcow2", will be
+thrown when you do ``qemu-img compare``):
+
+::
+
+    (QEMU) quit
+    {
+            "execute": "quit",
+                "arguments": {}
+    }
+            "return": {}
+    }
+    (QEMU)
+    {u'timestamp': {u'seconds': 1496072942, u'microseconds': 685292}, u'event': u'SHUTDOWN'}
+
+
+The end result will be, the image 'e.qcow2' containing a
+point-in-time backup of the disk image chain -- i.e. contents from
+images [A], and [B] at the time the ``blockdev-backup`` command was
+initiated.
+
+One way to confirm the backup disk image contains the identical content
+with the disk image chain is to compare the backup, and the contents of
+the chain, you should see "Images are identical".  (NB: this is assuming
+QEMU was launched with `-S` option, which will not start the CPUs at
+guest boot up):
+
+::
+
+    $ qemu-img compare b.qcow2 e.qcow2
+    Warning: Image size mismatch!
+    Images are identical.
+
+NOTE: The "Warning: Image size mismatch!" is expected, as we created the
+target image (e.qcow2) with 39M size.
diff --git a/docs/live-block-ops.txt b/docs/live-block-ops.txt
deleted file mode 100644
index 2211d14428a846f215f4396950a5743a2e3bfe94..0000000000000000000000000000000000000000
--- a/docs/live-block-ops.txt
+++ /dev/null
@@ -1,72 +0,0 @@
-LIVE BLOCK OPERATIONS
-=====================
-
-High level description of live block operations. Note these are not
-supported for use with the raw format at the moment.
-
-Note also that this document is incomplete and it currently only
-covers the 'stream' operation. Other operations supported by QEMU such
-as 'commit', 'mirror' and 'backup' are not described here yet. Please
-refer to the qapi/block-core.json file for an overview of those.
-
-Snapshot live merge
-===================
-
-Given a snapshot chain, described in this document in the following
-format:
-
-[A] <- [B] <- [C] <- [D] <- [E]
-
-Where the rightmost object ([E] in the example) described is the current
-image which the guest OS has write access to. To the left of it is its base
-image, and so on accordingly until the leftmost image, which has no
-base.
-
-The snapshot live merge operation transforms such a chain into a
-smaller one with fewer elements, such as this transformation relative
-to the first example:
-
-[A] <- [E]
-
-Data is copied in the right direction with destination being the
-rightmost image, but any other intermediate image can be specified
-instead. In this example data is copied from [C] into [D], so [D] can
-be backed by [B]:
-
-[A] <- [B] <- [D] <- [E]
-
-The operation is implemented in QEMU through image streaming facilities.
-
-The basic idea is to execute 'block_stream virtio0' while the guest is
-running. Progress can be monitored using 'info block-jobs'. When the
-streaming operation completes it raises a QMP event. 'block_stream'
-copies data from the backing file(s) into the active image. When finished,
-it adjusts the backing file pointer.
-
-The 'base' parameter specifies an image which data need not be
-streamed from. This image will be used as the backing file for the
-destination image when the operation is finished.
-
-In the first example above, the command would be:
-
-(qemu) block_stream virtio0 file-A.img
-
-In order to specify a destination image different from the active
-(rightmost) one we can use its node name instead.
-
-In the second example above, the command would be:
-
-(qemu) block_stream node-D file-B.img
-
-Live block copy
-===============
-
-To copy an in use image to another destination in the filesystem, one
-should create a live snapshot in the desired destination, then stream
-into that image. Example:
-
-(qemu) snapshot_blkdev ide0-hd0 /new-path/disk.img qcow2
-
-(qemu) block_stream ide0-hd0
-
-
-- 
2.7.5
