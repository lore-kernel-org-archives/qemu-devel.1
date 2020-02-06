Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD413C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 14:59:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78885227BF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 14:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T7uRE9Hd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78885227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izici-0005H8-Kk
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 09:59:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45477)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1izibz-0004pa-1e
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 09:58:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1izibx-00022x-Cw
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 09:58:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27877
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1izibx-0001vT-7Q
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 09:58:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581001112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s7Ap+IGXGeEvqg4rBInAZBSIq72ZMzZ9pXzuTetYPhQ=;
 b=T7uRE9HdU/Oc9/Ho1F08IzrVAZtRY8XUOnIxogvs1up0i6Nc8Qr7w+lNRgGFpQ5/fKLWk5
 +yJr0FYtmdlOjgVXmjsGrp6+C0mpO5GghVYtMBVb3X7rOOKmvGh9u3zpS3rCoY18nzaIKL
 wiuoDEE4niC0puYMocBtyaQ3Blp2R7I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-hbPVIKxhMXiwAM-H4KyKWQ-1; Thu, 06 Feb 2020 09:58:29 -0500
X-MC-Unique: hbPVIKxhMXiwAM-H4KyKWQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1436B8024DB;
 Thu,  6 Feb 2020 14:58:28 +0000 (UTC)
Received: from linux.fritz.box (ovpn-116-204.ams2.redhat.com [10.36.116.204])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DE14D859D2;
 Thu,  6 Feb 2020 14:58:26 +0000 (UTC)
Date: Thu, 6 Feb 2020 15:58:25 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v3 09/21] quorum: Add QuorumChild.to_be_replaced
Message-ID: <20200206145825.GD4926@linux.fritz.box>
References: <20200130214431.333510-1-mreitz@redhat.com>
 <20200130214431.333510-10-mreitz@redhat.com>
 <20200205153859.GE5768@dhcp-200-226.str.redhat.com>
 <92b951da-5e12-e08f-f8f7-a862790b51ac@redhat.com>
MIME-Version: 1.0
In-Reply-To: <92b951da-5e12-e08f-f8f7-a862790b51ac@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="6sX45UoQRIJXqkqR"
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 06.02.2020 um 11:11 hat Max Reitz geschrieben:
> On 05.02.20 16:38, Kevin Wolf wrote:
> > Am 30.01.2020 um 22:44 hat Max Reitz geschrieben:
> >> We will need this to verify that Quorum can let one of its children be
> >> replaced without breaking anything else.
> >>
> >> Signed-off-by: Max Reitz <mreitz@redhat.com>
> >> ---
> >>  block/quorum.c | 25 +++++++++++++++++++++++++
> >>  1 file changed, 25 insertions(+)
> >>
> >> diff --git a/block/quorum.c b/block/quorum.c
> >> index 59cd524502..6a7224c9e4 100644
> >> --- a/block/quorum.c
> >> +++ b/block/quorum.c
> >> @@ -67,6 +67,13 @@ typedef struct QuorumVotes {
> >> =20
> >>  typedef struct QuorumChild {
> >>      BdrvChild *child;
> >> +
> >> +    /*
> >> +     * If set, check whether this node can be replaced without any
> >> +     * other parent noticing: Unshare CONSISTENT_READ, and take the
> >> +     * WRITE permission.
> >> +     */
> >> +    bool to_be_replaced;
> >=20
> > I don't understand these permission changes. How does (preparing for)
> > detaching a node from quorum make its content invalid?
>=20
> It doesn=E2=80=99t, of course.  What we are preparing for is to replace i=
t by
> some other node with some other content.
>=20
> > And why do we
> > suddenly need WRITE permissions even if the quorum node is only used
> > read-only?
> >=20
> > The comment is a bit unclear, too. "check whether" implies that both
> > outcomes could be true, but it doesn't say what happens in either case.
> > Is this really "make sure that"?
>=20
> I think the comment is not only unclear, it is the problem.  (Well,
> maybe the code is also.)
>=20
> This series is about fixing at least some things about replacing nodes
> by mirroring.  The original use cases this was introduced for was to fix
> broken quorum children: The other children are still intact, so you read
> from the quorum node and replace the broken child (which maybe shows
> invalid data, or maybe just EIO) by the fixed mirror result.
>=20
> Replacing that broken node by the fixed one changes the data that=E2=80=
=99s
> visible on that node.

Hm, yes, that's true. But I wonder if this is really something that the
permission system must catch. Like other graph manipulations, it's
essentially the user saying "trust me, I know what I'm doing, this node
makes sense in this place".

Because if you assume that the user could add a node with unsuitable
content and you want to prevent this, where do we stop?
blockdev-snapshot can insert a non-empty overlay, which would result in
visible data change. Should we therefore only allow snapshots when
shared writes are allowed? This doesn't work obviously.

So I'm inclined to say that this is the user's responsibility and we
don't have to jump through hoops to prevent every possible way that the
user could mess up. (Which often also result in preventing legitimate
cases like here a quorum of read-only nodes.)

Kevin

--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJePCmRAAoJEH8JsnLIjy/WE7cP/1GaKc8jjJRWR8OMG19aedQZ
ulaBi8wTDwK0imIkyq5rwCCwqH+yqrLJQcQueYZGvtig0qN4ILl+XWzFmub45WIx
UEQslp2mbTgs9iq/LOuCTU1wyEhxjqcQ27JQju7egMLSlKbKJPA3oNmcKLeBAk1d
DehaDEtad4VhLlYeMOU4Xc9BaExhBAhdEw9Uq3UkAJMveWzska28MrLizVkoF90T
d7KOuaK02652h6XCC5yTbfp38MXZuSXMVd+jtL0kUcyLhSl2eOede+0abUDiQv4G
PTJX09bSoVbiesbkfQMLKlFYTy4+yfQ2eXXWQdElvXJYIqfbIHaAdyd2+zlNJeNX
4hal/3wt6xJUOOEaw5mL+1vwj5tHFVON17/9uJvfDdZq8xYsn1QgHJliWdJ61ssf
Y7LyWWAAgC9LzfVXodenNDVZu3zrmZEJZfuvQrw3VcHu2ErTuWeAC4la3CsIedAI
O8lS+3nl9GTrnrThyY4Vl15yHqtSAU8/IvHqPSmjxSIA8Czc4MEIYRP4GEFZgDCo
uCccW82LstB+wiln1SmRrapTp5A1MD9yFAzy8GOtTGJzQ3KJRvwLEmsxiMQayBXU
4kBSMl4oIzKJB1LWsE+OqkSsE9jv+KXgGeY33K4HAfCsKA/9KsXZT5Pe78vPwic8
X8x1kkNWRCuPc7hwRPMt
=a8IQ
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--


