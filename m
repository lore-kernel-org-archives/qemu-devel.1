Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24416C83008
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:40:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0648206D6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aHfXlTr+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0648206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTTH8-00013x-Tn
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 12:40:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34254)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jTTEx-00065Q-VD
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:38:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jTTBM-0000n8-PP
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:37:46 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55206
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jTTBM-0000m3-84
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588091642;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BDkdFG+bkTOis+mSoj8h262MmHFr5sQnDyX+fBxwEo8=;
 b=aHfXlTr+e9cyhhVjaTUXF8QVQQ7ak/TPhJQIgNhbW7h/e1oDKOZzalq3ySM4G4B7ikyhS4
 CvvgXhsNhKVVLWLgJES+HIYn8ZdWKxdT2UUGm8FGiUi2ucOdR7ErHbmXRzbFezbuPRYC/p
 GlIX2l6GHdfxKp8fONeDGt11ndU6CXQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-XK533HUzPMCxc8ewInbPLg-1; Tue, 28 Apr 2020 12:33:18 -0400
X-MC-Unique: XK533HUzPMCxc8ewInbPLg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32E901B18BC1;
 Tue, 28 Apr 2020 16:33:17 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BBB51648C1;
 Tue, 28 Apr 2020 16:33:11 +0000 (UTC)
Date: Tue, 28 Apr 2020 17:33:08 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V2] Add a new PIIX option to control PCI hot unplugging
 of devices on non-root buses
Message-ID: <20200428163308.GA1492846@redhat.com>
References: <1588069012-211196-1-git-send-email-ani.sinha@nutanix.com>
 <20200428120426-mutt-send-email-mst@kernel.org>
 <20200428162836.GI1374620@redhat.com>
 <20200428122931-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20200428122931-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Ani Sinha <ani.sinha@nutanix.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-devel@nongnu.org, Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, ani@anisinha.ca,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Apr 28, 2020 at 12:30:53PM -0400, Michael S. Tsirkin wrote:
> On Tue, Apr 28, 2020 at 05:28:36PM +0100, Daniel P. Berrang=C3=A9 wrote:
> > On Tue, Apr 28, 2020 at 12:05:47PM -0400, Michael S. Tsirkin wrote:
> > > On Tue, Apr 28, 2020 at 10:16:52AM +0000, Ani Sinha wrote:
> > > > A new option "use_acpi_unplug" is introduced for PIIX which will
> > > > selectively only disable hot unplugging of both hot plugged and
> > > > cold plugged PCI devices on non-root PCI buses. This will prevent
> > > > hot unplugging of devices from Windows based guests from system
> > > > tray but will not prevent devices from being hot plugged into the
> > > > guest.
> > > >=20
> > > > It has been tested on Windows guests.
> > > >=20
> > > > Signed-off-by: Ani Sinha <ani.sinha@nutanix.com>
> > >=20
> > > It's still a non starter until we find something similar for PCIE and
> > > SHPC. Do guests check command status? Can some unplug commands fail?
> >=20
> > Why does PCIE need anything ? For that we already have ability to
> > control hotplugging per-slot in pcie-root-port.
>=20
> At the moment that does not support unplug of hotplugged devices.

I don't see why this patch has to deal with that limitation though,
it is a independant problem from this patch which is PCI focused,
not PCIe.

