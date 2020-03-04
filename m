Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EC3C3F2CD
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 13:10:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0466D20838
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 13:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="OOsV/a4j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0466D20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9Tmj-0007Hs-4k
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 08:10:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37379)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lekiravi@yandex-team.ru>) id 1j9Tkb-0003B8-7u
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 08:07:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lekiravi@yandex-team.ru>) id 1j9TkW-0001n7-Ny
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 08:07:49 -0500
Received: from forwardcorp1o.mail.yandex.net ([2a02:6b8:0:1a2d::193]:43706)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lekiravi@yandex-team.ru>)
 id 1j9TkP-0001UW-1u; Wed, 04 Mar 2020 08:07:37 -0500
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net
 [IPv6:2a02:6b8:0:1a2d::301])
 by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id B6DE92E1764;
 Wed,  4 Mar 2020 16:07:35 +0300 (MSK)
Received: from sas1-9998cec34266.qloud-c.yandex.net
 (sas1-9998cec34266.qloud-c.yandex.net [2a02:6b8:c14:3a0e:0:640:9998:cec3])
 by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 Gfkc1GFItu-7SaiCmmE; Wed, 04 Mar 2020 16:07:35 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1583327255; bh=nlxUiX0vPzTyUjbVc3grdclin00oPgm2S/Tp+BITx2w=;
 h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
 b=OOsV/a4j175NykMjjUVdUCu/5E0pLhN7XJaXC2wCwFNIEzJV9AfrVT+jCWcKMMexL
 qjjfOoetQbMg33IOQRGqDSYKQhcjK2NxA35ybSeTiUyq9L5fEnk5H6vvWFhaQuB0KP
 bCefIHXhVH5euwuqMECnR3gmYZfPGOTOb7uS00IU=
Authentication-Results: mxbackcorp1o.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net
 [2a02:6b8:0:40c:b4f7:3f29:4fea:8822])
 by sas1-9998cec34266.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 ujb0Gsh6CR-7RWOip7E; Wed, 04 Mar 2020 16:07:27 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
From: Alexey Kirillov <lekiravi@yandex-team.ru>
To: Eric Blake <eblake@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 4/4] net: Remove field info_str of NetClientState
Date: Wed,  4 Mar 2020 16:06:56 +0300
Message-Id: <20200304130656.16859-5-lekiravi@yandex-team.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200304130656.16859-1-lekiravi@yandex-team.ru>
References: <20200304130656.16859-1-lekiravi@yandex-team.ru>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a02:6b8:0:1a2d::193
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Vincenzo Maffione <v.maffione@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Sven Schnelle <svens@stackframe.org>, Rob Herring <robh@kernel.org>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Joel Stanley <joel@jms.id.au>, Anthony Perard <anthony.perard@citrix.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Laurent Vivier <lvivier@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 yc-core@yandex-team.ru, Stefan Weil <sw@weilnetz.de>,
 Alistair Francis <alistair@alistair23.me>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 xen-devel@lists.xenproject.org, Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Luigi Rizzo <rizzo@iet.unipi.it>, Richard Henderson <rth@twiddle.net>,
 Andrew Jeffery <andrew@aj.id.au>, Michael Walle <michael@walle.cc>,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Alexey Kirillov <lekiravi@yandex-team.ru>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Completely remove the info_str field of struct NetClientState because
it is no longer required due to the addition of the QMP query-netdevs command.

Signed-off-by: Alexey Kirillov <lekiravi@yandex-team.ru>
---
 hw/net/allwinner_emac.c     |  2 +-
 hw/net/dp8393x.c            |  2 +-
 hw/net/e1000.c              |  4 ++--
 hw/net/e1000e.c             |  2 +-
 hw/net/e1000e_core.c        |  2 +-
 hw/net/e1000x_common.c      |  2 +-
 hw/net/eepro100.c           |  5 +++--
 hw/net/etraxfs_eth.c        |  2 +-
 hw/net/fsl_etsec/etsec.c    |  2 +-
 hw/net/ftgmac100.c          |  2 +-
 hw/net/i82596.c             |  6 +++---
 hw/net/imx_fec.c            |  2 +-
 hw/net/lan9118.c            |  4 ++--
 hw/net/mcf_fec.c            |  2 +-
 hw/net/milkymist-minimac2.c |  2 +-
 hw/net/mipsnet.c            |  2 +-
 hw/net/ne2000-isa.c         |  2 +-
 hw/net/ne2000-pci.c         |  2 +-
 hw/net/pcnet.c              |  2 +-
 hw/net/rocker/rocker_fp.c   |  4 ++--
 hw/net/rtl8139.c            |  6 +++---
 hw/net/smc91c111.c          |  2 +-
 hw/net/spapr_llan.c         |  6 +++---
 hw/net/stellaris_enet.c     |  2 +-
 hw/net/sungem.c             |  4 ++--
 hw/net/sunhme.c             |  2 +-
 hw/net/tulip.c              |  2 +-
 hw/net/virtio-net.c         |  8 ++++----
 hw/net/vmxnet3.c            |  4 ++--
 hw/net/xen_nic.c            |  4 ----
 hw/net/xgmac.c              |  2 +-
 hw/net/xilinx_axienet.c     |  2 +-
 hw/net/xilinx_ethlite.c     |  2 +-
 hw/usb/dev-network.c        |  2 +-
 include/net/net.h           |  3 +--
 net/l2tpv3.c                |  3 ---
 net/net.c                   |  8 +-------
 net/slirp.c                 |  4 ----
 net/socket.c                | 24 ------------------------
 net/tap.c                   | 12 ------------
 net/vde.c                   |  4 ----
 net/vhost-user.c            |  2 --
 42 files changed, 51 insertions(+), 110 deletions(-)

