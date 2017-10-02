Received: from eggs.gnu.org ([2001:4830:134:3::10]:50525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1dz1nS-0005co-1K
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:34:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1dz1nM-0007uh-3K
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:34:14 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:37885)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pradeepkiruvale@gmail.com>)
	id 1dz1nL-0007uL-T2
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:34:08 -0400
Received: by mail-wr0-x241.google.com with SMTP id v38so946608wrc.4
	for <qemu-devel@nongnu.org>; Mon, 02 Oct 2017 07:34:07 -0700 (PDT)
From: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>
Date: Mon,  2 Oct 2017 10:33:30 -0400
Message-Id: <1506954812-6552-5-git-send-email-pradeep.jagadeesh@huawei.com>
In-Reply-To: <1506954812-6552-1-git-send-email-pradeep.jagadeesh@huawei.com>
References: <1506954812-6552-1-git-send-email-pradeep.jagadeesh@huawei.com>
Subject: [Qemu-devel] [PATCH v13 4/6] hmp: create a throttle initialization
 function for code reuse
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: eric blake <eblake@redhat.com>, greg kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, alberto garcia <berto@igalia.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org
List-ID: <qemu-devel.nongnu.org>

This patch creates a throttle initialization function to maximize the
code reusability. The same code is also used by fsdev.

Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hmp.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/hmp.c b/hmp.c
index ace729d..904fc4a 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1766,20 +1766,28 @@ void hmp_change(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, &err);
 }
 
+static void hmp_initialize_throttle_limits(ThrottleLimits *iot,
+                                           const QDict *qdict)
+{
+    iot->bps_total = qdict_get_int(qdict, "bps");
+    iot->bps_read = qdict_get_int(qdict, "bps_rd");
+    iot->bps_write = qdict_get_int(qdict, "bps_wr");
+    iot->iops_total = qdict_get_int(qdict, "iops");
+    iot->iops_read = qdict_get_int(qdict, "iops_rd");
+    iot->iops_write = qdict_get_int(qdict, "iops_wr");
+}
+
 void hmp_block_set_io_throttle(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
+    ThrottleLimits *tlimits;
     BlockIOThrottle throttle = {
         .has_device = true,
         .device = (char *) qdict_get_str(qdict, "device"),
-        .bps = qdict_get_int(qdict, "bps"),
-        .bps_rd = qdict_get_int(qdict, "bps_rd"),
-        .bps_wr = qdict_get_int(qdict, "bps_wr"),
-        .iops = qdict_get_int(qdict, "iops"),
-        .iops_rd = qdict_get_int(qdict, "iops_rd"),
-        .iops_wr = qdict_get_int(qdict, "iops_wr"),
     };
 
+    tlimits = qapi_BlockIOThrottle_base(&throttle);
+    hmp_initialize_throttle_limits(tlimits, qdict);
     qmp_block_set_io_throttle(&throttle, &err);
     hmp_handle_error(mon, &err);
 }
-- 
1.8.3.1
