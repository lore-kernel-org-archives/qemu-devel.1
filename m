Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632B7C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 16:03:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 310D920679
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 16:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C17KgT7W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 310D920679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZGpM-0005lu-Vd
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 11:03:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36839)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iZGnF-0003tG-JH
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 11:00:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iZGnB-00073K-V5
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 11:00:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53688
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iZGn9-00072U-CT
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 11:00:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574697646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dGholLbexEcT6EajvtJ1ypQrkNDCDFhJDf3eUkuzUNM=;
 b=C17KgT7Wq2UTGsAMd71I8JeOE6s40JQiT+7y/08jpcBzvfw2Tfc2SMzs6vI5Ma7N8Dfp95
 5UueogYATRQEFXT8TTXXEalOE3aprW38fBvrt5DW8is8ZG7Snd+JSJA/3MLOUPPTZ651ZE
 Ex8VGZ9zs7G3vRYoFcseqH+IgBtv4hc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-HWFy1os-P7C9Z0Pw_5RYtw-1; Mon, 25 Nov 2019 11:00:42 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A7D0800594;
 Mon, 25 Nov 2019 16:00:41 +0000 (UTC)
Received: from linux.fritz.box (unknown [10.36.118.9])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 465E35D9CD;
 Mon, 25 Nov 2019 16:00:39 +0000 (UTC)
Date: Mon, 25 Nov 2019 17:00:37 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH 1/4] block/io: fix bdrv_co_block_status_above
Message-ID: <20191125160037.GD4638@linux.fritz.box>
References: <20191116163410.12129-1-vsementsov@virtuozzo.com>
 <20191116163410.12129-2-vsementsov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20191116163410.12129-2-vsementsov@virtuozzo.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: HWFy1os-P7C9Z0Pw_5RYtw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
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
Cc: fam@euphon.net, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 16.11.2019 um 17:34 hat Vladimir Sementsov-Ogievskiy geschrieben:
> bdrv_co_block_status_above has several problems with handling short
> backing files:
>=20
> 1. With want_zeros=3Dtrue, it may return ret with BDRV_BLOCK_ZERO but
> without BDRV_BLOCK_ALLOCATED flag, when actually short backing file
> which produces these after-EOF zeros is inside requested backing
> sequesnce.

s/sequesnce/sequence/

>=20
> 2. With want_zeros=3Dfalse, it will just stop inside requested region, if
> we have unallocated region in top node when underlying backing is
> short.

I honestly don't understand this one. Can you rephrase/explain in more
detail what you mean by "stop inside [the] requested region"?

> Fix these things, making logic about short backing files clearer.
>=20
> Note that 154 output changed, because now bdrv_block_status_above don't
> merge unallocated zeros with zeros after EOF (which are actually
> "allocated" in POV of read from backing-chain top) and is_zero() just
> don't understand that the whole head or tail is zero. We may update
> is_zero to call bdrv_block_status_above several times, or add flag to
> bdrv_block_status_above that we are not interested in ALLOCATED flag,
> so ranges with different ALLOCATED status may be merged, but actually,
> it seems that we'd better don't care about this corner case.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/io.c                 | 41 ++++++++++++++++++++++++++++----------
>  tests/qemu-iotests/154.out |  4 ++--
>  2 files changed, 32 insertions(+), 13 deletions(-)
>=20
> diff --git a/block/io.c b/block/io.c
> index f75777f5ea..4d7fa99bd2 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -2434,25 +2434,44 @@ static int coroutine_fn bdrv_co_block_status_abov=
e(BlockDriverState *bs,
>          ret =3D bdrv_co_block_status(p, want_zero, offset, bytes, pnum, =
map,
>                                     file);
>          if (ret < 0) {
> -            break;
> +            return ret;
>          }
> -        if (ret & BDRV_BLOCK_ZERO && ret & BDRV_BLOCK_EOF && !first) {
> +        if (*pnum =3D=3D 0) {
> +            if (first) {
> +                return ret;
> +            }
> +
>              /*
> -             * Reading beyond the end of the file continues to read
> -             * zeroes, but we can only widen the result to the
> -             * unallocated length we learned from an earlier
> -             * iteration.
> +             * Reads from bs for selected region will return zeroes, pro=
duced
> +             * because current level is short. We should consider it as
> +             * allocated.

"the selected region"
"the current level"

> +             * TODO: Should we report p as file here?

I think that would make sense.

>               */
> +            assert(ret & BDRV_BLOCK_EOF);

Can this assertion be moved above the if (first)?

>              *pnum =3D bytes;
> +            return BDRV_BLOCK_ZERO | BDRV_BLOCK_ALLOCATED;
>          }
> -        if (ret & (BDRV_BLOCK_ZERO | BDRV_BLOCK_DATA)) {
> -            break;
> +        if (ret & BDRV_BLOCK_ALLOCATED) {
> +            /* We've found the node and the status, we must return. */
> +
> +            if (ret & BDRV_BLOCK_ZERO && ret & BDRV_BLOCK_EOF && !first)=
 {
> +                /*
> +                 * This level also responsible for reads after EOF insid=
e
> +                 * unallocated region in previous level.

"is also responsible"
"the unallocated region in the previous level"

> +                 */
> +                *pnum =3D bytes;
> +            }
> +
> +            return ret;
>          }
> -        /* [offset, pnum] unallocated on this layer, which could be only
> -         * the first part of [offset, bytes].  */

Any reason for deleting this comment? I think it's still valid.

> -        bytes =3D MIN(bytes, *pnum);
> +
> +        /* Proceed to backing */
> +        assert(*pnum <=3D bytes);
> +        bytes =3D *pnum;
>          first =3D false;
>      }
> +
>      return ret;
>  }

Kevin


