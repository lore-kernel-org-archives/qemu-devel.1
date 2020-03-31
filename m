Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E4EC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 13:28:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CA5E20772
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 13:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rzx0f9+b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CA5E20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJGwm-0003c4-NK
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 09:28:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42046)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jJGqS-0000Xk-Fk
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 09:22:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1jJGqN-0005rE-Nl
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 09:22:20 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32625
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1jJGqN-0005qu-Hf
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 09:22:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585660935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yaOwtgmOb1WJgAzFCsAuhnSvk3thhHf/hjpROiOzOAM=;
 b=Rzx0f9+bpE1k7/LO3DeKDCL2xvXUgk4Sq9BQlIQqLVA5Sx/FZ6iXuomMiC88A7Xs4SlrTj
 SazvQy5/KUa8bD8TskoDNcBO2ww+wO81jMW4rapA8fXamgvdjxj4m2d0VYgmGqCH4J7nOb
 ATpUGqjKZn1VQT9xf3Hd3GCyPldGdMM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-x25oJb0RMoaf-QWoJ1_WNg-1; Tue, 31 Mar 2020 09:22:08 -0400
X-MC-Unique: x25oJb0RMoaf-QWoJ1_WNg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94A451085926;
 Tue, 31 Mar 2020 13:22:07 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-118.pek2.redhat.com
 [10.72.12.118])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E84E810002B5;
 Tue, 31 Mar 2020 13:22:05 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL V2 08/14] hw/net: Make NetCanReceive() return a boolean
Date: Tue, 31 Mar 2020 21:21:33 +0800
Message-Id: <1585660899-11228-9-git-send-email-jasowang@redhat.com>
In-Reply-To: <1585660899-11228-1-git-send-email-jasowang@redhat.com>
References: <1585660899-11228-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

The NetCanReceive handler return whether the device can or
can not receive new packets. Make it obvious by returning
a boolean type.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/allwinner_emac.c |  2 +-
 hw/net/cadence_gem.c    |  8 ++++----
 hw/net/dp8393x.c        |  8 +++-----
 hw/net/e1000.c          |  2 +-
 hw/net/e1000e.c         |  2 +-
 hw/net/ftgmac100.c      |  6 +++---
 hw/net/i82596.c         | 10 +++++-----
 hw/net/i82596.h         |  2 +-
 hw/net/imx_fec.c        |  2 +-
 hw/net/opencores_eth.c  |  5 ++---
 hw/net/rtl8139.c        |  8 ++++----
 hw/net/smc91c111.c      |  2 +-
 hw/net/spapr_llan.c     |  4 ++--
 hw/net/sungem.c         |  6 +++---
 hw/net/sunhme.c         |  4 ++--
 hw/net/virtio-net.c     | 10 +++++-----
 hw/net/xilinx_ethlite.c |  2 +-
 include/net/net.h       |  2 +-
 net/filter-buffer.c     |  2 +-
 net/hub.c               |  6 +++---
 20 files changed, 45 insertions(+), 48 deletions(-)

diff --git a/hw/net/allwinner_emac.c b/hw/net/allwinner_emac.c
index e9bbff8..ddddf35 100644
--- a/hw/net/allwinner_emac.c
+++ b/hw/net/allwinner_emac.c
@@ -178,7 +178,7 @@ static uint32_t fifo8_pop_word(Fifo8 *fifo)
     return ret;
 }
=20
-static int aw_emac_can_receive(NetClientState *nc)
+static bool aw_emac_can_receive(NetClientState *nc)
 {
     AwEmacState *s =3D qemu_get_nic_opaque(nc);
=20
diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 6340c1e..51ec5a0 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -505,7 +505,7 @@ static void phy_update_link(CadenceGEMState *s)
     }
 }
=20
-static int gem_can_receive(NetClientState *nc)
+static bool gem_can_receive(NetClientState *nc)
 {
     CadenceGEMState *s;
     int i;
@@ -518,7 +518,7 @@ static int gem_can_receive(NetClientState *nc)
             s->can_rx_state =3D 1;
             DB_PRINT("can't receive - no enable\n");
         }
-        return 0;
+        return false;
     }
=20
     for (i =3D 0; i < s->num_priority_queues; i++) {
@@ -532,14 +532,14 @@ static int gem_can_receive(NetClientState *nc)
             s->can_rx_state =3D 2;
             DB_PRINT("can't receive - all the buffer descriptors are busy\=
n");
         }
-        return 0;
+        return false;
     }
=20
     if (s->can_rx_state !=3D 0) {
         s->can_rx_state =3D 0;
         DB_PRINT("can receive\n");
     }
-    return 1;
+    return true;
 }
