Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A87EC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 18:08:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B5472068F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 18:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T0jCuaIC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B5472068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiMhm-0001HD-FK
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 13:08:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60041)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iiMct-0003CB-IE
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 13:03:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iiMcp-0001Nn-9a
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 13:03:47 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33617)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iiMcp-0001Ma-30
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 13:03:43 -0500
Received: by mail-wr1-x441.google.com with SMTP id b6so10311910wrq.0
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 10:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ZyyoS8xHYU8Pgl5ll8J6Ijsr+69DFyVzZsk+pOot/D0=;
 b=T0jCuaICZrr4ByV2B6BTDCk/3SEw9FJQ9xQOhI0c9kU+gQxpqvAk7IZrmGXYu1eNf1
 e44BwyVh9UjEDYplZNyFjaAT2hj+KHZySHzd4UsPMn3xYx/dD88HlO2dLvqvZ+2cTlAm
 6JSWsXA0YsjkvvDmjhT+zssJUDNzoV091WpWZOedWoUmJ9CO9crUpZXRK/6I+n0Wn5eA
 /mTAmLfhlugtwWj6/H2KQkTrKhIXWoeFrFzk7nv6F+PF/5Zi4AmcMwx1HCEtSDM52HR6
 xKrXc1ngXPrXa+Fewwewt2ej3f2++4QQKA46QAZ2riB9TflBx4wCmN+1ghczRUFuO/eY
 pumg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ZyyoS8xHYU8Pgl5ll8J6Ijsr+69DFyVzZsk+pOot/D0=;
 b=bjTTtVV2MXtk2hb3Yhx4kOU1KE2fYwx7lJxD+Rf8bh7tCgtQ7KR2IIj+2NCVSBD6Iv
 eWILXJDWTyGZLJkw3+q/QGsFftNqJVEdywrkUAe8MORa7HBZaD3CWZLXLdmxSSvEpX6u
 59TWgdn8c7KwqvjRSba5txEF1LyFFhvzFTORTV+m50s/QRWE7Nl4GFkLBBljzQ/BnI5e
 rtVtjKNry4MZVrjpvv1+KJB9OC2qwwNhn87/hocRb7tG/f1iwe3ANV3CtimA1aG1F3iw
 eI3D00HRyQCRo61f5KQswePc83tJc4Y5X+4e9/t/yZlTPEYXyug/fegdvOkkJHWN6r+G
 gOeA==
X-Gm-Message-State: APjAAAWakCALBBJvrMfxBX99b4CqYVqypOi+n5s4aFicexxcbmsrGH8N
 uoj/uotpkCFeJoYzcvtmvVNBIgzufwQ=
X-Google-Smtp-Source: APXvYqwYob8GDAJ0LSGzlHtcDV8owMkCXaBYarkFb6hvfups2TRXlRSCiIZbiif4F2JYT3CAhPkUmg==
X-Received: by 2002:a5d:4d4a:: with SMTP id a10mr16729591wru.220.1576865021999; 
 Fri, 20 Dec 2019 10:03:41 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a133sm10542350wme.29.2019.12.20.10.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 10:03:40 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 25BC81FF87;
 Fri, 20 Dec 2019 18:03:40 +0000 (GMT)
References: <20191216221158.29572-1-richard.henderson@linaro.org>
 <20191216221158.29572-22-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 21/28] target/unicore32: Remove MMU_MODE{0,1}_SUFFIX
In-reply-to: <20191216221158.29572-22-richard.henderson@linaro.org>
Date: Fri, 20 Dec 2019 18:03:40 +0000
Message-ID: <87pngic1s3.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> The functions generated by these macros are unused.
>
> Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/unicore32/cpu.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/target/unicore32/cpu.h b/target/unicore32/cpu.h
> index 50ed9dd99c..7a32e086ed 100644
> --- a/target/unicore32/cpu.h
> +++ b/target/unicore32/cpu.h
> @@ -133,8 +133,6 @@ void cpu_asr_write(CPUUniCore32State *env1, target_ul=
ong val, target_ulong mask)
>  int uc32_cpu_signal_handler(int host_signum, void *pinfo, void *puc);
>=20=20
>  /* MMU modes definitions */
> -#define MMU_MODE0_SUFFIX _kernel
> -#define MMU_MODE1_SUFFIX _user
>  #define MMU_USER_IDX 1
>  static inline int cpu_mmu_index(CPUUniCore32State *env, bool ifetch)
>  {


--=20
Alex Benn=C3=A9e

