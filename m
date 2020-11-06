Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4EBC2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 20:32:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16A4F20882
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 20:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="veMyDiMf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16A4F20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb8PX-00077o-Gb
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 15:32:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kb8Oj-0006ic-6n
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 15:31:49 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39960)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kb8Oh-0003Vc-8q
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 15:31:48 -0500
Received: by mail-wr1-x442.google.com with SMTP id 33so2614252wrl.7
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2020 12:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=KUljhgTZpx24Cozf4vDpjcO3unInS5X4aw0WCNYqUko=;
 b=veMyDiMferrQYGN21+xEcaJOrZwfW/XSH1HYUKO7KD1nLOfFW6ajGt2RM9EAqCkqr6
 HCz7D7O0+9c50R1EODaUihkbaOGpX0Vb23FTy8sZ+SCFaNsSvaVzZHPHf9/gPdwtEOJw
 4fA5WCJUbhh90XRnoP8VT2TBIiPPKOzgnqFKAyuFgOx37bHfl0QbukvTGl6KYrIRTTmg
 jgbSslOMO9zxPJdt+w9W6aqiXKGT94gWX2n9F5P6uBqR6AfsmbS4XloyAlsJcAGAvgnv
 yRjwaDsYTh5lDx+4FufisJ3g9QK5MB5/M5tQE8tECIyCioV6HbAHem3idBpiKre+fugr
 fqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=KUljhgTZpx24Cozf4vDpjcO3unInS5X4aw0WCNYqUko=;
 b=ntBHGyEmoZA+ANfzVf3yQJEEY4s21eyxXEwsYdT2xx8270tAysY0WcaNdh55Fyu50N
 I6sP/4EqPhpeyvQLxL6XKaR1YuCwkGWPmbQmTFIqTGu9QhsyTwkH+pfMaSErZksmTeXq
 WVa5SWE5y7YVFo6qT249SBIk8jNPYm61jx9AxP4KU6Y7IGnXNVzJ6+SiXEXvRMgO/W/E
 XF1zu4AgLtGHPR674JSiWarUmJFRrfzDolwZAEcSn4N2HTCu7+7Jue7VPnFCY59xdZMH
 s8lFnHik8cXLFuemQD1wA+7j3lvHmn4zSgbNHvOW9IulNKMA5OyTXfVFXJBqtMGDQAhU
 oFuw==
X-Gm-Message-State: AOAM5310wL+U5XnkPSPYReOitEex2QTl9q/n5HYWlnsJDk1NESDbvI4g
 xctAy9UCKh5E9iHXouS0U9d1aw==
X-Google-Smtp-Source: ABdhPJxgh9+E27gK2wlMbvbtuQ1TA0inPVWs2sOuj/t6u+fGQS20XTnZnWezNvYf3SW8zConfGOmwg==
X-Received: by 2002:adf:dc85:: with SMTP id r5mr4812994wrj.66.1604694705141;
 Fri, 06 Nov 2020 12:31:45 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a15sm3717613wrn.75.2020.11.06.12.31.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 12:31:43 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E45CB1FF7E;
 Fri,  6 Nov 2020 20:31:41 +0000 (GMT)
References: <20201106032921.600200-1-richard.henderson@linaro.org>
 <20201106032921.600200-2-richard.henderson@linaro.org>
User-agent: mu4e 1.5.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v3 01/41] tcg: Enhance flush_icache_range with separate
 data pointer
In-reply-to: <20201106032921.600200-2-richard.henderson@linaro.org>
Date: Fri, 06 Nov 2020 20:31:41 +0000
Message-ID: <87tuu28bwy.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: j@getutm.app, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> We are shortly going to have a split rw/rx jit buffer.  Depending
> on the host, we need to flush the dcache at the rw data pointer and
> flush the icache at the rx code pointer.
>
> For now, the two passed pointers are identical, so there is no
> effective change in behaviour.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/aarch64/tcg-target.h     |  9 +++++++--
>  tcg/arm/tcg-target.h         |  8 ++++++--
>  tcg/i386/tcg-target.h        |  3 ++-
>  tcg/mips/tcg-target.h        |  8 ++++++--
>  tcg/ppc/tcg-target.h         |  2 +-
>  tcg/riscv/tcg-target.h       |  8 ++++++--
>  tcg/s390/tcg-target.h        |  3 ++-
>  tcg/sparc/tcg-target.h       |  8 +++++---
>  tcg/tci/tcg-target.h         |  3 ++-
>  softmmu/physmem.c            |  9 ++++++++-
>  tcg/tcg.c                    |  6 ++++--
>  tcg/aarch64/tcg-target.c.inc |  2 +-
>  tcg/mips/tcg-target.c.inc    |  2 +-
>  tcg/ppc/tcg-target.c.inc     | 21 +++++++++++----------
>  tcg/sparc/tcg-target.c.inc   |  4 ++--
>  15 files changed, 64 insertions(+), 32 deletions(-)
>
> diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
> index 663dd0b95e..d0a6a059b7 100644
> --- a/tcg/aarch64/tcg-target.h
> +++ b/tcg/aarch64/tcg-target.h
> @@ -148,9 +148,14 @@ typedef enum {
>  #define TCG_TARGET_DEFAULT_MO (0)
>  #define TCG_TARGET_HAS_MEMORY_BSWAP     1
>=20=20
> -static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
> +/* Flush the dcache at RW, and the icache at RX, as necessary. */
> +static inline void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_=
t len)
>  {
> -    __builtin___clear_cache((char *)start, (char *)stop);
> +    /* TODO: Copy this from gcc to avoid 4 loops instead of 2. */

Why not do it now?

> +    if (rw !=3D rx) {
> +        __builtin___clear_cache((char *)rw, (char *)(rw + len));
> +    }
> +    __builtin___clear_cache((char *)rx, (char *)(rx + len));
>  }
>=20=20
<snip>
>=20=20
> -static inline void flush_icache_range(uintptr_t start, uintptr_t stop)
> +/* Flush the dcache at RW, and the icache at RX, as necessary. */
> +static inline void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_=
t len)
>  {
>  }

I take it i386 is just too primitive to care about flushing things?

Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

