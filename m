Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0B7C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 10:32:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0520D218AC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 10:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="adfXRW/N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0520D218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihWdU-0003D1-S3
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 05:32:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36007)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ihWbr-0001nP-9B
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 05:31:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ihWbo-0008Re-Sy
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 05:31:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42700
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ihWbo-0008PR-NP
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 05:31:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576665072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s3p6EgmUwLNqTAQosjZv8AScevIqcw1SuzyfY+IhmsI=;
 b=adfXRW/NJW8BpgFZ/7zMOKmM8/MxxwCIS83ZRtYuHLVjlj0gcMsq1zAQwyTeaNXA7aPYLx
 pPOuA5foNd9S+Cb+afcZblrZ327OUeWqNqj44KlNkaWfdayKAUc9CtVgY4q89pmVzs1PYA
 hLIHfQ09Ng9e2ufKGTxxhNwxFxZEttM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-qzgOkxPVONyEik5MCzOK6w-1; Wed, 18 Dec 2019 05:31:11 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 131F6800D4C;
 Wed, 18 Dec 2019 10:31:10 +0000 (UTC)
Received: from thuth.com (ovpn-116-150.ams2.redhat.com [10.36.116.150])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 967F65C3FA;
 Wed, 18 Dec 2019 10:31:08 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v2 3/7] tests/Makefile: Remove 'tests/' and '$(EXESUF)' from
 the check-qtest variables
Date: Wed, 18 Dec 2019 11:30:55 +0100
Message-Id: <20191218103059.11729-4-thuth@redhat.com>
In-Reply-To: <20191218103059.11729-1-thuth@redhat.com>
References: <20191218103059.11729-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: qzgOkxPVONyEik5MCzOK6w-1
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's much easier if we simply add the folder prefix and the exe suffix
later via a substitution instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/Makefile.include | 258 +++++++++++++++++++++--------------------
 1 file changed, 130 insertions(+), 128 deletions(-)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 16eb4aa7ba..9992e0e58c 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -152,151 +152,153 @@ check-block-$(call land,$(CONFIG_POSIX),$(CONFIG_SO=
FTMMU)) +=3D tests/check-block.
 # All QTests for now are POSIX-only, but the dependencies are
 # really in libqtest, not in the testcases themselves.
=20
-check-qtest-generic-y +=3D tests/qmp-test$(EXESUF)
-check-qtest-generic-y +=3D tests/qmp-cmd-test$(EXESUF)
-check-qtest-generic-$(CONFIG_MODULES) +=3D tests/modules-test$(EXESUF)
-
-check-qtest-generic-y +=3D tests/device-introspect-test$(EXESUF)
-check-qtest-generic-y +=3D tests/cdrom-test$(EXESUF)
-
-check-qtest-pci-$(CONFIG_RTL8139_PCI) +=3D tests/rtl8139-test$(EXESUF)
-check-qtest-pci-$(CONFIG_VGA) +=3D tests/display-vga-test$(EXESUF)
-check-qtest-pci-$(CONFIG_HDA) +=3D tests/intel-hda-test$(EXESUF)
-check-qtest-pci-$(CONFIG_IVSHMEM_DEVICE) +=3D tests/ivshmem-test$(EXESUF)
-
-check-qtest-i386-$(CONFIG_ISA_TESTDEV) =3D tests/endianness-test$(EXESUF)
-check-qtest-i386-y +=3D tests/fdc-test$(EXESUF)
-check-qtest-i386-y +=3D tests/ide-test$(EXESUF)
-check-qtest-i386-y +=3D tests/ahci-test$(EXESUF)
-check-qtest-i386-y +=3D tests/hd-geo-test$(EXESUF)
-check-qtest-i386-y +=3D tests/boot-order-test$(EXESUF)
-check-qtest-i386-y +=3D tests/bios-tables-test$(EXESUF)
-check-qtest-i386-$(CONFIG_SGA) +=3D tests/boot-serial-test$(EXESUF)
-check-qtest-i386-$(CONFIG_SLIRP) +=3D tests/pxe-test$(EXESUF)
-check-qtest-i386-y +=3D tests/rtc-test$(EXESUF)
-check-qtest-i386-$(CONFIG_ISA_IPMI_KCS) +=3D tests/ipmi-kcs-test$(EXESUF)
+check-qtest-generic-y +=3D qmp-test
+check-qtest-generic-y +=3D qmp-cmd-test
+check-qtest-generic-$(CONFIG_MODULES) +=3D modules-test
+
+check-qtest-generic-y +=3D device-introspect-test
+check-qtest-generic-y +=3D cdrom-test
+
+check-qtest-pci-$(CONFIG_RTL8139_PCI) +=3D rtl8139-test
+check-qtest-pci-$(CONFIG_VGA) +=3D display-vga-test
+check-qtest-pci-$(CONFIG_HDA) +=3D intel-hda-test
+check-qtest-pci-$(CONFIG_IVSHMEM_DEVICE) +=3D ivshmem-test
+
+check-qtest-i386-$(CONFIG_ISA_TESTDEV) =3D endianness-test
+check-qtest-i386-y +=3D fdc-test
+check-qtest-i386-y +=3D ide-test
+check-qtest-i386-y +=3D ahci-test
+check-qtest-i386-y +=3D hd-geo-test
+check-qtest-i386-y +=3D boot-order-test
+check-qtest-i386-y +=3D bios-tables-test
+check-qtest-i386-$(CONFIG_SGA) +=3D boot-serial-test
+check-qtest-i386-$(CONFIG_SLIRP) +=3D pxe-test
+check-qtest-i386-y +=3D rtc-test
+check-qtest-i386-$(CONFIG_ISA_IPMI_KCS) +=3D ipmi-kcs-test
 ifdef CONFIG_LINUX
