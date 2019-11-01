Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67237CA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 15:46:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 351C021734
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 15:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z3GhV9ve"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 351C021734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQZ7k-0004zo-6F
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 11:46:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53259)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iQZ4j-0003qg-Pk
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 11:42:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iQZ4h-0003ut-Mm
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 11:42:57 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42319
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iQZ4h-0003mV-GO
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 11:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572622972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xOjAHH/CXpv+pe9Z+LiEWwumE2gz00LCoO2U+yc4aME=;
 b=Z3GhV9vezxiz0GwosqhRfrZbGItoLiUhEIY5Bj0xuMY30+23pt6SJj+zRqzU8tvDszuxAj
 pLUbowZAnAmqRqahnmp4L3P4R3DUHe2N0/6l21MFrETtP/Y6jFZe8Ho+890dtZRDWQNOGo
 gJvALfEfxj0ywMcpV121pHBbBg9P3WQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-_JoUMd8rPGe3FtmAKwT1BQ-1; Fri, 01 Nov 2019 11:42:48 -0400
X-MC-Unique: _JoUMd8rPGe3FtmAKwT1BQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9CEF3800A1E;
 Fri,  1 Nov 2019 15:42:47 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-102.ams2.redhat.com
 [10.36.116.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1D6BE5D6B7;
 Fri,  1 Nov 2019 15:42:42 +0000 (UTC)
Date: Fri, 1 Nov 2019 16:42:41 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH for-4.2 1/4] Revert "qcow2: skip writing zero buffers to
 empty COW areas"
Message-ID: <20191101154241.GA23153@localhost.localdomain>
References: <20191101100019.9512-1-mreitz@redhat.com>
 <20191101100019.9512-2-mreitz@redhat.com>
 <c4e21028-0321-20ea-21b8-31dec87fac97@redhat.com>
 <e8f8ae20-b036-4330-4851-f099fc534f9b@redhat.com>
MIME-Version: 1.0
In-Reply-To: <e8f8ae20-b036-4330-4851-f099fc534f9b@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 01.11.2019 um 15:01 hat Max Reitz geschrieben:
> On 01.11.19 13:40, Eric Blake wrote:
> > On 11/1/19 11:00 AM, Max Reitz wrote:
> >> This reverts commit c8bb23cbdbe32f5c326365e0a82e1b0e68cdcd8a.
> >>
> >> This commit causes fundamental performance problems on XFS (because
> >> fallocate() stalls the AIO pipeline), and as such it is not clear that
> >> we should unconditionally enable this behavior.
> >>
> >> We expect subclusters to alleviate the performance penalty of small
> >> writes to newly allocated clusters, so when we get them, the originall=
y
> >> intended performance gain may actually no longer be significant.
> >>
> >> If we want to reintroduce something similar to c8bb23cbdbe, it will
> >> require extensive benchmarking on various systems with subclusters
> >> enabled.
> >>
> >> Cc: qemu-stable@nongnu.org
> >> Signed-off-by: Max Reitz <mreitz@redhat.com>
> >> ---
> >=20
> >> +++ b/qapi/block-core.json
> >> @@ -3304,8 +3304,6 @@
> >> =C2=A0 #
> >> =C2=A0 # @cor_write: a write due to copy-on-read (since 2.11)
> >> =C2=A0 #
> >> -# @cluster_alloc_space: an allocation of file space for a cluster
> >> (since 4.1)
> >> -#
> >> =C2=A0 # @none: triggers once at creation of the blkdebug node (since =
4.1)
> >=20
> > Deleting released qapi is not backwards-compatible.
>=20
> Right. :-/
>=20
> I=E2=80=99ll just not make changes to the QAPI schema.  It doesn=E2=80=99=
t hurt to leave
> this in.

Why would it be incompatible to drop an enum value that is only ever
used in output and that QEMU doesn't generate?

Kevin

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdvFJxAAoJEH8JsnLIjy/WJXAQAKq2igSusXV5zVvt1kqcDV0t
imBcsf6C4l0wCwD7PJ5Org5rGPAxCrthahSQzJvqImraKEhmJEL8bExGfz+Ddzam
ximAFz5gozr26d6clFya4G156eXCY3CRVCbojdXEaPmF7qK0FAilR9n0ol6iB34L
Zjb+oY56m19dp9ZRfEx8vXiqMWGW7TiPHz7JN4y2trHSPyKYCHPD0yGkFSI+W5qi
Fg6U2EGCYCFAo47NdKxK564QuPfOVVXlsV8kKOX78b6/DpS8rXIq+rB1002rkt/v
GOdDIPyx0sMPoDK3QOpm3AF8oiyLDZonn6ZJADeleVkiH/p901V5HPiVWZJEfvDO
Yr4gOeCEEfxncHQzEZbd+YjG9+Om4te/LdT5sTDFEzG39Gk1SGWQKLD8dV6hyTq/
KkdIwiWUu9eH+G3ubGLSYHNhNc9QwW68Psk+13Th9FQeMhHKQ4lntR+W5PBFKdWI
Ii2Zc1f6bWQM+u3n565uByTb98X8xdFd8U/1T0ykmBFrkcERmHalLjp5/VuRpyr8
G7okmekrCDvkGLmDGOMNzzXH+83Zfv5aSx8rkfPtx01OZ8SIXm3aKVOD08jHiuIJ
j/13Bdgm+55lw61k78ukyWf1huZokIxi7qvVKqGOcnoWEiHhZUgp1vnMP3gKBPOK
mTFR9q2xMCyum8wZSKxl
=E6x3
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--


