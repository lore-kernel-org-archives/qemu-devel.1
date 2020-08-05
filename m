Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B8BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 16:09:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05DD82312C
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 16:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xQCSZ0SA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05DD82312C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3LyN-0007SZ-7i
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 12:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k3Lxo-00072Y-PW
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 12:08:24 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032]:34287)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k3Lxn-0007ln-6p
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 12:08:24 -0400
Received: by mail-pj1-x1032.google.com with SMTP id c10so3340279pjn.1
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2020 09:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=md8lm8yJz+LGazofNah6zkJvAxFUVbYVHXC73OYsnd4=;
 b=xQCSZ0SAg87UQak7/8uzAzcz/2gPGDvAgqcl0MBmkJlnjoBLEUrJCpBlf22kyN4wQQ
 bLIz1gBEO7aVuHuj6PrT00a9YRet66dMKBr0jzTTkKvHSnmWTr58M664INW8f8yMyCYH
 YmthZf9H9LIB8m7/lvMT58XwPuK/St7U7vkO/43IxcY5sDN6kzON51Y1LDbkI3Znbhak
 iA+emUDdtdroBIxsa5GPAsE/idZ2gHsQrFicdRYKTbqEzSs1MGOcrLk4HtNbUunvq3u1
 s2SHuW8ZO2Cok6ueZT2ev2yY2GLgeR8OaCXAN21hxpQHbHGr+NDp8rNuUQ+mNVjxtaSt
 6Ycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=md8lm8yJz+LGazofNah6zkJvAxFUVbYVHXC73OYsnd4=;
 b=opjjuGYPrqJYCa3pkJLBw1WiqmBfCfxz2xPBSxmsALm7+1+x8r8C5waX1L2I3t4noU
 HCaYWqaP2TTmKSVaXignmYSA3V5JR8Sr1Y9qORKqCDywCh1gS3JHfyCzqsDaAKRBdVRA
 LFmtucCmtxBgh9FQiviq58RMmVChJb6+1S12xI0rKpiGzmwL0TVCdUTdKGInSqhfZ6dY
 1YESvGX2SLUDP8iHREK1UdXRIyLzS30Zjx/jF2dczIbzFIQHKPIyC2Tx8ghZg3uIjIp9
 b4kf+OetQ3RH3xYMCrS4AbhXHm284CK4N6Gne3aQDns5Zki3plAqpup6dMLGp+SAO26L
 9+tQ==
X-Gm-Message-State: AOAM531gbyueWedEklkxCvdxUtivx+RtevQG4YCgFY3LXiOjdpioOulr
 2+qm78jNajZ+BZPTcDCdMTXveA==
X-Google-Smtp-Source: ABdhPJzwGi0r5KPPoF33tw2nkKr41+z6LLAt39gj/xb6WsZ7JOAQcy1L6YPxsYFRLV6GxxAQjZsHmQ==
X-Received: by 2002:a17:90a:d3c2:: with SMTP id
 d2mr3954890pjw.112.1596643701509; 
 Wed, 05 Aug 2020 09:08:21 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id o190sm4205458pfd.194.2020.08.05.09.08.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2020 09:08:20 -0700 (PDT)
Subject: Re: [PATCH-for-5.1 v3 1/2] exec: Restrict icount to softmmu
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200805100126.25583-1-philmd@redhat.com>
 <20200805100126.25583-2-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <45eb57ee-6ed8-b3bf-079d-3b4a811c47b9@linaro.org>
Date: Wed, 5 Aug 2020 09:08:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200805100126.25583-2-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/5/20 3:01 AM, Philippe Mathieu-Daudé wrote:
> 'icount' feature is only meaningful when using softmmu.
> Move it out of the globally used exec.c, and define it as
> 'false' in user-mode emulation.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  include/sysemu/cpus.h | 4 ++++
>  exec.c                | 4 ----
>  softmmu/cpus.c        | 7 +++++++
>  3 files changed, 11 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

