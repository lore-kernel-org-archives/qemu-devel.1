Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173DFC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 11:24:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5890206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 11:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JhIlaT0E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5890206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juwZg-00049Q-0U
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 07:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1juwYW-0003ZJ-6S
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 07:23:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23668
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1juwYU-0008So-EU
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 07:23:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594639409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nGd9hQiIPUr7zMpoBuCpFStEFNCIFHXyShdoi3LqQVw=;
 b=JhIlaT0EBNZ8ruZva3HIzexj2vi2pbbE8GFb8+mOBnoeOJX7fj1lCYdvM44Vf+cCmbV/wS
 xkUcJ9g8xpgDc3jByjioj/XTk49VdsqkiHtWIr0h533CG5bZauXc/ZtIANWHxl7yRzxqZy
 Z/AhIq8SkV42R+AqN/U3yKyfuhNs/A8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-bcJz3Rk4NJyQxU4jkdMDmw-1; Mon, 13 Jul 2020 07:23:25 -0400
X-MC-Unique: bcJz3Rk4NJyQxU4jkdMDmw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6821280BCAE;
 Mon, 13 Jul 2020 11:23:24 +0000 (UTC)
Received: from localhost (ovpn-114-66.ams2.redhat.com [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A2DCB19D7D;
 Mon, 13 Jul 2020 11:23:23 +0000 (UTC)
Date: Mon, 13 Jul 2020 12:23:22 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 1/5] block/io: introduce bdrv_try_mark_request_serialising
Message-ID: <20200713112322.GH28639@stefanha-x1.localdomain>
References: <20200620143649.225852-1-vsementsov@virtuozzo.com>
 <20200620143649.225852-2-vsementsov@virtuozzo.com>
 <20200707155640.GA459887@stefanha-x1.localdomain>
 <6faa2ec5-9857-daf0-bf84-e42eb07897ff@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <6faa2ec5-9857-daf0-bf84-e42eb07897ff@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="N8ia4yKhAKKETby7"
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--N8ia4yKhAKKETby7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2020 at 06:51:18PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> 07.07.2020 18:56, Stefan Hajnoczi wrote:
> > On Sat, Jun 20, 2020 at 05:36:45PM +0300, Vladimir Sementsov-Ogievskiy =
wrote:
> > > Introduce a function to mark the request serialising only if there ar=
e
> > > no conflicting request to wait for.
> > >=20
> > > The function is static, so mark it unused. The attribute is to be
> > > dropped in the next commit.
> > >=20
> > > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
> > > ---
> > >   block/io.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++----=
---
> > >   1 file changed, 51 insertions(+), 7 deletions(-)
> >=20
> > I found this patch difficult to understand because there are multiple
> > levels of functions passing flags to ultimiately do different things in
> > a common function.
> >=20
> > Here are some ideas if you have time to rework this patch:
> >=20
> > 1. Introduce a bdrv_find_overlapping_request() function that does most
> >     of bdrv_wait_serialising_requests_locked() but does not wait. Then
> >     bdrv_wait_serialising_requests_locked() can call that function in a
> >     loop and wait if an overlapping request is found.
>=20
> I thought about it, but splitting bdrv_find_overlapping_request is not so=
 clear:
> it should include most of the logic inside "if (tracked_request_overlaps(=
..":
> an assertion, and checking !req->waiting_for. So the semantics of new fun=
ctions
> becomes unclear, and it lead to splitting "->waiting_for" logic.. So, I d=
ecided
> to keep the whole function as is, not splitted. I just can't imagine reas=
onable
> split.
>=20
> >=20
> > 2. Pass overlap_offset/overlap_bytes arguments to
> >     bdrv_find_overlapping_request() instead of changing and restoring t=
he
> >     value in bdrv_do_mark_request_serialising().
>=20
> I'm not sure that it would be safe to not add a request to the list durin=
g the
> search.
>=20
> >=20
> > 3. Use consistent names for flags: wait/blocking, found/success
> >=20
> > I'm not sure if all these ideas will work, but I get the feeling this
> > code can be refactored to make it easier to understand. Since I don't
> > have a concrete suggestion and the code looks correct:
>=20
> Hmm. Unfortunately I didn't record the problems I faced on the way to res=
ulting
> design, so I just don't remember now the details. So, I'll try to apply y=
our
> suggestions, and remember the problems (or we'll get better patch :)

Thanks!

Stefan

--N8ia4yKhAKKETby7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8MRCoACgkQnKSrs4Gr
c8girwgApH1LqhN2/3xQklur/UojwUhCGK2YwlD7bwAGX/xA3pY6wV4YBCfm0/JT
/YJjhiTRvuy1TcMQ+sn2mNtT+ldw88d+JbSxCjK27usGbMCoBstMjIto9AbYs9Ac
lEDgxpd0UOoS7KEvAF173T89echvtqZGVRN9J7awp+wjPeoMfh2yVt5aG7bbOl87
rrFvBbj3KygL+hd30nX0qyP9QkSIRKcc2aqrnSLrmgtUEjFhg05UqtB+ABHKDWh/
IDSblOwb9qlXtyrkuij5MeJHI2LCE/7T3pSTojQsIPtIInQY0sj7Q1H2u9EptkYg
4LklIrr0gVPCw618ngWynuFS/s3jRw==
=X6rZ
-----END PGP SIGNATURE-----

--N8ia4yKhAKKETby7--