-check-qtest-i386-$(CONFIG_ISA_IPMI_BT) +=3D tests/ipmi-bt-test$(EXESUF)
+check-qtest-i386-$(CONFIG_ISA_IPMI_BT) +=3D ipmi-bt-test
 endif
-check-qtest-i386-y +=3D tests/i440fx-test$(EXESUF)
-check-qtest-i386-y +=3D tests/fw_cfg-test$(EXESUF)
-check-qtest-i386-y +=3D tests/device-plug-test$(EXESUF)
-check-qtest-i386-y +=3D tests/drive_del-test$(EXESUF)
-check-qtest-i386-$(CONFIG_WDT_IB700) +=3D tests/wdt_ib700-test$(EXESUF)
-check-qtest-i386-y +=3D tests/tco-test$(EXESUF)
+check-qtest-i386-y +=3D i440fx-test
+check-qtest-i386-y +=3D fw_cfg-test
+check-qtest-i386-y +=3D device-plug-test
+check-qtest-i386-y +=3D drive_del-test
+check-qtest-i386-$(CONFIG_WDT_IB700) +=3D wdt_ib700-test
+check-qtest-i386-y +=3D tco-test
 check-qtest-i386-y +=3D $(check-qtest-pci-y)
-check-qtest-i386-$(CONFIG_PVPANIC) +=3D tests/pvpanic-test$(EXESUF)
-check-qtest-i386-$(CONFIG_I82801B11) +=3D tests/i82801b11-test$(EXESUF)
-check-qtest-i386-$(CONFIG_IOH3420) +=3D tests/ioh3420-test$(EXESUF)
-check-qtest-i386-$(CONFIG_USB_UHCI) +=3D tests/usb-hcd-uhci-test$(EXESUF)
-check-qtest-i386-$(call land,$(CONFIG_USB_EHCI),$(CONFIG_USB_UHCI)) +=3D t=
ests/usb-hcd-ehci-test$(EXESUF)
-check-qtest-i386-$(CONFIG_USB_XHCI_NEC) +=3D tests/usb-hcd-xhci-test$(EXES=
UF)
-check-qtest-i386-y +=3D tests/cpu-plug-test$(EXESUF)
-check-qtest-i386-y +=3D tests/q35-test$(EXESUF)
-check-qtest-i386-y +=3D tests/vmgenid-test$(EXESUF)
-check-qtest-i386-$(CONFIG_TPM_CRB) +=3D tests/tpm-crb-swtpm-test$(EXESUF)
-check-qtest-i386-$(CONFIG_TPM_CRB) +=3D tests/tpm-crb-test$(EXESUF)
-check-qtest-i386-$(CONFIG_TPM_TIS) +=3D tests/tpm-tis-swtpm-test$(EXESUF)
-check-qtest-i386-$(CONFIG_TPM_TIS) +=3D tests/tpm-tis-test$(EXESUF)
-check-qtest-i386-$(CONFIG_SLIRP) +=3D tests/test-netfilter$(EXESUF)
-check-qtest-i386-$(CONFIG_POSIX) +=3D tests/test-filter-mirror$(EXESUF)
-check-qtest-i386-$(CONFIG_RTL8139_PCI) +=3D tests/test-filter-redirector$(=
EXESUF)
-check-qtest-i386-y +=3D tests/migration-test$(EXESUF)
-check-qtest-i386-y +=3D tests/test-x86-cpuid-compat$(EXESUF)
-check-qtest-i386-y +=3D tests/numa-test$(EXESUF)
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
 check-qtest-x86_64-y +=3D $(check-qtest-i386-y)
