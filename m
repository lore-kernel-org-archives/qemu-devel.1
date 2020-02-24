Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACF1C38BE2
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:02:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98FA121556
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nidLenEi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98FA121556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Krr-0007Dz-MD
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 16:02:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50136)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1j6Km3-00060C-0d
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1j6Km0-0002vH-NG
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:18 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:52644)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1j6Km0-0002st-EA
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:16 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKrwDv164267;
 Mon, 24 Feb 2020 20:56:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references : mime-version : content-type : content-transfer-encoding;
 s=corp-2020-01-29; bh=2Sv8kRe5boqvpwqshlB2kRRqiGqW/uKXB3bGdhdbmAc=;
 b=nidLenEia59pAf2iac/0/eI/+SQxiqrYKgVGzEVYz9voQcws+wrfWSYVZpAtJ+YUyO2R
 b36modhaOOqzWvkCCVIVOdEXhDXd7rxCmFZN1mtrFxl7ZXrOnD70N3O/Y10cWSoTNlFj
 UZHkKhsEdAGJH0j7umCaxnuEGKIVy8XNuQv4Dq81hoSNctaMbMw5jUovJe9+XHMN8BRK
 k7UF/R4YM4seHBuUKYfBak0pfX31WkUZeKqCuEStJYlPliEEtEhVUjBdnnWkvnz1j8+G
 u0e4FwiIQcofzUgj0TKA46aUKQvfdzsyE5CnRHkus4xuQp83Hx7xLGWd/XmOp1OcTXV2 Uw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 2ybvr4p931-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:56:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKqWXP016815;
 Mon, 24 Feb 2020 20:56:08 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3030.oracle.com with ESMTP id 2ybduv6cmh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:56:07 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01OKu4wx029541;
 Mon, 24 Feb 2020 20:56:04 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 24 Feb 2020 12:56:04 -0800
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 06/50] multi-process: build system for remote device process
Date: Mon, 24 Feb 2020 15:54:57 -0500
Message-Id: <6ef9a3f85252c3c2f1b6b69cd19ae2230d69db4a.1582576372.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=1
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240153
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 suspectscore=1 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240153
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by aserp2120.oracle.com id
 01OKrwDv164267
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 141.146.126.78
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

Modify Makefile to support the building of the remote
device process. Implements main() function of remote
device process.

Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
---
 Makefile                |  2 ++
 Makefile.objs           | 26 +++++++++++++++++++++
 Makefile.target         | 61 +++++++++++++++++++++++++++++++++++++++++++=
+++++-
 accel/Makefile.objs     |  2 ++
 backends/Makefile.objs  |  2 ++
 block/Makefile.objs     |  2 ++
 hw/Makefile.objs        |  7 ++++++
 hw/block/Makefile.objs  |  2 ++
 hw/core/Makefile.objs   | 18 +++++++++++++++
 hw/nvram/Makefile.objs  |  2 ++
 hw/pci/Makefile.objs    |  4 ++++
 hw/scsi/Makefile.objs   |  2 ++
 migration/Makefile.objs |  2 ++
 qom/Makefile.objs       |  3 +++
 remote/Makefile.objs    |  1 +
 remote/remote-main.c    | 23 +++++++++++++++++++
 stubs/replay.c          |  4 ++++
 17 files changed, 162 insertions(+), 1 deletion(-)
 create mode 100644 remote/Makefile.objs
 create mode 100644 remote/remote-main.c

diff --git a/Makefile b/Makefile
index 15f8e53..f91dcb9 100644
--- a/Makefile
+++ b/Makefile
@@ -454,6 +454,8 @@ dummy :=3D $(call unnest-vars,, \
                 qom-obj-y \
                 io-obj-y \
                 common-obj-y \
+                remote-pci-obj-y \
+                remote-lsi-obj-y \
                 common-obj-m \
                 trace-obj-y)
=20
diff --git a/Makefile.objs b/Makefile.objs
index 8a1cbe8..c80e107 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -21,6 +21,32 @@ block-obj-$(CONFIG_REPLICATION) +=3D replication.o
=20
 block-obj-m =3D block/
