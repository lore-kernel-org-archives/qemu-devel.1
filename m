Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8EBC2D0EA
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 11:48:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97EB22076D
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 11:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aMBfRSlu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97EB22076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jM9C0-0000yT-Lc
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 07:48:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59162)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jM9BQ-0000TB-G2
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 07:47:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jM9BP-00058Y-Fo
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 07:47:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43950
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jM9BP-00058P-Bo
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 07:47:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586346471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QiddfnUC6nOTD/etMgZTSI0/tpfgxuYexfGHUaoUlQ0=;
 b=aMBfRSluj+IVc7o5JDZ8Ycq9tLtKqrGi4QDWvnfY9Fd3Gs3URW8QgbBhdiOUxEpMD/gwQZ
 0yjfw3unddUUSul8B13I1IupB5kUarIeBVa7swHadHciO9t2lIYu2stiV1K4EmOqmLqre4
 8eEW6PvDX3UQG0hQDYLi0FiNWyHD9Mo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-cME0Fzi3NraWaNvYgfV2NA-1; Wed, 08 Apr 2020 07:47:47 -0400
X-MC-Unique: cME0Fzi3NraWaNvYgfV2NA-1
Received: by mail-ed1-f72.google.com with SMTP id n15so6460002edq.6
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2020 04:47:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Xp5CT4dcC6KrFm6Fn3T5H+GGHQ6fgVemIlXpCpG/eK8=;
 b=aL3FklYhmkw/QFEiZc7wWKzeWMUvMBtZ4sRdgDgGuv9mHlL/mZo1dg8sS8v8fSfqq7
 qH6yTM7Htr4bsTJfJNd/ZkPeCcepjjSEU/e3eNaR90i4ScDeUEPwuKFcxyH7MXKi5CPd
 NUuZ398JnE4+KPfE3VSeAhK54aDUrIilf2ujBDW7le+tVPwZ05gnUY+xeSrFZgWthtor
 AfhsH3adcgdZen7KvGDa9CxUGlD3zvdVYelCQN5UDb+LERGza88wP5pF8fdKC3MGlGr/
 HOWvlZdZOCWsJ4ntOks5TGKj5h9AGJHNuO8bJ8SMfueVkNKkdKBlZA8BFAhPEl2z7fPo
 odug==
X-Gm-Message-State: AGi0PubCP+H/p6gGViLXMHv5j6BSMTsp5KRwNUDGy3oimOr8wdSrPtxE
 Ojz3ftkX+LDgiRLlwLcXdyVf2+zzPN/U6rtcA4G/tsbcmbglH6R6THSh5vVMlvgNlwPznhwOZ8J
 Eg1aBxfX0m0/7vCY=
X-Received: by 2002:aa7:dac9:: with SMTP id x9mr6035971eds.133.1586346466049; 
 Wed, 08 Apr 2020 04:47:46 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ2qjDSzK2CmlE2pUTcmlm7ZQVDWOuR02pMBtY+4P+0hMtYblBAyl6EsicnSFpZnhYz58ZUbQ==
X-Received: by 2002:aa7:dac9:: with SMTP id x9mr6035946eds.133.1586346465720; 
 Wed, 08 Apr 2020 04:47:45 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id ch5sm457694ejb.60.2020.04.08.04.47.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Apr 2020 04:47:45 -0700 (PDT)
Subject: Re: [PATCH for-5.0] aio-posix: signal-proof fdmon-io_uring
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200408091139.273851-1-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e65273c7-07ee-cea3-4a38-55db2e797f2d@redhat.com>
Date: Wed, 8 Apr 2020 13:47:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200408091139.273851-1-stefanha@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, qemu-block@nongnu.org, sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/8/20 11:11 AM, Stefan Hajnoczi wrote:
> The io_uring_enter(2) syscall returns with errno=3DEINTR when interrupted
> by a signal.  Retry the syscall in this case.
>=20
> It's essential to do this in the io_uring_submit_and_wait() case.  My
> interpretation of the Linux v5.5 io_uring_enter(2) code is that it
> shouldn't affect the io_uring_submit() case, but there is no guarantee
> this will always be the case.

This is how io_uring_enter() is documented indeed (no EINTR).

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> Let's check for -EINTR around both APIs.
>=20
> Note that the liburing APIs have -errno return values.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   util/fdmon-io_uring.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/util/fdmon-io_uring.c b/util/fdmon-io_uring.c
> index b4d6109f20..d5a80ed6fb 100644
> --- a/util/fdmon-io_uring.c
> +++ b/util/fdmon-io_uring.c
> @@ -88,7 +88,10 @@ static struct io_uring_sqe *get_sqe(AioContext *ctx)
>       }
>  =20
>       /* No free sqes left, submit pending sqes first */
> -    ret =3D io_uring_submit(ring);
> +    do {
> +        ret =3D io_uring_submit(ring);
> +    } while (ret =3D=3D -EINTR);
> +
>       assert(ret > 1);
>       sqe =3D io_uring_get_sqe(ring);
>       assert(sqe);
> @@ -282,7 +285,10 @@ static int fdmon_io_uring_wait(AioContext *ctx, AioH=
andlerList *ready_list,
>  =20
>       fill_sq_ring(ctx);
>  =20
> -    ret =3D io_uring_submit_and_wait(&ctx->fdmon_io_uring, wait_nr);
> +    do {
> +        ret =3D io_uring_submit_and_wait(&ctx->fdmon_io_uring, wait_nr);
> +    } while (ret =3D=3D -EINTR);
> +
>       assert(ret >=3D 0);
>  =20
>       return process_cq_ring(ctx, ready_list);
>=20


