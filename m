Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FF9C2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 15:28:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA73820724
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 15:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F+PAEBOH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA73820724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCmEr-0004AO-2o
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 11:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55797)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jCmDC-0002ZX-5i
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 11:26:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jCmDA-0001JW-9B
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 11:26:57 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42149
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jCmDA-0001HQ-1u
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 11:26:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584113214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kC8wm5oSNMcPE+klT92qbj64Ff7ypUiE3dhF/uihzCE=;
 b=F+PAEBOH40jX6V1DFqz32/HV8i901BeCWcFukUqwdZz11p/csFL64HJcwP7ZeCUT64kvXV
 x30XXuGrR588joQPN8nuZZTLq0dRNVa4YqOKAeagVgxsy7zIy+jH8lbmV2/q54XyAgx/W2
 4nlpqosIUVh0qFlzp9+Uv/kT+Gd5Uqk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-1yBtXSEUPzqVyAdOF-wYxg-1; Fri, 13 Mar 2020 11:26:53 -0400
X-MC-Unique: 1yBtXSEUPzqVyAdOF-wYxg-1
Received: by mail-qk1-f198.google.com with SMTP id j10so8363281qkm.12
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 08:26:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=a9PgsoztCczntXVY6YPgWWW/szA3xBtAi/nK3fZQgqM=;
 b=CGEOuw8RZO/q0cC3pbVOgNikrHKi/9lS0wsj1IDbinw7TlbEIVPMLr5asHiZvnB/JH
 0VCNylR8Bapn8EYcS0JER8SOFCmaUG0oHNW9zfy4JP+ROeMGFFspJJWqwJHnHCNgkRX7
 ubhDCD/KYouaOhO0n6zuJotulOHCxGTBBXUaFbH/Tgj2jZBnKlAr2PzKGqm35l/MOGyh
 g/x0GyMAjjFDuFYTjA39EzHYAl12FZYA39/C18lS2yIk6HTRcrVGVpRwIEERmR6jD8wb
 SQj0E1yTQM7dmtTw5RfU311+gPgvFZBA28oh/zqYoopHMoMG4Vxs4tnQArJWkU5Nv3PQ
 icCA==
X-Gm-Message-State: ANhLgQ1/SZPK7QmKOWPUVqqGzsfj70WfIr8ZVxuT6fkAu4vITI2hjaSg
 3wYvCapDCUVR5285gQ/ShRec2dPDuVaHdSUzNyPpOE6oAbjbZlJ3cdLhIgkguh3E2NoG0EEFtBz
 cn1n5JnBVYAxMwug=
X-Received: by 2002:ac8:3659:: with SMTP id n25mr13012212qtb.254.1584113212495; 
 Fri, 13 Mar 2020 08:26:52 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vukUjZvss/3tRE3AgQy9YLSgkUbkyt8L7qh8AReRrMFlP7mnMkTsArmrP5tK7rFQ3zxvivpgg==
X-Received: by 2002:ac8:3659:: with SMTP id n25mr13012189qtb.254.1584113212174; 
 Fri, 13 Mar 2020 08:26:52 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id g2sm29367684qkb.27.2020.03.13.08.26.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2020 08:26:51 -0700 (PDT)
Date: Fri, 13 Mar 2020 11:26:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH] acpi: Add Windows ACPI Emulated Device Table (WAET)
Message-ID: <20200313110940-mutt-send-email-mst@kernel.org>
References: <20200311170826.79419-1-liran.alon@oracle.com>
 <20200312172745.1b7b2222@redhat.com>
 <20200312130854-mutt-send-email-mst@kernel.org>
 <20200313103656.094ec89b@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200313103656.094ec89b@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

