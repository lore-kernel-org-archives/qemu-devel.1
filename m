Received: from eggs.gnu.org ([2001:4830:134:3::10]:48846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cdqf2-0002By-5E
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 22:53:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cdqf0-0008Ty-9r
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 22:53:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52250)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cdqf0-0008T7-3L
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 22:53:42 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 15 Feb 2017 11:53:22 +0800
Message-Id: <1487130802-27953-6-git-send-email-jasowang@redhat.com>
In-Reply-To: <1487130802-27953-1-git-send-email-jasowang@redhat.com>
References: <1487130802-27953-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 5/5] net: e1000e: fix an infinite loop issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>, Li Qiang <liqiang6-s@360.cn>, Jason Wang <jasowang@redhat.com>

From: Li Qiang <liq3ea@gmail.com>

This issue is like the issue in e1000 network card addressed in
this commit:
e1000: eliminate infinite loops on out-of-bounds transfer start.

Signed-off-by: Li Qiang <liqiang6-s@360.cn>
Reviewed-by: Dmitry Fleytman <dmitry@daynix.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/e1000e_core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index c99e2fb..28c5be1 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -806,7 +806,8 @@ typedef struct E1000E_RingInfo_st {
 static inline bool
 e1000e_ring_empty(E1000ECore *core, const E1000E_RingInfo *r)
 {
-    return core->mac[r->dh] == core->mac[r->dt];
+    return core->mac[r->dh] == core->mac[r->dt] ||
+                core->mac[r->dt] >= core->mac[r->dlen] / E1000_RING_DESC_LEN;
 }
 
 static inline uint64_t
@@ -1522,6 +1523,10 @@ e1000e_write_packet_to_guest(E1000ECore *core, struct NetRxPkt *pkt,
             desc_size = core->rx_desc_buf_size;
         }
 
+        if (e1000e_ring_empty(core, rxi)) {
+            return;
+        }
+
         base = e1000e_ring_head_descr(core, rxi);
 
         pci_dma_read(d, base, &desc, core->rx_desc_len);
-- 
2.7.4
