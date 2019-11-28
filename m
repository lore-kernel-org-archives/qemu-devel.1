Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AFDC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 13:58:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B53321739
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 13:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SlCN2WbR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B53321739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaKJp-00011X-8A
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 08:58:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37470)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1iaJyT-00078S-Uy
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 08:36:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1iaJyP-0005uX-3o
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 08:36:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21041
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1iaJyO-0005rB-Uv
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 08:36:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574948204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eZ8QD9y1PnI81CGPc75Po7wxubsc0fvkYKsrjfuN+mM=;
 b=SlCN2WbR+AdA3rYGuqiKa8pulWvnFnqVS3OyOqoIcQQX/T14ianisA+J1lbzgxTVOxGmU1
 hXQkLZpzvQIdTWGCTARRLGaqMyI1BhGhvMFIdd+Ik7HqE6t9Li06Mf1orO6gZLWvn47UME
 RjzfnIO1L2XTh3a3yGLiRHQ65t+WDlU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-xILTtdejPSS7XCAE-zNfDw-1; Thu, 28 Nov 2019 08:36:42 -0500
Received: by mail-wm1-f70.google.com with SMTP id f16so3584013wmb.2
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 05:36:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=stDyuDTZos9RhvuhP7pxj220FEA2jim+mLtDz5Ccuek=;
 b=gGD7DaN3SWJbJZpIbo5Vvu9EpZ2LT7Luib0TOmST05D+Fe4E8r+eh24E8zhwD4CWgg
 iT/iU0zXYBVBjMnwhaDli50jBIV/09osMGFv53Gg4z1FEYY6RtiVWNXd4jweHUNl7HOU
 LT5nqvgszbQtNptNMfxFJOACUIufn+FcPKcq1wukupu07nwNZ7SltH0Z+7GXdLPdxpjk
 wg9BcTTvNTm5Xa6Kz5yq4iRlZXAZENcs6qK1ZpexJ6lBifcA2PvknDQJ1Gv3rjimDvQl
 DZzyTmcjNmF+gVXGtZ2ZKx36kxEDBsmXt6E1LzNlfTCObNlrv+nb746BNeNQvRIlhnLj
 XHBA==
X-Gm-Message-State: APjAAAW1RbXYKTEf/3ofwCY2T1B30R3UFQkAC/HsxL41qpSyorVx87LA
 U6FVzfA1cTX8GAp8XrXsie4Qnne/j0YoIW2125Z6knRHZUBz+i4FqB2wTgLmtFiTFE/SYElJXNv
 r519h6fDeSNgek2c=
X-Received: by 2002:a5d:5308:: with SMTP id e8mr41001569wrv.77.1574948201584; 
 Thu, 28 Nov 2019 05:36:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqyoUjHwh7JOUa1NN3YEeaZ8JVnF7VAQUxYXjHTk6fIbrELYeyIHDr/T85y9gFxMuZ1OaZM4+Q==
X-Received: by 2002:a5d:5308:: with SMTP id e8mr41001504wrv.77.1574948200814; 
 Thu, 28 Nov 2019 05:36:40 -0800 (PST)
Received: from steredhat (host28-88-dynamic.16-87-r.retail.telecomitalia.it.
 [87.16.88.28])
 by smtp.gmail.com with ESMTPSA id m13sm10603656wmc.41.2019.11.28.05.36.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2019 05:36:40 -0800 (PST)
Date: Thu, 28 Nov 2019 14:36:37 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: pannengyuan@huawei.com
Subject: Re: [PATCH V2] block/nbd: fix memory leak in nbd_open()
Message-ID: <20191128133637.gntn2a5jjpepa2sy@steredhat>
References: <1574942971-49208-1-git-send-email-pannengyuan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1574942971-49208-1-git-send-email-pannengyuan@huawei.com>
X-MC-Unique: xILTtdejPSS7XCAE-zNfDw-1
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

