Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40421C2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 15:01:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B8E821734
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 15:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BRni3lY9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B8E821734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inOS6-0008Oh-25
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 10:01:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54760)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1inOR2-0007qq-LM
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 10:00:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1inOR0-0005A6-CL
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 10:00:19 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28486
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1inOR0-00050a-5r
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 10:00:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578063616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dw2G9HCTIqDWld2tmJcEDzR7suxURqOnX0k0+VydY8g=;
 b=BRni3lY9RSR0LQd0uC0EnjbCs9KqK1Din7qArhMBawOJcucLKt9mDjosWmlaBljVtaEhEa
 2Ujp1DMiVhq7Eu5FQqlFVPTJ3fVHRdtrY/iWCEFZi1MCZC524jYGgisJbAK8U/8L3BiB+4
 cDnvm/5SYty0OdYUHKa134z8tkvYX/I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-1YCMF6_tNWi8a8cdaRc8CQ-1; Fri, 03 Jan 2020 10:00:15 -0500
X-MC-Unique: 1YCMF6_tNWi8a8cdaRc8CQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 118631883526;
 Fri,  3 Jan 2020 15:00:12 +0000 (UTC)
Received: from localhost (ovpn-116-92.ams2.redhat.com [10.36.116.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A2D0863BCA;
 Fri,  3 Jan 2020 15:00:05 +0000 (UTC)
Date: Fri, 3 Jan 2020 15:00:03 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: Re: [RFC v4 PATCH 00/49] Initial support of multi-process qemu -
 status update
Message-ID: <20200103150003.GA277936@stefanha-x1.localdomain>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <20191210064716.GA6401@flaka>
 <20191213104116.GB1180977@stefanha-x1.localdomain>
 <20191216194655.GA5922@flaka>
 <AFBAD3A1-0E22-4E22-AF22-C56794929D87@nutanix.com>
 <20191217163316.GB1333385@stefanha-x1.localdomain>
 <20200102160136.GA20919@heatpipe>
MIME-Version: 1.0
In-Reply-To: <20200102160136.GA20919@heatpipe>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
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
Cc: "fam@euphon.net" <fam@euphon.net>,
 "john.g.johnson@oracle.com" <john.g.johnson@oracle.com>,
 Swapnil Ingle <swapnil.ingle@nutanix.com>, "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "jag.raman@oracle.com" <jag.raman@oracle.com>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "kanth.ghatraju@oracle.com" <kanth.ghatraju@oracle.com>,
 Felipe Franciosi <felipe@nutanix.com>, "thuth@redhat.com" <thuth@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "liran.alon@oracle.com" <liran.alon@oracle.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 "rth@twiddle.net" <rth@twiddle.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "ross.lagerwall@citrix.com" <ross.lagerwall@citrix.com>,
 "marcandre.lureau@gmail.com" <marcandre.lureau@gmail.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 02, 2020 at 08:01:36AM -0800, Elena Ufimtseva wrote:
> On Tue, Dec 17, 2019 at 04:33:16PM +0000, Stefan Hajnoczi wrote:
> > On Mon, Dec 16, 2019 at 07:57:32PM +0000, Felipe Franciosi wrote:
> > > > On 16 Dec 2019, at 20:47, Elena Ufimtseva <elena.ufimtseva@oracle.c=
om> wrote:
> > > > =EF=BB=BFOn Fri, Dec 13, 2019 at 10:41:16AM +0000, Stefan Hajnoczi =
wrote:
> > > >> Is there a work-in-progress muser patch series you can post to sta=
rt the
> > > >> discussion early?  That way we can avoid reviewers like myself ask=
ing
> > > >> you to make changes after you have invested a lot of time.
> > > >>=20
> > > >=20
> > > > Absolutely, that is our plan. At the moment we do not have the patc=
hes
> > > > ready for the review. We have setup internally a milestone and will=
 be
> > > > sending that early version as a tarball after we have it completed.
> > > > Would be also a meeting something that could help us to stay on the=
 same
> > > > page?
> > >=20
> > > Please loop us in if you so set up a meeting.
> >
>=20
> Hi Stefan
>=20
> And happy New Year to everyone!
>=20
> > There is a bi-weekly KVM Community Call that we can use for phone
> > discussions:
> >=20
> >   https://calendar.google.com/calendar/embed?src=3DdG9iMXRqcXAzN3Y4ZXZw=
NzRoMHE4a3BqcXNAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ
> >
>=20
> Our team would like to join the call on Jan 14 and maybe talk over few th=
ings.
> Felipe, will you and your team be joining as well?

Great, I'll be there.

Stefan

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4PVvMACgkQnKSrs4Gr
c8gtKQgAqAZcNyBIcmhusi6jzpMHw9Cph9C0NR2Vt1QIiVQuesRvRT34pzHkzFDC
+4gL3ZMGv85dtqzN54LJNE7GDlm8AKragfonpUjNKrEhLZ65HU+FJ+vBNU4oU9st
AA+rRZSLzdKYkMNjP6tw5L7JLbYQ+JPEw6G/mKbn/EiRksH8LjzXUhHj5KB3Xel7
ArYh4RxaEBmfGHT+9LfO3iv3UvrlCa8IHBJqJ/NtcE1xZnUuTTOvM+cz4pbNDewW
MgoNV1xbWzGwt2cYu+8J+/fRf4i/lKSOHTWQuEUuemkndz/5zxAZzQuQ6+sSxn7e
OuvfdZLzpknQx3YNPfOhxhC+UPwWIQ==
=hzRh
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--