On Fri, Mar 13, 2020 at 10:36:56AM +0100, Igor Mammedov wrote:
> On Thu, 12 Mar 2020 13:09:51 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>=20
> > On Thu, Mar 12, 2020 at 05:27:45PM +0100, Igor Mammedov wrote:
> > > On Wed, 11 Mar 2020 19:08:26 +0200
> > > Liran Alon <liran.alon@oracle.com> wrote:
> > >  =20
> > > > From: Elad Gabay <elad.gabay@oracle.com>
> > > >=20
> > > > Microsoft introduced this ACPI table to avoid Windows guests perfor=
ming
> > > > various workarounds for device erratas. As the virtual device emula=
ted
> > > > by VMM may not have the errata.
> > > >=20
> > > > Currently, WAET allows hypervisor to inform guest about two
> > > > specific behaviors: One for RTC and the other for ACPI PM Timer.
> > > >=20
> > > > Support for WAET have been introduced since Windows Vista. This ACP=
I
> > > > table is also exposed by other hypervisors, such as VMware, by defa=
ult.
> > > >=20
> > > > This patch adds WAET ACPI Table to QEMU. It also makes sure to intr=
oduce
> > > > the new ACPI table only for new machine-types. =20
> > >=20
> > > in addition to comments made by Michael ...
> > >  =20
> > > >=20
> > > > Signed-off-by: Elad Gabay <elad.gabay@oracle.com>
> > > > Co-developed-by: Liran Alon <liran.alon@oracle.com>
> > > > Signed-off-by: Liran Alon <liran.alon@oracle.com>
> > > > ---
> > > >  hw/i386/acpi-build.c        | 18 ++++++++++++++++++
> > > >  hw/i386/pc_piix.c           |  2 ++
> > > >  hw/i386/pc_q35.c            |  2 ++
> > > >  include/hw/acpi/acpi-defs.h | 25 +++++++++++++++++++++++++
> > > >  include/hw/i386/pc.h        |  1 +
> > > >  5 files changed, 48 insertions(+)
> > > >=20
> > > > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > > > index 9c4e46fa7466..29f70741cd96 100644
> > > > --- a/hw/i386/acpi-build.c
> > > > +++ b/hw/i386/acpi-build.c
> > > > @@ -2512,6 +2512,19 @@ build_dmar_q35(GArray *table_data, BIOSLinke=
r *linker)
> > > >      build_header(linker, table_data, (void *)(table_data->data + d=
mar_start),
> > > >                   "DMAR", table_data->len - dmar_start, 1, NULL, NU=
LL);
> > > >  }
> > > > +
> > > > +static void
> > > > +build_waet(GArray *table_data, BIOSLinker *linker) =20
> > > see build_hmat_lb() for example how to doc comment for such function
> > > should look like. Use earliest spec version where table was introduce=
d.
> > >  =20
> > > > +{
> > > > +    AcpiTableWaet *waet;
> > > > +
> > > > +    waet =3D acpi_data_push(table_data, sizeof(*waet));
> > > > +    waet->emulated_device_flags =3D cpu_to_le32(ACPI_WAET_PM_TIMER=
_GOOD); =20
> > >=20
> > > we don't use packed structures for building ACPI tables anymore (ther=
e is
> > > old code that still does but that's being converted when we touch it)
> > >=20
> > > pls use build_append_int_noprefix() api instead, see build_amd_iommu(=
) as
> > > an example how to build binary tables using it and how to use comment=
s
> > > to document fields.
> > > Basic idea is that api makes function building a table match table's
> > > description in spec (each call represents a row in spec) and comment
> > > belonging to a row should contain verbatim field name as used by spec
> > > so reader could copy/past and grep it easily. =20
> >=20
> >=20
> > BTW how about a better name for this function?
>=20
> how about [aml|acpi]_int_raw=20
> [...]

I'm not sure how this helps.  I think the main problems are
1- very long name
2- only makes sense if you know that ACPI has a special integer prefix
3- easy to confuse which is the value which is the length
4- length is in bytes (typical documentation is in bits)

Your suggestion only fixes issue 1.

Having listed it all out, I suggest the following for the purpose of
building structures:

=09acpi/aml/build_append_u8
=09acpi/aml/build_append_u16
=09acpi/aml/build_append_u32
=09acpi/aml/build_append_u64

and maybe
=09acpi/aml/build_append_pad( length)

I'm not sure what the best prefix is. I guess we can have them all
with the slightly different arguments.


--=20
MST


