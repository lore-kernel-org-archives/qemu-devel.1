Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A5BC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 21:56:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 538B920771
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 21:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dkx7V9rE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 538B920771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ2O4-00017q-Hl
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 17:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46931)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jJ2NN-0000Ds-Gp
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 17:55:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jJ2NM-0000HU-CB
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 17:55:21 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35136)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jJ2NL-0000H8-UU
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 17:55:20 -0400
Received: by mail-wm1-x342.google.com with SMTP id i19so500476wmb.0
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 14:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=aGMNm0JtWP3AxZQlXFns7pxLjat3ku2JNZsQzgAjdwk=;
 b=dkx7V9rElthmwetJKvNYtjWRQp7llsoReNx4huhPXSmKXXh0uYC7ynM3qttrs92YDG
 93Gybn/9xIsFvf3FwtP4xdwegTVOs9kpiSxZCIQNMu3MIJE7X6SqFwfAyV8Mih0HaCVO
 hEHsEdfXu0vKp0snXJ6bXewZ0Vnbyk69zo31cn1HwVwC2U8/CGP4Mj8XFLVyFjdrnTaa
 Lv9qAbvsrH+JXaxJwIsuXbigRasrt5h/WJOFxWU05eb7aL8oyJjsxj3pg56TBRWDi7Hx
 QznvVxxYpXIaah0cpzaPteHPto89nw4lFmxQf6IUYTT+WZCE8zaSHru6dp3CsmX119MW
 YQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=aGMNm0JtWP3AxZQlXFns7pxLjat3ku2JNZsQzgAjdwk=;
 b=NJY4siY7PFwc8Rr0TfH7Wl0F4LdCWESmG48GKaZP9v/cGZ4qxFgyO/2xIpV8IjLmlm
 PfirKmkxArszCnYeXs4g8U4f7Y8aulwM6oNN/emN2jJ/1c4wxqQnjq/4Mz/0U5TZhNo1
 pwuvGPIA3snwnzi6WWr3VVanbCSL2MZ4eYYmXPIkpDCkZr6Ee2m5GkR1ZQv3kNBJzfyV
 INGw4nzmS3dC5X6C81pcPI0+KWazqsnAfvXN+xFyklzjAmIIbo2zcyTgt48p/vxRc2WM
 +l8aGcOjFXsAeKqgub+LiELZJ4FGfDBQRJoWF6GIOxfkYe0BjzoCb10LbCOFkZGdc8lk
 gAUQ==
X-Gm-Message-State: ANhLgQ3iMYRIaWMd/gaOV1IaDudFzLuPwtC4hT0wCYxRdVvkJjoPPVZK
 16KK4zX1NRdSuvlgyYNeHSPuVQ==
X-Google-Smtp-Source: ADFU+vsAUXEXf5PQPQHhw1bj9hkU7mFQGLwGkxSJCxSzlEJzanOTJCGscXBJVg7wwdV7dvf13gNitA==
X-Received: by 2002:a05:600c:2101:: with SMTP id
 u1mr137062wml.177.1585605318672; 
 Mon, 30 Mar 2020 14:55:18 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a16sm1017958wmm.20.2020.03.30.14.55.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2020 14:55:17 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AB1B81FF7E;
 Mon, 30 Mar 2020 22:55:16 +0100 (BST)
References: <20200318062057.224953-1-scw@google.com>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Shu-Chun Weng <scw@google.com>
Subject: Re: [PATCH] Makes softmmu compile with clang at HEAD
In-reply-to: <20200318062057.224953-1-scw@google.com>
Date: Mon, 30 Mar 2020 22:55:16 +0100
Message-ID: <87r1x9fqyj.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Shu-Chun Weng <scw@google.com> writes:

> With clang at HEAD, linking fails with "undefined symbol:
> qemu_build_not_reached". It's because `store_helper` and
> `helper_ret_stb_mmu` are mutually recursive and clang inlined latter
> inside the former, making `store_helper` a recursive function and no
> longer fully inlineable preventing constant propogation.
>
> Signed-off-by: Shu-Chun Weng <scw@google.com>
> ---
>  accel/tcg/cputlb.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index e3b5750c3b..a7c812ed72 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -2050,6 +2050,7 @@ store_helper(CPUArchState *env, target_ulong addr, =
uint64_t val,
>      store_memop(haddr, val, op);
>  }
>=20=20
> +__attribute__((noinline))
>  void helper_ret_stb_mmu(CPUArchState *env, target_ulong addr, uint8_t va=
l,
>                          TCGMemOpIdx oi, uintptr_t retaddr)

Hmm I wonder if the correct fix is for store_helper to callL

  store_memop(addr + i, val8, MO_UB);

direct in the fallback case - although the page crossing may be tricky
to get right. Perhaps we should out of line all the unaligned stuff?


--=20
Alex Benn=C3=A9e

