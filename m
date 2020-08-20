Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7C5C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 09:24:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9D7D22CE3
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 09:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="u7ReBjW3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9D7D22CE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8gnt-000076-VZ
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 05:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1k8gmj-0007GT-Lv
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 05:23:01 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45522)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1k8gmh-0002ws-Id
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 05:23:01 -0400
Received: by mail-wr1-x441.google.com with SMTP id z18so1293573wrm.12
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 02:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=3jJCb4qoAzH9kDZz4LVmAbFOZI2+0ILxucgj/GAiGrs=;
 b=u7ReBjW3worY+9nnvyeZ9eAP/IhlLfol/bCymQ5zvISZgRVEbuRRSYXP2GbGcO1JBh
 2PWgqku44FkA8P6zRn7YRsS+qLcQWv3vClRThQyIp5tjn8z3EvWDqdYwMrlZHzgffxLi
 Fu0unTTjmLz87AXCeXOPtJ2fTWIvMzDUgkkdsEaSqO/s8Vyt0LvVgCqEeZEvqCT5vpx4
 51GXxHL62LzuYcXaGF8vZIJLdus8/04xs4y3u8CyzWyLN/y19J7e9yPYg2NlSN523B1n
 HhX/hjmd5Ha6HzMdrEQz+m/xWNpoFk96sPkQMuBzEQV3zAGXfNdm+05dQATuVcx4ogKz
 rjkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=3jJCb4qoAzH9kDZz4LVmAbFOZI2+0ILxucgj/GAiGrs=;
 b=lPCKwEEFsd7GWr+tH2F7JKANrP9wGrM0xotWidr8CGlqAUXSEmOjJh5/bz9GYrwgcA
 hzMuI/vT22nfFGk6ktgl0O6YHsdNzj7nLXd9WT/GggqT5HHOGRH1CRgI7LR6/ibsqFKF
 VANZUMsLZ43S7Uw8VnpRCp6kKULhdWtIeBJ1FlL/0enEDpaQFrBZksAIlliqLCnoPKjx
 Jnsp0s7jw7ESvwUseE0hNoNCv/AU8jP3jgtteijM4POIqoOP1jbk47afiCc5uB/9YcK1
 z0rPX+04iZhjsPGBUzCgl4GZhUnZ97EoOCRaTjf8U0f/Sm/gU6Jaeaz8bLb0K9jyjssS
 CuHA==
X-Gm-Message-State: AOAM531Kv/h4caA0vk6qYqVEzYat1+6WHDhmyNmVoqNl5lwP0zEReEdV
 E6BIDnHOnSDFiI24kC9dk3zjhbJ5jMATfCjb+HQxzg==
X-Google-Smtp-Source: ABdhPJz1ADy9FUfzzJ3j6Vv2vpyzAqZKOumW70F3Pw+eB3u7NsXvyotIKVMFw+11IVEVnr5CertVrTW+0/Z0HdMNkfk=
X-Received: by 2002:adf:9c8c:: with SMTP id d12mr2192456wre.369.1597915377886; 
 Thu, 20 Aug 2020 02:22:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200820081659.17328-1-ani@anisinha.ca>
 <447c3e1d-ab86-13bd-4699-d791c1bc1d0d@redhat.com>
In-Reply-To: <447c3e1d-ab86-13bd-4699-d791c1bc1d0d@redhat.com>
From: Ani Sinha <ani@anisinha.ca>
Date: Thu, 20 Aug 2020 14:52:46 +0530
Message-ID: <CAARzgwxB+6At5nRw3f5TTu50bgc2SjNtnhf1Au6vtpH5yncP1w@mail.gmail.com>
Subject: Re: [PATCH V5] Introduce a new flag for i440fx to disable PCI hotplug
 on the root bus
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2a00:1450:4864:20::441;
 envelope-from=ani@anisinha.ca; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 20, 2020 at 2:21 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> On 8/20/20 10:16 AM, Ani Sinha wrote:
> > We introduce a new global flag 'acpi-root-pci-hotplug' for i440fx with =
which
> > we can turn on or off PCI device hotplug on the root bus. This flag can=
 be
