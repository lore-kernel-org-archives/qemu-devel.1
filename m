Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E80C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 06:13:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA45620578
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 06:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Asz1pA1D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA45620578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCH6C-0007Yb-W7
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 02:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54260)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jCH5Z-0006rr-En
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 02:13:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jCH5X-0000dl-J0
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 02:13:01 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28734
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jCH5X-0000dY-Df
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 02:12:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583993578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/6MRL5yVU+swEirE2WOjfGOGOqDeHuXWRNFT0S8dqHc=;
 b=Asz1pA1D0+G+xiR0KenGJytTZGuX0KOSn0mooCRasIIAtcY4q9AElbgbYmus0n60sMfXhw
 GZw+TV2roYZvO8QywvgiToV4tcJex6G5zqkCQOsmAfsehgTdsNrMaVNi4J2RV0dPMKct0B
 2HE6439NqcVNT6C+qS+pd7V4CNlKvww=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-iaEnSTeVM-2lIlMknZ9QlA-1; Thu, 12 Mar 2020 02:12:40 -0400
X-MC-Unique: iaEnSTeVM-2lIlMknZ9QlA-1
Received: by mail-qk1-f197.google.com with SMTP id m6so3192254qkm.2
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 23:12:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=bSkhJtaxt21AzUP7/t5hNj448wxs3bIKfh3bYZ/ui+M=;
 b=bd5g+k1wQ40XK77E8PORlC+zyflkqn4eKH4qQZm8njXjFVpLWMFoQ7RGtOWC49wQeB
 Xv2Iemn2oO0IsyAGg02QZs4UYc7pxvBW0Uc2JjZJuQ2hq4+zOw8IdCwPbDfSzG5CZKAu
 +zpu5hj0KYdhGk3TeRqkHXWo0UsEHgQp4DK7qQzJJhjHBYWXXULH51Kp2RUoKw9+gvR9
 skHQ55CPq8Mv3UBuUz5mKP9AaA9DQ8+G6q3j52rQZAeIwTX5OZ7q5WgZ+ex0L4dRde1x
 VgM7MZC1Fn+NoQl8cJyO9Z5AuItxCmTfVrog7epWEOACh18zkS5DCXKhVtKL9QmWgeqQ
 3cmQ==
X-Gm-Message-State: ANhLgQ0fR7ybmKpDImUFBfkeCUwG9wELgcuSDoYGDTqRt9/4MT60CVXU
 ds+H9wQREeEJXWUhlo9IKqwqINS94sMwB9fpZYAU/a1r1Shwxy7CxIDIZtKg7o6WN0meJvzNacY
 ehUQUh7KoaPz+J3E=
X-Received: by 2002:a0c:9b96:: with SMTP id o22mr5697131qve.169.1583993559616; 
 Wed, 11 Mar 2020 23:12:39 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vu1iB+t7azlXmEb787onmDznmZtyBVxflgp0OZhMa95qyCNpR8KodmJX/J/euzj3xogJUZEkA==
X-Received: by 2002:a0c:9b96:: with SMTP id o22mr5697112qve.169.1583993559193; 
 Wed, 11 Mar 2020 23:12:39 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id b7sm8398446qkh.0.2020.03.11.23.12.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2020 23:12:37 -0700 (PDT)
Date: Thu, 12 Mar 2020 02:12:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH] acpi: Add Windows ACPI Emulated Device Table (WAET)
Message-ID: <20200312012859-mutt-send-email-mst@kernel.org>
References: <20200311170826.79419-1-liran.alon@oracle.com>
 <20200311162509-mutt-send-email-mst@kernel.org>
 <92564357-25c1-0a0f-537b-6902f45a88d0@oracle.com>
MIME-Version: 1.0
In-Reply-To: <92564357-25c1-0a0f-537b-6902f45a88d0@oracle.com>
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
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org, imammedo@redhat.com,
 Elad Gabay <elad.gabay@oracle.com>, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 12, 2020 at 01:20:02AM +0200, Liran Alon wrote:
