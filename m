Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A029AC10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 12:20:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BB6E206EB
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 12:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CkBinH0K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BB6E206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCMpZ-0002rx-Hx
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 08:20:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38402)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jCMov-0002FS-No
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 08:20:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jCMos-0001wK-It
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 08:20:12 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22550
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jCMos-0001vZ-AF
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 08:20:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584015609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=caf0aq/+3hCAGKB0Nbz2/tgYSSJUpCC+sMR1em4LqFw=;
 b=CkBinH0K4U4gwMAQPmwJvDLHpr068BBKEAd4dyuguTAKTHSS+OkgZGSLfi1C4My3NM01qE
 KLjYYQ9rwgF7GWSOWkLa9o8g/Wx3bxb95gaTpmWc+li4NTFpZGMOhPY8KFQbmcO0zKsurX
 enk64kx89II59s+kdBsIa7JlHplMR4Y=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-gP0LGwtqNZ-MIs3g9JCs3A-1; Thu, 12 Mar 2020 08:19:42 -0400
X-MC-Unique: gP0LGwtqNZ-MIs3g9JCs3A-1
Received: by mail-qt1-f198.google.com with SMTP id a21so3492984qto.0
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 05:19:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=4TaOmtwGEIy4Jv/NCSeuPpMj6ecKWF6IZRyi7KYqHp8=;
 b=Vac/mu2fqjCZd2tlADIIHvbqL2vtbIKL4J4+pEd0P39+ZgQvWIZyLT+KvUUoS+ZgGi
 JGD7jIrLLgQNftKU+e7FaIYTKIs29HunwgAGCoZgagy63SgoQvR8exZ6VUPdVMOUvMCO
 556uk2NiuHpfvBqOZaTCLe/0TeQ6mzILFK6xHPacmwdPDyn1x8eakM9OIvEUKL7c5GHz
 JRp+xQBZre9TWrsZNUOudEbI8AN6L8fxFJexXqmetacgqxyROo7ptFnBTLOcw+gSFp2J
 Lkv5So06QbD1PoWCfmgOdjIgp2e4d/T6DSRR68/BT48+VHrHm3z88jNZgXTv+yQO51xB
 Ydww==
X-Gm-Message-State: ANhLgQ0bMlonlPASEQU0E8r7cHQscJ/7giGQSA+aTNalkz/hu91Aq6rq
 K1kgnx3EjPbRQpVmVDFxpAuu/cMQ3qzeznXfh8ucEm8b6P87tmp6e9Ys+EX8xfCBO2XDOTsIWGj
 nYemQRN4A0yn+d0Y=
X-Received: by 2002:a37:b084:: with SMTP id z126mr7564275qke.497.1584015581828; 
 Thu, 12 Mar 2020 05:19:41 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvmw+IJkWFhgvZbPnm0+DkTcoowq4jKA3SDtmQZb9rI0INY649WzhI4McHbLUvlLuKS0tpZiQ==
X-Received: by 2002:a37:b084:: with SMTP id z126mr7564237qke.497.1584015581397; 
 Thu, 12 Mar 2020 05:19:41 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id j17sm27778194qth.27.2020.03.12.05.19.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 05:19:40 -0700 (PDT)
Date: Thu, 12 Mar 2020 08:19:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH] acpi: Add Windows ACPI Emulated Device Table (WAET)
Message-ID: <20200312080602-mutt-send-email-mst@kernel.org>
References: <20200311170826.79419-1-liran.alon@oracle.com>
 <20200311162509-mutt-send-email-mst@kernel.org>
 <92564357-25c1-0a0f-537b-6902f45a88d0@oracle.com>
 <20200312012859-mutt-send-email-mst@kernel.org>
 <8cab6eba-22bc-a62e-d4a8-e2138b815a01@oracle.com>
