Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F631C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 16:42:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE54820674
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 16:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="X/ZrI/zm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE54820674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8ndx-0002d4-2r
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 12:42:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1k8ndN-0002C2-JD
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 12:41:49 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:37383)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1k8ndK-0003yq-Ln
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 12:41:49 -0400
Received: by mail-pg1-x542.google.com with SMTP id g33so1406770pgb.4
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 09:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=content-transfer-encoding:from:mime-version:subject:date:message-id
 :references:cc:in-reply-to:to;
 bh=QvKJj/eaddDD10mhCul2dONPGFGdcQfpC+PkaUPdHns=;
 b=X/ZrI/zmGfteD8oub5Wg7mvLtymJDZWXt+kFtoyStuNRHi6M4evPzBtd7TGaf76GD2
 ythD/zeKMy52Nz+1OktTgBSWwqaDqhMoYcCTmLcAZGt8wuzzHpxWAbwRGjU1oI8gzdTm
 C+xhFK1FAV1tbfKm8Jt5IIh0OD7YioCWl8ULi9SwK+JgW46n8ZcionbYT9eXO2t7AYam
 Qv4ALCcTcVXyQtpktlqH4iHXEtTLeZuaWuLssrsTRUrifNj5G60KpClq/pznQGszia1u
 aogFbh6k31DVufJs2zHKfQHlyemJp86APRAk+8+oAgBDJbr00Gvjosmtr9N14yCjNe50
 nUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=QvKJj/eaddDD10mhCul2dONPGFGdcQfpC+PkaUPdHns=;
 b=CYsUBuo3Ss2S08LLANERJ9zf9Srvnz2pYTl5+ow04eMHbiOjQ9kkHi4svwlh1ZwTYi
 36JuoT1dA88MM1rR3qJVhZBAPUKbynz5JfBDWIH3A6cwrol7o1Kz+X8LKUHyHdwO4ObU
 mmP+Smu7tfCCgKh1KsZ+fonzAv6D1WQIII4DHkW6+sTFkBalQxBiQtkpbTNQtc5Wyy5r
 JOFxZMDFyaDuM4lj+OzR2e91IBrs792lIS6Kjkvp0ntWG/9dg0xbI9p1VqsPwmY4HxV3
 U4mHpY6vjTVDnbdZjXZLjPHP8qZE+Ysnnxdt81I5XGTPkoBpeYthx/TX9JEGyFVc+8RP
 7/cA==
X-Gm-Message-State: AOAM532DiVH+Uk3XA2mR/IUqxichDayh/CVbCYqsldP9q2OhIVcDPcWM
 tIAbmvAmeENKikm6Fw40VtDL6w==
X-Google-Smtp-Source: ABdhPJwV7PjdyL8npc+ZHZN4P5I3KfSRiOj247xLWqxEKaTh8lhCSDPoXp8Z01i6t5KJpWWI5zOqNQ==
X-Received: by 2002:a63:c343:: with SMTP id e3mr2808628pgd.288.1597941704650; 
 Thu, 20 Aug 2020 09:41:44 -0700 (PDT)
Received: from [192.168.1.3] ([115.96.133.117])
 by smtp.gmail.com with ESMTPSA id c2sm2866617pgb.52.2020.08.20.09.41.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2020 09:41:44 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ani Sinha <ani@anisinha.ca>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH V6] Introduce a new flag for i440fx to disable PCI hotplug
 on the root bus
