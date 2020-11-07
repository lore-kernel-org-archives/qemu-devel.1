Return-Path: <SRS0=ex3l=EN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E8DC388F9
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 12:23:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66D1C206F4
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 12:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="fgksGwID"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66D1C206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbNFv-0008MZ-AF
	for qemu-devel@archiver.kernel.org; Sat, 07 Nov 2020 07:23:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kbNEY-0007q8-EF
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 07:22:18 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45006)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kbNEW-0001s7-AJ
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 07:22:18 -0500
Received: by mail-wr1-x442.google.com with SMTP id c17so3990017wrc.11
 for <qemu-devel@nongnu.org>; Sat, 07 Nov 2020 04:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=faK6L8neeebQNjY9EHAH4tNJqAAGSDnBCXyHbXMSLyU=;
 b=fgksGwIDmoMk0TvgDCLFDwosrCQXdud59SG2m3KwkaMc5myftdVUmw8wfPHgN3FQiQ
 2ul1OkxsrblnXlaPCvKW4OQC28mgVa+J5ZIOo/mFB5ABXWvOJzrNc7PzQS/ArC3O717Q
 PB/F/YtB3dJr4NHborch2jdoviCu3ivexqmudEja2PBTFMFFw+2qy3fueanFMDZOfTQB
 17SaOBVcLqmPpb29Nx4vFDhCoVL1Wsoswm+7+iPmpPFBAMM+UjCn+00KeusEAvhEwoLL
 JA6FFW7R/32Jc75+wIHNJ8NasBYGkZgX4NqEqoD/oVOO/S/9uluaWfc+IgY7i4PAZZJf
 3UXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=faK6L8neeebQNjY9EHAH4tNJqAAGSDnBCXyHbXMSLyU=;
 b=i0ZbhgnfQm2X91MfCn/5m2ErmrZx+FrIHgZaJOcD7Q+yTbqW8oKtxM3WEwpKZWbCU9
 yhxbOfQFOxE/iexc2+cfOcidHV2vD9iCV7XY+TCeUMLRfbwd68TyMSjmQ7S7UlsQh5EH
 Fn6j2QQKWk6fbbj0M+qu271iA4Xe3v9R9eq9ajnukRAs7xvt3D51GlHd9f5He6e7nQo+
 /fL2WtVZNDrUSkSH4tRYsA7HlY4R0kPXrdqC8uVx0iJswLZP/utUxjiWrwEiRznSAtl6
 s1to56PqzPgTudcm+ceeubbzuV9MwFrWHEFOvnTaN+wcXtYlwfH0BHp5EL0G9aoYDpy5
 DB+Q==
X-Gm-Message-State: AOAM533xCLsbQEPiN3CRT9S7L76wO9S/UkSN+DrJBmV1PrpDUaIrfdS8
 dyO6CJylrxe+NUXo/MnostMIRjr7lT26Olg5RGPCTQ==
X-Google-Smtp-Source: ABdhPJzAvP9t0R8UcKe9xmKDRPUpS9xVXDIDFexF0WLyG47bcvi+fxwvoOd8m/xJh2PKL7RATZzhr7UkosG0460+hTs=
X-Received: by 2002:a5d:4d86:: with SMTP id b6mr7643423wru.369.1604751733993; 
 Sat, 07 Nov 2020 04:22:13 -0800 (PST)
MIME-Version: 1.0
References: <20200929071948.281157-1-mst@redhat.com>
 <20200929071948.281157-45-mst@redhat.com>
 <5b79133f-374e-8a8f-6aeb-bd5313dc8eb1@redhat.com>
In-Reply-To: <5b79133f-374e-8a8f-6aeb-bd5313dc8eb1@redhat.com>
From: Ani Sinha <ani@anisinha.ca>
Date: Sat, 7 Nov 2020 17:52:02 +0530
Message-ID: <CAARzgwx+n0k9kC15Twy0sj07jcDcPWX6-x2pGDXQ1i8fDU-Leg@mail.gmail.com>
Subject: Re: [PULL v4 44/48] piix4: don't reserve hw resources when hotplug is
 off globally
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2a00:1450:4864:20::442;
 envelope-from=ani@anisinha.ca; helo=mail-wr1-x442.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Nov 7, 2020 at 3:40 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>