MIME-Version: 1.0
In-Reply-To: <8cab6eba-22bc-a62e-d4a8-e2138b815a01@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org, imammedo@redhat.com,
 Elad Gabay <elad.gabay@oracle.com>, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 12, 2020 at 01:30:01PM +0200, Liran Alon wrote:
>=20
> On 12/03/2020 8:12, Michael S. Tsirkin wrote:
> > On Thu, Mar 12, 2020 at 01:20:02AM +0200, Liran Alon wrote:
> > > On 11/03/2020 22:36, Michael S. Tsirkin wrote:
> > > > Thanks for the patch! Some questions/comments:
> > > >=20
> > > > On Wed, Mar 11, 2020 at 07:08:26PM +0200, Liran Alon wrote:
> > > > > From: Elad Gabay <elad.gabay@oracle.com>
> > > > >=20
> > > > > Microsoft introduced this ACPI table to avoid Windows guests perf=
orming
> > > > > various workarounds for device erratas. As the virtual device emu=
lated
> > > > > by VMM may not have the errata.
> > > > >=20
> > > > > Currently, WAET allows hypervisor to inform guest about two
> > > > > specific behaviors: One for RTC and the other for ACPI PM Timer.
> > > > >=20
> > > > > Support for WAET have been introduced since Windows Vista. This A=
CPI
> > > > > table is also exposed by other hypervisors, such as VMware, by de=
fault.
> > > > >=20
> > > > > This patch adds WAET ACPI Table to QEMU.
> > > > Could you add a bit more info? Why is this so useful we are adding =
this
> > > > by default? How does it change windows behaviour when present?
> > > It changes behavior as documented in the WAET specification linked be=
low
> > > (and the comments above the flags definitions).
> > > Specifically for ACPI_WAET_PM_TIMER_GOOD (Which is the only bit we se=
t), the
> > > guest performs only one read of ACPI PM Timer instead of multiple to =
obtain
> > > it's value.
> > > Which improves performance as it removes unnecessary VMExits.
> > Sounds excellent. Pls include this info in the commit log.
> Ok. Will do in v2.
> > As with any
> > performance optimization, pls add a bit of info about how you tested
> > and what kind of speedup was seen.
> This is a quite an old patch of ours that I upstream now to contribute to
> community.
> I will need to re-setup such environment for gathering exact performance
> numbers.
>=20
> Having said that, note that there isn't really a trade-off here between
> better performance or something else.

Well some guests are known to make crazy assumptions. E.g. they would
see this bit and say "oh so I know this hyperv" or something to
that end.

> We just expose a bit to guest that says to it: "You don't need to do this
> useless thing that cause unnecessary VMExits. You can just do this simple
> operation which is always better because we support it".
> Therefore, as long as other guests just ignore this ACPI table (Which the=
y
> do as far as I've seen from the vast variety of instances we have run on
> production for over 5 years), exposing this just have positive effect.
>=20
> Also note that besides VMware which expose it by default, you can also se=
e
> this exposed by default by some cloud hypervisors, such as GCP:
> [=A0=A0=A0 0.000000] ACPI: WAET 0x00000000BFFF5CE0 000028 (v01 Google GOO=
GWAET
> 00000001 GOOG 00000001)
>=20
> > > > > It also makes sure to introduce
> > > > > the new ACPI table only for new machine-types.
> > > > OK and why is that?
> > > As ACPI tables are guest-visible, we should make sure to not change i=
t
> > > between machine-types.
> > > For example, a change in ACPI tables may invalidate a Windows guest l=
icense
> > > activation (As platform have changed).
> > I don't think there's something like this taken into account, no.
> Windows measures at boot-time if the hardware have "changed too much" sin=
ce
> activation.
> The way it does so, is calculating a "weighted diff score" based on a num=
ber
> of hardware properties.
>=20
> It is at least documented internally in Ravello that some guests have bee=
n
> witnessed to broke their license activation because of ACPI/SMBIOS change=
s.

Any data on which changes exactly?
All I know about is this list, though it's pretty old.
https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-x=
p/bb457054(v=3Dtechnet.10)?redirectedfrom=3DMSDN

