Received: from eggs.gnu.org ([2001:4830:134:3::10]:52776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1dSPnh-0006bz-EP
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 11:31:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1dSPnf-0000d1-KI
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 11:31:41 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:33516)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pradeepkiruvale@gmail.com>)
	id 1dSPnf-0000cc-Eh
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 11:31:39 -0400
Received: by mail-wr0-x244.google.com with SMTP id x23so47706557wrb.0
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 08:31:39 -0700 (PDT)
From: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>
Date: Tue,  4 Jul 2017 11:31:01 -0400
Message-Id: <1499182263-19139-5-git-send-email-pradeep.jagadeesh@huawei.com>
In-Reply-To: <1499182263-19139-1-git-send-email-pradeep.jagadeesh@huawei.com>
References: <1499182263-19139-1-git-send-email-pradeep.jagadeesh@huawei.com>
Subject: [Qemu-devel] [PATCH v7 4/6] hmp: create a throttle initialization
 function for code reusability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric blake <eblake@redhat.com>, greg kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, alberto garcia <berto@igalia.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

This patch creates a throttle initialization function to maximize the
code reusability. The same code is also used by fsdev.

Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
---
 hmp.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/hmp.c b/hmp.c
index 8c72c58..3f76073 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1749,20 +1749,27 @@ void hmp_change(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, &err);
 }
 
+static void hmp_initialize_io_throttle(IOThrottle *iot, const QDict *qdict)
+{
+    iot->bps = qdict_get_int(qdict, "bps");
+    iot->bps_rd = qdict_get_int(qdict, "bps_rd");
+    iot->bps_wr = qdict_get_int(qdict, "bps_wr");
+    iot->iops = qdict_get_int(qdict, "iops");
+    iot->iops_rd = qdict_get_int(qdict, "iops_rd");
+    iot->iops_wr = qdict_get_int(qdict, "iops_wr");
+}
+
 void hmp_block_set_io_throttle(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
+    IOThrottle *iothrottle;
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
 
+    iothrottle = qapi_BlockIOThrottle_base(&throttle);
+    hmp_initialize_io_throttle(iothrottle, qdict);
     qmp_block_set_io_throttle(&throttle, &err);
     hmp_handle_error(mon, &err);
 }
-- 
1.8.3.1