> Hi,
>
> On 9/29/20 9:22 AM, Michael S. Tsirkin wrote:
> > From: Ani Sinha <ani@anisinha.ca>
> >
> > When acpi hotplug is turned off for both root pci bus as well as for pc=
i
> > bridges, we should not generate the related ACPI code for DSDT table or
> > initialize related hw ports or reserve hw resources. This change makes
> > sure all those operations are turned off in the case ACPI pci hotplug i=
s
> > off globally.
> >
> > In this change, we also make sure ACPI code for the PCNT method are onl=
y
> > added when bsel is enabled for the corresponding pci bus or bridge hotp=
lug
> > is turned on.
>
> I'm trying to understand the following build failure using gcc 9.3.0
> on Ubuntu:
>
> [2567/3684] Compiling C object
> libqemu-x86_64-softmmu.fa.p/hw_i386_acpi-build.c.o
> FAILED: libqemu-x86_64-softmmu.fa.p/hw_i386_acpi-build.c.o
> ../hw/i386/acpi-build.c: In function 'build_append_pci_bus_devices':
> ../hw/i386/acpi-build.c:496:9: error: 'method' may be used uninitialized
> in this function [-Werror=3Dmaybe-uninitialized]
>   496 |         aml_append(parent_scope, method);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
>
> >
> > As q35 machines do not use bsel for it's pci buses at this point in tim=
e, this
> > change affects DSDT acpi table for q35 machines as well. Therefore, we =
will
> > also need to commit the updated golden master DSDT table acpi binary bl=
obs as
> > well. Following is the list of blobs which needs updating:
> >
> >  tests/data/acpi/q35/DSDT
> >  tests/data/acpi/q35/DSDT.acpihmat
> >  tests/data/acpi/q35/DSDT.bridge
> >  tests/data/acpi/q35/DSDT.cphp
> >  tests/data/acpi/q35/DSDT.dimmpxm
> >  tests/data/acpi/q35/DSDT.ipmibt
> >  tests/data/acpi/q35/DSDT.memhp
> >  tests/data/acpi/q35/DSDT.mmio64
> >  tests/data/acpi/q35/DSDT.numamem
> >  tests/data/acpi/q35/DSDT.tis
> >
> > These tables are updated in the following commit. Without the updated t=
able
> > blobs, the unit tests would fail with this patch.
> >
> > Signed-off-by: Ani Sinha <ani@anisinha.ca>
> > Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> > Message-Id: <20200918084111.15339-11-ani@anisinha.ca>
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  hw/acpi/piix4.c      |  6 ++++--
> >  hw/i386/acpi-build.c | 25 ++++++++++++++++++-------
> >  2 files changed, 22 insertions(+), 9 deletions(-)
> >
> > diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> > index 832f8fba82..894d357f8c 100644
> > --- a/hw/acpi/piix4.c
> > +++ b/hw/acpi/piix4.c
> > @@ -596,8 +596,10 @@ static void piix4_acpi_system_hot_add_init(MemoryR=
egion *parent,
> >                            "acpi-gpe0", GPE_LEN);
> >      memory_region_add_subregion(parent, GPE_BASE, &s->io_gpe);
> >
> > -    acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, parent,
> > -                    s->use_acpi_hotplug_bridge);
> > +    if (s->use_acpi_hotplug_bridge || s->use_acpi_root_pci_hotplug) {
> > +        acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, parent,
> > +                        s->use_acpi_hotplug_bridge);
> > +    }
> >
> >      s->cpu_hotplug_legacy =3D true;
> >      object_property_add_bool(OBJECT(s), "cpu-hotplug-legacy",
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index 2b17843837..8d14e4667a 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -96,6 +96,7 @@ typedef struct AcpiPmInfo {
> >      bool s4_disabled;
> >      bool pcihp_bridge_en;
> >      bool smi_on_cpuhp;
> > +    bool pcihp_root_en;
> >      uint8_t s4_val;
> >      AcpiFadtData fadt;
> >      uint16_t cpu_hp_io_base;
> > @@ -251,6 +252,9 @@ static void acpi_get_pm_info(MachineState *machine,=
 AcpiPmInfo *pm)
> >      pm->pcihp_bridge_en =3D
> >          object_property_get_bool(obj, "acpi-pci-hotplug-with-bridge-su=
pport",
> >                                   NULL);
> > +    pm->pcihp_root_en =3D
> > +        object_property_get_bool(obj, "acpi-root-pci-hotplug",
> > +                                 NULL);
> >  }
> >
> >  static void acpi_get_misc_info(AcpiMiscInfo *info)
> > @@ -456,10 +460,12 @@ static void build_append_pci_bus_devices(Aml *par=
ent_scope, PCIBus *bus,
> >      }
> >
> >      /* Append PCNT method to notify about events on local and child bu=
ses.
> > -     * Add unconditionally for root since DSDT expects it.
> > +     * Add this method for root bus only when hotplug is enabled since=
 DSDT
> > +     * expects it.
> >       */
> > -    method =3D aml_method("PCNT", 0, AML_NOTSERIALIZED);
> > -
> > +    if (bsel || pcihp_bridge_en) {
> > +        method =3D aml_method("PCNT", 0, AML_NOTSERIALIZED);
> > +    }
>
> build_append_pci_bus_devices() is not easy to follow and could certainly
> benefit from a refactor.

Hmm, ok will do that in my spare time.

>
> So here, before 'method' was always reinitialized. Now not always,
> so it can be any value set in the big for() loop before...

In line 467 above, method is initialized when bsel is available or
pcihp is enabled. In line 496, it is appended to the parent scope only
under those conditions as well. Basically, in hunks

+    if (bsel || pcihp_bridge_en) {
+        method =3D aml_method("PCNT", 0, AML_NOTSERIALIZED);
+    }

and
+
+    if (bsel || pcihp_bridge_en) {
+        aml_append(parent_scope, method);
+    }

the conditions are exactly the same.

Hence, I see no contradiction. To satisfy the compiler, one could do this:

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 4f66642..79b86d4 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -349,7 +349,7 @@ static void build_append_pcihp_notify_entry(Aml
*method, int slot)
 static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
                                          bool pcihp_bridge_en)
 {
-    Aml *dev, *notify_method =3D NULL, *method;
+    Aml *dev, *notify_method =3D NULL, *method =3D NULL;
     QObject *bsel;
     PCIBus *sec;
     int i;
@@ -492,7 +492,7 @@ static void build_append_pci_bus_devices(Aml
*parent_scope, PCIBus *bus,
         }
     }
