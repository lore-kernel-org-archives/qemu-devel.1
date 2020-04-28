Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CD0C83008
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:25:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BC68206D8
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GkYGfwy1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BC68206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTT3R-0006oy-77
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 12:25:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60790)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jTSz1-0000U6-EG
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:21:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jTSyv-0001Vt-7g
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:21:19 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48116
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jTSyu-0001Rt-Lv
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:21:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588090871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=luNnCEHXVRPuOI/83hxEtNARuPMc7xD2N3g3EXr/sZo=;
 b=GkYGfwy1UC/CiboLFZBBgURCVYQ2+D6vx2iF1mWg0hFub/ady8yR+xM79/DFgT8BOieeKd
 hftJKjt1JCU0dNcG7cZ8YZtQhuUq0kcGvMOoC7dBL1IXxdJ846qfsZXfbAQlmcnnQu28Il
 Z6rRJhwClROGhAuvglFFX6m1fobYbVw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-thNWaNfJNRm3N_gmfqbG4g-1; Tue, 28 Apr 2020 12:21:10 -0400
X-MC-Unique: thNWaNfJNRm3N_gmfqbG4g-1
Received: by mail-wm1-f70.google.com with SMTP id h22so1311692wml.1
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 09:21:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/eEEbIhAIcvONndBeBbvwWiAUqLIZvx4LmMWSwiv+0Q=;
 b=fJ1zywfYKVgRFV5cw4OPZ9vtG6FmphCRQ9I5aWdnNYbv+sLz9ezun1NbwLsvp70X89
 y0TuL4U2hpxyd06qqlsvTuK+r1UR+fqgQHAD9+cnvlIn3/CfqMHWZHWMPbrCPWMgmwSX
 F8e5KNXPOLzrhxDWMYL+d1W8RihIT9jPfsvaAoldv5IWoiDxZCyHOqgpnQcGjCF3ucxP
 ERz/dqgycb9fsUcbGqm2igeGMLYuV5j1dqauJev5tPOvZdQw9Lhl+k2X768QEm9mmoPm
 Ye/8deXDo3PLyBc0wh+BAtBDvRwuBpn3B9VzRENGOJlhiZs3ERtdfKfSvOSyeuNjA5u0
 T8Gw==
X-Gm-Message-State: AGi0Pua6yJHOFUwr8a6MdjXDE3aI/ui1uWTpMnVw29z8dV+tsiWM1jdD
 /OIwX7/P7KS9e5AZUi+oKpNNAjk/JeazPzSaX9cWM6f7Yn17V4XS9mSrUGH60TTPEpy2B+e6aW7
 iQFa9//sAibq9Eng=
X-Received: by 2002:adf:a11a:: with SMTP id o26mr33464635wro.284.1588090869236; 
 Tue, 28 Apr 2020 09:21:09 -0700 (PDT)
X-Google-Smtp-Source: APiQypKVqjeD4BfRegmtDTyWnPH/HWijzt+WfPih7Py/azU2YVpUjeBauO++WwnfkRaFKWQGrCrzWQ==
X-Received: by 2002:adf:a11a:: with SMTP id o26mr33464613wro.284.1588090868940; 
 Tue, 28 Apr 2020 09:21:08 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 w4sm9777513wro.28.2020.04.28.09.21.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 09:21:08 -0700 (PDT)
Date: Tue, 28 Apr 2020 12:21:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <ani@anisinha.ca>
Subject: Re: [PATCH V2] Add a new PIIX option to control PCI hot unplugging
 of devices on non-root buses
Message-ID: <20200428121837-mutt-send-email-mst@kernel.org>
References: <1588069012-211196-1-git-send-email-ani.sinha@nutanix.com>
 <20200428120426-mutt-send-email-mst@kernel.org>
 <67e481a5-de04-4e01-b9ec-70932194d69f@Spark>
MIME-Version: 1.0
In-Reply-To: <67e481a5-de04-4e01-b9ec-70932194d69f@Spark>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 02:06:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