Date: Thu, 20 Aug 2020 22:11:41 +0530
Message-Id: <96C3BCCD-7A5E-439D-8EDD-927D188C0946@anisinha.ca>
References: <CAARzgwyuL_joY_4wq8=WY7U=E67F2roPJ36kaQLJFRVqLgpGXg@mail.gmail.com>
In-Reply-To: <CAARzgwyuL_joY_4wq8=WY7U=E67F2roPJ36kaQLJFRVqLgpGXg@mail.gmail.com>
To: Igor Mammedov <imammedo@redhat.com>
X-Mailer: iPad Mail (17G68)
Received-SPF: none client-ip=2607:f8b0:4864:20::542;
 envelope-from=ani@anisinha.ca; helo=mail-pg1-x542.google.com
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
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On Aug 20, 2020, at 9:11 PM, Ani Sinha <ani@anisinha.ca> wrote:
>=20
> =EF=BB=BFOn Thu, Aug 20, 2020 at 7:37 PM Igor Mammedov <imammedo@redhat.co=
m> wrote:
>>=20
>>> On Thu, 20 Aug 2020 14:51:56 +0530
>>> Ani Sinha <ani@anisinha.ca> wrote:
>>>=20
>>> We introduce a new global flag 'acpi-root-pci-hotplug' for i440fx with w=
hich
>>> we can turn on or off PCI device hotplug on the root bus. This flag can b=
e
>>> used to prevent all PCI devices from getting hotplugged or unplugged fro=
m the
>>> root PCI bus.
>>> This feature is targetted mostly towards Windows VMs. It is useful in ca=
ses
>>> where some hypervisor admins want to deploy guest VMs in a way so that t=
he
>>> users of the guest OSes are not able to hot-eject certain PCI devices fr=
om
>>> the Windows system tray. Laine has explained the use case here in detail=
:
>>> https://www.redhat.com/archives/libvir-list/2020-February/msg00110.html
>>>=20
>>> Julia has resolved this issue for PCIE buses with the following commit:
>>> 530a0963184e57e71a5b538 ("pcie_root_port: Add hotplug disabling option")=

>>>=20
>>> This commit attempts to introduce similar behavior for PCI root buses us=
ed in
>>> i440fx machine types (although in this case, we do not have a per-slot
>>> capability to turn hotplug on or off).
>>>=20
>>> Usage:
>>>   -global PIIX4_PM.acpi-root-pci-hotplug=3Doff
>>>=20
>>> By default, this option is enabled which means that hotplug is turned on=
 for
>>> the PCI root bus.
>>>=20
>>> The previously existing flag 'acpi-pci-hotplug-with-bridge-support' for P=
CI-PCI
>>> bridges remain as is and can be used along with this new flag to control=
 PCI
>>> hotplug on PCI bridges.
>>>=20
>>> This change has been tested using a Windows 2012R2 server guest image an=
d also
>>> with a Windows 2019 server guest image on a Ubuntu 18.04 host using the l=
atest
>>> master qemu from upstream (v5.1.0 tag).
>>>=20
>>> Signed-off-by: Ani Sinha <ani@anisinha.ca>
>>> ---
>>> hw/acpi/piix4.c      |  8 ++++++--
>>> hw/i386/acpi-build.c | 26 +++++++++++++++++++-------
>>> 2 files changed, 25 insertions(+), 9 deletions(-)
>>>=20
>>> Change Log:
>>> V5..V6: specified upstream master tag information off which this patch i=
s
>>> based off of.
>>>=20
>>> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
>>> index 26bac4f16c..4f436e5bf3 100644
>>> --- a/hw/acpi/piix4.c
>>> +++ b/hw/acpi/piix4.c
>>> @@ -78,6 +78,7 @@ typedef struct PIIX4PMState {
>>>=20
>>>     AcpiPciHpState acpi_pci_hotplug;
>>>     bool use_acpi_hotplug_bridge;
>>> +    bool use_acpi_root_pci_hotplug;
>>>=20
>>>     uint8_t disable_s3;
>>>     uint8_t disable_s4;
>>=20
>>> @@ -595,8 +596,9 @@ static void piix4_acpi_system_hot_add_init(MemoryReg=
ion *parent,
>>>                           "acpi-gpe0", GPE_LEN);
>>>     memory_region_add_subregion(parent, GPE_BASE, &s->io_gpe);
>>>=20
>>> -    acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, parent,
>>> -                    s->use_acpi_hotplug_bridge);
>>> +    if (s->use_acpi_hotplug_bridge || s->use_acpi_root_pci_hotplug)
>>> +        acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, parent,
>>> +                        s->use_acpi_hotplug_bridge);
>> If intent was to disable hardware part of ACPI hotplug,
>> then this hunk is not enough. I'd say it introduces bug since you are lea=
ving
>> device_add/del route open and "_E01" AML code around trying to access no l=
onger
>> described/present io ports.
>>=20
>> Without this hunk patch is fine, as a means to hide hotplug from Windows.=