diff --git a/hw/net/allwinner_emac.c b/hw/net/allwinner_emac.c
index e9bbff8710..6abbdbfd4b 100644
--- a/hw/net/allwinner_emac.c
+++ b/hw/net/allwinner_emac.c
@@ -454,7 +454,7 @@ static void aw_emac_realize(DeviceState *dev, Error **errp)
     qemu_macaddr_default_if_unset(&s->conf.macaddr);
     s->nic = qemu_new_nic(&net_aw_emac_info, &s->conf,
                           object_get_typename(OBJECT(dev)), dev->id, s);
-    qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
+    qemu_update_nic_macaddr(qemu_get_queue(s->nic), s->conf.macaddr.a);
 
     fifo8_create(&s->rx_fifo, RX_FIFO_SIZE);
     fifo8_create(&s->tx_fifo[0], TX_FIFO_SIZE);
diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index 8a3504d962..a6f95b097b 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -982,7 +982,7 @@ static void dp8393x_realize(DeviceState *dev, Error **errp)
 
     s->nic = qemu_new_nic(&net_dp83932_info, &s->conf,
                           object_get_typename(OBJECT(dev)), dev->id, s);
-    qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
+    qemu_update_nic_macaddr(qemu_get_queue(s->nic), s->conf.macaddr.a);
 
     s->watchdog = timer_new_ns(QEMU_CLOCK_VIRTUAL, dp8393x_watchdog, s);
 
diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index 0b833d5a15..5ae52e37ea 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -1095,7 +1095,7 @@ mac_writereg(E1000State *s, int index, uint32_t val)
     if (index == RA + 1) {
         macaddr[0] = cpu_to_le32(s->mac_reg[RA]);
         macaddr[1] = cpu_to_le32(s->mac_reg[RA + 1]);
-        qemu_format_nic_info_str(qemu_get_queue(s->nic), (uint8_t *)macaddr);
+        qemu_update_nic_macaddr(qemu_get_queue(s->nic), (uint8_t *)macaddr);
     }
 }
 
@@ -1711,7 +1711,7 @@ static void pci_e1000_realize(PCIDevice *pci_dev, Error **errp)
     d->nic = qemu_new_nic(&net_e1000_info, &d->conf,
                           object_get_typename(OBJECT(d)), dev->id, d);
 
-    qemu_format_nic_info_str(qemu_get_queue(d->nic), macaddr);
+    qemu_update_nic_macaddr(qemu_get_queue(d->nic), macaddr);
 
     d->autoneg_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL, e1000_autoneg_timer, d);
     d->mit_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, e1000_mit_timer, d);
diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index a91dbdca3c..763661227d 100644
--- a/hw/net/e1000e.c
+++ b/hw/net/e1000e.c
@@ -333,7 +333,7 @@ e1000e_init_net_peer(E1000EState *s, PCIDevice *pci_dev, uint8_t *macaddr)
     trace_e1000e_mac_set_permanent(MAC_ARG(macaddr));
     memcpy(s->core.permanent_mac, macaddr, sizeof(s->core.permanent_mac));
 
