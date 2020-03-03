Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951E6C3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:19:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6385C214DB
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZCWJVBdX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6385C214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j94dl-0000Gm-H0
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 05:19:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52674)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1j94WK-0008BY-1Q
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:11:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1j94WI-0006G5-Os
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:11:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47372
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1j94WI-0006Fw-L3
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:11:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583230282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gk6scAIq8vqYOb97q4nZS0IFIgb/seMluZ2oy4VdAlA=;
 b=ZCWJVBdXYWRoBEMRx5QhuRpDbZ1/WeOw3PJsE86z9bV2S0V6DqpT245zOZ9juB9kmZDrRR
 gV+5x74YQzb9kz8dYqLBcVfIrjKvHjXGUMw+s9pZLOECC1U2Tx4GlleEdRpvV2Q3usB0hL
 0IsFqhVyMrAh9JMd9v3EV+xscHNVCXA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-Aa2i0RVKM_WidHpLGHR_xg-1; Tue, 03 Mar 2020 05:11:18 -0500
X-MC-Unique: Aa2i0RVKM_WidHpLGHR_xg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61A2E800053;
 Tue,  3 Mar 2020 10:11:17 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-98.pek2.redhat.com
 [10.72.12.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BEC688B745;
 Tue,  3 Mar 2020 10:11:15 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org
Subject: [PULL V2 14/23] dp8393x: Don't stop reception upon RBE interrupt
 assertion
Date: Tue,  3 Mar 2020 18:10:33 +0800
Message-Id: <1583230242-14597-15-git-send-email-jasowang@redhat.com>
In-Reply-To: <1583230242-14597-1-git-send-email-jasowang@redhat.com>
References: <1583230242-14597-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Finn Thain <fthain@telegraphics.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Finn Thain <fthain@telegraphics.com.au>

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
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/dp8393x.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index c2ac2a1..8a3504d 100644
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
         s->regs[SONIC_RRP] =3D s->regs[SONIC_RSA];
     }
=20
-    /* Check resource exhaustion */
+    /* Warn the host if CRBA now has the last available resource */
     if (s->regs[SONIC_RRP] =3D=3D s->regs[SONIC_RWP])
     {
         s->regs[SONIC_ISR] |=3D SONIC_ISR_RBE;
         dp8393x_update_irq(s);
     }
+
+    /* Allow packet reception */
+    s->last_rba_is_full =3D false;
 }
=20
 static void dp8393x_do_software_reset(dp8393xState *s)
@@ -661,9 +665,6 @@ static void dp8393x_write(void *opaque, hwaddr addr, ui=
nt64_t data,
                 dp8393x_do_read_rra(s);
             }
             dp8393x_update_irq(s);
-            if (dp8393x_can_receive(s->nic->ncs)) {
-                qemu_flush_queued_packets(qemu_get_queue(s->nic));
-            }
             break;
         /* The guest is required to store aligned pointers here */
         case SONIC_RSA:
@@ -723,8 +724,6 @@ static int dp8393x_can_receive(NetClientState *nc)
=20
     if (!(s->regs[SONIC_CR] & SONIC_CR_RXEN))
         return 0;
-    if (s->regs[SONIC_ISR] & SONIC_ISR_RBE)
-        return 0;
     return 1;
 }
=20
@@ -775,6 +774,10 @@ static ssize_t dp8393x_receive(NetClientState *nc, con=
st uint8_t * buf,
     s->regs[SONIC_RCR] &=3D ~(SONIC_RCR_PRX | SONIC_RCR_LBK | SONIC_RCR_FA=
ER |
         SONIC_RCR_CRCR | SONIC_RCR_LPKT | SONIC_RCR_BC | SONIC_RCR_MC);
=20
+    if (s->last_rba_is_full) {
+        return pkt_size;
+    }
+
     rx_len =3D pkt_size + sizeof(checksum);
     if (s->regs[SONIC_DCR] & SONIC_DCR_DW) {
         width =3D 2;
@@ -788,8 +791,8 @@ static ssize_t dp8393x_receive(NetClientState *nc, cons=
t uint8_t * buf,
         DPRINTF("oversize packet, pkt_size is %d\n", pkt_size);
         s->regs[SONIC_ISR] |=3D SONIC_ISR_RBAE;
         dp8393x_update_irq(s);
-        dp8393x_do_read_rra(s);
-        return pkt_size;
+        s->regs[SONIC_RCR] |=3D SONIC_RCR_LPKT;
+        goto done;
     }
=20
     packet_type =3D dp8393x_receive_filter(s, buf, pkt_size);
@@ -903,17 +906,23 @@ static ssize_t dp8393x_receive(NetClientState *nc, co=
nst uint8_t * buf,
         s->regs[SONIC_ISR] |=3D SONIC_ISR_PKTRX;
     }
=20
+    dp8393x_update_irq(s);
+
     s->regs[SONIC_RSC] =3D (s->regs[SONIC_RSC] & 0xff00) |
                          ((s->regs[SONIC_RSC] + 1) & 0x00ff);
=20
+done:
+
     if (s->regs[SONIC_RCR] & SONIC_RCR_LPKT) {
-        /* Read next RRA */
-        dp8393x_do_read_rra(s);
+        if (s->regs[SONIC_RRP] =3D=3D s->regs[SONIC_RWP]) {
+            /* Stop packet reception */
+            s->last_rba_is_full =3D true;
+        } else {
+            /* Read next resource */
+            dp8393x_do_read_rra(s);
+        }
     }
=20
-    /* Done */
-    dp8393x_update_irq(s);
-
     return pkt_size;
 }
=20
--=20
2.5.0


