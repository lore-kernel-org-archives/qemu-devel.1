Return-Path: <SRS0=q9Vo=YU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56AC9CA9EAF
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2019 14:47:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F6A021726
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2019 14:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HilEFTLe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F6A021726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOjpX-0003yh-Fu
	for qemu-devel@archiver.kernel.org; Sun, 27 Oct 2019 10:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34685)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iOjmM-0001lM-B8
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 10:44:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iOjmJ-0002fb-TA
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 10:44:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49270
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iOjmJ-0002fH-Pm
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 10:44:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572187463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3cFw1pFH/wLzDlvh7cgeBLwr5+gzD2EJndIEyxkyCQ8=;
 b=HilEFTLexqiSiuReSEDBhO9YoLRanr0eZfMexC/EWFZz1KsPHQS/et3K+zdypOKj4Qt+Pp
 qrRSt3BCcqeVk6iSrmdZl4YjQy+5Uo5eC2v8TOPsCeEo9Duyfx1LuUCgRv2ZdhD1dSEgO8
 lc0RS776oopO2RuNUdb/UXyETTSiRM8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-DB6qRtLAP1K2BT5EI7-YzQ-1; Sun, 27 Oct 2019 10:44:18 -0400
X-MC-Unique: DB6qRtLAP1K2BT5EI7-YzQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5883D800D49;
 Sun, 27 Oct 2019 14:44:17 +0000 (UTC)
Received: from localhost (ovpn-116-99.ams2.redhat.com [10.36.116.99])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DD4DB60167;
 Sun, 27 Oct 2019 14:44:16 +0000 (UTC)
Date: Sun, 27 Oct 2019 13:35:55 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [RFC 0/3] block/file-posix: Work around XFS bug
Message-ID: <20191027123555.GN4472@stefanha-x1.localdomain>
References: <20191025095849.25283-1-mreitz@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191025095849.25283-1-mreitz@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="fz0LNKsoEivY4NpG"
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--fz0LNKsoEivY4NpG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2019 at 11:58:46AM +0200, Max Reitz wrote:
> As for how we can address the issue, I see three ways:
> (1) The one presented in this series: On XFS with aio=3Dnative, we extend
>     tracked requests for post-EOF fallocate() calls (i.e., write-zero
>     operations) to reach until infinity (INT64_MAX in practice), mark
>     them serializing and wait for other conflicting requests.
>=20
>     Advantages:
>     + Limits the impact to very specific cases
>       (And that means it wouldn=E2=80=99t hurt too much to keep this work=
around
>       even when the XFS driver has been fixed)
>     + Works around the bug where it happens, namely in file-posix
>=20
>     Disadvantages:
>     - A bit complex
>     - A bit of a layering violation (should file-posix have access to
>       tracked requests?)

Your patch series is reasonable.  I don't think it's too bad.

The main question is how to detect the XFS fix once it ships.  XFS
already has a ton of ioctls, so maybe they don't mind adding a
feature/quirk bit map ioctl for publishing information about bug fixes
to userspace.  I didn't see another obvious way of doing it, maybe a
mount option that the kernel automatically sets and that gets reported
to userspace?

If we imagine that XFS will not provide a mechanism to detect the
presence of the fix, then could we ask QEMU package maintainers to
./configure --disable-xfs-fallocate-beyond-eof-workaround at some point
in the future when their distro has been shipping a fixed kernel for a
while?  It's ugly because it doesn't work if the user installs an older
custom-built kernel on the host.  But at least it will cover 98% of
users...

> (3) Drop handle_alloc_space(), i.e. revert c8bb23cbdbe32f.
>     To my knowledge I=E2=80=99m the only one who has provided any benchma=
rks for
>     this commit, and even then I was a bit skeptical because it performs
>     well in some cases and bad in others.  I concluded that it=E2=80=99s
>     probably worth it because the =E2=80=9Csome cases=E2=80=9D are more l=
ikely to occur.
>=20
>     Now we have this problem of corruption here (granted due to a bug in
>     the XFS driver), and another report of massively degraded
>     performance on ppc64
>     (https://bugzilla.redhat.com/show_bug.cgi?id=3D1745823 =E2=80=93 sorr=
y, a
>     private BZ; I hate that :-/  The report is about 40 % worse
>     performance for an in-guest fio write benchmark.)
>=20
>     So I have to ask the question about what the justification for
>     keeping c8bb23cbdbe32f is.  How much does performance increase with
>     it actually?  (On non-(ppc64+XFS) machines, obviously)
>=20
>     Advantages:
>     + Trivial
>     + No layering violations
>     + We wouldn=E2=80=99t need to keep track of whether the kernel bug ha=
s been
>       fixed or not
>     + Fixes the ppc64+XFS performance problem
>=20
>     Disadvantages:
>     - Reverts cluster allocation performance to pre-c8bb23cbdbe32f
>       levels, whatever that means

My favorite because it is clean and simple, but Vladimir has a valid
use-case for requiring this performance optimization so reverting isn't
an option.

Stefan

--fz0LNKsoEivY4NpG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl21jysACgkQnKSrs4Gr
c8irOggAqXDdDrzM2dETK3t23iy53OEMgv3oAtuMcajpfNZx4ZFNT/+E+4PZY7B7
HiMvY5kgT331w/Ah0hUxtrjCKAAArIf/3oHPrekKKdgil4/aeURPtMHqCQL6hYyZ
32WWALgO/cyhdHzlNhxy3yuyJ3y1nsvwFp3+LerBmgCzzIwbc5xDpBrwXqbzyW6i
FTibisyQu1Q39JoZYHj50igJdNDIvxKj6YHQKr6Hw5CIuJ76aJGZ1frEr/xkGBu5
P1POZBhzk9TkZybsTBDlgkotYv1WrcKj+CKmGRDPh+r5Q3Y9J8S+Jd9dcIcizIzw
oj8323UW4Wm+BEZlwfxycYJOw5E5bg==
=FAM7
-----END PGP SIGNATURE-----

--fz0LNKsoEivY4NpG--