-    qemu_format_nic_info_str(qemu_get_queue(s->nic), macaddr);
+    qemu_update_nic_macaddr(qemu_get_queue(s->nic), macaddr);
 
     /* Setup virtio headers */
     if (s->disable_vnet) {
diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 94ea34dca5..358e90b40d 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -2731,7 +2731,7 @@ e1000e_mac_setmacaddr(E1000ECore *core, int index, uint32_t val)
 
     macaddr[0] = cpu_to_le32(core->mac[RA]);
     macaddr[1] = cpu_to_le32(core->mac[RA + 1]);
-    qemu_format_nic_info_str(qemu_get_queue(core->owner_nic),
+    qemu_update_nic_macaddr(qemu_get_queue(core->owner_nic),
         (uint8_t *) macaddr);
 
     trace_e1000e_mac_set_sw(MAC_ARG(macaddr));
diff --git a/hw/net/e1000x_common.c b/hw/net/e1000x_common.c
index 717f9df1c9..ad66dd3d55 100644
--- a/hw/net/e1000x_common.c
+++ b/hw/net/e1000x_common.c
@@ -145,7 +145,7 @@ void e1000x_reset_mac_addr(NICState *nic, uint32_t *mac_regs,
             (i < 2) ? mac_addr[i + 4] << (8 * i) : 0;
     }
 
-    qemu_format_nic_info_str(qemu_get_queue(nic), mac_addr);
+    qemu_update_nic_macaddr(qemu_get_queue(nic), mac_addr);
     trace_e1000x_mac_indicate(MAC_ARG(mac_addr));
 }
 
diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
index f6474f0e68..31cb5c007f 100644
--- a/hw/net/eepro100.c
+++ b/hw/net/eepro100.c
@@ -1867,8 +1867,9 @@ static void e100_nic_realize(PCIDevice *pci_dev, Error **errp)
     s->nic = qemu_new_nic(&net_eepro100_info, &s->conf,
                           object_get_typename(OBJECT(pci_dev)), pci_dev->qdev.id, s);
 
-    qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
-    TRACE(OTHER, logout("%s\n", qemu_get_queue(s->nic)->info_str));
+    qemu_update_nic_macaddr(qemu_get_queue(s->nic), s->conf.macaddr.a);
+    TRACE(OTHER, logout("macaddr=%s\n",
+                        qemu_get_queue(s->nic)->stored_config->u.nic.macaddr));
 
     qemu_register_reset(nic_reset, s);
 
diff --git a/hw/net/etraxfs_eth.c b/hw/net/etraxfs_eth.c
index 27fd069b96..dccdcb9e67 100644
--- a/hw/net/etraxfs_eth.c
+++ b/hw/net/etraxfs_eth.c
@@ -620,7 +620,7 @@ static void etraxfs_eth_realize(DeviceState *dev, Error **errp)
     qemu_macaddr_default_if_unset(&s->conf.macaddr);
     s->nic = qemu_new_nic(&net_etraxfs_info, &s->conf,
                           object_get_typename(OBJECT(s)), dev->id, s);
-    qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
+    qemu_update_nic_macaddr(qemu_get_queue(s->nic), s->conf.macaddr.a);
 
     s->phy.read = tdk_read;
     s->phy.write = tdk_write;
diff --git a/hw/net/fsl_etsec/etsec.c b/hw/net/fsl_etsec/etsec.c
index 475f3c887a..1de9c2fff3 100644
--- a/hw/net/fsl_etsec/etsec.c
+++ b/hw/net/fsl_etsec/etsec.c
@@ -390,7 +390,7 @@ static void etsec_realize(DeviceState *dev, Error **errp)
 
     etsec->nic = qemu_new_nic(&net_etsec_info, &etsec->conf,
                               object_get_typename(OBJECT(dev)), dev->id, etsec);
-    qemu_format_nic_info_str(qemu_get_queue(etsec->nic), etsec->conf.macaddr.a);
+    qemu_update_nic_macaddr(qemu_get_queue(etsec->nic), etsec->conf.macaddr.a);
 
     etsec->ptimer = ptimer_init(etsec_timer_hit, etsec, PTIMER_POLICY_DEFAULT);
     ptimer_transaction_begin(etsec->ptimer);
diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index 2f92b65d4e..14286cac81 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -1037,7 +1037,7 @@ static void ftgmac100_realize(DeviceState *dev, Error **errp)
     s->nic = qemu_new_nic(&net_ftgmac100_info, &s->conf,
                           object_get_typename(OBJECT(dev)), DEVICE(dev)->id,
                           s);
-    qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
+    qemu_update_nic_macaddr(qemu_get_queue(s->nic), s->conf.macaddr.a);
 }
 
 static const VMStateDescription vmstate_ftgmac100 = {
diff --git a/hw/net/i82596.c b/hw/net/i82596.c
index fe9f2390a9..3d62720920 100644
--- a/hw/net/i82596.c
+++ b/hw/net/i82596.c
@@ -174,8 +174,8 @@ static void set_individual_address(I82596State *s, uint32_t addr)
     m = s->conf.macaddr.a;
     address_space_read(&address_space_memory, addr + 8,
                        MEMTXATTRS_UNSPECIFIED, m, ETH_ALEN);
-    qemu_format_nic_info_str(nc, m);
-    trace_i82596_new_mac(nc->info_str);
+    qemu_update_nic_macaddr(nc, m);
+    trace_i82596_new_mac(nc->stored_config->u.nic.macaddr);
 }
 
 static void set_multicast_list(I82596State *s, uint32_t addr)
@@ -723,7 +723,7 @@ void i82596_common_init(DeviceState *dev, I82596State *s, NetClientInfo *info)
     }
     s->nic = qemu_new_nic(info, &s->conf, object_get_typename(OBJECT(dev)),
                 dev->id, s);
-    qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
+    qemu_update_nic_macaddr(qemu_get_queue(s->nic), s->conf.macaddr.a);
 
     if (USE_TIMER) {
         s->flush_queue_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index 6a124a154a..e8047ec42e 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -1323,7 +1323,7 @@ static void imx_eth_realize(DeviceState *dev, Error **errp)
                           object_get_typename(OBJECT(dev)),
                           DEVICE(dev)->id, s);
 
-    qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
+    qemu_update_nic_macaddr(qemu_get_queue(s->nic), s->conf.macaddr.a);
 }
 
 static Property imx_eth_properties[] = {
diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index da7e0bb0e8..0c1bc0f0eb 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -353,7 +353,7 @@ static void lan9118_update(lan9118_state *s)
 
 static void lan9118_mac_changed(lan9118_state *s)
 {
-    qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
+    qemu_update_nic_macaddr(qemu_get_queue(s->nic), s->conf.macaddr.a);
 }
 
 static void lan9118_reload_eeprom(lan9118_state *s)
@@ -1343,7 +1343,7 @@ static void lan9118_realize(DeviceState *dev, Error **errp)
 
     s->nic = qemu_new_nic(&net_lan9118_info, &s->conf,
                           object_get_typename(OBJECT(dev)), dev->id, s);
-    qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
+    qemu_update_nic_macaddr(qemu_get_queue(s->nic), s->conf.macaddr.a);
     s->eeprom[0] = 0xa5;
     for (i = 0; i < 6; i++) {
         s->eeprom[i + 1] = s->conf.macaddr.a[i];
diff --git a/hw/net/mcf_fec.c b/hw/net/mcf_fec.c
index 9327ac8a30..5690a48829 100644
--- a/hw/net/mcf_fec.c
+++ b/hw/net/mcf_fec.c
@@ -641,7 +641,7 @@ static void mcf_fec_realize(DeviceState *dev, Error **errp)
 
     s->nic = qemu_new_nic(&net_mcf_fec_info, &s->conf,
                           object_get_typename(OBJECT(dev)), dev->id, s);
-    qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
+    qemu_update_nic_macaddr(qemu_get_queue(s->nic), s->conf.macaddr.a);
 }
 
 static void mcf_fec_instance_init(Object *obj)
diff --git a/hw/net/milkymist-minimac2.c b/hw/net/milkymist-minimac2.c
index 1ba01754ee..1852ec124e 100644
--- a/hw/net/milkymist-minimac2.c
+++ b/hw/net/milkymist-minimac2.c
@@ -485,7 +485,7 @@ static void milkymist_minimac2_realize(DeviceState *dev, Error **errp)
     qemu_macaddr_default_if_unset(&s->conf.macaddr);
     s->nic = qemu_new_nic(&net_milkymist_minimac2_info, &s->conf,
                           object_get_typename(OBJECT(dev)), dev->id, s);
-    qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
+    qemu_update_nic_macaddr(qemu_get_queue(s->nic), s->conf.macaddr.a);
 }
 
 static const VMStateDescription vmstate_milkymist_minimac2_mdio = {
diff --git a/hw/net/mipsnet.c b/hw/net/mipsnet.c
index 0c578c430c..ca2649d4d2 100644
--- a/hw/net/mipsnet.c
+++ b/hw/net/mipsnet.c
@@ -255,7 +255,7 @@ static void mipsnet_realize(DeviceState *dev, Error **errp)
 
     s->nic = qemu_new_nic(&net_mipsnet_info, &s->conf,
                           object_get_typename(OBJECT(dev)), dev->id, s);
-    qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
+    qemu_update_nic_macaddr(qemu_get_queue(s->nic), s->conf.macaddr.a);
 }
 
 static void mipsnet_sysbus_reset(DeviceState *dev)
