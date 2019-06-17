Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C138C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:20:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B0EA20B1F
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 18:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DAE2ICbT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B0EA20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50890 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcwEg-0007jm-Kc
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 14:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58445)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1hcwAM-0005DG-Co
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:15:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1hcwAJ-0001BM-Mu
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:15:38 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42586)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1hcwAJ-0001A4-B9
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:15:35 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HI9175149332;
 Mon, 17 Jun 2019 18:15:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=2JTdks2T660NsSLjsk5mhaG7Y9bk06luO7AA8iBoKoU=;
 b=DAE2ICbTK/Uw/fD83irXP4wSmsS8LFvrC/YgcsKjbQSO0oSQF0QLxgx4eVsW7hhH3eus
 rR1w/V1r4125PpXAxFFpGSRjrHV9LbgO7o5Ujt4UyomMMX0flvuRY0AeEd+/4bSORbqq
 M8P1THWner8eI9+id+qj3GLLjQxaqzG0jQ44Fm5nWJCpxtBHvsCQ8qpQG4VdA5XP/R60
 DDWj8M4sw7LEz4tW4YgC74yh7PVp1qyJGzL70J93YhgEw29+t6Mtzjcz6ScLvGZ+WPI0
 W2e04E4QjXvcgLyWm55HE/LsdRc/H+WHVJe17vEPXp+T22ww/UjA+ejN/xRjIxCAAQ/L Gw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 2t4r3tg2tw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 18:15:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5HIF93S118052;
 Mon, 17 Jun 2019 18:15:26 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 2t5cpdkehm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 18:15:26 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5HIFPY4027637;
 Mon, 17 Jun 2019 18:15:25 GMT
Received: from heatpipe.hsd1.ca.comcast.net (/73.170.27.202)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 17 Jun 2019 11:15:24 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 11:15:21 -0700
Message-Id: <20190617181521.29371-1-elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906170162
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9291
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906170162
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 156.151.31.86
Subject: [Qemu-devel] [RFC PATCH v2 06/35] multi-process: build system for
 remote device process
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
Cc: elena.ufimtseva@oracle.com, john.g.johnson@oracle.com, jag.raman@oracle.com,
 konrad.wilk@oracle.com, mst@redhat.com, dgilbert@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, liran.alon@oracle.com, stefanha@redhat.com,
 pbonzini@redhat.com, kanth.ghatraju@oracle.com, fam@euphon.net,
 kwolf@redhat.com, quintela@redhat.com, afaerber@suse.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jagannathan Raman <jag.raman@oracle.com>

Modify Makefile to support the building of the remote
device process. Implements main() function of remote
device process.

Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 Makefile                |  5 +++-
 Makefile.objs           | 22 +++++++++++++++++
 Makefile.target         | 52 +++++++++++++++++++++++++++++++++++++++--
 backends/Makefile.objs  |  2 ++
 block/Makefile.objs     |  2 ++
 hw/Makefile.objs        |  7 ++++++
 hw/block/Makefile.objs  |  2 ++
 hw/core/Makefile.objs   | 14 +++++++++++
 hw/nvram/Makefile.objs  |  2 ++
 hw/pci/Makefile.objs    |  4 ++++
 hw/scsi/Makefile.objs   |  2 ++
 migration/Makefile.objs |  2 ++
 qom/Makefile.objs       |  4 ++++
 remote/Makefile.objs    |  1 +
 remote/remote-main.c    | 35 +++++++++++++++++++++++++++
 15 files changed, 153 insertions(+), 3 deletions(-)
 create mode 100644 remote/Makefile.objs
 create mode 100644 remote/remote-main.c