-    if (bsel || pcihp_bridge_en) {
+    if (method) {
         aml_append(parent_scope, method);
     }
     qobject_unref(bsel);




>
> Something is definitively wrong.
>
> >      /* If bus supports hotplug select it and notify about local events=
 */
> >      if (bsel) {
> >          uint64_t bsel_val =3D qnum_get_uint(qobject_to(QNum, bsel));
> > @@ -485,7 +491,10 @@ static void build_append_pci_bus_devices(Aml *pare=
nt_scope, PCIBus *bus,
> >              aml_append(method, aml_name("^S%.02X.PCNT", devfn));
> >          }
> >      }
> > -    aml_append(parent_scope, method);
> > +
> > +    if (bsel || pcihp_bridge_en) {
> > +        aml_append(parent_scope, method);
> > +    }
> >      qobject_unref(bsel);
> >  }
> >
> > @@ -1510,7 +1519,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker=
,
> >          build_hpet_aml(dsdt);
> >          build_piix4_isa_bridge(dsdt);
> >          build_isa_devices_aml(dsdt);
> > -        build_piix4_pci_hotplug(dsdt);
> > +        if (pm->pcihp_bridge_en || pm->pcihp_root_en) {
> > +            build_piix4_pci_hotplug(dsdt);
> > +        }
> >          build_piix4_pci0_int(dsdt);
> >      } else {
> >          sb_scope =3D aml_scope("_SB");
> > @@ -1579,7 +1590,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker=
,
> >      {
> >          aml_append(scope, aml_name_decl("_HID", aml_string("ACPI0006")=
));
> >
> > -        if (misc->is_piix4) {
> > +        if (misc->is_piix4 && (pm->pcihp_bridge_en || pm->pcihp_root_e=
n)) {
> >              method =3D aml_method("_E01", 0, AML_NOTSERIALIZED);
> >              aml_append(method,
> >                  aml_acquire(aml_name("\\_SB.PCI0.BLCK"), 0xFFFF));
> > @@ -1731,7 +1742,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker=
,
> >      crs_range_set_free(&crs_range_set);
> >
> >      /* reserve PCIHP resources */
> > -    if (pm->pcihp_io_len) {
> > +    if (pm->pcihp_io_len && (pm->pcihp_bridge_en || pm->pcihp_root_en)=
) {
> >          dev =3D aml_device("PHPR");
> >          aml_append(dev, aml_name_decl("_HID", aml_string("PNP0A06")));
> >          aml_append(dev,
> >
>

