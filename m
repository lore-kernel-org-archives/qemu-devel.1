Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8F7C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 20:53:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 031572076A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 20:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ezpCb0pC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 031572076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTXEq-0004Je-08
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 16:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42886)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jTXA8-0003HK-EC
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 16:53:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jTX6a-0007iB-Kq
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 16:49:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39026
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jTX6a-0007cc-0z
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 16:45:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588106722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/65bmyRMSMWSARt8mQdNMcRZnOW7tsQVsSRkZFTUwW8=;
 b=ezpCb0pCQ4qHRP8G8lFKp9qu9V1c/w2izoEJuzNad+1abrMTld3RNP/Ikzfxu66Mmdlsup
 OXWsFDdgg/OiKo2+B5vfBC7IDwNiyLWmEThzY+3cmCzp0f1Krf8hVyEPZQeX+7ex4DPiF0
 BIW3HdnFfPBmstz76hHSvYTZ05dKgzg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-74e_qJJbPRe0Zp8aF4b-mg-1; Tue, 28 Apr 2020 16:45:18 -0400
X-MC-Unique: 74e_qJJbPRe0Zp8aF4b-mg-1
Received: by mail-wm1-f69.google.com with SMTP id h6so30591wmi.7
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 13:45:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=ey4DleDaGsXmrzfCIr/G7ojvsyGk3XPDbeLJsb0IR/0=;
 b=aBV4WnYy9fZsR0F+lHjnpJ/tYz0CVvVy2m0kbF80HEnHzg0/QFixSEpiSZPZz6bD6Q
 S3cx5rjfpoMbK2kMVTGp1GiDCTxz7HMUjwS/Kg5Zv19DCcBL4MJkCOuleZ1r5KJxfSZC
 VF3BMK/xqUaewg0NoI5X2AuzwOmfLnrjGC/hjq7bHU0t9KeaD978lHwPJeFoapNyn3wN
 WBkLkFfoYdW9aDVciBDkitoSYraUXbn4yylRsOXMA8Kt8pbBVQr9Dybv+yGk9RpUVRSl
 REK9hp+Jt79rYucenkpdJ3lnquH44O6cL1e5vF5k/u9gtR6up3Sqrwrq8OgkvC3mVB9k
 +c3Q==
X-Gm-Message-State: AGi0PuYvCWc02ULO0gws3S/udZSBWpK9hSghM6nK7IjA2XqJdfpUk8JY
 ruCvxUXVrnCsWNh9qodL2jk7zEncxtHaohBBIpj9gi3nXjmXRWqksq4Bwxe5DGLue85OG6zjdhm
 V/TxQUNJmGonfcdI=
X-Received: by 2002:a1c:1c8:: with SMTP id 191mr6146814wmb.37.1588106717420;
 Tue, 28 Apr 2020 13:45:17 -0700 (PDT)
X-Google-Smtp-Source: APiQypLHallVtoZQuXFlvlIuh3mYni1FhTSgymJ5gL/fqM3QuPJi/u9GNQ6tJeBb5ZMVg3/x554ZHQ==
X-Received: by 2002:a1c:1c8:: with SMTP id 191mr6146794wmb.37.1588106717194;
 Tue, 28 Apr 2020 13:45:17 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 91sm29026681wra.37.2020.04.28.13.45.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 13:45:16 -0700 (PDT)
Date: Tue, 28 Apr 2020 16:45:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <ani@anisinha.ca>
Subject: Re: [PATCH V2] Add a new PIIX option to control PCI hot unplugging
 of devices on non-root buses
Message-ID: <20200428164428-mutt-send-email-mst@kernel.org>
References: <1588069012-211196-1-git-send-email-ani.sinha@nutanix.com>
 <20200428120426-mutt-send-email-mst@kernel.org>
 <67e481a5-de04-4e01-b9ec-70932194d69f@Spark>
 <20200428121837-mutt-send-email-mst@kernel.org>
 <CAARzgwwTo+r9xFge_XL_eu8-nsRFBFXEaQmTOhT1YHJifzfCJA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAARzgwwTo+r9xFge_XL_eu8-nsRFBFXEaQmTOhT1YHJifzfCJA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 02:16:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Ani Sinha <ani.sinha@nutanix.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-devel@nongnu.org, Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Apr 28, 2020 at 10:10:18PM +0530, Ani Sinha wrote:
>=20
>=20
> On Tue, Apr 28, 2020 at 9:51 PM Michael S. Tsirkin <mst@redhat.com> wrote=
:
>=20
>     On Tue, Apr 28, 2020 at 09:39:16PM +0530, Ani Sinha wrote:
>     >
>     > Ani
>     > On Apr 28, 2020, 21:35 +0530, Michael S. Tsirkin <mst@redhat.com>, =
wrote:
>     >
>     >=A0 =A0 =A0On Tue, Apr 28, 2020 at 10:16:52AM +0000, Ani Sinha wrote=
:
>     >
>     >=A0 =A0 =A0 =A0 =A0A new option "use_acpi_unplug" is introduced for =
PIIX which will
>     >=A0 =A0 =A0 =A0 =A0selectively only disable hot unplugging of both h=
ot plugged and
>     >=A0 =A0 =A0 =A0 =A0cold plugged PCI devices on non-root PCI buses. T=
his will prevent
>     >=A0 =A0 =A0 =A0 =A0hot unplugging of devices from Windows based gues=
ts from system
>     >=A0 =A0 =A0 =A0 =A0tray but will not prevent devices from being hot =
plugged into the
>     >=A0 =A0 =A0 =A0 =A0guest.
>     >
>     >=A0 =A0 =A0 =A0 =A0It has been tested on Windows guests.
>     >
>     >=A0 =A0 =A0 =A0 =A0Signed-off-by: Ani Sinha <ani.sinha@nutanix.com>
>     >
>     >
>     >=A0 =A0 =A0It's still a non starter until we find something similar =
for PCIE and
>     >=A0 =A0 =A0SHPC. Do guests check command status? Can some unplug com=
mands fail?
>     >
>     >
>     > Ok I=A0 give up! I thought we debated this on the other thread.
>=20
>     Sorry to hear that.
>     I'd rather you didn't, and worked on a solution that works for everyo=
ne.
>=20
>=20
> That is extremely hard for one person to do, without inputs and ideas fro=
m the
> community.

What kind of input are you looking for?

