Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD6CCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:15:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4895F20856
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Rq7eSZnf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4895F20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNZDJ-0001So-Ea
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 05:15:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43592)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1iNZ8D-00054L-4M
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:10:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1iNZ8A-0003nN-T6
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:10:08 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60118)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1iNZ8A-0003mr-L6
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:10:06 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O94LIE094836;
 Thu, 24 Oct 2019 09:10:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2019-08-05;
 bh=djhRt41UYigUdh6RTBGKKZ8WWVHBf3mQ1k4IXTUECqQ=;
 b=Rq7eSZnfkK3mjNEcQxJ8tnmS/4auZNnd2qFKUVYCxqYpJvWT7ZdOWPC8931psR84BzJB
 zeofXBVSn8XktLRg8CPozkqnhV7hgIvQZlpXg6pfmsF9qtM1sX2lTYF5ynXdi+McCFN1
 6CsgKwhIhDSJXgoczyg+B8fq2WE3lkgI3pfl4IaOsvQAsWDMoDTH2KuQIrbjF1Okbpyu
 5t0zlqrjZmvnekfo0yHMm5p5oQSov7wGHIkOsc8cleJTrb5fo/KOwNOJA42EP1lIfenh
 M1MFhNSrMVRi3C07vh3fxbHYCiM8wAdEvZsQXnbRp0wKsBLOFVxaJ5KswkFPpt4eiS7e jw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 2vqu4r24kg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 09:10:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O98Lt5047136;
 Thu, 24 Oct 2019 09:10:00 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 2vu0fnu665-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 09:10:00 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9O99x0K001696;
 Thu, 24 Oct 2019 09:10:00 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 24 Oct 2019 02:09:59 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [RFC v4 PATCH 06/49] multi-process: build system for remote device
 process
Date: Thu, 24 Oct 2019 05:08:47 -0400
Message-Id: <e145fb518878ea5bab998f3bc290f410f87b3fce.1571905346.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1571905346.git.jag.raman@oracle.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
In-Reply-To: <cover.1571905346.git.jag.raman@oracle.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9419
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910240089
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9419
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910240089
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, john.g.johnson@oracle.com,
 kraxel@redhat.com, jag.raman@oracle.com, quintela@redhat.com, mst@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Modify Makefile to support the building of the remote
device process. Implements main() function of remote
device process.

Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 Makefile                |  2 ++
 Makefile.objs           | 22 ++++++++++++++++++++
 Makefile.target         | 53 +++++++++++++++++++++++++++++++++++++++++++++++--
 backends/Makefile.objs  |  2 ++
 block/Makefile.objs     |  2 ++
 hw/Makefile.objs        |  7 +++++++
 hw/block/Makefile.objs  |  2 ++
 hw/core/Makefile.objs   | 16 +++++++++++++++
 hw/nvram/Makefile.objs  |  2 ++
 hw/pci/Makefile.objs    |  4 ++++
 hw/scsi/Makefile.objs   |  2 ++
 migration/Makefile.objs |  2 ++
 qom/Makefile.objs       |  3 +++
 remote/Makefile.objs    |  1 +
 remote/remote-main.c    | 37 ++++++++++++++++++++++++++++++++++
 stubs/replay.c          |  4 ++++
 16 files changed, 159 insertions(+), 2 deletions(-)
 create mode 100644 remote/Makefile.objs
 create mode 100644 remote/remote-main.c

