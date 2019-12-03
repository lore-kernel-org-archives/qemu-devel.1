Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA74C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 20:41:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 658E72080F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 20:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qpIUBdyA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 658E72080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icEyh-0001SY-Kd
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 15:40:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56607)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1icDn4-0001JH-Bp
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 14:24:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1icDmq-00062B-PF
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 14:24:43 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37941)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1icDmq-0005rl-BL
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 14:24:40 -0500
Received: by mail-wr1-x441.google.com with SMTP id y17so5198152wrh.5
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 11:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=RW3m04iIZvm7xv36jm3LzAKxtgR4n/wrN/M0DJ7Kq+M=;
 b=qpIUBdyA2CMPv/wohCVHhYOqpB7DJZ1pEYaxSUMjffSr3ygMjz2Jp3Y0u5hFOTrniE
 bfWMEWMtUfkHnOEqRVKdMkUPsF/YIRUzn/AqVzksZiQ0w2J4NE2VHYxgJHTnX+/56Y+3
 lOVdaKC/tI4Pxmwy66yZIYiCSesEnMzoibqwTY9T8xeicDd9l+j6aJU2Y/xnVtxbT28z
 9Htkj4oXmhb4VhjVdtmwh22eMJaG2q/m/E8hGk9/BcFpF+2s9FEJJCgegdfWmb34kWsJ
 e+jfNzK1RQxk8pD1yZXrvn5Xwpu4ri2kDnmyJV97A2Hc/an8zKQfX7lzn3ttRo+fxB7L
 FDUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=RW3m04iIZvm7xv36jm3LzAKxtgR4n/wrN/M0DJ7Kq+M=;
 b=QEMuP29vOD+kPEYMmW3vE9kVuemQaURjzaJNGka4un+4TbklUFz61t+aGcaaWw/msa
 pQ9zFTQLB+h5cnoxq32OMD+M7FxNI/Ed/0tAWRZcMPKMddKlccVyRqhSP21sM7J058Zq
 8s6+s2jFsmrJtKl7PJQrbs1djtkkNk6/ZF5DKZ2ch+V7rzdPB+/LuR4VsrYt3zr79e00
 1xUtHaFeNxMaJORsVOspLPjy544QU0f/gqf2NCVpCfdqFkZuFQOCAdR0Rcr7Vh51jp0N
 3L8gRu0hawGUygIowiDDQLxo2LYUAZBJXDN36+rUzZEevXFl7xQ4tAI8cDecRJsK5WUZ
 SMUQ==
X-Gm-Message-State: APjAAAUIDGdxeauk+f+Vmh525/nmoA8CGO/v+d0LjhRjreGftX45jsf8
 +TJbII32WERJPANqtoHbppzfgQ+g3kE=
X-Google-Smtp-Source: APXvYqwe4RQ8iuAihenk/izJITf2Ey3/+hHFlBo6Z8r9osWg/pS3XIBJ0HY8Si5b6F30O45S3l2BgQ==
X-Received: by 2002:a5d:6a52:: with SMTP id t18mr6669594wrw.391.1575401077205; 
 Tue, 03 Dec 2019 11:24:37 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g17sm4014336wmc.37.2019.12.03.11.24.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2019 11:24:36 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 612EA1FF87;
 Tue,  3 Dec 2019 19:24:35 +0000 (GMT)
References: <20190910185839.19682-1-thuth@redhat.com>
 <20190910185839.19682-4-thuth@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 3/7] tests/Makefile: Remove 'tests/' and '$(EXESUF)'
 from the check-qtest variables
In-reply-to: <20190910185839.19682-4-thuth@redhat.com>
Date: Tue, 03 Dec 2019 19:24:35 +0000
Message-ID: <87immx9pqk.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> It's much easier if we simply add the folder prefix and the exe suffix
> later via a substitution instead.

I guess it took too long for me to get around to this as I'm hit with a
merge conflict. Is there likely to be a re-base soon?