=20
+#########################################################
+# remote-pci-obj-y is common code used by remote devices
+
+remote-pci-obj-$(CONFIG_MPQEMU) +=3D hw/
+remote-pci-obj-$(CONFIG_MPQEMU) +=3D qom/
+remote-pci-obj-$(CONFIG_MPQEMU) +=3D backends/
+remote-pci-obj-$(CONFIG_MPQEMU) +=3D block/
+remote-pci-obj-$(CONFIG_MPQEMU) +=3D migration/
+remote-pci-obj-$(CONFIG_MPQEMU) +=3D remote/
+remote-pci-obj-$(CONFIG_MPQEMU) +=3D accel/
+
+remote-pci-obj-$(CONFIG_MPQEMU) +=3D cpus-common.o
+remote-pci-obj-$(CONFIG_MPQEMU) +=3D dma-helpers.o
+remote-pci-obj-$(CONFIG_MPQEMU) +=3D blockdev.o
+remote-pci-obj-$(CONFIG_MPQEMU) +=3D qdev-monitor.o
+remote-pci-obj-$(CONFIG_MPQEMU) +=3D bootdevice.o
+remote-pci-obj-$(CONFIG_MPQEMU) +=3D iothread.o
+
+##############################################################
+# remote-lsi-obj-y is code used to implement remote LSI device
+
+remote-lsi-obj-$(CONFIG_MPQEMU) +=3D hw/
+
+#######################################################################
+# crypto-obj-y is code used by both qemu system emulation and qemu-img
+
 crypto-obj-y =3D crypto/
=20
 io-obj-y =3D io/
diff --git a/Makefile.target b/Makefile.target
index 2d43dc5..375fdaa 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -36,7 +36,17 @@ QEMU_PROG_BUILD =3D $(QEMU_PROG)
 endif
 endif
=20
+ifdef CONFIG_MPQEMU
+SCSI_DEV_PROG=3Dqemu-scsi-dev
+SCSI_DEV_BUILD =3D $(SCSI_DEV_PROG)
+endif
+
 PROGS=3D$(QEMU_PROG) $(QEMU_PROGW)
+
+ifeq ($(TARGET_NAME)-$(CONFIG_MPQEMU)-$(CONFIG_USER_ONLY), x86_64-y-)
+PROGS +=3D $(SCSI_DEV_PROG)
+endif
+
 STPFILES=3D
=20
 config-target.h: config-target.h-timestamp
@@ -121,6 +131,20 @@ LIBS :=3D $(libs_cpu) $(LIBS)
=20
 obj-$(CONFIG_PLUGIN) +=3D plugins/
=20
+ifeq ($(TARGET_NAME)-$(CONFIG_MPQEMU)-$(CONFIG_USER_ONLY), x86_64-y-)
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) +=3D accel/stubs/kvm-stub.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) +=3D accel/stubs/tcg-stub.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) +=3D accel/stubs/hax-stub.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) +=3D accel/stubs/whpx-stub.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) +=3D stubs/vl-stub.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) +=3D stubs/net-stub.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) +=3D stubs/monitor.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) +=3D stubs/replay.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) +=3D stubs/xen-mapcache.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) +=3D stubs/audio.o
+remote-pci-tgt-obj-$(CONFIG_MPQEMU) +=3D stubs/monitor.o
+endif
+
 #########################################################
 # Linux user emulator target
=20
@@ -178,6 +202,20 @@ endif # CONFIG_SOFTMMU
 dummy :=3D $(call unnest-vars,,obj-y)
 all-obj-y :=3D $(obj-y)
