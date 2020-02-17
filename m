Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A468C34026
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:31:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D489D2072C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jS0x1/+w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D489D2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3m6d-0001rb-Ti
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 14:30:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55486)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3m5W-0000GB-V8
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:29:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3m5W-0003T6-1c
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:29:50 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:34217)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3m5V-0003Sf-Ry
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:29:49 -0500
Received: by mail-pg1-x542.google.com with SMTP id j4so9738255pgi.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 11:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=IYKMF+l0xWcljN37ZmgF478eMQc/36lDVUMeDSo3v24=;
 b=jS0x1/+wmyu9G3xxYLlDGrnBRRB7iZbkiLM5hnHFlhW4jzz8PKMtdRS/yxWUfs+yFm
 MhsNyjk40975A+F7cob51QD4rrrTJ+FSBZiibmzxn2rFmUN1ExRd0gpl7NSRrIAC7BAh
 ig5vTj+0ITmOWPjlpEV1phI1GuWVE6rZngUh/oCS0uY07tllnbNITOx0RAH39S+1X8sg
 7uisDBMUZ4pOnPt6BLKhVdX0ks0KU/x1Ee9AvXY9ARsV9w4R4R8fAE/yUJSRlgLyLavU
 yozGZyo6/HO5tJyAE13IxyLKoEoP7gAeGFYYSSDuM2HDwCeGtvKu/n4ofxTrYSYYz39I
 Dfcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IYKMF+l0xWcljN37ZmgF478eMQc/36lDVUMeDSo3v24=;
 b=jjoQ5rIXFIvEHSMBkiHiWaDjwoFjBU6JTJZw0GGap2agmVUQWegmxv4aUlFqDy+vM5
 UYvxDxT4CUXWDTeNHXsx3QMM3BtdOIhaBF93BkuqXbxo0LZ0L8eWMzUiL6ukuWA965U0
 Wm+pxg4R2kl9Q0UWasT208ARCLmNlY/WFubk5nGqL+2Ve+1Hgo8xY4bLsGZJRr7aUnrm
 BzyWct08z+UisjsDUs/38HSJmGGQGcXMcDnvYL0/3iO6qsCGn4WjlRPR+7PdH61QxRH5
 cLYRRIaAfonS00VVtlympAi3UBY8+suNAsyhU4mzuTqLMZ8IrLNvW7aIVCdCfSNg23KM
 z2wA==
X-Gm-Message-State: APjAAAUXQWpyQPTFUamW79KTYxba6tkne1YMgTilTQ9f43GvHMmtVlqU
 z/8FVZy7b7kqH5N21tEVBpDjow==
X-Google-Smtp-Source: APXvYqx6CHHiBTtCrW08tBw9EdBn5RbwKhzr202oSZM0pFOQdInue3WW/kWhh3q6U4DcQExJV0KSfA==
X-Received: by 2002:a63:3c46:: with SMTP id i6mr19435303pgn.413.1581967788978; 
 Mon, 17 Feb 2020 11:29:48 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 z4sm1247366pfn.42.2020.02.17.11.29.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 11:29:48 -0800 (PST)
Subject: Re: [PATCH v5 45/79] lm32/milkymist: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-46-imammedo@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <23001699-4222-b41f-d9dc-9298350d7524@linaro.org>
Date: Mon, 17 Feb 2020 11:29:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-46-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, michael@walle.cc
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
> PS:
>  while at it add check for user supplied RAM size and error
>  out if it mismatches board expected value.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


