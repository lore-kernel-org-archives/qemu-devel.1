Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CE6C3402D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 18:46:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 092F824655
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 18:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y4bYGoPG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 092F824655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3lPh-00055V-72
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 13:46:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48900)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3lOv-0004cJ-KG
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:45:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3lOu-00028W-Og
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:45:49 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:36849)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3lOu-00028C-H7
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:45:48 -0500
Received: by mail-pf1-x441.google.com with SMTP id 185so9362470pfv.3
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 10:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5nenbn+0cc/Jm8/H/IrMs1qP3PWGd6m5xqod30sNN7s=;
 b=y4bYGoPG+++tK4n6oxKVMwtfeYoxPvXBSyxskzV038uu+65/UkIpFydOm+LWFl5n7d
 RDllm19QhL66j9onUvwrULoceVsIJkbhnWLz3YWytDhHwF+FdvmyLvyngutpSUFQo24C
 4ePHQ3z5hJJqNbFOYyOGvoxV1V/2EKu/RlccPOMx/sOpplERYPMESiVQ1Npx4oAoCiCh
 a+rmuzde74Yxa2C31HC2gRAZas2Z6z3wFLh+tSq7pFcjcwND79FMg/izgkAK7P9wzeyD
 bZ6qU9aSq5QiUDYnjzR50T8bFdvxNffYvrIG/1rQ/wdcXg0m+itOWe8thqiiu5WOMYku
 LmMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5nenbn+0cc/Jm8/H/IrMs1qP3PWGd6m5xqod30sNN7s=;
 b=Ox/hGJ++nVnJKewJB/znXoRJsPiAPC0m5r65UKJtw37kzIaQnbsjb6LwSOLJu4SVnZ
 K2sOYY8571HnLJGfRAqrwynMAAOQEn+Fbg3RVaIEfjDTXoosmzLPLKww1uns98vP/BER
 QgFvnXRNwoXTwxw1l5sCiLxmSEv+DoiO8IlNAteO8mW8bnZpiXgHwKorWGWt9eWO8eI8
 /GXtmqeGbbC71hi77b5zfjwU5XZVIHKOkwWPAOzKsHM09ryik4WCuP8EkdQcic8mCQZY
 bdNOZoNJD3qRIzBW7zqgh0I6CkzlT0Ng4tJyhg38jBreJP0fiBBrNZqH2vKTCq7gDXHu
 HCcg==
X-Gm-Message-State: APjAAAXTLUJqeGU0MNobL9+isDy9M13wNERCoidRCkXNjuMule5O7QB5
 lNpNinMJSTmLgvvtTx2OF+dymg==
X-Google-Smtp-Source: APXvYqxCadhFGESJ3h9COoHKpn0fGfwNd3UJxg99xhXp5BAIoBoHRpAs5XACdYJLZwTc5pnurludQA==
X-Received: by 2002:a62:1594:: with SMTP id 142mr17627368pfv.18.1581965147388; 
 Mon, 17 Feb 2020 10:45:47 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 g72sm1287178pfb.11.2020.02.17.10.45.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 10:45:46 -0800 (PST)
Subject: Re: [PATCH v5 04/79] machine: introduce convenience MachineState::ram
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-5-imammedo@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f2633929-5a30-3823-7712-777102b054e0@linaro.org>
Date: Mon, 17 Feb 2020 10:45:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-5-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: pasic@linux.ibm.com, Paolo Bonzini <pbonzini@redhat.com>,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 9:33 AM, Igor Mammedov wrote:
> the new field will be used by boards to get access to main
> RAM memory region and will help to save boiler plate in
> boards which often introduce a field or variable just for
> this purpose.
> 
> Memory region will be equivalent to what currently used
> memory_region_allocate_system_memory() is returning apart
> from that it will come from hostmem backend.
> Followup patches will incrementally switch boards to using
> RAM from MachineState::ram.
> 
> Patch takes care of non-NUMA case and follow up patch will
> initialize MachineState::ram for NUMA case.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