On Thu, Nov 28, 2019 at 08:09:31PM +0800, pannengyuan@huawei.com wrote:
> From: PanNengyuan <pannengyuan@huawei.com>
>=20
> In currently implementation there will be a memory leak when
> nbd_client_connect() returns error status. Here is an easy way to
> reproduce:
>=20
> 1. run qemu-iotests as follow and check the result with asan:
>     ./check -raw 143
>=20
> Following is the asan output backtrack:
> Direct leak of 40 byte(s) in 1 object(s) allocated from:
>     #0 0x7f629688a560 in calloc (/usr/lib64/libasan.so.3+0xc7560)
>     #1 0x7f6295e7e015 in g_malloc0  (/usr/lib64/libglib-2.0.so.0+0x50015)
>     #2 0x56281dab4642 in qobject_input_start_struct  /mnt/sdb/qemu-4.2.0-=
rc0/qapi/qobject-input-visitor.c:295
>     #3 0x56281dab1a04 in visit_start_struct  /mnt/sdb/qemu-4.2.0-rc0/qapi=
/qapi-visit-core.c:49
>     #4 0x56281dad1827 in visit_type_SocketAddress  qapi/qapi-visit-socket=
s.c:386
>     #5 0x56281da8062f in nbd_config   /mnt/sdb/qemu-4.2.0-rc0/block/nbd.c=
:1716
>     #6 0x56281da8062f in nbd_process_options  /mnt/sdb/qemu-4.2.0-rc0/blo=
ck/nbd.c:1829
>     #7 0x56281da8062f in nbd_open  /mnt/sdb/qemu-4.2.0-rc0/block/nbd.c:18=
73
>=20
> Direct leak of 15 byte(s) in 1 object(s) allocated from:
>     #0 0x7f629688a3a0 in malloc (/usr/lib64/libasan.so.3+0xc73a0)
>     #1 0x7f6295e7dfbd in g_malloc (/usr/lib64/libglib-2.0.so.0+0x4ffbd)
>     #2 0x7f6295e96ace in g_strdup (/usr/lib64/libglib-2.0.so.0+0x68ace)
>     #3 0x56281da804ac in nbd_process_options /mnt/sdb/qemu-4.2.0-rc0/bloc=
k/nbd.c:1834
>     #4 0x56281da804ac in nbd_open /mnt/sdb/qemu-4.2.0-rc0/block/nbd.c:187=
3
>=20
> Indirect leak of 24 byte(s) in 1 object(s) allocated from:
>     #0 0x7f629688a3a0 in malloc (/usr/lib64/libasan.so.3+0xc73a0)
>     #1 0x7f6295e7dfbd in g_malloc (/usr/lib64/libglib-2.0.so.0+0x4ffbd)
>     #2 0x7f6295e96ace in g_strdup (/usr/lib64/libglib-2.0.so.0+0x68ace)
>     #3 0x56281dab41a3 in qobject_input_type_str_keyval  /mnt/sdb/qemu-4.2=
.0-rc0/qapi/qobject-input-visitor.c:536
>     #4 0x56281dab2ee9 in visit_type_str  /mnt/sdb/qemu-4.2.0-rc0/qapi/qap=
i-visit-core.c:297
>     #5 0x56281dad0fa1 in visit_type_UnixSocketAddress_members qapi/qapi-v=
isit-sockets.c:141
>     #6 0x56281dad17b6 in visit_type_SocketAddress_members  qapi/qapi-visi=
t-sockets.c:366
>     #7 0x56281dad186a in visit_type_SocketAddress qapi/qapi-visit-sockets=
.c:393
>     #8 0x56281da8062f in nbd_config /mnt/sdb/qemu-4.2.0-rc0/block/nbd.c:1=
716
>     #9 0x56281da8062f in nbd_process_options /mnt/sdb/qemu-4.2.0-rc0/bloc=
k/nbd.c:1829
>     #10 0x56281da8062f in nbd_open /mnt/sdb/qemu-4.2.0-rc0/block/nbd.c:18=
73
>=20
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: PanNengyuan <pannengyuan@huawei.com>
> ---
> Changes v2 to v1:
> - add a new function to do the common cleanups (suggested by Stefano Garz=
arella).
> ---
>  block/nbd.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
>=20
> diff --git a/block/nbd.c b/block/nbd.c
> index 1239761..f8aa2a8 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -94,6 +94,8 @@ typedef struct BDRVNBDState {
> =20
>  static int nbd_client_connect(BlockDriverState *bs, Error **errp);
> =20
> +static void nbd_free_bdrvstate_prop(BDRVNBDState *s);
> +
>  static void nbd_channel_error(BDRVNBDState *s, int ret)
>  {
>      if (ret =3D=3D -EIO) {
> @@ -1486,6 +1488,17 @@ static int nbd_client_connect(BlockDriverState *bs=
, Error **errp)
>      }
>  }
> =20
> +static void nbd_free_bdrvstate_prop(BDRVNBDState *s)
> +{
> +    object_unref(OBJECT(s->tlscreds));
> +    qapi_free_SocketAddress(s->saddr);
> +    g_free(s->export);
> +    g_free(s->tlscredsid);
> +    if (s->x_dirty_bitmap) {
       ^ it is not needed, g_free() handles NULL pointers.
> +        g_free(s->x_dirty_bitmap);
> +    }
> +}
> +

Please, split this patch in two patches:
- the first patch where you add this function and use it in
  nbd_process_options() and nbd_close()
- the second patch where you fix the leak in nbd_open()

Thanks,
Stefano

>  /*
>   * Parse nbd_open options
>   */
> @@ -1855,10 +1868,7 @@ static int nbd_process_options(BlockDriverState *b=
s, QDict *options,
> =20
>   error:
>      if (ret < 0) {
> -        object_unref(OBJECT(s->tlscreds));
> -        qapi_free_SocketAddress(s->saddr);
> -        g_free(s->export);
> -        g_free(s->tlscredsid);
> +        nbd_free_bdrvstate_prop(s);
>      }
>      qemu_opts_del(opts);
>      return ret;
> @@ -1881,6 +1891,7 @@ static int nbd_open(BlockDriverState *bs, QDict *op=
tions, int flags,
> =20
>      ret =3D nbd_client_connect(bs, errp);
>      if (ret < 0) {
> +        nbd_free_bdrvstate_prop(s);
>          return ret;
>      }
>      /* successfully connected */
> @@ -1937,12 +1948,7 @@ static void nbd_close(BlockDriverState *bs)
>      BDRVNBDState *s =3D bs->opaque;
> =20
>      nbd_client_close(bs);
> -
> -    object_unref(OBJECT(s->tlscreds));
> -    qapi_free_SocketAddress(s->saddr);
> -    g_free(s->export);
> -    g_free(s->tlscredsid);
> -    g_free(s->x_dirty_bitmap);
> +    nbd_free_bdrvstate_prop(s);
>  }
> =20
>  static int64_t nbd_getlength(BlockDriverState *bs)
> --=20
> 2.7.2.windows.1
>=20
>=20
>=20

--=20


