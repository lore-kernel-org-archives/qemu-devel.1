Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318EEC76191
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 11:48:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02ABE22387
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 11:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O9JCl8jk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02ABE22387
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqFki-0001kl-5c
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 07:48:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33829)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hqFkW-0001K2-Dw
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 07:48:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hqFkV-0007N5-E6
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 07:48:00 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37397)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hqFkV-0007MP-5z
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 07:47:59 -0400
Received: by mail-wm1-x344.google.com with SMTP id f17so41323246wme.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2019 04:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=SeKvS4e35e36m2eWkzxcVA5Hxy3yWrVA7IZQtH7AaU0=;
 b=O9JCl8jkgrY7pVXYdtO06VhBIpw5lsQIKLj+WBZ+cl037lQL4vfEZId0X7fIdQTOHI
 U8wpxlMFNWv9pSdYTP8MiXzUEUqQ7haeoHYMAmmmOIPGCTaO3zJoelKP5B7LNPw2TWHk
 DWezswPexEexGr+EDck+05NXw0vqNkYTxlzT3/Fmbhbe0KXmiKXZbQkVQ8/yye7CrA94
 IdAVrIIAZyEY9uOnZhd6Vqf46wNBMTXh3kDOlrOtSxUXEsb4zt7tphkKAkL46H87oHVp
 HJfeqy4r/X9WsH7dq5FMA6ah15cTcgRpl67XxM+UXKfYYQ8si3mY2YdBjZCxSQf6HbMZ
 wUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=SeKvS4e35e36m2eWkzxcVA5Hxy3yWrVA7IZQtH7AaU0=;
 b=Pgwn2zk1hA4eNCMIhzCbiBnCvBNv7IwrZiydCeygM5VsRBkKgB2p1stph4Wz4h7dSl
 h51S+E6MMqkGTj8zh+Y7N6/3jUbdVwrAiKeYSKXHK/aCEXoed6ImkMhF1pr6KMjeVcH0
 wcIrYkFNG7TZPtb2/mpcb00xzIJSj4Qd9m81gyvqo9tpaQwg44JDqxyUzGWCR7Je8qBw
 jPpC4D33WRpJQUnOzp5fdoYHRfZvR6+VLlz+Ir76vwrAfV9tt0lvAX1P6lo2kohFfoj1
 tRI+q6TpIsC5u2XXc8ppj2Zd3jPMFaLwO+LYT6jp/Ono45HXq1WcTqKvimj+XmqVkteH
 4E9A==
X-Gm-Message-State: APjAAAWQnvhJD4ZUyZq79E0BAllqfnFy0JcQayxtS5O/NpJ3IdBgdQN7
 V0VIXpJ9+u2FL4OCdRALGKgvnfGZnmQ=
X-Google-Smtp-Source: APXvYqwqTe5ed8T67sM5xJkpTdDKV1OCFGacp51GB/VrYfVtWtWqle0goh9RArkyqdfWZsFBCzF+dg==
X-Received: by 2002:a1c:4b0b:: with SMTP id y11mr47625976wma.25.1563968877413; 
 Wed, 24 Jul 2019 04:47:57 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id h16sm46226815wrv.88.2019.07.24.04.47.56
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 24 Jul 2019 04:47:56 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 68C551FF87;
 Wed, 24 Jul 2019 12:47:56 +0100 (BST)
References: <20190719210326.15466-1-richard.henderson@linaro.org>
 <20190719210326.15466-5-richard.henderson@linaro.org>
User-agent: mu4e 1.3.3; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190719210326.15466-5-richard.henderson@linaro.org>
Date: Wed, 24 Jul 2019 12:47:56 +0100
Message-ID: <87d0hz1wnn.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH for-4.2 04/24] target/arm: Install ASIDs
 for short-form from EL1
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
Cc: peter.maydell@linaro.org, beata.michalska@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> This is less complex than the LPAE case, but still we now avoid the
> flush in case it is only the PROCID field that is changing.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/helper.c | 34 ++++++++++++++++++++++++----------
>  1 file changed, 24 insertions(+), 10 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 0f21a077de..1ed7c06313 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -551,17 +551,31 @@ static void fcse_write(CPUARMState *env, const ARMC=
PRegInfo *ri, uint64_t value)
>  static void contextidr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                               uint64_t value)
>  {
> -    ARMCPU *cpu =3D env_archcpu(env);
> -
> -    if (raw_read(env, ri) !=3D value && !arm_feature(env, ARM_FEATURE_PM=
SA)
> -        && !extended_addresses_enabled(env)) {
> -        /* For VMSA (when not using the LPAE long descriptor page table
> -         * format) this register includes the ASID, so do a TLB flush.
> -         * For PMSA it is purely a process ID and no action is needed.
> -         */
> -        tlb_flush(CPU(cpu));
> -    }
>      raw_write(env, ri, value);
> +
> +    /*
> +     * For VMSA (when not using the LPAE long descriptor page table form=
at)
> +     * this register includes the ASID.  For PMSA it is purely a process=
 ID
> +     * and no action is needed.
> +     */
> +    if (!arm_feature(env, ARM_FEATURE_PMSA) &&
> +        !extended_addresses_enabled(env)) {
> +        CPUState *cs =3D env_cpu(env);
> +        int asid =3D extract32(value, 0, 8);
> +        int idxmask;
> +
> +        switch (ri->secure) {
> +        case ARM_CP_SECSTATE_S:
> +            idxmask =3D ARMMMUIdxBit_S1SE1 | ARMMMUIdxBit_S1SE0;
> +            break;
> +        case ARM_CP_SECSTATE_NS:
> +            idxmask =3D ARMMMUIdxBit_S12NSE1 | ARMMMUIdxBit_S12NSE0;
> +            break;
> +        default:
> +            g_assert_not_reached();
> +        }
> +        tlb_set_asid_for_mmuidx(cs, asid, idxmask, 0);
> +    }
>  }
>
>  /* IS variants of TLB operations must affect all cores */


--
Alex Benn=C3=A9e