=20
 /*
diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index 1563c11..c54db0d 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -414,7 +414,7 @@ static void dp8393x_do_stop_timer(dp8393xState *s)
     dp8393x_update_wt_regs(s);
 }
=20
-static int dp8393x_can_receive(NetClientState *nc);
+static bool dp8393x_can_receive(NetClientState *nc);
=20
 static void dp8393x_do_receiver_enable(dp8393xState *s)
 {
@@ -718,13 +718,11 @@ static void dp8393x_watchdog(void *opaque)
     dp8393x_update_irq(s);
 }
=20
-static int dp8393x_can_receive(NetClientState *nc)
+static bool dp8393x_can_receive(NetClientState *nc)
 {
     dp8393xState *s =3D qemu_get_nic_opaque(nc);
=20
-    if (!(s->regs[SONIC_CR] & SONIC_CR_RXEN))
-        return 0;
-    return 1;
+    return !!(s->regs[SONIC_CR] & SONIC_CR_RXEN);
 }
=20
 static int dp8393x_receive_filter(dp8393xState *s, const uint8_t * buf,
diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index 9233248..2a69eee 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -845,7 +845,7 @@ static bool e1000_has_rxbufs(E1000State *s, size_t tota=
l_size)
     return total_size <=3D bufs * s->rxbuf_size;
 }
=20
-static int
+static bool
 e1000_can_receive(NetClientState *nc)
 {
     E1000State *s =3D qemu_get_nic_opaque(nc);
diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index f2cc155..79ba158 100644
--- a/hw/net/e1000e.c
+++ b/hw/net/e1000e.c
@@ -199,7 +199,7 @@ static const MemoryRegionOps io_ops =3D {
     },
 };
=20
-static int
+static bool
 e1000e_nc_can_receive(NetClientState *nc)
 {
     E1000EState *s =3D qemu_get_nic_opaque(nc);
diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index 2f92b65..041ed21 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -562,18 +562,18 @@ static void ftgmac100_do_tx(FTGMAC100State *s, uint32=
_t tx_ring,
     ftgmac100_update_irq(s);
 }
=20
-static int ftgmac100_can_receive(NetClientState *nc)
+static bool ftgmac100_can_receive(NetClientState *nc)
 {
     FTGMAC100State *s =3D FTGMAC100(qemu_get_nic_opaque(nc));
     FTGMAC100Desc bd;
=20
     if ((s->maccr & (FTGMAC100_MACCR_RXDMA_EN | FTGMAC100_MACCR_RXMAC_EN))
          !=3D (FTGMAC100_MACCR_RXDMA_EN | FTGMAC100_MACCR_RXMAC_EN)) {
-        return 0;
+        return false;
     }
=20
     if (ftgmac100_read_bd(&bd, s->rx_descriptor)) {
-        return 0;
+        return false;
     }
     return !(bd.des0 & FTGMAC100_RXDES0_RXPKT_RDY);
 }
diff --git a/hw/net/i82596.c b/hw/net/i82596.c
index 3b0efd0..055c3a1 100644
--- a/hw/net/i82596.c
+++ b/hw/net/i82596.c
@@ -470,23 +470,23 @@ void i82596_h_reset(void *opaque)
     i82596_s_reset(s);
 }
=20
-int i82596_can_receive(NetClientState *nc)
+bool i82596_can_receive(NetClientState *nc)
 {
     I82596State *s =3D qemu_get_nic_opaque(nc);
=20
     if (s->rx_status =3D=3D RX_SUSPENDED) {
-        return 0;
+        return false;
     }
=20
     if (!s->lnkst) {
-        return 0;
+        return false;
     }
=20
     if (USE_TIMER && !timer_pending(s->flush_queue_timer)) {
-        return 1;
+        return true;
     }
=20
-    return 1;
+    return true;
 }
=20
 #define MIN_BUF_SIZE 60
diff --git a/hw/net/i82596.h b/hw/net/i82596.h
index 1238ac1..f0bbe81 100644
--- a/hw/net/i82596.h
+++ b/hw/net/i82596.h
@@ -48,7 +48,7 @@ void i82596_ioport_writel(void *opaque, uint32_t addr, ui=
nt32_t val);
 uint32_t i82596_ioport_readl(void *opaque, uint32_t addr);
 uint32_t i82596_bcr_readw(I82596State *s, uint32_t rap);
 ssize_t i82596_receive(NetClientState *nc, const uint8_t *buf, size_t size=
_);
-int i82596_can_receive(NetClientState *nc);
+bool i82596_can_receive(NetClientState *nc);
 void i82596_set_link_status(NetClientState *nc);
 void i82596_common_init(DeviceState *dev, I82596State *s, NetClientInfo *i=
nfo);
 extern const VMStateDescription vmstate_i82596;
diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index 5c145a8..a35c336 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -1049,7 +1049,7 @@ static void imx_eth_write(void *opaque, hwaddr offset=
, uint64_t value,
     imx_eth_update(s);
 }
=20
-static int imx_eth_can_receive(NetClientState *nc)
+static bool imx_eth_can_receive(NetClientState *nc)
 {
     IMXFECState *s =3D IMX_FEC(qemu_get_nic_opaque(nc));
=20
diff --git a/hw/net/opencores_eth.c b/hw/net/opencores_eth.c
index 6b338c2..2ba0dc8 100644
--- a/hw/net/opencores_eth.c
+++ b/hw/net/opencores_eth.c
@@ -349,12 +349,11 @@ static void open_eth_reset(void *opaque)
     open_eth_set_link_status(qemu_get_queue(s->nic));
 }
=20
-static int open_eth_can_receive(NetClientState *nc)
+static bool open_eth_can_receive(NetClientState *nc)
 {
     OpenEthState *s =3D qemu_get_nic_opaque(nc);
=20
-    return GET_REGBIT(s, MODER, RXEN) &&
-        (s->regs[TX_BD_NUM] < 0x80);
+    return GET_REGBIT(s, MODER, RXEN) && (s->regs[TX_BD_NUM] < 0x80);
 }
=20
 static ssize_t open_eth_receive(NetClientState *nc,
diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index be9a0af..70aca7e 100644
--- a/hw/net/rtl8139.c
+++ b/hw/net/rtl8139.c
@@ -793,23 +793,23 @@ static bool rtl8139_cp_rx_valid(RTL8139State *s)
     return !(s->RxRingAddrLO =3D=3D 0 && s->RxRingAddrHI =3D=3D 0);
 }
=20
-static int rtl8139_can_receive(NetClientState *nc)
+static bool rtl8139_can_receive(NetClientState *nc)
 {
     RTL8139State *s =3D qemu_get_nic_opaque(nc);
     int avail;
=20
     /* Receive (drop) packets if card is disabled.  */
     if (!s->clock_enabled) {
-        return 1;
+        return true;
     }
     if (!rtl8139_receiver_enabled(s)) {
-        return 1;
+        return true;
     }
