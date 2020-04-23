Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B4EC2BA19
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 04:29:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79DA42071C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 04:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wiFRkpIG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79DA42071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRTUF-0007Mw-MM
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 00:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50372)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jRTIC-0003FO-8R
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:16:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jRTIB-0002PT-0D
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:16:52 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40262)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jRTIA-0002M8-EN
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:16:50 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03N4CmWO051965;
 Thu, 23 Apr 2020 04:16:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=fIh/1i+zeXVKv46AyzemjOQecsfTQY2sswmXA9bhg/w=;
 b=wiFRkpIG+b0Va3hOe0vNi9+1UlfBK5yga97f3Y+W2shwvdN8l1xmpk9XsCWhzHS8DMoX
 EZYtsnlyrCkGOWQAoaKhyALntDvdZ9aSOX9mTOAjncTcPSzdkZwEqzz927pOSaOAFHQR
 nL6R9edI6ddGvWWzcR+EVnFY27+37mnn1/qs7AMJJ+gmuiy6usTEzrIJRVrpYvrZ4YzM
 Q6JxZGtSxzNOxG5sZJLYxXrwbQfXJ00j6yPVKCwrQUPV1a3VNoMQR7idRxOqBHaj67Fm
 BqiK86oyyfENocoOIIhtulCwc8777805vKFM7UCzbEy2zsKHOnVcjfZZlrP/4EvIzUMN hw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 30jhyc545u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2020 04:16:43 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03N4CZCc156935;
 Thu, 23 Apr 2020 04:14:42 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3020.oracle.com with ESMTP id 30gbbjtwwm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2020 04:14:42 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03N4EewI020191;
 Thu, 23 Apr 2020 04:14:40 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 22 Apr 2020 21:14:39 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v6 10/36] multi-process: build system for remote device
 process
Date: Wed, 22 Apr 2020 21:13:45 -0700
Message-Id: <622e5b5a9408c1e0bee41cd75a792ff784fc2874.1587614626.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <cover.1587614626.git.elena.ufimtseva@oracle.com>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9599
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0
 suspectscore=1 mlxlogscore=999 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004230027
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9599
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0 mlxscore=0
 clxscore=1015 suspectscore=1 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004230027
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=elena.ufimtseva@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 00:14:40
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, thanos.makatos@nutanix.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
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
 MAINTAINERS             |  8 ++++++
 Makefile                |  2 ++
 Makefile.objs           | 27 ++++++++++++++++++
 Makefile.target         | 61 ++++++++++++++++++++++++++++++++++++++++-
 accel/Makefile.objs     |  2 ++
 backends/Makefile.objs  |  2 ++
 block/Makefile.objs     |  2 ++
 hw/Makefile.objs        |  7 +++++
 hw/block/Makefile.objs  |  2 ++
 hw/core/Makefile.objs   | 18 ++++++++++++
 hw/nvram/Makefile.objs  |  2 ++
 hw/pci/Makefile.objs    |  4 +++
 hw/scsi/Makefile.objs   |  2 ++
 migration/Makefile.objs |  2 ++
 qom/Makefile.objs       |  3 ++
 remote/Makefile.objs    |  1 +
 remote/remote-main.c    | 23 ++++++++++++++++
 stubs/replay.c          |  4 +++
 18 files changed, 171 insertions(+), 1 deletion(-)
 create mode 100644 remote/Makefile.objs
 create mode 100644 remote/remote-main.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c5fba124e4..965f34d4f9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2850,6 +2850,14 @@ S: Maintained
 F: hw/semihosting/
 F: include/hw/semihosting/
 
+Multi-process QEMU
+M: Jagannathan Raman <jag.raman@oracle.com>
+M: Elena Ufimtseva <elena.ufimtseva@oracle.com>
+M: John G Johnson <john.g.johnson@oracle.com>
+S: Maintained
+F: remote/Makefile.objs
+F: remote/remote-main.c
+
 Build and test automation
 -------------------------
 Build and test automation
diff --git a/Makefile b/Makefile
index 8a9113e666..69337d6f8c 100644
--- a/Makefile
+++ b/Makefile
@@ -474,6 +474,8 @@ dummy := $(call unnest-vars,, \
                 qom-obj-y \
                 io-obj-y \
                 common-obj-y \
+                remote-pci-obj-y \
+                remote-lsi-obj-y \
                 common-obj-m \
                 trace-obj-y)
 