>=20
>=20
> > If SHPC doesn't
> > support this that's fine too, it isn't a reason to block its merge
> > and use with x86 i440fx machine.
> >=20
> > >=20
> > >=20
> > > > ---
> > > >  hw/acpi/piix4.c      |  3 +++
> > > >  hw/i386/acpi-build.c | 40 ++++++++++++++++++++++++++--------------
> > > >  2 files changed, 29 insertions(+), 14 deletions(-)
> > > >=20
> > > > diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> > > > index 964d6f5..59fa707 100644
> > > > --- a/hw/acpi/piix4.c
> > > > +++ b/hw/acpi/piix4.c
> > > > @@ -78,6 +78,7 @@ typedef struct PIIX4PMState {
> > > > =20
> > > >      AcpiPciHpState acpi_pci_hotplug;
> > > >      bool use_acpi_pci_hotplug;
> > > > +    bool use_acpi_unplug;
> > > > =20
> > > >      uint8_t disable_s3;
> > > >      uint8_t disable_s4;
> > > > @@ -633,6 +634,8 @@ static Property piix4_pm_properties[] =3D {
> > > >      DEFINE_PROP_UINT8(ACPI_PM_PROP_S4_VAL, PIIX4PMState, s4_val, 2=
),
> > > >      DEFINE_PROP_BOOL("acpi-pci-hotplug-with-bridge-support", PIIX4=
PMState,
> > > >                       use_acpi_pci_hotplug, true),
> > > > +    DEFINE_PROP_BOOL("acpi-pci-hotunplug-enable-bridge", PIIX4PMSt=
ate,
> > > > +                     use_acpi_unplug, true),
> > > >      DEFINE_PROP_BOOL("memory-hotplug-support", PIIX4PMState,
> > > >                       acpi_memory_hotplug.is_enabled, true),
> > > >      DEFINE_PROP_END_OF_LIST(),
> > > > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > > > index 23c77ee..71b3ac3 100644
> > > > --- a/hw/i386/acpi-build.c
> > > > +++ b/hw/i386/acpi-build.c
> > > > @@ -96,6 +96,7 @@ typedef struct AcpiPmInfo {
> > > >      bool s3_disabled;
> > > >      bool s4_disabled;
> > > >      bool pcihp_bridge_en;
> > > > +    bool pcihup_bridge_en;
> > > >      uint8_t s4_val;
> > > >      AcpiFadtData fadt;
> > > >      uint16_t cpu_hp_io_base;
> > > > @@ -240,6 +241,9 @@ static void acpi_get_pm_info(MachineState *mach=
ine, AcpiPmInfo *pm)
> > > >      pm->pcihp_bridge_en =3D
> > > >          object_property_get_bool(obj, "acpi-pci-hotplug-with-bridg=
e-support",
> > > >                                   NULL);
> > > > +    pm->pcihup_bridge_en =3D
> > > > +        object_property_get_bool(obj, "acpi-pci-hotunplug-enable-b=
ridge",
> > > > +                                 NULL);
> > > >  }
> > > > =20
> > > >  static void acpi_get_misc_info(AcpiMiscInfo *info)
> > > > @@ -451,7 +455,8 @@ static void build_append_pcihp_notify_entry(Aml=
 *method, int slot)
> > > >  }
> > > > =20
> > > >  static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus=
 *bus,
> > > > -                                         bool pcihp_bridge_en)
> > > > +                                         bool pcihp_bridge_en,
> > > > +                                         bool pcihup_bridge_en)
> > > >  {
> > > >      Aml *dev, *notify_method =3D NULL, *method;
> > > >      QObject *bsel;
> > > > @@ -479,11 +484,14 @@ static void build_append_pci_bus_devices(Aml =
*parent_scope, PCIBus *bus,
> > > >                  dev =3D aml_device("S%.02X", PCI_DEVFN(slot, 0));
> > > >                  aml_append(dev, aml_name_decl("_SUN", aml_int(slot=
)));
> > > >                  aml_append(dev, aml_name_decl("_ADR", aml_int(slot=
 << 16)));
> > > > -                method =3D aml_method("_EJ0", 1, AML_NOTSERIALIZED=
);
> > > > -                aml_append(method,
> > > > -                    aml_call2("PCEJ", aml_name("BSEL"), aml_name("=
_SUN"))
> > > > -                );
> > > > -                aml_append(dev, method);
> > > > +                if (pcihup_bridge_en || pci_bus_is_root(bus)) {
> > > > +                    method =3D aml_method("_EJ0", 1, AML_NOTSERIAL=
IZED);
> > > > +                    aml_append(method,
> > > > +                               aml_call2("PCEJ", aml_name("BSEL"),
> > > > +                                         aml_name("_SUN"))
> > > > +                        );
> > > > +                    aml_append(dev, method);
> > > > +                }
> > > >                  aml_append(parent_scope, dev);
> > > > =20
> > > >                  build_append_pcihp_notify_entry(notify_method, slo=
t);
> > > > @@ -537,12 +545,14 @@ static void build_append_pci_bus_devices(Aml =
*parent_scope, PCIBus *bus,
> > > >              /* add _SUN/_EJ0 to make slot hotpluggable  */
> > > >              aml_append(dev, aml_name_decl("_SUN", aml_int(slot)));
> > > > =20
> > > > -            method =3D aml_method("_EJ0", 1, AML_NOTSERIALIZED);
> > > > -            aml_append(method,
> > > > -                aml_call2("PCEJ", aml_name("BSEL"), aml_name("_SUN=
"))
> > > > -            );
> > > > -            aml_append(dev, method);
> > > > -
> > > > +            if (pcihup_bridge_en || pci_bus_is_root(bus)) {
> > > > +                method =3D aml_method("_EJ0", 1, AML_NOTSERIALIZED=
);
> > > > +                aml_append(method,
> > > > +                           aml_call2("PCEJ", aml_name("BSEL"),
> > > > +                                     aml_name("_SUN"))
> > > > +                    );
> > > > +                aml_append(dev, method);
> > > > +            }
> > > >              if (bsel) {
> > > >                  build_append_pcihp_notify_entry(notify_method, slo=
t);
> > > >              }
> > > > @@ -553,7 +563,8 @@ static void build_append_pci_bus_devices(Aml *p=
arent_scope, PCIBus *bus,
> > > >               */
> > > >              PCIBus *sec_bus =3D pci_bridge_get_sec_bus(PCI_BRIDGE(=
pdev));
> > > > =20
> > > > -            build_append_pci_bus_devices(dev, sec_bus, pcihp_bridg=
e_en);
> > > > +            build_append_pci_bus_devices(dev, sec_bus, pcihp_bridg=
e_en,
> > > > +                                         pcihup_bridge_en);
> > > >          }
> > > >          /* slot descriptor has been composed, add it into parent c=
ontext */
> > > >          aml_append(parent_scope, dev);
> > > > @@ -2196,7 +2207,8 @@ build_dsdt(GArray *table_data, BIOSLinker *li=
nker,
> > > >          if (bus) {
> > > >              Aml *scope =3D aml_scope("PCI0");
> > > >              /* Scan all PCI buses. Generate tables to support hotp=
lug. */
> > > > -            build_append_pci_bus_devices(scope, bus, pm->pcihp_bri=
dge_en);
> > > > +            build_append_pci_bus_devices(scope, bus, pm->pcihp_bri=
dge_en,
> > > > +                                         pm->pcihup_bridge_en);
> > > > =20
> > > >              if (TPM_IS_TIS_ISA(tpm)) {
> > > >                  if (misc->tpm_version =3D=3D TPM_VERSION_2_0) {
> > > > --=20
> > > > 1.9.4
> > >=20
> > >=20
> >=20
> > Regards,
> > Daniel
> > --=20
> > |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> > |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> > |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


