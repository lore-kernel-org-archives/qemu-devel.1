Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CC5C34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:03:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2D6C20578
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 19:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T4QceWm6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2D6C20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3lfu-0004TF-0J
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 14:03:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51086)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3ler-0003SA-5H
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:02:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3leq-0002Nk-6J
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:02:17 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:45736)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3lep-0002NH-WF
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 14:02:16 -0500
Received: by mail-pg1-x542.google.com with SMTP id b9so9547188pgk.12
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 11:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=lOpoGlMHmRcDqN4ZWXKlb9Ek24G1P4/qCOiUBXU8rBU=;
 b=T4QceWm66mBIoSjhFJFE0ySe6JV+DD9D0UVKbVG3I9gIdP8rDzMvMA4BW63SVzvfu+
 WSjGF+CcdVv36NOkmeRSkpiti5WfAicQCzbz8zAUpfgfBc0JW14/igtWeCcI7US7CyqI
 Z5y7M76yH+mOEMdA0ySVJCBQSRyujn3ezfSWWcwssNwaOibGe0kA7kvQQstbbc3OduRn
 n2MC7XkhfkdQHCK7Rg57vdczJ5mBNu65n2et9vf7174xZNyOtrq5krgcxKJzl4tjDEh2
 gHsaaZs6SpHWiBS4FVWenhpjCBp4rHGvY4JA2O0q1i1oaL6IhsVY39YJc8h7URgUO5PN
 wnsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lOpoGlMHmRcDqN4ZWXKlb9Ek24G1P4/qCOiUBXU8rBU=;
 b=Aexa9U/nza7rOM5cQ6uNI9zTPZKS3YFOU3WKVUmYsSL+EJQUnF7utvpYz28hh98Yer
 9Wzok/wTpKC3MU0G7K4nwPEMlwYtG5TV/VaXgs0qqDn5PxQBCa6T9pV4LqH8wO8owc7q
 nzxSaWWuISJ3Ozfi/OlPN1y9HXjVqaASFFytSi4NHUKgJejFR0LBD3v5EjlFqEF3fDnk
 ce4v5zIZGdCbP5JjQiKLRAj2kMUm+8f/dgJVeUrthKQEgnbiS636Y08o6hib/joF02WY
 XNlNyQ1DVnBVTx8XD7yFCuJvqlZX2CroV4U6rDZHm+CZWvkp7fY1tKIGAdzXexgoed4B
 DX1Q==
X-Gm-Message-State: APjAAAVKwCvxqBEU4aBaTrfFXJLCm6MQsDyXNDp3K694SqIuiNXHhZF4
 SfpNoCn5EY7BOKTChiQE144/3w==
X-Google-Smtp-Source: APXvYqzTjijlsOp24IpO53veGRjFxrt6eThnPAkUu8k18Qs7Do6iASPVMj0gzrMPxUgC7FlmF1nDzw==
X-Received: by 2002:a62:5183:: with SMTP id
 f125mr17001117pfb.201.1581966134796; 
 Mon, 17 Feb 2020 11:02:14 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 gx18sm210663pjb.8.2020.02.17.11.02.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 11:02:14 -0800 (PST)
Subject: Re: [PATCH v5 22/79] arm/mps2-tz: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-23-imammedo@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d97260a5-5ab7-bff1-6cde-e9011e40a51a@linaro.org>
Date: Mon, 17 Feb 2020 11:02:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-23-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
> PS:
>  while at it add check for user supplied RAM size and error
>  out if it mismatches board expected value.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Andrew Jones <drjones@redhat.com>
> ---
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


