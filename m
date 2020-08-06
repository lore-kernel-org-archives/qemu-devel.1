Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544FEC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 20:00:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46F5E221E2
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 20:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g7VJv6Vi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46F5E221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3m46-0001Uw-Ao
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 16:00:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lQK-0000yu-Hu
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:19:32 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44993
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k3lQH-0006m2-UT
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 15:19:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596741569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/ZnIMjoTccZk5f8PSa5vfybwIdk3xSdKpgnxMEzLOXY=;
 b=g7VJv6ViICgG3yB/AOdEuBe+veTSNw42NLSxYf9QS+Ozl3RYv0VNmKemJy/QpwJcsiwd+P
 uxB2n8oVKXfdi1ef3QtLE9F/zb/X822FLtW10Jh9hfn3CwEbtmwcdHGa96vqSFyz1s92Cr
 ERLmKlhqduSEHWfjFQ3Ml+OtszYPoNM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-UIaUC7pPNjCvjS-W-9oR3Q-1; Thu, 06 Aug 2020 15:19:27 -0400
X-MC-Unique: UIaUC7pPNjCvjS-W-9oR3Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EAA1A800685
 for <qemu-devel@nongnu.org>; Thu,  6 Aug 2020 19:19:24 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 07E535FC3B;
 Thu,  6 Aug 2020 19:19:23 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 103/143] meson: convert hw/net
Date: Thu,  6 Aug 2020 21:15:39 +0200
Message-Id: <1596741379-12902-104-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 00:07:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/Makefile.objs         |  1 -
 hw/meson.build           |  1 +
 hw/net/Makefile.objs     | 59 ------------------------------------------
 hw/net/can/Makefile.objs |  4 ---
 hw/net/can/meson.build   |  4 +++
 hw/net/meson.build       | 67 ++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 72 insertions(+), 64 deletions(-)
 delete mode 100644 hw/net/Makefile.objs
 delete mode 100644 hw/net/can/Makefile.objs
 create mode 100644 hw/net/can/meson.build
 create mode 100644 hw/net/meson.build

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 748a718..d0d7816 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -18,7 +18,6 @@ devices-dirs-$(CONFIG_IPACK) += ipack/
 devices-dirs-$(CONFIG_IPMI) += ipmi/
 devices-dirs-y += isa/
 devices-dirs-y += misc/
-devices-dirs-y += net/
 endif
 
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/meson.build b/hw/meson.build
index f704e51..1f7b2c4 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -1,5 +1,6 @@
 subdir('core')
 subdir('mem')
+subdir('net')
 subdir('nubus')
 subdir('nvram')
 subdir('pci')
