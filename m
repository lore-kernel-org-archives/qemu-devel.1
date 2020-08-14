Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD16C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 17:08:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D01F23B30
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 17:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WS1aUiEb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D01F23B30
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6zfP-0005dZ-O8
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 13:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6zeP-0004Mr-PS
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 13:07:25 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:35041)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6zeO-0001So-8i
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 13:07:25 -0400
Received: by mail-il1-x141.google.com with SMTP id q14so7622011ilm.2
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2020 10:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=3ArlhIf63DPyzBXDe5j7/Mnm8PQPZAMAlpFUhxnKNcQ=;
 b=WS1aUiEb3MKDSe7YiCQGT2nIBYfnbFkvz4wc3dW7E9uPqRjBDIjzlaBrf+dSIcIS1s
 f8DlExRXFeebUx1qcfFqNSdTSRmCmsd35EphraTJuI4EhPtpM89IkZ4xeZpQkBqapYk5
 mubjhUiZJDjPUrST2wDtuHXqQZrBFvm60C4yHsC9l4OUHpl0xqAMvQ//mza5Z4A+cAI7
 caPSoHFlYNNYWh5Nbf5tQIIQPLMaTT8khPKKULVx5F6eYWlku8t+0fIT2VB0j0SU38Az
 voUf5rNgE34E5rDxy3V9j3hHzEQle6hxXtZu78nj6/AaaanA7uW2xzw8e8ZfFZqBVjEv
 1BdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3ArlhIf63DPyzBXDe5j7/Mnm8PQPZAMAlpFUhxnKNcQ=;
 b=p92d6LBRaT75MLmppIRwgZ9oJh9GAd9g1D+HKvFbJgeuTkijVxSRn96p5bCUPhUAVd
 eFzbgQQ6sNtH3SSh1O6gRrvl5bHrclkUS++tSxRaTnCXwwuXWD8mHQnRicb+ifUbqKjC
 MHrjjiP0JCwBCIB99zj408gAjyTwuZk+2rS7ZHdg7egmXkJn5JeYtmI0IWprbResdoJM
 DbF/hGntePcZyZv/0HuQ+A7gWKUABEiC6rIf6jQfRz8ZTkuUoOzu1v6VVX4IS6pmjzoe
 BJHsOBH/M3IP+dKmUOGA7x0WsdQpJh+tyaiCcS/1oHKTYsDuy2XJXLv3uM6VZz0XY5bq
 RgCw==
X-Gm-Message-State: AOAM532nezgCHeCOzWyCVY/X3MJCgA7mOBcUXQ3/jXbfKOisDfyACXNf
 C5gXESY7GiuQUZ93lAmem7D8L1qS3SQLRw==
X-Google-Smtp-Source: ABdhPJztVVOAB305CXHFnDjv+Eb4UsVjBkwT/oWbY/4+ev0QxOlTGqQaywjP598T4hjXW8C3NNCa3A==
X-Received: by 2002:a63:9256:: with SMTP id s22mr2836891pgn.75.1597439246514; 
 Fri, 14 Aug 2020 14:07:26 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id q11sm10298131pfn.170.2020.08.14.14.07.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 14:07:25 -0700 (PDT)
Subject: Re: [PATCH v5 14/14] kvm: remove kvm specific functions from global
 includes
To: Claudio Fontana <cfontana@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>
References: <20200812183250.9221-1-cfontana@suse.de>
 <20200812183250.9221-15-cfontana@suse.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1426bf6f-b587-60bf-cdc6-5659139539eb@linaro.org>
Date: Fri, 14 Aug 2020 14:07:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200812183250.9221-15-cfontana@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x141.google.com
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
> Signed-off-by: Claudio Fontana <cfontana@suse.de>
> ---
>  accel/kvm/kvm-cpus.h   |  7 +++++++
>  accel/stubs/kvm-stub.c | 22 ----------------------
>  include/sysemu/kvm.h   |  7 -------
>  3 files changed, 7 insertions(+), 29 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

