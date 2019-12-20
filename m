Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E502AC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:37:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADBFE24687
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xBPtiOQm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADBFE24687
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiJPg-0003xn-Ph
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 09:37:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60901)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iiJ3d-0005J9-MG
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:15:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iiJ3c-0000CT-AG
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:15:09 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38528)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iiJ3b-00009T-OW
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 09:15:07 -0500
Received: by mail-wm1-x344.google.com with SMTP id u2so9384687wmc.3
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 06:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=sK71ZzdC0Xdg4oImE2x3EkUlnXucYhoEV5hIXb2aFBM=;
 b=xBPtiOQmOa8ce0sgop4hBXqusg8TLmJE3JvcNJvj84JcAbQEQKV2qLC1vXj1ehCRUG
 Egj4TSgLUoNZP4RsEnO8FDszyIsf62e5a47vdgyfa78TY+v42K9fIPabGbnZ6OgdDLXI
 /BFazpB/28So1IzSE4LVLpMfy2aJiwU0Dja6744uKRwU/wo84C/cVOlyWSXas/D+7j7f
 y//lD2hpLezzagYL/fkEQWOGnTaoKkkPNSKUtkQzwNcp9e+4k1POoiXJPx0Pfw4joGlV
 FrZ+sqf1czC0VoPMkC2fUkLjVL1JDS2vsgrYYTcReiOhR5juuqlJSbNHX62ZxTdfdjyT
 lqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=sK71ZzdC0Xdg4oImE2x3EkUlnXucYhoEV5hIXb2aFBM=;
 b=HPOfUs8c8MoucWbSud397xa8FlShGJmZYOucf+jSl9/qdIG0iE0uRnFEGljsN+z+YE
 dFoNMLkTxhxubGUaWanGzG6fomrn/X9n164eCoWsAybEG/zKpl3iG4wRbeYvyCBEu8kO
 rbd17XXC6+c5czV0NnBIsvIDpZC7Hb5HjnUcjcoYrV+CNsnHPh7a+Shv9qp3TyPbowZ0
 R/Dz6cfYi93AdN+huaY7ndBMOhqumyD5cS5XVTLr4dXlTnZTJbL3bv6/qP3nHwgyushW
 BHQQNU5DrYQYH2rW5daHmuPPBoL2alA5nKaGR+O02LA42mPCluhao4OcySzSqpJXjjyl
 hnMQ==
X-Gm-Message-State: APjAAAU8bCUkbuxlUMDa5J2jhIUhlI5qM1YxoFsKkpIHdplaMa//0pEc
 OwBI/cHQPDueKWWUYkMdACFdTA==
X-Google-Smtp-Source: APXvYqxq9E5MagbM9dz40HNpykcKND/58oG9ZbSuuYMSYQDGcSf2VTaXMhG7EpCF/w+hHwI1EXq1DQ==
X-Received: by 2002:a1c:a9c6:: with SMTP id
 s189mr17155793wme.151.1576851306342; 
 Fri, 20 Dec 2019 06:15:06 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a14sm10371202wrx.81.2019.12.20.06.15.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 06:15:05 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 74C821FF87;
 Fri, 20 Dec 2019 14:15:04 +0000 (GMT)
References: <20191216221158.29572-1-richard.henderson@linaro.org>
 <20191216221158.29572-2-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 01/28] target/xtensa: Use probe_access for itlb_hit_test
In-reply-to: <20191216221158.29572-2-richard.henderson@linaro.org>
Date: Fri, 20 Dec 2019 14:15:04 +0000
Message-ID: <878sn7dqxj.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Max Filippov <jcmvbkbc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> We don't actually need the result of the read, only to probe that the
> memory mapping exists.  This is exactly what probe_access does.
>
> This is also the only user of any cpu_ld*_code_ra function.
> Removing this allows the interface to be removed shortly.
>
> Acked-by: Max Filippov <jcmvbkbc@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/xtensa/mmu_helper.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/target/xtensa/mmu_helper.c b/target/xtensa/mmu_helper.c
> index f15bff306f..b01ff9399a 100644
> --- a/target/xtensa/mmu_helper.c
> +++ b/target/xtensa/mmu_helper.c
> @@ -63,10 +63,11 @@
>  void HELPER(itlb_hit_test)(CPUXtensaState *env, uint32_t vaddr)
>  {
>      /*
> -     * Attempt the memory load; we don't care about the result but
> +     * Probe the memory; we don't care about the result but
>       * only the side-effects (ie any MMU or other exception)
>       */
> -    cpu_ldub_code_ra(env, vaddr, GETPC());
> +    probe_access(env, vaddr, 1, MMU_INST_FETCH,
> +                 cpu_mmu_index(env, true), GETPC());
>  }
>=20=20
>  void HELPER(wsr_rasid)(CPUXtensaState *env, uint32_t v)


--=20
Alex Benn=C3=A9e