>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/Makefile.include | 252 ++++++++++++++++++++---------------------
>  1 file changed, 126 insertions(+), 126 deletions(-)
>
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 50891b8a37..2b2fec59c9 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -147,150 +147,150 @@ check-block-$(call land,$(CONFIG_POSIX),$(CONFIG_=
SOFTMMU)) +=3D tests/check-block.
>  # All QTests for now are POSIX-only, but the dependencies are
>  # really in libqtest, not in the testcases themselves.
>=20=20
> -check-qtest-generic-y +=3D tests/qmp-test$(EXESUF)
> -check-qtest-generic-y +=3D tests/qmp-cmd-test$(EXESUF)
> -check-qtest-generic-$(CONFIG_MODULES) +=3D tests/modules-test$(EXESUF)
> -
> -check-qtest-generic-y +=3D tests/device-introspect-test$(EXESUF)
> -check-qtest-generic-y +=3D tests/cdrom-test$(EXESUF)
> -
> -check-qtest-pci-$(CONFIG_RTL8139_PCI) +=3D tests/rtl8139-test$(EXESUF)
> -check-qtest-pci-$(CONFIG_VGA) +=3D tests/display-vga-test$(EXESUF)
> -check-qtest-pci-$(CONFIG_HDA) +=3D tests/intel-hda-test$(EXESUF)
> -check-qtest-pci-$(CONFIG_IVSHMEM_DEVICE) +=3D tests/ivshmem-test$(EXESUF)
> -
> -check-qtest-i386-$(CONFIG_ISA_TESTDEV) =3D tests/endianness-test$(EXESUF)
> -check-qtest-i386-y +=3D tests/fdc-test$(EXESUF)
> -check-qtest-i386-y +=3D tests/ide-test$(EXESUF)
> -check-qtest-i386-y +=3D tests/ahci-test$(EXESUF)
> -check-qtest-i386-y +=3D tests/hd-geo-test$(EXESUF)
> -check-qtest-i386-y +=3D tests/boot-order-test$(EXESUF)
> -check-qtest-i386-y +=3D tests/bios-tables-test$(EXESUF)
> -check-qtest-i386-$(CONFIG_SGA) +=3D tests/boot-serial-test$(EXESUF)
> -check-qtest-i386-$(CONFIG_SLIRP) +=3D tests/pxe-test$(EXESUF)
> -check-qtest-i386-y +=3D tests/rtc-test$(EXESUF)
> -check-qtest-i386-$(CONFIG_ISA_IPMI_KCS) +=3D tests/ipmi-kcs-test$(EXESUF)
> +check-qtest-generic-y +=3D qmp-test
> +check-qtest-generic-y +=3D qmp-cmd-test
> +check-qtest-generic-$(CONFIG_MODULES) +=3D modules-test
> +
> +check-qtest-generic-y +=3D device-introspect-test
> +check-qtest-generic-y +=3D cdrom-test
> +
> +check-qtest-pci-$(CONFIG_RTL8139_PCI) +=3D rtl8139-test
> +check-qtest-pci-$(CONFIG_VGA) +=3D display-vga-test
> +check-qtest-pci-$(CONFIG_HDA) +=3D intel-hda-test
> +check-qtest-pci-$(CONFIG_IVSHMEM_DEVICE) +=3D ivshmem-test
> +
> +check-qtest-i386-$(CONFIG_ISA_TESTDEV) =3D endianness-test
> +check-qtest-i386-y +=3D fdc-test
> +check-qtest-i386-y +=3D ide-test
> +check-qtest-i386-y +=3D ahci-test
> +check-qtest-i386-y +=3D hd-geo-test
> +check-qtest-i386-y +=3D boot-order-test
> +check-qtest-i386-y +=3D bios-tables-test
> +check-qtest-i386-$(CONFIG_SGA) +=3D boot-serial-test
> +check-qtest-i386-$(CONFIG_SLIRP) +=3D pxe-test
> +check-qtest-i386-y +=3D rtc-test
> +check-qtest-i386-$(CONFIG_ISA_IPMI_KCS) +=3D ipmi-kcs-test
>  # Disabled temporarily as it fails intermittently especially under NetBS=
D VM
> -# check-qtest-i386-$(CONFIG_ISA_IPMI_BT) +=3D tests/ipmi-bt-test$(EXESUF)
> -check-qtest-i386-y +=3D tests/i440fx-test$(EXESUF)
> -check-qtest-i386-y +=3D tests/fw_cfg-test$(EXESUF)
> -check-qtest-i386-y +=3D tests/device-plug-test$(EXESUF)
> -check-qtest-i386-y +=3D tests/drive_del-test$(EXESUF)
> -check-qtest-i386-$(CONFIG_WDT_IB700) +=3D tests/wdt_ib700-test$(EXESUF)
> -check-qtest-i386-y +=3D tests/tco-test$(EXESUF)
> +# check-qtest-i386-$(CONFIG_ISA_IPMI_BT) +=3D ipmi-bt-test
> +check-qtest-i386-y +=3D i440fx-test
> +check-qtest-i386-y +=3D fw_cfg-test
> +check-qtest-i386-y +=3D device-plug-test
> +check-qtest-i386-y +=3D drive_del-test
> +check-qtest-i386-$(CONFIG_WDT_IB700) +=3D wdt_ib700-test
> +check-qtest-i386-y +=3D tco-test
>  check-qtest-i386-y +=3D $(check-qtest-pci-y)
> -check-qtest-i386-$(CONFIG_PVPANIC) +=3D tests/pvpanic-test$(EXESUF)
> -check-qtest-i386-$(CONFIG_I82801B11) +=3D tests/i82801b11-test$(EXESUF)
> -check-qtest-i386-$(CONFIG_IOH3420) +=3D tests/ioh3420-test$(EXESUF)
> -check-qtest-i386-$(CONFIG_USB_UHCI) +=3D tests/usb-hcd-uhci-test$(EXESUF)
> +check-qtest-i386-$(CONFIG_PVPANIC) +=3D pvpanic-test
> +check-qtest-i386-$(CONFIG_I82801B11) +=3D i82801b11-test
> +check-qtest-i386-$(CONFIG_IOH3420) +=3D ioh3420-test
> +check-qtest-i386-$(CONFIG_USB_UHCI) +=3D usb-hcd-uhci-test
>  ifeq ($(CONFIG_USB_ECHI)$(CONFIG_USB_UHCI),yy)
> -check-qtest-i386-y +=3D tests/usb-hcd-ehci-test$(EXESUF)
> +check-qtest-i386-y +=3D usb-hcd-ehci-test
>  endif
> -check-qtest-i386-$(CONFIG_USB_XHCI_NEC) +=3D tests/usb-hcd-xhci-test$(EX=
ESUF)
> -check-qtest-i386-y +=3D tests/cpu-plug-test$(EXESUF)
> -check-qtest-i386-y +=3D tests/q35-test$(EXESUF)
> -check-qtest-i386-y +=3D tests/vmgenid-test$(EXESUF)
> -check-qtest-i386-$(CONFIG_TPM_CRB) +=3D tests/tpm-crb-swtpm-test$(EXESUF)
> -check-qtest-i386-$(CONFIG_TPM_CRB) +=3D tests/tpm-crb-test$(EXESUF)
> -check-qtest-i386-$(CONFIG_TPM_TIS) +=3D tests/tpm-tis-swtpm-test$(EXESUF)
> -check-qtest-i386-$(CONFIG_TPM_TIS) +=3D tests/tpm-tis-test$(EXESUF)
> -check-qtest-i386-$(CONFIG_SLIRP) +=3D tests/test-netfilter$(EXESUF)
> -check-qtest-i386-$(CONFIG_POSIX) +=3D tests/test-filter-mirror$(EXESUF)
> -check-qtest-i386-$(CONFIG_RTL8139_PCI) +=3D tests/test-filter-redirector=
$(EXESUF)
> -check-qtest-i386-y +=3D tests/migration-test$(EXESUF)
> -check-qtest-i386-y +=3D tests/test-x86-cpuid-compat$(EXESUF)
> -check-qtest-i386-y +=3D tests/numa-test$(EXESUF)
> +check-qtest-i386-$(CONFIG_USB_XHCI_NEC) +=3D usb-hcd-xhci-test
> +check-qtest-i386-y +=3D cpu-plug-test
> +check-qtest-i386-y +=3D q35-test
> +check-qtest-i386-y +=3D vmgenid-test
> +check-qtest-i386-$(CONFIG_TPM_CRB) +=3D tpm-crb-swtpm-test
> +check-qtest-i386-$(CONFIG_TPM_CRB) +=3D tpm-crb-test
> +check-qtest-i386-$(CONFIG_TPM_TIS) +=3D tpm-tis-swtpm-test
> +check-qtest-i386-$(CONFIG_TPM_TIS) +=3D tpm-tis-test
> +check-qtest-i386-$(CONFIG_SLIRP) +=3D test-netfilter
> +check-qtest-i386-$(CONFIG_POSIX) +=3D test-filter-mirror
> +check-qtest-i386-$(CONFIG_RTL8139_PCI) +=3D test-filter-redirector
> +check-qtest-i386-y +=3D migration-test
> +check-qtest-i386-y +=3D test-x86-cpuid-compat
> +check-qtest-i386-y +=3D numa-test
>  check-qtest-x86_64-y +=3D $(check-qtest-i386-y)
>=20=20
> -check-qtest-alpha-y +=3D tests/boot-serial-test$(EXESUF)
> -check-qtest-alpha-$(CONFIG_VGA) +=3D tests/display-vga-test$(EXESUF)
> +check-qtest-alpha-y +=3D boot-serial-test
> +check-qtest-alpha-$(CONFIG_VGA) +=3D display-vga-test
>=20=20
> -check-qtest-hppa-y +=3D tests/boot-serial-test$(EXESUF)
> -check-qtest-hppa-$(CONFIG_VGA) +=3D tests/display-vga-test$(EXESUF)
> +check-qtest-hppa-y +=3D boot-serial-test
> +check-qtest-hppa-$(CONFIG_VGA) +=3D display-vga-test
>=20=20
> -check-qtest-m68k-y =3D tests/boot-serial-test$(EXESUF)
> +check-qtest-m68k-y =3D boot-serial-test
>=20=20
> -check-qtest-microblaze-y +=3D tests/boot-serial-test$(EXESUF)
> +check-qtest-microblaze-y +=3D boot-serial-test
>=20=20
> -check-qtest-mips-$(CONFIG_ISA_TESTDEV) =3D tests/endianness-test$(EXESUF)
> -check-qtest-mips-$(CONFIG_VGA) +=3D tests/display-vga-test$(EXESUF)
> +check-qtest-mips-$(CONFIG_ISA_TESTDEV) =3D endianness-test
> +check-qtest-mips-$(CONFIG_VGA) +=3D display-vga-test
>=20=20
> -check-qtest-mips64-$(CONFIG_ISA_TESTDEV) =3D tests/endianness-test$(EXES=
UF)
> -check-qtest-mips64-$(CONFIG_VGA) +=3D tests/display-vga-test$(EXESUF)
> +check-qtest-mips64-$(CONFIG_ISA_TESTDEV) =3D endianness-test
> +check-qtest-mips64-$(CONFIG_VGA) +=3D display-vga-test
>=20=20
> -check-qtest-mips64el-$(CONFIG_ISA_TESTDEV) =3D tests/endianness-test$(EX=
ESUF)
> -check-qtest-mips64el-$(CONFIG_VGA) +=3D tests/display-vga-test$(EXESUF)
> +check-qtest-mips64el-$(CONFIG_ISA_TESTDEV) =3D endianness-test
> +check-qtest-mips64el-$(CONFIG_VGA) +=3D display-vga-test
>=20=20
> -check-qtest-moxie-y +=3D tests/boot-serial-test$(EXESUF)
> +check-qtest-moxie-y +=3D boot-serial-test
>=20=20
> -check-qtest-ppc-$(CONFIG_ISA_TESTDEV) =3D tests/endianness-test$(EXESUF)
> -check-qtest-ppc-y +=3D tests/boot-order-test$(EXESUF)
> -check-qtest-ppc-y +=3D tests/prom-env-test$(EXESUF)
> -check-qtest-ppc-y +=3D tests/drive_del-test$(EXESUF)
> -check-qtest-ppc-y +=3D tests/boot-serial-test$(EXESUF)
> -check-qtest-ppc-$(CONFIG_M48T59) +=3D tests/m48t59-test$(EXESUF)
> +check-qtest-ppc-$(CONFIG_ISA_TESTDEV) =3D endianness-test
> +check-qtest-ppc-y +=3D boot-order-test
> +check-qtest-ppc-y +=3D prom-env-test
> +check-qtest-ppc-y +=3D drive_del-test
> +check-qtest-ppc-y +=3D boot-serial-test
> +check-qtest-ppc-$(CONFIG_M48T59) +=3D m48t59-test
>=20=20
>  check-qtest-ppc64-y +=3D $(check-qtest-ppc-y)
> -check-qtest-ppc64-$(CONFIG_PSERIES) +=3D tests/device-plug-test$(EXESUF)
> -check-qtest-ppc64-$(CONFIG_POWERNV) +=3D tests/pnv-xscom-test$(EXESUF)
> -check-qtest-ppc64-y +=3D tests/migration-test$(EXESUF)
> -check-qtest-ppc64-$(CONFIG_PSERIES) +=3D tests/rtas-test$(EXESUF)
> -check-qtest-ppc64-$(CONFIG_SLIRP) +=3D tests/pxe-test$(EXESUF)
> -check-qtest-ppc64-$(CONFIG_USB_UHCI) +=3D tests/usb-hcd-uhci-test$(EXESU=
F)
> -check-qtest-ppc64-$(CONFIG_USB_XHCI_NEC) +=3D tests/usb-hcd-xhci-test$(E=
XESUF)
> -check-qtest-ppc64-$(CONFIG_SLIRP) +=3D tests/test-netfilter$(EXESUF)
> -check-qtest-ppc64-$(CONFIG_POSIX) +=3D tests/test-filter-mirror$(EXESUF)
> -check-qtest-ppc64-$(CONFIG_RTL8139_PCI) +=3D tests/test-filter-redirecto=
r$(EXESUF)
> -check-qtest-ppc64-$(CONFIG_VGA) +=3D tests/display-vga-test$(EXESUF)
> -check-qtest-ppc64-y +=3D tests/numa-test$(EXESUF)
> -check-qtest-ppc64-$(CONFIG_IVSHMEM_DEVICE) +=3D tests/ivshmem-test$(EXES=
UF)
> -check-qtest-ppc64-y +=3D tests/cpu-plug-test$(EXESUF)
> -
> -check-qtest-sh4-$(CONFIG_ISA_TESTDEV) =3D tests/endianness-test$(EXESUF)
> -
> -check-qtest-sh4eb-$(CONFIG_ISA_TESTDEV) =3D tests/endianness-test$(EXESU=
F)
> -
> -check-qtest-sparc-y +=3D tests/prom-env-test$(EXESUF)
> -check-qtest-sparc-y +=3D tests/m48t59-test$(EXESUF)
> -check-qtest-sparc-y +=3D tests/boot-serial-test$(EXESUF)
> -
> -check-qtest-sparc64-$(CONFIG_ISA_TESTDEV) =3D tests/endianness-test$(EXE=
SUF)
> -check-qtest-sparc64-y +=3D tests/prom-env-test$(EXESUF)
> -check-qtest-sparc64-y +=3D tests/boot-serial-test$(EXESUF)
> -
> -check-qtest-arm-y +=3D tests/microbit-test$(EXESUF)
> -check-qtest-arm-y +=3D tests/m25p80-test$(EXESUF)
> -check-qtest-arm-y +=3D tests/test-arm-mptimer$(EXESUF)
> -check-qtest-arm-y +=3D tests/boot-serial-test$(EXESUF)
> -check-qtest-arm-y +=3D tests/hexloader-test$(EXESUF)
> -check-qtest-arm-$(CONFIG_PFLASH_CFI02) +=3D tests/pflash-cfi02-test$(EXE=
SUF)
> -
> -check-qtest-aarch64-y =3D tests/numa-test$(EXESUF)
> -check-qtest-aarch64-y +=3D tests/boot-serial-test$(EXESUF)
> -check-qtest-aarch64-y +=3D tests/migration-test$(EXESUF)
> +check-qtest-ppc64-$(CONFIG_PSERIES) +=3D device-plug-test
> +check-qtest-ppc64-$(CONFIG_POWERNV) +=3D pnv-xscom-test
> +check-qtest-ppc64-y +=3D migration-test
> +check-qtest-ppc64-$(CONFIG_PSERIES) +=3D rtas-test
> +check-qtest-ppc64-$(CONFIG_SLIRP) +=3D pxe-test
> +check-qtest-ppc64-$(CONFIG_USB_UHCI) +=3D usb-hcd-uhci-test
> +check-qtest-ppc64-$(CONFIG_USB_XHCI_NEC) +=3D usb-hcd-xhci-test
> +check-qtest-ppc64-$(CONFIG_SLIRP) +=3D test-netfilter
> +check-qtest-ppc64-$(CONFIG_POSIX) +=3D test-filter-mirror
> +check-qtest-ppc64-$(CONFIG_RTL8139_PCI) +=3D test-filter-redirector
> +check-qtest-ppc64-$(CONFIG_VGA) +=3D display-vga-test
> +check-qtest-ppc64-y +=3D numa-test
> +check-qtest-ppc64-$(CONFIG_IVSHMEM_DEVICE) +=3D ivshmem-test
> +check-qtest-ppc64-y +=3D cpu-plug-test
> +
> +check-qtest-sh4-$(CONFIG_ISA_TESTDEV) =3D endianness-test
> +
> +check-qtest-sh4eb-$(CONFIG_ISA_TESTDEV) =3D endianness-test
> +
> +check-qtest-sparc-y +=3D prom-env-test
> +check-qtest-sparc-y +=3D m48t59-test
> +check-qtest-sparc-y +=3D boot-serial-test
> +
> +check-qtest-sparc64-$(CONFIG_ISA_TESTDEV) =3D endianness-test
> +check-qtest-sparc64-y +=3D prom-env-test
> +check-qtest-sparc64-y +=3D boot-serial-test
> +
> +check-qtest-arm-y +=3D microbit-test
> +check-qtest-arm-y +=3D m25p80-test
> +check-qtest-arm-y +=3D test-arm-mptimer
> +check-qtest-arm-y +=3D boot-serial-test
> +check-qtest-arm-y +=3D hexloader-test
> +check-qtest-arm-$(CONFIG_PFLASH_CFI02) +=3D pflash-cfi02-test
> +
> +check-qtest-aarch64-y =3D numa-test
> +check-qtest-aarch64-y +=3D boot-serial-test
> +check-qtest-aarch64-y +=3D migration-test
>  # TODO: once aarch64 TCG is fixed on ARM 32 bit host, make test uncondit=
ional
>  ifneq ($(ARCH),arm)
> -check-qtest-aarch64-y +=3D tests/bios-tables-test$(EXESUF)
> +check-qtest-aarch64-y +=3D bios-tables-test
>  endif
>=20=20
>  check-qtest-microblazeel-y +=3D $(check-qtest-microblaze-y)
>=20=20
>  check-qtest-xtensaeb-y +=3D $(check-qtest-xtensa-y)
>=20=20
> -check-qtest-s390x-y =3D tests/boot-serial-test$(EXESUF)
> -check-qtest-s390x-$(CONFIG_SLIRP) +=3D tests/pxe-test$(EXESUF)
> -check-qtest-s390x-$(CONFIG_SLIRP) +=3D tests/test-netfilter$(EXESUF)
> -check-qtest-s390x-$(CONFIG_POSIX) +=3D tests/test-filter-mirror$(EXESUF)
> -check-qtest-s390x-$(CONFIG_POSIX) +=3D tests/test-filter-redirector$(EXE=
SUF)
> -check-qtest-s390x-y +=3D tests/drive_del-test$(EXESUF)
> -check-qtest-s390x-y +=3D tests/device-plug-test$(EXESUF)
> -check-qtest-s390x-y +=3D tests/virtio-ccw-test$(EXESUF)
> -check-qtest-s390x-y +=3D tests/cpu-plug-test$(EXESUF)
> -check-qtest-s390x-y +=3D tests/migration-test$(EXESUF)
> -
> -check-qtest-generic-y +=3D tests/machine-none-test$(EXESUF)
> -check-qtest-generic-y +=3D tests/qom-test$(EXESUF)
> -check-qtest-generic-y +=3D tests/test-hmp$(EXESUF)
> +check-qtest-s390x-y =3D boot-serial-test
> +check-qtest-s390x-$(CONFIG_SLIRP) +=3D pxe-test
> +check-qtest-s390x-$(CONFIG_SLIRP) +=3D test-netfilter
> +check-qtest-s390x-$(CONFIG_POSIX) +=3D test-filter-mirror
> +check-qtest-s390x-$(CONFIG_POSIX) +=3D test-filter-redirector
> +check-qtest-s390x-y +=3D drive_del-test
> +check-qtest-s390x-y +=3D device-plug-test
> +check-qtest-s390x-y +=3D virtio-ccw-test
> +check-qtest-s390x-y +=3D cpu-plug-test
> +check-qtest-s390x-y +=3D migration-test
> +
> +check-qtest-generic-y +=3D machine-none-test
> +check-qtest-generic-y +=3D qom-test
> +check-qtest-generic-y +=3D test-hmp
>=20=20
>  qapi-schema +=3D alternate-any.json
>  qapi-schema +=3D alternate-array.json
> @@ -763,7 +763,7 @@ qos-test-obj-y +=3D tests/vmxnet3-test.o
>  check-unit-y +=3D tests/test-qgraph$(EXESUF)
>  tests/test-qgraph$(EXESUF): tests/test-qgraph.o $(libqgraph-obj-y)
>=20=20
> -check-qtest-generic-y +=3D tests/qos-test$(EXESUF)
> +check-qtest-generic-y +=3D qos-test
>  tests/qos-test$(EXESUF): $(qos-test-obj-y)
>=20=20
>  tests/qmp-test$(EXESUF): tests/qmp-test.o
> @@ -846,8 +846,8 @@ tests/migration/initrd-stress.img: tests/migration/st=
ress$(EXESUF)
>  TARGETS=3D$(patsubst %-softmmu,%, $(filter %-softmmu,$(TARGET_DIRS)))
>  ifeq ($(CONFIG_POSIX),y)
>  QTEST_TARGETS =3D $(TARGETS)
> -check-qtest-y=3D$(foreach TARGET,$(TARGETS), $(check-qtest-$(TARGET)-y))
> -check-qtest-y +=3D $(check-qtest-generic-y)
> +check-qtest-y=3D$(foreach TARGET,$(TARGETS), $(check-qtest-$(TARGET)-y:%=
=3Dtests/%$(EXESUF)))
> +check-qtest-y +=3D $(check-qtest-generic-y:%=3Dtests/%$(EXESUF))
>  else
>  QTEST_TARGETS =3D
>  endif
> @@ -897,7 +897,7 @@ endef
>=20=20
>  .PHONY: $(patsubst %, check-qtest-%, $(QTEST_TARGETS))
>  $(patsubst %, check-qtest-%, $(QTEST_TARGETS)): check-qtest-%: %-softmmu=
/all $(check-qtest-y)
> -	$(call do_test_human,$(check-qtest-$*-y) $(check-qtest-generic-y), \
> +	$(call do_test_human,$(check-qtest-$*-y:%=3Dtests/%$(EXESUF)) $(check-q=
test-generic-y:%=3Dtests/%$(EXESUF)), \
>  	  QTEST_QEMU_BINARY=3D$*-softmmu/qemu-system-$* \
>  	  QTEST_QEMU_IMG=3Dqemu-img$(EXESUF))
>=20=20
> @@ -910,7 +910,7 @@ check-speed: $(check-speed-y)
>  # gtester tests with TAP output
>=20=20
>  $(patsubst %, check-report-qtest-%.tap, $(QTEST_TARGETS)): check-report-=
qtest-%.tap: %-softmmu/all $(check-qtest-y)
> -	$(call do_test_tap, $(check-qtest-$*-y) $(check-qtest-generic-y), \
> +	$(call do_test_tap, $(check-qtest-$*-y:%=3Dtests/%$(EXESUF)) $(check-qt=
est-generic-y:%=3Dtests/%$(EXESUF)), \
>  	  QTEST_QEMU_BINARY=3D$*-softmmu/qemu-system-$* \
>  	  QTEST_QEMU_IMG=3Dqemu-img$(EXESUF))
>=20=20
> @@ -1173,7 +1173,7 @@ check-block: $(patsubst %,check-%, $(check-block-y))
>  check: check-block check-qapi-schema check-unit check-softfloat check-qt=
est check-decodetree
>  check-clean:
>  	rm -rf $(check-unit-y) tests/*.o $(QEMU_IOTESTS_HELPERS-y)
> -	rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-$(t=
arget)-y)) $(check-qtest-generic-y))
> +	rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST), $(check-qtest-$(t=
arget)-y:%=3Dtests/%$(EXESUF))) $(check-qtest-generic-y:%=3Dtests/%$(EXESUF=
)))
>  	rm -f tests/test-qapi-gen-timestamp
>  	rm -rf $(TESTS_VENV_DIR) $(TESTS_RESULTS_DIR)


--=20
Alex Benn=C3=A9e