> > used to prevent all PCI devices from getting hotplugged or unplugged fr=
om the
> > root PCI bus.
> > This feature is targetted mostly towards Windows VMs. It is useful in c=
ases
> > where some hypervisor admins want to deploy guest VMs in a way so that =
the
> > users of the guest OSes are not able to hot-eject certain PCI devices f=
rom
> > the Windows system tray. Laine has explained the use case here in detai=
l:
> > https://www.redhat.com/archives/libvir-list/2020-February/msg00110.html
> >
> > Julia has resolved this issue for PCIE buses with the following commit:
> > 530a0963184e57e71a5b538 ("pcie_root_port: Add hotplug disabling option"=
)
> >
> > This commit attempts to introduce similar behavior for PCI root buses u=
sed in
> > i440fx machine types (although in this case, we do not have a per-slot
> > capability to turn hotplug on or off).
> >
> > Usage:
> >    -global PIIX4_PM.acpi-root-pci-hotplug=3Doff
> >
> > By default, this option is enabled which means that hotplug is turned o=
n for
> > the PCI root bus.
> >
> > The previously existing flag 'acpi-pci-hotplug-with-bridge-support' for=
 PCI-PCI
> > bridges remain as is and can be used along with this new flag to contro=
l PCI
> > hotplug on PCI bridges.
> >
> > This change has been tested using a Windows 2012R2 server guest image a=
nd also
> > with a Windows 2019 server guest image on a Ubuntu 18.04 host using the=
 latest
> > master qemu from upstream.
>
> "latest master qemu from upstream" -> "v5.1.0 tag"

Addressed in V6.