=20
+dummy :=3D $(call unnest-vars,..,remote-pci-tgt-obj-y)
+all-remote-pci-obj-y :=3D $(remote-pci-tgt-obj-y)
+
+ifeq ($(TARGET_NAME)-$(CONFIG_MPQEMU)-$(CONFIG_USER_ONLY), x86_64-y-)
+all-remote-pci-obj-y +=3D memory.o
+all-remote-pci-obj-y +=3D exec.o
+all-remote-pci-obj-y +=3D exec-vary.o
+all-remote-pci-obj-y +=3D ioport.o
+all-remote-pci-obj-y +=3D cpus.o
+endif
+
+remote-pci-obj-y :=3D
+remote-lsi-obj-y :=3D
+
 include $(SRC_PATH)/Makefile.objs
 dummy :=3D $(call unnest-vars,.., \
                authz-obj-y \
@@ -188,7 +226,10 @@ dummy :=3D $(call unnest-vars,.., \
                qom-obj-y \
                io-obj-y \
                common-obj-y \
-               common-obj-m)
+               common-obj-m \
+               remote-pci-obj-y \
+               remote-lsi-obj-y)
+
 all-obj-y +=3D $(common-obj-y)
 all-obj-y +=3D $(qom-obj-y)
 all-obj-$(CONFIG_SOFTMMU) +=3D $(authz-obj-y)
@@ -196,8 +237,19 @@ all-obj-$(CONFIG_SOFTMMU) +=3D $(block-obj-y) $(char=
dev-obj-y)
 all-obj-$(CONFIG_SOFTMMU) +=3D $(crypto-obj-y)
 all-obj-$(CONFIG_SOFTMMU) +=3D $(io-obj-y)
=20
+all-remote-pci-obj-y +=3D $(authz-obj-y)
+all-remote-pci-obj-y +=3D $(block-obj-y)
+all-remote-pci-obj-y +=3D $(crypto-obj-y)
+all-remote-pci-obj-y +=3D $(io-obj-y)
+all-remote-pci-obj-y +=3D $(chardev-obj-y)
+all-remote-pci-obj-y +=3D $(remote-pci-obj-y)
+
+
+all-remote-lsi-obj-y +=3D $(all-remote-pci-obj-y) $(remote-lsi-obj-y)
+
 ifdef CONFIG_SOFTMMU
 $(QEMU_PROG_BUILD): config-devices.mak
+$(SCSI_DEV_BUILD): config-devices.mak
 endif
=20
 COMMON_LDADDS =3D ../libqemuutil.a
@@ -210,6 +262,13 @@ ifdef CONFIG_DARWIN
 	$(call quiet-command,SetFile -a C $@,"SETFILE","$(TARGET_DIR)$@")
 endif
=20
+$(SCSI_DEV_BUILD): $(all-remote-lsi-obj-y) $(COMMON_LDADDS)
+	$(call LINK, $(filter-out %.mak, $^))
+ifdef CONFIG_DARWIN
+	$(call quiet-command,Rez -append $(SRC_PATH)/pc-bios/qemu.rsrc -o $@,"R=
EZ","$(TARGET_DIR)$@")
+	$(call quiet-command,SetFile -a C $@,"SETFILE","$(TARGET_DIR)$@")
+endif
+
 gdbstub-xml.c: $(TARGET_XML_FILES) $(SRC_PATH)/scripts/feature_to_c.sh
 	$(call quiet-command,rm -f $@ && $(SHELL) $(SRC_PATH)/scripts/feature_t=
o_c.sh $@ $(TARGET_XML_FILES),"GEN","$(TARGET_DIR)$@")
=20
diff --git a/accel/Makefile.objs b/accel/Makefile.objs
index 17e5ac6..e312dd4 100644
--- a/accel/Makefile.objs
+++ b/accel/Makefile.objs
@@ -3,3 +3,5 @@ obj-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_POSIX)) +=3D q=
test.o
 obj-$(CONFIG_KVM) +=3D kvm/
 obj-$(CONFIG_TCG) +=3D tcg/
 obj-y +=3D stubs/
+
+remote-pci-obj-$(CONFIG_MPQEMU) +=3D accel.o
diff --git a/backends/Makefile.objs b/backends/Makefile.objs
index 28a847c..947cde3 100644
--- a/backends/Makefile.objs
+++ b/backends/Makefile.objs
@@ -21,3 +21,5 @@ common-obj-$(CONFIG_LINUX) +=3D hostmem-memfd.o
 common-obj-$(CONFIG_GIO) +=3D dbus-vmstate.o
 dbus-vmstate.o-cflags =3D $(GIO_CFLAGS)
 dbus-vmstate.o-libs =3D $(GIO_LIBS)
