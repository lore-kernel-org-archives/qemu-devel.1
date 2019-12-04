Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E48C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 15:04:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 430752084F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 15:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QI/4ajX3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 430752084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icWCT-0002Gp-5r
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 10:04:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48538)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1icW9j-0008Lu-JI
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 10:01:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1icW9i-0001V0-5y
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 10:01:31 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52587)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1icW9h-0001R1-RY
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 10:01:30 -0500
Received: by mail-wm1-x341.google.com with SMTP id p9so45789wmc.2
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2019 07:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=OiZUIgVr3CPfXnJvv4HcHQtpjQifyqmFG3z0NTVB/uU=;
 b=QI/4ajX3yt1JqnhIAiZUjm8A7YAUiYYixdcUUyiGSclnCYF6Qz5YKDWYlXfUsXU2pJ
 4toeElW8CAJCyxGFTf6ZNHGDaz8F23QoqtAr+lcZEce22JuwiFE+JtUdzkJKvAph4VAy
 Leq+EjSi37+TnMnuFcBFGr4ITX3HK9eUajL5LVnYgxAuwXxwNzC8U27PjcyDxKri8L07
 W6m04vsiYhqDhOC/TbzGHiIqP1oxdOZyflsL/ki1nj/K39ccI8Gv0vl9Spnja+Zgs98I
 LLlvYwmU4cN+xRY4LY/Cco1VYptr+kvx45uAqdXHJV7Ii0/MGualr7F3RY7bc/dS+mr7
 BclA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=OiZUIgVr3CPfXnJvv4HcHQtpjQifyqmFG3z0NTVB/uU=;
 b=P2MHWZ08z9o06K4Q6aL5EvxKGDpnrr4awf4NPKPqqZxGUZJyhfTTyJmeOQ7WGPTr8j
 AeCG42n2R5C0gL2KpJHo3spMt/047nSNR8DMJZXwnztpkwzxF7rx/YlnvLUWHYmOIlHs
 svPimI3aG2UVyK23mc9HzXArr5dDHYWt+iAcT9WozPfZh6tcZxGE48JX/avF5+R0J+v8
 HeR39JKxMSGutqv3vSYkEUwbLnZrS8GxuST9folUFsRps33KmsQJviM3KRAKca2qZPGn
 2yp1SwxI+UU0wNZkY7df9VRSGNt1VWiQoL1Iuo+6fzyNY/GNO6EImJhCZSnu3YKzzMEX
 9WDQ==
X-Gm-Message-State: APjAAAXTwSumYZg81WrqYgyxYIFDmXU4ES4KNo1ZppkA1H15Zlp/qy2L
 K5sKSZTU1zaaGCzCWq04neRTug==
X-Google-Smtp-Source: APXvYqzc7AEU0BnWDB9Girurvlrh/idUsYACKuBbEkDlKhKB8p+0O39k5+S3x5BDpWbPotQZAvjWsA==
X-Received: by 2002:a1c:a984:: with SMTP id s126mr10619wme.146.1575471687907; 
 Wed, 04 Dec 2019 07:01:27 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m10sm8660965wrx.19.2019.12.04.07.01.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2019 07:01:26 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 265D21FF87;
 Wed,  4 Dec 2019 15:01:25 +0000 (GMT)
References: <20191203022937.1474-1-richard.henderson@linaro.org>
 <20191203022937.1474-23-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v4 22/40] target/arm: Update aa64_zva_access for EL2
In-reply-to: <20191203022937.1474-23-richard.henderson@linaro.org>
Date: Wed, 04 Dec 2019 15:01:25 +0000
Message-ID: <875ziw8796.fsf@linaro.org>
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> The comment that we don't support EL2 is somewhat out of date.
> Update to include checks against HCR_EL2.TDZ.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/helper.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 4f5e0b656c..ffa82b5509 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -4109,11 +4109,27 @@ static void tlbi_aa64_ipas2e1is_write(CPUARMState=
 *env, const ARMCPRegInfo *ri,
>  static CPAccessResult aa64_zva_access(CPUARMState *env, const ARMCPRegIn=
fo *ri,
>                                        bool isread)
>  {
> -    /* We don't implement EL2, so the only control on DC ZVA is the
> -     * bit in the SCTLR which can prohibit access for EL0.
> -     */
> -    if (arm_current_el(env) =3D=3D 0 && !(env->cp15.sctlr_el[1] & SCTLR_=
DZE)) {
> -        return CP_ACCESS_TRAP;
> +    int cur_el =3D arm_current_el(env);
> +
> +    if (cur_el < 2) {
> +        uint64_t hcr =3D arm_hcr_el2_eff(env);
> +
> +        if (cur_el =3D=3D 0) {
> +            if ((hcr & (HCR_E2H | HCR_TGE)) =3D=3D (HCR_E2H | HCR_TGE)) {
> +                if (!(env->cp15.sctlr_el[2] & SCTLR_DZE)) {
> +                    return CP_ACCESS_TRAP_EL2;
> +                }
> +            } else {
> +                if (!(env->cp15.sctlr_el[1] & SCTLR_DZE)) {
> +                    return CP_ACCESS_TRAP;
> +                }
> +                if (hcr & HCR_TDZ) {
> +                    return CP_ACCESS_TRAP_EL2;
> +                }
> +            }
> +        } else if (hcr & HCR_TDZ) {
> +            return CP_ACCESS_TRAP_EL2;
> +        }
>      }
>      return CP_ACCESS_OK;
>  }


--=20
Alex Benn=C3=A9e