=20
-check-qtest-alpha-y +=3D tests/boot-serial-test$(EXESUF)
-check-qtest-alpha-$(CONFIG_VGA) +=3D tests/display-vga-test$(EXESUF)
+check-qtest-alpha-y +=3D boot-serial-test
+check-qtest-alpha-$(CONFIG_VGA) +=3D display-vga-test
=20
-check-qtest-hppa-y +=3D tests/boot-serial-test$(EXESUF)
-check-qtest-hppa-$(CONFIG_VGA) +=3D tests/display-vga-test$(EXESUF)
+check-qtest-hppa-y +=3D boot-serial-test
+check-qtest-hppa-$(CONFIG_VGA) +=3D display-vga-test
=20
-check-qtest-m68k-y =3D tests/boot-serial-test$(EXESUF)
+check-qtest-m68k-y =3D boot-serial-test
=20
-check-qtest-microblaze-y +=3D tests/boot-serial-test$(EXESUF)
+check-qtest-microblaze-y +=3D boot-serial-test
=20
-check-qtest-mips-$(CONFIG_ISA_TESTDEV) =3D tests/endianness-test$(EXESUF)
-check-qtest-mips-$(CONFIG_VGA) +=3D tests/display-vga-test$(EXESUF)
+check-qtest-mips-$(CONFIG_ISA_TESTDEV) =3D endianness-test
+check-qtest-mips-$(CONFIG_VGA) +=3D display-vga-test
=20
-check-qtest-mips64-$(CONFIG_ISA_TESTDEV) =3D tests/endianness-test$(EXESUF=
)
-check-qtest-mips64-$(CONFIG_VGA) +=3D tests/display-vga-test$(EXESUF)
+check-qtest-mips64-$(CONFIG_ISA_TESTDEV) =3D endianness-test
+check-qtest-mips64-$(CONFIG_VGA) +=3D display-vga-test
=20
-check-qtest-mips64el-$(CONFIG_ISA_TESTDEV) =3D tests/endianness-test$(EXES=
UF)
-check-qtest-mips64el-$(CONFIG_VGA) +=3D tests/display-vga-test$(EXESUF)
+check-qtest-mips64el-$(CONFIG_ISA_TESTDEV) =3D endianness-test
+check-qtest-mips64el-$(CONFIG_VGA) +=3D display-vga-test
=20
-check-qtest-moxie-y +=3D tests/boot-serial-test$(EXESUF)
+check-qtest-moxie-y +=3D boot-serial-test
=20
-check-qtest-ppc-$(CONFIG_ISA_TESTDEV) =3D tests/endianness-test$(EXESUF)
-check-qtest-ppc-y +=3D tests/boot-order-test$(EXESUF)
-check-qtest-ppc-y +=3D tests/prom-env-test$(EXESUF)
-check-qtest-ppc-y +=3D tests/drive_del-test$(EXESUF)
-check-qtest-ppc-y +=3D tests/boot-serial-test$(EXESUF)
-check-qtest-ppc-$(CONFIG_M48T59) +=3D tests/m48t59-test$(EXESUF)
+check-qtest-ppc-$(CONFIG_ISA_TESTDEV) =3D endianness-test
+check-qtest-ppc-y +=3D boot-order-test
+check-qtest-ppc-y +=3D prom-env-test
+check-qtest-ppc-y +=3D drive_del-test
+check-qtest-ppc-y +=3D boot-serial-test
+check-qtest-ppc-$(CONFIG_M48T59) +=3D m48t59-test
=20
 check-qtest-ppc64-y +=3D $(check-qtest-ppc-y)
