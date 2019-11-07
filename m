Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6220FC5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 10:13:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 315EE214D8
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 10:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gzX80yAn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 315EE214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSend-000663-B2
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 05:13:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34554)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iSemQ-0005ar-Vc
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 05:12:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iSemP-0005Ol-MA
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 05:12:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49467
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iSemP-0005Mw-HF
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 05:12:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573121561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tHwhlVhZUKtew0i7vISTKXP4xot1Ro3llNz+lcALFiA=;
 b=gzX80yAnuDr559bgE8JpAIPrEh5IBDlypzRF+WwFDcACZgOsqrzXcdmcZsT8m8U+EN05o4
 VYzKC26uzfjETtdQUDXHKxwXBrNsoBhoweMl8arw1FlMqtXpOPjt4kqMAEhCGWjI+Y8zOs
 D2vYV8mv01YxTr0cTZ09wFa6wOqB6LE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-ZrASH7GAPRCNWn8ikBHl6A-1; Thu, 07 Nov 2019 05:12:39 -0500
X-MC-Unique: ZrASH7GAPRCNWn8ikBHl6A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA0FC1005500;
 Thu,  7 Nov 2019 10:12:38 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-214.ams2.redhat.com [10.36.116.214])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 781A119757;
 Thu,  7 Nov 2019 10:12:37 +0000 (UTC)
Date: Thu, 7 Nov 2019 11:12:35 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [RFC PATCH 18/18] qemu-storage-daemon: Add --monitor option
Message-ID: <20191107101235.GB5007@linux.fritz.box>
References: <20191017130204.16131-1-kwolf@redhat.com>
 <20191017130204.16131-19-kwolf@redhat.com>
 <64d79019-711d-8eb1-da72-a9b95f999ff5@redhat.com>
MIME-Version: 1.0
In-Reply-To: <64d79019-711d-8eb1-da72-a9b95f999ff5@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: pkrempa@redhat.com, armbru@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 06.11.2019 um 15:32 hat Max Reitz geschrieben:
> On 17.10.19 15:02, Kevin Wolf wrote:
> > This adds and parses the --monitor option, so that a QMP monitor can be
> > used in the storage daemon. The monitor offers commands defined in the
> > QAPI schema at storage-daemon/qapi/qapi-schema.json.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  storage-daemon/qapi/qapi-schema.json | 15 ++++++++++++
> >  qemu-storage-daemon.c                | 34 ++++++++++++++++++++++++++++
> >  Makefile                             | 30 ++++++++++++++++++++++++
> >  Makefile.objs                        |  4 ++--
> >  monitor/Makefile.objs                |  2 ++
> >  qapi/Makefile.objs                   |  5 ++++
> >  qom/Makefile.objs                    |  1 +
> >  scripts/qapi/gen.py                  |  5 ++++
> >  storage-daemon/Makefile.objs         |  1 +
> >  storage-daemon/qapi/Makefile.objs    |  1 +
> >  10 files changed, 96 insertions(+), 2 deletions(-)
> >  create mode 100644 storage-daemon/qapi/qapi-schema.json
> >  create mode 100644 storage-daemon/Makefile.objs
> >  create mode 100644 storage-daemon/qapi/Makefile.objs
>=20
> [...]
>=20
> > diff --git a/qapi/Makefile.objs b/qapi/Makefile.objs
> > index 3e04e299ed..03d256f0a4 100644
> > --- a/qapi/Makefile.objs
> > +++ b/qapi/Makefile.objs
> > @@ -30,3 +30,8 @@ obj-y +=3D $(QAPI_TARGET_MODULES:%=3Dqapi-events-%.o)
> >  obj-y +=3D qapi-events.o
> >  obj-y +=3D $(QAPI_TARGET_MODULES:%=3Dqapi-commands-%.o)
> >  obj-y +=3D qapi-commands.o
> > +
> > +QAPI_MODULES_STORAGE_DAEMON =3D block block-core char common crypto in=
trospect
> > +QAPI_MODULES_STORAGE_DAEMON +=3D job monitor qom sockets pragma transa=
ction
>=20
> I took a look into the rest, and I wonder whether query-iothreads from
> misc.json would be useful, too.

Possibly. It would be a separate patch, but I can add it.

The question is just where to move query-iothreads. Do we have a good
place, or do I need to separate misc.json and a new misc-sysemu.json?

> > diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
> > index 796c17c38a..c25634f673 100644
> > --- a/scripts/qapi/gen.py
> > +++ b/scripts/qapi/gen.py
> > @@ -44,6 +44,11 @@ class QAPIGen(object):
> >          return ''
> > =20
> >      def write(self, output_dir):
> > +        # Include paths starting with ../ are used to reuse modules of=
 the main
> > +        # schema in specialised schemas. Don't overwrite the files tha=
t are
> > +        # already generated for the main schema.
> > +        if self.fname.startswith('../'):
> > +            return
>=20
> Sorry, but I=E2=80=99m about to ask a clueless question: How do we ensure=
 that
> the main schema is generated before something else could make sure of
> the specialized schemas?

"Make sure"?

I think the order of the generation doesn't matter because generating
the storage daemon files doesn't actually access the main ones.
Generated C files shouldn't be a problem either because if we link an
object file into a binary, we have a make dependency for it.

Maybe the only a bit trickier question is whether we have the
dependencies right so that qemu-storage-daemon.c is only built after the
header files of both the main schema and the specific one have been
generated. If I understand the Makefile correctly, generated-files-y
takes care of this, and this patch adds all new header files to it if I
didn't miss any.

Kevin

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdw+4TAAoJEH8JsnLIjy/WRcAQAKdnWaaR9LumipHwGyiJTT+t
oQFRsZgWkLKSmtvvyZu7XGzDz0iR3ppCdVh0U2U/c9Y8M5vJ65s9pHntOYvzhF5M
dFA70nHRBE/2RoM4Gwxp9zv+RSq+7iWdg5KjIH3bIHTIr5ut5vK4ZZVlEecXb1d8
IL04kQb34J/u6rmSG0nVpe2CvYgLU86wwLRm60cpTwv/ViPdVgA2zy8I+KLk4eZo
IYfRJ8wvqu2EJGjOIBqSDmW35B2GYcHAxlEfWpu4c3lHqtaNzokaHvbMRQkGdcuB
Un/imeGlu95UxH+VDYhxCtUHk5vSqmnHoguS5hBxHBxiKhdw1xI8S7wTuVOig13C
hNGouiLd7UQRb+tSbfZdCqPrSum0gEGGjmZjtqfyz/BNkOM+gWC/f7Ob/itt/87/
ciCM/CX5JmwwvdnKSlNHh+0LEVTXA6WrN/FAglkjMIRDfiKaTUbwC5EWYXr8CuWI
fW6c8efkMhMN8jcjm7OEydU3Bwi6IBOq5C+gy0cVzWiZc9rpF3BnvjARDjlOT0Tm
y1DvBzuOENS6U+k9+kDGFnxOa7x22G2PuVL1tFW4WJ25olEWvf1zDiSctRXQh2Kr
ewMpuosXprP2XBZtrjRfQTDxlypafeRxx8wCVZtXkYB/y630F8gkBxAq6DznC4Ya
+7aFwZIZl0XQAn8Y0FTX
=xaGJ
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--


