Return-Path: <SRS0=tUBQ=3B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F06C32771
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2020 11:32:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BB9B21744
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2020 11:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DcqaOokW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BB9B21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iqbTm-0001td-6G
	for qemu-devel@archiver.kernel.org; Sun, 12 Jan 2020 06:32:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43272)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iqbQL-0006T2-5t
 for qemu-devel@nongnu.org; Sun, 12 Jan 2020 06:28:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iqbQH-0000GP-5p
 for qemu-devel@nongnu.org; Sun, 12 Jan 2020 06:28:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38243
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iqbQH-0000Dv-0G
 for qemu-devel@nongnu.org; Sun, 12 Jan 2020 06:28:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578828528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9FaomDScvjIUiNzda8qqtM0z4tolgLwOSvY1XoYwel8=;
 b=DcqaOokWjnn/GLR6WiVZblpK5FxfQnBFujr0yND9z8DLrG6tCSFa7lhSj/QbjsozWCOUF/
 CuXdwdGQXYSkhx5K5abvd2E227Ku7yHkfWJSth9xq+x7Jbef0hNwK94JrqGP7+TBxVS1fL
 AVGp/9LghxVAMKCGEi5RYkolxyU0SzI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-SxOUq_MPMLqm5wvQyaLpWw-1; Sun, 12 Jan 2020 06:28:46 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B41A800D41;
 Sun, 12 Jan 2020 11:28:45 +0000 (UTC)
