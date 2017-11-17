Received: from eggs.gnu.org ([2001:4830:134:3::10]:59451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1eFln3-0002lu-5t
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 13:55:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1eFln2-000838-1R
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 13:55:01 -0500
From: Kashyap Chamarthy <kchamart@redhat.com>
Date: Fri, 17 Nov 2017 19:54:44 +0100
Message-Id: <20171117185444.4947-1-kchamart@redhat.com>
Subject: [Qemu-devel] [PATCH v4 for-2.11] QAPI & interop: Clarify events
 emitted by 'block-job-cancel'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com, eblake@redhat.com, Kashyap Chamarthy <kchamart@redhat.com>

When you cancel an in-progress 'mirror' job (or "active `block-commit`)
with QMP `block-job-cancel`, it emits the event: BLOCK_JOB_CANCELLED.
However, when `block-job-cancel` is issued *after* `drive-mirror` has
indicated (via the event BLOCK_JOB_READY) that the source and
destination have reached synchronization:

    [...] # Snip `drive-mirror` invocation & outputs
    {
      "execute":"block-job-cancel",
      "arguments":{
        "device":"virtio0"
      }
    }

    {"return": {}}

It (`block-job-cancel`) will counterintuitively emit the event
'BLOCK_JOB_COMPLETED':

    {
      "timestamp":{
        "seconds":1510678024,
        "microseconds":526240
      },
      "event":"BLOCK_JOB_COMPLETED",
      "data":{
        "device":"virtio0",
        "len":41126400,
        "offset":41126400,
        "speed":0,
        "type":"mirror"
      }
    }

But this is expected behaviour, where the _COMPLETED event indicates
that synchronization has successfully ended (and the destination now has
a point-in-time copy, which is at the time of cancel).

So add a small note to this effect in 'block-core.json'.  While at it,
also update the "Live disk synchronization -- drive-mirror and
blockdev-mirror" section in 'live-block-operations.rst'.

(Thanks: Max Reitz for reminding me of this caveat on IRC.)

Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
Changes in v4:
 - Make the wording nicer [Eric Blake]

Changes in v3:
 - Fix / rewrite the section "Live disk synchronization -- drive-mirror
   and blockdev-mirror" to note this gotcha [John Snow]

Changes in v2:
 - "Note:" seems to be a special construct in Patchew, my usage caused a
    build failure.  So do: s/Note:/Note that/
 - Add the missing 'Signed-off-by'
---
 docs/interop/live-block-operations.rst | 50 ++++++++++++++++++++++------------
 qapi/block-core.json                   |  6 ++++
 2 files changed, 38 insertions(+), 18 deletions(-)

diff --git a/docs/interop/live-block-operations.rst b/docs/interop/live-block-operations.rst
index 5f01797..e811c95 100644
--- a/docs/interop/live-block-operations.rst
+++ b/docs/interop/live-block-operations.rst
@@ -506,26 +506,40 @@ Again, given our familiar disk image chain::
 
     [A] <-- [B] <-- [C] <-- [D]
 
-The ``drive-mirror`` (and its newer equivalent ``blockdev-mirror``) allows
-you to copy data from the entire chain into a single target image (which
-can be located on a different host).
-
-Once a 'mirror' job has started, there are two possible actions while a
-``drive-mirror`` job is active:
-
-(1) Issuing the command ``block-job-cancel`` after it emits the event
-    ``BLOCK_JOB_CANCELLED``: will (after completing synchronization of
-    the content from the disk image chain to the target image, [E])
-    create a point-in-time (which is at the time of *triggering* the
-    cancel command) copy, contained in image [E], of the the entire disk
+The ``drive-mirror`` (and its newer equivalent ``blockdev-mirror``)
+allows you to copy data from the entire chain into a single target image
+(which can be located on a different host), [E].
+
+.. note::
+
+    When you cancel an in-progress 'mirror' job *before* the source and
+    target are synchronized, ``block-job-cancel`` will emit the event
+    ``BLOCK_JOB_CANCELLED``.  However, note that if you cancel a
+    'mirror' job *after* it has indicated (via the event
+    ``BLOCK_JOB_READY``) that the source and target have reached
+    synchronization, then the event emitted by ``block-job-cancel``
+    changes to ``BLOCK_JOB_COMPLETED``.
+
+    Besides the 'mirror' job, the "active ``block-commit``" is the only
+    other block device job that emits the event ``BLOCK_JOB_READY``.
+    The rest of the block device jobs ('stream', "non-active
+    ``block-commit``", and 'backup') end automatically.
+
+So there are two possible actions to take, after a 'mirror' job has
+emitted the event ``BLOCK_JOB_READY``, indicating that the source and
+target have reached synchronization:
+
+(1) Issuing the command ``block-job-cancel`` (after it emits the event
+    ``BLOCK_JOB_COMPLETED``) will create a point-in-time (which is at
+    the time of *triggering* the cancel command) copy of the entire disk
     image chain (or only the top-most image, depending on the ``sync``
-    mode).
+    mode), contained in the target image [E].
 
-(2) Issuing the command ``block-job-complete`` after it emits the event
-    ``BLOCK_JOB_COMPLETED``: will, after completing synchronization of
-    the content, adjust the guest device (i.e. live QEMU) to point to
-    the target image, and, causing all the new writes from this point on
-    to happen there.  One use case for this is live storage migration.
+(2) Issuing the command ``block-job-complete`` (after it emits the event
+    ``BLOCK_JOB_COMPLETED``) will adjust the guest device (i.e. live
+    QEMU) to point to the target image, [E], causing all the new writes
+    from this point on to happen there.  One use case for this is live
+    storage migration.
 
 About synchronization modes: The synchronization mode determines
 *which* part of the disk image chain will be copied to the target.
diff --git a/qapi/block-core.json b/qapi/block-core.json
index ab96e34..0616b73 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2065,6 +2065,12 @@
 # BLOCK_JOB_CANCELLED event.  Before that happens the job is still visible when
 # enumerated using query-block-jobs.
 #
+# Note that if you issue 'block-job-cancel' after 'drive-mirror' has indicated
+# (via the event BLOCK_JOB_READY) that the source and destination are
+# synchronized, then the event triggered by this command changes to
+# BLOCK_JOB_COMPLETED, to indicate that the mirroring has ended and the
+# destination now has a point-in-time copy tied to the time of the cancellation.
+#
 # For streaming, the image file retains its backing file unless the streaming
 # operation happens to complete just as it is being cancelled.  A new streaming
 # operation can be started at a later time to finish copying all data from the
-- 
2.9.5
