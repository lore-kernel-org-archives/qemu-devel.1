Received: from eggs.gnu.org ([2001:4830:134:3::10]:52248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1dsRZk-0006rt-CR
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 06:40:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1dsRZe-0001yk-FH
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 06:40:52 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:33548)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pradeepkiruvale@gmail.com>)
	id 1dsRZe-0001xd-3v
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 06:40:46 -0400
Received: by mail-wr0-x244.google.com with SMTP id b9so1474740wra.0
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 03:40:45 -0700 (PDT)
From: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>
Date: Thu, 14 Sep 2017 06:40:08 -0400
Message-Id: <1505385610-35529-5-git-send-email-pradeep.jagadeesh@huawei.com>
In-Reply-To: <1505385610-35529-1-git-send-email-pradeep.jagadeesh@huawei.com>
References: <1505385610-35529-1-git-send-email-pradeep.jagadeesh@huawei.com>
Subject: [Qemu-devel] [PATCH v11 4/6] hmp: create a throttle initialization
 function for code reuse
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

Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hmp.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/hmp.c b/hmp.c
index cd046c6..acaf0e6 100644
--- a/hmp.c
+++ b/hmp.c
@@ -1752,20 +1752,28 @@ void hmp_change(Monitor *mon, const QDict *qdict)
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
