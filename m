Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D336BC43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 16:27:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9709A206DB
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 16:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eIw49PjJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9709A206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icXV2-0006uX-DH
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 11:27:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60582)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1icXFs-00057h-IP
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 11:11:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1icXFr-0004TP-8G
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 11:11:56 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41035)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1icXFq-0004Qw-27
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 11:11:55 -0500
Received: by mail-wr1-x441.google.com with SMTP id c9so2868491wrw.8
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2019 08:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ecq2Xvl+gCXXdLlelDcZXcDIY2/d4e/x0MvRTkrEgCk=;
 b=eIw49PjJ6BYSLeNOcYzTdZPVlU/OROvtTZs4gDKAUY1ijKbiOSPLpPbV3QSAYSxYcg
 GQOAvLilPoLoix9uN6w3LNen8e8FSFxP4A5CMOmeyopUmIA2bghE0gVr6TllPxfjNYSN
 aUPT5WnC7Uju+XuGPuTYvKd7l+LgV6KuQLZumeN9VfjQFvhDBYr2JMy1atjF5Km4Uwxe
 VqAtl3HS23PF9R1hVbmO+PPTohm1qGwiodXwSKstHVEzmKgaXc4YF/eyg76zicM6d1jG
 Vuup/1oPHwtu/4+cGHL1Mp+0ozZR0zRIQ6yHGHs97XXgtgapFarX4DxDKKm4aZbhSMk9
 D3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ecq2Xvl+gCXXdLlelDcZXcDIY2/d4e/x0MvRTkrEgCk=;
 b=OSvPHfwcVqixYOKpNNvKOfUxxjpEoVzM5QBF9dvqtg48hJ0KmlQhPqA8B2m8ieXCnB
 +lOW7JabD19g/PtjT2RMYphqAqNT0TrgDDXyxSveoI+xZ5qdQSEXf6vxOC9jfhbjZ8e8
 PwhudsJ3KgISxWJpNmCC4ctc8TzjgWi0cTZDYsPWoqzPhVQLbd67Q0fIL9SPp6IhG7Gb
 DgP+IT0TzwUkkZt20PVn3Y/PSZnFC8dnXuoBZBJT5PPMQVE85RquEW7eJ0ga7sKO1/0O
 aToJ+nHIcCSYr5/os+JUkGONIYM3ZkPD3BjGFDhvE2IA4d3GyeXIpNHmHv5Hzdcdg9Ji
 yFZw==
X-Gm-Message-State: APjAAAUSXmOjsQjW0Ou2wOSgifbdm2PNi4DgN4DKL0qHJwyeWKOmxxMY
 dnwhsLWbLz0di2VXd/iB2UvkMw==
X-Google-Smtp-Source: APXvYqxAuKpVhSJO+hz/UAIzDrke07uNCV2pe6xjelhqdiiAAoj2WLwnQrpp6odrxHvOAwgiihIzPw==
X-Received: by 2002:a05:6000:12:: with SMTP id
 h18mr4655531wrx.87.1575475908605; 
 Wed, 04 Dec 2019 08:11:48 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d12sm8621364wrp.62.2019.12.04.08.11.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2019 08:11:47 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A630C1FF87;
 Wed,  4 Dec 2019 16:11:46 +0000 (GMT)
References: <20191203022937.1474-1-richard.henderson@linaro.org>
 <20191203022937.1474-24-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v4 23/40] target/arm: Update ctr_el0_access for EL2
In-reply-to: <20191203022937.1474-24-richard.henderson@linaro.org>
Date: Wed, 04 Dec 2019 16:11:46 +0000
Message-ID: <87zhg86pfh.fsf@linaro.org>
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Update to include checks against HCR_EL2.TID2.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/helper.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index ffa82b5509..9ad5015d5c 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -5212,11 +5212,27 @@ static const ARMCPRegInfo el3_cp_reginfo[] =3D {
>  static CPAccessResult ctr_el0_access(CPUARMState *env, const ARMCPRegInf=
o *ri,
>                                       bool isread)
>  {
> -    /* Only accessible in EL0 if SCTLR.UCT is set (and only in AArch64,
> -     * but the AArch32 CTR has its own reginfo struct)
> -     */
> -    if (arm_current_el(env) =3D=3D 0 && !(env->cp15.sctlr_el[1] & SCTLR_=
UCT)) {
> -        return CP_ACCESS_TRAP;
> +    int cur_el =3D arm_current_el(env);
> +
> +    if (cur_el < 2) {
> +        uint64_t hcr =3D arm_hcr_el2_eff(env);
> +
> +        if (cur_el =3D=3D 0) {
> +            if ((hcr & (HCR_E2H | HCR_TGE)) =3D=3D (HCR_E2H | HCR_TGE)) {
> +                if (!(env->cp15.sctlr_el[2] & SCTLR_UCT)) {
> +                    return CP_ACCESS_TRAP_EL2;
> +                }
> +            } else {
> +                if (!(env->cp15.sctlr_el[1] & SCTLR_UCT)) {
> +                    return CP_ACCESS_TRAP;
> +                }
> +                if (hcr & HCR_TID2) {
> +                    return CP_ACCESS_TRAP_EL2;
> +                }
> +            }
> +        } else if (hcr & HCR_TID2) {
> +            return CP_ACCESS_TRAP_EL2;
> +        }
>      }
>      return CP_ACCESS_OK;
>  }


--=20
Alex Benn=C3=A9e