diff --git a/hw/net/ne2000-isa.c b/hw/net/ne2000-isa.c
index e744eff153..f4d7791271 100644
--- a/hw/net/ne2000-isa.c
+++ b/hw/net/ne2000-isa.c
@@ -74,7 +74,7 @@ static void isa_ne2000_realizefn(DeviceState *dev, Error **errp)
 
     s->nic = qemu_new_nic(&net_ne2000_isa_info, &s->c,
                           object_get_typename(OBJECT(dev)), dev->id, s);
-    qemu_format_nic_info_str(qemu_get_queue(s->nic), s->c.macaddr.a);
+    qemu_update_nic_macaddr(qemu_get_queue(s->nic), s->c.macaddr.a);
 }
 
 static Property ne2000_isa_properties[] = {
diff --git a/hw/net/ne2000-pci.c b/hw/net/ne2000-pci.c
index e11d67bf75..e8690f47e2 100644
--- a/hw/net/ne2000-pci.c
+++ b/hw/net/ne2000-pci.c
@@ -72,7 +72,7 @@ static void pci_ne2000_realize(PCIDevice *pci_dev, Error **errp)
     s->nic = qemu_new_nic(&net_ne2000_info, &s->c,
                           object_get_typename(OBJECT(pci_dev)),
                           pci_dev->qdev.id, s);
-    qemu_format_nic_info_str(qemu_get_queue(s->nic), s->c.macaddr.a);
+    qemu_update_nic_macaddr(qemu_get_queue(s->nic), s->c.macaddr.a);
 }
 
 static void pci_ne2000_exit(PCIDevice *pci_dev)
diff --git a/hw/net/pcnet.c b/hw/net/pcnet.c
index f3f18d8598..ecb1fcb332 100644
--- a/hw/net/pcnet.c
+++ b/hw/net/pcnet.c
@@ -1719,7 +1719,7 @@ void pcnet_common_init(DeviceState *dev, PCNetState *s, NetClientInfo *info)
 
     qemu_macaddr_default_if_unset(&s->conf.macaddr);
     s->nic = qemu_new_nic(info, &s->conf, object_get_typename(OBJECT(dev)), dev->id, s);
-    qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
+    qemu_update_nic_macaddr(qemu_get_queue(s->nic), s->conf.macaddr.a);
 
     /* Initialize the PROM */
 
diff --git a/hw/net/rocker/rocker_fp.c b/hw/net/rocker/rocker_fp.c
index 4aa7da79b8..ddb2191949 100644
--- a/hw/net/rocker/rocker_fp.c
+++ b/hw/net/rocker/rocker_fp.c
@@ -240,8 +240,8 @@ FpPort *fp_port_alloc(Rocker *r, char *sw_name,
 
     port->nic = qemu_new_nic(&fp_port_info, &port->conf,
                              sw_name, NULL, port);
-    qemu_format_nic_info_str(qemu_get_queue(port->nic),
-                             port->conf.macaddr.a);
+    qemu_update_nic_macaddr(qemu_get_queue(port->nic),
+                            port->conf.macaddr.a);
 
     fp_port_reset(port);
 
diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index ae4739bc09..a3f42ea567 100644
--- a/hw/net/rtl8139.c
+++ b/hw/net/rtl8139.c
@@ -1227,7 +1227,7 @@ static void rtl8139_reset(DeviceState *d)
 
     /* restore MAC address */
     memcpy(s->phys, s->conf.macaddr.a, 6);
-    qemu_format_nic_info_str(qemu_get_queue(s->nic), s->phys);
+    qemu_update_nic_macaddr(qemu_get_queue(s->nic), s->phys);
 
     /* reset interrupt mask */
     s->IntrStatus = 0;
@@ -2676,7 +2676,7 @@ static void rtl8139_io_writeb(void *opaque, uint8_t addr, uint32_t val)
             break;
         case MAC0+5:
             s->phys[addr - MAC0] = val;
-            qemu_format_nic_info_str(qemu_get_queue(s->nic), s->phys);
+            qemu_update_nic_macaddr(qemu_get_queue(s->nic), s->phys);
             break;
         case MAC0+6 ... MAC0+7:
             /* reserved */
@@ -3398,7 +3398,7 @@ static void pci_rtl8139_realize(PCIDevice *dev, Error **errp)
 
     s->nic = qemu_new_nic(&net_rtl8139_info, &s->conf,
                           object_get_typename(OBJECT(dev)), d->id, s);
-    qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
+    qemu_update_nic_macaddr(qemu_get_queue(s->nic), s->conf.macaddr.a);
 
     s->cplus_txbuffer = NULL;
     s->cplus_txbuffer_len = 0;
diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
index e9eb6f6c05..f23746dc33 100644
--- a/hw/net/smc91c111.c
+++ b/hw/net/smc91c111.c
@@ -782,7 +782,7 @@ static void smc91c111_realize(DeviceState *dev, Error **errp)
     qemu_macaddr_default_if_unset(&s->conf.macaddr);
     s->nic = qemu_new_nic(&net_smc91c111_info, &s->conf,
                           object_get_typename(OBJECT(dev)), dev->id, s);
-    qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
+    qemu_update_nic_macaddr(qemu_get_queue(s->nic), s->conf.macaddr.a);
     /* ??? Save/restore.  */
 }
 
