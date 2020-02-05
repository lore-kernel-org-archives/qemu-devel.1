Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E52C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 15:58:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84C80217BA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 15:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dMe3y+xG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84C80217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izN4f-00039H-Pb
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 10:58:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43489)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1izN3t-0002G6-Rs
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 10:57:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1izN3s-0000Qj-PF
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 10:57:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49708
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1izN3s-0000PN-L6
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 10:57:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580918276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wNh66nqG88VDB/dTueM8CwMFfxrzQzqXs730fSe4qS0=;
 b=dMe3y+xGjG037W9yPOeVPB9qG9TfO4qebQIJB9eOh26lS+h14LllOWCgrYOSQAWVQfZ6eb
 6rmyenKhIq0p4VOVvxsT7xwbO91O4Loaa7Mbk9jE5UVr+/AbROg6OkFcAVKQRfZ7+V91C9
 DDBXhxT8rvogteMdzsqnfi5J7JRDWUA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-ijGVvfilMHKvm37LXLk4wA-1; Wed, 05 Feb 2020 10:57:52 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6FAC18010EF;
 Wed,  5 Feb 2020 15:57:51 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 07E6D857AE;
 Wed,  5 Feb 2020 15:57:49 +0000 (UTC)
Date: Wed, 5 Feb 2020 16:57:48 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH for-5.0 v2 11/23] block: Use bdrv_recurse_can_replace()
Message-ID: <20200205155748.GG5768@dhcp-200-226.str.redhat.com>
References: <20191111160216.197086-1-mreitz@redhat.com>
 <20191111160216.197086-12-mreitz@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191111160216.197086-12-mreitz@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: ijGVvfilMHKvm37LXLk4wA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
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
 Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 11.11.2019 um 17:02 hat Max Reitz geschrieben:
> Let check_to_replace_node() use the more specialized
> bdrv_recurse_can_replace() instead of
> bdrv_recurse_is_first_non_filter(), which is too restrictive.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>=20
> diff --git a/block.c b/block.c
> index de53addeb0..7608f21570 100644
> --- a/block.c
> +++ b/block.c
> @@ -6243,6 +6243,17 @@ bool bdrv_recurse_can_replace(BlockDriverState *bs=
,
>      return false;
>  }
> =20
> +/*
> + * Check whether the given @node_name can be replaced by a node that
> + * has the same data as @parent_bs.  If so, return @node_name's BDS;
> + * NULL otherwise.
> + *
> + * @node_name must be a (recursive) *child of @parent_bs (or this
> + * function will return NULL).
> + *
> + * The result (whether the node can be replaced or not) is only valid
> + * for as long as no graph changes occur.
> + */
>  BlockDriverState *check_to_replace_node(BlockDriverState *parent_bs,
>                                          const char *node_name, Error **e=
rrp)
>  {
> @@ -6267,8 +6278,11 @@ BlockDriverState *check_to_replace_node(BlockDrive=
rState *parent_bs,
>       * Another benefit is that this tests exclude backing files which ar=
e
>       * blocked by the backing blockers.
>       */
> -    if (!bdrv_recurse_is_first_non_filter(parent_bs, to_replace_bs)) {
> -        error_setg(errp, "Only top most non filter can be replaced");
> +    if (!bdrv_recurse_can_replace(parent_bs, to_replace_bs)) {
> +        error_setg(errp, "Cannot replace '%s' by a node mirrored from '%=
s', "
> +                   "because it cannot be guaranteed that doing so would =
not "
> +                   "lead to an abrupt change of visible data",
> +                   node_name, parent_bs->node_name);

If this function is only supposed to be used in the context of the
mirror job, moving it into block/mirror.c could be considered as a
cleanup on top.

Kevin


