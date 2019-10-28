Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD883CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 11:05:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5F1F208C0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 11:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VVg3xnqv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5F1F208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP2pt-00046L-Sl
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 07:05:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43303)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iP2p5-0003AY-CJ
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 07:04:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iP2p3-0006n9-EY
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 07:04:30 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25615
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iP2p3-0006mg-Ay
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 07:04:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572260668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=56Igtf7Ahg/b8huWVlfQIdxWzwcqcIa4JDjoRG8FQLc=;
 b=VVg3xnqv7Uc+t06WmeCT/EEmmUkw+F0Z5J0VpfsKMuBtIjEbjMoghuhUlwBZvrfhFoaXs/
 l1qGzQQAcVmG5o3IeFiJhXQny4qsBiMeI/B9jWpFgm5v3IZ4YYtDT3cuVFZ2EUuFXR++7p
 gqkdw87sKJ46F460IeA91TVCPLA9rqE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-oQEu4ffzMmal5oYMs_z-lw-1; Mon, 28 Oct 2019 07:04:22 -0400
X-MC-Unique: oQEu4ffzMmal5oYMs_z-lw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F04E47B;
 Mon, 28 Oct 2019 11:04:21 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-42.ams2.redhat.com
 [10.36.116.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1302860C4E;
 Mon, 28 Oct 2019 11:04:12 +0000 (UTC)
Date: Mon, 28 Oct 2019 12:04:08 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [RFC 0/3] block/file-posix: Work around XFS bug
Message-ID: <20191028110408.GB3579@localhost.localdomain>
References: <20191025095849.25283-1-mreitz@redhat.com>
 <20191027123555.GN4472@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20191027123555.GN4472@stefanha-x1.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 27.10.2019 um 13:35 hat Stefan Hajnoczi geschrieben:
> On Fri, Oct 25, 2019 at 11:58:46AM +0200, Max Reitz wrote:
> > As for how we can address the issue, I see three ways:
> > (1) The one presented in this series: On XFS with aio=3Dnative, we exte=
nd
> >     tracked requests for post-EOF fallocate() calls (i.e., write-zero
> >     operations) to reach until infinity (INT64_MAX in practice), mark
> >     them serializing and wait for other conflicting requests.
> >=20
> >     Advantages:
> >     + Limits the impact to very specific cases
> >       (And that means it wouldn=E2=80=99t hurt too much to keep this wo=
rkaround
> >       even when the XFS driver has been fixed)
> >     + Works around the bug where it happens, namely in file-posix
> >=20
> >     Disadvantages:
> >     - A bit complex
> >     - A bit of a layering violation (should file-posix have access to
> >       tracked requests?)
>=20
> Your patch series is reasonable.  I don't think it's too bad.
>=20
> The main question is how to detect the XFS fix once it ships.  XFS
> already has a ton of ioctls, so maybe they don't mind adding a
> feature/quirk bit map ioctl for publishing information about bug fixes
> to userspace.  I didn't see another obvious way of doing it, maybe a
> mount option that the kernel automatically sets and that gets reported
> to userspace?

I think the CC list is too short for this question. We should involve
the XFS people here.

> If we imagine that XFS will not provide a mechanism to detect the
> presence of the fix, then could we ask QEMU package maintainers to
> ./configure --disable-xfs-fallocate-beyond-eof-workaround at some point
> in the future when their distro has been shipping a fixed kernel for a
> while?  It's ugly because it doesn't work if the user installs an older
> custom-built kernel on the host.  But at least it will cover 98% of
> users...
>=20
> > (3) Drop handle_alloc_space(), i.e. revert c8bb23cbdbe32f.
> >     To my knowledge I=E2=80=99m the only one who has provided any bench=
marks for
> >     this commit, and even then I was a bit skeptical because it perform=
s
> >     well in some cases and bad in others.  I concluded that it=E2=80=99=
s
> >     probably worth it because the =E2=80=9Csome cases=E2=80=9D are more=
 likely to occur.
> >=20
> >     Now we have this problem of corruption here (granted due to a bug i=
n
> >     the XFS driver), and another report of massively degraded
> >     performance on ppc64
> >     (https://bugzilla.redhat.com/show_bug.cgi?id=3D1745823 =E2=80=93 so=
rry, a
> >     private BZ; I hate that :-/  The report is about 40 % worse
> >     performance for an in-guest fio write benchmark.)
> >=20
> >     So I have to ask the question about what the justification for
> >     keeping c8bb23cbdbe32f is.  How much does performance increase with
> >     it actually?  (On non-(ppc64+XFS) machines, obviously)
> >=20
> >     Advantages:
> >     + Trivial
> >     + No layering violations
> >     + We wouldn=E2=80=99t need to keep track of whether the kernel bug =
has been
> >       fixed or not
> >     + Fixes the ppc64+XFS performance problem
> >=20
> >     Disadvantages:
> >     - Reverts cluster allocation performance to pre-c8bb23cbdbe32f
> >       levels, whatever that means
>=20
> My favorite because it is clean and simple, but Vladimir has a valid
> use-case for requiring this performance optimization so reverting isn't
> an option.

Vladimir also said that qcow2 subclusters would probably also solve his
problem, so maybe reverting and applying the subcluster patches instead
is a possible solution, too?

We already have some cases where the existing handle_alloc_space()
causes performance to actually become worse, and serialising requests as
a workaround isn't going to make performance any better. So even on
these grounds, keeping commit c8bb23cbdbe32f is questionable.

Kevin

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdtssoAAoJEH8JsnLIjy/WrYYP/1IpGjjFZuApNuNIrrYlYskd
xc0H+02O8tbp1oqSwjDRLArh4VydQ5Xcui+KJVxlrPJJLrCQArxA8rX9GEYzLwLF
Qm4iDMqQXkv9Zqko07A/h6t4+/o/ok/PASbrahAmZEhrQun0efZUalWFgboiVjPd
DszPLiYA8+SnHlZAg9tQwq0jabQZiS/Lhmgo1/6sMtA6Z2BQ5mhjI7f3T9q7Fsl+
1k6cvHo+XwEtfzl7dtWtPEZRh+yXWIJIQku5n+w1TXsJ2k3hDyCEvATQqWIYKcg+
1bwk8y1yUODwpct+71OoQg6N+XhnhTO2sf+DrfHF6zDR7Poo9q7IUH6Oh/ZraX+7
rOIvD9bL/GhgqSJ8QQxzhgEVNSh4lYgfi+r5kj3AsAZipLA+t2YUCczNtxIIjVuL
Ad6Jex3BKUa9YV3D1eY/8FV5coElEb68yEOw89GCtnKkhUVsmO/uc4KZaJ25g7Pn
y4duxWgc7iqKiCs+DYNkkmVb7Rkb3TsqfH4LZsVRvG6S2Z/zNy+Wwa6Qq1r7fXAk
zoPU4E40m/zmsD2M21+PoemxtjTgy0+wM5RnA9XYpGdNGeg1O5DdOZ+V39TX02Uy
vlNdW9QWPgF4oYpZj8tr6RMrvCITzhqtPWQoByMSnggFDbrctcuHL8PKMJhJvKQD
a3rzbqmxSRsYV0mVKD0s
=vGz2
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--