On Tue, Apr 28, 2020 at 09:39:16PM +0530, Ani Sinha wrote:
>=20
> Ani
> On Apr 28, 2020, 21:35 +0530, Michael S. Tsirkin <mst@redhat.com>, wrote:
>=20
>     On Tue, Apr 28, 2020 at 10:16:52AM +0000, Ani Sinha wrote:
>=20
>         A new option "use_acpi_unplug" is introduced for PIIX which will
>         selectively only disable hot unplugging of both hot plugged and
>         cold plugged PCI devices on non-root PCI buses. This will prevent
>         hot unplugging of devices from Windows based guests from system
>         tray but will not prevent devices from being hot plugged into the
>         guest.
>=20
>         It has been tested on Windows guests.
>=20
>         Signed-off-by: Ani Sinha <ani.sinha@nutanix.com>
>=20
>=20
>     It's still a non starter until we find something similar for PCIE and
>     SHPC. Do guests check command status? Can some unplug commands fail?=
=20
>=20
>=20
> Ok I  give up! I thought we debated this on the other thread.

Sorry to hear that.
I'd rather you didn't, and worked on a solution that works for everyone.
Pushing back on merging code is unfortunately the only mechanism
maintainers have to make sure features are complete and
orthogonal to each other, so I'm not sure I can help otherwise.