diff --git a/hw/net/spapr_llan.c b/hw/net/spapr_llan.c
index 80f5a1dd37..26b11a21a9 100644
--- a/hw/net/spapr_llan.c
+++ b/hw/net/spapr_llan.c
@@ -314,7 +314,7 @@ static void spapr_vlan_reset(SpaprVioDevice *sdev)
 
     memcpy(&dev->nicconf.macaddr.a, &dev->perm_mac.a,
            sizeof(dev->nicconf.macaddr.a));
-    qemu_format_nic_info_str(qemu_get_queue(dev->nic), dev->nicconf.macaddr.a);
+    qemu_update_nic_macaddr(qemu_get_queue(dev->nic), dev->nicconf.macaddr.a);
 }
 
 static void spapr_vlan_realize(SpaprVioDevice *sdev, Error **errp)
@@ -327,7 +327,7 @@ static void spapr_vlan_realize(SpaprVioDevice *sdev, Error **errp)
 
     dev->nic = qemu_new_nic(&net_spapr_vlan_info, &dev->nicconf,
                             object_get_typename(OBJECT(sdev)), sdev->qdev.id, dev);
-    qemu_format_nic_info_str(qemu_get_queue(dev->nic), dev->nicconf.macaddr.a);
+    qemu_update_nic_macaddr(qemu_get_queue(dev->nic), dev->nicconf.macaddr.a);
 
     dev->rxp_timer = timer_new_us(QEMU_CLOCK_VIRTUAL, spapr_vlan_flush_rx_queue,
                                   dev);
@@ -775,7 +775,7 @@ static target_ulong h_change_logical_lan_mac(PowerPCCPU *cpu,
         macaddr >>= 8;
     }
 
-    qemu_format_nic_info_str(qemu_get_queue(dev->nic), dev->nicconf.macaddr.a);
+    qemu_update_nic_macaddr(qemu_get_queue(dev->nic), dev->nicconf.macaddr.a);
 
     return H_SUCCESS;
 }
diff --git a/hw/net/stellaris_enet.c b/hw/net/stellaris_enet.c
index cb6e2509ea..aec99bc214 100644
--- a/hw/net/stellaris_enet.c
+++ b/hw/net/stellaris_enet.c
@@ -493,7 +493,7 @@ static void stellaris_enet_realize(DeviceState *dev, Error **errp)
 
     s->nic = qemu_new_nic(&net_stellaris_enet_info, &s->conf,
                           object_get_typename(OBJECT(dev)), dev->id, s);
-    qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
+    qemu_update_nic_macaddr(qemu_get_queue(s->nic), s->conf.macaddr.a);
 }
 
 static Property stellaris_enet_properties[] = {
diff --git a/hw/net/sungem.c b/hw/net/sungem.c
index 89da51f7f6..b3f49b23ae 100644
--- a/hw/net/sungem.c
+++ b/hw/net/sungem.c
@@ -1361,8 +1361,8 @@ static void sungem_realize(PCIDevice *pci_dev, Error **errp)
     s->nic = qemu_new_nic(&net_sungem_info, &s->conf,
                           object_get_typename(OBJECT(dev)),
                           dev->id, s);
-    qemu_format_nic_info_str(qemu_get_queue(s->nic),
-                             s->conf.macaddr.a);
+    qemu_update_nic_macaddr(qemu_get_queue(s->nic),
+                            s->conf.macaddr.a);
 }
 
 static void sungem_reset(DeviceState *dev)
diff --git a/hw/net/sunhme.c b/hw/net/sunhme.c
index 8863601f6c..2ff2ef1162 100644
--- a/hw/net/sunhme.c
+++ b/hw/net/sunhme.c
@@ -892,7 +892,7 @@ static void sunhme_realize(PCIDevice *pci_dev, Error **errp)
     qemu_macaddr_default_if_unset(&s->conf.macaddr);
     s->nic = qemu_new_nic(&net_sunhme_info, &s->conf,
                           object_get_typename(OBJECT(d)), d->id, s);
-    qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
+    qemu_update_nic_macaddr(qemu_get_queue(s->nic), s->conf.macaddr.a);
 }
 
 static void sunhme_instance_init(Object *obj)
diff --git a/hw/net/tulip.c b/hw/net/tulip.c
index cfac2719d3..36ff10c593 100644
--- a/hw/net/tulip.c
+++ b/hw/net/tulip.c
@@ -964,7 +964,7 @@ static void pci_tulip_realize(PCIDevice *pci_dev, Error **errp)
     s->nic = qemu_new_nic(&net_tulip_info, &s->c,
                           object_get_typename(OBJECT(pci_dev)),
                           pci_dev->qdev.id, s);
