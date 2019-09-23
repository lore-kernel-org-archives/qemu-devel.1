Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52263C4CEC4
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 16:57:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BE8F20882
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 16:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iGhRGSur"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BE8F20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCRe1-0004bq-MF
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 12:57:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34030)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iCRN5-0005e0-6n
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:39:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iCRN3-0003sQ-3h
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:39:31 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38417)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iCRN1-0003ru-6M
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:39:27 -0400
Received: by mail-wr1-x443.google.com with SMTP id l11so14738264wrx.5
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 09:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=IFm5yY/29subTcXqJqo4PofXOnZaqQJjrhJJ/cRg9L0=;
 b=iGhRGSurAHgp+Xt5KOPkzdcMRjMoIBWY4G8hdyqMRHdyQD2CdWGYZYVVP3J/F+SgSL
 UvF0sARis5/1hoIHmmkO6Ox7MZ+I05EbqFmBrn0W/mkkPf3nv5XDOMcBAVCbgzhYbOIu
 ehAN5ZbmkIBRrriBILCkYUIsbnYyBXl0bwM2MR6p23Alyb2kthCSZR13c0u8I1HnNPWC
 Aom6wZa3a2W4YgwHwwwFxs+EJKQpxgIq+bPl8UF99Dqn90GIqWQMSl0PEGVEiFETHAmw
 w7hZKJKjS6iKf8UkmW7DRSgS2KnOwJnKengl6xKyJFn+U3HKov0kWRQTTBM0to2bevp9
 ppAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=IFm5yY/29subTcXqJqo4PofXOnZaqQJjrhJJ/cRg9L0=;
 b=KU7+EoeOf7e38JZdSxXgGh+NyiIcZ+hH5axitxN9tS8i517IjCuw8d17vvLjJjcxRO
 bB90kOmxinNM+6CLQ/0Pop48mca3WsO/9sMvLrho+bAUKxlzG2LY33r4Dg8v+r9iSrpE
 7WeUtJuWo6k+NoG1Oy5/uYltVfgfOaQ2ASjZ2vTVlV3CAhyfLXWSMtXQHRXGkWfd7Vfe
 DSlFuXnUiaZQcXPTyxMPMflYZM/GB4wvMaNPTPDwQ0GBYD1nqNN52bUs08FLmqY2DiuQ
 i000cyi7E2WRndjJswSkGgSS5k6ZepgwaQxRJVnUbAUvSb5ls/of0ySBuT6yE9s1A8Rp
 Xe/A==
X-Gm-Message-State: APjAAAXz26n46yn9zpepMPCVjZAc04DfieY+dd7dBax6ZemTg95LGKow
 m1MAkVX0NPO0awbW+Neb4z6U+g==
X-Google-Smtp-Source: APXvYqyZWR+1p7gZdNG/px3snHwUUMeTPxppappGWh6qyOkyugsJH5ToskVz5VvSf3Dk8SZoV7MHXQ==
X-Received: by 2002:a05:6000:a:: with SMTP id h10mr273296wrx.226.1569256765830; 
 Mon, 23 Sep 2019 09:39:25 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v7sm12833502wru.87.2019.09.23.09.39.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2019 09:39:25 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 81FEE1FF87;
 Mon, 23 Sep 2019 17:39:24 +0100 (BST)
References: <20190921043256.4575-1-richard.henderson@linaro.org>
 <20190921043256.4575-7-richard.henderson@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 6/7] target/alpha: Mask IOV exception with INV for
 user-only
In-reply-to: <20190921043256.4575-7-richard.henderson@linaro.org>
Date: Mon, 23 Sep 2019 17:39:24 +0100
Message-ID: <87muevarwj.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> The kernel masks the integer overflow exception with the
> software invalid exception mask.  Include IOV in the set
> of exception bits masked by fpcr_exc_enable.
>
> Fixes the new float_convs test.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/alpha/helper.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/target/alpha/helper.c b/target/alpha/helper.c
> index 1b3479738b..55d7274d94 100644
> --- a/target/alpha/helper.c
> +++ b/target/alpha/helper.c
> @@ -58,6 +58,13 @@ void cpu_alpha_store_fpcr(CPUAlphaState *env, uint64_t=
 val)
>       */
>      uint32_t soft_fpcr =3D alpha_ieee_swcr_to_fpcr(env->swcr) >> 32;
>      fpcr |=3D soft_fpcr & (FPCR_STATUS_MASK | FPCR_DNZ);
> +
> +    /*
> +     * The IOV exception is disabled by the kernel with SWCR_TRAP_ENABLE=
_INV,
> +     * which got mapped by alpha_ieee_swcr_to_fpcr to FPCR_INVD.
> +     * Add FPCR_IOV to fpcr_exc_enable so that it is handled identically.
> +     */
> +    t |=3D CONVERT_BIT(soft_fpcr, FPCR_INVD, FPCR_IOV);
>  #endif
>
>      t |=3D CONVERT_BIT(fpcr, FPCR_INED, FPCR_INE);


--
Alex Benn=C3=A9e