diff --git a/Makefile.objs b/Makefile.objs
index f29c60c59d..f6654633b4 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -21,6 +21,33 @@ block-obj-$(CONFIG_REPLICATION) += replication.o
 
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
+remote-pci-obj-$(CONFIG_MPQEMU) += accel/
+
+remote-pci-obj-$(CONFIG_MPQEMU) += cpus-common.o
+remote-pci-obj-$(CONFIG_MPQEMU) += dma-helpers.o
+remote-pci-obj-$(CONFIG_MPQEMU) += blockdev.o
+remote-pci-obj-$(CONFIG_MPQEMU) += qdev-monitor.o
+remote-pci-obj-$(CONFIG_MPQEMU) += bootdevice.o
+remote-pci-obj-$(CONFIG_MPQEMU) += iothread.o
+remote-pci-obj-$(CONFIG_MPQEMU) += qemu-parse.o
+
+##############################################################
+# remote-lsi-obj-y is code used to implement remote LSI device
+
+remote-lsi-obj-$(CONFIG_MPQEMU) += hw/
+
+#######################################################################
+# crypto-obj-y is code used by both qemu system emulation and qemu-img
+
 crypto-obj-y = crypto/
 
 io-obj-y = io/
diff --git a/Makefile.target b/Makefile.target
index 8ed1eba95b..70fa1eeca5 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -36,7 +36,17 @@ QEMU_PROG_BUILD = $(QEMU_PROG)
 endif
 endif
 
+ifdef CONFIG_MPQEMU
+SCSI_DEV_PROG=qemu-scsi-dev
+SCSI_DEV_BUILD = $(SCSI_DEV_PROG)
+endif
+
 PROGS=$(QEMU_PROG) $(QEMU_PROGW)
+
+ifeq ($(TARGET_NAME)-$(CONFIG_MPQEMU)-$(CONFIG_USER_ONLY), x86_64-y-)
+PROGS += $(SCSI_DEV_PROG)
+endif
+
 STPFILES=
 
 config-target.h: config-target.h-timestamp
@@ -121,6 +131,20 @@ LIBS := $(libs_cpu) $(LIBS)
 
 obj-$(CONFIG_PLUGIN) += plugins/
 
+ifeq ($(TARGET_NAME)-$(CONFIG_MPQEMU)-$(CONFIG_USER_ONLY), x86_64-y-)
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
+endif
+
 #########################################################
 # Linux user emulator target
 
@@ -179,6 +203,20 @@ endif # CONFIG_SOFTMMU
 dummy := $(call unnest-vars,,obj-y)
 all-obj-y := $(obj-y)
 
+dummy := $(call unnest-vars,..,remote-pci-tgt-obj-y)
+all-remote-pci-obj-y := $(remote-pci-tgt-obj-y)
+
+ifeq ($(TARGET_NAME)-$(CONFIG_MPQEMU)-$(CONFIG_USER_ONLY), x86_64-y-)
+all-remote-pci-obj-y += memory.o
+all-remote-pci-obj-y += exec.o
+all-remote-pci-obj-y += exec-vary.o
+all-remote-pci-obj-y += ioport.o
+all-remote-pci-obj-y += cpus.o
+endif
+
+remote-pci-obj-y :=
+remote-lsi-obj-y :=
+
 include $(SRC_PATH)/Makefile.objs
 dummy := $(call unnest-vars,.., \
                authz-obj-y \
@@ -189,7 +227,10 @@ dummy := $(call unnest-vars,.., \
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
@@ -197,8 +238,19 @@ all-obj-$(CONFIG_SOFTMMU) += $(block-obj-y) $(chardev-obj-y)
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
@@ -211,6 +263,13 @@ ifdef CONFIG_DARWIN
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
 
diff --git a/accel/Makefile.objs b/accel/Makefile.objs
index 17e5ac6061..e312dd4f01 100644
--- a/accel/Makefile.objs
+++ b/accel/Makefile.objs
@@ -3,3 +3,5 @@ obj-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_POSIX)) += qtest.o
 obj-$(CONFIG_KVM) += kvm/
 obj-$(CONFIG_TCG) += tcg/
 obj-y += stubs/
+
+remote-pci-obj-$(CONFIG_MPQEMU) += accel.o
diff --git a/backends/Makefile.objs b/backends/Makefile.objs
index 28a847cd57..947cde39ac 100644
--- a/backends/Makefile.objs
+++ b/backends/Makefile.objs
@@ -21,3 +21,5 @@ common-obj-$(CONFIG_LINUX) += hostmem-memfd.o
 common-obj-$(CONFIG_GIO) += dbus-vmstate.o
 dbus-vmstate.o-cflags = $(GIO_CFLAGS)
 dbus-vmstate.o-libs = $(GIO_LIBS)