=20
     if (rtl8139_cp_receiver_enabled(s) && rtl8139_cp_rx_valid(s)) {
         /* ??? Flow control not implemented in c+ mode.
            This is a hack to work around slirp deficiencies anyway.  */
-        return 1;
+        return true;
     }
=20
     avail =3D MOD2(s->RxBufferSize + s->RxBufPtr - s->RxBufAddr,
diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
index 02be60c..b3240b9 100644
--- a/hw/net/smc91c111.c
+++ b/hw/net/smc91c111.c
@@ -667,7 +667,7 @@ static void smc91c111_writefn(void *opaque, hwaddr addr=
,
     }
 }
=20
-static int smc91c111_can_receive_nc(NetClientState *nc)
+static bool smc91c111_can_receive_nc(NetClientState *nc)
 {
     smc91c111_state *s =3D qemu_get_nic_opaque(nc);
=20
diff --git a/hw/net/spapr_llan.c b/hw/net/spapr_llan.c
index 80f5a1d..a237702 100644
--- a/hw/net/spapr_llan.c
+++ b/hw/net/spapr_llan.c
@@ -110,11 +110,11 @@ typedef struct SpaprVioVlan {
     RxBufPool *rx_pool[RX_MAX_POOLS];  /* Receive buffer descriptor pools =
*/
 } SpaprVioVlan;
=20
-static int spapr_vlan_can_receive(NetClientState *nc)
+static bool spapr_vlan_can_receive(NetClientState *nc)
 {
     SpaprVioVlan *dev =3D qemu_get_nic_opaque(nc);
=20
-    return (dev->isopen && dev->rx_bufs > 0);
+    return dev->isopen && dev->rx_bufs > 0;
 }
=20
 /**
diff --git a/hw/net/sungem.c b/hw/net/sungem.c
index 89da51f..b01197d 100644
--- a/hw/net/sungem.c
+++ b/hw/net/sungem.c
@@ -433,7 +433,7 @@ static bool sungem_rx_full(SunGEMState *s, uint32_t kic=
k, uint32_t done)
     return kick =3D=3D ((done + 1) & s->rx_mask);
 }
=20
-static int sungem_can_receive(NetClientState *nc)
+static bool sungem_can_receive(NetClientState *nc)
 {
     SunGEMState *s =3D qemu_get_nic_opaque(nc);
     uint32_t kick, done, rxdma_cfg, rxmac_cfg;
@@ -445,11 +445,11 @@ static int sungem_can_receive(NetClientState *nc)
     /* If MAC disabled, can't receive */
     if ((rxmac_cfg & MAC_RXCFG_ENAB) =3D=3D 0) {
         trace_sungem_rx_mac_disabled();
-        return 0;
+        return false;
     }
     if ((rxdma_cfg & RXDMA_CFG_ENABLE) =3D=3D 0) {
         trace_sungem_rx_txdma_disabled();
-        return 0;
+        return false;
     }
=20
     /* Check RX availability */
diff --git a/hw/net/sunhme.c b/hw/net/sunhme.c
index 8863601..9c38583 100644
--- a/hw/net/sunhme.c
+++ b/hw/net/sunhme.c
@@ -657,11 +657,11 @@ static void sunhme_transmit(SunHMEState *s)
     sunhme_update_irq(s);
 }
