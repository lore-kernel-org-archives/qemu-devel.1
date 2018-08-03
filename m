Received: from eggs.gnu.org ([2001:4830:134:3::10]:52987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1flWA9-0001Zr-4T
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 05:14:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1flWA6-0001pT-AO
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 05:14:21 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:38336)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1flWA6-0001ng-4o
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 05:14:18 -0400
Received: by mail-pl0-x244.google.com with SMTP id u11-v6so2310480plq.5
	for <qemu-devel@nongnu.org>; Fri, 03 Aug 2018 02:14:18 -0700 (PDT)
From: Lidong Chen <jemmy858585@gmail.com>
Date: Fri,  3 Aug 2018 17:13:49 +0800
Message-Id: <1533287630-4221-12-git-send-email-lidongchen@tencent.com>
In-Reply-To: <1533287630-4221-1-git-send-email-lidongchen@tencent.com>
References: <1533287630-4221-1-git-send-email-lidongchen@tencent.com>
Subject: [Qemu-devel] [PATCH v6 11/12] migration: remove the unnecessary
 RDMA_CONTROL_ERROR message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhang.zhanghailiang@huawei.com, quintela@redhat.com, dgilbert@redhat.com
Cc: qemu-devel@nongnu.org, Lidong Chen <lidongchen@tencent.com>

It's not necessary to send RDMA_CONTROL_ERROR when clean up rdma resource.
If rdma->error_state is ture, the message may not send successfully.
and the cm event can also notify the peer qemu.

Signed-off-by: Lidong Chen <lidongchen@tencent.com>
---
 migration/rdma.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 62de2ec..14cdf82 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2305,17 +2305,6 @@ static void qemu_rdma_cleanup(RDMAContext *rdma)
     int idx;
 
     if (rdma->cm_id && rdma->connected) {
-        if ((rdma->error_state ||
-             migrate_get_current()->state == MIGRATION_STATUS_CANCELLING) &&
-            !rdma->received_error) {
-            RDMAControlHeader head = { .len = 0,
-                                       .type = RDMA_CONTROL_ERROR,
-                                       .repeat = 1,
-                                     };
-            error_report("Early error. Sending error.");
-            qemu_rdma_post_send_control(rdma, NULL, &head);
-        }
-
         rdma_disconnect(rdma->cm_id);
         trace_qemu_rdma_cleanup_disconnect();
         rdma->connected = false;
-- 
1.8.3.1
