Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D06FC3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 12:10:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0675A20857
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 12:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PGnprF3z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0675A20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j96NX-00062o-5f
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 07:10:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43773)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j96MU-0005BQ-B9
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 07:09:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j96MT-0004M3-6Y
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 07:09:22 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52223)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j96MS-0004LO-W0
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 07:09:21 -0500
Received: by mail-wm1-x344.google.com with SMTP id a132so2878060wme.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 04:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=0BfxLWi20bkAuDQyu9Wjmf+LLzCIRnG3eTeXFymdnhs=;
 b=PGnprF3zDF3T113i1sQZes1+PqefZDU05Tz00JED+k2IBZ4db9ogU13WWVggqDftCO
 mgKT38zdAtR09K7ymYyaqJSJ13AcsN9xwngBf7oncxW+/D4vQ/mHHlV3hNPxCa1atraf
 K2lEMSZGWz2V6KE9aOSYW1wY8E3BYnpwTqIviOsk6PeY7hjS/BQA+1u7RfvsLIq/zETc
 tzfBiN3nRJDWVRGIT9D6VjEp3dmQs9MNWHkDnGWAHXyPmv9VMSLcRQvmNLCQEaqAfX17
 bA4s8YUPSXZPMabZdU4UlvHS7glsD/brJsbYqPWW+0iukxocVKSgLwoww8YPJz4QbdZc
 N1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=0BfxLWi20bkAuDQyu9Wjmf+LLzCIRnG3eTeXFymdnhs=;
 b=nZUKgDe43vwcAsIYe/DGGYBMMYsbG9Xto73LQNA88TtVGS4xnBZG/UVT3M+tZMDuV9
 VO61EOw10SI8xr5zSSvrNLARc+hFLsOJ6BQU/3KVrgEbFZAUlZ4ZBqRk/WGT9p3N7fDC
 qwwForxbe1Tyz631ccnQabRkoN1/7TGafQkTnAuCJfbYaorPAUjppZ8VMPvMyg69HaTA
 bBFJJX39aKHtlHU5cFjS5Jnvr91KJdVFEQldEJdqIufKiRelilKENPY+7SXwCdY2Mq7+
 q5w37Ae4ldo+FE0PWlxZMkU7FlLTTKeLolt308Ks9m+5Sv9rM27ydBRH4dRCdKtC3ctA
 2nnQ==
X-Gm-Message-State: ANhLgQ0D22EzY+rdtJYQ+cshXYrkXxNuBCBxA9ygqK68FvqwPzKRHQpX
 knnj826ENh/ilcPP4SsaISBOIg==
X-Google-Smtp-Source: ADFU+vu2u223YP+lqV8OVn+3kIQL9dAmj1kBQnt6jaOwTdoZJNA004ASmTlV+tH7QKFgJH7QV6D8uw==
X-Received: by 2002:a1c:e206:: with SMTP id z6mr3829238wmg.141.1583237359199; 
 Tue, 03 Mar 2020 04:09:19 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g206sm3612077wme.46.2020.03.03.04.09.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2020 04:09:17 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 249621FF87;
 Tue,  3 Mar 2020 12:09:17 +0000 (GMT)
References: <20200301215029.15196-1-nieklinnenbank@gmail.com>
 <20200301215029.15196-7-nieklinnenbank@gmail.com>
User-agent: mu4e 1.3.9; emacs 27.0.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Niek Linnenbank <nieklinnenbank@gmail.com>
Subject: Re: [PATCH v6 06/18] hw/arm/allwinner: add CPU Configuration module
In-reply-to: <20200301215029.15196-7-nieklinnenbank@gmail.com>
Date: Tue, 03 Mar 2020 12:09:17 +0000
Message-ID: <87d09t7i8i.fsf@linaro.org>
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
Cc: peter.maydell@linaro.org, jasowang@redhat.com, qemu-devel@nongnu.org,
 b.galvani@gmail.com, qemu-arm@nongnu.org, imammedo@redhat.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Niek Linnenbank <nieklinnenbank@gmail.com> writes:

> Various Allwinner System on Chip designs contain multiple processors
> that can be configured and reset using the generic CPU Configuration
> module interface. This commit adds support for the Allwinner CPU
> configuration interface which emulates the following features:
>
>  * CPU reset
>  * CPU status
>
> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
<snip>
> +
> +/* CPUCFG constants */
> +enum {
> +    CPU_EXCEPTION_LEVEL_ON_RESET =3D 3, /* EL3 */
> +};
> +
> +static void allwinner_cpucfg_cpu_reset(AwCpuCfgState *s, uint8_t cpu_id)
> +{
> +    int ret;
> +
> +    trace_allwinner_cpucfg_cpu_reset(cpu_id, s->entry_addr);
> +
> +    ret =3D arm_set_cpu_on(cpu_id, s->entry_addr, 0,
> +                         CPU_EXCEPTION_LEVEL_ON_RESET, false);

According to the arm_set_cpu_on code:

    if (!target_aa64 && arm_feature(&target_cpu->env, ARM_FEATURE_AARCH64))=
 {
        /*
         * For now we don't support booting an AArch64 CPU in AArch32 mode
         * TODO: We should add this support later
         */
        qemu_log_mask(LOG_UNIMP,
                      "[ARM]%s: Starting AArch64 CPU %" PRId64
                      " in AArch32 mode is not supported yet\n",
                      __func__, cpuid);
        return QEMU_ARM_POWERCTL_INVALID_PARAM;
    }

Do you really want to reboot in aarch32 mode on a reset? If so we should
fix the TODO.

--=20
Alex Benn=C3=A9e

