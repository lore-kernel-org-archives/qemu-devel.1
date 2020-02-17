Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A99AC34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:35:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46DAE20637
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sdOvleG+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46DAE20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3mAh-00010U-Cy
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 14:35:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55699)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3m6m-0002hm-Qt
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:31:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3m6l-00042S-SP
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:31:08 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:43107)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3m6l-00042E-MQ
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:31:07 -0500
Received: by mail-pg1-x544.google.com with SMTP id u12so9370038pgb.10
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 11:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=s2CbYYjbFZ/h07a/T7EwnPg8q6ttk+XqV+IXi4hWi2M=;
 b=sdOvleG+9/Qa707j/ot5Pf2jHevqP+F+LUtgwWV2DnCbzqq8+qZTy1G1Pjc4TFt3H0
 FVCEuYu6BSoN1RO7O55RRuhZNRBS5hJrKW/xnhyTMkXhTczW3M/bvGMHgFUkMv2ShzPF
 24XmW5Tbg5qhPqfyPyXh3lUaTk47c2rtyxpam4y4xC2jkYaGgk4j37BcitZvwHaecBCB
 X/lotGFZ039eFl0XKLP9vzPdnWGNaJYa+lfcXB+4FJHOzS40ut+ebznTyI+g7HqldyDu
 CMALiPNYl5ROZTkn9FLFXgYJNdhFG2BVv+jlrGEftgK/Gkzk70WwzKBVSnGwLR6qlXmq
 yNgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=s2CbYYjbFZ/h07a/T7EwnPg8q6ttk+XqV+IXi4hWi2M=;
 b=BSqf8X++k2BBan/fLpLwX0xLimIUaimaqeYPlzlpjEuejvAFi4IkK8igYc0rEbOpn7
 7asRXFJnyW/GEx9W7xkqFAq7VT1hci8ayqfN0Ev50dI8WoCn9rCjXjhj6oi/y72jppRm
 fTuWYulh80EW8ZsTVwoBvXjjGGUY+efwS5eJE21m/UGORO/1Asg5RGy3wGS/UDOJ8NUV
 KPjAqSG+rjV04OamMTS3t86fyIVqisGeu66L0uBtKBqSn3eo+1O1tBrgXSl2I2685SVs
 ow6m9hgLHL9QjkNmkzPVpq94yPqddI3zYV03VM3edqB1auKsb4PcqesVZ5ap0v4QgbFF
 agWw==
X-Gm-Message-State: APjAAAUsNi5MFh6NnVejH1/dFazlXK3EZLsirXxlfSCN70dbo4xV1Q3b
 7gk4eylVB+hMsUuAj2fd5xHbNg==
X-Google-Smtp-Source: APXvYqyZjTkfuPlMzCufos1m1BpovcZsa0cJa7nlBgB0nOc1vf/1GeZXZPzYBsGoErL5l+x/2MWpyA==
X-Received: by 2002:a17:90a:a60c:: with SMTP id
 c12mr711855pjq.28.1581967866799; 
 Mon, 17 Feb 2020 11:31:06 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 w11sm1751863pgh.5.2020.02.17.11.31.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 11:31:05 -0800 (PST)
Subject: Re: [PATCH v5 49/79] m68k/next-cube: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-50-imammedo@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f6d862ea-f149-ba5b-8fb7-53de008964a8@linaro.org>
Date: Mon, 17 Feb 2020 11:31:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-50-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 9:34 AM, Igor Mammedov wrote:
> memory_region_allocate_system_memory() API is going away, so
> replace it with memdev allocated MemoryRegion. The later is
> initialized by generic code, so board only needs to opt in
> to memdev scheme by providing
>   MachineClass::default_ram_id
> and using MachineState::ram instead of manually initializing
> RAM memory region.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Acked-by: Thomas Huth <thuth@redhat.com>
> ---
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


