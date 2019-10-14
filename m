Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11A6ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:34:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B22BD20854
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K3J0+NHn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B22BD20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK4EL-0000BZ-Dd
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 13:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39509)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iK32X-0004EQ-9O
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:17:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iK32V-0006Jt-VY
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:17:45 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51768)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iK32V-0006Jc-PQ
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:17:43 -0400
Received: by mail-wm1-x341.google.com with SMTP id 7so17920417wme.1
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=oa6VR9l0CP02BagOZTmCYZbHtP2wRglnaHz77oXUTmI=;
 b=K3J0+NHnIB804RrDC7EY4jGyIvDzZs7VRj1NztGYtNlBeW5hixY6CSJGnMdCreDTWa
 YOrQFUxqMUdI+HONIXQQu8COzz+jsH9lk/wlQe9VSOYmjTTdrmUXZAlmgLGnzwKnszwl
 WNVBdA1xtxqbEaPFwRC4vxCw6woiZJ+Ri7TDSKwpw5+wR7g8NuRO1ckBy4ir7GzazU/p
 fOhAvoTe1ungIlNqFzFLBVerU+u7aOTBde1Bb7BVFKGbFcx1Z8PFJvquN8brvOfdXNn6
 IYszDCQiQ7BoLjhXUXM1/gUQSrsMV+leVjAItkdxrwh+QqY/Hch0MtZvzaK7NpCbzYAA
 gPJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=oa6VR9l0CP02BagOZTmCYZbHtP2wRglnaHz77oXUTmI=;
 b=n9YpujaJKupYEzX1PdgulviYXEuwspKCgj3aX35kQ4WG6rhtBUj5i7Borz0kL5rXkI
 VLrxjjFxf+5UlNWFhlEutFwEzNzch5/Ew8S1nr6OGHmwT+5LE7JsrZGrbXRI92BgTQgc
 aWO3WW9354prID4VwHMAUaEBsMte0/zKbOt7EWCsd4xnddIlG8i0NuvW7M/jebWL1EbG
 haMakSQogbNX3GU8jQqSwo9QoBgXz4bgqXEHbdYDRTzN8+6dvVmATf0DYRDf1KWLbByq
 iSHG0zKTSGutkfRVlC7jTbwajTyt94LdHAGo6lanurUPY+fRS5QJVr2IH2WzrJ+Juc9+
 F12w==
X-Gm-Message-State: APjAAAU9vo73zxLeyIZ8+ps2zhFJ3z6SRtfJi+YpJIxx0rnpVvZOjheg
 90XRcjjIqUguMnca0sayImLjRg==
X-Google-Smtp-Source: APXvYqw4tDmG6L73esuGmRzenU+8xfXxDRMUpw9jniK310x3B/lAsFa6S9sPDBm8wdumO7Ov5VxrEA==
X-Received: by 2002:a05:600c:29a:: with SMTP id
 26mr16706615wmk.127.1571069861017; 
 Mon, 14 Oct 2019 09:17:41 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n22sm12827903wmk.19.2019.10.14.09.17.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:17:40 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DB39A1FF87;
 Mon, 14 Oct 2019 17:17:39 +0100 (BST)
References: <20191011155546.14342-1-richard.henderson@linaro.org>
 <20191011155546.14342-8-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
Subject: Re: [PATCH v6 07/20] target/arm: Split out rebuild_hflags_a32
In-reply-to: <20191011155546.14342-8-richard.henderson@linaro.org>
Date: Mon, 14 Oct 2019 17:17:39 +0100
Message-ID: <87o8yjmhcs.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Currently a trivial wrapper for rebuild_hflags_common_32.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/helper.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 296a4b2232..d1cd54cc93 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -11106,6 +11106,12 @@ static uint32_t rebuild_hflags_m32(CPUARMState *=
env, int fp_el,
>      return rebuild_hflags_common_32(env, fp_el, mmu_idx, flags);
>  }
>
> +static uint32_t rebuild_hflags_a32(CPUARMState *env, int fp_el,
> +                                   ARMMMUIdx mmu_idx)
> +{
> +    return rebuild_hflags_common_32(env, fp_el, mmu_idx, 0);
> +}
> +
>  static uint32_t rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
>                                     ARMMMUIdx mmu_idx)
>  {
> @@ -11218,7 +11224,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, targe=
t_ulong *pc,
>                  flags =3D FIELD_DP32(flags, TBFLAG_A32, LSPACT, 1);
>              }
>          } else {
> -            flags =3D rebuild_hflags_common_32(env, fp_el, mmu_idx, 0);
> +            flags =3D rebuild_hflags_a32(env, fp_el, mmu_idx);
>          }
>
>          flags =3D FIELD_DP32(flags, TBFLAG_A32, THUMB, env->thumb);


--
Alex Benn=C3=A9e