-check-qtest-ppc64-$(CONFIG_PSERIES) +=3D tests/device-plug-test$(EXESUF)
-check-qtest-ppc64-$(CONFIG_POWERNV) +=3D tests/pnv-xscom-test$(EXESUF)
-check-qtest-ppc64-y +=3D tests/migration-test$(EXESUF)
-check-qtest-ppc64-$(CONFIG_PSERIES) +=3D tests/rtas-test$(EXESUF)
-check-qtest-ppc64-$(CONFIG_SLIRP) +=3D tests/pxe-test$(EXESUF)
-check-qtest-ppc64-$(CONFIG_USB_UHCI) +=3D tests/usb-hcd-uhci-test$(EXESUF)
-check-qtest-ppc64-$(CONFIG_USB_XHCI_NEC) +=3D tests/usb-hcd-xhci-test$(EXE=
SUF)
-check-qtest-ppc64-$(CONFIG_SLIRP) +=3D tests/test-netfilter$(EXESUF)
-check-qtest-ppc64-$(CONFIG_POSIX) +=3D tests/test-filter-mirror$(EXESUF)
-check-qtest-ppc64-$(CONFIG_RTL8139_PCI) +=3D tests/test-filter-redirector$=
(EXESUF)
-check-qtest-ppc64-$(CONFIG_VGA) +=3D tests/display-vga-test$(EXESUF)
-check-qtest-ppc64-y +=3D tests/numa-test$(EXESUF)
-check-qtest-ppc64-$(CONFIG_IVSHMEM_DEVICE) +=3D tests/ivshmem-test$(EXESUF=
)
-check-qtest-ppc64-y +=3D tests/cpu-plug-test$(EXESUF)
-
-check-qtest-sh4-$(CONFIG_ISA_TESTDEV) =3D tests/endianness-test$(EXESUF)
-
-check-qtest-sh4eb-$(CONFIG_ISA_TESTDEV) =3D tests/endianness-test$(EXESUF)
-
-check-qtest-sparc-y +=3D tests/prom-env-test$(EXESUF)
-check-qtest-sparc-y +=3D tests/m48t59-test$(EXESUF)
-check-qtest-sparc-y +=3D tests/boot-serial-test$(EXESUF)
-
-check-qtest-sparc64-$(CONFIG_ISA_TESTDEV) =3D tests/endianness-test$(EXESU=
F)
-check-qtest-sparc64-y +=3D tests/prom-env-test$(EXESUF)
-check-qtest-sparc64-y +=3D tests/boot-serial-test$(EXESUF)
-
-check-qtest-arm-y +=3D tests/arm-cpu-features$(EXESUF)
-check-qtest-arm-y +=3D tests/microbit-test$(EXESUF)
-check-qtest-arm-y +=3D tests/m25p80-test$(EXESUF)
-check-qtest-arm-y +=3D tests/test-arm-mptimer$(EXESUF)
-check-qtest-arm-y +=3D tests/boot-serial-test$(EXESUF)
-check-qtest-arm-y +=3D tests/hexloader-test$(EXESUF)
-check-qtest-arm-$(CONFIG_PFLASH_CFI02) +=3D tests/pflash-cfi02-test$(EXESU=
F)
-
-check-qtest-aarch64-y +=3D tests/arm-cpu-features$(EXESUF)
-check-qtest-aarch64-y +=3D tests/numa-test$(EXESUF)
-check-qtest-aarch64-y +=3D tests/boot-serial-test$(EXESUF)
-check-qtest-aarch64-y +=3D tests/migration-test$(EXESUF)
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
 # TODO: once aarch64 TCG is fixed on ARM 32 bit host, make test unconditio=
nal
 ifneq ($(ARCH),arm)
-check-qtest-aarch64-y +=3D tests/bios-tables-test$(EXESUF)
+check-qtest-aarch64-y +=3D bios-tables-test
 endif
=20
 check-qtest-microblazeel-y +=3D $(check-qtest-microblaze-y)
=20
 check-qtest-xtensaeb-y +=3D $(check-qtest-xtensa-y)
=20
-check-qtest-s390x-y =3D tests/boot-serial-test$(EXESUF)
-check-qtest-s390x-$(CONFIG_SLIRP) +=3D tests/pxe-test$(EXESUF)
-check-qtest-s390x-$(CONFIG_SLIRP) +=3D tests/test-netfilter$(EXESUF)
-check-qtest-s390x-$(CONFIG_POSIX) +=3D tests/test-filter-mirror$(EXESUF)
-check-qtest-s390x-$(CONFIG_POSIX) +=3D tests/test-filter-redirector$(EXESU=
F)
-check-qtest-s390x-y +=3D tests/drive_del-test$(EXESUF)
-check-qtest-s390x-y +=3D tests/device-plug-test$(EXESUF)
-check-qtest-s390x-y +=3D tests/virtio-ccw-test$(EXESUF)
-check-qtest-s390x-y +=3D tests/cpu-plug-test$(EXESUF)
-check-qtest-s390x-y +=3D tests/migration-test$(EXESUF)
-
-check-qtest-generic-y +=3D tests/machine-none-test$(EXESUF)
-check-qtest-generic-y +=3D tests/qom-test$(EXESUF)
-check-qtest-generic-y +=3D tests/test-hmp$(EXESUF)
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
+check-qtest-generic-y +=3D machine-none-test
+check-qtest-generic-y +=3D qom-test
+check-qtest-generic-y +=3D test-hmp
=20
 qapi-schema +=3D alternate-any.json
 qapi-schema +=3D alternate-array.json
