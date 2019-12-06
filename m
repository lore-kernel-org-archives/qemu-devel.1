Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFFEC43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:28:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89BD82466E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 15:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bT6Q0RvB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89BD82466E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idFX3-00062Y-TR
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 10:28:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34611)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1idEcs-0008WA-9I
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:30:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1idEce-0004dr-EB
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:30:25 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35758
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1idEcb-0004YZ-Nt
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:30:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575642616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bbP67jnRbmBjMQgSmpeq866mKuV61nIVTxsBbscMtG8=;
 b=bT6Q0RvBeRgEEmZeQiyvvdLrtE58pSZvrj3v5mfyBZ3cQ1QhEqXK13Wu3gwrRv6O+Giw1X
 ownxDy6kFrDl3LAan/0zqEYqLYNc1Z0vmq6CW2qVJk8Ek2rGy+ft/+yb0MiyrFAMO3QH0N
 IxUrMazUQz5RKGxTq9c0FsvX6Th/VqI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-OMXQpLg2NdKOR4HDk7e5hw-1; Fri, 06 Dec 2019 02:28:42 -0500
Received: by mail-wm1-f71.google.com with SMTP id v8so1790019wml.4
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 23:28:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=75m/0pESRoURDWGsUz0Rj5lwUM3NNX+Bwb4B7Hi/g58=;
 b=Yi3MFHUFAjcUncYJVZo7Ldpbc8qKx3+98vh6EE1RUSGX3TQM5Uh1YCFIQ1DwAwJwjH
 67SBEaDSfpc/GHukZtXgsNrERDQ9a5bbEmPQNKg7ub2cMv5gdeq3aXcXLnaDHw7MoyH4
 W7ywoS39LIk0V4xyWnnYHFj2qQMszui2sgl5trmAj+EN8fO1QC/dNBW4PzgwpIawGhBl
 vs3s9f7cXWWUauseVJ0AeTP58Z/yqOzF2VZhK7et3uTUifRcYGyuhPrd3azDLtjrutoO
 3KuqFC6FC3yZAyIQblzxcuPGzx2rEn9wlFATu+NGMj2HFtV6SbjfRdSQFGyhblhrz4qr
 AHNg==
X-Gm-Message-State: APjAAAW3mb0HOK/9CK3yDJppsGcNWFB3RW2j3m6HagRrfaTq3+xBnIV6
 6aacAzjO5R035vbcJSWOMUqJpkgTslBqcUJrjiKA3CXu+qAfrd1XD7ptylyW7qRNOBUx/J2FLzW
 o7+M+pLbiWe99c/0=
X-Received: by 2002:adf:eb48:: with SMTP id u8mr13562889wrn.283.1575617321083; 
 Thu, 05 Dec 2019 23:28:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqzooi50kKOPuKRWkWiklaaM0x6b4dhJjDavgk3x+dx9ulgGsmhEiurKEKvVHciOIrfpvJ+4ow==
X-Received: by 2002:adf:eb48:: with SMTP id u8mr13562863wrn.283.1575617320816; 
 Thu, 05 Dec 2019 23:28:40 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id j12sm16089460wrw.54.2019.12.05.23.28.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2019 23:28:40 -0800 (PST)
Subject: Re: [PATCH v8 03/21] error: make Error **errp const where it is
 appropriate
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20191205174635.18758-1-vsementsov@virtuozzo.com>
 <20191205174635.18758-4-vsementsov@virtuozzo.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c791caf0-86d9-93f0-1319-afb1e72002c5@redhat.com>
Date: Fri, 6 Dec 2019 08:28:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191205174635.18758-4-vsementsov@virtuozzo.com>
Content-Language: en-US
X-MC-Unique: OMXQpLg2NdKOR4HDk7e5hw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: armbru@redhat.com, Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/5/19 6:46 PM, Vladimir Sementsov-Ogievskiy wrote:
> Mostly, Error ** is for returning error from the function, so the
> callee sets it. However these three functions get already filled errp
> parameter. They dont change the pointer itself, only change the
> internal state of referenced Error object. So we can make it
> Error *const * errp, to stress the behavior. It will also help
> coccinelle script (in future) to distinguish such cases from common
> errp usage.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

> ---
>   include/qapi/error.h | 6 +++---
>   util/error.c         | 6 +++---
>   2 files changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/include/qapi/error.h b/include/qapi/error.h
> index 3f95141a01..ad5b6e896d 100644
> --- a/include/qapi/error.h
> +++ b/include/qapi/error.h
> @@ -233,13 +233,13 @@ void error_propagate_prepend(Error **dst_errp, Erro=
r *local_err,
>    * Prepend some text to @errp's human-readable error message.
>    * The text is made by formatting @fmt, @ap like vprintf().
>    */
> -void error_vprepend(Error **errp, const char *fmt, va_list ap);
> +void error_vprepend(Error *const *errp, const char *fmt, va_list ap);
>  =20
>   /*
>    * Prepend some text to @errp's human-readable error message.
>    * The text is made by formatting @fmt, ... like printf().
>    */
> -void error_prepend(Error **errp, const char *fmt, ...)
> +void error_prepend(Error *const *errp, const char *fmt, ...)
>       GCC_FMT_ATTR(2, 3);
>  =20
>   /*
> @@ -256,7 +256,7 @@ void error_prepend(Error **errp, const char *fmt, ...=
)
>    * May be called multiple times.  The resulting hint should end with a
>    * newline.
>    */
> -void error_append_hint(Error **errp, const char *fmt, ...)
> +void error_append_hint(Error *const *errp, const char *fmt, ...)
>       GCC_FMT_ATTR(2, 3);
>  =20
>   /*
> diff --git a/util/error.c b/util/error.c
> index d4532ce318..b6c89d1412 100644
> --- a/util/error.c
> +++ b/util/error.c
> @@ -121,7 +121,7 @@ void error_setg_file_open_internal(Error **errp,
>                                 "Could not open '%s'", filename);
>   }
>  =20
> -void error_vprepend(Error **errp, const char *fmt, va_list ap)
> +void error_vprepend(Error *const *errp, const char *fmt, va_list ap)
>   {
>       GString *newmsg;
>  =20
> @@ -136,7 +136,7 @@ void error_vprepend(Error **errp, const char *fmt, va=
_list ap)
>       (*errp)->msg =3D g_string_free(newmsg, 0);
>   }
>  =20
> -void error_prepend(Error **errp, const char *fmt, ...)
> +void error_prepend(Error *const *errp, const char *fmt, ...)
>   {
>       va_list ap;
>  =20
> @@ -145,7 +145,7 @@ void error_prepend(Error **errp, const char *fmt, ...=
)
>       va_end(ap);
>   }
>  =20
> -void error_append_hint(Error **errp, const char *fmt, ...)
> +void error_append_hint(Error *const *errp, const char *fmt, ...)
>   {
>       va_list ap;
>       int saved_errno =3D errno;
>=20