+
+remote-pci-obj-$(CONFIG_MPQEMU) +=3D hostmem.o
diff --git a/block/Makefile.objs b/block/Makefile.objs
index 3bcb35c..6398613 100644
--- a/block/Makefile.objs
+++ b/block/Makefile.objs
@@ -71,3 +71,5 @@ io_uring.o-cflags  :=3D $(LINUX_IO_URING_CFLAGS)
 io_uring.o-libs    :=3D $(LINUX_IO_URING_LIBS)
 parallels.o-cflags :=3D $(LIBXML2_CFLAGS)
 parallels.o-libs   :=3D $(LIBXML2_LIBS)
+
+remote-pci-obj-$(CONFIG_MPQEMU) +=3D stream.o
diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 660e2b4..af9235b 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -44,3 +44,10 @@ endif
=20
 common-obj-y +=3D $(devices-dirs-y)
 obj-y +=3D $(devices-dirs-y)
+
+remote-pci-obj-$(CONFIG_MPQEMU) +=3D core/
+remote-pci-obj-$(CONFIG_MPQEMU) +=3D block/
+remote-pci-obj-$(CONFIG_MPQEMU) +=3D pci/
+remote-pci-obj-$(CONFIG_MPQEMU) +=3D nvram/
+
+remote-lsi-obj-$(CONFIG_MPQEMU) +=3D scsi/
diff --git a/hw/block/Makefile.objs b/hw/block/Makefile.objs
index 4b4a2b3..0b4644f 100644
--- a/hw/block/Makefile.objs
+++ b/hw/block/Makefile.objs
@@ -16,3 +16,5 @@ obj-$(CONFIG_VIRTIO_BLK) +=3D virtio-blk.o
 obj-$(CONFIG_VHOST_USER_BLK) +=3D vhost-user-blk.o
=20
 obj-y +=3D dataplane/
+
+remote-pci-obj-$(CONFIG_MPQEMU) +=3D block.o cdrom.o hd-geometry.o
diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index 6215e7c..e3e8084 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -31,3 +31,21 @@ common-obj-$(CONFIG_OR_IRQ) +=3D or-irq.o
 common-obj-$(CONFIG_SPLIT_IRQ) +=3D split-irq.o
 common-obj-$(CONFIG_PLATFORM_BUS) +=3D platform-bus.o
 common-obj-$(CONFIG_GENERIC_LOADER) +=3D generic-loader.o
+
+remote-pci-obj-$(CONFIG_MPQEMU) +=3D qdev-properties.o
+remote-pci-obj-$(CONFIG_MPQEMU) +=3D qdev.o
+remote-pci-obj-$(CONFIG_MPQEMU) +=3D bus.o
+remote-pci-obj-$(CONFIG_MPQEMU) +=3D irq.o
+remote-pci-obj-$(CONFIG_MPQEMU) +=3D hotplug.o
+remote-pci-obj-$(CONFIG_MPQEMU) +=3D machine.o
+remote-pci-obj-$(CONFIG_MPQEMU) +=3D fw-path-provider.o
+remote-pci-obj-$(CONFIG_MPQEMU) +=3D reset.o
+remote-pci-obj-$(CONFIG_MPQEMU) +=3D sysbus.o
+remote-pci-obj-$(CONFIG_MPQEMU) +=3D loader.o
+remote-pci-obj-$(CONFIG_MPQEMU) +=3D nmi.o
+remote-pci-obj-$(CONFIG_MPQEMU) +=3D qdev-properties-system.o
+remote-pci-obj-$(CONFIG_MPQEMU) +=3D qdev-fw.o
+remote-pci-obj-$(CONFIG_MPQEMU) +=3D numa.o
+remote-pci-obj-$(CONFIG_MPQEMU) +=3D cpu.o
+remote-pci-obj-$(CONFIG_MPQEMU) +=3D vmstate-if.o
+remote-pci-obj-$(CONFIG_MPQEMU) +=3D resettable.o
diff --git a/hw/nvram/Makefile.objs b/hw/nvram/Makefile.objs
index f3ad921..4d2d809 100644
--- a/hw/nvram/Makefile.objs
+++ b/hw/nvram/Makefile.objs
@@ -6,3 +6,5 @@ common-obj-$(CONFIG_CHRP_NVRAM) +=3D chrp_nvram.o
 common-obj-$(CONFIG_MAC_NVRAM) +=3D mac_nvram.o
 common-obj-$(CONFIG_NRF51_SOC) +=3D nrf51_nvm.o
 obj-$(CONFIG_PSERIES) +=3D spapr_nvram.o
