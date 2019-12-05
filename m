Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824ECC43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 09:50:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CA592464E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 09:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RgzlLYR+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CA592464E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icnmg-00025B-EY
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 04:50:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38340)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1icnhV-0008Pj-Sg
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 04:45:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1icnhN-0000kj-5w
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 04:45:33 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49208
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1icnhM-0000hS-U3
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 04:45:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575539124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rEczgcfUVfkG7I1J44dp85BlXZYGU7pRPmeX+HBJFtk=;
 b=RgzlLYR+5fLyPpI4JKvzmJd+8tbR2LMw/g+/68tGqOaAC5+Et19fyDh3A9LG01oqoT06uw
 P4q71viAuSbBcnnaYfGAfB8DZPhGJ4o2bN20vPizTthrUfXlDoRiuS7kK+wtbUewOEe+Ou
 V7AV0dtnptRlwXLJ5c7Lk4hFGaXEWEk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-GgR82Qi2NKG_gyQqKofYDw-1; Thu, 05 Dec 2019 04:45:22 -0500
Received: by mail-wr1-f71.google.com with SMTP id c6so1267007wrm.18
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 01:45:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tgf+Ym6RCq7OiPcspOTR40XcffhQ/grqwAuYUQ2p9YQ=;
 b=ToN5ziH44PJSdlt9fxfCiYi9epbgm+tFwPX1l0TyQAT3eJ0a4zxT5WadFSJfo8J680
 P/GdiJ9upG+ZKXmmDOOw5PHfsI3YwCx1I/4m2rqjj5+nVtAAqwRMi0rBotiQ0aCF/PVJ
 vYOqnnyyEshg302GL2+yqhKkFtlx2ImnCmSYWCSLBC60xUa8uYxdKz3UQGgaCu1V9g3Z
 rvzxR7B6vDhvZIN3zjB3F7KNHwJTA/KzlgtFX8X5QtflCVMrzWnAalfmsm7VBNctUYBU
 aPM2eklGmNNO0Byc9hIRgdVKRKGqbOKTM02sUAIALhoCApyrNHFJqTuaIkPpnLUpdAeq
 XJ/g==
X-Gm-Message-State: APjAAAVlpv7oyLFnzg+Qyvve4jNbKJAlhI4aBcLpMw27UguONQluCrb6
 5AsicBeG80w4Rdhy2IgYaDXE5sAcPxYLjpeTzvCZQVRtTVS6y94hsrfd/pvWGBNONWJH+5rrlJa
 Wl4O0Wnm/K2fC8Ok=
X-Received: by 2002:adf:dfc2:: with SMTP id q2mr8704092wrn.251.1575539121539; 
 Thu, 05 Dec 2019 01:45:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqyg4zn3rPyKP8pVCCSQRfD0MrpMmU9DAiC7UZsfWuCCflove/EOROFUh++hr01qtlEYte7OIw==
X-Received: by 2002:adf:dfc2:: with SMTP id q2mr8704064wrn.251.1575539121289; 
 Thu, 05 Dec 2019 01:45:21 -0800 (PST)
Received: from steredhat (host28-88-dynamic.16-87-r.retail.telecomitalia.it.
 [87.16.88.28])
 by smtp.gmail.com with ESMTPSA id w20sm4275295wmk.34.2019.12.05.01.45.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2019 01:45:20 -0800 (PST)
Date: Thu, 5 Dec 2019 10:45:18 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: pannengyuan@huawei.com
Subject: Re: [PATCH v5 2/2] block/nbd: fix memory leak in nbd_open()
Message-ID: <20191205094518.4jl357lrbiuzrdcg@steredhat>
References: <1575517528-44312-1-git-send-email-pannengyuan@huawei.com>
 <1575517528-44312-3-git-send-email-pannengyuan@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1575517528-44312-3-git-send-email-pannengyuan@huawei.com>
X-MC-Unique: GgR82Qi2NKG_gyQqKofYDw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: kwolf@redhat.com, liyiting@huawei.com,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 zhang.zhanghailiang@huawei.com, qemu-block@nongnu.org,
 qemu-stable <qemu-stable@nongnu.org>, qemu-devel@nongnu.org, mreitz@redhat.com,
 kuhn.chenqun@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 05, 2019 at 11:45:28AM +0800, pannengyuan@huawei.com wrote:
> From: Pan Nengyuan <pannengyuan@huawei.com>
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
>     #6 0x56281da8062f in nbd_process_options /mnt/sdb/qemu-4.2.0-rc0/bloc=
k/nbd.c:1829
>     #7 0x56281da8062f in nbd_open /mnt/sdb/qemu-4.2.0-rc0/block/nbd.c:187=
3
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
>     #3 0x56281dab41a3 in qobject_input_type_str_keyval /mnt/sdb/qemu-4.2.=
0-rc0/qapi/qobject-input-visitor.c:536
>     #4 0x56281dab2ee9 in visit_type_str /mnt/sdb/qemu-4.2.0-rc0/qapi/qapi=
-visit-core.c:297
>     #5 0x56281dad0fa1 in visit_type_UnixSocketAddress_members qapi/qapi-v=
isit-sockets.c:141
>     #6 0x56281dad17b6 in visit_type_SocketAddress_members qapi/qapi-visit=
-sockets.c:366
>     #7 0x56281dad186a in visit_type_SocketAddress qapi/qapi-visit-sockets=
.c:393
>     #8 0x56281da8062f in nbd_config /mnt/sdb/qemu-4.2.0-rc0/block/nbd.c:1=
716
>     #9 0x56281da8062f in nbd_process_options /mnt/sdb/qemu-4.2.0-rc0/bloc=
k/nbd.c:1829
>     #10 0x56281da8062f in nbd_open /mnt/sdb/qemu-4.2.0-rc0/block/nbd.c:18=
73
>=20
> Fixes: 8f071c9db506e03ab
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Cc: qemu-stable <qemu-stable@nongnu.org>
> Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
> Changes v2 to v1:
> - add a new function to do the common cleanups (suggested by Stefano
>   Garzarella).
> ---
> Changes v3 to v2:
> - split in two patches(suggested by Stefano Garzarella)
> ---
> Changes v4 to v3:
> - replace function name from nbd_free_bdrvstate_prop to
>   nbd_clear_bdrvstate and add Fixes tag.
> ---
> Changes v5 to v4:
> - correct the wrong email address
> ---
>  block/nbd.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>=20
> diff --git a/block/nbd.c b/block/nbd.c
> index 8b4a65a..9062409 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -1891,6 +1891,7 @@ static int nbd_open(BlockDriverState *bs, QDict *op=
tions, int flags,
> =20
>      ret =3D nbd_client_connect(bs, errp);
>      if (ret < 0) {
> +        nbd_clear_bdrvstate(s);
>          return ret;
>      }
>      /* successfully connected */
> --=20
> 2.7.2.windows.1


