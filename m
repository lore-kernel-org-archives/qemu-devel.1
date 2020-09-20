Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F15C43465
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 23:02:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 682D620809
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 23:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s+h/KB70"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 682D620809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kK8LO-0006Kp-Ay
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 19:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kK8Jo-0005o1-1n
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 19:00:29 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:51583)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kK8Jh-0004Lw-07
 for qemu-devel@nongnu.org; Sun, 20 Sep 2020 19:00:24 -0400
Received: by mail-pj1-x1044.google.com with SMTP id a9so6355370pjg.1
 for <qemu-devel@nongnu.org>; Sun, 20 Sep 2020 16:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=DZYp+jqXCnl9LSLKD0zG8bv96mYfBaZD2cIqmRkuiQc=;
 b=s+h/KB70dvcVLUNekkDBMYfcTojf96x3vrt+EZUJmSFp9IgtUuTPTQhNn5scvXw6vM
 dbl6n6wZ8oPxz3D8BRXfkdfCFpKD+eCakn9OQh3nBOL6R82HUraH44E627coYWdA3x8S
 uZNxGTtHvcsqTWmmtkrlhsWIaxcfH9XRXKQ20FHgUA+n8e3OC5dOsEE2dLN1T8vNhFHy
 dWs0KGp8LSvXHnmIP0owlbIYyoooUrmMMXuq18X0reAwp6WeMNHxz920y+I3ySYg8ZKd
 UGJ1yWdgxPvg5YHrMg7fHAgryVoq/u3XIeBbhQrYC1GAyoRL4p7hOmktB6WmRnWFHQze
 ZeyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DZYp+jqXCnl9LSLKD0zG8bv96mYfBaZD2cIqmRkuiQc=;
 b=DNclDIMf05edsIavaG8O6E9LBOOWz9Rz0vbFbymoXsW+yaI176JvxFj74Ft0NEkrn9
 MzDa3/LRYcrGSJF35Ox/A4t+tANoMyyUQCSUGMJI949RnkR70pkxZFanVMt4NoaREe3A
 9uiVcEBkswm3aQik0IrWnLqHp0mCNwaBPXA43473mc08T61oSUwjFdsrPIpHCIl4TJG7
 J9XFzMvr7UTlXpNJDAmkXHxFBFkaKoZ/F/F0i8BwgQBtOzm7j7UhTKEbU3qHy+OgEp/i
 C2BEJXUq8nntyPIziQNSjpfRNrHhBSkUIWb/EuIJGWCnsdlssRXSG5lB306kPfI5kImV
 eGeA==
X-Gm-Message-State: AOAM53371XNSvWCRvE6FiVYw4ToSpwe1grnTZye/irh7z+n2U49SEUQx
 gt9HxqboFmNzclpmfts7F46pw70oGtJ5xw==
X-Google-Smtp-Source: ABdhPJzJT8cFakIlfpg1XplePmLeyb+iuw+RyGnUAWNrBpRVfjy0vwLm0k/BimltP7fdMFXBHJoMxQ==
X-Received: by 2002:a17:90a:d813:: with SMTP id
 a19mr21219711pjv.115.1600642819327; 
 Sun, 20 Sep 2020 16:00:19 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id v204sm10011726pfc.10.2020.09.20.16.00.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Sep 2020 16:00:18 -0700 (PDT)
Subject: Re: [PATCH 1/4] configure: cleanup invocation of submodule Make
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200920093016.1150346-1-pbonzini@redhat.com>
 <20200920093016.1150346-2-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5d1929df-d3c9-9053-0894-48445a75ebab@linaro.org>
Date: Sun, 20 Sep 2020 16:00:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200920093016.1150346-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/20/20 2:30 AM, Paolo Bonzini wrote:
> Move common command line options to SUBDIR_MAKEFLAGS, thus simplifying
> the rules themselves.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  Makefile | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


