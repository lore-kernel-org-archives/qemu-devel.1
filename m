Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B33C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 14:10:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FF5E206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 14:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AJJM92St"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FF5E206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idEJY-00042L-Jc
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 09:10:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55968)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1idEHP-0002Fu-9V
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:08:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1idEHJ-0000Q9-T3
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:08:23 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:34003)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1idEHJ-0000Ne-Mb
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:08:17 -0500
Received: by mail-ot1-x344.google.com with SMTP id a15so5903013otf.1
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 06:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Z4sjm9mq9FY1JBwtvKmdYT9ZZ3hKV67Tyf1BR1lTeOw=;
 b=AJJM92Stp3S2lj/sjdyQGY67jSbm4ayYNuhm+4rMSqhS+SxxZ0jVZBd+msHmLexoOt
 aCb+ZxRMrv7QDsxMWKNRjwQUvO38T7acJV9hrbLlqVCPnQJ1OWej+5QVtfYFWGfJRWEJ
 6LVkRgNX76UARx7ldyaLVcKW8Fndqx6MI46tBRF1v1IC7AW9v4TBVgJp/ppWUB9H/Soc
 eqFugjPqzJuyI0uPwlRbWIQZDbuJDYf0mPoAKH/ij+wthkjaYHWL/PvyLPoHvc9wln0A
 7Rg76dLYORAX2AeWENSIp+Qntw7/U4voMoQhPyean5OjozqURNsvUwmU2ic3F8eW+uvF
 qB5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Z4sjm9mq9FY1JBwtvKmdYT9ZZ3hKV67Tyf1BR1lTeOw=;
 b=qFMt2us/ycPaVztyitF5UbA6APY0iiWW92Sjw4Q3dsP65pi7xV2svG2jUV1/az3jZJ
 OWW/up71dnCGqtMmMZ88bPeRlg2p3vF+VyUHEXRLE0flifNgdH/keZ7HMY2IizJTGcsm
 pheDk+VVTy/hoNFNS9OhlGC0WosiTD4FtrXQAfNiux8zDwZRYZbPfvh5G7shUVQcsXsJ
 JiXIWyNRLke0589k1+T0hbBEI21lRZYGEJG+R/S/W3YTlEmPD/magwvteC2bkEqNGebd
 zwHFmLjt4QYnc7OrtXRalTRd53LiM5sUe0ovRFiXh7AITUjngYA4h1EI9S/odnDhaOh/
 6LCA==
X-Gm-Message-State: APjAAAXvWD7L5PAJEnwDn3OAduFJA1ltnmS0eWYs0mgjim2HKGAO1iqv
 jfmaIl+b16GHLMz/Xz5rEfV4Jcx0amR3B24TFm8yvQ==
X-Google-Smtp-Source: APXvYqzrntCeRcECAGynjuKrNAr6W6c2Hv0/aLo/VBA8L6c6DdqsRKy6xQLvd3B8HvJ18ed7kqpkT04yFIhqFwu9zqY=
X-Received: by 2002:a05:6830:13d3:: with SMTP id
 e19mr11191067otq.135.1575641296875; 
 Fri, 06 Dec 2019 06:08:16 -0800 (PST)
MIME-Version: 1.0
References: <20191201122018.25808-1-maz@kernel.org>
 <20191201122018.25808-4-maz@kernel.org>
In-Reply-To: <20191201122018.25808-4-maz@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2019 14:08:06 +0000
Message-ID: <CAFEAcA_YGBXY4X5KYE_xny1bYtP1fKefT+VubmNYbe8TxdwBOw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] target/arm: Handle trapping to EL2 of AArch32 VMRS
 instructions
To: Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, kvmarm@lists.cs.columbia.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 1 Dec 2019 at 12:20, Marc Zyngier <maz@kernel.org> wrote:
>
> HCR_EL2.TID3 requires that AArch32 reads of MVFR[012] are trapped to
> EL2, and HCR_EL2.TID0 does the same for reads of FPSID.
> In order to handle this, introduce a new TCG helper function that
> checks for these control bits before executing the VMRC instruction.
>
> Tested with a hacked-up version of KVM/arm64 that sets the control
> bits for 32bit guests.
>
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  target/arm/helper-a64.h        |  2 ++
>  target/arm/translate-vfp.inc.c | 18 +++++++++++++++---
>  target/arm/vfp_helper.c        | 29 +++++++++++++++++++++++++++++
>  3 files changed, 46 insertions(+), 3 deletions(-)
>
> diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
> index a915c1247f..0af44dc814 100644
> --- a/target/arm/helper-a64.h
> +++ b/target/arm/helper-a64.h
> @@ -102,3 +102,5 @@ DEF_HELPER_FLAGS_3(autda, TCG_CALL_NO_WG, i64, env, i64, i64)
>  DEF_HELPER_FLAGS_3(autdb, TCG_CALL_NO_WG, i64, env, i64, i64)
>  DEF_HELPER_FLAGS_2(xpaci, TCG_CALL_NO_RWG_SE, i64, env, i64)
>  DEF_HELPER_FLAGS_2(xpacd, TCG_CALL_NO_RWG_SE, i64, env, i64)
> +
> +DEF_HELPER_3(check_hcr_el2_trap, void, env, i32, i32)

This has to be in helper.h, not helper-a64.h, otherwise
the arm-softmmu target won't build. helper-a64.h is for
helper functions which only exist in the aarch64 binary.

thanks
-- PMM

