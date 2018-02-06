Received: from eggs.gnu.org ([2001:4830:134:3::10]:44995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ej9uF-0001GV-QR
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:31:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ej9uE-0003LW-Bx
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:31:55 -0500
Received: from mail-db5eur01on0132.outbound.protection.outlook.com
	([104.47.2.132]:39281
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1ej9uE-0003KQ-4C
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:31:54 -0500
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Tue,  6 Feb 2018 23:30:40 +0300
Message-Id: <20180206203048.11096-27-rkagan@virtuozzo.com>
In-Reply-To: <20180206203048.11096-1-rkagan@virtuozzo.com>
References: <20180206203048.11096-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC PATCH 26/34] hv-scsi: limit the number of
 requests per notification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Jan Dakinevich <jan.dakinevich@virtuozzo.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Cathy Avery <cavery@redhat.com>, Ben Warren <ben@skyportsystems.com>, si-wei liu <si-wei.liu@oracle.com>, "Marcos E. Matsunaga" <Marcos.Matsunaga@oracle.com>, Krish Sadhukhan <krish.sadhukhan@oracle.com>, Vadim Rozenfeld <vrozenfe@redhat.com>

There's a vague feeling that, if there are too many requests in the
incoming ring buffer, processing and replying to them may usurp the
event loop (main thread) and thus induce lags, soft lockups, etc.

So ensure to yield the event loop at most every 1024 requests.

TODO: do something smarter than this
Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
 hw/scsi/hv-scsi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/hv-scsi.c b/hw/scsi/hv-scsi.c
index bbfc26bf0a..aa055340ef 100644
--- a/hw/scsi/hv-scsi.c
+++ b/hw/scsi/hv-scsi.c
@@ -294,8 +294,9 @@ static void hv_scsi_handle_packet(HvScsiReq *req)
 static void hv_scsi_notify_cb(VMBusChannel *chan)
 {
     HvScsi *scsi = HV_SCSI(vmbus_channel_device(chan));
+    int i;
 
-    for (;;) {
+    for (i = 1024; i; i--) {
         HvScsiReq *req = vmbus_channel_recv(chan, sizeof(*req));
         if (!req) {
             break;
@@ -304,6 +305,10 @@ static void hv_scsi_notify_cb(VMBusChannel *chan)
         hv_scsi_init_req(scsi, req);
         hv_scsi_handle_packet(req);
     }
+
+    if (!i) {
+        vmbus_notify_channel(chan);
+    }
 }
 
 static void hv_scsi_reset(HvScsi *scsi)
-- 
2.14.3
