Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0094DC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 13:37:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD270207DF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 13:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZOio9+35"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD270207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBeZD-0002fM-Th
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 09:37:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36012)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBeYK-0001kd-Gu
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 09:36:24 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:40749)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBeYI-00074d-LA
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 09:36:24 -0400
Received: by mail-pj1-x1043.google.com with SMTP id kx11so510291pjb.5
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 06:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=tFSSgs9QRwmKeuCKPJUn4j6hT0jhHfFpLFIOY65jDc4=;
 b=ZOio9+35BLRQTASsqD7BM6QeuGOWsxTyOjIVIldshVlCaGjPpOA/CD+30YI7489J/x
 3lnN1WBInxZ6UeZdffzFand0Vv8V7LPGkLHG7WQ5SNcOcoGm3pmwPx03pnL6VdUgh+4i
 A16b+KCTNWSJo92EOrKXA1SieKP+f7hlFQ3Lx+TzCNRrcQCtFmyhOrx1b1BavZLPoPpc
 Gjj6fYH7i/yz6+O95cgTn2LIFjhse4EdtZrx74HwCfGuUTJKjcISvHVXXk3V8L5KdLO5
 IHaK7Hxh9VfBw4lAl72tkp/+3+Sbjbc4ryUpnrJxbUsmD58iWaOwZoufTuchh3l2wOUS
 kc4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tFSSgs9QRwmKeuCKPJUn4j6hT0jhHfFpLFIOY65jDc4=;
 b=mYkNH6cxUIiLMCCrQg2Kt7dvZIfUATYuzWW/7hQiv0OrJg5ZA0jS70xxo4ol0XeV8Y
 uMsltYYw5E8SXyRqJzSuzOmYXwEGL92Ikxjn6tKIt3A/y1EoxKK3BxOZrQRVVnQVhpUv
 O5/QaadqIWAaIwHeS815Up02Co1jHqtOe9cz0CqO7gRs5uupBBgAUhVGFLntrz1fVZhp
 mG8LwXVLc7E4BZF9nWOiO8xvmNm1MbjnjMa6HXSB22HL36EcmBdXBEEWnLUvEyRzuLY1
 Cg3ek8vSWuDQGu+2g11K7hHHObvB+mscFfA3X2fPP3WsKQJ+Cd+SJIN6ZUeE28iDt+Jg
 SQNw==
X-Gm-Message-State: AOAM533AEKl6loIfUN2I57WWZEDmlfxj54kciBb+Mvz4IWL5Kkjvt9mB
 KJ98So+oWhy9TtLYQSVkNRyQSnAIR3Y/mg==
X-Google-Smtp-Source: ABdhPJw6tgOMzJcCYss1Q0f5eq0D+pE9hJuCTxAtYA+5q7PP8FUZZhMa+JPS3Znv+dKHoMD8kLRS0w==
X-Received: by 2002:a17:90a:630c:: with SMTP id
 e12mr1222289pjj.17.1598621780771; 
 Fri, 28 Aug 2020 06:36:20 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 37sm1448909pjo.8.2020.08.28.06.36.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2020 06:36:19 -0700 (PDT)
Subject: Re: [PATCH 00/77] target/microblaze improvements
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
 <20200827091128.GK2954729@toto>
 <1628c0ac-db22-ef9d-22e2-6a167ceaaf55@linaro.org>
 <20200827102217.GN2954729@toto>
 <5a787d85-a75f-60cf-0c99-a40c84222b35@linaro.org>
 <20200827170948.GO2954729@toto>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f555646c-f725-1328-7e42-75d4047a4e9a@linaro.org>
Date: Fri, 28 Aug 2020 06:36:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200827170948.GO2954729@toto>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.809,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/27/20 10:09 AM, Edgar E. Iglesias wrote:
> It seems to be getting out of sync when getting a slave-error and the core
> is not setup to take exceptions for slave errors. Looks like a pre-existing
> bug where we're restoring CPU state without taking the exception.
> The following fixes that particular case in my runs.
> 
> 
> I'm on a backported QEMU 5.1 so thing may look different in master.
> 
> diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
> index 831ff2cac1..0cae51c2df 100644
> --- a/target/microblaze/op_helper.c
> +++ b/target/microblaze/op_helper.c
> @@ -432,22 +432,19 @@ void mb_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
>      cpu = MICROBLAZE_CPU(cs);
>      env = &cpu->env;
>  
> -    cpu_restore_state(cs, retaddr, true);
> -    if (!(env->msr & MSR_EE)) {
> +    if (!cpu->cfg.iopb_bus_exception || !(env->msr & MSR_EE)) {
>          return;
>      }
>  
> +    cpu_restore_state(cs, retaddr, true);
> +
>      env->ear = addr;
>      if (access_type == MMU_INST_FETCH) {
> -        if ((env->pvr.regs[2] & PVR2_IOPB_BUS_EXC_MASK)) {
> -            env->esr = ESR_EC_INSN_BUS;
> -            helper_raise_exception(env, EXCP_HW_EXCP);
> -        }
> +        env->esr = ESR_EC_INSN_BUS;
> +        helper_raise_exception(env, EXCP_HW_EXCP);
>      } else {
> -        if ((env->pvr.regs[2] & PVR2_DOPB_BUS_EXC_MASK)) {
> -            env->esr = ESR_EC_DATA_BUS;
> -            helper_raise_exception(env, EXCP_HW_EXCP);
> -        }
> +        env->esr = ESR_EC_DATA_BUS;
> +        helper_raise_exception(env, EXCP_HW_EXCP);
>      }
>  }

Thanks for the pointer.  I've re-written this section to use
cpu_loop_exit_restore(), so that the restore is at the end.  The new patch will
appear in v2, just before iflags is added to the restore state.


r~

