Return-Path: <SRS0=nDBX=XQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53E6C49ED7
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 09:00:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57D6F2073F
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 09:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aUboXIAc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57D6F2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBbFM-0002wV-1Q
	for qemu-devel@archiver.kernel.org; Sat, 21 Sep 2019 05:00:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38573)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iBbEO-0002Ir-4Z
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 04:59:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iBbEM-00023n-Lk
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 04:59:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39446
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iBbCz-0001ZD-Sq
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 04:59:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1569056257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=nZP7iSd23tgch2qa52Pk26dO1viJ0auiAwhZFtvaKSg=;
 b=aUboXIAcNV8w9CDhgkeOd186jVd8ATyoTsuz1wT5Dv55Frbm9zdg/VqD6APMZzOi3kE75t
 T/RwSKDywxVnRRWbCHi27nqAjCyWiW441WLght3pGV1t2uGPoOFChiLmgtIJf6GugFucpz
 79tNz3kkHfsE5DC3Q3A/lF/7ybYYIog=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-xDkMP6hpPGC7mk8gAvkplg-1; Sat, 21 Sep 2019 04:57:33 -0400
Received: by mail-wm1-f72.google.com with SMTP id m6so2037747wmf.2
 for <qemu-devel@nongnu.org>; Sat, 21 Sep 2019 01:57:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pcvleAXVCp+oXaCu+wDA9AxnnL0ehlMgml+8kc3cALc=;
 b=mBy1/XnPqXNDiDnuerJI/IPaazSUp28eCUMsALwMY2PGXU/DecawU4ECuPQwW657wr
 5td+9u92iuaputmBDeIZQdWOJM4xQzuV1arqoT9ViZjgZg5RxO53uQhNPmnZLC9ZS0fb
 YWR6AIOCrMZW65fknUPOJd5fmwMMa+GpHBVurEV0IbbTA3TsR1xJqKGHenUgykm7qanZ
 UVraZB3zRNi4D9sSShH7KSDrvrPYYgkBuAYYRqSglGx3SlrJW2bO6Col7IoeWrJ64aH0
 +Cf0UfKtmIF+O4sfAGfBEgY3wKjmYeq5TB4VTimFfHCMtcvwjXoCL2WTCfT8sQ/wvJE7
 CVfg==
X-Gm-Message-State: APjAAAWduuWodB4zDRqO/KoT6lbfTEYtGyut2yOzY4zt0oDXR/IS3zyp
 bc0xCGX1yLyTa2z61V3cUU0lve+HadSGvFsc5ALlvHfSqpuu7V1tDAuWKFqnlx/pfRJaxbza1v/
 O8upXQhuw20efoDc=
X-Received: by 2002:a7b:cf12:: with SMTP id l18mr6972862wmg.25.1569056252435; 
 Sat, 21 Sep 2019 01:57:32 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwvCqj3AolWXlUIAvFuAYYQ42T7XXUvMxhvSyZfLpNj9VMFyvt3sdlejPBW8d6YO6zqMCF9UA==
X-Received: by 2002:a7b:cf12:: with SMTP id l18mr6972852wmg.25.1569056252279; 
 Sat, 21 Sep 2019 01:57:32 -0700 (PDT)
Received: from [192.168.1.40] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id w12sm6411406wrg.47.2019.09.21.01.57.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Sep 2019 01:57:31 -0700 (PDT)
Subject: Re: [PATCH 7/7] target/alpha: Tidy helper_fp_exc_raise_s
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190921043256.4575-1-richard.henderson@linaro.org>
 <20190921043256.4575-8-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <075b9290-ef5d-89fc-c6a0-481ab1baeac4@redhat.com>
Date: Sat, 21 Sep 2019 10:57:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190921043256.4575-8-richard.henderson@linaro.org>
Content-Language: en-US
X-MC-Unique: xDkMP6hpPGC7mk8gAvkplg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/21/19 6:32 AM, Richard Henderson wrote:
> Remove a redundant masking of ignore.  Once that's gone it is
> obvious that the system-mode inner test is redundant with the
> outer test.  Move the fpcr_exc_enable masking up and tidy.
>=20
> No functional change.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>  target/alpha/fpu_helper.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
>=20
> diff --git a/target/alpha/fpu_helper.c b/target/alpha/fpu_helper.c
> index 62a066d902..df8b58963b 100644
> --- a/target/alpha/fpu_helper.c
> +++ b/target/alpha/fpu_helper.c
> @@ -90,25 +90,18 @@ void helper_fp_exc_raise_s(CPUAlphaState *env, uint32=
_t ignore, uint32_t regno)
>      uint32_t exc =3D env->error_code & ~ignore;
>      if (exc) {
>          env->fpcr |=3D exc;
> -        exc &=3D ~ignore;
> -#ifdef CONFIG_USER_ONLY
> -        /*
> -         * In user mode, the kernel's software handler only
> -         * delivers a signal if the exception is enabled.
> -         */
> -        if (!(exc & env->fpcr_exc_enable)) {
> -            return;
> -        }
> -#else
> +        exc &=3D env->fpcr_exc_enable;
>          /*
>           * In system mode, the software handler gets invoked
>           * for any non-ignored exception.
> +         * In user mode, the kernel's software handler only
> +         * delivers a signal if the exception is enabled.
>           */
> +#ifdef CONFIG_USER_ONLY
>          if (!exc) {
>              return;
>          }
>  #endif
> -        exc &=3D env->fpcr_exc_enable;
>          fp_exc_raise1(env, GETPC(), exc, regno, EXC_M_SWC);
>      }
>  }
>=20