+
+remote-pci-obj-$(CONFIG_MPQEMU) +=3D fw_cfg.o
diff --git a/hw/pci/Makefile.objs b/hw/pci/Makefile.objs
index c78f2fb..955be54 100644
--- a/hw/pci/Makefile.objs
+++ b/hw/pci/Makefile.objs
@@ -12,3 +12,7 @@ common-obj-$(CONFIG_PCI_EXPRESS) +=3D pcie_port.o pcie_=
host.o
=20
 common-obj-$(call lnot,$(CONFIG_PCI)) +=3D pci-stub.o
 common-obj-$(CONFIG_ALL) +=3D pci-stub.o
+
+remote-pci-obj-$(CONFIG_MPQEMU) +=3D pci.o pci_bridge.o
+remote-pci-obj-$(CONFIG_MPQEMU) +=3D msi.o msix.o
+remote-pci-obj-$(CONFIG_MPQEMU) +=3D pcie.o
diff --git a/hw/scsi/Makefile.objs b/hw/scsi/Makefile.objs
index 54b36ed..ef97770 100644
--- a/hw/scsi/Makefile.objs
+++ b/hw/scsi/Makefile.objs
@@ -13,3 +13,5 @@ obj-y +=3D virtio-scsi.o virtio-scsi-dataplane.o
 obj-$(CONFIG_VHOST_SCSI) +=3D vhost-scsi-common.o vhost-scsi.o
 obj-$(CONFIG_VHOST_USER_SCSI) +=3D vhost-scsi-common.o vhost-user-scsi.o
 endif
+
+remote-lsi-obj-$(CONFIG_MPQEMU) +=3D scsi-generic.o scsi-bus.o lsi53c895=
a.o scsi-disk.o emulation.o
diff --git a/migration/Makefile.objs b/migration/Makefile.objs
index d3623d5..e7cdc76 100644
--- a/migration/Makefile.objs
+++ b/migration/Makefile.objs
@@ -14,3 +14,5 @@ common-obj-$(CONFIG_RDMA) +=3D rdma.o
 common-obj-$(CONFIG_LIVE_BLOCK_MIGRATION) +=3D block.o
=20
 rdma.o-libs :=3D $(RDMA_LIBS)
+
+remote-pci-obj-$(CONFIG_MPQEMU) +=3D qemu-file.o vmstate.o qjson.o vmsta=
te-types.o
diff --git a/qom/Makefile.objs b/qom/Makefile.objs
index f9d7735..07e50e5 100644
--- a/qom/Makefile.objs
+++ b/qom/Makefile.objs
@@ -2,3 +2,6 @@ qom-obj-y =3D object.o container.o qom-qobject.o
 qom-obj-y +=3D object_interfaces.o
=20
 common-obj-$(CONFIG_SOFTMMU) +=3D qom-hmp-cmds.o qom-qmp-cmds.o
+
+remote-pci-obj-$(CONFIG_MPQEMU) +=3D object.o qom-qobject.o container.o
+remote-pci-obj-$(CONFIG_MPQEMU) +=3D object_interfaces.o
diff --git a/remote/Makefile.objs b/remote/Makefile.objs
new file mode 100644
index 0000000..a9b2256
--- /dev/null
+++ b/remote/Makefile.objs
@@ -0,0 +1 @@
+remote-pci-obj-$(CONFIG_MPQEMU) +=3D remote-main.o
diff --git a/remote/remote-main.c b/remote/remote-main.c
new file mode 100644
index 0000000..7c0764a
--- /dev/null
+++ b/remote/remote-main.c
@@ -0,0 +1,23 @@
+/*
+ * Remote device initialization
+ *
+ * Copyright =C2=A9 2018, 2020 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
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
index 2e3feee..9b53c0c 100644
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
--=20
1.8.3.1