-    qemu_format_nic_info_str(qemu_get_queue(s->nic), s->c.macaddr.a);
+    qemu_update_nic_macaddr(qemu_get_queue(s->nic), s->c.macaddr.a);
 }
 
 static void pci_tulip_exit(PCIDevice *pci_dev)
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 3627bb1717..ea1992bc84 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -152,7 +152,7 @@ static void virtio_net_set_config(VirtIODevice *vdev, const uint8_t *config)
         !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1) &&
         memcmp(netcfg.mac, n->mac, ETH_ALEN)) {
         memcpy(n->mac, netcfg.mac, ETH_ALEN);
-        qemu_format_nic_info_str(qemu_get_queue(n->nic), n->mac);
+        qemu_update_nic_macaddr(qemu_get_queue(n->nic), n->mac);
     }
 }
 
@@ -521,7 +521,7 @@ static void virtio_net_reset(VirtIODevice *vdev)
     n->mac_table.uni_overflow = 0;
     memset(n->mac_table.macs, 0, MAC_TABLE_ENTRIES * ETH_ALEN);
     memcpy(&n->mac[0], &n->nic->conf->macaddr, sizeof(n->mac));
-    qemu_format_nic_info_str(qemu_get_queue(n->nic), n->mac);
+    qemu_update_nic_macaddr(qemu_get_queue(n->nic), n->mac);
     memset(n->vlans, 0, MAX_VLAN >> 3);
 
     /* Flush any async TX */
@@ -1009,7 +1009,7 @@ static int virtio_net_handle_mac(VirtIONet *n, uint8_t cmd,
         }
         s = iov_to_buf(iov, iov_cnt, 0, &n->mac, sizeof(n->mac));
         assert(s == sizeof(n->mac));
-        qemu_format_nic_info_str(qemu_get_queue(n->nic), n->mac);
+        qemu_update_nic_macaddr(qemu_get_queue(n->nic), n->mac);
         rxfilter_notify(nc);
 
         return VIRTIO_NET_OK;
@@ -3056,7 +3056,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
         n->host_hdr_len = 0;
     }
 
-    qemu_format_nic_info_str(qemu_get_queue(n->nic), n->nic_conf.macaddr.a);
+    qemu_update_nic_macaddr(qemu_get_queue(n->nic), n->nic_conf.macaddr.a);
 
     n->vqs[0].tx_waiting = 0;
     n->tx_burst = n->net_conf.txburst;
diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 6d91cd8309..3c337739d0 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -366,7 +366,7 @@ static void vmxnet3_set_variable_mac(VMXNET3State *s, uint32_t h, uint32_t l)
 
     VMW_CFPRN("Variable MAC: " MAC_FMT, MAC_ARG(s->conf.macaddr.a));
 
-    qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
+    qemu_update_nic_macaddr(qemu_get_queue(s->nic), s->conf.macaddr.a);
 }
 
 static uint64_t vmxnet3_get_mac_low(MACAddr *addr)
@@ -2069,7 +2069,7 @@ static void vmxnet3_net_init(VMXNET3State *s)
         qemu_using_vnet_hdr(qemu_get_queue(s->nic)->peer, 1);
     }
 
-    qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
+    qemu_update_nic_macaddr(qemu_get_queue(s->nic), s->conf.macaddr.a);
 }
 
 static void
diff --git a/hw/net/xen_nic.c b/hw/net/xen_nic.c
index 00a7fdf843..19476fc08c 100644
--- a/hw/net/xen_nic.c
+++ b/hw/net/xen_nic.c
@@ -296,10 +296,6 @@ static int net_init(struct XenLegacyDevice *xendev)
     netdev->nic = qemu_new_nic(&net_xen_info, &netdev->conf,
                                "xen", NULL, netdev);
 
-    snprintf(qemu_get_queue(netdev->nic)->info_str,
-             sizeof(qemu_get_queue(netdev->nic)->info_str),
-             "nic: xenbus vif macaddr=%s", netdev->mac);
-
     /* fill info */
     xenstore_write_be_int(&netdev->xendev, "feature-rx-copy", 1);
     xenstore_write_be_int(&netdev->xendev, "feature-rx-flip", 0);
diff --git a/hw/net/xgmac.c b/hw/net/xgmac.c
index 574dd47b41..f882026930 100644
--- a/hw/net/xgmac.c
+++ b/hw/net/xgmac.c
@@ -393,7 +393,7 @@ static void xgmac_enet_realize(DeviceState *dev, Error **errp)
     qemu_macaddr_default_if_unset(&s->conf.macaddr);
     s->nic = qemu_new_nic(&net_xgmac_enet_info, &s->conf,
                           object_get_typename(OBJECT(dev)), dev->id, s);
-    qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
+    qemu_update_nic_macaddr(qemu_get_queue(s->nic), s->conf.macaddr.a);
 
     s->regs[XGMAC_ADDR_HIGH(0)] = (s->conf.macaddr.a[5] << 8) |
                                    s->conf.macaddr.a[4];
diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
index 704788811a..73cc3f2aa8 100644
--- a/hw/net/xilinx_axienet.c
+++ b/hw/net/xilinx_axienet.c
@@ -975,7 +975,7 @@ static void xilinx_enet_realize(DeviceState *dev, Error **errp)
     qemu_macaddr_default_if_unset(&s->conf.macaddr);
     s->nic = qemu_new_nic(&net_xilinx_enet_info, &s->conf,
                           object_get_typename(OBJECT(dev)), dev->id, s);
