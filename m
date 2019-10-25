Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11603CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 10:39:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB59F21929
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 10:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gVQqVZZp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB59F21929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNx0X-0007Eh-Ke
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 06:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37268)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iNwx0-0001Gr-Ba
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 06:36:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iNwwz-0007kn-7G
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 06:36:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35441
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iNwwz-0007kH-38
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 06:36:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571999768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JR3J+kghMA6QQulNvmo1v3aBnEhShqF/Yan1bGW5Geo=;
 b=gVQqVZZpSXCu/lEnCkM8OHxh2+JlOvugmCFM18ghiqh1A+eEocf08sBgFcBe8eLISqvqWi
 k6QzS0sg2bl/O9WP5qYbuZ2rmPk5s+SwyKVEcvo8aBknvzuMQnaijyhP9ROXKhWN6z97tY
 lbBqa4ba0gxTbD7k89PFVAImhHdjdDc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-OPGOQBbaOUeYm6jvZ4GH7A-1; Fri, 25 Oct 2019 06:36:04 -0400
X-MC-Unique: OPGOQBbaOUeYm6jvZ4GH7A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3039107AD31;
 Fri, 25 Oct 2019 10:36:02 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-223.ams2.redhat.com
 [10.36.117.223])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ACD345D70E;
 Fri, 25 Oct 2019 10:35:55 +0000 (UTC)
Date: Fri, 25 Oct 2019 12:35:54 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [RFC 2/3] block/file-posix: Detect XFS with CONFIG_FALLOCATE
Message-ID: <20191025103554.GC7275@localhost.localdomain>
References: <20191025095849.25283-1-mreitz@redhat.com>
 <20191025095849.25283-3-mreitz@redhat.com>
 <20191025101920.GB7275@localhost.localdomain>
 <f71d7cab-a1cf-c93c-0697-4b5f77105314@redhat.com>
MIME-Version: 1.0
In-Reply-To: <f71d7cab-a1cf-c93c-0697-4b5f77105314@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 25.10.2019 um 12:22 hat Max Reitz geschrieben:
> On 25.10.19 12:19, Kevin Wolf wrote:
> > Am 25.10.2019 um 11:58 hat Max Reitz geschrieben:
> >> We will need this for the next patch.
> >>
> >> Signed-off-by: Max Reitz <mreitz@redhat.com>
> >> ---
> >>  block/file-posix.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/block/file-posix.c b/block/file-posix.c
> >> index 695fcf740d..5cd54c8bff 100644
> >> --- a/block/file-posix.c
> >> +++ b/block/file-posix.c
> >> @@ -149,7 +149,7 @@ typedef struct BDRVRawState {
> >>      int perm_change_flags;
> >>      BDRVReopenState *reopen_state;
> >> =20
> >> -#ifdef CONFIG_XFS
> >> +#if defined(CONFIG_XFS) || defined(CONFIG_FALLOCATE)
> >>      bool is_xfs:1;
> >>  #endif
> >>      bool has_discard:1;
> >> @@ -667,7 +667,7 @@ static int raw_open_common(BlockDriverState *bs, Q=
Dict *options,
> >>      }
> >>  #endif
> >> =20
> >> -#ifdef CONFIG_XFS
> >> +#if defined(CONFIG_XFS) || defined(CONFIG_FALLOCATE)
> >>      if (platform_test_xfs_fd(s->fd)) {
> >=20
> > platform_test_xfs_fd() is defined in a header file from xfsprogs. I
> > don't think you can call that without CONFIG_XFS, it would break the
> > build.
>=20
> Aw.
>=20
> OK.  Should we then just assume is_xfs to be true (for the next patch)
> with !defined(CONFIG_XFS) && defined(CONFIG_FALLOCATE)?

It's a small inline function that basically just calls statfs() and then
checks f_type.

I think we can have a small function to implement this in the file-posix
code. Don't copy it from the header because of licensing (LGPL, while
file-posix is MIT); refer to the statfs() manpage instead and write it
yourself.

Kevin

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdstAKAAoJEH8JsnLIjy/W/hgP/jHOep63MxjQb0xIDmqAfxWd
QJxCdULCbnPOKo3EhbVnCBH48JEziDotOC/VSLYUchKGbx9i+UAc0EcuA5ZgBEn/
9hH4VYzmhTK1svo0RwutgtexaVTJjeAGpUCDNF4drNHYjVHY7i1tTL7V1ymsfjcd
r/6sLsIcjNXEz07/3u7XGFQNJgyNowfzqJmwEWdfc83kAkJxZ6ASNvr/fPmrZ39E
Jn1oMliXCBkRobfMuV9ID0jL4jMCrTBDl8R+YzYMAsWnRSXgNj4ggsp/KVqnn8fu
e1AqnJhEtCnHVfliqIGEp8M88vbgGyo1GagzoxMUryY1lF9emFxSMDdNlVt1yH9d
dVTDbbYhrwhBNdlguAw4PycV3vytqBIpVu26rZa4FqlWK3lfUagWwYH/hYLXAZia
Hv2tz6pbaFdU5zlzt20LFrh03VEpJlvbmd9HMo+HvHwfm/5p3hKuAeN9c8B7sf7P
zUZImpgbCdgwERDgG+m4lahSdvssx7BFtNpm72CKH1d31FXwKDv7VeWX+6GlRsF4
LbmqMhUbGWQQfbcEFWvY7MuKsOlXglw3Pu35qhv7rtkG5zkS7X22uk4Rk13tzAdJ
YF0M5fmzFR+E9nixPHsFmGmhBc0cKyogJ7Kw+RkcoObzryRXmWsx2MKZTXhamWdg
cwo8PUbJNipa1THRl4Y+
=5N2K
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--


