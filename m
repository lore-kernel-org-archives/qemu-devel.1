Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2EAFC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:28:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDD20214AF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gKweddJh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDD20214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j04ce-000172-TV
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:28:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49944)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j04bd-0000Ew-T3
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:27:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j04bc-0002b4-Pa
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:27:41 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24635
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j04bc-0002Zt-Ly
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:27:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581085660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rAaFfbbWuueE+CH3D2w4/AhbcXvm0SdG98aPBQGIqxo=;
 b=gKweddJhD8Cj/0SJOJCYvPB9edC7wCH4qXwqJ7GiNhs+9Rr6Nv+0azJQtpZRb+moZ/FAwO
 ns97rMRw7+5zfiLIXrhkiaLtQHcvRxSMrnIy/lRzYnvxsL+cK94Fzb6BufqUaxH2QfwRJJ
 IiHddQ4BKK++5GczvHKFYncFUEf00lc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-eV1iR0zAO-qRvjb037H5qw-1; Fri, 07 Feb 2020 09:27:37 -0500
Received: by mail-qt1-f200.google.com with SMTP id d9so1685214qtq.13
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 06:27:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=/+mcTgyM4TM1KAKKxzzXGQSR6tVRzBp69dTvTGgPD44=;
 b=WK9BU49G1xRlMKrH+tcMLuMPAwEtSm7jim7b8amSqBdMcGrP+hZ36VCykI72mdcmjR
 VitQwD279p9EBOIpE7bHVWD1ljeyVC7R6vhLd6wM2d3cfjBmxyiBM1Io2yXvxXPjkKrj
 zcAiNBpEwoG7SHaJLJVvxX0gAZJN2kRFdo7kXlc0dmp2ffQ+FD6jVMyGmq3VFYHDVr0I
 fqOWVJMrvQ8SVdypUMdVXbrAAzwuQrM8ZNzShuQGXnL3w2Gq21nS4Xsty3ZlZpHU+yl8
 ltJZyoUcqqdJw5q9RctDjYMvP0yyodJPccGmTBFoCxlWTlsoaLTgWw+4UA0HIjL3nb5a
 31Lw==
X-Gm-Message-State: APjAAAVnDGHNHdRDGH8aD7QSsfDG37TqPajtrzcculujIoYjhTwqWaS1
 yeSfT6Jmb5u3Cw03gSTcc3kUjBVbV3OmSQTl5dHdHbcVSXvhbgAYTTw8s0FHS8ZHoWqBzQYNKZ0
 PK3Uhoi7FJ6trK98=
X-Received: by 2002:a37:4743:: with SMTP id u64mr6197508qka.289.1581085657019; 
 Fri, 07 Feb 2020 06:27:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqzOAOQ0h44AfXyncve+EbK3kF0y3Em8xW8NUgYoxGGWwG6j1kj//dCEYeJnZkM5S91Tmjpcig==
X-Received: by 2002:a37:4743:: with SMTP id u64mr6197493qka.289.1581085656782; 
 Fri, 07 Feb 2020 06:27:36 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
 by smtp.gmail.com with ESMTPSA id h13sm1434089qtu.23.2020.02.07.06.27.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 06:27:36 -0800 (PST)
Date: Fri, 7 Feb 2020 09:27:32 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH] ppc: function to setup latest class options
Message-ID: <20200207092612-mutt-send-email-mst@kernel.org>
References: <20200207064628.1196095-1-mst@redhat.com>
 <e77a2a7b-ed74-7584-4751-711b115e98c7@redhat.com>
 <20200207121209.06a1be98@bahia.lan>
MIME-Version: 1.0
In-Reply-To: <20200207121209.06a1be98@bahia.lan>
X-MC-Unique: eV1iR0zAO-qRvjb037H5qw-1
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
Cc: qemu-ppc@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Feb 07, 2020 at 12:12:09PM +0100, Greg Kurz wrote:
> On Fri, 7 Feb 2020 11:35:47 +0100
> Philippe Mathieu-Daud=E9 <philmd@redhat.com> wrote:
>=20
> > On 2/7/20 7:48 AM, Michael S. Tsirkin wrote:
> > > We are going to add more init for the latest machine, so move the set=
up
> > > to a function so we don't have to change the DEFINE_SPAPR_MACHINE mac=
ro
> > > each time.
> > >=20
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > ---
> > >   hw/ppc/spapr.c | 9 +++++++--
> > >   1 file changed, 7 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index 02cf53fc5b..4cf2a992a5 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -4428,6 +4428,12 @@ static const TypeInfo spapr_machine_info =3D {
> > >       },
> > >   };
> > >  =20
> > > +static void spapr_machine_latest_class_options(MachineClass *mc)
> > > +{
> > > +    mc->alias =3D "pseries";
> > > +    mc->is_default =3D 1;
> >=20
> > But we can have only 1 default per QEMU binary... How PPC manage having=
=20
> > multiple defaults? The first or last listed is choosen as default?
> >=20
>=20
> IIUC it isn't about putting multiple defaults here. It is about putting
> any additional init for the default machine type that we cannot put in
> spapr_machine_class_init(), instead of putting it in the versioned
> init function, eg. spapr_machine_5_0_class_options(). Otherwise this
> would force us to carry the change when we add a new machine version.

Maybe it's cleaner to pass the latest flag to
spapr_machine_latest_class_options? Rename it spapr_machine_default_class_o=
ptions?
This way we don't need to bother clearing is_default in other
machine types, we'll only set it for the latest one.

> > > +}
> > > +
> > >   #define DEFINE_SPAPR_MACHINE(suffix, verstr, latest)               =
  \
> > >       static void spapr_machine_##suffix##_class_init(ObjectClass *oc=
, \
> > >                                                       void *data)    =
  \
> > > @@ -4435,8 +4441,7 @@ static const TypeInfo spapr_machine_info =3D {
> > >           MachineClass *mc =3D MACHINE_CLASS(oc);                    =
    \
> > >           spapr_machine_##suffix##_class_options(mc);                =
  \
> > >           if (latest) {                                              =
  \
> > > -            mc->alias =3D "pseries";                                =
   \
> > > -            mc->is_default =3D 1;                                   =
   \
> > > +            spapr_machine_latest_class_options(mc);                 =
 \
> > >           }                                                          =
  \
> > >       }                                                              =
  \
> > >       static const TypeInfo spapr_machine_##suffix##_info =3D {      =
    \
> > >=20
> >=20
> >=20


