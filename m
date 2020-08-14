Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C94C433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 20:28:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CAB720768
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 20:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WLK22fdB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CAB720768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6gJi-0004PA-OX
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 16:28:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6gJA-00040F-IL
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 16:28:12 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:35498)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6gJ8-0003DT-I7
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 16:28:12 -0400
Received: by mail-pf1-x444.google.com with SMTP id d188so5099516pfd.2
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 13:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=kKLajZI4hlGVxUQEVf4leCRp3CMdnb20DEZyyj3olRM=;
 b=WLK22fdB8a/4w45aZx8VtsAayNuX2+YAx34Rg7pCmY6SyhmP2be2gZThDO7SCCoYjE
 A6NpHebNQ7FtXe1kkhrYUOW0MYDQ8blOgPPg9r9HjCh0Ekp44jGWncWv9OmLYKu0jxBk
 FUacvj0N2nxUBCJRYj9VD0+yx4o0DJ1Z5fWF7ew517zMB2faKHXemmQ+50lIkzkx4uhi
 FLyfyKhpRxYpCMPzInh7nyzHZRp1kLLURU0TRI1wiiXfeeNCPWw6XULi/laauZqgSGA+
 WyV8AHvNlU1mEApR51d5bLU14u/F3m5zRyVf2NC+7Jt94ynhcJ4Acj8dE+Mks0Q7dVDM
 /+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kKLajZI4hlGVxUQEVf4leCRp3CMdnb20DEZyyj3olRM=;
 b=QfjrfU8ojFsm1HIZjU5laelKMofnu1EjLLLXsZtDDHQrouh9fXB5wd2n/zR0JX7+a6
 7VQNadLX7SgIHgNT4in0SzjEmHwFK50I/I1yHtAUucQWHNJwpqKnk9roFjHCdPbYXwIU
 SrhnK45TlMXgZ10f9Q1bvDB/DehdUCanJXNxHxTUlxXbM3mdk14n6iixz+8MW7QL/nAQ
 eRuP2PvEV9Y9ly6nfii7Oo4fnqpZgi5o3fEM9+B1XLl2u8RRfhpEgN/prSdDaB/CdhTa
 IU+dNBOapSb7DxFt+hICh9cp1vIk751uWdLe7k+h0ej29tDw3fjl4P+GeEleaUpFZoJC
 dXYg==
X-Gm-Message-State: AOAM530s5FVCDzaaTmlGugQK6Igh5awnUzoij+ItJf6fEVv5DycYTtgd
 13lrHZwEKYSXWXBCLFOfb3D7+Q==
X-Google-Smtp-Source: ABdhPJwt74lwHPRcWiH0reU6+7JRqOwRcWMRpKRZ8tJkf+Pe6vfRhf7wxC9twDpfYGZlMZewg6e3cQ==
X-Received: by 2002:a63:f44d:: with SMTP id p13mr2764509pgk.363.1597436889103; 
 Fri, 14 Aug 2020 13:28:09 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id b23sm9922364pfo.12.2020.08.14.13.28.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 13:28:08 -0700 (PDT)
Subject: Re: [PATCH v5 02/14] cpus: prepare new CpusAccel cpu accelerator
 interface
To: Claudio Fontana <cfontana@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>
References: <20200812183250.9221-1-cfontana@suse.de>
 <20200812183250.9221-3-cfontana@suse.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <83d22792-b436-1332-9457-1110b758f183@linaro.org>
Date: Fri, 14 Aug 2020 13:28:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200812183250.9221-3-cfontana@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Wenchao Wang <wenchao.wang@intel.com>,
 haxm-team@intel.com, Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <rth@twiddle.net>, Colin Xu <colin.xu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/12/20 11:32 AM, Claudio Fontana wrote:
>  uint64_t cpu_get_tsc(CPUX86State *env)
>  {
> -    return cpu_get_ticks();
> +    return cpus_get_elapsed_ticks();

What has this change got to do with creating the interface?
You said the interface wasn't used yet...


> diff --git a/stubs/cpu-synchronize-state.c b/stubs/cpu-synchronize-state.c
> new file mode 100644
> index 0000000000..3112fe439d
> --- /dev/null
> +++ b/stubs/cpu-synchronize-state.c
> @@ -0,0 +1,15 @@
> +#include "qemu/osdep.h"
> +#include "sysemu/hw_accel.h"
> +
> +void cpu_synchronize_state(CPUState *cpu)
> +{
> +}
> +void cpu_synchronize_post_reset(CPUState *cpu)
> +{
> +}
> +void cpu_synchronize_post_init(CPUState *cpu)
> +{
> +}
> +void cpu_synchronize_pre_loadvm(CPUState *cpu)
> +{
> +}
> diff --git a/stubs/cpus-get-virtual-clock.c b/stubs/cpus-get-virtual-clock.c
> new file mode 100644
> index 0000000000..fd447d53f3
> --- /dev/null
> +++ b/stubs/cpus-get-virtual-clock.c
> @@ -0,0 +1,8 @@
> +#include "qemu/osdep.h"
> +#include "sysemu/cpu-timers.h"
> +#include "qemu/main-loop.h"
> +
> +int64_t cpus_get_virtual_clock(void)
> +{
> +    return cpu_get_clock();
> +}

How do these stubs get used?


r~

