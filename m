Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493C7C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 09:02:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E9C02176D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 09:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RuczSqD2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E9C02176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6W6d-0002Ha-20
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 04:02:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50296)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j6W5p-0001eX-KO
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 04:01:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j6W5k-00052e-Qe
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 04:01:29 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26566
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j6W5k-00052N-M2
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 04:01:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582621284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i3pcL7p0NM3yAz+ntnw0fN8yWNMHry4pH48A3W9eTtw=;
 b=RuczSqD2A3jsJ9S8KriFHYnUML1hsCBW8nrm0BDdGt+1YwY0aBZNXBCeJtKJ8WFFgabPbW
 uEQk/P7V5WIwEhyteIwKgNoWcPlnNawTX57rO0cIOe9nElVf6N4h/04Z2KW63lKPXSHaTR
 dmFL41MNOkE4MGBxyxryeYky/rNa7Uw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-IMfxVSo8NuuK0hZ80QY9Nw-1; Tue, 25 Feb 2020 04:01:20 -0500
X-MC-Unique: IMfxVSo8NuuK0hZ80QY9Nw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 134CD10CE78B;
 Tue, 25 Feb 2020 09:01:19 +0000 (UTC)
Received: from localhost (ovpn-117-159.ams2.redhat.com [10.36.117.159])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8CF4F620D8;
 Tue, 25 Feb 2020 09:01:18 +0000 (UTC)
Date: Tue, 25 Feb 2020 09:01:17 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 1/2] qemu/queue.h: clear linked list pointers on remove
Message-ID: <20200225090117.GA4178@stefanha-x1.localdomain>
References: <20200224103406.1894923-1-stefanha@redhat.com>
 <20200224103406.1894923-2-stefanha@redhat.com>
 <0a6d15b1-7936-82a2-0d65-a1b77c4c5cc1@redhat.com>
MIME-Version: 1.0
In-Reply-To: <0a6d15b1-7936-82a2-0d65-a1b77c4c5cc1@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2020 at 12:51:54PM +0100, Philippe Mathieu-Daud=E9 wrote:
> On 2/24/20 11:34 AM, Stefan Hajnoczi wrote:
> > @@ -304,8 +310,10 @@ struct {                                          =
                      \
> >   } while (/*CONSTCOND*/0)
> >   #define QSIMPLEQ_REMOVE_HEAD(head, field) do {                       =
   \
> > -    if (((head)->sqh_first =3D (head)->sqh_first->field.sqe_next) =3D=
=3D NULL)\
> > +    typeof((head)->sqh_first) elm =3D (head)->sqh_first;              =
    \
> > +    if (((head)->sqh_first =3D elm->field.sqe_next) =3D=3D NULL)      =
        \
> >           (head)->sqh_last =3D &(head)->sqh_first;                     =
     \
>=20
> Here you check elm for NULL ...
>=20
> > +    elm->field.sqe_next =3D NULL;                                     =
    \
>=20
> ... then you assign it.

The sqe_next field is copied into the head.  If this was the last
element in the list then the head's sqh_last needs to be fixed up.

Finally we clear the linked list sqe_next pointer inside the element
itself (which is no longer in the list).

Is there an issue?

Stefan

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5U4loACgkQnKSrs4Gr
c8iHqAf+MSTlKZWjuROo6UCTnQXnmx8IJ2xKgZA8hgYMV16+EVLPIRLiGQxvLUUv
DySzbaNEwGBpKt9N3ReE2wVGnukhX64I+PK7/ARdCzOSAcw5F3PD5yZqIYamapGz
/YccWXd9fj+KoAzxTrH6+H1JQDiDcCD4/+ju+6fbtRkR/Kti+e+vtEcetUcn7bAP
hd+TtX7FkH3zLdHfzOjir14uoD6yttvYdtpdpmol28CiGxitvGmwYZxJHIYLt1zq
H/KbU90HQTDSNcHFvcTmRsZTc2BQvmCyGL7rrKXAK91jU5Z0xXN67q/X9o2o5kVR
as5scVM00UnoIcY40ekTh84GX5NuuQ==
=/YBm
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--


