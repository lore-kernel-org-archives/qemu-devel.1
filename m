Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DF6C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 16:45:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF9232067C
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 16:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MF1zwCQP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF9232067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD9Pg-0006ym-UG
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 12:45:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kD9Os-0005zL-Am
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 12:44:50 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b]:39315)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kD9Oq-0001pN-Ir
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 12:44:49 -0400
Received: by mail-pl1-x62b.google.com with SMTP id x18so813993pll.6
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 09:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=AT0m4gk5vKwNemNRUnmoZuxnPRp5iXTqLQNHSdaZKkI=;
 b=MF1zwCQP8J6h8/KwNTuVWDZ0XdfT4Y86E9/KRnlHJxQqD+1vQ1avEUb62zeo/VWXu4
 h/GrtgBqoqBBAWXeXV9gq/z52zZXq5DUkp+0pSPKJrU2/Mz2O8ubzJJIqLajBv8wWBp/
 qqPKJWmMZsBxG83OfR8y4+QR7UI1s08bIF/mFbrgkK7F8xwxGS3z+SbJIx906m87G+2D
 MtitvVY9++Ksy9FP2jk5U52LEYrsb3Ep4VhXo+9rnVD0CFpbgacT5Bh5ijF97K1bCdRa
 xFhB+HhonFlb3Ru0bblDsSTHk8pa+skf8a1APkGgHE3eUK8eRp05OzR/jVCoRdwg64le
 V2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AT0m4gk5vKwNemNRUnmoZuxnPRp5iXTqLQNHSdaZKkI=;
 b=VD3mONQP8X+GG3QbP56Xsn1So1+h+8BSliE8Ch/5n1EQx17596VtI+GJSBHD1bVEKG
 8fVzfRaHYWd5F39oFKD8CsNETdUXt6kWLtoPQzmpMcnUcJGXg5z3B1SCJVARdtXIiiIb
 DYRkWIsc7VUaAriIkUthVpD+9SOBKCZ4gYCK0hAHfkKnjECrpONho3X43Z/kXqYzms3p
 P3pZ0AjR4Hlez6fPhrkhIUMUhcABD4899gC371eoEzXVGfEnhJGSfmE/C3AfWktpGTQP
 XHeDkcf0KHMrmw9YguuIJiONdBwKWcBiJIVswydNm4PxYzMujRTy/p4q0/PuRVKsP6Bi
 sjPA==
X-Gm-Message-State: AOAM531VipHvHSTAqMCveg33o5rRtoO0/LkrSCwTIne36ipCWxr2Ep1I
 tYjD8t79n2OcLV+IasEu8fmQTg==
X-Google-Smtp-Source: ABdhPJy4SiG9ZyHYXEujfTqwbnppxjFLN7l7WlZ2dxoNRfTrJrQpRD/TJUAuhlsJT3qTVS5G05x6lQ==
X-Received: by 2002:a17:90a:6288:: with SMTP id
 d8mr2302203pjj.37.1598978686873; 
 Tue, 01 Sep 2020 09:44:46 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id t20sm3156932pgj.27.2020.09.01.09.44.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2020 09:44:46 -0700 (PDT)
Subject: Re: [PATCH 0/2] hw/core: Move hw_error() out of cpus.c
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200901112323.94969-1-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <690315d0-195e-4f77-b429-c693b35e7b32@linaro.org>
Date: Tue, 1 Sep 2020 09:44:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200901112323.94969-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.13,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/1/20 4:23 AM, Philippe Mathieu-Daudé wrote:
> Move hw_error() out of cpus.c because we already have cpu_abort()
> there.
> 
> Philippe Mathieu-Daudé (2):
>   cpus: Do not dump CPU state when calling hw_error()
>   hw/core: Move hw_error() out of cpus.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

