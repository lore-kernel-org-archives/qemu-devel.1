Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63D0C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 15:56:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2FE320702
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 15:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BrOrUomn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2FE320702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izN2K-0007Xd-Om
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 10:56:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42136)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1izN1P-000714-5m
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 10:55:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1izN1M-00068R-ON
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 10:55:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23279
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1izN1M-000676-K1
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 10:55:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580918120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nEO0L9Tl03Hwr9hL+Yjt13PQRNTVE8BJLZL15hoHW70=;
 b=BrOrUomnA/hIQz8QvR23YdAlysvjZkeTb+p+hKgdRnZxM+l29W/1Ro1wMzJ9GyUPGLIl+j
 +ZuqBN10F77TaXiY1ZpEbGaXDNtKTlmC/GYiaFSOP8X1/Y2RNLFk1jvuCXgqowebPEgNR8
 K2hxK7OivNfJpNrp0WQIgtzmurw69Vg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-ADbGB8NlNSeIfZtj79JYkw-1; Wed, 05 Feb 2020 10:55:16 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7BEE1DB63;
 Wed,  5 Feb 2020 15:55:15 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 300D55DA7B;
 Wed,  5 Feb 2020 15:55:13 +0000 (UTC)
Date: Wed, 5 Feb 2020 16:55:11 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH for-5.0 v2 10/23] quorum: Implement
 .bdrv_recurse_can_replace()
Message-ID: <20200205155511.GF5768@dhcp-200-226.str.redhat.com>
References: <20191111160216.197086-1-mreitz@redhat.com>
 <20191111160216.197086-11-mreitz@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191111160216.197086-11-mreitz@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: ADbGB8NlNSeIfZtj79JYkw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
 Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 11.11.2019 um 17:02 hat Max Reitz geschrieben:
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/quorum.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>=20
> diff --git a/block/quorum.c b/block/quorum.c
> index 3a824e77e3..8ee03e9baf 100644
> --- a/block/quorum.c
> +++ b/block/quorum.c
> @@ -825,6 +825,67 @@ static bool quorum_recurse_is_first_non_filter(Block=
DriverState *bs,
>      return false;
>  }
> =20
> +static bool quorum_recurse_can_replace(BlockDriverState *bs,
> +                                       BlockDriverState *to_replace)
> +{
> +    BDRVQuorumState *s =3D bs->opaque;
> +    int i;
> +
> +    for (i =3D 0; i < s->num_children; i++) {
> +        /*
> +         * We have no idea whether our children show the same data as
> +         * this node (@bs).  It is actually highly likely that
> +         * @to_replace does not, because replacing a broken child is
> +         * one of the main use cases here.
> +         *
> +         * We do know that the new BDS will match @bs, so replacing
> +         * any of our children by it will be safe.  It cannot change
> +         * the data this quorum node presents to its parents.
> +         *
> +         * However, replacing @to_replace by @bs in any of our
> +         * children's chains may change visible data somewhere in
> +         * there.  We therefore cannot recurse down those chains with
> +         * bdrv_recurse_can_replace().
> +         * (More formally, bdrv_recurse_can_replace() requires that
> +         * @to_replace will be replaced by something matching the @bs
> +         * passed to it.  We cannot guarantee that.)
> +         *
> +         * Thus, we can only check whether any of our immediate
> +         * children matches @to_replace.
> +         *
> +         * (In the future, we might add a function to recurse down a
> +         * chain that checks that nothing there cares about a change
> +         * in data from the respective child in question.  For
> +         * example, most filters do not care when their child's data
> +         * suddenly changes, as long as their parents do not care.)
> +         */
> +        if (s->children[i].child->bs =3D=3D to_replace) {
> +            Error *local_err =3D NULL;
> +
> +            /*
> +             * We now have to ensure that there is no other parent
> +             * that cares about replacing this child by a node with
> +             * potentially different data.
> +             */
> +            s->children[i].to_be_replaced =3D true;
> +            bdrv_child_refresh_perms(bs, s->children[i].child, &local_er=
r);
> +
> +            /* Revert permissions */
> +            s->children[i].to_be_replaced =3D false;
> +            bdrv_child_refresh_perms(bs, s->children[i].child, &error_ab=
ort);

Quite a hack. The two obvious problems are:

1. We can't guarantee that we can actually revert the permissions. I
   think we ignore failure to loosen permissions meanwhile so that at
   least the &error_abort doesn't trigger, but bs could still be in the
   wrong state afterwards.

   It would be cleaner to use check+abort instead of actually setting
   the new permission.

2. As aborting the permission change makes more obvious, we're checking
   something that might not be true any more when we actually make the
   change.

Pragmatically, a hack might be good enough here, but it should be
documented as such (with a short explanation of its shortcomings) at
least.

Kevin