>
> >
> > Signed-off-by: Ani Sinha <ani@anisinha.ca>
> > ---
> >  hw/acpi/piix4.c      |  8 ++++++--
> >  hw/i386/acpi-build.c | 26 +++++++++++++++++++-------
> >  2 files changed, 25 insertions(+), 9 deletions(-)
> >
> > Change Log:
> > V4..V5: Updated commit message to reflect the fact that testing was als=
o
> > performed on a Windows 2019 server guest image. Minor commit log format=
ting
> > to make sure 80 col rule is enforced.
> >
> > diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> > index 26bac4f16c..4f436e5bf3 100644
> > --- a/hw/acpi/piix4.c
> > +++ b/hw/acpi/piix4.c
> > @@ -78,6 +78,7 @@ typedef struct PIIX4PMState {
> >
> >      AcpiPciHpState acpi_pci_hotplug;
> >      bool use_acpi_hotplug_bridge;
> > +    bool use_acpi_root_pci_hotplug;
> >
> >      uint8_t disable_s3;
> >      uint8_t disable_s4;
> > @@ -595,8 +596,9 @@ static void piix4_acpi_system_hot_add_init(MemoryRe=
gion *parent,
> >                            "acpi-gpe0", GPE_LEN);
> >      memory_region_add_subregion(parent, GPE_BASE, &s->io_gpe);
> >
> > -    acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, parent,
> > -                    s->use_acpi_hotplug_bridge);
> > +    if (s->use_acpi_hotplug_bridge || s->use_acpi_root_pci_hotplug)
> > +        acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, parent,
> > +                        s->use_acpi_hotplug_bridge);
> >
> >      s->cpu_hotplug_legacy =3D true;
> >      object_property_add_bool(OBJECT(s), "cpu-hotplug-legacy",
> > @@ -635,6 +637,8 @@ static Property piix4_pm_properties[] =3D {
> >      DEFINE_PROP_UINT8(ACPI_PM_PROP_S4_VAL, PIIX4PMState, s4_val, 2),
> >      DEFINE_PROP_BOOL("acpi-pci-hotplug-with-bridge-support", PIIX4PMSt=
ate,
> >                       use_acpi_hotplug_bridge, true),
> > +    DEFINE_PROP_BOOL("acpi-root-pci-hotplug", PIIX4PMState,
> > +                     use_acpi_root_pci_hotplug, true),
> >      DEFINE_PROP_BOOL("memory-hotplug-support", PIIX4PMState,
> >                       acpi_memory_hotplug.is_enabled, true),
> >      DEFINE_PROP_END_OF_LIST(),
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index b7bcbbbb2a..19a1702ad1 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -95,6 +95,7 @@ typedef struct AcpiPmInfo {
> >      bool s3_disabled;
> >      bool s4_disabled;
> >      bool pcihp_bridge_en;
> > +    bool pcihp_root_en;
> >      uint8_t s4_val;
> >      AcpiFadtData fadt;
> >      uint16_t cpu_hp_io_base;
> > @@ -245,6 +246,9 @@ static void acpi_get_pm_info(MachineState *machine,=
 AcpiPmInfo *pm)
> >      pm->pcihp_bridge_en =3D
> >          object_property_get_bool(obj, "acpi-pci-hotplug-with-bridge-su=
pport",
> >                                   NULL);
> > +    pm->pcihp_root_en =3D
> > +        object_property_get_bool(obj, "acpi-root-pci-hotplug", NULL);
> > +
> >  }
> >
> >  static void acpi_get_misc_info(AcpiMiscInfo *info)
> > @@ -337,15 +341,18 @@ static void build_append_pcihp_notify_entry(Aml *=
method, int slot)
> >  }
> >
> >  static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bu=
s,
> > -                                         bool pcihp_bridge_en)
> > +                                         bool pcihp_bridge_en,
> > +                                         bool pcihp_root_en)
> >  {
> >      Aml *dev, *notify_method =3D NULL, *method;
> >      QObject *bsel;
> >      PCIBus *sec;
> >      int i;
> > +    bool root_bus =3D pci_bus_is_root(bus);
> > +    bool root_pcihp_disabled =3D (root_bus && !pcihp_root_en);
> >
> >      bsel =3D object_property_get_qobject(OBJECT(bus), ACPI_PCIHP_PROP_=
BSEL, NULL);
> > -    if (bsel) {
> > +    if (bsel && !root_pcihp_disabled) {
> >          uint64_t bsel_val =3D qnum_get_uint(qobject_to(QNum, bsel));
> >
> >          aml_append(parent_scope, aml_name_decl("BSEL", aml_int(bsel_va=
l)));
> > @@ -361,6 +368,9 @@ static void build_append_pci_bus_devices(Aml *paren=
t_scope, PCIBus *bus,
> >          bool bridge_in_acpi;
> >
> >          if (!pdev) {
> > +            /* skip if pci hotplug for the root bus is disabled */
> > +            if (root_pcihp_disabled)
> > +                continue;
> >              if (bsel) { /* add hotplug slots for non present devices *=
/
> >                  dev =3D aml_device("S%.02X", PCI_DEVFN(slot, 0));
> >                  aml_append(dev, aml_name_decl("_SUN", aml_int(slot)));
> > @@ -419,7 +429,7 @@ static void build_append_pci_bus_devices(Aml *paren=
t_scope, PCIBus *bus,
> >              method =3D aml_method("_S3D", 0, AML_NOTSERIALIZED);
> >              aml_append(method, aml_return(aml_int(s3d)));
> >              aml_append(dev, method);
> > -        } else if (hotplug_enabled_dev) {
> > +        } else if (hotplug_enabled_dev && !root_pcihp_disabled) {
> >              /* add _SUN/_EJ0 to make slot hotpluggable  */
> >              aml_append(dev, aml_name_decl("_SUN", aml_int(slot)));
> >
> > @@ -439,13 +449,14 @@ static void build_append_pci_bus_devices(Aml *par=
ent_scope, PCIBus *bus,
> >               */
> >              PCIBus *sec_bus =3D pci_bridge_get_sec_bus(PCI_BRIDGE(pdev=
));
> >
> > -            build_append_pci_bus_devices(dev, sec_bus, pcihp_bridge_en=
);
> > +            build_append_pci_bus_devices(dev, sec_bus, pcihp_bridge_en=
,
> > +                                         pcihp_root_en);
> >          }
> >          /* slot descriptor has been composed, add it into parent conte=
xt */
> >          aml_append(parent_scope, dev);
> >      }
> >
> > -    if (bsel) {
> > +    if (bsel && !root_pcihp_disabled) {
> >          aml_append(parent_scope, notify_method);
> >      }
> >
> > @@ -455,7 +466,7 @@ static void build_append_pci_bus_devices(Aml *paren=
t_scope, PCIBus *bus,
> >      method =3D aml_method("PCNT", 0, AML_NOTSERIALIZED);
> >
> >      /* If bus supports hotplug select it and notify about local events=
 */
> > -    if (bsel) {
> > +    if (bsel && !root_pcihp_disabled) {
> >          uint64_t bsel_val =3D qnum_get_uint(qobject_to(QNum, bsel));
> >
> >          aml_append(method, aml_store(aml_int(bsel_val), aml_name("BNUM=
")));
> > @@ -1818,7 +1829,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker=
,
> >          if (bus) {
> >              Aml *scope =3D aml_scope("PCI0");
> >              /* Scan all PCI buses. Generate tables to support hotplug.=
 */
> > -            build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_=
en);
> > +            build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_=
en,
> > +                                         pm->pcihp_root_en);
> >
> >              if (TPM_IS_TIS_ISA(tpm)) {
> >                  if (misc->tpm_version =3D=3D TPM_VERSION_2_0) {
> >
>

