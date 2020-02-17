Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA923C34026
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:25:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78D0820836
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I5zkMD4j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78D0820836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3m0r-0001AK-N6
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 14:25:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54752)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3m0D-0000bT-Mf
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:24:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3m0C-0000ui-O1
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:24:21 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:36966)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3m0C-0000uA-IB
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:24:20 -0500
Received: by mail-pl1-x643.google.com with SMTP id c23so7107569plz.4
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 11:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=X8AEMZPiEtj8NBy2aqTtBUyOCgCZNHzj7alvIhp8ll0=;
 b=I5zkMD4jdkhWW2PoC8xx21CvG4Gr6P9g/AldY45agwyOKdLAeJych13KLhEIGWACDy
 rCNYwEVDXYNeiUNfmd81HkpaHvnQqMMyM1PvUefXr0cMOBVoJhsNtWQezcJjW7dB+kfu
 PLD2+P8vhnsCaD49dapV+u4gZaoukNsU1VF0PzieDQGdeAMZwBJFOPqFhpJRWFf0f6Fb
 3NTXnrRdoIWuO7pYhfkyOgJ9Gt8ngu3hRQeKIbd+VR+IKFNyh12j0YLlLXcRgLR40u18
 V0N9OHXkT2nGJB/1BlJhQPPLGfubnK/aTnQGfumTPeq88gSE3dFSBwdxKcLrckDXb+sS
 U8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=X8AEMZPiEtj8NBy2aqTtBUyOCgCZNHzj7alvIhp8ll0=;
 b=nFnNypNTA7ujyB8zDaPmWR7E+9dSFxPnT0En+mK1zomN5vNhAVlH7SY1lp1USp50d6
 LMH4Ci4jQQ0PL03kcA0DjN5PcuYYPZCxvxo2bh8NdCt0oVuNkCDcHQ/lf9M6ySRzMwFE
 YGenzfuhqdit077YckwgAGhLwqBZSPN4ShYQgRc77NChNooa0VAPgZI6CGF7a3fRwlsx
 XYMiaM2UvK1YL5C9nUN/UrFEj8LztzPvX6Ep1ew0lURIfel7DAz+JpyaWLgrh4exVicE
 Fw4lsxJWlAB+bMYe2HESEydmR6PLPX4rAKhK1bgxDFj+d//WR74HTv9++KUWvHuix5hW
 dW5Q==
X-Gm-Message-State: APjAAAWY/xSZSqOmuSGK37MvnpHWDxVfpW494lnHSYq8oyeml0UH6T/2
 ZN1bTeM1lc2q7x2xbx434E3rMA==
X-Google-Smtp-Source: APXvYqyU8Cy9Dv3sbxsOccOcwu20aesT+htFf6jL70Kc8Z9q6VOdJdhOelPTacocp6OPXOYo4LiNJw==
X-Received: by 2002:a17:902:8609:: with SMTP id
 f9mr16505338plo.203.1581967459372; 
 Mon, 17 Feb 2020 11:24:19 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 u23sm1229691pfm.29.2020.02.17.11.24.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 11:24:18 -0800 (PST)
Subject: Re: [PATCH v5 35/79] arm/xilinx_zynq: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-36-imammedo@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <32df977b-9d04-e666-9a9b-b1b5f0997349@linaro.org>
Date: Mon, 17 Feb 2020 11:24:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-36-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


