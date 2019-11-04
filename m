Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DB0CA9ECF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 09:46:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DE5A21D7D
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 09:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QOd0E8NC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DE5A21D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRYwm-0001BU-AL
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 04:46:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45642)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iRYvD-0000G7-63
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 04:45:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iRYvA-0000aw-QW
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 04:45:14 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59610
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iRYvA-0000Zd-MB
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 04:45:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572860711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5QxDoVqZAM7XOLzTgyvCCbhSj/49CK48CcFDYFhv0nE=;
 b=QOd0E8NC0PSbu35rMnKgApvUl1OsxPmm/uKjKNz2xlYfuaNFSA9fesqJEOGCUuuQOTriZg
 wyr5CwJCCmKqkYNzd4vL/BFuIAmiu/J5I9GN7OHrCWC0CfDcGtSxHg/eIUN1S4grZTpRWV
 WNULCG8PjDjMgzeG29xRdFhZM2ZOJow=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-VrNXFPB6PQ2ORw71jhJfmw-1; Mon, 04 Nov 2019 04:45:07 -0500
X-MC-Unique: VrNXFPB6PQ2ORw71jhJfmw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B99D21800D53;
 Mon,  4 Nov 2019 09:45:05 +0000 (UTC)
Received: from localhost (ovpn-116-49.ams2.redhat.com [10.36.116.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 38C3F5D6C5;
 Mon,  4 Nov 2019 09:45:03 +0000 (UTC)
Date: Mon, 4 Nov 2019 10:45:02 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH for-4.2 v2 0/3] qcow2: Fix data corruption on XFS
Message-ID: <20191104094502.GB4682@stefanha-x1.localdomain>
References: <20191101152510.11719-1-mreitz@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191101152510.11719-1-mreitz@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="rJwd6BRFiFCcLxzm"
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 01, 2019 at 04:25:07PM +0100, Max Reitz wrote:
> Hi,
>=20
> As I reasoned here:
> https://lists.nongnu.org/archive/html/qemu-block/2019-11/msg00027.html
> I=E2=80=99m no longer convinced of reverting c8bb23cbdbe.  I could see a
> significant performance improvement from it on ext4 with aio=3Dnative in =
a
> guest that does random 4k writes, and as such I feel it would be a
> regression to revert it for 4.2.
>=20
> To work around the XFS corruption, we still need the other three patches
> from the series, of course.  We cannot restrict the workaround to just
> XFS, because maybe the file is on a remote filesystem and then we don=E2=
=80=99t
> know anything about the host configuration.
>=20
> The performance impact should still be minimal because this just
> serializes post-EOF write-zeroes and data writes, and that just doesn=E2=
=80=99t
> happen very often, even with handle_alloc_space() in qcow2.
>=20
>=20
> I would love to have more time to make a decision, but there simply
> isn=E2=80=99t any.  Patches for 4.1.1 are to be collected on Monday, AFAI=
U.
>=20
>=20
> v2:
> - Dropped patch 1
> - Forgot a =E2=80=9Ccoroutine_fn=E2=80=9D in patch 2 (it isn=E2=80=99t re=
ally important,
>   qemu_coroutine_self() works in non-coroutine functions, too, but
>   calling bdrv_(co_)get_self_request() from a non-coroutine just doesn=E2=
=80=99t
>   make any sense)
> - Patch 3:
>   - Reverted the commit message to the RFC state to reflect that this is
>     specifically because of handle_alloc_space()
>   - Dropped the two lines that said there=E2=80=99d be no performance imp=
act at
>     all because no driver would submit zero writes beyond the EOF
>     (because qcow2 now still does)
>=20
>=20
> git-backport-diff against v1:
>=20
> Key:
> [----] : patches are identical
> [####] : number of functional differences between upstream/downstream pat=
ch
> [down] : patch is downstream-only
> The flags [FC] indicate (F)unctional and (C)ontextual differences, respec=
tively
>=20
> 001/3:[----] [--] 'block: Make wait/mark serialising requests public'
> 002/3:[0004] [FC] 'block: Add bdrv_co_get_self_request()'
> 003/3:[0002] [FC] 'block/file-posix: Let post-EOF fallocate serialize'
>=20
>=20
> Max Reitz (3):
>   block: Make wait/mark serialising requests public
>   block: Add bdrv_co_get_self_request()
>   block/file-posix: Let post-EOF fallocate serialize
>=20
>  include/block/block_int.h |  4 ++++
>  block/file-posix.c        | 36 +++++++++++++++++++++++++++++++++
>  block/io.c                | 42 ++++++++++++++++++++++++++++-----------
>  3 files changed, 70 insertions(+), 12 deletions(-)
>=20
> --=20
> 2.21.0
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--rJwd6BRFiFCcLxzm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2/8x4ACgkQnKSrs4Gr
c8hUpwgAks/omrf+K0jmtUVeNx48nfkQbVg9kbEDTNkHinkBmuKYFyBB4keWT5yv
A+SCQXrwwmQ7LTu8OHMQyhykRmHjYZh9QXKrMTySxmayhMeEuty2Zp3hfikwLUiQ
RXy810weBrGdJ1syqLimXFOd/YB81w7OO0uG574vfWXS4CLi/fiX+f/bZiYWIWS4
KWyIRsNjNmTdZfYl1asVZwL3ph71wb+zByTnXuta4Pvmw9yWfxAjSqe3HV+yZvtL
bHcf2BLEudChIwA6eDb6zX3MYLOK9hl9cw+0H1auQCBzBy6yUcMLVeZDohA0xdCQ
fdKzvZJj89+Kl033fgl6IsZj/IObug==
=WY2s
-----END PGP SIGNATURE-----

--rJwd6BRFiFCcLxzm--


