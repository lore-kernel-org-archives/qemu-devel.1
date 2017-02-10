Received: from eggs.gnu.org ([2001:4830:134:3::10]:35780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cc0oA-00046M-Ou
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 21:19:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cc0o7-0001FB-LC
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 21:19:34 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:36715)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1cc0o7-0001F3-DX
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 21:19:31 -0500
Received: by mail-wr0-x241.google.com with SMTP id k90so13672784wrc.3
	for <qemu-devel@nongnu.org>; Thu, 09 Feb 2017 18:19:31 -0800 (PST)
From: Li Qiang <liq3ea@gmail.com>
Date: Thu,  9 Feb 2017 18:19:19 -0800
Message-Id: <1486693159-29029-1-git-send-email-liqiang6-s@360.cn>
Subject: [Qemu-devel] [PATCH v3] net: e1000e: fix an infinite loop issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dmitry@daynix.com, jasowang@redhat.com, qemu-devel@nongnu.org
Cc: Li Qiang <liqiang6-s@360.cn>

This issue is like the issue in e1000 network card addressed in
this commit:
e1000: eliminate infinite loops on out-of-bounds transfer start.

Signed-off-by: Li Qiang <liqiang6-s@360.cn>
---

Change since v2:
fix error in e1000e_ring_empty
eliminate unnecessory detect code in loop

Changes since v1:
make wraparound detect in e1000e_ring_empty

 hw/net/e1000e_core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 2b11499..dc94188 100644
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
1.8.3.1