@@ -778,7 +780,7 @@ qos-test-obj-y +=3D tests/vmxnet3-test.o
 check-unit-y +=3D tests/test-qgraph$(EXESUF)
 tests/test-qgraph$(EXESUF): tests/test-qgraph.o $(libqgraph-obj-y)
=20
-check-qtest-generic-y +=3D tests/qos-test$(EXESUF)
+check-qtest-generic-y +=3D qos-test
 tests/qos-test$(EXESUF): $(qos-test-obj-y)
=20
 tests/qmp-test$(EXESUF): tests/qmp-test.o
@@ -862,8 +864,8 @@ tests/migration/initrd-stress.img: tests/migration/stre=
ss$(EXESUF)
 TARGETS=3D$(patsubst %-softmmu,%, $(filter %-softmmu,$(TARGET_DIRS)))
 ifeq ($(CONFIG_POSIX),y)
 QTEST_TARGETS =3D $(TARGETS)
-check-qtest-y=3D$(foreach TARGET,$(TARGETS), $(check-qtest-$(TARGET)-y))
-check-qtest-y +=3D $(check-qtest-generic-y)
+check-qtest-y=3D$(foreach TARGET,$(TARGETS), $(check-qtest-$(TARGET)-y:%=
=3Dtests/%$(EXESUF)))
+check-qtest-y +=3D $(check-qtest-generic-y:%=3Dtests/%$(EXESUF))
 else
 QTEST_TARGETS =3D
 endif
@@ -913,7 +915,7 @@ endef
=20
 .PHONY: $(patsubst %, check-qtest-%, $(QTEST_TARGETS))
 $(patsubst %, check-qtest-%, $(QTEST_TARGETS)): check-qtest-%: %-softmmu/a=
ll $(check-qtest-y)
-=09$(call do_test_human,$(check-qtest-$*-y) $(check-qtest-generic-y), \
+=09$(call do_test_human,$(check-qtest-$*-y:%=3Dtests/%$(EXESUF)) $(check-q=
test-generic-y:%=3Dtests/%$(EXESUF)), \
 =09  QTEST_QEMU_BINARY=3D$*-softmmu/qemu-system-$* \
 =09  QTEST_QEMU_IMG=3Dqemu-img$(EXESUF))
=20
@@ -926,7 +928,7 @@ check-speed: $(check-speed-y)
 # gtester tests with TAP output
=20
 $(patsubst %, check-report-qtest-%.tap, $(QTEST_TARGETS)): check-report-qt=
est-%.tap: %-softmmu/all $(check-qtest-y)
-=09$(call do_test_tap, $(check-qtest-$*-y) $(check-qtest-generic-y), \
+=09$(call do_test_tap, $(check-qtest-$*-y:%=3Dtests/%$(EXESUF)) $(check-qt=
est-generic-y:%=3Dtests/%$(EXESUF)), \
 =09  QTEST_QEMU_BINARY=3D$*-softmmu/qemu-system-$* \
 =09  QTEST_QEMU_IMG=3Dqemu-img$(EXESUF))
=20
@@ -1195,7 +1197,7 @@ check-block: $(patsubst %,check-%, $(check-block-y))
 check: check-block check-qapi-schema check-unit check-softfloat check-qtes=
t check-decodetree
 check-clean:
 =09rm -rf $(check-unit-y) tests/*.o $(QEMU_IOTESTS_HELPERS-y)
-=09rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-$(t=
arget)-y)) $(check-qtest-generic-y))
+=09rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-$(t=
arget)-y:%=3Dtests/%$(EXESUF))) $(check-qtest-generic-y:%=3Dtests/%$(EXESUF=
)))
 =09rm -f tests/test-qapi-gen-timestamp
 =09rm -rf $(TESTS_VENV_DIR) $(TESTS_RESULTS_DIR)
=20
--=20
2.18.1