=20
-static int sunhme_can_receive(NetClientState *nc)
+static bool sunhme_can_receive(NetClientState *nc)
 {
     SunHMEState *s =3D qemu_get_nic_opaque(nc);
=20
-    return s->macregs[HME_MACI_RXCFG >> 2] & HME_MAC_RXCFG_ENABLE;
+    return !!(s->macregs[HME_MACI_RXCFG >> 2] & HME_MAC_RXCFG_ENABLE);
 }
=20
 static void sunhme_link_status_changed(NetClientState *nc)
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 3627bb1..a46e3b3 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1234,26 +1234,26 @@ static void virtio_net_handle_rx(VirtIODevice *vdev=
, VirtQueue *vq)
     qemu_flush_queued_packets(qemu_get_subqueue(n->nic, queue_index));
 }
=20
-static int virtio_net_can_receive(NetClientState *nc)
+static bool virtio_net_can_receive(NetClientState *nc)
 {
     VirtIONet *n =3D qemu_get_nic_opaque(nc);
     VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
     VirtIONetQueue *q =3D virtio_net_get_subqueue(nc);
=20
     if (!vdev->vm_running) {
-        return 0;
+        return false;
     }
=20
     if (nc->queue_index >=3D n->curr_queues) {
-        return 0;
+        return false;
     }
=20
     if (!virtio_queue_ready(q->rx_vq) ||
         !(vdev->status & VIRTIO_CONFIG_S_DRIVER_OK)) {
-        return 0;
+        return false;
     }
=20
-    return 1;
+    return true;
 }
=20
 static int virtio_net_has_buffers(VirtIONetQueue *q, int bufsize)
diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index cf07e69..71d16fe 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -175,7 +175,7 @@ static const MemoryRegionOps eth_ops =3D {
     }
 };
=20
-static int eth_can_rx(NetClientState *nc)
+static bool eth_can_rx(NetClientState *nc)
 {
     struct xlx_ethlite *s =3D qemu_get_nic_opaque(nc);
     unsigned int rxbase =3D s->rxbuf * (0x800 / 4);
diff --git a/include/net/net.h b/include/net/net.h
index 094e966..39085d9 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -42,7 +42,7 @@ typedef struct NICConf {
 /* Net clients */
=20
 typedef void (NetPoll)(NetClientState *, bool enable);
-typedef int (NetCanReceive)(NetClientState *);
+typedef bool (NetCanReceive)(NetClientState *);
 typedef ssize_t (NetReceive)(NetClientState *, const uint8_t *, size_t);
 typedef ssize_t (NetReceiveIOV)(NetClientState *, const struct iovec *, in=
t);
 typedef void (NetCleanup) (NetClientState *);
diff --git a/net/filter-buffer.c b/net/filter-buffer.c
index 88da78f..12e0254 100644
--- a/net/filter-buffer.c
+++ b/net/filter-buffer.c
@@ -74,7 +74,7 @@ static ssize_t filter_buffer_receive_iov(NetFilterState *=
nf,
      * the filter can still accept packets until its internal queue is ful=
l.
      * For example:
      *   For some reason, receiver could not receive more packets
-     * (.can_receive() returns zero). Without a filter, at most one packet
+     * (.can_receive() returns false). Without a filter, at most one packe=
t
      * will be queued in incoming queue and sender's poll will be disabled
      * unit its sent_cb() was called. With a filter, it will keep receivin=
g
      * the packets without caring about the receiver. This is suboptimal.
diff --git a/net/hub.c b/net/hub.c
index 88cfb87..1375738 100644
--- a/net/hub.c
+++ b/net/hub.c
@@ -90,7 +90,7 @@ static NetHub *net_hub_new(int id)
     return hub;
 }
=20
-static int net_hub_port_can_receive(NetClientState *nc)
+static bool net_hub_port_can_receive(NetClientState *nc)
 {
     NetHubPort *port;
     NetHubPort *src_port =3D DO_UPCAST(NetHubPort, nc, nc);
@@ -102,11 +102,11 @@ static int net_hub_port_can_receive(NetClientState *n=
c)
         }
=20
         if (qemu_can_send_packet(&port->nc)) {
-            return 1;
+            return true;
         }
     }
=20
-    return 0;
+    return false;
 }
=20
 static ssize_t net_hub_port_receive(NetClientState *nc,
--=20
2.5.0