diff --git a/Makefile b/Makefile
index 626a04d305..8650212b0a 100644
--- a/Makefile
+++ b/Makefile
@@ -414,6 +414,8 @@ dummy := $(call unnest-vars,, \
                 qom-obj-y \
                 io-obj-y \
                 common-obj-y \
+                remote-pci-obj-y \
+                remote-lsi-obj-y \
                 common-obj-m \
                 ui-obj-y \
                 ui-obj-m \
@@ -483,7 +485,8 @@ subdir-slirp: .git-submodule-status
 	$(call quiet-command,$(MAKE) -C $(SRC_PATH)/slirp BUILD_DIR="$(BUILD_DIR)/slirp" CC="$(CC)" AR="$(AR)" LD="$(LD)" RANLIB="$(RANLIB)" CFLAGS="$(QEMU_CFLAGS)")
 
 $(SUBDIR_RULES): libqemuutil.a $(common-obj-y) $(chardev-obj-y) \
-	$(qom-obj-y) $(crypto-aes-obj-$(CONFIG_USER_ONLY))
+	$(qom-obj-y) $(crypto-aes-obj-$(CONFIG_USER_ONLY)) \
+	$(remote-pci-obj-y) $(remote-lsi-obj-y)
 
 ROMSUBDIR_RULES=$(patsubst %,romsubdir-%, $(ROMS))
 # Only keep -O and -g cflags
diff --git a/Makefile.objs b/Makefile.objs
index cf065de5ed..74bd8914f0 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -21,6 +21,28 @@ block-obj-$(CONFIG_REPLICATION) += replication.o
 
 block-obj-m = block/
 
+#########################################################
+# remote-pci-obj-y is common code used by remote devices
+
+remote-pci-obj-$(CONFIG_MPQEMU) += hw/
+remote-pci-obj-$(CONFIG_MPQEMU) += qom/
+remote-pci-obj-$(CONFIG_MPQEMU) += backends/
+remote-pci-obj-$(CONFIG_MPQEMU) += block/
+remote-pci-obj-$(CONFIG_MPQEMU) += migration/
+remote-pci-obj-$(CONFIG_MPQEMU) += remote/
+
+remote-pci-obj-$(CONFIG_MPQEMU) += cpus-common.o
+remote-pci-obj-$(CONFIG_MPQEMU) += dma-helpers.o
+remote-pci-obj-$(CONFIG_MPQEMU) += blockdev.o
+remote-pci-obj-$(CONFIG_MPQEMU) += qdev-monitor.o
+remote-pci-obj-$(CONFIG_MPQEMU) += bootdevice.o
+remote-pci-obj-$(CONFIG_MPQEMU) += iothread.o
+
+##############################################################
+# remote-lsi-obj-y is code used to implement remote LSI device
+
+remote-lsi-obj-$(CONFIG_MPQEMU) += hw/
+
 #######################################################################
 # crypto-obj-y is code used by both qemu system emulation and qemu-img
 
diff --git a/Makefile.target b/Makefile.target
index ae02495951..f45af2b851 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -36,7 +36,12 @@ QEMU_PROG_BUILD = $(QEMU_PROG)
 endif
 endif
 
-PROGS=$(QEMU_PROG) $(QEMU_PROGW)
+ifdef CONFIG_MPQEMU
+SCSI_DEV_PROG=qemu-scsi-dev
+SCSI_DEV_BUILD = $(SCSI_DEV_PROG)
+endif
+
+PROGS=$(QEMU_PROG) $(QEMU_PROGW) $(SCSI_DEV_PROG)
 STPFILES=
 
 # Makefile Tests
@@ -118,6 +123,16 @@ obj-y += target/$(TARGET_BASE_ARCH)/
 obj-y += disas.o
 obj-$(call notempty,$(TARGET_XML_FILES)) += gdbstub-xml.o
 
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += accel/stubs/kvm-stub.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += accel/stubs/tcg-stub.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += accel/stubs/hax-stub.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += accel/stubs/whpx-stub.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += stubs/vl-stub.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += stubs/net-stub.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += stubs/monitor.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += stubs/replay.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += stubs/xen-mapcache.o
+
 #########################################################
 # Linux user emulator target
 
@@ -173,6 +188,18 @@ endif # CONFIG_SOFTMMU
 dummy := $(call unnest-vars,,obj-y)
 all-obj-y := $(obj-y)
 
+dummy := $(call unnest-vars,..,remote-pci-tgt-obj-y)
+all-remote-pci-obj-y := $(remote-pci-tgt-obj-y)
+
+all-remote-pci-obj-y += memory.o
+all-remote-pci-obj-y += exec.o
+all-remote-pci-obj-y += numa.o
+all-remote-pci-obj-y += ioport.o
+all-remote-pci-obj-y += cpus.o
+
+remote-pci-obj-y :=
+remote-lsi-obj-y :=
+
 include $(SRC_PATH)/Makefile.objs
 dummy := $(call unnest-vars,.., \
                authz-obj-y \
@@ -184,7 +211,10 @@ dummy := $(call unnest-vars,.., \
                qom-obj-y \
                io-obj-y \
                common-obj-y \
-               common-obj-m)
+               common-obj-m \
+               remote-pci-obj-y \
+               remote-lsi-obj-y)
+
 all-obj-y += $(common-obj-y)
 all-obj-y += $(qom-obj-y)
 all-obj-$(CONFIG_SOFTMMU) += $(authz-obj-y)
@@ -193,8 +223,19 @@ all-obj-$(CONFIG_USER_ONLY) += $(crypto-aes-obj-y)
 all-obj-$(CONFIG_SOFTMMU) += $(crypto-obj-y)
 all-obj-$(CONFIG_SOFTMMU) += $(io-obj-y)
 
+all-remote-pci-obj-y += $(authz-obj-y)
+all-remote-pci-obj-y += $(block-obj-y)
+all-remote-pci-obj-y += $(crypto-obj-y)
+all-remote-pci-obj-y += $(io-obj-y)
+all-remote-pci-obj-y += $(chardev-obj-y)
+all-remote-pci-obj-y += $(remote-pci-obj-y)
+
+
+all-remote-lsi-obj-y += $(all-remote-pci-obj-y) $(remote-lsi-obj-y)
+
 ifdef CONFIG_SOFTMMU
 $(QEMU_PROG_BUILD): config-devices.mak
+$(SCSI_DEV_BUILD): config-devices.mak
 endif
 
 COMMON_LDADDS = ../libqemuutil.a
@@ -207,6 +248,13 @@ ifdef CONFIG_DARWIN
 	$(call quiet-command,SetFile -a C $@,"SETFILE","$(TARGET_DIR)$@")
 endif
 
+$(SCSI_DEV_BUILD): $(all-remote-lsi-obj-y) $(COMMON_LDADDS)
+	$(call LINK, $(filter-out %.mak, $^))
+ifdef CONFIG_DARWIN
+	$(call quiet-command,Rez -append $(SRC_PATH)/pc-bios/qemu.rsrc -o $@,"REZ","$(TARGET_DIR)$@")
+	$(call quiet-command,SetFile -a C $@,"SETFILE","$(TARGET_DIR)$@")
+endif
+
 gdbstub-xml.c: $(TARGET_XML_FILES) $(SRC_PATH)/scripts/feature_to_c.sh
 	$(call quiet-command,rm -f $@ && $(SHELL) $(SRC_PATH)/scripts/feature_to_c.sh $@ $(TARGET_XML_FILES),"GEN","$(TARGET_DIR)$@")
 
diff --git a/backends/Makefile.objs b/backends/Makefile.objs
index ff619d31b4..47c4161b49 100644
--- a/backends/Makefile.objs
+++ b/backends/Makefile.objs
@@ -15,3 +15,5 @@ common-obj-$(CONFIG_VHOST_CRYPTO) += cryptodev-vhost-user.o
 endif
 
 common-obj-$(CONFIG_LINUX) += hostmem-memfd.o
+
+remote-pci-obj-$(CONFIG_MPQEMU) += hostmem.o
diff --git a/block/Makefile.objs b/block/Makefile.objs
index 7a81892a52..cfc7719f62 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -63,3 +63,5 @@ qcow.o-libs        := -lz
 linux-aio.o-libs   := -laio
 parallels.o-cflags := $(LIBXML2_CFLAGS)
 parallels.o-libs   := $(LIBXML2_LIBS)
+
+remote-pci-obj-$(CONFIG_MPQEMU) += stream.o
diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 82aa7fab8e..80e0a6ab14 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -39,3 +39,10 @@ devices-dirs-$(CONFIG_SOFTMMU) += smbios/
 devices-dirs-y += core/
 common-obj-y += $(devices-dirs-y)
 obj-y += $(devices-dirs-y)
+
+remote-pci-obj-$(CONFIG_MPQEMU) += core/
+remote-pci-obj-$(CONFIG_MPQEMU) += block/
+remote-pci-obj-$(CONFIG_MPQEMU) += pci/
+remote-pci-obj-$(CONFIG_MPQEMU) += nvram/
+
+remote-lsi-obj-$(CONFIG_MPQEMU) += scsi/
diff --git a/hw/block/Makefile.objs b/hw/block/Makefile.objs
index f5f643f0cc..7286fbd885 100644
--- a/hw/block/Makefile.objs
+++ b/hw/block/Makefile.objs
@@ -15,3 +15,5 @@ obj-$(CONFIG_VIRTIO_BLK) += virtio-blk.o
 obj-$(CONFIG_VHOST_USER_BLK) += vhost-user-blk.o
 
 obj-y += dataplane/
+
+remote-pci-obj-$(CONFIG_MPQEMU) += block.o cdrom.o hd-geometry.o
diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index a799c83815..3e3afaa271 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -22,3 +22,17 @@ common-obj-$(CONFIG_SOFTMMU) += split-irq.o
 common-obj-$(CONFIG_PLATFORM_BUS) += platform-bus.o
 common-obj-$(CONFIG_SOFTMMU) += generic-loader.o
 common-obj-$(CONFIG_SOFTMMU) += null-machine.o
+
+remote-pci-obj-$(CONFIG_MPQEMU) += qdev-properties.o
+remote-pci-obj-$(CONFIG_MPQEMU) += qdev.o
+remote-pci-obj-$(CONFIG_MPQEMU) += bus.o
+remote-pci-obj-$(CONFIG_MPQEMU) += irq.o
+remote-pci-obj-$(CONFIG_MPQEMU) += hotplug.o
+remote-pci-obj-$(CONFIG_MPQEMU) += machine.o
+remote-pci-obj-$(CONFIG_MPQEMU) += fw-path-provider.o
+remote-pci-obj-$(CONFIG_MPQEMU) += reset.o
+remote-pci-obj-$(CONFIG_MPQEMU) += sysbus.o
+remote-pci-obj-$(CONFIG_MPQEMU) += loader.o
+remote-pci-obj-$(CONFIG_MPQEMU) += nmi.o
+remote-pci-obj-$(CONFIG_MPQEMU) += qdev-properties-system.o
+remote-pci-obj-$(CONFIG_MPQEMU) += qdev-fw.o
diff --git a/hw/nvram/Makefile.objs b/hw/nvram/Makefile.objs
index 26f7b4ca35..9802a31fbb 100644
--- a/hw/nvram/Makefile.objs
+++ b/hw/nvram/Makefile.objs
@@ -6,3 +6,5 @@ common-obj-y += chrp_nvram.o
 common-obj-$(CONFIG_MAC_NVRAM) += mac_nvram.o
 obj-$(CONFIG_PSERIES) += spapr_nvram.o
 obj-$(CONFIG_NRF51_SOC) += nrf51_nvm.o
+
+remote-pci-obj-$(CONFIG_MPQEMU) += fw_cfg.o
diff --git a/hw/pci/Makefile.objs b/hw/pci/Makefile.objs
index c78f2fb24b..955be54472 100644
--- a/hw/pci/Makefile.objs
+++ b/hw/pci/Makefile.objs
@@ -12,3 +12,7 @@ common-obj-$(CONFIG_PCI_EXPRESS) += pcie_port.o pcie_host.o
 
 common-obj-$(call lnot,$(CONFIG_PCI)) += pci-stub.o
 common-obj-$(CONFIG_ALL) += pci-stub.o
+
+remote-pci-obj-$(CONFIG_MPQEMU) += pci.o pci_bridge.o
+remote-pci-obj-$(CONFIG_MPQEMU) += msi.o msix.o
+remote-pci-obj-$(CONFIG_MPQEMU) += pcie.o
diff --git a/hw/scsi/Makefile.objs b/hw/scsi/Makefile.objs
index 54b36ed8b1..ef97770922 100644
--- a/hw/scsi/Makefile.objs
+++ b/hw/scsi/Makefile.objs
@@ -13,3 +13,5 @@ obj-y += virtio-scsi.o virtio-scsi-dataplane.o
 obj-$(CONFIG_VHOST_SCSI) += vhost-scsi-common.o vhost-scsi.o
 obj-$(CONFIG_VHOST_USER_SCSI) += vhost-scsi-common.o vhost-user-scsi.o
 endif
+
+remote-lsi-obj-$(CONFIG_MPQEMU) += scsi-generic.o scsi-bus.o lsi53c895a.o scsi-disk.o emulation.o
diff --git a/migration/Makefile.objs b/migration/Makefile.objs
index a4f3bafd86..016b6abd6e 100644
--- a/migration/Makefile.objs
+++ b/migration/Makefile.objs
@@ -13,3 +13,5 @@ common-obj-$(CONFIG_RDMA) += rdma.o
 common-obj-$(CONFIG_LIVE_BLOCK_MIGRATION) += block.o
 
 rdma.o-libs := $(RDMA_LIBS)
+
+remote-pci-obj-$(CONFIG_MPQEMU) += qemu-file.o vmstate.o qjson.o vmstate-types.o
diff --git a/qom/Makefile.objs b/qom/Makefile.objs
index 516349eec3..f0392c2b55 100644
--- a/qom/Makefile.objs
+++ b/qom/Makefile.objs
@@ -2,3 +2,7 @@ qom-obj-y = object.o container.o qom-qobject.o
 qom-obj-y += object_interfaces.o
 
 common-obj-y = cpu.o
+
+remote-pci-obj-$(CONFIG_MPQEMU) += object.o qom-qobject.o container.o
+remote-pci-obj-$(CONFIG_MPQEMU) += object_interfaces.o
+remote-pci-obj-$(CONFIG_MPQEMU) += cpu.o
diff --git a/remote/Makefile.objs b/remote/Makefile.objs
new file mode 100644
index 0000000000..a9b2256b2a
--- /dev/null
+++ b/remote/Makefile.objs
@@ -0,0 +1 @@
+remote-pci-obj-$(CONFIG_MPQEMU) += remote-main.o
diff --git a/remote/remote-main.c b/remote/remote-main.c
new file mode 100644
index 0000000000..ffcf47f185
--- /dev/null
+++ b/remote/remote-main.c
@@ -0,0 +1,35 @@
+/*
+ * Remote device initialization
+ *
+ * Copyright 2019, Oracle and/or its affiliates.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include <stdio.h>
+
+#include "qemu/osdep.h"
+#include "qemu/module.h"
+
+int main(int argc, char *argv[])
+{
+    module_call_init(MODULE_INIT_QOM);
+
+    return 0;
+}
-- 
2.17.1