+
+remote-pci-obj-$(CONFIG_MPQEMU) += hostmem.o
diff --git a/block/Makefile.objs b/block/Makefile.objs
index 3635b6b4c1..3e7513967c 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -74,3 +74,5 @@ io_uring.o-cflags  := $(LINUX_IO_URING_CFLAGS)
 io_uring.o-libs    := $(LINUX_IO_URING_LIBS)
 parallels.o-cflags := $(LIBXML2_CFLAGS)
 parallels.o-libs   := $(LIBXML2_LIBS)
+
+remote-pci-obj-$(CONFIG_MPQEMU) += stream.o
diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 660e2b4373..af9235b6f2 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -44,3 +44,10 @@ endif
 
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
index 4b4a2b338d..0b4644f472 100644
--- a/hw/block/Makefile.objs
+++ b/hw/block/Makefile.objs
@@ -16,3 +16,5 @@ obj-$(CONFIG_VIRTIO_BLK) += virtio-blk.o
 obj-$(CONFIG_VHOST_USER_BLK) += vhost-user-blk.o
 
 obj-y += dataplane/
+
+remote-pci-obj-$(CONFIG_MPQEMU) += block.o cdrom.o hd-geometry.o
diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index 6215e7c208..e3e80848c8 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -31,3 +31,21 @@ common-obj-$(CONFIG_OR_IRQ) += or-irq.o
 common-obj-$(CONFIG_SPLIT_IRQ) += split-irq.o
 common-obj-$(CONFIG_PLATFORM_BUS) += platform-bus.o
 common-obj-$(CONFIG_GENERIC_LOADER) += generic-loader.o
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
+remote-pci-obj-$(CONFIG_MPQEMU) += vmstate-if.o
+remote-pci-obj-$(CONFIG_MPQEMU) += resettable.o
diff --git a/hw/nvram/Makefile.objs b/hw/nvram/Makefile.objs
index f3ad921382..4d2d809106 100644
--- a/hw/nvram/Makefile.objs
+++ b/hw/nvram/Makefile.objs
@@ -6,3 +6,5 @@ common-obj-$(CONFIG_CHRP_NVRAM) += chrp_nvram.o
 common-obj-$(CONFIG_MAC_NVRAM) += mac_nvram.o
 common-obj-$(CONFIG_NRF51_SOC) += nrf51_nvm.o
 obj-$(CONFIG_PSERIES) += spapr_nvram.o
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
index 0fc619e380..ad33d77d0b 100644
--- a/migration/Makefile.objs
+++ b/migration/Makefile.objs
@@ -16,3 +16,5 @@ common-obj-$(CONFIG_RDMA) += rdma.o
 common-obj-$(CONFIG_LIVE_BLOCK_MIGRATION) += block.o
 
 rdma.o-libs := $(RDMA_LIBS)
+
+remote-pci-obj-$(CONFIG_MPQEMU) += qemu-file.o vmstate.o qjson.o vmstate-types.o
diff --git a/qom/Makefile.objs b/qom/Makefile.objs
index 1b45d104ba..7e9455db90 100644
--- a/qom/Makefile.objs
+++ b/qom/Makefile.objs
@@ -3,3 +3,6 @@ qom-obj-y += object_interfaces.o
 
 common-obj-$(CONFIG_SOFTMMU) += qom-hmp-cmds.o qom-qmp-cmds.o
 storage-daemon-obj-y += qom-qmp-cmds.o
+
+remote-pci-obj-$(CONFIG_MPQEMU) += object.o qom-qobject.o container.o
+remote-pci-obj-$(CONFIG_MPQEMU) += object_interfaces.o
diff --git a/remote/Makefile.objs b/remote/Makefile.objs
new file mode 100644
index 0000000000..a9b2256b2a
--- /dev/null
+++ b/remote/Makefile.objs
@@ -0,0 +1 @@
+remote-pci-obj-$(CONFIG_MPQEMU) += remote-main.o
diff --git a/remote/remote-main.c b/remote/remote-main.c
new file mode 100644
index 0000000000..7c0764ad01
--- /dev/null
+++ b/remote/remote-main.c
@@ -0,0 +1,23 @@
+/*
+ * Remote device initialization
+ *
+ * Copyright © 2018, 2020 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
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
index 2e3feee6a9..9b53c0cb37 100644
--- a/stubs/replay.c
+++ b/stubs/replay.c
@@ -102,3 +102,7 @@ int replay_get_instructions(void)
 void replay_account_executed_instructions(void)
 {
 }
+
+void replay_add_blocker(Error *reason)
+{
+}
-- 
2.25.GIT