> Satisfying the entire world requires lot of time and energy
> investment, not to mention a broad expertise in multiple technologies.=A0
>=20
>=20
>=20
>     Pushing back on merging code is unfortunately the only mechanism
>     maintainers have to make sure features are complete and
>     orthogonal to each other, so I'm not sure I can help otherwise.
>=20
>     >
>     >
>     >
>     >
>     >=A0 =A0 =A0 =A0 =A0---
>     >=A0 =A0 =A0 =A0 =A0hw/acpi/piix4.c | 3 +++
>     >=A0 =A0 =A0 =A0 =A0hw/i386/acpi-build.c | 40
>     ++++++++++++++++++++++++++--------------
>     >=A0 =A0 =A0 =A0 =A02 files changed, 29 insertions(+), 14 deletions(-=
)
>     >
>     >=A0 =A0 =A0 =A0 =A0diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
>     >=A0 =A0 =A0 =A0 =A0index 964d6f5..59fa707 100644
>     >=A0 =A0 =A0 =A0 =A0--- a/hw/acpi/piix4.c
>     >=A0 =A0 =A0 =A0 =A0+++ b/hw/acpi/piix4.c
>     >=A0 =A0 =A0 =A0 =A0@@ -78,6 +78,7 @@ typedef struct PIIX4PMState {
>     >
>     >=A0 =A0 =A0 =A0 =A0AcpiPciHpState acpi_pci_hotplug;
>     >=A0 =A0 =A0 =A0 =A0bool use_acpi_pci_hotplug;
>     >=A0 =A0 =A0 =A0 =A0+ bool use_acpi_unplug;
>     >
>     >=A0 =A0 =A0 =A0 =A0uint8_t disable_s3;
>     >=A0 =A0 =A0 =A0 =A0uint8_t disable_s4;
>     >=A0 =A0 =A0 =A0 =A0@@ -633,6 +634,8 @@ static Property piix4_pm_prop=
erties[] =3D {
>     >=A0 =A0 =A0 =A0 =A0DEFINE_PROP_UINT8(ACPI_PM_PROP_S4_VAL, PIIX4PMSta=
te, s4_val, 2),
>     >=A0 =A0 =A0 =A0 =A0DEFINE_PROP_BOOL("acpi-pci-hotplug-with-bridge-su=
pport",
>     PIIX4PMState,
>     >=A0 =A0 =A0 =A0 =A0use_acpi_pci_hotplug, true),
>     >=A0 =A0 =A0 =A0 =A0+ DEFINE_PROP_BOOL("acpi-pci-hotunplug-enable-bri=
dge",
>     PIIX4PMState,
>     >=A0 =A0 =A0 =A0 =A0+ use_acpi_unplug, true),
>     >=A0 =A0 =A0 =A0 =A0DEFINE_PROP_BOOL("memory-hotplug-support", PIIX4P=
MState,
>     >=A0 =A0 =A0 =A0 =A0acpi_memory_hotplug.is_enabled, true),
>     >=A0 =A0 =A0 =A0 =A0DEFINE_PROP_END_OF_LIST(),
>     >=A0 =A0 =A0 =A0 =A0diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-=
build.c
>     >=A0 =A0 =A0 =A0 =A0index 23c77ee..71b3ac3 100644
>     >=A0 =A0 =A0 =A0 =A0--- a/hw/i386/acpi-build.c
>     >=A0 =A0 =A0 =A0 =A0+++ b/hw/i386/acpi-build.c
>     >=A0 =A0 =A0 =A0 =A0@@ -96,6 +96,7 @@ typedef struct AcpiPmInfo {
>     >=A0 =A0 =A0 =A0 =A0bool s3_disabled;
>     >=A0 =A0 =A0 =A0 =A0bool s4_disabled;
>     >=A0 =A0 =A0 =A0 =A0bool pcihp_bridge_en;
>     >=A0 =A0 =A0 =A0 =A0+ bool pcihup_bridge_en;
>     >=A0 =A0 =A0 =A0 =A0uint8_t s4_val;
>     >=A0 =A0 =A0 =A0 =A0AcpiFadtData fadt;
>     >=A0 =A0 =A0 =A0 =A0uint16_t cpu_hp_io_base;
>     >=A0 =A0 =A0 =A0 =A0@@ -240,6 +241,9 @@ static void acpi_get_pm_info(=
MachineState
>     *machine,
>     >=A0 =A0 =A0 =A0 =A0AcpiPmInfo *pm)
>     >=A0 =A0 =A0 =A0 =A0pm->pcihp_bridge_en =3D
>     >=A0 =A0 =A0 =A0 =A0object_property_get_bool(obj,
>     "acpi-pci-hotplug-with-bridge-support",
>     >=A0 =A0 =A0 =A0 =A0NULL);
>     >=A0 =A0 =A0 =A0 =A0+ pm->pcihup_bridge_en =3D
>     >=A0 =A0 =A0 =A0 =A0+ object_property_get_bool(obj,
>     "acpi-pci-hotunplug-enable-bridge",
>     >=A0 =A0 =A0 =A0 =A0+ NULL);
>     >=A0 =A0 =A0 =A0 =A0}
>     >
>     >=A0 =A0 =A0 =A0 =A0static void acpi_get_misc_info(AcpiMiscInfo *info=
)
>     >=A0 =A0 =A0 =A0 =A0@@ -451,7 +455,8 @@ static void build_append_pcih=
p_notify_entry
>     (Aml
>     >=A0 =A0 =A0 =A0 =A0*method, int slot)
>     >=A0 =A0 =A0 =A0 =A0}
>     >
>     >=A0 =A0 =A0 =A0 =A0static void build_append_pci_bus_devices(Aml *par=
ent_scope,
>     PCIBus
>     >=A0 =A0 =A0 =A0 =A0*bus,
>     >=A0 =A0 =A0 =A0 =A0- bool pcihp_bridge_en)
>     >=A0 =A0 =A0 =A0 =A0+ bool pcihp_bridge_en,
>     >=A0 =A0 =A0 =A0 =A0+ bool pcihup_bridge_en)
>     >=A0 =A0 =A0 =A0 =A0{
>     >=A0 =A0 =A0 =A0 =A0Aml *dev, *notify_method =3D NULL, *method;
>     >=A0 =A0 =A0 =A0 =A0QObject *bsel;
>     >=A0 =A0 =A0 =A0 =A0@@ -479,11 +484,14 @@ static void build_append_pc=
i_bus_devices
>     (Aml
>     >=A0 =A0 =A0 =A0 =A0*parent_scope, PCIBus *bus,
>     >=A0 =A0 =A0 =A0 =A0dev =3D aml_device("S%.02X", PCI_DEVFN(slot, 0));
>     >=A0 =A0 =A0 =A0 =A0aml_append(dev, aml_name_decl("_SUN", aml_int(slo=
t)));
>     >=A0 =A0 =A0 =A0 =A0aml_append(dev, aml_name_decl("_ADR", aml_int(slo=
t << 16)));
>     >=A0 =A0 =A0 =A0 =A0- method =3D aml_method("_EJ0", 1, AML_NOTSERIALI=
ZED);
>     >=A0 =A0 =A0 =A0 =A0- aml_append(method,
>     >=A0 =A0 =A0 =A0 =A0- aml_call2("PCEJ", aml_name("BSEL"), aml_name("_=
SUN"))
>     >=A0 =A0 =A0 =A0 =A0- );
>     >=A0 =A0 =A0 =A0 =A0- aml_append(dev, method);
>     >=A0 =A0 =A0 =A0 =A0+ if (pcihup_bridge_en || pci_bus_is_root(bus)) {
>     >=A0 =A0 =A0 =A0 =A0+ method =3D aml_method("_EJ0", 1, AML_NOTSERIALI=
ZED);
>     >=A0 =A0 =A0 =A0 =A0+ aml_append(method,
>     >=A0 =A0 =A0 =A0 =A0+ aml_call2("PCEJ", aml_name("BSEL"),
>     >=A0 =A0 =A0 =A0 =A0+ aml_name("_SUN"))
>     >=A0 =A0 =A0 =A0 =A0+ );
>     >=A0 =A0 =A0 =A0 =A0+ aml_append(dev, method);
>     >=A0 =A0 =A0 =A0 =A0+ }
>     >=A0 =A0 =A0 =A0 =A0aml_append(parent_scope, dev);
>     >
>     >=A0 =A0 =A0 =A0 =A0build_append_pcihp_notify_entry(notify_method, sl=
ot);
>     >=A0 =A0 =A0 =A0 =A0@@ -537,12 +545,14 @@ static void build_append_pc=
i_bus_devices
>     (Aml
>     >=A0 =A0 =A0 =A0 =A0*parent_scope, PCIBus *bus,
>     >=A0 =A0 =A0 =A0 =A0/* add _SUN/_EJ0 to make slot hotpluggable */
>     >=A0 =A0 =A0 =A0 =A0aml_append(dev, aml_name_decl("_SUN", aml_int(slo=
t)));
>     >
>     >=A0 =A0 =A0 =A0 =A0- method =3D aml_method("_EJ0", 1, AML_NOTSERIALI=
ZED);
>     >=A0 =A0 =A0 =A0 =A0- aml_append(method,
>     >=A0 =A0 =A0 =A0 =A0- aml_call2("PCEJ", aml_name("BSEL"), aml_name("_=
SUN"))
>     >=A0 =A0 =A0 =A0 =A0- );
>     >=A0 =A0 =A0 =A0 =A0- aml_append(dev, method);
>     >=A0 =A0 =A0 =A0 =A0-
>     >=A0 =A0 =A0 =A0 =A0+ if (pcihup_bridge_en || pci_bus_is_root(bus)) {
>     >=A0 =A0 =A0 =A0 =A0+ method =3D aml_method("_EJ0", 1, AML_NOTSERIALI=
ZED);
>     >=A0 =A0 =A0 =A0 =A0+ aml_append(method,
>     >=A0 =A0 =A0 =A0 =A0+ aml_call2("PCEJ", aml_name("BSEL"),
>     >=A0 =A0 =A0 =A0 =A0+ aml_name("_SUN"))
>     >=A0 =A0 =A0 =A0 =A0+ );
>     >=A0 =A0 =A0 =A0 =A0+ aml_append(dev, method);
>     >=A0 =A0 =A0 =A0 =A0+ }
>     >=A0 =A0 =A0 =A0 =A0if (bsel) {
>     >=A0 =A0 =A0 =A0 =A0build_append_pcihp_notify_entry(notify_method, sl=
ot);
>     >=A0 =A0 =A0 =A0 =A0}
>     >=A0 =A0 =A0 =A0 =A0@@ -553,7 +563,8 @@ static void build_append_pci_=
bus_devices(Aml
>     >=A0 =A0 =A0 =A0 =A0*parent_scope, PCIBus *bus,
>     >=A0 =A0 =A0 =A0 =A0*/
>     >=A0 =A0 =A0 =A0 =A0PCIBus *sec_bus =3D pci_bridge_get_sec_bus(PCI_BR=
IDGE(pdev));
>     >
>     >=A0 =A0 =A0 =A0 =A0- build_append_pci_bus_devices(dev, sec_bus, pcih=
p_bridge_en);
>     >=A0 =A0 =A0 =A0 =A0+ build_append_pci_bus_devices(dev, sec_bus, pcih=
p_bridge_en,
>     >=A0 =A0 =A0 =A0 =A0+ pcihup_bridge_en);
>     >=A0 =A0 =A0 =A0 =A0}
>     >=A0 =A0 =A0 =A0 =A0/* slot descriptor has been composed, add it into=
 parent context
>     */
>     >=A0 =A0 =A0 =A0 =A0aml_append(parent_scope, dev);
>     >=A0 =A0 =A0 =A0 =A0@@ -2196,7 +2207,8 @@ build_dsdt(GArray *table_da=
ta, BIOSLinker
>     >=A0 =A0 =A0 =A0 =A0*linker,
>     >=A0 =A0 =A0 =A0 =A0if (bus) {
>     >=A0 =A0 =A0 =A0 =A0Aml *scope =3D aml_scope("PCI0");
>     >=A0 =A0 =A0 =A0 =A0/* Scan all PCI buses. Generate tables to support=
 hotplug. */
>     >=A0 =A0 =A0 =A0 =A0- build_append_pci_bus_devices(scope, bus, pm->pc=
ihp_bridge_en);
>     >=A0 =A0 =A0 =A0 =A0+ build_append_pci_bus_devices(scope, bus, pm->pc=
ihp_bridge_en,
>     >=A0 =A0 =A0 =A0 =A0+ pm->pcihup_bridge_en);
>     >
>     >=A0 =A0 =A0 =A0 =A0if (TPM_IS_TIS_ISA(tpm)) {
>     >=A0 =A0 =A0 =A0 =A0if (misc->tpm_version =3D=3D TPM_VERSION_2_0) {
>     >=A0 =A0 =A0 =A0 =A0--
>     >=A0 =A0 =A0 =A0 =A01.9.4
>     >
>     >
>     >
>=20
>=20


