Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB149C34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:00:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B84A9207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UQEoQAEc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B84A9207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3lcy-0000nZ-TY
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 14:00:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50577)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3lbn-00081s-FK
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:59:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3lbm-0000gR-HR
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:59:07 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:40176)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3lbm-0000fi-BH
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:59:06 -0500
Received: by mail-pl1-x642.google.com with SMTP id y1so7076919plp.7
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 10:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=wu44ice58HpGB3GS2r/QKbbsDyW0CCGYos9To6QBLpY=;
 b=UQEoQAEczxncWG/0EYU48CLV5+P2d3kMJO6gX1BUhEMct7mZZEt/0oQBXq0ZRA1E55
 cNN0XEsWHwFNlDyzmESBbbLZzGa0hlQ+xHSr852lA2FmCFsdlsyHF+iyapVqS7ciuhKP
 vO2qC1n8PRLXnyKYh/JEUw7jtbH8eNJornYtbqx/XkjN9iVZ9lHEHfOIFYg59mLEuRW+
 EXjycXRY3b4iWMBbU+uWDY821SO7fjs4nyXNczJlQpoaZwdjdqIs+JByoBtX9TX5+lpe
 syKyDmIqHEZtsHz4Wu0f0KKtUP3t8Qj9TXwOyc48rh5ajol4YilZ7LtY4fVdpyAJtITl
 m14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wu44ice58HpGB3GS2r/QKbbsDyW0CCGYos9To6QBLpY=;
 b=t5y6OwDJN65gToD1Kes9IwRac1FaTocKZxF1Li2DYI89mXrrWGy+lzv3PWKzqu/VXg
 YT9YID90I2ZpsdhCvYleaUQFFMt/mXn5+v8Ibh1+S9ei1/jcL1o2zZbN39/fwhyCs2Gr
 4zXJN5pnmc6aXMhEmxphZwMwckl1I1zwWLy5xvwiCtsnrkHmA95ubzqeI4KHVObu0m5Y
 5mQquuGCiCJtbzB5iKYPUuyyCZiD1bbV+VjIAh58JLBzM9AgXmC9hxDSWUr9Vt4kKwT/
 SoYoxB7+atLNxekVIUh4niw56D7nPy5UK1NC4bRc2+gevNcvPoIChezL38sorK9trKHX
 ya8A==
X-Gm-Message-State: APjAAAVxM0wkhl0aOvkmrFNWZu+yxJDoJLpMw2INHN5dnII5ahN6MjVz
 kdanWWimSyluvw/4Zx7Pk7+YgQ==
X-Google-Smtp-Source: APXvYqxbXNPzOQY7kxXUV5jg61ZVXBsJA/KS4bic35mYr5Zj8bzSBpwmq66xJFTLo2fmPgDA0TGklA==
X-Received: by 2002:a17:902:724a:: with SMTP id
 c10mr15998709pll.307.1581965944698; 
 Mon, 17 Feb 2020 10:59:04 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 f18sm1712926pgn.2.2020.02.17.10.59.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 10:59:04 -0800 (PST)
Subject: Re: [PATCH v5 19/79] arm/kzm: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-20-imammedo@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <53b559d7-ecb5-65f1-d962-8e4ccca1fcf8@linaro.org>
Date: Mon, 17 Feb 2020 10:59:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-20-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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

On 2/17/20 9:33 AM, Igor Mammedov wrote:
> memory_region_allocate_system_memory() API is going away, so
> replace it with memdev allocated MemoryRegion. The later is
> initialized by generic code, so board only needs to opt in
> to memdev scheme by providing
>   MachineClass::default_ram_id
> and using MachineState::ram instead of manually initializing
> RAM memory region.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Reviewed-by: Peter Chubb <peter.chubb@data61.csiro.au>
> ---
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


