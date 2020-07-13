Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3B7C433EA
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 11:26:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A7FA206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 11:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DhXkKkmR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A7FA206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juwbH-0005iV-Jo
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 07:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1juwZ2-0003pL-C6
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 07:24:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54598
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1juwZ0-0008VT-Qy
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 07:24:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594639440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GRijH3ZVr0zcFjitE4tc1YP86LchTyP9kDnjkJrK2tg=;
 b=DhXkKkmRnRRojCtKWothm4vWSjD9KDmpP0cFXtp3vBfSKkTx+nuq7hKqodPQRCSibnA6iz
 QqUwmisQsmquokMp0FhqPtl5vODgtn4NsHOU0ON4yrqsA6SClaE18NKBYI6cGfNz/FSRcM
 QG2Vt7f8MY7dvTprCsdyoPeI4C2Dr3A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-jaVblZFCND2LXmzDg3payA-1; Mon, 13 Jul 2020 07:23:58 -0400
X-MC-Unique: jaVblZFCND2LXmzDg3payA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5DF6480040A;
 Mon, 13 Jul 2020 11:23:57 +0000 (UTC)
Received: from localhost (ovpn-114-66.ams2.redhat.com [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E787C5C6C0;
 Mon, 13 Jul 2020 11:23:56 +0000 (UTC)
Date: Mon, 13 Jul 2020 12:23:55 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 2/5] block/io: introduce bdrv_co_range_try_lock
Message-ID: <20200713112355.GI28639@stefanha-x1.localdomain>
References: <20200620143649.225852-1-vsementsov@virtuozzo.com>
 <20200620143649.225852-3-vsementsov@virtuozzo.com>
 <20200707161024.GB459887@stefanha-x1.localdomain>
 <6216a191-6039-0bd2-6f1c-459932157f96@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <6216a191-6039-0bd2-6f1c-459932157f96@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="X0cz4bGbQuRbxrVl"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 03:20:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-block@nongnu.org,
 Anton.Nefedov@acronis.com, armbru@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--X0cz4bGbQuRbxrVl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2020 at 06:56:53PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> 07.07.2020 19:10, Stefan Hajnoczi wrote:
> > On Sat, Jun 20, 2020 at 05:36:46PM +0300, Vladimir Sementsov-Ogievskiy =
wrote:
> > > +int coroutine_fn bdrv_co_pwrite_zeroes_locked(BdrvChild *child, int6=
4_t offset,
> > > +                                              int bytes, BdrvRequest=
Flags flags,
> > > +                                              BdrvTrackedRequest *lo=
ck)
> >=20
> > The name is confusing because _locked() normally means that a mutex
> > should be held. Functions using that naming convention already exist in
> > block/io.c. It would be nice to distinguish between functions that need
> > BdrvTrackedRequest and functions that must be called with a mutex held.
> >=20
> > How about bdrv_co_pwrite_zeroes_with_lock()?
> >=20
>=20
> OK.
>=20
> May be _in_locked_range ? A bit longer, but more understandable.

Sounds good.

Stefan

--X0cz4bGbQuRbxrVl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8MREsACgkQnKSrs4Gr
c8jYJgf+IdKPy1e0Of1r5dJ6IUptNyndvOBSkWzxUkutQP1tffZevR/GKaA1D53t
MrglRF0z3QA9yJH1rWH+OnOImUSkSb2NXHf6MdYMa7xFXgf3sw4yjuDzqPKAzsYN
xKk412GJdY4U/1+fkcqlo1gJs8+7rsQz47IivMehiErKL56B/XR5mhQlWhD6Wd5u
FgLuQa3NIwziXZOvNJGOpo9I2UF6JvcA5TBLcEH4n5BVZyrM7pifD/7pwgkJmpb2
7pongahyzVtoQqa7iqIr9WEy+yVr4Uitg52y7quMe1+Auxc0T3bmArtOW2C4nDtt
+NQkZZBUbK99heRFbonPnDjBitbZnA==
=QksW
-----END PGP SIGNATURE-----

--X0cz4bGbQuRbxrVl--