>>=20
>> If you'd like to disable hw part, you will need to consider case where ho=
tplug is
>> disabled completly and block all related AML and block device_add|del.
>> So it would be a bit more than above hunk.
>=20
> Ok maybe I will just remove it.
>=20
>>=20
>>=20
>>>     s->cpu_hotplug_legacy =3D true;
>>>     object_property_add_bool(OBJECT(s), "cpu-hotplug-legacy",
>>> @@ -635,6 +637,8 @@ static Property piix4_pm_properties[] =3D {
>>>     DEFINE_PROP_UINT8(ACPI_PM_PROP_S4_VAL, PIIX4PMState, s4_val, 2),
>>>     DEFINE_PROP_BOOL("acpi-pci-hotplug-with-bridge-support", PIIX4PMStat=
e,
>>>                      use_acpi_hotplug_bridge, true),
>>> +    DEFINE_PROP_BOOL("acpi-root-pci-hotplug", PIIX4PMState,
>>> +                     use_acpi_root_pci_hotplug, true),
>>>     DEFINE_PROP_BOOL("memory-hotplug-support", PIIX4PMState,
>>>                      acpi_memory_hotplug.is_enabled, true),
>>>     DEFINE_PROP_END_OF_LIST(),
>>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>>> index b7bcbbbb2a..19a1702ad1 100644
>>> --- a/hw/i386/acpi-build.c
>>> +++ b/hw/i386/acpi-build.c
>>> @@ -95,6 +95,7 @@ typedef struct AcpiPmInfo {
>>>     bool s3_disabled;
>>>     bool s4_disabled;
>>>     bool pcihp_bridge_en;
>>> +    bool pcihp_root_en;
>>>     uint8_t s4_val;
>>>     AcpiFadtData fadt;
>>>     uint16_t cpu_hp_io_base;
>>> @@ -245,6 +246,9 @@ static void acpi_get_pm_info(MachineState *machine, A=
cpiPmInfo *pm)
>>>     pm->pcihp_bridge_en =3D
>>>         object_property_get_bool(obj, "acpi-pci-hotplug-with-bridge-supp=
ort",
>>>                                  NULL);
>>> +    pm->pcihp_root_en =3D
>>> +        object_property_get_bool(obj, "acpi-root-pci-hotplug", NULL);
>>> +
>>> }
>>>=20
>>> static void acpi_get_misc_info(AcpiMiscInfo *info)
>>> @@ -337,15 +341,18 @@ static void build_append_pcihp_notify_entry(Aml *m=
ethod, int slot)
>>> }
>>>=20
>>> static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,=

>>> -                                         bool pcihp_bridge_en)
>>> +                                         bool pcihp_bridge_en,
>>> +                                         bool pcihp_root_en)
>>> {
>>>     Aml *dev, *notify_method =3D NULL, *method;
>>>     QObject *bsel;
>>>     PCIBus *sec;
>>>     int i;
>>> +    bool root_bus =3D pci_bus_is_root(bus);
>>> +    bool root_pcihp_disabled =3D (root_bus && !pcihp_root_en);
>>>=20
>>>     bsel =3D object_property_get_qobject(OBJECT(bus), ACPI_PCIHP_PROP_BS=
EL, NULL);
>>> -    if (bsel) {
>>> +    if (bsel && !root_pcihp_disabled) {
>>=20
>> have you considered to make bus not hotpluggable,
>> which should make it not to have bsel, and hence skip this branch without=

>> root_pcihp_disabled?
>>=20
>> see: acpi_set_bsel()
>>=20
>>=20
>> maybe you can drop pcihp_root_en and use bsel instead of it then.
>>=20
>> it also should block device_add/del route.
>=20
> This is a good idea. Therefore, I tried this:
>=20
> --- a/hw/acpi/piix4.c
> +++ b/hw/acpi/piix4.c
> @@ -28,6 +28,7 @@
> #include "hw/pci/pci.h"
> #include "hw/qdev-properties.h"
> #include "hw/acpi/acpi.h"
> +#include "hw/pci/pci_bus.h"
> #include "sysemu/runstate.h"
> #include "sysemu/sysemu.h"
> #include "sysemu/xen.h"
> @@ -507,7 +508,9 @@ static void piix4_pm_realize(PCIDevice *dev, Error **e=
rrp)
>=20
>     piix4_acpi_system_hot_add_init(pci_address_space_io(dev),
>                                    pci_get_bus(dev), s);
> -    qbus_set_hotplug_handler(BUS(pci_get_bus(dev)), OBJECT(s));
> +    if (s->use_acpi_root_pci_hotplug ||
> +        !pci_bus_is_root(pci_get_bus(dev)))
> +        qbus_set_hotplug_handler(BUS(pci_get_bus(dev)), OBJECT(s));
>=20
>     piix4_pm_add_propeties(s);
> }
>=20
>=20
> but this does not seem to be working. I am out of ideas as to why it
> wouldn't work :(

By that I mean the devices attached to bridges also seems to be disabled fro=
m hotplug from within Windows. I do not understand why that would be the cas=
e when the pci_bus_is_root() should be false for the secondary buses.

 Any ideas? =20

>=20
>>=20
>>=20
>>>         uint64_t bsel_val =3D qnum_get_uint(qobject_to(QNum, bsel));
>>>=20
>>>         aml_append(parent_scope, aml_name_decl("BSEL", aml_int(bsel_val)=
));
>>> @@ -361,6 +368,9 @@ static void build_append_pci_bus_devices(Aml *parent=
_scope, PCIBus *bus,
>>>         bool bridge_in_acpi;
>>>=20
>>>         if (!pdev) {
>>> +            /* skip if pci hotplug for the root bus is disabled */
>>> +            if (root_pcihp_disabled)
>>> +                continue;
>>>             if (bsel) { /* add hotplug slots for non present devices */
>>>                 dev =3D aml_device("S%.02X", PCI_DEVFN(slot, 0));
>>>                 aml_append(dev, aml_name_decl("_SUN", aml_int(slot)));
>>> @@ -419,7 +429,7 @@ static void build_append_pci_bus_devices(Aml *parent=
_scope, PCIBus *bus,
>>>             method =3D aml_method("_S3D", 0, AML_NOTSERIALIZED);
>>>             aml_append(method, aml_return(aml_int(s3d)));
>>>             aml_append(dev, method);
>>> -        } else if (hotplug_enabled_dev) {
>>> +        } else if (hotplug_enabled_dev && !root_pcihp_disabled) {
>>>             /* add _SUN/_EJ0 to make slot hotpluggable  */
>>>             aml_append(dev, aml_name_decl("_SUN", aml_int(slot)));
>>>=20
>>> @@ -439,13 +449,14 @@ static void build_append_pci_bus_devices(Aml *pare=
nt_scope, PCIBus *bus,
>>>              */
>>>             PCIBus *sec_bus =3D pci_bridge_get_sec_bus(PCI_BRIDGE(pdev))=
;
>>>=20
>>> -            build_append_pci_bus_devices(dev, sec_bus, pcihp_bridge_en)=
;
>>> +            build_append_pci_bus_devices(dev, sec_bus, pcihp_bridge_en,=

>>> +                                         pcihp_root_en);
>>>         }
>>>         /* slot descriptor has been composed, add it into parent context=
 */
>>>         aml_append(parent_scope, dev);
>>>     }
>>>=20
>>> -    if (bsel) {
>>> +    if (bsel && !root_pcihp_disabled) {
>>>         aml_append(parent_scope, notify_method);
>>>     }
>>>=20
>>> @@ -455,7 +466,7 @@ static void build_append_pci_bus_devices(Aml *parent=
_scope, PCIBus *bus,
>>>     method =3D aml_method("PCNT", 0, AML_NOTSERIALIZED);
>>>=20
>>>     /* If bus supports hotplug select it and notify about local events *=
/
>>> -    if (bsel) {
>>> +    if (bsel && !root_pcihp_disabled) {
>>>         uint64_t bsel_val =3D qnum_get_uint(qobject_to(QNum, bsel));
>>>=20
>>>         aml_append(method, aml_store(aml_int(bsel_val), aml_name("BNUM")=
));
>>> @@ -1818,7 +1829,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,=

>>>         if (bus) {
>>>             Aml *scope =3D aml_scope("PCI0");
>>>             /* Scan all PCI buses. Generate tables to support hotplug. *=
/
>>> -            build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_e=
n);
>>> +            build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_e=
n,
>>> +                                         pm->pcihp_root_en);
>>>=20
>>>             if (TPM_IS_TIS_ISA(tpm)) {
>>>                 if (misc->tpm_version =3D=3D TPM_VERSION_2_0) {
>>=20