>=20
> On 11/03/2020 22:36, Michael S. Tsirkin wrote:
> > Thanks for the patch! Some questions/comments:
> >=20
> > On Wed, Mar 11, 2020 at 07:08:26PM +0200, Liran Alon wrote:
> > > From: Elad Gabay <elad.gabay@oracle.com>
> > >=20
> > > Microsoft introduced this ACPI table to avoid Windows guests performi=
ng
> > > various workarounds for device erratas. As the virtual device emulate=
d
> > > by VMM may not have the errata.
> > >=20
> > > Currently, WAET allows hypervisor to inform guest about two
> > > specific behaviors: One for RTC and the other for ACPI PM Timer.
> > >=20
> > > Support for WAET have been introduced since Windows Vista. This ACPI
> > > table is also exposed by other hypervisors, such as VMware, by defaul=
t.
> > >=20
> > > This patch adds WAET ACPI Table to QEMU.
> > Could you add a bit more info? Why is this so useful we are adding this
> > by default? How does it change windows behaviour when present?
> It changes behavior as documented in the WAET specification linked below
> (and the comments above the flags definitions).
> Specifically for ACPI_WAET_PM_TIMER_GOOD (Which is the only bit we set), =
the
> guest performs only one read of ACPI PM Timer instead of multiple to obta=
in
> it's value.
> Which improves performance as it removes unnecessary VMExits.

Sounds excellent. Pls include this info in the commit log. As with any
performance optimization, pls add a bit of info about how you tested
and what kind of speedup was seen.


> >=20
> > > It also makes sure to introduce
> > > the new ACPI table only for new machine-types.
> > OK and why is that?
> As ACPI tables are guest-visible, we should make sure to not change it
> between machine-types.
> For example, a change in ACPI tables may invalidate a Windows guest licen=
se
> activation (As platform have changed).

I don't think there's something like this taken into account, no.

> But this is just a good practice in general and in the past it was said b=
y
> maintainers that this is one of the main reasons that ACPI and SMBIOS
> generation have moved from SeaBIOS to QEMU.

I think a flag to disable this might make sense though. For example,
some guests might behave differently and get broken.


> >=20
> > > Signed-off-by: Elad Gabay <elad.gabay@oracle.com>
> > > Co-developed-by: Liran Alon <liran.alon@oracle.com>
> > > Signed-off-by: Liran Alon <liran.alon@oracle.com>
> > > ---
> > >   hw/i386/acpi-build.c        | 18 ++++++++++++++++++
> > >   hw/i386/pc_piix.c           |  2 ++
> > >   hw/i386/pc_q35.c            |  2 ++
> > >   include/hw/acpi/acpi-defs.h | 25 +++++++++++++++++++++++++
> > >   include/hw/i386/pc.h        |  1 +
> > >   5 files changed, 48 insertions(+)
> > >=20
> > > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > > index 9c4e46fa7466..29f70741cd96 100644
> > > --- a/hw/i386/acpi-build.c
> > > +++ b/hw/i386/acpi-build.c
> > > @@ -2512,6 +2512,19 @@ build_dmar_q35(GArray *table_data, BIOSLinker =
*linker)
> > >       build_header(linker, table_data, (void *)(table_data->data + dm=
ar_start),
> > >                    "DMAR", table_data->len - dmar_start, 1, NULL, NUL=
L);
> > >   }
> > > +
> > > +static void
> > > +build_waet(GArray *table_data, BIOSLinker *linker)

Add documentation that it's a Windows Emulated Device Flags table,
helpful to speed up windows guests, and ignored by others.