diff --git a/hw/net/Makefile.objs b/hw/net/Makefile.objs
deleted file mode 100644
index 7ccbf72..0000000
--- a/hw/net/Makefile.objs
+++ /dev/null
@@ -1,59 +0,0 @@
-common-obj-$(CONFIG_DP8393X) += dp8393x.o
-common-obj-$(CONFIG_XEN) += xen_nic.o
-common-obj-$(CONFIG_NE2000_COMMON) += ne2000.o
-
-# PCI network cards
-common-obj-$(CONFIG_NE2000_PCI) += ne2000-pci.o
-common-obj-$(CONFIG_EEPRO100_PCI) += eepro100.o
-common-obj-$(CONFIG_PCNET_PCI) += pcnet-pci.o
-common-obj-$(CONFIG_PCNET_COMMON) += pcnet.o
-common-obj-$(CONFIG_E1000_PCI) += e1000.o e1000x_common.o
-common-obj-$(CONFIG_E1000E_PCI_EXPRESS) += net_tx_pkt.o net_rx_pkt.o
-common-obj-$(CONFIG_E1000E_PCI_EXPRESS) += e1000e.o e1000e_core.o e1000x_common.o
-common-obj-$(CONFIG_RTL8139_PCI) += rtl8139.o
-common-obj-$(CONFIG_VMXNET3_PCI) += net_tx_pkt.o net_rx_pkt.o
-common-obj-$(CONFIG_VMXNET3_PCI) += vmxnet3.o
-common-obj-$(CONFIG_TULIP) += tulip.o
-
-common-obj-$(CONFIG_SMC91C111) += smc91c111.o
-common-obj-$(CONFIG_LAN9118) += lan9118.o
-common-obj-$(CONFIG_NE2000_ISA) += ne2000-isa.o
-common-obj-$(CONFIG_OPENCORES_ETH) += opencores_eth.o
-common-obj-$(CONFIG_XGMAC) += xgmac.o
-common-obj-$(CONFIG_MIPSNET) += mipsnet.o
-common-obj-$(CONFIG_XILINX_AXI) += xilinx_axienet.o
-common-obj-$(CONFIG_ALLWINNER_EMAC) += allwinner_emac.o
-common-obj-$(CONFIG_ALLWINNER_SUN8I_EMAC) += allwinner-sun8i-emac.o
-common-obj-$(CONFIG_IMX_FEC) += imx_fec.o
-
-common-obj-$(CONFIG_CADENCE) += cadence_gem.o
-common-obj-$(CONFIG_STELLARIS_ENET) += stellaris_enet.o
-common-obj-$(CONFIG_LANCE) += lance.o
-common-obj-$(CONFIG_LASI_82596) += lasi_i82596.o
-common-obj-$(CONFIG_I82596_COMMON) += i82596.o
-common-obj-$(CONFIG_SUNHME) += sunhme.o
-common-obj-$(CONFIG_FTGMAC100) += ftgmac100.o
-common-obj-$(CONFIG_SUNGEM) += sungem.o
-
-common-obj-$(CONFIG_ETRAXFS) += etraxfs_eth.o
-common-obj-$(CONFIG_COLDFIRE) += mcf_fec.o
-obj-$(CONFIG_MILKYMIST) += milkymist-minimac2.o
-obj-$(CONFIG_PSERIES) += spapr_llan.o
-obj-$(CONFIG_XILINX_ETHLITE) += xilinx_ethlite.o
-
-common-obj-$(CONFIG_VIRTIO_NET) += net_rx_pkt.o
-obj-$(CONFIG_VIRTIO_NET) += virtio-net.o
-common-obj-$(call land,$(CONFIG_VIRTIO_NET),$(CONFIG_VHOST_NET)) += vhost_net.o
-common-obj-$(call lnot,$(call land,$(CONFIG_VIRTIO_NET),$(CONFIG_VHOST_NET))) += vhost_net-stub.o
-common-obj-$(CONFIG_ALL) += vhost_net-stub.o
-
-common-obj-$(CONFIG_ETSEC) += fsl_etsec/etsec.o fsl_etsec/registers.o \
-			fsl_etsec/rings.o fsl_etsec/miim.o
-
-common-obj-$(CONFIG_ROCKER) += rocker/rocker.o rocker/rocker_fp.o \
-                               rocker/rocker_desc.o rocker/rocker_world.o \
-                               rocker/rocker_of_dpa.o
-obj-$(call lnot,$(CONFIG_ROCKER)) += rocker/qmp-norocker.o
-
-common-obj-$(CONFIG_CAN_BUS) += can/
-common-obj-$(CONFIG_MSF2) += msf2-emac.o
diff --git a/hw/net/can/Makefile.objs b/hw/net/can/Makefile.objs
deleted file mode 100644
index 9f0c4ee..0000000
--- a/hw/net/can/Makefile.objs
+++ /dev/null
@@ -1,4 +0,0 @@
-common-obj-$(CONFIG_CAN_SJA1000) += can_sja1000.o
-common-obj-$(CONFIG_CAN_PCI) += can_kvaser_pci.o
-common-obj-$(CONFIG_CAN_PCI) += can_pcm3680_pci.o
-common-obj-$(CONFIG_CAN_PCI) += can_mioe3680_pci.o
diff --git a/hw/net/can/meson.build b/hw/net/can/meson.build
new file mode 100644
index 0000000..c9cfeb7
--- /dev/null
+++ b/hw/net/can/meson.build
@@ -0,0 +1,4 @@
+softmmu_ss.add(when: 'CONFIG_CAN_SJA1000', if_true: files('can_sja1000.c'))
+softmmu_ss.add(when: 'CONFIG_CAN_PCI', if_true: files('can_kvaser_pci.c'))
+softmmu_ss.add(when: 'CONFIG_CAN_PCI', if_true: files('can_pcm3680_pci.c'))
+softmmu_ss.add(when: 'CONFIG_CAN_PCI', if_true: files('can_mioe3680_pci.c'))
diff --git a/hw/net/meson.build b/hw/net/meson.build
new file mode 100644
index 0000000..4a7051b
--- /dev/null
+++ b/hw/net/meson.build
@@ -0,0 +1,67 @@
+softmmu_ss.add(when: 'CONFIG_DP8393X', if_true: files('dp8393x.c'))
+softmmu_ss.add(when: 'CONFIG_XEN', if_true: files('xen_nic.c'))
+softmmu_ss.add(when: 'CONFIG_NE2000_COMMON', if_true: files('ne2000.c'))
+
+# PCI network cards
+softmmu_ss.add(when: 'CONFIG_NE2000_PCI', if_true: files('ne2000-pci.c'))
+softmmu_ss.add(when: 'CONFIG_EEPRO100_PCI', if_true: files('eepro100.c'))
+softmmu_ss.add(when: 'CONFIG_PCNET_PCI', if_true: files('pcnet-pci.c'))
+softmmu_ss.add(when: 'CONFIG_PCNET_COMMON', if_true: files('pcnet.c'))
+softmmu_ss.add(when: 'CONFIG_E1000_PCI', if_true: files('e1000.c', 'e1000x_common.c'))
+softmmu_ss.add(when: 'CONFIG_E1000E_PCI_EXPRESS', if_true: files('net_tx_pkt.c', 'net_rx_pkt.c'))
+softmmu_ss.add(when: 'CONFIG_E1000E_PCI_EXPRESS', if_true: files('e1000e.c', 'e1000e_core.c', 'e1000x_common.c'))
+softmmu_ss.add(when: 'CONFIG_RTL8139_PCI', if_true: files('rtl8139.c'))
+softmmu_ss.add(when: 'CONFIG_TULIP', if_true: files('tulip.c'))
+softmmu_ss.add(when: 'CONFIG_VMXNET3_PCI', if_true: files('net_tx_pkt.c', 'net_rx_pkt.c'))
+softmmu_ss.add(when: 'CONFIG_VMXNET3_PCI', if_true: files('vmxnet3.c'))
+
+softmmu_ss.add(when: 'CONFIG_SMC91C111', if_true: files('smc91c111.c'))
+softmmu_ss.add(when: 'CONFIG_LAN9118', if_true: files('lan9118.c'))
+softmmu_ss.add(when: 'CONFIG_NE2000_ISA', if_true: files('ne2000-isa.c'))
+softmmu_ss.add(when: 'CONFIG_OPENCORES_ETH', if_true: files('opencores_eth.c'))
+softmmu_ss.add(when: 'CONFIG_XGMAC', if_true: files('xgmac.c'))
+softmmu_ss.add(when: 'CONFIG_MIPSNET', if_true: files('mipsnet.c'))
+softmmu_ss.add(when: 'CONFIG_XILINX_AXI', if_true: files('xilinx_axienet.c'))
+softmmu_ss.add(when: 'CONFIG_ALLWINNER_EMAC', if_true: files('allwinner_emac.c'))
+softmmu_ss.add(when: 'CONFIG_ALLWINNER_SUN8I_EMAC', if_true: files('allwinner-sun8i-emac.c'))
+softmmu_ss.add(when: 'CONFIG_IMX_FEC', if_true: files('imx_fec.c'))
+softmmu_ss.add(when: 'CONFIG_MSF2', if_true: files('msf2-emac.c'))
+
+softmmu_ss.add(when: 'CONFIG_CADENCE', if_true: files('cadence_gem.c'))
+softmmu_ss.add(when: 'CONFIG_STELLARIS_ENET', if_true: files('stellaris_enet.c'))
+softmmu_ss.add(when: 'CONFIG_LANCE', if_true: files('lance.c'))
+softmmu_ss.add(when: 'CONFIG_LASI_I82596', if_true: files('lasi_i82596.c'))
+softmmu_ss.add(when: 'CONFIG_I82596_COMMON', if_true: files('i82596.c'))
+softmmu_ss.add(when: 'CONFIG_SUNHME', if_true: files('sunhme.c'))
+softmmu_ss.add(when: 'CONFIG_FTGMAC100', if_true: files('ftgmac100.c'))
+softmmu_ss.add(when: 'CONFIG_SUNGEM', if_true: files('sungem.c'))
+
+softmmu_ss.add(when: 'CONFIG_ETRAXFS', if_true: files('etraxfs_eth.c'))
+softmmu_ss.add(when: 'CONFIG_COLDFIRE', if_true: files('mcf_fec.c'))
+specific_ss.add(when: 'CONFIG_MILKYMIST', if_true: files('milkymist-minimac2.c'))
+specific_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr_llan.c'))
+specific_ss.add(when: 'CONFIG_XILINX_ETHLITE', if_true: files('xilinx_ethlite.c'))
+
+softmmu_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('net_rx_pkt.c'))
+specific_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('virtio-net.c'))
+
+softmmu_ss.add(when: ['CONFIG_VIRTIO_NET', 'CONFIG_VHOST_NET'], if_true: files('vhost_net.c'), if_false: files('vhost_net-stub.c'))
+softmmu_ss.add(when: 'CONFIG_ALL', if_true: files('vhost_net-stub.c'))
+
+softmmu_ss.add(when: 'CONFIG_ETSEC', if_true: files(
+  'fsl_etsec/etsec.c',
+  'fsl_etsec/miim.c',
+  'fsl_etsec/registers.c',
+  'fsl_etsec/rings.c',
+))
+
+softmmu_ss.add(when: 'CONFIG_ROCKER', if_true: files(
+  'rocker/rocker.c',
+  'rocker/rocker_desc.c',
+  'rocker/rocker_fp.c',
+  'rocker/rocker_of_dpa.c',
+  'rocker/rocker_world.c',
+), if_false: files('rocker/qmp-norocker.c'))
+softmmu_ss.add(when: 'CONFIG_ALL', if_true: files('rocker/qmp-norocker.c'))
+
+subdir('can')
-- 
1.8.3.1