Received: from thuth.com (ovpn-116-70.ams2.redhat.com [10.36.116.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F13C187EDF;
 Sun, 12 Jan 2020 11:28:43 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL v2 6/8] tests/Makefile: Move qtest-related settings to a
 separate Makefile.include
Date: Sun, 12 Jan 2020 12:28:32 +0100
Message-Id: <20200112112832.9450-4-thuth@redhat.com>
In-Reply-To: <20200112112832.9450-1-thuth@redhat.com>
References: <20200112112832.9450-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: SxOUq_MPMLqm5wvQyaLpWw-1
X-Mimecast-Spam-Score: 0
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

tests/Makefile.include is pretty much overcrowded. Now that we have a
dedicated folder for the qtests, let's move the related settings
to a Makefile.include file in that directory instead.

Message-Id: <20191218103059.11729-7-thuth@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/Makefile.include       | 319 +----------------------------------
 tests/qtest/Makefile.include | 318 ++++++++++++++++++++++++++++++++++
 2 files changed, 319 insertions(+), 318 deletions(-)
 create mode 100644 tests/qtest/Makefile.include

diff --git a/tests/Makefile.include b/tests/Makefile.include
index bd2bcd6f1b..065fd09964 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -149,164 +149,6 @@ check-unit-y +=3D tests/test-qapi-util$(EXESUF)
=20
 check-block-$(call land,$(CONFIG_POSIX),$(CONFIG_SOFTMMU)) +=3D tests/chec=
k-block.sh
=20
-# All QTests for now are POSIX-only, but the dependencies are
-# really in libqtest, not in the testcases themselves.
-
-check-qtest-generic-y +=3D qmp-test
-check-qtest-generic-y +=3D qmp-cmd-test
-check-qtest-generic-$(CONFIG_MODULES) +=3D modules-test
-
-check-qtest-generic-y +=3D device-introspect-test
-check-qtest-generic-y +=3D cdrom-test
-
-DBUS_DAEMON :=3D $(shell which dbus-daemon 2>/dev/null)
-ifneq ($(GDBUS_CODEGEN),)
-ifneq ($(DBUS_DAEMON),)
-check-qtest-pci-$(CONFIG_GIO) +=3D dbus-vmstate-test
-endif
-endif
-
-check-qtest-pci-$(CONFIG_RTL8139_PCI) +=3D rtl8139-test
-check-qtest-pci-$(CONFIG_VGA) +=3D display-vga-test
-check-qtest-pci-$(CONFIG_HDA) +=3D intel-hda-test
-check-qtest-pci-$(CONFIG_IVSHMEM_DEVICE) +=3D ivshmem-test
-
-check-qtest-i386-$(CONFIG_ISA_TESTDEV) =3D endianness-test
-check-qtest-i386-y +=3D fdc-test
-check-qtest-i386-y +=3D ide-test
-check-qtest-i386-$(CONFIG_TOOLS) +=3D ahci-test
-check-qtest-i386-y +=3D hd-geo-test
-check-qtest-i386-y +=3D boot-order-test
-check-qtest-i386-y +=3D bios-tables-test
-check-qtest-i386-$(CONFIG_SGA) +=3D boot-serial-test
-check-qtest-i386-$(CONFIG_SLIRP) +=3D pxe-test
-check-qtest-i386-y +=3D rtc-test
-check-qtest-i386-$(CONFIG_ISA_IPMI_KCS) +=3D ipmi-kcs-test
-ifdef CONFIG_LINUX
-check-qtest-i386-$(CONFIG_ISA_IPMI_BT) +=3D ipmi-bt-test
-endif
-check-qtest-i386-y +=3D i440fx-test
-check-qtest-i386-y +=3D fw_cfg-test
-check-qtest-i386-y +=3D device-plug-test
-check-qtest-i386-y +=3D drive_del-test
-check-qtest-i386-$(CONFIG_WDT_IB700) +=3D wdt_ib700-test
-check-qtest-i386-y +=3D tco-test
-check-qtest-i386-y +=3D $(check-qtest-pci-y)
-check-qtest-i386-$(CONFIG_PVPANIC) +=3D pvpanic-test
-check-qtest-i386-$(CONFIG_I82801B11) +=3D i82801b11-test
-check-qtest-i386-$(CONFIG_IOH3420) +=3D ioh3420-test
-check-qtest-i386-$(CONFIG_USB_UHCI) +=3D usb-hcd-uhci-test
-check-qtest-i386-$(call land,$(CONFIG_USB_EHCI),$(CONFIG_USB_UHCI)) +=3D u=
sb-hcd-ehci-test
-check-qtest-i386-$(CONFIG_USB_XHCI_NEC) +=3D usb-hcd-xhci-test
-check-qtest-i386-y +=3D cpu-plug-test
-check-qtest-i386-y +=3D q35-test
-check-qtest-i386-y +=3D vmgenid-test
-check-qtest-i386-$(CONFIG_TPM_CRB) +=3D tpm-crb-swtpm-test
-check-qtest-i386-$(CONFIG_TPM_CRB) +=3D tpm-crb-test
-check-qtest-i386-$(CONFIG_TPM_TIS) +=3D tpm-tis-swtpm-test
-check-qtest-i386-$(CONFIG_TPM_TIS) +=3D tpm-tis-test
-check-qtest-i386-$(CONFIG_SLIRP) +=3D test-netfilter
-check-qtest-i386-$(CONFIG_POSIX) +=3D test-filter-mirror
-check-qtest-i386-$(CONFIG_RTL8139_PCI) +=3D test-filter-redirector
-check-qtest-i386-y +=3D migration-test
-check-qtest-i386-y +=3D test-x86-cpuid-compat
-check-qtest-i386-y +=3D numa-test
-
-check-qtest-x86_64-y +=3D $(check-qtest-i386-y)
-
-check-qtest-alpha-y +=3D boot-serial-test
-check-qtest-alpha-$(CONFIG_VGA) +=3D display-vga-test
-
-check-qtest-hppa-y +=3D boot-serial-test
-check-qtest-hppa-$(CONFIG_VGA) +=3D display-vga-test
-
-check-qtest-m68k-y =3D boot-serial-test
-
-check-qtest-microblaze-y +=3D boot-serial-test
-
-check-qtest-mips-$(CONFIG_ISA_TESTDEV) =3D endianness-test
-check-qtest-mips-$(CONFIG_VGA) +=3D display-vga-test
-
-check-qtest-mips64-$(CONFIG_ISA_TESTDEV) =3D endianness-test
-check-qtest-mips64-$(CONFIG_VGA) +=3D display-vga-test
-
-check-qtest-mips64el-$(CONFIG_ISA_TESTDEV) =3D endianness-test
-check-qtest-mips64el-$(CONFIG_VGA) +=3D display-vga-test
-
-check-qtest-moxie-y +=3D boot-serial-test
-
-check-qtest-ppc-$(CONFIG_ISA_TESTDEV) =3D endianness-test
-check-qtest-ppc-y +=3D boot-order-test
-check-qtest-ppc-y +=3D prom-env-test
-check-qtest-ppc-y +=3D drive_del-test
-check-qtest-ppc-y +=3D boot-serial-test
-check-qtest-ppc-$(CONFIG_M48T59) +=3D m48t59-test
-
-check-qtest-ppc64-y +=3D $(check-qtest-ppc-y)
-check-qtest-ppc64-$(CONFIG_PSERIES) +=3D device-plug-test
-check-qtest-ppc64-$(CONFIG_POWERNV) +=3D pnv-xscom-test
-check-qtest-ppc64-y +=3D migration-test
-check-qtest-ppc64-$(CONFIG_PSERIES) +=3D rtas-test
-check-qtest-ppc64-$(CONFIG_SLIRP) +=3D pxe-test
-check-qtest-ppc64-$(CONFIG_USB_UHCI) +=3D usb-hcd-uhci-test
-check-qtest-ppc64-$(CONFIG_USB_XHCI_NEC) +=3D usb-hcd-xhci-test
-check-qtest-ppc64-$(CONFIG_SLIRP) +=3D test-netfilter
-check-qtest-ppc64-$(CONFIG_POSIX) +=3D test-filter-mirror
-check-qtest-ppc64-$(CONFIG_RTL8139_PCI) +=3D test-filter-redirector
-check-qtest-ppc64-$(CONFIG_VGA) +=3D display-vga-test
-check-qtest-ppc64-y +=3D numa-test
-check-qtest-ppc64-$(CONFIG_IVSHMEM_DEVICE) +=3D ivshmem-test
-check-qtest-ppc64-y +=3D cpu-plug-test
-
-check-qtest-sh4-$(CONFIG_ISA_TESTDEV) =3D endianness-test
-
-check-qtest-sh4eb-$(CONFIG_ISA_TESTDEV) =3D endianness-test
-
-check-qtest-sparc-y +=3D prom-env-test
-check-qtest-sparc-y +=3D m48t59-test
-check-qtest-sparc-y +=3D boot-serial-test
-
-check-qtest-sparc64-$(CONFIG_ISA_TESTDEV) =3D endianness-test
-check-qtest-sparc64-y +=3D prom-env-test
-check-qtest-sparc64-y +=3D boot-serial-test
-
-check-qtest-arm-y +=3D arm-cpu-features
-check-qtest-arm-y +=3D microbit-test
-check-qtest-arm-y +=3D m25p80-test
-check-qtest-arm-y +=3D test-arm-mptimer
-check-qtest-arm-y +=3D boot-serial-test
-check-qtest-arm-y +=3D hexloader-test
-check-qtest-arm-$(CONFIG_PFLASH_CFI02) +=3D pflash-cfi02-test
-
-check-qtest-aarch64-y +=3D arm-cpu-features
-check-qtest-aarch64-y +=3D numa-test
-check-qtest-aarch64-y +=3D boot-serial-test
-check-qtest-aarch64-y +=3D migration-test
-
-# TODO: once aarch64 TCG is fixed on ARM 32 bit host, make test unconditio=
nal
-ifneq ($(ARCH),arm)
-check-qtest-aarch64-y +=3D bios-tables-test
-endif
-
-check-qtest-microblazeel-y +=3D $(check-qtest-microblaze-y)
-
-check-qtest-xtensaeb-y +=3D $(check-qtest-xtensa-y)
-
-check-qtest-s390x-y =3D boot-serial-test
-check-qtest-s390x-$(CONFIG_SLIRP) +=3D pxe-test
-check-qtest-s390x-$(CONFIG_SLIRP) +=3D test-netfilter
-check-qtest-s390x-$(CONFIG_POSIX) +=3D test-filter-mirror
-check-qtest-s390x-$(CONFIG_POSIX) +=3D test-filter-redirector
-check-qtest-s390x-y +=3D drive_del-test
-check-qtest-s390x-y +=3D device-plug-test
-check-qtest-s390x-y +=3D virtio-ccw-test
-check-qtest-s390x-y +=3D cpu-plug-test
-check-qtest-s390x-y +=3D migration-test
-
-check-qtest-generic-y +=3D machine-none-test
-check-qtest-generic-y +=3D qom-test
-check-qtest-generic-y +=3D test-hmp
-
 qapi-schema +=3D alternate-any.json
 qapi-schema +=3D alternate-array.json
 qapi-schema +=3D alternate-base.json
@@ -708,12 +550,6 @@ tests/test-authz-pam$(EXESUF): tests/test-authz-pam.o =
$(test-authz-obj-y)
 tests/test-io-task$(EXESUF): tests/test-io-task.o $(test-io-obj-y)
 tests/test-io-channel-socket$(EXESUF): tests/test-io-channel-socket.o \
         tests/io-channel-helpers.o tests/socket-helpers.o $(test-io-obj-y)
-tests/qtest/tpm-crb-swtpm-test$(EXESUF): tests/qtest/tpm-crb-swtpm-test.o =
tests/qtest/tpm-emu.o \
-=09tests/qtest/tpm-util.o tests/qtest/tpm-tests.o $(test-io-obj-y)
-tests/qtest/tpm-crb-test$(EXESUF): tests/qtest/tpm-crb-test.o tests/qtest/=
tpm-emu.o $(test-io-obj-y)
-tests/qtest/tpm-tis-swtpm-test$(EXESUF): tests/qtest/tpm-tis-swtpm-test.o =
tests/qtest/tpm-emu.o \
-=09tests/qtest/tpm-util.o tests/qtest/tpm-tests.o $(test-io-obj-y)
-tests/qtest/tpm-tis-test$(EXESUF): tests/qtest/tpm-tis-test.o tests/qtest/=
tpm-emu.o $(test-io-obj-y)
 tests/test-io-channel-file$(EXESUF): tests/test-io-channel-file.o \
         tests/io-channel-helpers.o $(test-io-obj-y)
 tests/test-io-channel-tls$(EXESUF): tests/test-io-channel-tls.o \
@@ -728,147 +564,6 @@ tests/test-crypto-ivgen$(EXESUF): tests/test-crypto-i=
vgen.o $(test-crypto-obj-y)
 tests/test-crypto-afsplit$(EXESUF): tests/test-crypto-afsplit.o $(test-cry=
pto-obj-y)
 tests/test-crypto-block$(EXESUF): tests/test-crypto-block.o $(test-crypto-=
obj-y)
=20
-libqgraph-obj-y =3D tests/libqos/qgraph.o
-
-libqos-obj-y =3D $(libqgraph-obj-y) tests/libqos/pci.o tests/libqos/fw_cfg=
.o
-libqos-obj-y +=3D tests/libqos/malloc.o
-libqos-obj-y +=3D tests/libqos/libqos.o
-libqos-spapr-obj-y =3D $(libqos-obj-y) tests/libqos/malloc-spapr.o
-libqos-spapr-obj-y +=3D tests/libqos/libqos-spapr.o
-libqos-spapr-obj-y +=3D tests/libqos/rtas.o
-libqos-spapr-obj-y +=3D tests/libqos/pci-spapr.o
-libqos-pc-obj-y =3D $(libqos-obj-y) tests/libqos/pci-pc.o
-libqos-pc-obj-y +=3D tests/libqos/malloc-pc.o tests/libqos/libqos-pc.o
-libqos-pc-obj-y +=3D tests/libqos/ahci.o
-libqos-usb-obj-y =3D $(libqos-spapr-obj-y) $(libqos-pc-obj-y) tests/libqos=
/usb.o
-
-# Devices
-qos-test-obj-y =3D tests/qtest/qos-test.o $(libqgraph-obj-y)
-qos-test-obj-y +=3D $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
-qos-test-obj-y +=3D tests/libqos/e1000e.o
-qos-test-obj-y +=3D tests/libqos/i2c.o
-qos-test-obj-y +=3D tests/libqos/i2c-imx.o
-qos-test-obj-y +=3D tests/libqos/i2c-omap.o
-qos-test-obj-y +=3D tests/libqos/sdhci.o
-qos-test-obj-y +=3D tests/libqos/tpci200.o
-qos-test-obj-y +=3D tests/libqos/virtio.o
-qos-test-obj-$(CONFIG_VIRTFS) +=3D tests/libqos/virtio-9p.o
-qos-test-obj-y +=3D tests/libqos/virtio-balloon.o
-qos-test-obj-y +=3D tests/libqos/virtio-blk.o
-qos-test-obj-y +=3D tests/libqos/virtio-mmio.o
-qos-test-obj-y +=3D tests/libqos/virtio-net.o
-qos-test-obj-y +=3D tests/libqos/virtio-pci.o
-qos-test-obj-y +=3D tests/libqos/virtio-pci-modern.o
-qos-test-obj-y +=3D tests/libqos/virtio-rng.o
-qos-test-obj-y +=3D tests/libqos/virtio-scsi.o
-qos-test-obj-y +=3D tests/libqos/virtio-serial.o
-
-# Machines
-qos-test-obj-y +=3D tests/libqos/aarch64-xlnx-zcu102-machine.o
-qos-test-obj-y +=3D tests/libqos/arm-imx25-pdk-machine.o
-qos-test-obj-y +=3D tests/libqos/arm-n800-machine.o
-qos-test-obj-y +=3D tests/libqos/arm-raspi2-machine.o
-qos-test-obj-y +=3D tests/libqos/arm-sabrelite-machine.o
-qos-test-obj-y +=3D tests/libqos/arm-smdkc210-machine.o
-qos-test-obj-y +=3D tests/libqos/arm-virt-machine.o
-qos-test-obj-y +=3D tests/libqos/arm-xilinx-zynq-a9-machine.o
-qos-test-obj-y +=3D tests/libqos/ppc64_pseries-machine.o
-qos-test-obj-y +=3D tests/libqos/x86_64_pc-machine.o
-
-# Tests
-qos-test-obj-y +=3D tests/qtest/ac97-test.o
-qos-test-obj-y +=3D tests/qtest/ds1338-test.o
-qos-test-obj-y +=3D tests/qtest/e1000-test.o
-qos-test-obj-y +=3D tests/qtest/e1000e-test.o
-qos-test-obj-y +=3D tests/qtest/eepro100-test.o
-qos-test-obj-y +=3D tests/qtest/es1370-test.o
-qos-test-obj-y +=3D tests/qtest/ipoctal232-test.o
-qos-test-obj-y +=3D tests/qtest/megasas-test.o
-qos-test-obj-y +=3D tests/qtest/ne2000-test.o
-qos-test-obj-y +=3D tests/qtest/nvme-test.o
-qos-test-obj-y +=3D tests/qtest/pca9552-test.o
-qos-test-obj-y +=3D tests/qtest/pci-test.o
-qos-test-obj-y +=3D tests/qtest/pcnet-test.o
-qos-test-obj-y +=3D tests/qtest/sdhci-test.o
-qos-test-obj-y +=3D tests/qtest/spapr-phb-test.o
-qos-test-obj-y +=3D tests/qtest/tmp105-test.o
-qos-test-obj-y +=3D tests/qtest/usb-hcd-ohci-test.o $(libqos-usb-obj-y)
-qos-test-obj-$(CONFIG_VHOST_NET_USER) +=3D tests/qtest/vhost-user-test.o $=
(chardev-obj-y) $(test-io-obj-y)
-qos-test-obj-y +=3D tests/qtest/virtio-test.o
-qos-test-obj-$(CONFIG_VIRTFS) +=3D tests/qtest/virtio-9p-test.o
-qos-test-obj-y +=3D tests/qtest/virtio-blk-test.o
-qos-test-obj-y +=3D tests/qtest/virtio-net-test.o
-qos-test-obj-y +=3D tests/qtest/virtio-rng-test.o
-qos-test-obj-y +=3D tests/qtest/virtio-scsi-test.o
-qos-test-obj-y +=3D tests/qtest/virtio-serial-test.o
-qos-test-obj-y +=3D tests/qtest/vmxnet3-test.o
-
-check-unit-y +=3D tests/test-qgraph$(EXESUF)
-tests/test-qgraph$(EXESUF): tests/test-qgraph.o $(libqgraph-obj-y)
-
-check-qtest-generic-y +=3D qos-test
-tests/qtest/qos-test$(EXESUF): $(qos-test-obj-y)
-
-tests/qtest/qmp-test$(EXESUF): tests/qtest/qmp-test.o
-tests/qtest/qmp-cmd-test$(EXESUF): tests/qtest/qmp-cmd-test.o
-tests/qtest/device-introspect-test$(EXESUF): tests/qtest/device-introspect=
-test.o
-tests/qtest/rtc-test$(EXESUF): tests/qtest/rtc-test.o
-tests/qtest/m48t59-test$(EXESUF): tests/qtest/m48t59-test.o
-tests/qtest/hexloader-test$(EXESUF): tests/qtest/hexloader-test.o
-tests/qtest/pflash-cfi02$(EXESUF): tests/qtest/pflash-cfi02-test.o
-tests/qtest/endianness-test$(EXESUF): tests/qtest/endianness-test.o
-tests/qtest/prom-env-test$(EXESUF): tests/qtest/prom-env-test.o $(libqos-o=
bj-y)
-tests/qtest/rtas-test$(EXESUF): tests/qtest/rtas-test.o $(libqos-spapr-obj=
-y)
-tests/qtest/fdc-test$(EXESUF): tests/qtest/fdc-test.o
-tests/qtest/ide-test$(EXESUF): tests/qtest/ide-test.o $(libqos-pc-obj-y)
-tests/qtest/ahci-test$(EXESUF): tests/qtest/ahci-test.o $(libqos-pc-obj-y)=
 qemu-img$(EXESUF)
-tests/qtest/ipmi-kcs-test$(EXESUF): tests/qtest/ipmi-kcs-test.o
-tests/qtest/ipmi-bt-test$(EXESUF): tests/qtest/ipmi-bt-test.o
-tests/qtest/hd-geo-test$(EXESUF): tests/qtest/hd-geo-test.o $(libqos-obj-y=
)
-tests/qtest/boot-order-test$(EXESUF): tests/qtest/boot-order-test.o $(libq=
os-obj-y)
-tests/qtest/boot-serial-test$(EXESUF): tests/qtest/boot-serial-test.o $(li=
bqos-obj-y)
-tests/qtest/bios-tables-test$(EXESUF): tests/qtest/bios-tables-test.o \
-=09tests/qtest/boot-sector.o tests/qtest/acpi-utils.o $(libqos-obj-y)
-tests/qtest/pxe-test$(EXESUF): tests/qtest/pxe-test.o tests/qtest/boot-sec=
tor.o $(libqos-obj-y)
-tests/qtest/microbit-test$(EXESUF): tests/qtest/microbit-test.o
-tests/qtest/m25p80-test$(EXESUF): tests/qtest/m25p80-test.o
-tests/qtest/i440fx-test$(EXESUF): tests/qtest/i440fx-test.o $(libqos-pc-ob=
j-y)
-tests/qtest/q35-test$(EXESUF): tests/qtest/q35-test.o $(libqos-pc-obj-y)
-tests/qtest/fw_cfg-test$(EXESUF): tests/qtest/fw_cfg-test.o $(libqos-pc-ob=
j-y)
-tests/qtest/rtl8139-test$(EXESUF): tests/qtest/rtl8139-test.o $(libqos-pc-=
obj-y)
-tests/qtest/pnv-xscom-test$(EXESUF): tests/qtest/pnv-xscom-test.o
-tests/qtest/wdt_ib700-test$(EXESUF): tests/qtest/wdt_ib700-test.o
-tests/qtest/tco-test$(EXESUF): tests/qtest/tco-test.o $(libqos-pc-obj-y)
-tests/qtest/virtio-ccw-test$(EXESUF): tests/qtest/virtio-ccw-test.o
-tests/qtest/display-vga-test$(EXESUF): tests/qtest/display-vga-test.o
-tests/qtest/qom-test$(EXESUF): tests/qtest/qom-test.o
-tests/qtest/test-hmp$(EXESUF): tests/qtest/test-hmp.o
-tests/qtest/machine-none-test$(EXESUF): tests/qtest/machine-none-test.o
-tests/qtest/device-plug-test$(EXESUF): tests/qtest/device-plug-test.o
-tests/qtest/drive_del-test$(EXESUF): tests/qtest/drive_del-test.o
-tests/qtest/pvpanic-test$(EXESUF): tests/qtest/pvpanic-test.o
-tests/qtest/i82801b11-test$(EXESUF): tests/qtest/i82801b11-test.o
-tests/qtest/intel-hda-test$(EXESUF): tests/qtest/intel-hda-test.o
-tests/qtest/ioh3420-test$(EXESUF): tests/qtest/ioh3420-test.o
-tests/qtest/usb-hcd-uhci-test$(EXESUF): tests/qtest/usb-hcd-uhci-test.o $(=
libqos-usb-obj-y)
-tests/qtest/usb-hcd-ehci-test$(EXESUF): tests/qtest/usb-hcd-ehci-test.o $(=
libqos-usb-obj-y)
-tests/qtest/usb-hcd-xhci-test$(EXESUF): tests/qtest/usb-hcd-xhci-test.o $(=
libqos-usb-obj-y)
-tests/qtest/cpu-plug-test$(EXESUF): tests/qtest/cpu-plug-test.o
-tests/qtest/migration-test$(EXESUF): tests/qtest/migration-test.o tests/qt=
est/migration-helpers.o
-tests/qtest/qemu-iotests/qtest/socket_scm_helper$(EXESUF): tests/qtest/qem=
u-iotests/qtest/socket_scm_helper.o
-tests/qtest/test-netfilter$(EXESUF): tests/qtest/test-netfilter.o $(qtest-=
obj-y)
-tests/qtest/test-filter-mirror$(EXESUF): tests/qtest/test-filter-mirror.o =
$(qtest-obj-y)
-tests/qtest/test-filter-redirector$(EXESUF): tests/qtest/test-filter-redir=
ector.o $(qtest-obj-y)
-tests/qtest/test-x86-cpuid-compat$(EXESUF): tests/qtest/test-x86-cpuid-com=
pat.o $(qtest-obj-y)
-tests/qtest/ivshmem-test$(EXESUF): tests/qtest/ivshmem-test.o contrib/ivsh=
mem-server/ivshmem-server.o $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
-tests/qtest/dbus-vmstate-test$(EXESUF): tests/qtest/dbus-vmstate-test.o te=
sts/qtest/migration-helpers.o tests/qtest/dbus-vmstate1.o $(libqos-pc-obj-y=
) $(libqos-spapr-obj-y)
-tests/qtest/vhost-user-bridge$(EXESUF): tests/qtest/vhost-user-bridge.o $(=
test-util-obj-y) libvhost-user.a
-tests/qtest/test-arm-mptimer$(EXESUF): tests/qtest/test-arm-mptimer.o
-tests/qtest/numa-test$(EXESUF): tests/qtest/numa-test.o
-tests/qtest/vmgenid-test$(EXESUF): tests/qtest/vmgenid-test.o tests/qtest/=
boot-sector.o tests/qtest/acpi-utils.o
-tests/qtest/cdrom-test$(EXESUF): tests/qtest/cdrom-test.o tests/qtest/boot=
-sector.o $(libqos-obj-y)
-tests/qtest/arm-cpu-features$(EXESUF): tests/qtest/arm-cpu-features.o
-
 tests/migration/stress$(EXESUF): tests/migration/stress.o
 =09$(call quiet-command, $(LINKPROG) -static -O3 $(PTHREAD_LIB) -o $@ $< ,=
"LINK","$(TARGET_DIR)$@")
=20
@@ -881,19 +576,7 @@ tests/migration/initrd-stress.img: tests/migration/str=
ess$(EXESUF)
 =09rm $(INITRD_WORK_DIR)/init
 =09rmdir $(INITRD_WORK_DIR)
=20
-# QTest rules
-
-TARGETS=3D$(patsubst %-softmmu,%, $(filter %-softmmu,$(TARGET_DIRS)))
-ifeq ($(CONFIG_POSIX),y)
-QTEST_TARGETS =3D $(TARGETS)
-check-qtest-y=3D$(foreach TARGET,$(TARGETS), $(check-qtest-$(TARGET)-y:%=
=3Dtests/qtest/%$(EXESUF)))
-check-qtest-y +=3D $(check-qtest-generic-y:%=3Dtests/qtest/%$(EXESUF))
-else
-QTEST_TARGETS =3D
-endif
-
-qtest-obj-y =3D tests/qtest/libqtest.o $(test-util-obj-y)
-$(check-qtest-y): $(qtest-obj-y)
+include $(SRC_PATH)/tests/qtest/Makefile.include
=20
 tests/test-qga$(EXESUF): qemu-ga$(EXESUF)
 tests/test-qga$(EXESUF): tests/test-qga.o $(qtest-obj-y)
diff --git a/tests/qtest/Makefile.include b/tests/qtest/Makefile.include
new file mode 100644
index 0000000000..816d0d90ea
--- /dev/null
+++ b/tests/qtest/Makefile.include
@@ -0,0 +1,318 @@
+# All QTests for now are POSIX-only, but the dependencies are
+# really in libqtest, not in the testcases themselves.
+
+check-qtest-generic-y +=3D cdrom-test
+check-qtest-generic-y +=3D device-introspect-test
+check-qtest-generic-y +=3D machine-none-test
+check-qtest-generic-y +=3D qmp-test
+check-qtest-generic-y +=3D qmp-cmd-test
+check-qtest-generic-y +=3D qom-test
+check-qtest-generic-$(CONFIG_MODULES) +=3D modules-test
+check-qtest-generic-y +=3D test-hmp
+
+check-qtest-pci-$(CONFIG_RTL8139_PCI) +=3D rtl8139-test
+check-qtest-pci-$(CONFIG_VGA) +=3D display-vga-test
+check-qtest-pci-$(CONFIG_HDA) +=3D intel-hda-test
+check-qtest-pci-$(CONFIG_IVSHMEM_DEVICE) +=3D ivshmem-test
+
+DBUS_DAEMON :=3D $(shell which dbus-daemon 2>/dev/null)
+ifneq ($(GDBUS_CODEGEN),)
+ifneq ($(DBUS_DAEMON),)
+check-qtest-pci-$(CONFIG_GIO) +=3D dbus-vmstate-test
+endif
+endif
+
+check-qtest-i386-$(CONFIG_ISA_TESTDEV) =3D endianness-test
+check-qtest-i386-y +=3D fdc-test
+check-qtest-i386-y +=3D ide-test
+check-qtest-i386-$(CONFIG_TOOLS) +=3D ahci-test
+check-qtest-i386-y +=3D hd-geo-test
+check-qtest-i386-y +=3D boot-order-test
+check-qtest-i386-y +=3D bios-tables-test
+check-qtest-i386-$(CONFIG_SGA) +=3D boot-serial-test
+check-qtest-i386-$(CONFIG_SLIRP) +=3D pxe-test
+check-qtest-i386-y +=3D rtc-test
+check-qtest-i386-$(CONFIG_ISA_IPMI_KCS) +=3D ipmi-kcs-test
+ifdef CONFIG_LINUX
+check-qtest-i386-$(CONFIG_ISA_IPMI_BT) +=3D ipmi-bt-test
+endif
+check-qtest-i386-y +=3D i440fx-test
+check-qtest-i386-y +=3D fw_cfg-test
+check-qtest-i386-y +=3D device-plug-test
+check-qtest-i386-y +=3D drive_del-test
+check-qtest-i386-$(CONFIG_WDT_IB700) +=3D wdt_ib700-test
+check-qtest-i386-y +=3D tco-test
+check-qtest-i386-y +=3D $(check-qtest-pci-y)
+check-qtest-i386-$(CONFIG_PVPANIC) +=3D pvpanic-test
+check-qtest-i386-$(CONFIG_I82801B11) +=3D i82801b11-test
+check-qtest-i386-$(CONFIG_IOH3420) +=3D ioh3420-test
+check-qtest-i386-$(CONFIG_USB_UHCI) +=3D usb-hcd-uhci-test
+check-qtest-i386-$(call land,$(CONFIG_USB_EHCI),$(CONFIG_USB_UHCI)) +=3D u=
sb-hcd-ehci-test
+check-qtest-i386-$(CONFIG_USB_XHCI_NEC) +=3D usb-hcd-xhci-test
+check-qtest-i386-y +=3D cpu-plug-test
+check-qtest-i386-y +=3D q35-test
+check-qtest-i386-y +=3D vmgenid-test
+check-qtest-i386-$(CONFIG_TPM_CRB) +=3D tpm-crb-swtpm-test
+check-qtest-i386-$(CONFIG_TPM_CRB) +=3D tpm-crb-test
+check-qtest-i386-$(CONFIG_TPM_TIS) +=3D tpm-tis-swtpm-test
+check-qtest-i386-$(CONFIG_TPM_TIS) +=3D tpm-tis-test
+check-qtest-i386-$(CONFIG_SLIRP) +=3D test-netfilter
+check-qtest-i386-$(CONFIG_POSIX) +=3D test-filter-mirror
+check-qtest-i386-$(CONFIG_RTL8139_PCI) +=3D test-filter-redirector
+check-qtest-i386-y +=3D migration-test
+check-qtest-i386-y +=3D test-x86-cpuid-compat
+check-qtest-i386-y +=3D numa-test
+
+check-qtest-x86_64-y +=3D $(check-qtest-i386-y)
+
+check-qtest-alpha-y +=3D boot-serial-test
+check-qtest-alpha-$(CONFIG_VGA) +=3D display-vga-test
+
+check-qtest-hppa-y +=3D boot-serial-test
+check-qtest-hppa-$(CONFIG_VGA) +=3D display-vga-test
+
+check-qtest-m68k-y =3D boot-serial-test
+
+check-qtest-microblaze-y +=3D boot-serial-test
+
+check-qtest-mips-$(CONFIG_ISA_TESTDEV) =3D endianness-test
+check-qtest-mips-$(CONFIG_VGA) +=3D display-vga-test
+
+check-qtest-mips64-$(CONFIG_ISA_TESTDEV) =3D endianness-test
+check-qtest-mips64-$(CONFIG_VGA) +=3D display-vga-test
+
+check-qtest-mips64el-$(CONFIG_ISA_TESTDEV) =3D endianness-test
+check-qtest-mips64el-$(CONFIG_VGA) +=3D display-vga-test
+
+check-qtest-moxie-y +=3D boot-serial-test
+
+check-qtest-ppc-$(CONFIG_ISA_TESTDEV) =3D endianness-test
+check-qtest-ppc-y +=3D boot-order-test
+check-qtest-ppc-y +=3D prom-env-test
+check-qtest-ppc-y +=3D drive_del-test
+check-qtest-ppc-y +=3D boot-serial-test
+check-qtest-ppc-$(CONFIG_M48T59) +=3D m48t59-test
+
+check-qtest-ppc64-y +=3D $(check-qtest-ppc-y)
+check-qtest-ppc64-$(CONFIG_PSERIES) +=3D device-plug-test
+check-qtest-ppc64-$(CONFIG_POWERNV) +=3D pnv-xscom-test
+check-qtest-ppc64-y +=3D migration-test
+check-qtest-ppc64-$(CONFIG_PSERIES) +=3D rtas-test
+check-qtest-ppc64-$(CONFIG_SLIRP) +=3D pxe-test
+check-qtest-ppc64-$(CONFIG_USB_UHCI) +=3D usb-hcd-uhci-test
+check-qtest-ppc64-$(CONFIG_USB_XHCI_NEC) +=3D usb-hcd-xhci-test
+check-qtest-ppc64-$(CONFIG_SLIRP) +=3D test-netfilter
+check-qtest-ppc64-$(CONFIG_POSIX) +=3D test-filter-mirror
+check-qtest-ppc64-$(CONFIG_RTL8139_PCI) +=3D test-filter-redirector
+check-qtest-ppc64-$(CONFIG_VGA) +=3D display-vga-test
+check-qtest-ppc64-y +=3D numa-test
+check-qtest-ppc64-$(CONFIG_IVSHMEM_DEVICE) +=3D ivshmem-test
+check-qtest-ppc64-y +=3D cpu-plug-test
+
+check-qtest-sh4-$(CONFIG_ISA_TESTDEV) =3D endianness-test
+
+check-qtest-sh4eb-$(CONFIG_ISA_TESTDEV) =3D endianness-test
+
+check-qtest-sparc-y +=3D prom-env-test
+check-qtest-sparc-y +=3D m48t59-test
+check-qtest-sparc-y +=3D boot-serial-test
+
+check-qtest-sparc64-$(CONFIG_ISA_TESTDEV) =3D endianness-test
+check-qtest-sparc64-y +=3D prom-env-test
+check-qtest-sparc64-y +=3D boot-serial-test
+
+check-qtest-arm-y +=3D arm-cpu-features
+check-qtest-arm-y +=3D microbit-test
+check-qtest-arm-y +=3D m25p80-test
+check-qtest-arm-y +=3D test-arm-mptimer
+check-qtest-arm-y +=3D boot-serial-test
+check-qtest-arm-y +=3D hexloader-test
+check-qtest-arm-$(CONFIG_PFLASH_CFI02) +=3D pflash-cfi02-test
+
+check-qtest-aarch64-y +=3D arm-cpu-features
+check-qtest-aarch64-y +=3D numa-test
+check-qtest-aarch64-y +=3D boot-serial-test
+check-qtest-aarch64-y +=3D migration-test
+
+# TODO: once aarch64 TCG is fixed on ARM 32 bit host, make test unconditio=
nal
+ifneq ($(ARCH),arm)
+check-qtest-aarch64-y +=3D bios-tables-test
+endif
+
+check-qtest-microblazeel-y +=3D $(check-qtest-microblaze-y)
+
+check-qtest-xtensaeb-y +=3D $(check-qtest-xtensa-y)
+
+check-qtest-s390x-y =3D boot-serial-test
+check-qtest-s390x-$(CONFIG_SLIRP) +=3D pxe-test
+check-qtest-s390x-$(CONFIG_SLIRP) +=3D test-netfilter
+check-qtest-s390x-$(CONFIG_POSIX) +=3D test-filter-mirror
+check-qtest-s390x-$(CONFIG_POSIX) +=3D test-filter-redirector
+check-qtest-s390x-y +=3D drive_del-test
+check-qtest-s390x-y +=3D device-plug-test
+check-qtest-s390x-y +=3D virtio-ccw-test
+check-qtest-s390x-y +=3D cpu-plug-test
+check-qtest-s390x-y +=3D migration-test
+
+# libqos / qgraph :
+libqgraph-obj-y =3D tests/libqos/qgraph.o
+
+libqos-obj-y =3D $(libqgraph-obj-y) tests/libqos/pci.o tests/libqos/fw_cfg=
.o
+libqos-obj-y +=3D tests/libqos/malloc.o
+libqos-obj-y +=3D tests/libqos/libqos.o
+libqos-spapr-obj-y =3D $(libqos-obj-y) tests/libqos/malloc-spapr.o
+libqos-spapr-obj-y +=3D tests/libqos/libqos-spapr.o
+libqos-spapr-obj-y +=3D tests/libqos/rtas.o
+libqos-spapr-obj-y +=3D tests/libqos/pci-spapr.o
+libqos-pc-obj-y =3D $(libqos-obj-y) tests/libqos/pci-pc.o
+libqos-pc-obj-y +=3D tests/libqos/malloc-pc.o tests/libqos/libqos-pc.o
+libqos-pc-obj-y +=3D tests/libqos/ahci.o
+libqos-usb-obj-y =3D $(libqos-spapr-obj-y) $(libqos-pc-obj-y) tests/libqos=
/usb.o
+
+# qos devices:
+qos-test-obj-y =3D tests/qtest/qos-test.o $(libqgraph-obj-y)
+qos-test-obj-y +=3D $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
+qos-test-obj-y +=3D tests/libqos/e1000e.o
+qos-test-obj-y +=3D tests/libqos/i2c.o
+qos-test-obj-y +=3D tests/libqos/i2c-imx.o
+qos-test-obj-y +=3D tests/libqos/i2c-omap.o
+qos-test-obj-y +=3D tests/libqos/sdhci.o
+qos-test-obj-y +=3D tests/libqos/tpci200.o
+qos-test-obj-y +=3D tests/libqos/virtio.o
+qos-test-obj-$(CONFIG_VIRTFS) +=3D tests/libqos/virtio-9p.o
+qos-test-obj-y +=3D tests/libqos/virtio-balloon.o
+qos-test-obj-y +=3D tests/libqos/virtio-blk.o
+qos-test-obj-y +=3D tests/libqos/virtio-mmio.o
+qos-test-obj-y +=3D tests/libqos/virtio-net.o
+qos-test-obj-y +=3D tests/libqos/virtio-pci.o
+qos-test-obj-y +=3D tests/libqos/virtio-pci-modern.o
+qos-test-obj-y +=3D tests/libqos/virtio-rng.o
+qos-test-obj-y +=3D tests/libqos/virtio-scsi.o
+qos-test-obj-y +=3D tests/libqos/virtio-serial.o
+
+# qos machines:
+qos-test-obj-y +=3D tests/libqos/aarch64-xlnx-zcu102-machine.o
+qos-test-obj-y +=3D tests/libqos/arm-imx25-pdk-machine.o
+qos-test-obj-y +=3D tests/libqos/arm-n800-machine.o
+qos-test-obj-y +=3D tests/libqos/arm-raspi2-machine.o
+qos-test-obj-y +=3D tests/libqos/arm-sabrelite-machine.o
+qos-test-obj-y +=3D tests/libqos/arm-smdkc210-machine.o
+qos-test-obj-y +=3D tests/libqos/arm-virt-machine.o
+qos-test-obj-y +=3D tests/libqos/arm-xilinx-zynq-a9-machine.o
+qos-test-obj-y +=3D tests/libqos/ppc64_pseries-machine.o
+qos-test-obj-y +=3D tests/libqos/x86_64_pc-machine.o
+
+# qos tests:
+qos-test-obj-y +=3D tests/qtest/ac97-test.o
+qos-test-obj-y +=3D tests/qtest/ds1338-test.o
+qos-test-obj-y +=3D tests/qtest/e1000-test.o
+qos-test-obj-y +=3D tests/qtest/e1000e-test.o
+qos-test-obj-y +=3D tests/qtest/eepro100-test.o
+qos-test-obj-y +=3D tests/qtest/es1370-test.o
+qos-test-obj-y +=3D tests/qtest/ipoctal232-test.o
+qos-test-obj-y +=3D tests/qtest/megasas-test.o
+qos-test-obj-y +=3D tests/qtest/ne2000-test.o
+qos-test-obj-y +=3D tests/qtest/nvme-test.o
+qos-test-obj-y +=3D tests/qtest/pca9552-test.o
+qos-test-obj-y +=3D tests/qtest/pci-test.o
+qos-test-obj-y +=3D tests/qtest/pcnet-test.o
+qos-test-obj-y +=3D tests/qtest/sdhci-test.o
+qos-test-obj-y +=3D tests/qtest/spapr-phb-test.o
+qos-test-obj-y +=3D tests/qtest/tmp105-test.o
+qos-test-obj-y +=3D tests/qtest/usb-hcd-ohci-test.o $(libqos-usb-obj-y)
+qos-test-obj-$(CONFIG_VHOST_NET_USER) +=3D tests/qtest/vhost-user-test.o $=
(chardev-obj-y) $(test-io-obj-y)
+qos-test-obj-y +=3D tests/qtest/virtio-test.o
+qos-test-obj-$(CONFIG_VIRTFS) +=3D tests/qtest/virtio-9p-test.o
+qos-test-obj-y +=3D tests/qtest/virtio-blk-test.o
+qos-test-obj-y +=3D tests/qtest/virtio-net-test.o
+qos-test-obj-y +=3D tests/qtest/virtio-rng-test.o
+qos-test-obj-y +=3D tests/qtest/virtio-scsi-test.o
+qos-test-obj-y +=3D tests/qtest/virtio-serial-test.o
+qos-test-obj-y +=3D tests/qtest/vmxnet3-test.o
+
+check-unit-y +=3D tests/test-qgraph$(EXESUF)
+tests/test-qgraph$(EXESUF): tests/test-qgraph.o $(libqgraph-obj-y)
+
+check-qtest-generic-y +=3D qos-test
+tests/qtest/qos-test$(EXESUF): $(qos-test-obj-y)
+
+# QTest dependencies:
+tests/qtest/qmp-test$(EXESUF): tests/qtest/qmp-test.o
+tests/qtest/qmp-cmd-test$(EXESUF): tests/qtest/qmp-cmd-test.o
+tests/qtest/device-introspect-test$(EXESUF): tests/qtest/device-introspect=
-test.o
+tests/qtest/rtc-test$(EXESUF): tests/qtest/rtc-test.o
+tests/qtest/m48t59-test$(EXESUF): tests/qtest/m48t59-test.o
+tests/qtest/hexloader-test$(EXESUF): tests/qtest/hexloader-test.o
+tests/qtest/pflash-cfi02$(EXESUF): tests/qtest/pflash-cfi02-test.o
+tests/qtest/endianness-test$(EXESUF): tests/qtest/endianness-test.o
+tests/qtest/prom-env-test$(EXESUF): tests/qtest/prom-env-test.o $(libqos-o=
bj-y)
+tests/qtest/rtas-test$(EXESUF): tests/qtest/rtas-test.o $(libqos-spapr-obj=
-y)
+tests/qtest/fdc-test$(EXESUF): tests/qtest/fdc-test.o
+tests/qtest/ide-test$(EXESUF): tests/qtest/ide-test.o $(libqos-pc-obj-y)
+tests/qtest/ahci-test$(EXESUF): tests/qtest/ahci-test.o $(libqos-pc-obj-y)=
 qemu-img$(EXESUF)
+tests/qtest/ipmi-kcs-test$(EXESUF): tests/qtest/ipmi-kcs-test.o
+tests/qtest/ipmi-bt-test$(EXESUF): tests/qtest/ipmi-bt-test.o
+tests/qtest/hd-geo-test$(EXESUF): tests/qtest/hd-geo-test.o $(libqos-obj-y=
)
+tests/qtest/boot-order-test$(EXESUF): tests/qtest/boot-order-test.o $(libq=
os-obj-y)
+tests/qtest/boot-serial-test$(EXESUF): tests/qtest/boot-serial-test.o $(li=
bqos-obj-y)
+tests/qtest/bios-tables-test$(EXESUF): tests/qtest/bios-tables-test.o \
+=09tests/qtest/boot-sector.o tests/qtest/acpi-utils.o $(libqos-obj-y)
+tests/qtest/pxe-test$(EXESUF): tests/qtest/pxe-test.o tests/qtest/boot-sec=
tor.o $(libqos-obj-y)
+tests/qtest/microbit-test$(EXESUF): tests/qtest/microbit-test.o
+tests/qtest/m25p80-test$(EXESUF): tests/qtest/m25p80-test.o
+tests/qtest/i440fx-test$(EXESUF): tests/qtest/i440fx-test.o $(libqos-pc-ob=
j-y)
+tests/qtest/q35-test$(EXESUF): tests/qtest/q35-test.o $(libqos-pc-obj-y)
+tests/qtest/fw_cfg-test$(EXESUF): tests/qtest/fw_cfg-test.o $(libqos-pc-ob=
j-y)
+tests/qtest/rtl8139-test$(EXESUF): tests/qtest/rtl8139-test.o $(libqos-pc-=
obj-y)
+tests/qtest/pnv-xscom-test$(EXESUF): tests/qtest/pnv-xscom-test.o
+tests/qtest/wdt_ib700-test$(EXESUF): tests/qtest/wdt_ib700-test.o
+tests/qtest/tco-test$(EXESUF): tests/qtest/tco-test.o $(libqos-pc-obj-y)
+tests/qtest/virtio-ccw-test$(EXESUF): tests/qtest/virtio-ccw-test.o
+tests/qtest/display-vga-test$(EXESUF): tests/qtest/display-vga-test.o
+tests/qtest/qom-test$(EXESUF): tests/qtest/qom-test.o
+tests/qtest/test-hmp$(EXESUF): tests/qtest/test-hmp.o
+tests/qtest/machine-none-test$(EXESUF): tests/qtest/machine-none-test.o
+tests/qtest/device-plug-test$(EXESUF): tests/qtest/device-plug-test.o
+tests/qtest/drive_del-test$(EXESUF): tests/qtest/drive_del-test.o
+tests/qtest/pvpanic-test$(EXESUF): tests/qtest/pvpanic-test.o
+tests/qtest/i82801b11-test$(EXESUF): tests/qtest/i82801b11-test.o
+tests/qtest/intel-hda-test$(EXESUF): tests/qtest/intel-hda-test.o
+tests/qtest/ioh3420-test$(EXESUF): tests/qtest/ioh3420-test.o
+tests/qtest/usb-hcd-uhci-test$(EXESUF): tests/qtest/usb-hcd-uhci-test.o $(=
libqos-usb-obj-y)
+tests/qtest/usb-hcd-ehci-test$(EXESUF): tests/qtest/usb-hcd-ehci-test.o $(=
libqos-usb-obj-y)
+tests/qtest/usb-hcd-xhci-test$(EXESUF): tests/qtest/usb-hcd-xhci-test.o $(=
libqos-usb-obj-y)
+tests/qtest/cpu-plug-test$(EXESUF): tests/qtest/cpu-plug-test.o
+tests/qtest/migration-test$(EXESUF): tests/qtest/migration-test.o tests/qt=
est/migration-helpers.o
+tests/qtest/qemu-iotests/qtest/socket_scm_helper$(EXESUF): tests/qtest/qem=
u-iotests/qtest/socket_scm_helper.o
+tests/qtest/test-netfilter$(EXESUF): tests/qtest/test-netfilter.o $(qtest-=
obj-y)
+tests/qtest/test-filter-mirror$(EXESUF): tests/qtest/test-filter-mirror.o =
$(qtest-obj-y)
+tests/qtest/test-filter-redirector$(EXESUF): tests/qtest/test-filter-redir=
ector.o $(qtest-obj-y)
+tests/qtest/test-x86-cpuid-compat$(EXESUF): tests/qtest/test-x86-cpuid-com=
pat.o $(qtest-obj-y)
+tests/qtest/ivshmem-test$(EXESUF): tests/qtest/ivshmem-test.o contrib/ivsh=
mem-server/ivshmem-server.o $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
+tests/qtest/dbus-vmstate-test$(EXESUF): tests/qtest/dbus-vmstate-test.o te=
sts/qtest/migration-helpers.o tests/qtest/dbus-vmstate1.o $(libqos-pc-obj-y=
) $(libqos-spapr-obj-y)
+tests/qtest/vhost-user-bridge$(EXESUF): tests/qtest/vhost-user-bridge.o $(=
test-util-obj-y) libvhost-user.a
+tests/qtest/test-arm-mptimer$(EXESUF): tests/qtest/test-arm-mptimer.o
+tests/qtest/numa-test$(EXESUF): tests/qtest/numa-test.o
+tests/qtest/vmgenid-test$(EXESUF): tests/qtest/vmgenid-test.o tests/qtest/=
boot-sector.o tests/qtest/acpi-utils.o
+tests/qtest/cdrom-test$(EXESUF): tests/qtest/cdrom-test.o tests/qtest/boot=
-sector.o $(libqos-obj-y)
+tests/qtest/arm-cpu-features$(EXESUF): tests/qtest/arm-cpu-features.o
+tests/qtest/tpm-crb-swtpm-test$(EXESUF): tests/qtest/tpm-crb-swtpm-test.o =
tests/qtest/tpm-emu.o \
+=09tests/qtest/tpm-util.o tests/qtest/tpm-tests.o $(test-io-obj-y)
+tests/qtest/tpm-crb-test$(EXESUF): tests/qtest/tpm-crb-test.o tests/qtest/=
tpm-emu.o $(test-io-obj-y)
+tests/qtest/tpm-tis-swtpm-test$(EXESUF): tests/qtest/tpm-tis-swtpm-test.o =
tests/qtest/tpm-emu.o \
+=09tests/qtest/tpm-util.o tests/qtest/tpm-tests.o $(test-io-obj-y)
+tests/qtest/tpm-tis-test$(EXESUF): tests/qtest/tpm-tis-test.o tests/qtest/=
tpm-emu.o $(test-io-obj-y)
+
+# QTest rules
+
+TARGETS=3D$(patsubst %-softmmu,%, $(filter %-softmmu,$(TARGET_DIRS)))
+ifeq ($(CONFIG_POSIX),y)
+QTEST_TARGETS =3D $(TARGETS)
+check-qtest-y=3D$(foreach TARGET,$(TARGETS), $(check-qtest-$(TARGET)-y:%=
=3Dtests/qtest/%$(EXESUF)))
+check-qtest-y +=3D $(check-qtest-generic-y:%=3Dtests/qtest/%$(EXESUF))
+else
+QTEST_TARGETS =3D
+endif
+
+qtest-obj-y =3D tests/qtest/libqtest.o $(test-util-obj-y)
+$(check-qtest-y): $(qtest-obj-y)
--=20
2.18.1


