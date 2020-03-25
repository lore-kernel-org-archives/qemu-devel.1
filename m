Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE2EC54FD0
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 14:49:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AAE920775
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 14:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="deAV28zg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AAE920775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH7L2-0003yJ-RX
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 10:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37457)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jH7He-0000b4-Lk
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 10:45:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jH7Hd-0008Ei-JV
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 10:45:30 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:45259)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jH7Hd-0008DU-EU
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 10:45:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585147528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ffw78GnQ7aJg/SyZ5e+nt+smKyiTV/FIapJxUhgL67I=;
 b=deAV28zgI0d2FDue+fglf+wgKx/QQGfLVf9i5PLdOAGoCZot5FttvQP6DCFCaj+7quB0Xm
 IBsuEOOd3f0EHCcXDkwHKnma1EWUTzGLQBwd4yKTW/d+lMHdzZRFq+FIT24s85L5wKWdpV
 VlGblrEiJR/wdiFs53sy2EGP9k5M1o4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-01LGOmU7Ob-fCaLMxye0lA-1; Wed, 25 Mar 2020 10:45:26 -0400
X-MC-Unique: 01LGOmU7Ob-fCaLMxye0lA-1
Received: by mail-ed1-f69.google.com with SMTP id b12so2297725edy.7
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2020 07:45:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fAGfzTTtVr37YuLmasmWRbN/k2qBaNzFXJdy2LZiBhM=;
 b=BWdS8hvu6TV9jDm7V2r/smIszQ7lcTkTF8UZB91b+haCI3MLrueebShinh2zepL5ZU
 D5bnXJxCKeW4wg0aOmaVgjm5qlTqa5XRhUlg0j3hIGqFY8utOlbLS7yWfkJE8OIa/Tla
 dsHFYGTcz6D82ueP1Ks0JLCbCcbnvHyNMKHxQOb7LuoTKCPk6yz+aaeasm62eJMHu6UT
 3Fw6HvaL1iu7lkFhZ62EULUVSa+5eRo9O0DckWUEfRHI0a22sXXM/CuSw/Axn6OEN5IB
 o5FI/zgkONlCbkEAIWL/aTmGn6C7spC84OsjVdCEQIEjsGIV+aC9RrmeTIzoaRn/CrJw
 Mbjw==
X-Gm-Message-State: ANhLgQ1ZNyrjZTUBZfTTpWHs/WU2k8Wu32e3Rd+TZ+XHqaxqQRkiR1DR
 SW3lNz5ILGcUacBPT+20WkhYV2MHghoJjg1JYWumR1nbIucQHY8F8Dabxhw6aYf91YcEBNAsiqs
 LgNwjdJKNn8Gavcc=
X-Received: by 2002:a05:6402:c0d:: with SMTP id
 co13mr5682edb.266.1585147525628; 
 Wed, 25 Mar 2020 07:45:25 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtuiS/Fgom9c7SocRVIMXce0KKISANGxIDt6KLdc8Ua4xHKNxEqc0k54BnYULdBqoZPrapwtQ==
X-Received: by 2002:a05:6402:c0d:: with SMTP id
 co13mr5665edb.266.1585147525396; 
 Wed, 25 Mar 2020 07:45:25 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id e14sm806286edy.84.2020.03.25.07.45.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2020 07:45:24 -0700 (PDT)
Subject: Re: [PATCH-for-5.0 v2 4/4] sheepdog: Consistently set
 bdrv_has_zero_init_truncate
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200324174233.1622067-1-eblake@redhat.com>
 <20200324174233.1622067-5-eblake@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7c58b0c7-171c-d359-6f8d-c2efaa4af16e@redhat.com>
Date: Wed, 25 Mar 2020 15:45:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200324174233.1622067-5-eblake@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: kwolf@redhat.com, Liu Yuan <namei.unix@gmail.com>,
 "open list:Sheepdog" <sheepdog@lists.wpkg.org>, qemu-block@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/24/20 6:42 PM, Eric Blake wrote:
> block_int.h claims that .bdrv_has_zero_init must return 0 if
> .bdrv_has_zero_init_truncate does likewise; but this is violated if
> only the former callback is provided if .bdrv_co_truncate also exists.
> When adding the latter callback, it was mistakenly added to only one
> of the three possible sheepdog instantiations.
>=20
> Fixes: 1dcaf527
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   block/sheepdog.c | 2 ++
>   1 file changed, 2 insertions(+)
>=20
> diff --git a/block/sheepdog.c b/block/sheepdog.c
> index cfa84338a2d6..522c16a93676 100644
> --- a/block/sheepdog.c
> +++ b/block/sheepdog.c
> @@ -3269,6 +3269,7 @@ static BlockDriver bdrv_sheepdog_tcp =3D {
>       .bdrv_co_create               =3D sd_co_create,
>       .bdrv_co_create_opts          =3D sd_co_create_opts,
>       .bdrv_has_zero_init           =3D bdrv_has_zero_init_1,
> +    .bdrv_has_zero_init_truncate  =3D bdrv_has_zero_init_1,
>       .bdrv_getlength               =3D sd_getlength,
>       .bdrv_get_allocated_file_size =3D sd_get_allocated_file_size,
>       .bdrv_co_truncate             =3D sd_co_truncate,
> @@ -3307,6 +3308,7 @@ static BlockDriver bdrv_sheepdog_unix =3D {
>       .bdrv_co_create               =3D sd_co_create,
>       .bdrv_co_create_opts          =3D sd_co_create_opts,
>       .bdrv_has_zero_init           =3D bdrv_has_zero_init_1,
> +    .bdrv_has_zero_init_truncate  =3D bdrv_has_zero_init_1,
>       .bdrv_getlength               =3D sd_getlength,
>       .bdrv_get_allocated_file_size =3D sd_get_allocated_file_size,
>       .bdrv_co_truncate             =3D sd_co_truncate,
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


