Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181BFC34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:31:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7F2620637
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Am7kMr8C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7F2620637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3m7A-0002qs-02
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 14:31:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55554)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3m5x-000177-C3
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:30:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3m5t-0003eK-LR
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:30:17 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:41005)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3m5t-0003dh-Ef
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:30:13 -0500
Received: by mail-pl1-x643.google.com with SMTP id t14so7114183plr.8
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 11:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=s2CbYYjbFZ/h07a/T7EwnPg8q6ttk+XqV+IXi4hWi2M=;
 b=Am7kMr8CT+j7ATACPlaSdZ84IwaFObr5haMEEr8+IZ5anQW8a98ZTOGRVSz1AggKr6
 RskxoFdbkJKoqZlfUMBiT7hNt5ph+BYClPD8aAtfb2Aeht0P+qUWwwgfXghJ4Vjrq6S7
 ViI1WinHEjFKvB6dsBpMH6e9Fh9gQah74xziU1Z1KXtuZZ+8Kbt0KuEFxFTZPjy+D/Vr
 q9LiygFZc40e3IRge/jWTLBX4oqh9seZEVohPtkurkL+35a4khj7+nRdm2a+GpbK5F6/
 whW6ra1p+HpDH9z5qkKZN3jy4CV2KhfiA71G9LXgZjTTSgzl1/ly0DQS2ymt/SYXt92+
 sapQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=s2CbYYjbFZ/h07a/T7EwnPg8q6ttk+XqV+IXi4hWi2M=;
 b=Y2CGaMfLRKKsvCrLZACPclC8KjjWwcuzzXhLMAQDGFPJpV8+WATVR1Bchpqn0Mzfu2
 /Fs48N/5eVhMKVOyfaNh2G1KJk61BBmaqU7zvotu3C8GQGsqMzhjXVP1OfFcptYROg7n
 HIcXyYUEYuvg54pzsZefOwgdIvExRIU0BND1cRaZmSHeQrLrTYo+DXaBCdvAcMsXMHcv
 4Vpe6Z6b43Lh2wA/mozfhX6UIZWKL8/uHIMlLMTcZlWdliGuJIP3CxRMpePznmfocaJt
 y3kzGNCA06pvo4GUPxRgHz8XDzj2CK0zUNv1KR1D83voOBT1doPl+scWd7UE/a/TJpJ8
 Trsg==
X-Gm-Message-State: APjAAAW0/Q7jVPXMaYIAgRLeZOxFHulpCM7y7za1c40ghcYOk0wMgTV6
 IrLxeaY84icHd/diISFVfSimaw==
X-Google-Smtp-Source: APXvYqyGAnbwQ3/A17AgBMsXxbUr3xpuE5V+o+aAHdtRhRK4sLz6xcA64S2XeozI5GQIm3iix3AUFw==
X-Received: by 2002:a17:902:9a8f:: with SMTP id
 w15mr18179651plp.30.1581967812458; 
 Mon, 17 Feb 2020 11:30:12 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 s13sm443667pjp.1.2020.02.17.11.30.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 11:30:11 -0800 (PST)
Subject: Re: [PATCH v5 46/79] m68k/an5206: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-47-imammedo@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6c9af50c-3279-b184-674e-0c4c6fd7cd2f@linaro.org>
Date: Mon, 17 Feb 2020 11:30:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-47-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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


