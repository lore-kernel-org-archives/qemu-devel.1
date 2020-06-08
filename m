Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81162C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 19:43:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47DE82068D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 19:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OL+qxbLp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47DE82068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiNgM-0007BH-IG
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 15:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jiNfO-0006KC-4e
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 15:42:42 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:38387)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jiNfN-0003iP-6S
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 15:42:41 -0400
Received: by mail-pl1-x641.google.com with SMTP id m7so7066673plt.5
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 12:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=kR4X4nQrt8s0VeEPyMSy+BZ8jmyJmBfxjB/bXUbkqn0=;
 b=OL+qxbLpb9pD+9oXGegycN2dp5fikrcRFKvEt8ccy5Rq5HO0dlErmx57Oenv3Epe/u
 g8zsx5pjIoLN1UvQRzC6xG/hyQne57Lh54nB8B9hRRfKeOTKByi3vF6xVvKgOS0007AE
 gxoMe7d9vPI3spGJEWf1f7ch5N9hZb9fF+AjKui+1e3TjvpwMXUPW9HE+twsAAHXMes/
 aQxYPHxSk5yven6JoZjXYBb09yUBESCnE6B1uA56PNKD7DHIKszTt6w7OxLaTtUMtOmb
 sc92hiBdd9oYf94B2m7yj0RW6QYE3fWafMqcymXCIisTjmz29KIlaW8V5jTIAz+xKKu3
 dIFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kR4X4nQrt8s0VeEPyMSy+BZ8jmyJmBfxjB/bXUbkqn0=;
 b=cm2/RZaCH115tQNBSI35IPVRWsHX6RkmK4JhuSQ8/HHFOcO+OxbE5K1OUKuFxz7lad
 4J/HVizNnXHpv3Xa8kakLAUb7qoBEBBqYtXwyC5f6jQ0nm0qkX+eWly+bBdg8aqtKoVT
 ZD0Rvf+yh67u54OYywM/t+OOUjUnpJAFRtChZZVTGPs/l5BXrkYL0ldLL9AgPqTUpMfa
 9E7gxMpEOC38u5jwV81QEhbTZ20Z8t0NdLNzHOxzt7CmXLZ0LNotTByGDAW/DFtKRgqU
 n/vsCRW45/lIy2E6tLFXhcKVzdw788jJIIzlSzUntGeMxK8ZfvpTcPmrElx0cWj41mRK
 vjJw==
X-Gm-Message-State: AOAM5304R8F/vjEB5YO0vAkcVVgGDOmqeRuxMOAsSelNhldeHcE9MHkV
 olpcCSrbjiski+I4p2iRKvngYg==
X-Google-Smtp-Source: ABdhPJzOyxOk7BgBAhwjNkti3P1+JR4YO0HwSvjwx8cblfDYHfQPW/c/oLwY7utfkvHFqhERBVgIKg==
X-Received: by 2002:a17:90b:ece:: with SMTP id
 gz14mr824900pjb.93.1591645359627; 
 Mon, 08 Jun 2020 12:42:39 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id c2sm7935955pfi.71.2020.06.08.12.42.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2020 12:42:38 -0700 (PDT)
Subject: Re: [PATCH v2] hw/openrisc/openrisc_sim: Add assertion to silence GCC
 warning
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>,
 Eric Blake <eblake@redhat.com>
References: <20200608160611.16966-1-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9646f888-9e8f-b4f9-9aa0-bd3b0951a7e4@linaro.org>
Date: Mon, 8 Jun 2020 12:42:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200608160611.16966-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Jia Liu <proljc@gmail.com>, qemu-trivial@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, 1874073@bugs.launchpad.net,
 Christophe de Dinechin <dinechin@redhat.com>,
 Stafford Horne <shorne@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/8/20 9:06 AM, Philippe Mathieu-Daudé wrote:
> When compiling with GCC 10 (Fedora 32) using CFLAGS=-O2 we get:
> 
>     CC      or1k-softmmu/hw/openrisc/openrisc_sim.o
>   hw/openrisc/openrisc_sim.c: In function ‘openrisc_sim_init’:
>   hw/openrisc/openrisc_sim.c:87:42: error: ‘cpu_irqs[0]’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
>      87 |         sysbus_connect_irq(s, i, cpu_irqs[i][irq_pin]);
>         |                                  ~~~~~~~~^~~
> 
> While humans can tell smp_cpus will always be in the [1, 2] range,
> (openrisc_sim_machine_init sets mc->max_cpus = 2), the compiler
> can't.
> 
> Add an assertion to give the compiler a hint there's no use of
> uninitialized data.
> 
> Buglink: https://bugs.launchpad.net/qemu/+bug/1874073
> Reported-by: Martin Liška <mliska@suse.cz>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Tested-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> v2: Fixed typo in subject (eblake)
> Supersedes: <20200608071409.17024-1-philmd@redhat.com>
> ---
>  hw/openrisc/openrisc_sim.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