>=20
>=20
>=20
>=20
>         ---
>         hw/acpi/piix4.c | 3 +++
>         hw/i386/acpi-build.c | 40 ++++++++++++++++++++++++++-------------=
-
>         2 files changed, 29 insertions(+), 14 deletions(-)
>=20
>         diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
>         index 964d6f5..59fa707 100644
>         --- a/hw/acpi/piix4.c
>         +++ b/hw/acpi/piix4.c
>         @@ -78,6 +78,7 @@ typedef struct PIIX4PMState {
>=20
>         AcpiPciHpState acpi_pci_hotplug;
>         bool use_acpi_pci_hotplug;
>         + bool use_acpi_unplug;
>=20
>         uint8_t disable_s3;
>         uint8_t disable_s4;
>         @@ -633,6 +634,8 @@ static Property piix4_pm_properties[] =3D {
>         DEFINE_PROP_UINT8(ACPI_PM_PROP_S4_VAL, PIIX4PMState, s4_val, 2),
>         DEFINE_PROP_BOOL("acpi-pci-hotplug-with-bridge-support", PIIX4PMS=
tate,
>         use_acpi_pci_hotplug, true),
>         + DEFINE_PROP_BOOL("acpi-pci-hotunplug-enable-bridge", PIIX4PMSta=
te,
>         + use_acpi_unplug, true),
>         DEFINE_PROP_BOOL("memory-hotplug-support", PIIX4PMState,
>         acpi_memory_hotplug.is_enabled, true),
>         DEFINE_PROP_END_OF_LIST(),
>         diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>         index 23c77ee..71b3ac3 100644
>         --- a/hw/i386/acpi-build.c
>         +++ b/hw/i386/acpi-build.c
>         @@ -96,6 +96,7 @@ typedef struct AcpiPmInfo {
>         bool s3_disabled;
>         bool s4_disabled;
>         bool pcihp_bridge_en;
>         + bool pcihup_bridge_en;
>         uint8_t s4_val;
>         AcpiFadtData fadt;
>         uint16_t cpu_hp_io_base;
>         @@ -240,6 +241,9 @@ static void acpi_get_pm_info(MachineState *ma=
chine,
>         AcpiPmInfo *pm)
>         pm->pcihp_bridge_en =3D
>         object_property_get_bool(obj, "acpi-pci-hotplug-with-bridge-suppo=
rt",
>         NULL);
>         + pm->pcihup_bridge_en =3D
>         + object_property_get_bool(obj, "acpi-pci-hotunplug-enable-bridge=
",
>         + NULL);
>         }
>=20
>         static void acpi_get_misc_info(AcpiMiscInfo *info)
>         @@ -451,7 +455,8 @@ static void build_append_pcihp_notify_entry(A=
ml
>         *method, int slot)
>         }
>=20
>         static void build_append_pci_bus_devices(Aml *parent_scope, PCIBu=
s
>         *bus,
>         - bool pcihp_bridge_en)
>         + bool pcihp_bridge_en,
>         + bool pcihup_bridge_en)
>         {
>         Aml *dev, *notify_method =3D NULL, *method;
>         QObject *bsel;
>         @@ -479,11 +484,14 @@ static void build_append_pci_bus_devices(Am=
l
>         *parent_scope, PCIBus *bus,
>         dev =3D aml_device("S%.02X", PCI_DEVFN(slot, 0));
>         aml_append(dev, aml_name_decl("_SUN", aml_int(slot)));
>         aml_append(dev, aml_name_decl("_ADR", aml_int(slot << 16)));
>         - method =3D aml_method("_EJ0", 1, AML_NOTSERIALIZED);
>         - aml_append(method,
>         - aml_call2("PCEJ", aml_name("BSEL"), aml_name("_SUN"))
>         - );
>         - aml_append(dev, method);
>         + if (pcihup_bridge_en || pci_bus_is_root(bus)) {
>         + method =3D aml_method("_EJ0", 1, AML_NOTSERIALIZED);
>         + aml_append(method,
>         + aml_call2("PCEJ", aml_name("BSEL"),
>         + aml_name("_SUN"))
>         + );
>         + aml_append(dev, method);
>         + }
>         aml_append(parent_scope, dev);
>=20
>         build_append_pcihp_notify_entry(notify_method, slot);
>         @@ -537,12 +545,14 @@ static void build_append_pci_bus_devices(Am=
l
>         *parent_scope, PCIBus *bus,
>         /* add _SUN/_EJ0 to make slot hotpluggable */
>         aml_append(dev, aml_name_decl("_SUN", aml_int(slot)));
>=20
>         - method =3D aml_method("_EJ0", 1, AML_NOTSERIALIZED);
>         - aml_append(method,
>         - aml_call2("PCEJ", aml_name("BSEL"), aml_name("_SUN"))
>         - );
>         - aml_append(dev, method);
>         -
>         + if (pcihup_bridge_en || pci_bus_is_root(bus)) {
>         + method =3D aml_method("_EJ0", 1, AML_NOTSERIALIZED);
>         + aml_append(method,
>         + aml_call2("PCEJ", aml_name("BSEL"),
>         + aml_name("_SUN"))
>         + );
>         + aml_append(dev, method);
>         + }
>         if (bsel) {
>         build_append_pcihp_notify_entry(notify_method, slot);
>         }
>         @@ -553,7 +563,8 @@ static void build_append_pci_bus_devices(Aml
>         *parent_scope, PCIBus *bus,
>         */
>         PCIBus *sec_bus =3D pci_bridge_get_sec_bus(PCI_BRIDGE(pdev));
>=20
>         - build_append_pci_bus_devices(dev, sec_bus, pcihp_bridge_en);
>         + build_append_pci_bus_devices(dev, sec_bus, pcihp_bridge_en,
>         + pcihup_bridge_en);
>         }
>         /* slot descriptor has been composed, add it into parent context =
*/
>         aml_append(parent_scope, dev);
>         @@ -2196,7 +2207,8 @@ build_dsdt(GArray *table_data, BIOSLinker
>         *linker,
>         if (bus) {
>         Aml *scope =3D aml_scope("PCI0");
>         /* Scan all PCI buses. Generate tables to support hotplug. */
>         - build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_en);
>         + build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_en,
>         + pm->pcihup_bridge_en);
>=20
>         if (TPM_IS_TIS_ISA(tpm)) {
>         if (misc->tpm_version =3D=3D TPM_VERSION_2_0) {
>         --
>         1.9.4
>=20
>=20
>=20


