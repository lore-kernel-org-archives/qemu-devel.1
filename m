Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B21C34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:38:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B97BF20578
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qg1bVbFR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B97BF20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3mDP-0006N9-Us
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 14:37:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56154)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3m98-0006sS-1j
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:33:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3m96-0005De-UQ
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:33:33 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:35949)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3m96-0005DM-Oy
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:33:32 -0500
Received: by mail-pg1-x544.google.com with SMTP id d9so9746013pgu.3
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 11:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=KYDZleVuW+LxY4vSup9Y7EwXUDBUSBOKXkyA9C7NpyQ=;
 b=qg1bVbFRskDpOsqZBApBDYISx4S1mdpTB82G4ZpYmY2M8kAdDSEtcgWTiO8zLfkQT0
 G8yOA3+un3XtkwpDNF7AMCv/ZCoMPgGuDRtt1HxJOYcmE+A0aXEff+UToMM0TM0QD5a7
 212+qHIeXu0p0hSnamASkuwLAjMy0y+okvjcbPwwFPj3qrilfUcDFei4to9JTvY+Z5sL
 +MuMvKJ88COlos7lc0QQfWm6b7NqZAT4R1/AqYkWTdCB9x0JfpKEX3xxxiFSLtsuiVBy
 QdmP2oKRaRXsSEZbvyMrA1VqSvC1lOg+Hc0pJ/sKkstKn6iv+bOu+EYd4vWMztTamOCb
 e1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KYDZleVuW+LxY4vSup9Y7EwXUDBUSBOKXkyA9C7NpyQ=;
 b=ETwLlg7VyQa/dz9T4RszJokrbGYbu/2odaXu/AG8MdV/yG/hv8NAagsIj7VH+GvXOg
 za+BhGYKUnUX8hsW6HsBLIdp9AIUgB8jZ+tbQUklXa+6GQWoKZ+J5Mr0Bxko6KG5qjfE
 Dm8bRMxoBB9sNMrPmYiIXdPcpWrsJg5LvzW8T449g5gXVT6zoGjO2mr6FGiV1NAgi0mS
 BmkgdjnKX6E/PIw7kGTf0k/ee6zLatos/um2Zf32+ejUA8t80+RO9zry+8Fs4aIIFt2k
 7ckRPzjuLEpdu1mTZxCTej+asSgeJRF5se+j5B4EhgewMPfnPz2zAUn4mGZdWqnu6OvW
 35uQ==
X-Gm-Message-State: APjAAAXRT2Mlsm4D9BrZwzjKPJZspICt2UVLPe+fIpjc9KJ1l1vtTWxF
 n2Doq7kF3cZ5iAJkzZLaoXunZWXLJwo=
X-Google-Smtp-Source: APXvYqwXipSIT/UoFIme5/i8AK6D0CYjF5t7hLIH1jlYHvFg6yRTJc0UPlwhCU+HYTpyeVVldTTGkw==
X-Received: by 2002:a17:90a:2004:: with SMTP id n4mr716910pjc.20.1581968011738; 
 Mon, 17 Feb 2020 11:33:31 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 w2sm1666007pgj.41.2020.02.17.11.33.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 11:33:31 -0800 (PST)
Subject: Re: [PATCH v5 62/79] ppc/pnv: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-63-imammedo@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <90b5850e-8c85-8700-7ed4-477f7bf4b71f@linaro.org>
Date: Mon, 17 Feb 2020 11:33:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-63-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
> Acked-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> ---
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


