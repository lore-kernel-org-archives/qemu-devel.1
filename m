Received: from eggs.gnu.org ([2001:4830:134:3::10]:33288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1eEthp-0002fl-Vk
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 04:10:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1eEthp-00045g-2f
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 04:10:01 -0500
From: Kashyap Chamarthy <kchamart@redhat.com>
Date: Wed, 15 Nov 2017 10:09:47 +0100
Message-Id: <20171115090947.29883-1-kchamart@redhat.com>
Subject: [Qemu-devel] [PATCH v2] qapi: block-core: Clarify events emitted by
 'block-job-cancel'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, armbru@redhat.com, eblake@redhat.com, Kashyap Chamarthy <kchamart@redhat.com>

When you cancel an in-progress live block operation with QMP
`block-job-cancel`, it emits the event: BLOCK_JOB_CANCELLED.  However,
when `block-job-cancel` is issued after `drive-mirror` has indicated (by
emitting the event BLOCK_JOB_READY) that the source and destination
remain synchronized:

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
that synchronization has successfully ended (and the destination has a
point-in-time copy, which is at the time of cancel).

So add a small note to this effect.  (Thanks: Max Reitz for reminding
me of this on IRC.)

Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
---
Changes in v2:
 - "Note:" seems to be a special construct in Patchew, my usage caused a
    build failure.  So do: s/Note:/Note that/
 - Add the missing 'Signed-off-by'
---
 qapi/block-core.json | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index ab96e348e6317bb42769ae20f4a4519bac02e93a..4ecfd1fbc5bc231c69da15d489c44e3e8b0706a5 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2065,6 +2065,14 @@
 # BLOCK_JOB_CANCELLED event.  Before that happens the job is still visible when
 # enumerated using query-block-jobs.
 #
+# Note that the 'block-job-cancel' command will emit the event
+# BLOCK_JOB_COMPLETED if you issue it ('block-job-cancel') after 'drive-mirror'
+# has indicated (by emitting the event BLOCK_JOB_READY) that the source and
+# destination remain synchronized.  In this case, the BLOCK_JOB_COMPLETED
+# event indicates that synchronization (from 'drive-mirror') has successfully
+# ended and the destination now has a point-in-time copy, which is at the time
+# of cancel.
+#
 # For streaming, the image file retains its backing file unless the streaming
 # operation happens to complete just as it is being cancelled.  A new streaming
 # operation can be started at a later time to finish copying all data from the
-- 
2.9.5