Any chance it was actually to do with the EOM table that bypasses
activation?

> > > But this is just a good practice in general and in the past it was sa=
id by
> > > maintainers that this is one of the main reasons that ACPI and SMBIOS
> > > generation have moved from SeaBIOS to QEMU.
> > I think a flag to disable this might make sense though. For example,
> > some guests might behave differently and get broken.
> Right. That's why I think it's a good practice to have this flag and tie =
it
> to machine-type.

Tying things to the machine type is not what I had in mind.
A separate flag would also be helpful so users can tweak this
for new machine types, too.

> Guest-visible changes shouldn't be exposed to old machine-types.

Well almost any change in qemu is guest visible to some level.
Even optimizations are guest visible.
We made changes in ACPI without versioning in the past but I'm not
opposed to versioning here. However in that case pls do add a bit
of documentation about why this is done here.
What I am asking about is whether we need a flag to disable
this as part of the stable interface.

> >=20
> >=20
> > > > > Signed-off-by: Elad Gabay <elad.gabay@oracle.com>
> > > > > Co-developed-by: Liran Alon <liran.alon@oracle.com>
> > > > > Signed-off-by: Liran Alon <liran.alon@oracle.com>
> > > > > ---
> > > > >    hw/i386/acpi-build.c        | 18 ++++++++++++++++++
> > > > >    hw/i386/pc_piix.c           |  2 ++
> > > > >    hw/i386/pc_q35.c            |  2 ++
> > > > >    include/hw/acpi/acpi-defs.h | 25 +++++++++++++++++++++++++
> > > > >    include/hw/i386/pc.h        |  1 +
> > > > >    5 files changed, 48 insertions(+)
> > > > >=20
> > > > > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > > > > index 9c4e46fa7466..29f70741cd96 100644
> > > > > --- a/hw/i386/acpi-build.c
> > > > > +++ b/hw/i386/acpi-build.c
> > > > > @@ -2512,6 +2512,19 @@ build_dmar_q35(GArray *table_data, BIOSLin=
ker *linker)
> > > > >        build_header(linker, table_data, (void *)(table_data->data=
 + dmar_start),
> > > > >                     "DMAR", table_data->len - dmar_start, 1, NULL=
, NULL);
> > > > >    }
> > > > > +
> > > > > +static void
> > > > > +build_waet(GArray *table_data, BIOSLinker *linker)
> > Add documentation that it's a Windows Emulated Device Flags table,
> > helpful to speed up windows guests, and ignored by others.
> Ok. Will do in v2.
> >=20
> > > > > +{
> > > > > +    AcpiTableWaet *waet;
> > > > > +
> > > > > +    waet =3D acpi_data_push(table_data, sizeof(*waet));
> > > > Can combine with the previous line.
> > > Ok. Will do in v2.
> > > > > +    waet->emulated_device_flags =3D cpu_to_le32(ACPI_WAET_PM_TIM=
ER_GOOD);
> > > > > +
> > > > > +    build_header(linker, table_data,
> > > > > +                 (void *)waet, "WAET", sizeof(*waet), 1, NULL, N=
ULL);
> > > > > +}
> > > > > +
> > > > >    /*
> > > > >     *   IVRS table as specified in AMD IOMMU Specification v2.62,=
 Section 5.2
> > > > >     *   accessible here https://urldefense.com/v3/__http://suppor=
t.amd.com/TechDocs/48882_IOMMU.pdf__;!!GqivPVa7Brio!OAQpLo9QhdHiNDa_aRLR_ma=
1nWLZU1aQhDozYgUlrqBZiz1vKdZgg-lTDMIj_5g$
> > > > > @@ -2859,6 +2872,11 @@ void acpi_build(AcpiBuildTables *tables, M=
achineState *machine)
> > > > >                              machine->nvdimms_state, machine->ram=
_slots);
> > > > >        }
> > > > > +    if (!pcmc->do_not_add_waet_acpi) {
> > > > > +        acpi_add_table(table_offsets, tables_blob);
> > > > > +        build_waet(tables_blob, tables->linker);
> > > > > +    }
> > > > > +
> > > > >        /* Add tables supplied by user (if any) */
> > > > >        for (u =3D acpi_table_first(); u; u =3D acpi_table_next(u)=
) {
> > > > >            unsigned len =3D acpi_table_len(u);
> > > > > diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> > > > > index 9088db8fb601..2d11a8b50a9c 100644
> > > > > --- a/hw/i386/pc_piix.c
> > > > > +++ b/hw/i386/pc_piix.c
> > > > > @@ -432,9 +432,11 @@ DEFINE_I440FX_MACHINE(v5_0, "pc-i440fx-5.0",=
 NULL,
> > > > >    static void pc_i440fx_4_2_machine_options(MachineClass *m)
> > > > >    {
> > > > > +    PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
> > > > >        pc_i440fx_5_0_machine_options(m);
> > > > >        m->alias =3D NULL;
> > > > >        m->is_default =3D false;
> > > > > +    pcmc->do_not_add_waet_acpi =3D true;
> > > > >        compat_props_add(m->compat_props, hw_compat_4_2, hw_compat=
_4_2_len);
> > > > >        compat_props_add(m->compat_props, pc_compat_4_2, pc_compat=
_4_2_len);
> > > > >    }
> > > > > diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> > > > > index 84cf925cf43a..1e0a726b27a7 100644
> > > > > --- a/hw/i386/pc_q35.c
> > > > > +++ b/hw/i386/pc_q35.c
> > > > > @@ -361,8 +361,10 @@ DEFINE_Q35_MACHINE(v5_0, "pc-q35-5.0", NULL,
> > > > >    static void pc_q35_4_2_machine_options(MachineClass *m)
> > > > >    {
> > > > > +    PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
> > > > >        pc_q35_5_0_machine_options(m);
> > > > >        m->alias =3D NULL;
> > > > > +    pcmc->do_not_add_waet_acpi =3D true;
> > > > >        compat_props_add(m->compat_props, hw_compat_4_2, hw_compat=
_4_2_len);
> > > > >        compat_props_add(m->compat_props, pc_compat_4_2, pc_compat=
_4_2_len);
> > > > >    }
> > > > > diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-d=
efs.h
> > > > > index 57a3f58b0c9a..803c904471d5 100644
> > > > > --- a/include/hw/acpi/acpi-defs.h
> > > > > +++ b/include/hw/acpi/acpi-defs.h
> > > > > @@ -634,4 +634,29 @@ struct AcpiIortRC {
> > > > >    } QEMU_PACKED;
> > > > >    typedef struct AcpiIortRC AcpiIortRC;
> > > > > +/*
> > > > > + * Windows ACPI Emulated Devices Table.
> > > > > + * Specification:
> > > > > + * https://urldefense.com/v3/__http://download.microsoft.com/dow=
nload/7/E/7/7E7662CF-CBEA-470B-A97E-CE7CE0D98DC2/WAET.docx____;!!GqivPVa7Br=
io!MX1Hzr4X9NtS4pcT1Kb4VlDoV-pobn4n6YYQCkU3U-7imIaxXmu_ZsQzPB0e2Tc$
> > Please include
> > - name of the spec
> The name of the spec is "Windows ACPI Emulated Devices Table".
> You can see this by entering above link...

Links go stale. Then someone will have to dig to find the new location.
Name of the document will be helpful for that.

> > - earliest revision that includes the relevant bits
> The above link is to version 1.0 of the document (Which as far as I know,=
 is
> the only version ever released).
> So the bits exists in all revisions. Which documentation do you want me t=
o
> add then?

1. name of the document
2. revision of the document that includes the bit (if multiple,
include the earliest revision)

--=20
MST


