Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC73C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 09:49:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 955322464D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 09:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VflVecgw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 955322464D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icnl5-00011Z-Jc
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 04:49:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50993)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1icnfG-0006fP-6G
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 04:43:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1icnfE-0003q7-KF
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 04:43:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55073
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1icnfC-0003oA-LU
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 04:43:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575538988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kplMizwHfbOJX7uz/OCWjKr2gh75iAnTy3WnYskBIXU=;
 b=VflVecgwyOYmaY3CLW7Yk2HaHLirNANqZMVBkj20z8rMsJF6zcfgFXoNXqNICCrSLICICO
 bt4qlGxP8D33TvixnEZhdAw/vTSn6RKCrihxr3Ebm2xQuD36GJ4A15vuDpZX9NBD0D1NCw
 UqvY2cWClXS9LqPKLiHaERCFRbJ0urw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-TCVabl1fNxOJ9zJcjt8WYg-1; Thu, 05 Dec 2019 04:43:03 -0500
Received: by mail-wr1-f72.google.com with SMTP id u12so1276000wrt.15
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 01:43:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Oo8JdBzSfmLgf5O2t1WIVNXf0TLwGIs0qvPU19562gg=;
 b=sh0AY4naSwFqs9ILLvgUZSNxovoR897b2rtSIII5YjTsC+cdewsZ3RF43vqQF9pIoH
 YUJi6bal7boBlociWba2EiM0a77BKIzEL50xLv4/1NohCxfC9vZf2kYCUkRd68pZ3RlY
 EzIWRjVX27MdvMWtQriJlseuoMivoV7OVohl/H3bd3Pc6KxBqlUMWk7FXJTXgSSZn3qI
 LiMIuRFYrpoQfhv5wJo2vYeZdmmI2Ap5BfmgbklsQ4Yz9nrJWyD9wD1tbas2lJHCCoXs
 cDnKQzM7B0s/LI4VG8UvPldKaBfuKNn+mDA1wrNJME09vEsGNWXeV233YwKfk+zn3Y2Z
 uCGw==
X-Gm-Message-State: APjAAAVYKuSQX3JeNf/1rLx5sbnivxWPfj0AY2LPTsirF2tZkksbyaVL
 2CCqqjTPGmS7yWx5QSd6YVpy1x3+yWdKx7xq5LqBiJPQ4FrVCGle2J+DtMZLFZ25es4/hl5Lnbh
 TYbJv3sshkaVvRY0=
X-Received: by 2002:a5d:6305:: with SMTP id i5mr9166617wru.119.1575538982185; 
 Thu, 05 Dec 2019 01:43:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqy+1JkO0o9DaqlHc9KcymYynztI/EfdBz02tbzP6XelXMoEzYwimlzZdq7cjGpfpP+Ohnxi9g==
X-Received: by 2002:a5d:6305:: with SMTP id i5mr9166596wru.119.1575538981959; 
 Thu, 05 Dec 2019 01:43:01 -0800 (PST)
Received: from steredhat (host28-88-dynamic.16-87-r.retail.telecomitalia.it.
 [87.16.88.28])
 by smtp.gmail.com with ESMTPSA id v15sm9253624wmh.24.2019.12.05.01.43.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2019 01:43:01 -0800 (PST)
Date: Thu, 5 Dec 2019 10:42:59 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: pannengyuan@huawei.com
Subject: Re: [PATCH v5 1/2] block/nbd: extract the common cleanup code
Message-ID: <20191205094259.r4qb4jxcrom76x7f@steredhat>
References: <1575517528-44312-1-git-send-email-pannengyuan@huawei.com>
 <1575517528-44312-2-git-send-email-pannengyuan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1575517528-44312-2-git-send-email-pannengyuan@huawei.com>
X-MC-Unique: TCVabl1fNxOJ9zJcjt8WYg-1
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
Cc: kwolf@redhat.com, liyiting@huawei.com, zhang.zhanghailiang@huawei.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 kuhn.chenqun@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Pan,

On Thu, Dec 05, 2019 at 11:45:27AM +0800, pannengyuan@huawei.com wrote:
> From: Pan Nengyuan <pannengyuan@huawei.com>
>=20
> The BDRVNBDState cleanup code is common in two places, add
> nbd_clear_bdrvstate() function to do these cleanups.
>=20
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

I only suggested this change, so I think is better to change it in:
Suggested-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
> v3:
> - new patch, split form 2/2 patch (suggested by Stefano Garzarella)
> Changes v4 to v3:
> - replace function name from nbd_free_bdrvstate_prop to
>   nbd_clear_bdrvstate and set cleared fields to NULL (suggested by Eric
>   Blake)
> - remove static function prototype. (suggested by Eric Blake)
> ---
> Changes v5 to v4:
> - correct the wrong email address
> ---
>  block/nbd.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
>=20
> diff --git a/block/nbd.c b/block/nbd.c
> index 1239761..8b4a65a 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -94,6 +94,19 @@ typedef struct BDRVNBDState {
> =20
>  static int nbd_client_connect(BlockDriverState *bs, Error **errp);
> =20
> +void nbd_clear_bdrvstate(BDRVNBDState *s)
> +{
> +    object_unref(OBJECT(s->tlscreds));
> +    qapi_free_SocketAddress(s->saddr);
> +    s->saddr =3D NULL;
> +    g_free(s->export);
> +    s->export =3D NULL;
> +    g_free(s->tlscredsid);
> +    s->tlscredsid =3D NULL;
> +    g_free(s->x_dirty_bitmap);
> +    s->x_dirty_bitmap =3D NULL;
> +}
> +
>  static void nbd_channel_error(BDRVNBDState *s, int ret)
>  {
>      if (ret =3D=3D -EIO) {
> @@ -1855,10 +1868,7 @@ static int nbd_process_options(BlockDriverState *b=
s, QDict *options,
> =20
>   error:
>      if (ret < 0) {
> -        object_unref(OBJECT(s->tlscreds));
> -        qapi_free_SocketAddress(s->saddr);
> -        g_free(s->export);
> -        g_free(s->tlscredsid);
> +        nbd_clear_bdrvstate(s);
>      }
>      qemu_opts_del(opts);
>      return ret;
> @@ -1937,12 +1947,7 @@ static void nbd_close(BlockDriverState *bs)
>      BDRVNBDState *s =3D bs->opaque;
> =20
>      nbd_client_close(bs);
> -
> -    object_unref(OBJECT(s->tlscreds));
> -    qapi_free_SocketAddress(s->saddr);
> -    g_free(s->export);
> -    g_free(s->tlscredsid);
> -    g_free(s->x_dirty_bitmap);
> +    nbd_clear_bdrvstate(s);
>  }
> =20
>  static int64_t nbd_getlength(BlockDriverState *bs)
> --=20
> 2.7.2.windows.1
>=20
>=20

--=20