-    qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
+    qemu_update_nic_macaddr(qemu_get_queue(s->nic), s->conf.macaddr.a);
 
     tdk_init(&s->TEMAC.phy);
     mdio_attach(&s->TEMAC.mdio_bus, &s->TEMAC.phy, s->c_phyaddr);
diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index cf07e698b3..37692f15e1 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -235,7 +235,7 @@ static void xilinx_ethlite_realize(DeviceState *dev, Error **errp)
     qemu_macaddr_default_if_unset(&s->conf.macaddr);
     s->nic = qemu_new_nic(&net_xilinx_ethlite_info, &s->conf,
                           object_get_typename(OBJECT(dev)), dev->id, s);
-    qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
+    qemu_update_nic_macaddr(qemu_get_queue(s->nic), s->conf.macaddr.a);
 }
 
 static void xilinx_ethlite_init(Object *obj)
diff --git a/hw/usb/dev-network.c b/hw/usb/dev-network.c
index 9a78ad928b..52e8e6989a 100644
--- a/hw/usb/dev-network.c
+++ b/hw/usb/dev-network.c
@@ -1362,7 +1362,7 @@ static void usb_net_realize(USBDevice *dev, Error **errp)
     qemu_macaddr_default_if_unset(&s->conf.macaddr);
     s->nic = qemu_new_nic(&net_usbnet_info, &s->conf,
                           object_get_typename(OBJECT(s)), s->dev.qdev.id, s);
