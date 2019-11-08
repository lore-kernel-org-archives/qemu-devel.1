Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAA9FC6196
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 21:00:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B497A20869
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 21:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vP76qVAk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B497A20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iTBN6-0001Bj-TZ
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 16:00:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52592)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iTBLl-0000CW-I6
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 15:59:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iTBLk-0004pJ-Jq
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 15:59:21 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46949)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iTBLk-0004p5-Dz
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 15:59:20 -0500
Received: by mail-wr1-x442.google.com with SMTP id b3so8484014wrs.13
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2019 12:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=tRfRi6VB/Y3Y8JzSXjtEjiocNzaOaRNdnQhQ6MBN/dQ=;
 b=vP76qVAkbvSt4yayqxKbMmixNqRTDeR46/sPRIAIIif0m7/Phu5lH3IY1HuGviIuPa
 HZ4/CsRh3BtIiLCPzaN78HAZBiT8X9Nf+vukDw8lbjDUUnZ52898ZCdrpwssbX6i0XJ7
 ViO2lxD2ssiobni8KG6UYNqqJs1v+6qLa6LgEod8O1fQNtAaUpEahuJlQd4uv49NbE7F
 ucONb3CByyy37c7tUzzu6uNqsEScIcEQLGvhLB30LJq/2pPhf3RMGSIabKFuj4cwB8s7
 PmdHfF7ktAlNr0THOPEkqk1JgEVzCO9nV6T6i6v9PAYkwTxK6mH+RG4m+24Qj94Axhzp
 WGSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=tRfRi6VB/Y3Y8JzSXjtEjiocNzaOaRNdnQhQ6MBN/dQ=;
 b=mYxXLPihpqyWQzAKyKnp8X4k0y+wxyv5M9WcufNcBMDscT+ABTv900l3UcHnr7bI/H
 bSbqCU68N4yIBMOkyHbzWJBYDk/Fw1EZQ+v2VRT4ZLJ9geSeRY8xvC0hCLDJMFzT7tT4
 6QDkTyYG1Gu+jh8GIZCvAqle/CHevX5G7KmuQUvMyf16W3tUOqTz+Huj5eE6HlzWX2eJ
 8M7SSLeNQ5gcVDEWF7J4YyHOfhupdNcbfEh0FLNHU98BfwsQ+OsGWYEZL9STzgjbiy9B
 QS0sPw3kYQSEAXPj5k3jBuYrPq1OnBoV/aN0YMXu6Uj4nWe4Adv/97vMzIr6YcSqcwYE
 uejg==
X-Gm-Message-State: APjAAAWi6neU4Iv6cb1ZG6Jq6WyUMhhv2KVs3tD1l8QwEZfjCCXAkt/T
 dsblVrtqYNpcJkLbPuRVF0YBOcc5cczfSzOl/AQ=
X-Google-Smtp-Source: APXvYqz3bfeW+Uxse2EjUZ8+UeleH8XWfdO0UYex6UEUt4x0P8XJ/KoVlC6uCmFo9mzqIdH6AuTjo8BVohn95//j4Pk=
X-Received: by 2002:adf:ed4e:: with SMTP id u14mr10627026wro.132.1573246759485; 
 Fri, 08 Nov 2019 12:59:19 -0800 (PST)
MIME-Version: 1.0
References: <20191011160552.22907-1-vsementsov@virtuozzo.com>
 <20191011160552.22907-23-vsementsov@virtuozzo.com>
In-Reply-To: <20191011160552.22907-23-vsementsov@virtuozzo.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sat, 9 Nov 2019 00:59:07 +0400
Message-ID: <CAJ+F1CKo9tuJRoq3qw=Ypz9_wjQ5rvy2GOXfH7gT+8_FoSv9BA@mail.gmail.com>
Subject: Re: [RFC v5 022/126] backends/cryptodev: drop local_err from
 cryptodev_backend_complete()
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: "Gonglei \(Arei\)" <arei.gonglei@huawei.com>, QEMU <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 11, 2019 at 8:58 PM Vladimir Sementsov-Ogievskiy
<vsementsov@virtuozzo.com> wrote:
>
> No reason for local_err here, use errp directly instead.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  backends/cryptodev.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/backends/cryptodev.c b/backends/cryptodev.c
> index 3c071eab95..5a9735684e 100644
> --- a/backends/cryptodev.c
> +++ b/backends/cryptodev.c
> @@ -176,19 +176,10 @@ cryptodev_backend_complete(UserCreatable *uc, Error=
 **errp)
>  {
>      CryptoDevBackend *backend =3D CRYPTODEV_BACKEND(uc);
>      CryptoDevBackendClass *bc =3D CRYPTODEV_BACKEND_GET_CLASS(uc);
> -    Error *local_err =3D NULL;
>
>      if (bc->init) {
> -        bc->init(backend, &local_err);
> -        if (local_err) {
> -            goto out;
> -        }
> +        bc->init(backend, errp);
>      }
> -
> -    return;
> -
> -out:
> -    error_propagate(errp, local_err);
>  }
>
>  void cryptodev_backend_set_used(CryptoDevBackend *backend, bool used)
> --
> 2.21.0
>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

--=20
Marc-Andr=C3=A9 Lureau

