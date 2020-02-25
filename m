Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E817BC35DF9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 09:06:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B36492176D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 09:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NoNAJP4L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B36492176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6WAb-0004lD-Su
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 04:06:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50699)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j6W9y-00049h-Tv
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 04:05:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j6W9v-0006ML-6V
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 04:05:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54032
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j6W9v-0006LX-27
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 04:05:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582621541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wE3YDTP4ZAI7lx5XDaHgsudAf8AoP/jp7Ym3ICM+qJQ=;
 b=NoNAJP4L8YjhduUUZUelt/7v0Cz7hSHe/qLW+pGGgyMp7lBRnGzTbOGtj7I1vnvOn+DYNq
 zqen0Ma8/AGCp45tul+gfpxVgQcTcFB/0XhH/5gnkJ4WHBoUlKp+gN5UnLYx5TGTC4oA4A
 Nn+ByNyeeCoDm8NZbv5FDJ/2ngU77H8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-JfiZY-S_MneW3M6Dul26_g-1; Tue, 25 Feb 2020 04:05:38 -0500
X-MC-Unique: JfiZY-S_MneW3M6Dul26_g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C69A51005512;
 Tue, 25 Feb 2020 09:05:36 +0000 (UTC)
Received: from localhost (ovpn-117-159.ams2.redhat.com [10.36.117.159])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5ACC060BF7;
 Tue, 25 Feb 2020 09:05:36 +0000 (UTC)
Date: Tue, 25 Feb 2020 09:05:34 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 0/2] qemu/queue.h: clear linked list pointers on remove
Message-ID: <20200225090534.GB4178@stefanha-x1.localdomain>
References: <20200224103406.1894923-1-stefanha@redhat.com>
 <158254173238.10132.7761755657862330006@a1bbccc8075a>
 <20200224113903.GD1896567@stefanha-x1.localdomain>
 <d3fa195d-d6cc-438f-517b-676b2642df71@redhat.com>
MIME-Version: 1.0
In-Reply-To: <d3fa195d-d6cc-438f-517b-676b2642df71@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: fam@euphon.net, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2020 at 12:54:37PM +0100, Philippe Mathieu-Daud=E9 wrote:
> On 2/24/20 12:39 PM, Stefan Hajnoczi wrote:
> > On Mon, Feb 24, 2020 at 02:55:33AM -0800, no-reply@patchew.org wrote:
> > > =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> > > 1/2 Checking commit f913b2430ad3 (qemu/queue.h: clear linked list poi=
nters on remove)
> > > ERROR: do not use assignment in if condition
> > > #65: FILE: include/qemu/queue.h:314:
> > > +    if (((head)->sqh_first =3D elm->field.sqe_next) =3D=3D NULL)    =
          \
> > >=20
> > > total: 1 errors, 0 warnings, 59 lines checked
> >=20
> > The same pattern is used elsewhere in this file.  This code comes from
> > BSD and doesn't comply with QEMU's coding style.
>=20
> Checkpatch is right, assigning out of the if statement makes the review
> easier, and we can avoid the 'elm' null deref:

The rest of the file uses if ((a =3D b) =3D=3D NULL), so making it
inconsistent in this one instance isn't very satisfying.

> #define QSIMPLEQ_REMOVE_HEAD(head, field) do { \
> -    if (((head)->sqh_first =3D (head)->sqh_first->field.sqe_next) =3D=3D=
 NULL)\
> +    typeof((head)->sqh_first) elm =3D (head)->sqh_first; \
> +    (head)->sqh_first =3D elm->field.sqe_next; \
> +    if (elm =3D=3D NULL) { \

The previous line would have segfaulted if elm was NULL so this check
doesn't make sense.

This macro assumes there is at least one element in the list.

The point of the check is to fix up the sqh_last pointer in the head
when the final element is removed from the list.

>          (head)->sqh_last =3D &(head)->sqh_first; \
> +    } else { \
> +        elm->field.sqe_next =3D NULL; \
> +    } \
>  } while (/*CONSTCOND*/0)

--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5U414ACgkQnKSrs4Gr
c8jSaQf/TEytwBmRh6/X154vUdBN5BetQxU49lWMuMq0eSJzBRrReuPGYSAu/A3Z
PmrFWTRZr6Iqq49eQb0JVP/egO5RRm1mKfCaJZjz+rQlizTZI9QbO8ldW4CCsTi/
E5sZ4udj8K+bsiC74TEfdgcTtXWSUZgY8u63h/gzVMKHDD8kuBv7muYx3CmQ+iBJ
HEC/O49+jLkdGjUlk7Dz19vqKIGmSfl8bp1PqqF27Ih2FDPZtO1Ghvf542n/Eh32
STa8TYAAOaJqO7YubPwrO746m8zXPNgEK56xxyt8AKR06Xs1oAvQHG/SIn07OFuw
ZPQI08P4CtBZbfA5UdDWz8Unn1MDdA==
=W537
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--


