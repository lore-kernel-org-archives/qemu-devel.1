Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B2FC31E50
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:13:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93D8D206B7
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gm2fBR8z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93D8D206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47898 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcsOO-0008FR-UM
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 10:13:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39331)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hcsJv-0003qP-PG
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:09:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hcsJt-0000SC-VK
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:09:15 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35467)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hcsJt-0000RU-N7
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:09:13 -0400
Received: by mail-wr1-x443.google.com with SMTP id m3so10145504wrv.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 07:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=mSEV5ypfh1DQV6YGsw46Sg1iqlVNWxjQ2jmjXWBCBGk=;
 b=gm2fBR8zXeyWAkDmV6exjuOO7J0yesZp2rRYZw8XlSu/ZedWCmq2Lb2S95KfVb0UxR
 ufZm5GORil7RO1lydKSNPwHLt1Do3cMXZ6PC0ANsJmgIvrxpYzAMIK78aBy8c1APQrq5
 K81+l46yUsyLzYdVzY+2ucdOHlXkCuda3QlFSSqTS0tLKVv5qvnES4zushXQln6Rxsjp
 P2q0qaAWzPzJ9rYmYngpoIZc4qgK7pBekqTEBlxG/4WA2C0y5KAZWftm7Vk1Ser2zjJg
 L7SoEnqPyaXthbnM86RIQPlbbAgedz8lOedqGjZGTBqFBL4k1P33We5yN+TevzpF5h37
 gEwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=mSEV5ypfh1DQV6YGsw46Sg1iqlVNWxjQ2jmjXWBCBGk=;
 b=jTEyALU4uH/g/1Z+S20Oc779aVeG/fTcbhgNx7gAnq2qhDBi3C2j/10efPi/WngCbT
 3Dh9pi++6NW0g6Htltd/avVJ6dLiZUHordQ7V526ff1e3/ZGhjpgaQZsmbqnJy2pDul3
 Pq2o7u2wPogj+a6AqBnUJ4Lyv3nBwMZE/rra3aDyTbwQeT83DKMG1U+bZVKdOQzallR8
 6++7LG2JLBN9V0/B6kwdaLhedompGri8cwROunAhsLIh82jJp8BNP6Hsx7pSJhRtn2qP
 kF7DfE1cdQZqGK3XurgR8o/Ylkq79GzRxKUoA/JAvpSWJ7RjOw9KM7fF5lzEUAKAyaaa
 6Eqw==
X-Gm-Message-State: APjAAAUxlBLV7fsuXWadreDDmhEAVexYpcPJjSiJXdh4jqBs+qUqt09R
 FUkdjiYB8rct/GPR4VyNIsTu2ZOn+PE=
X-Google-Smtp-Source: APXvYqyZ5dY9a8gj5B54IQjIc5umgdbkx1iLgvNB2tseVoJz3jMaKqqTiC5xchXXQNR52Uv+0STjvQ==
X-Received: by 2002:adf:f812:: with SMTP id s18mr10533537wrp.32.1560780552668; 
 Mon, 17 Jun 2019 07:09:12 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id r2sm11671761wme.30.2019.06.17.07.09.11
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 17 Jun 2019 07:09:12 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AEA121FF87;
 Mon, 17 Jun 2019 15:09:11 +0100 (BST)
References: <20190615154352.26824-1-philmd@redhat.com>
 <20190615154352.26824-12-philmd@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
In-reply-to: <20190615154352.26824-12-philmd@redhat.com>
Date: Mon, 17 Jun 2019 15:09:11 +0100
Message-ID: <87r27s9ud4.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 11/23] target/arm: Declare
 v7m_cpacr_pass() publicly
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> In the next commit we will move exception handling routines to
> v7m_helper, so this function will be called from 2 different
> files. Declare it inlined in the "internals.h" header.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/helper.c    | 19 -------------------
>  target/arm/internals.h | 21 +++++++++++++++++++++
>  2 files changed, 21 insertions(+), 19 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index cf76010ea1..5d05db84d3 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -7611,25 +7611,6 @@ uint32_t arm_phys_excp_target_el(CPUState *cs, uin=
t32_t excp_idx,
>      return target_el;
>  }
>
> -/*
> - * Return true if the v7M CPACR permits access to the FPU for the specif=
ied
> - * security state and privilege level.
> - */
> -static bool v7m_cpacr_pass(CPUARMState *env, bool is_secure, bool is_pri=
v)
> -{
> -    switch (extract32(env->v7m.cpacr[is_secure], 20, 2)) {
> -    case 0:
> -    case 2: /* UNPREDICTABLE: we treat like 0 */
> -        return false;
> -    case 1:
> -        return is_priv;
> -    case 3:
> -        return true;
> -    default:
> -        g_assert_not_reached();
> -    }
> -}
> -
>  /*
>   * What kind of stack write are we doing? This affects how exceptions
>   * generated during the stacking are treated.
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 04711b317a..1d15af3f8b 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -891,6 +891,27 @@ static inline uint32_t v7m_sp_limit(CPUARMState *env)
>      }
>  }
>
> +/**
> + * v7m_cpacr_pass:
> + * Return true if the v7M CPACR permits access to the FPU for the specif=
ied
> + * security state and privilege level.
> + */
> +static inline bool v7m_cpacr_pass(CPUARMState *env,
> +                                  bool is_secure, bool is_priv)
> +{
> +    switch (extract32(env->v7m.cpacr[is_secure], 20, 2)) {
> +    case 0:
> +    case 2: /* UNPREDICTABLE: we treat like 0 */
> +        return false;
> +    case 1:
> +        return is_priv;
> +    case 3:
> +        return true;
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
>  /**
>   * aarch32_mode_name(): Return name of the AArch32 CPU mode
>   * @psr: Program Status Register indicating CPU mode


--
Alex Benn=C3=A9e