> > > +{
> > > +    AcpiTableWaet *waet;
> > > +
> > > +    waet =3D acpi_data_push(table_data, sizeof(*waet));
> > Can combine with the previous line.
> Ok. Will do in v2.
> >=20
> > > +    waet->emulated_device_flags =3D cpu_to_le32(ACPI_WAET_PM_TIMER_G=
OOD);
> > > +
> > > +    build_header(linker, table_data,
> > > +                 (void *)waet, "WAET", sizeof(*waet), 1, NULL, NULL)=
;
> > > +}
> > > +
> > >   /*
> > >    *   IVRS table as specified in AMD IOMMU Specification v2.62, Sect=
ion 5.2
> > >    *   accessible here https://urldefense.com/v3/__http://support.amd=
.com/TechDocs/48882_IOMMU.pdf__;!!GqivPVa7Brio!OAQpLo9QhdHiNDa_aRLR_ma1nWLZ=
U1aQhDozYgUlrqBZiz1vKdZgg-lTDMIj_5g$
> > > @@ -2859,6 +2872,11 @@ void acpi_build(AcpiBuildTables *tables, Machi=
neState *machine)
> > >                             machine->nvdimms_state, machine->ram_slot=
s);
> > >       }
> > > +    if (!pcmc->do_not_add_waet_acpi) {
> > > +        acpi_add_table(table_offsets, tables_blob);
> > > +        build_waet(tables_blob, tables->linker);
> > > +    }
> > > +
> > >       /* Add tables supplied by user (if any) */
> > >       for (u =3D acpi_table_first(); u; u =3D acpi_table_next(u)) {
> > >           unsigned len =3D acpi_table_len(u);
> > > diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> > > index 9088db8fb601..2d11a8b50a9c 100644
> > > --- a/hw/i386/pc_piix.c
> > > +++ b/hw/i386/pc_piix.c
> > > @@ -432,9 +432,11 @@ DEFINE_I440FX_MACHINE(v5_0, "pc-i440fx-5.0", NUL=
L,
> > >   static void pc_i440fx_4_2_machine_options(MachineClass *m)
> > >   {
> > > +    PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
> > >       pc_i440fx_5_0_machine_options(m);
> > >       m->alias =3D NULL;
> > >       m->is_default =3D false;
> > > +    pcmc->do_not_add_waet_acpi =3D true;
> > >       compat_props_add(m->compat_props, hw_compat_4_2, hw_compat_4_2_=
len);
> > >       compat_props_add(m->compat_props, pc_compat_4_2, pc_compat_4_2_=
len);
> > >   }
> > > diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> > > index 84cf925cf43a..1e0a726b27a7 100644
> > > --- a/hw/i386/pc_q35.c
> > > +++ b/hw/i386/pc_q35.c
> > > @@ -361,8 +361,10 @@ DEFINE_Q35_MACHINE(v5_0, "pc-q35-5.0", NULL,
> > >   static void pc_q35_4_2_machine_options(MachineClass *m)
> > >   {
> > > +    PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
> > >       pc_q35_5_0_machine_options(m);
> > >       m->alias =3D NULL;
> > > +    pcmc->do_not_add_waet_acpi =3D true;
> > >       compat_props_add(m->compat_props, hw_compat_4_2, hw_compat_4_2_=
len);
> > >       compat_props_add(m->compat_props, pc_compat_4_2, pc_compat_4_2_=
len);
> > >   }
> > > diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.=
h
> > > index 57a3f58b0c9a..803c904471d5 100644
> > > --- a/include/hw/acpi/acpi-defs.h
> > > +++ b/include/hw/acpi/acpi-defs.h
> > > @@ -634,4 +634,29 @@ struct AcpiIortRC {
> > >   } QEMU_PACKED;
> > >   typedef struct AcpiIortRC AcpiIortRC;
> > > +/*
> > > + * Windows ACPI Emulated Devices Table.
> > > + * Specification:
> > > + * http://download.microsoft.com/download/7/E/7/7E7662CF-CBEA-470B-A=
97E-CE7CE0D98DC2/WAET.docx__

Please include
- name of the spec
- earliest revision that includes the relevant bits


> > > + */
> > > +
> > > +/*
> > > + * Indicates whether the RTC has been enhanced not to require acknow=
ledgment
> > > + * after it asserts an interrupt. With this bit set, an interrupt ha=
ndler can
> > > + * bypass reading the RTC register C to unlatch the pending interrup=
t.
> > > + */
> > > +#define ACPI_WAET_RTC_GOOD      (1 << 0)

Include the name of the field exactly as it appears in the spec pls.
"RTC good"?

So if you feel you need to document that this bit is clear, you can do it
like this:

=09 /* Bit 0 - PV RTC which doesn't need an acknowledgment after an interru=
pt assert.
=09    Clear since our RTC behaves like the hardware one. */

=09


> > > +/*
> > > + * Indicates whether the ACPI PM timer has been enhanced not to requ=
ire
> > > + * multiple reads. With this bit set, only one read of the ACPI PM t=
imer is
> > > + * necessary to obtain a reliable value.
> > > + */
> > > +#define ACPI_WAET_PM_TIMER_GOOD (1 << 1)

Go easy on what we do, and harder on why please:

=09/* ACPI PM timer good - tells windows guests our PM timer is reliable -
=09 * guests then avoid re-reading it.
=09 */
should be enough.

> > > +
> > ACPI spec is so huge we really can't add enums for all values,
> > it just does not scale.
> >=20
> >=20
> > So we switched to a different way to do this: you add e.g. 1 << 1
> > in the code directly, and put the comments there.
>=20
> Ok. I will change this as you say in v2.
>=20
> BTW it seems other code in acpi-build.c still relies on flags definitions=
 in
> acpi-defs.h (As I have done in this v1). E.g. ACPI_DMAR_TYPE_*, ACPI_APIC=
_*,
> ACPI_FADT_F_*.
> I assume this is just code that wasn't changed yet to the new convention?

Yes - we only do it when we are actually changing code.

> > Igor this is becoming a FAQ. Could you write up the way ACPI
> > generation code should look?
>=20
> +1.
>=20
> Thanks for the review,
> -Liran
>=20