-    qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
+    qemu_update_nic_macaddr(qemu_get_queue(s->nic), s->conf.macaddr.a);
     snprintf(s->usbstring_mac, sizeof(s->usbstring_mac),
              "%02x%02x%02x%02x%02x%02x",
              0x40,
diff --git a/include/net/net.h b/include/net/net.h
index 9df4680937..b4ca9112aa 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -91,7 +91,6 @@ struct NetClientState {
     NetQueue *incoming_queue;
     char *model;
     char *name;
-    char info_str[256];
     NetdevInfo *stored_config;
     unsigned receive_disabled : 1;
     NetClientDestructor *destructor;
@@ -155,7 +154,7 @@ ssize_t qemu_send_packet_async(NetClientState *nc, const uint8_t *buf,
 void qemu_purge_queued_packets(NetClientState *nc);
 void qemu_flush_queued_packets(NetClientState *nc);
 void qemu_flush_or_purge_queued_packets(NetClientState *nc, bool purge);
-void qemu_format_nic_info_str(NetClientState *nc, uint8_t macaddr[6]);
+void qemu_update_nic_macaddr(NetClientState *nc, uint8_t macaddr[6]);
 bool qemu_has_ufo(NetClientState *nc);
 bool qemu_has_vnet_hdr(NetClientState *nc);
 bool qemu_has_vnet_hdr_len(NetClientState *nc, int len);
diff --git a/net/l2tpv3.c b/net/l2tpv3.c
index f4e45e7b28..8dccdd625e 100644
--- a/net/l2tpv3.c
+++ b/net/l2tpv3.c
@@ -744,9 +744,6 @@ int net_init_l2tpv3(const Netdev *netdev,
     if (l2tpv3->has_dstport) {
         stored->dstport = g_strdup(l2tpv3->dstport);
     }
-
-    snprintf(s->nc.info_str, sizeof(s->nc.info_str),
-             "l2tpv3: connected");
     return 0;
 outerr:
     qemu_del_net_client(nc);
diff --git a/net/net.c b/net/net.c
index 1a8153dbf7..88755e5c1c 100644
--- a/net/net.c
+++ b/net/net.c
@@ -127,19 +127,13 @@ char *qemu_mac_strdup_printf(const uint8_t *macaddr)
                            macaddr[3], macaddr[4], macaddr[5]);
 }
 
-void qemu_format_nic_info_str(NetClientState *nc, uint8_t macaddr[6])
+void qemu_update_nic_macaddr(NetClientState *nc, uint8_t macaddr[6])
 {
     g_assert(nc->stored_config);
 
     g_free(nc->stored_config->u.nic.macaddr);
     nc->stored_config->u.nic.macaddr = g_strdup_printf(MAC_FMT,
                                                        MAC_ARG(macaddr));
-
-    snprintf(nc->info_str, sizeof(nc->info_str),
-             "model=%s,macaddr=%02x:%02x:%02x:%02x:%02x:%02x",
-             nc->model,
-             macaddr[0], macaddr[1], macaddr[2],
-             macaddr[3], macaddr[4], macaddr[5]);
 }
 
 static int mac_table[256] = {0};
diff --git a/net/slirp.c b/net/slirp.c
index fb5b87ebed..24a8877ddc 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -670,10 +670,6 @@ static int net_slirp_init(NetClientState *peer, const char *model,
         stored->tftp_server_name = g_strdup(tftp_server_name);
     }
 
-    snprintf(nc->info_str, sizeof(nc->info_str),
-             "net=%s,restrict=%s", inet_ntoa(net),
-             restricted ? "on" : "off");
-
     s = DO_UPCAST(SlirpState, nc, nc);
 
     s->slirp = slirp_init(restricted, ipv4, net, mask, host,
diff --git a/net/socket.c b/net/socket.c
index 2d2d5419ca..1f8801970c 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -180,7 +180,6 @@ static void net_socket_send(void *opaque)
         s->fd = -1;
         net_socket_rs_init(&s->rs, net_socket_rs_finalize, false);
         s->nc.link_down = true;
-        memset(s->nc.info_str, 0, sizeof(s->nc.info_str));
 
         return;
     }
@@ -400,16 +399,10 @@ static NetSocketState *net_socket_fd_init_dgram(NetClientState *peer,
         stored->mcast = g_strdup(mcast);
 
         s->dgram_dst = saddr;
-        snprintf(nc->info_str, sizeof(nc->info_str),
-                 "socket: fd=%d (cloned mcast=%s:%d)",
-                 fd, inet_ntoa(saddr.sin_addr), ntohs(saddr.sin_port));
     } else {
         if (sa_type == SOCKET_ADDRESS_TYPE_UNIX) {
             s->dgram_dst.sin_family = AF_UNIX;
         }
-
-        snprintf(nc->info_str, sizeof(nc->info_str),
-                 "socket: fd=%d %s", fd, SocketAddressType_str(sa_type));
     }
 
     return s;
@@ -443,9 +436,6 @@ static NetSocketState *net_socket_fd_init_stream(NetClientState *peer,
     NetdevSocketOptions *stored;
 
     nc = qemu_new_net_client(&net_socket_info, peer, model, name);
-
-    snprintf(nc->info_str, sizeof(nc->info_str), "socket: fd=%d", fd);
-
     s = DO_UPCAST(NetSocketState, nc, nc);
 
     s->fd = fd;
@@ -527,10 +517,6 @@ static void net_socket_accept(void *opaque)
 
     stored->has_fd = true;
     stored->fd = g_strdup_printf("%d", fd);
-
-    snprintf(s->nc.info_str, sizeof(s->nc.info_str),
-             "socket: connection from %s:%d",
-             inet_ntoa(saddr.sin_addr), ntohs(saddr.sin_port));
 }
 
 static int net_socket_listen_init(NetClientState *peer,
@@ -645,9 +631,6 @@ static int net_socket_connect_init(NetClientState *peer,
     stored->has_connect = true;
     stored->connect = g_strdup(host_str);
 
-    snprintf(s->nc.info_str, sizeof(s->nc.info_str),
-             "socket: connect to %s:%d",
-             inet_ntoa(saddr.sin_addr), ntohs(saddr.sin_port));
     return 0;
 }
 
@@ -704,11 +687,7 @@ static int net_socket_mcast_init(NetClientState *peer,
         stored->localaddr = g_strdup(localaddr_str);
     }
 
-    snprintf(s->nc.info_str, sizeof(s->nc.info_str),
-             "socket: mcast=%s:%d",
-             inet_ntoa(saddr.sin_addr), ntohs(saddr.sin_port));
     return 0;
-
 }
 
 static int net_socket_udp_init(NetClientState *peer,
@@ -769,9 +748,6 @@ static int net_socket_udp_init(NetClientState *peer,
     stored->has_udp = true;
     stored->udp = g_strdup(rhost);
 
-    snprintf(s->nc.info_str, sizeof(s->nc.info_str),
-             "socket: udp=%s:%d",
-             inet_ntoa(raddr.sin_addr), ntohs(raddr.sin_port));
     return 0;
 }
 
diff --git a/net/tap.c b/net/tap.c
index f40f378c2a..bd5cb6f5cd 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -616,9 +616,6 @@ int net_init_bridge(const Netdev *netdev, const char *name,
         stored->helper = g_strdup(helper);
     }
 
-    snprintf(s->nc.info_str, sizeof(s->nc.info_str), "helper=%s,br=%s", helper,
-             br);
-
     return 0;
 }
 
@@ -704,8 +701,6 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
             stored->fds = g_strdup_printf("%s:%d", stored->fds, fd);
             g_free(tmp_s);
         }
-
-        snprintf(s->nc.info_str, sizeof(s->nc.info_str), "fd=%d", fd);
     } else if (tap->has_helper) {
         if (!stored->has_helper) {
             stored->has_helper = true;
@@ -717,9 +712,6 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
             stored->br = tap->has_br ? g_strdup(tap->br) :
                                     g_strdup(DEFAULT_BRIDGE_INTERFACE);
         }
-
-        snprintf(s->nc.info_str, sizeof(s->nc.info_str), "helper=%s",
-                 tap->helper);
     } else {
         if (ifname && !stored->has_ifname) {
             stored->has_ifname = true;
@@ -736,10 +728,6 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
             stored->downscript = g_strdup(downscript);
         }
 
-        snprintf(s->nc.info_str, sizeof(s->nc.info_str),
-                 "ifname=%s,script=%s,downscript=%s", ifname, script,
-                 downscript);
-
         if (strcmp(downscript, "no") != 0) {
             snprintf(s->down_script, sizeof(s->down_script), "%s", downscript);
             snprintf(s->down_script_arg, sizeof(s->down_script_arg),
diff --git a/net/vde.c b/net/vde.c
index c4edf5cba1..cdd27eddd7 100644
--- a/net/vde.c
+++ b/net/vde.c
@@ -99,10 +99,6 @@ static int net_vde_init(NetClientState *peer, const char *model,
     }
 
     nc = qemu_new_net_client(&net_vde_info, peer, model, name);
-
-    snprintf(nc->info_str, sizeof(nc->info_str), "sock=%s,fd=%d",
-             sock, vde_datafd(vde));
-
     s = DO_UPCAST(VDEState, nc, nc);
 
     s->vde = vde;
diff --git a/net/vhost-user.c b/net/vhost-user.c
index aa2dc53179..dcc60f9c34 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -323,8 +323,6 @@ static int net_vhost_user_init(NetClientState *peer, const char *device,
     user = g_new0(struct VhostUserState, 1);
     for (i = 0; i < queues; i++) {
         nc = qemu_new_net_client(&net_vhost_user_info, peer, device, name);
-        snprintf(nc->info_str, sizeof(nc->info_str), "vhost-user%d to %s",
-                 i, chr->label);
         nc->queue_index = i;
         if (!nc0) {
             nc0 = nc;
-- 
2.17.1


