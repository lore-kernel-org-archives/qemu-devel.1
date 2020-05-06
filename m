Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5211EC28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 16:38:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FD1220708
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 16:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dy93qCtq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FD1220708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWN40-00036s-5c
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 12:38:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jWN35-0002VO-6l
 for qemu-devel@nongnu.org; Wed, 06 May 2020 12:37:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53755
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jWN33-0005xT-SN
 for qemu-devel@nongnu.org; Wed, 06 May 2020 12:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588783048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kX8RlxyPNLjAXzWN8uHuWHORtA/hKt9J7Jp0RXtKTG8=;
 b=dy93qCtqVvy/P+4xzdRngcGv0QmRLfadAj/sBtX0eLJH7ZqpYi40fll/1o+qhOeK7uTwP8
 w/sv17C9Zry7uMlJqBVZ8AaUnKjQ5E0n8f/8cm1m/MYIvPGpfN8qmTC3Ha2RHkxDKlSB+o
 Thb9Eot6FYfxrbQebRHCeSWOMygN1QE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-NWS0GxCwMXO9Wa1UkcS1tA-1; Wed, 06 May 2020 12:37:26 -0400
X-MC-Unique: NWS0GxCwMXO9Wa1UkcS1tA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D243835B40;
 Wed,  6 May 2020 16:37:25 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-140.ams2.redhat.com [10.36.113.140])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 520E31001DC2;
 Wed,  6 May 2020 16:37:24 +0000 (UTC)
Date: Wed, 6 May 2020 18:37:22 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v3 22/33] block: Make backing files child_of_bds children
Message-ID: <20200506163722.GH6333@linux.fritz.box>
References: <20200218124242.584644-1-mreitz@redhat.com>
 <20200218124242.584644-23-mreitz@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200218124242.584644-23-mreitz@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 23:48:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 18.02.2020 um 13:42 hat Max Reitz geschrieben:
> Make all parents of backing files pass the appropriate BdrvChildRole.
> By doing so, we can switch their BdrvChildClass over to the generic
> child_of_bds, which will do the right thing when given a correct
> BdrvChildRole.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block.c                 | 26 ++++++++++++++++++++------
>  block/backup-top.c      |  2 +-
>  block/vvfat.c           |  3 ++-
>  tests/test-bdrv-drain.c | 13 +++++++------
>  4 files changed, 30 insertions(+), 14 deletions(-)
>=20
> diff --git a/block.c b/block.c
> index 43df38ca30..31affcb4ee 100644
> --- a/block.c
> +++ b/block.c
> @@ -2770,6 +2770,20 @@ static bool bdrv_inherits_from_recursive(BlockDriv=
erState *child,
>      return child !=3D NULL;
>  }
> =20
> +/*
> + * Return the BdrvChildRole for @bs's backing child.  bs->backing is
> + * mostly used for COW backing children (role =3D COW), but also for
> + * filtered children (role =3D FILTERED | PRIMARY).
> + */
> +static BdrvChildRole bdrv_backing_role(BlockDriverState *bs)
> +{
> +    if (bs->drv && bs->drv->is_filter) {
> +        return BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY;
> +    } else {
> +        return BDRV_CHILD_COW;
> +    }
> +}

bdrv_mirror_top and bdrv_commit_top don't set .is_filter, so it will
return the wrong role for them. (They also don't set .supports_backing,
so grepping for that wouldn't help...)

>  /*
>   * Sets the backing file link of a BDS. A new reference is created; call=
ers
>   * which don't need their own reference any more must call bdrv_unref().
> @@ -2797,8 +2811,8 @@ void bdrv_set_backing_hd(BlockDriverState *bs, Bloc=
kDriverState *backing_hd,
>          goto out;
>      }
> =20
> -    bs->backing =3D bdrv_attach_child(bs, backing_hd, "backing", &child_=
backing,
> -                                    0, errp);
> +    bs->backing =3D bdrv_attach_child(bs, backing_hd, "backing", &child_=
of_bds,
> +                                    bdrv_backing_role(bs), errp);
>      /* If backing_hd was already part of bs's backing chain, and
>       * inherits_from pointed recursively to bs then let's update it to
>       * point directly to bs (else it will become NULL). */
> @@ -2895,7 +2909,7 @@ int bdrv_open_backing_file(BlockDriverState *bs, QD=
ict *parent_options,
>      }
> =20
>      backing_hd =3D bdrv_open_inherit(backing_filename, reference, option=
s, 0, bs,
> -                                   &child_backing, 0, errp);
> +                                   &child_of_bds, BDRV_CHILD_COW, errp);

Wouldn't it be more consistent to use bdrv_backing_role() here, too?

Kevin


