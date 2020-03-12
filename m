Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67F3C1975A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:15:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 922532067C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 17:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LTSJGA64"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 922532067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCRQM-0006qP-Ng
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 13:15:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40539)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jCRLg-0000pz-F0
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 13:10:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jCRLd-0003L5-VR
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 13:10:20 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26300
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jCRLd-0003KO-Oj
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 13:10:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584033017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RgtMrHAQ/+GbDZ2xzfbDPaO4QwWBRFdbKyUO6d2H7+g=;
 b=LTSJGA643OY05nFWvudjjr1nOf3J1wVyG/AdPEIJRzMUKt51SjuqWHtpSPUXDRk82QYxMo
 DCH8Zjf6OsdqP9mG+Zy5psfMpJELrL0cmyWS8lw2CvJjGowLkf4DC6kGgXElJXIkz4nC86
 RO/AXaWOO74RNMtav/cAIvqMKlZr7nQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-FUMsz8AtOG6P9CYiyTElTA-1; Thu, 12 Mar 2020 13:09:59 -0400
X-MC-Unique: FUMsz8AtOG6P9CYiyTElTA-1
Received: by mail-qt1-f200.google.com with SMTP id e21so4357656qts.14
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 10:09:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Lo0yrIzPvCEzlDM2nQC+VsthWiHMcCUQf5ZgpSXcgD8=;
 b=T56LCAeR+KU2QJb3p0MPNiAj1al7ur9TTMNgVJexPKJauutBySZTdSttcEKiItXcTT
 WcgpBy+pCBWtbTOxf/YTQ1Z+9+wCmP9JlkhaUdyLH3T0KR6wImEUay/pEEwuZ9iayOti
 A1AOj3ceHHTaRjvpMIIATjEHVtQd2TtbomQLPDgM3fCRJTfWin5bUtrv3G0PGp35HplS
 qMr3sHGImg0B+pGEvprmlFiQx3MEs4RRlaY820vjq3gsmWIG4sGps5na3pPNA/YAqKez
 maJFQkb/5LRlzkoNDiVbWuloASIkYWyZfqy3rPuT79NfrBnVKSGDDs8iYCK/kNq5iXS4
 JQag==
X-Gm-Message-State: ANhLgQ1VsCCt/WQU/wLAFRPJcS1yr2tSOrNuAqCbq29RaYQYJBn7eZFK
 mPNOiNYAooZ9wiSjMbZcyCICCkhCT+iYzb6nv0eHtSCmSQClm+CuSYTx4dPttVXzaXQNy8p4ZoN
 lMxKOBHygqm0b0X8=
X-Received: by 2002:ac8:3148:: with SMTP id h8mr8368931qtb.341.1584032998701; 
 Thu, 12 Mar 2020 10:09:58 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsNHOoJivFILMwo7z83jxE6vAL7sf5bw6uO/2qbEA8jxAWsdXaLYSlN/ldycjQxw1C7g393kg==
X-Received: by 2002:ac8:3148:: with SMTP id h8mr8368891qtb.341.1584032998244; 
 Thu, 12 Mar 2020 10:09:58 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id h24sm20742633qkk.3.2020.03.12.10.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 10:09:56 -0700 (PDT)
Date: Thu, 12 Mar 2020 13:09:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH] acpi: Add Windows ACPI Emulated Device Table (WAET)
Message-ID: <20200312130854-mutt-send-email-mst@kernel.org>
References: <20200311170826.79419-1-liran.alon@oracle.com>
 <20200312172745.1b7b2222@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200312172745.1b7b2222@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
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
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org,
 Liran Alon <liran.alon@oracle.com>, Elad Gabay <elad.gabay@oracle.com>,
 pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 12, 2020 at 05:27:45PM +0100, Igor Mammedov wrote:
> On Wed, 11 Mar 2020 19:08:26 +0200
> Liran Alon <liran.alon@oracle.com> wrote:
>=20
> > From: Elad Gabay <elad.gabay@oracle.com>
> >=20
> > Microsoft introduced this ACPI table to avoid Windows guests performing
> > various workarounds for device erratas. As the virtual device emulated
> > by VMM may not have the errata.
> >=20
> > Currently, WAET allows hypervisor to inform guest about two
> > specific behaviors: One for RTC and the other for ACPI PM Timer.
> >=20
> > Support for WAET have been introduced since Windows Vista. This ACPI
> > table is also exposed by other hypervisors, such as VMware, by default.
> >=20
> > This patch adds WAET ACPI Table to QEMU. It also makes sure to introduc=
e
> > the new ACPI table only for new machine-types.
>=20
> in addition to comments made by Michael ...
>=20
> >=20
> > Signed-off-by: Elad Gabay <elad.gabay@oracle.com>
> > Co-developed-by: Liran Alon <liran.alon@oracle.com>
> > Signed-off-by: Liran Alon <liran.alon@oracle.com>
> > ---
> >  hw/i386/acpi-build.c        | 18 ++++++++++++++++++
> >  hw/i386/pc_piix.c           |  2 ++
> >  hw/i386/pc_q35.c            |  2 ++
> >  include/hw/acpi/acpi-defs.h | 25 +++++++++++++++++++++++++
> >  include/hw/i386/pc.h        |  1 +
> >  5 files changed, 48 insertions(+)
> >=20
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index 9c4e46fa7466..29f70741cd96 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -2512,6 +2512,19 @@ build_dmar_q35(GArray *table_data, BIOSLinker *l=
inker)
> >      build_header(linker, table_data, (void *)(table_data->data + dmar_=
start),
> >                   "DMAR", table_data->len - dmar_start, 1, NULL, NULL);
> >  }
> > +
> > +static void
> > +build_waet(GArray *table_data, BIOSLinker *linker)
> see build_hmat_lb() for example how to doc comment for such function
> should look like. Use earliest spec version where table was introduced.
>=20
> > +{
> > +    AcpiTableWaet *waet;
> > +
> > +    waet =3D acpi_data_push(table_data, sizeof(*waet));
> > +    waet->emulated_device_flags =3D cpu_to_le32(ACPI_WAET_PM_TIMER_GOO=
D);
>=20
> we don't use packed structures for building ACPI tables anymore (there is
> old code that still does but that's being converted when we touch it)
>=20
> pls use build_append_int_noprefix() api instead, see build_amd_iommu() as
> an example how to build binary tables using it and how to use comments
> to document fields.
> Basic idea is that api makes function building a table match table's
> description in spec (each call represents a row in spec) and comment
> belonging to a row should contain verbatim field name as used by spec
> so reader could copy/past and grep it easily.


BTW how about a better name for this function?

>=20
>=20
>=20
> > +
> > +    build_header(linker, table_data,
> > +                 (void *)waet, "WAET", sizeof(*waet), 1, NULL, NULL);
> > +}
> > +
> >  /*
> >   *   IVRS table as specified in AMD IOMMU Specification v2.62, Section=
 5.2
> >   *   accessible here http://support.amd.com/TechDocs/48882_IOMMU.pdf
> > @@ -2859,6 +2872,11 @@ void acpi_build(AcpiBuildTables *tables, Machine=
State *machine)
> >                            machine->nvdimms_state, machine->ram_slots);
> >      }
> > =20
> > +    if (!pcmc->do_not_add_waet_acpi) {
> > +        acpi_add_table(table_offsets, tables_blob);
> > +        build_waet(tables_blob, tables->linker);
> > +    }
>=20
> we typically do not version ACPI table changes (there might be exceptions
> but it should be a justified one).
> ACPI tables are considered to be a part of firmware (even though they are
> generated by QEMU) so on QEMU upgrade user gets a new firmware along with
> new ACPI tables.
>=20
> > +
> >      /* Add tables supplied by user (if any) */
> >      for (u =3D acpi_table_first(); u; u =3D acpi_table_next(u)) {
> >          unsigned len =3D acpi_table_len(u);
> > diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> > index 9088db8fb601..2d11a8b50a9c 100644
> > --- a/hw/i386/pc_piix.c
> > +++ b/hw/i386/pc_piix.c
> > @@ -432,9 +432,11 @@ DEFINE_I440FX_MACHINE(v5_0, "pc-i440fx-5.0", NULL,
> > =20
> >  static void pc_i440fx_4_2_machine_options(MachineClass *m)
> >  {
> > +    PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
> >      pc_i440fx_5_0_machine_options(m);
> >      m->alias =3D NULL;
> >      m->is_default =3D false;
> > +    pcmc->do_not_add_waet_acpi =3D true;
> >      compat_props_add(m->compat_props, hw_compat_4_2, hw_compat_4_2_len=
);
> >      compat_props_add(m->compat_props, pc_compat_4_2, pc_compat_4_2_len=
);
> >  }
> > diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> > index 84cf925cf43a..1e0a726b27a7 100644
> > --- a/hw/i386/pc_q35.c
> > +++ b/hw/i386/pc_q35.c
> > @@ -361,8 +361,10 @@ DEFINE_Q35_MACHINE(v5_0, "pc-q35-5.0", NULL,
> > =20
> >  static void pc_q35_4_2_machine_options(MachineClass *m)
> >  {
> > +    PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
> >      pc_q35_5_0_machine_options(m);
> >      m->alias =3D NULL;
> > +    pcmc->do_not_add_waet_acpi =3D true;
> >      compat_props_add(m->compat_props, hw_compat_4_2, hw_compat_4_2_len=
);
> >      compat_props_add(m->compat_props, pc_compat_4_2, pc_compat_4_2_len=
);
> >  }
> > diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
> > index 57a3f58b0c9a..803c904471d5 100644
> > --- a/include/hw/acpi/acpi-defs.h
> > +++ b/include/hw/acpi/acpi-defs.h
> > @@ -634,4 +634,29 @@ struct AcpiIortRC {
> >  } QEMU_PACKED;
> >  typedef struct AcpiIortRC AcpiIortRC;
> > =20
> > +/*
> > + * Windows ACPI Emulated Devices Table.
> > + * Specification:
> > + * http://download.microsoft.com/download/7/E/7/7E7662CF-CBEA-470B-A97=
E-CE7CE0D98DC2/WAET.docx
> > + */
> > +
> > +/*
> > + * Indicates whether the RTC has been enhanced not to require acknowle=
dgment
> > + * after it asserts an interrupt. With this bit set, an interrupt hand=
ler can
> > + * bypass reading the RTC register C to unlatch the pending interrupt.
> > + */
> > +#define ACPI_WAET_RTC_GOOD      (1 << 0)
> > +/*
> > + * Indicates whether the ACPI PM timer has been enhanced not to requir=
e
> > + * multiple reads. With this bit set, only one read of the ACPI PM tim=
er is
> > + * necessary to obtain a reliable value.
> > + */
> > +#define ACPI_WAET_PM_TIMER_GOOD (1 << 1)
> > +
> > +struct AcpiTableWaet {
> > +    ACPI_TABLE_HEADER_DEF
> > +    uint32_t emulated_device_flags;
> > +} QEMU_PACKED;
> > +typedef struct AcpiTableWaet AcpiTableWaet;
> > +
> >  #endif
> > diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> > index 60c988c4a5aa..f1f64e8f45c8 100644
> > --- a/include/hw/i386/pc.h
> > +++ b/include/hw/i386/pc.h
> > @@ -100,6 +100,7 @@ typedef struct PCMachineClass {
> >      int legacy_acpi_table_size;
> >      unsigned acpi_data_size;
> >      bool do_not_add_smb_acpi;
> > +    bool do_not_add_waet_acpi;
> > =20
> >      /* SMBIOS compat: */
> >      bool smbios_defaults;