diff --git a/Makefile b/Makefile
index d20e7ff..c4d5048 100644
--- a/Makefile
+++ b/Makefile
@@ -437,6 +437,8 @@ dummy := $(call unnest-vars,, \
                 qom-obj-y \
                 io-obj-y \
                 common-obj-y \
+                remote-pci-obj-y \
+                remote-lsi-obj-y \
                 common-obj-m \
                 ui-obj-y \
                 ui-obj-m \
diff --git a/Makefile.objs b/Makefile.objs
index abcbd89..c2ac261 100644
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
index 5e91623..e454aae 100644
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
 
 config-target.h: config-target.h-timestamp
@@ -119,6 +124,18 @@ obj-y += disas.o
 obj-$(call notempty,$(TARGET_XML_FILES)) += gdbstub-xml.o
 LIBS := $(libs_cpu) $(LIBS)
 
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += accel/stubs/kvm-stub.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += accel/stubs/tcg-stub.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += accel/stubs/hax-stub.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += accel/stubs/whpx-stub.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += stubs/vl-stub.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += stubs/net-stub.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += stubs/monitor.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += stubs/replay.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += stubs/xen-mapcache.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += stubs/audio.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) += stubs/monitor.o
+
 #########################################################
 # Linux user emulator target
 
@@ -175,6 +192,17 @@ endif # CONFIG_SOFTMMU
 dummy := $(call unnest-vars,,obj-y)
 all-obj-y := $(obj-y)
 
