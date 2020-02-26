Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC6BC4BA0E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 10:04:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36DA5206E6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 10:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wbetMoRu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36DA5206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6tYU-0003Nb-Bk
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 05:04:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38477)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j6tXd-0002xW-4L
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 05:03:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j6tXb-0007c0-VG
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 05:03:44 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:39172)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j6tXb-0007Wh-NH
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 05:03:43 -0500
Received: by mail-oi1-x234.google.com with SMTP id 18so2439658oij.6
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 02:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IBROLuFPhqzKOPd8gyMxNRb9dw5nHSwIh9zOG5fnXsk=;
 b=wbetMoRuM1Wwsl+qrYWKuMKwCiTX6C0+V49Inh2/flIIYJLPOdzb/oy2pGLs5J79P/
 qloNBpRgyL6FKp6wwWWZh5A/pt+ZjpreyVmEcGTCsloOr4zDt1JXGtojbehVosBWR9Vt
 t0DxoJ5ksqOJw1FeBn8KxVhgwsur9LXwblRj3P99o/RnJvSyo7cS8Sfz9djlIF/bBI9r
 d+uOjt6ebR7TAjPQI0kYNL9m2UYb8FClsscqluKGpPexAFa/q2pbrliIgz9C0RadrpBG
 ogcvaeJq/qxYZOw0LBmEXcrtr0ccsl8udmsTWXnHCMNT4g/ftM+QGBCSX+aL9BAXqIJp
 U/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IBROLuFPhqzKOPd8gyMxNRb9dw5nHSwIh9zOG5fnXsk=;
 b=lMW2dZZuQ0BbqE8kYhip1tr9WTjnbGt2qXmc/wQ2MtnqEW9MgESIrG2UacY3v7q9Yf
 cHJ5+Y2QrxVV87omI0OqyWlTzwDFIzXXqmYeAs1zG49RPUzFSwz4lG8WMan0XCI1/Dy5
 crPtnHQpknvGnNW07hMjDbN1DHZjnJyJSxYpC1LbzAyFNLhjk/IGwnQdfb8bVC9M7kC4
 vJd5I6k5GwIxyiOoxni95v/wtSsfsX2D6Fxut+287gJwqHitWbQnkGth+uFNMhomqOCx
 yqXq4tBA0dHQdUcIdQ15fMUXEfH57J+SpAMRVBvssm/wVJcKZVLPkOtbWhLQGs93qyPh
 OWmA==
X-Gm-Message-State: APjAAAWRGLQ3q+BGi3eVRkyNOO0sEVpCm67spzAJ/+qb27fGy998PV+y
 DqEgoEQlfNak50Lje0oYWBVIMuJ81YmpBgn4lYFqmw==
X-Google-Smtp-Source: APXvYqyvTE3bOD/TXqFFEy762Uejykkx6jo6PwTKzEx0Q33nc7ax1P0rpCcADeqhHp9b3fhPEW59hshdmRO4poO5EcQ=
X-Received: by 2002:a54:4f16:: with SMTP id e22mr2524890oiy.170.1582711422423; 
 Wed, 26 Feb 2020 02:03:42 -0800 (PST)
MIME-Version: 1.0
References: <CAPan3Wq-MVwcJQELP8n+g33CR7tsiGXQ698gA177nd2my9hWCw@mail.gmail.com>
 <20200226101948.786be4b0@redhat.com>
In-Reply-To: <20200226101948.786be4b0@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 26 Feb 2020 10:03:31 +0000
Message-ID: <CAFEAcA80K+h-nkiHrh15mmgomBaqDpdhRwb34zwKqF31dp3KDw@mail.gmail.com>
Subject: Re: Sudden slowdown of ARM emulation in master
To: Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::234
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 26 Feb 2020 at 09:19, Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Wed, 26 Feb 2020 00:07:55 +0100
> Niek Linnenbank <nieklinnenbank@gmail.com> wrote:
>
> > Hello Igor and Paolo,
>
> does following hack solves issue?
>
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index a08ab11f65..ab2448c5aa 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -944,7 +944,7 @@ static inline size_t size_code_gen_buffer(size_t tb_size)
>          /* ??? If we relax the requirement that CONFIG_USER_ONLY use the
>             static buffer, we could size this on RESERVED_VA, on the text
>             segment size of the executable, or continue to use the default.  */
> -        tb_size = (unsigned long)(ram_size / 4);
> +        tb_size = MAX_CODE_GEN_BUFFER_SIZE;
>  #endif
>      }
>      if (tb_size < MIN_CODE_GEN_BUFFER_SIZE) {

Cc'ing Richard to ask: does it still make sense for TCG
to pick a codegen buffer size based on the guest RAM size?
(We should fix the regression anyway, but it surprised me
slightly to find a config detail of the guest machine being
used here.)

thanks
-- PMM

