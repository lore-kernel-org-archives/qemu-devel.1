Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9EBC35240
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 09:39:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D94102070E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 09:39:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D94102070E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwjov-0003jU-VG
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 04:39:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51482)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fthain@telegraphics.com.au>) id 1iwjl5-0003bv-86
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 04:35:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fthain@telegraphics.com.au>) id 1iwjl3-0000nl-Hu
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 04:35:39 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:50074)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <fthain@telegraphics.com.au>)
 id 1iwjl3-0000kr-CW; Wed, 29 Jan 2020 04:35:37 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
 id CA578299C8; Wed, 29 Jan 2020 04:35:35 -0500 (EST)
To: Jason Wang <jasowang@redhat.com>,
    qemu-devel@nongnu.org
Message-Id: <593b2398a3eba28a555f63b0f40b67396dd5d181.1580290069.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1580290069.git.fthain@telegraphics.com.au>
References: <cover.1580290069.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v4 14/14] dp8393x: Don't stop reception upon RBE interrupt
 assertion
Date: Wed, 29 Jan 2020 20:27:49 +1100
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 98.124.60.144
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Section 3.4.7 of the datasheet explains that,

    The RBE bit in the Interrupt Status register is set when the
    SONIC finishes using the second to last receive buffer and reads
    the last RRA descriptor. Actually, the SONIC is not truly out of
    resources, but gives the system an early warning of an impending
    out of resources condition.

RBE does not mean actual receive buffer exhaustion, and reception should
not be stopped. This is important because Linux will not check and clear
the RBE interrupt until it receives another packet. But that won't
happen if can_receive returns false. This bug causes the SONIC to become
deaf (until reset).

Fix this with a new flag to indicate actual receive buffer exhaustion.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Tested-by: Laurent Vivier <laurent@vivier.eu>
---
Changed since v2:
 - Don't use can_receive to suspend packet reception.
 - Don't misuse the RBE interrupt flag as a proxy for RRP == RWP.
---
 hw/net/dp8393x.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index 93eb07e6c8..cb55913a8a 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -158,6 +158,7 @@ typedef struct dp8393xState {
     /* Hardware */
     uint8_t it_shift;
     bool big_endian;
+    bool last_rba_is_full;
     qemu_irq irq;
 #ifdef DEBUG_SONIC
     int irq_level;
@@ -347,12 +348,15 @@ static void dp8393x_do_read_rra(dp8393xState *s)
         s->regs[SONIC_RRP] = s->regs[SONIC_RSA];
     }
 
-    /* Check resource exhaustion */
+    /* Warn the host if CRBA now has the last available resource */
     if (s->regs[SONIC_RRP] == s->regs[SONIC_RWP])
     {
         s->regs[SONIC_ISR] |= SONIC_ISR_RBE;
         dp8393x_update_irq(s);
     }
+
+    /* Allow packet reception */
+    s->last_rba_is_full = false;
 }
 
 static void dp8393x_do_software_reset(dp8393xState *s)
@@ -659,9 +663,6 @@ static void dp8393x_write(void *opaque, hwaddr addr, uint64_t data,
                 dp8393x_do_read_rra(s);
             }
             dp8393x_update_irq(s);
-            if (dp8393x_can_receive(s->nic->ncs)) {
-                qemu_flush_queued_packets(qemu_get_queue(s->nic));
-            }
             break;
         /* The guest is required to store aligned pointers here */
         case SONIC_RSA:
@@ -721,8 +722,6 @@ static int dp8393x_can_receive(NetClientState *nc)
 
     if (!(s->regs[SONIC_CR] & SONIC_CR_RXEN))
         return 0;
-    if (s->regs[SONIC_ISR] & SONIC_ISR_RBE)
-        return 0;
     return 1;
 }
 
@@ -773,6 +772,10 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
     s->regs[SONIC_RCR] &= ~(SONIC_RCR_PRX | SONIC_RCR_LBK | SONIC_RCR_FAER |
         SONIC_RCR_CRCR | SONIC_RCR_LPKT | SONIC_RCR_BC | SONIC_RCR_MC);
 
+    if (s->last_rba_is_full) {
+        return pkt_size;
+    }
+
     rx_len = pkt_size + sizeof(checksum);
     if (s->regs[SONIC_DCR] & SONIC_DCR_DW) {
         width = 2;
@@ -786,8 +789,8 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
         DPRINTF("oversize packet, pkt_size is %d\n", pkt_size);
         s->regs[SONIC_ISR] |= SONIC_ISR_RBAE;
         dp8393x_update_irq(s);
-        dp8393x_do_read_rra(s);
-        return pkt_size;
+        s->regs[SONIC_RCR] |= SONIC_RCR_LPKT;
+        goto done;
     }
 
     packet_type = dp8393x_receive_filter(s, buf, pkt_size);
@@ -899,17 +902,23 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
         s->regs[SONIC_ISR] |= SONIC_ISR_PKTRX;
     }
 
+    dp8393x_update_irq(s);
+
     s->regs[SONIC_RSC] = (s->regs[SONIC_RSC] & 0xff00) |
                          ((s->regs[SONIC_RSC] + 1) & 0x00ff);
 
+done:
+
     if (s->regs[SONIC_RCR] & SONIC_RCR_LPKT) {
-        /* Read next RRA */
-        dp8393x_do_read_rra(s);
+        if (s->regs[SONIC_RRP] == s->regs[SONIC_RWP]) {
+            /* Stop packet reception */
+            s->last_rba_is_full = true;
+        } else {
+            /* Read next resource */
+            dp8393x_do_read_rra(s);
+        }
     }
 
-    /* Done */
-    dp8393x_update_irq(s);
-
     return pkt_size;
 }
 
-- 
2.24.1