+dummy := $(call unnest-vars,..,remote-pci-tgt-obj-y)
+all-remote-pci-obj-y := $(remote-pci-tgt-obj-y)
+
+all-remote-pci-obj-y += memory.o
+all-remote-pci-obj-y += exec.o
+all-remote-pci-obj-y += ioport.o
+all-remote-pci-obj-y += cpus.o
+
+remote-pci-obj-y :=
+remote-lsi-obj-y :=
+
 include $(SRC_PATH)/Makefile.objs
 dummy := $(call unnest-vars,.., \
                authz-obj-y \
@@ -186,7 +214,10 @@ dummy := $(call unnest-vars,.., \
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
@@ -195,8 +226,19 @@ all-obj-$(CONFIG_USER_ONLY) += $(crypto-user-obj-y)
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
@@ -209,6 +251,13 @@ ifdef CONFIG_DARWIN
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
index f069111..bd52cbc 100644
--- a/backends/Makefile.objs
+++ b/backends/Makefile.objs
@@ -17,3 +17,5 @@ endif
 common-obj-$(call land,$(CONFIG_VHOST_USER),$(CONFIG_VIRTIO)) += vhost-user.o
 
 common-obj-$(CONFIG_LINUX) += hostmem-memfd.o
+
+remote-pci-obj-$(CONFIG_MPQEMU) += hostmem.o
diff --git a/block/Makefile.objs b/block/Makefile.objs
index e394fe0..adcc1b0 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -67,3 +67,5 @@ qcow.o-libs        := -lz
 linux-aio.o-libs   := -laio
 parallels.o-cflags := $(LIBXML2_CFLAGS)
 parallels.o-libs   := $(LIBXML2_LIBS)
+
+remote-pci-obj-$(CONFIG_MPQEMU) += stream.o
diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index ece6cc3..4e28053 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -43,3 +43,10 @@ endif
 
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
index f5f643f..7286fbd 100644
--- a/hw/block/Makefile.objs
+++ b/hw/block/Makefile.objs
@@ -15,3 +15,5 @@ obj-$(CONFIG_VIRTIO_BLK) += virtio-blk.o
 obj-$(CONFIG_VHOST_USER_BLK) += vhost-user-blk.o
 
 obj-y += dataplane/
+
+remote-pci-obj-$(CONFIG_MPQEMU) += block.o cdrom.o hd-geometry.o
diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index fd0550d..9ef6b42 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -28,3 +28,19 @@ common-obj-$(CONFIG_SOFTMMU) += null-machine.o
 obj-$(CONFIG_SOFTMMU) += machine-qmp-cmds.o
 obj-$(CONFIG_SOFTMMU) += numa.o
 common-obj-$(CONFIG_SOFTMMU) += machine-hmp-cmds.o
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
+remote-pci-obj-$(CONFIG_MPQEMU) += numa.o
+remote-pci-obj-$(CONFIG_MPQEMU) += cpu.o
diff --git a/hw/nvram/Makefile.objs b/hw/nvram/Makefile.objs
index 26f7b4c..9802a31 100644
--- a/hw/nvram/Makefile.objs
+++ b/hw/nvram/Makefile.objs
@@ -6,3 +6,5 @@ common-obj-y += chrp_nvram.o
 common-obj-$(CONFIG_MAC_NVRAM) += mac_nvram.o
 obj-$(CONFIG_PSERIES) += spapr_nvram.o
 obj-$(CONFIG_NRF51_SOC) += nrf51_nvm.o
+
+remote-pci-obj-$(CONFIG_MPQEMU) += fw_cfg.o
diff --git a/hw/pci/Makefile.objs b/hw/pci/Makefile.objs
index c78f2fb..955be54 100644
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
index 54b36ed..ef97770 100644
--- a/hw/scsi/Makefile.objs
+++ b/hw/scsi/Makefile.objs
@@ -13,3 +13,5 @@ obj-y += virtio-scsi.o virtio-scsi-dataplane.o
 obj-$(CONFIG_VHOST_SCSI) += vhost-scsi-common.o vhost-scsi.o
 obj-$(CONFIG_VHOST_USER_SCSI) += vhost-scsi-common.o vhost-user-scsi.o
 endif
+
+remote-lsi-obj-$(CONFIG_MPQEMU) += scsi-generic.o scsi-bus.o lsi53c895a.o scsi-disk.o emulation.o
diff --git a/migration/Makefile.objs b/migration/Makefile.objs
index a4f3baf..016b6ab 100644
--- a/migration/Makefile.objs
+++ b/migration/Makefile.objs
@@ -13,3 +13,5 @@ common-obj-$(CONFIG_RDMA) += rdma.o
 common-obj-$(CONFIG_LIVE_BLOCK_MIGRATION) += block.o
 
 rdma.o-libs := $(RDMA_LIBS)
+
+remote-pci-obj-$(CONFIG_MPQEMU) += qemu-file.o vmstate.o qjson.o vmstate-types.o
diff --git a/qom/Makefile.objs b/qom/Makefile.objs
index f9d7735..07e50e5 100644
--- a/qom/Makefile.objs
+++ b/qom/Makefile.objs
@@ -2,3 +2,6 @@ qom-obj-y = object.o container.o qom-qobject.o
 qom-obj-y += object_interfaces.o
 
 common-obj-$(CONFIG_SOFTMMU) += qom-hmp-cmds.o qom-qmp-cmds.o
+
+remote-pci-obj-$(CONFIG_MPQEMU) += object.o qom-qobject.o container.o
+remote-pci-obj-$(CONFIG_MPQEMU) += object_interfaces.o
diff --git a/remote/Makefile.objs b/remote/Makefile.objs
new file mode 100644
index 0000000..a9b2256
--- /dev/null
+++ b/remote/Makefile.objs
@@ -0,0 +1 @@
+remote-pci-obj-$(CONFIG_MPQEMU) += remote-main.o
diff --git a/remote/remote-main.c b/remote/remote-main.c
new file mode 100644
index 0000000..cccad12
--- /dev/null
+++ b/remote/remote-main.c
@@ -0,0 +1,37 @@
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
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+
+#include <stdio.h>
+
+#include "qemu/module.h"
+
+int main(int argc, char *argv[])
+{
+    module_call_init(MODULE_INIT_QOM);
+
+    return 0;
+}
diff --git a/stubs/replay.c b/stubs/replay.c
index c0b51cb..4a966ff 100644
--- a/stubs/replay.c
+++ b/stubs/replay.c
@@ -93,3 +93,7 @@ int replay_get_instructions(void)
 void replay_account_executed_instructions(void)
 {
 }
+
+void replay_add_blocker(Error *reason)
+{
+}
-- 
1.8.3.1


