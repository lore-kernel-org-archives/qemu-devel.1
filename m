Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86297C34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 18:53:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 527AD207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 18:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eIl9vlIW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 527AD207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3lWj-0004cw-J2
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 13:53:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49485)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3lTU-0008HM-3Y
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:50:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3lTT-00047D-6k
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:50:32 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:37952)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3lTS-000471-Vc
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:50:31 -0500
Received: by mail-pf1-x444.google.com with SMTP id x185so9358217pfc.5
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 10:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=fmbTXOEcwbaTxMPBVv5CSXlE7RqeZwMUctSjQKqMkCU=;
 b=eIl9vlIWvreIoRYHd0gkzeFgvTrs0iVQfzGF/VteBXlQQGrF5DC9qik8SIVnIEEaqj
 p3D4PpEUO+0zxXcbog6skouZlr9tkwHq2uDKhD2xZoA3pDJifXsuIvO8II78HOe8Q3vZ
 OHX3e+p6dEcxNK2ZdJKyxiY6zo8u0zLdP4EOPKy3qE+h/HE7CgPbSP8S68bg7KVgvMqZ
 GM4EmihT5705dAxtaYBRMjoDYqnlcDP81/wo5lLdJVnVhEm+guN85cXO+kGLtWJCapeq
 r/j80OzjEUk4sbTLBoGBNzMATtMjdXlqDg04HhHuk9fPWWQxo2Jpo2+TU1RlxBJ1uvuG
 9CkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fmbTXOEcwbaTxMPBVv5CSXlE7RqeZwMUctSjQKqMkCU=;
 b=PV4u2W7hHg6Qs8bGZe2ThX7GRn2j5A5i6dInjHweIdUSuEoUdhimzUgE3H6Xk+XL+o
 6T0VY+V0F/rmFk60JO1coceKEOsTXSElahEfk7FN0d4u8WS73aPPFUGUcWNWbqGQ18up
 HykbDjXRi00ciddbe9/IpD/tjhDmwxuN/KGWzGjZza42oCcR7JyxPveDaF9ibA9fr086
 QEJZqh1kW6Yu4K6bylsAj3dXcLDB2qFNnMw/nPfrPIwv4eF62t8IKi/VKF9+lzMxRYQR
 iG5efpsPcu4045Ty0C2HsryGR6GBSbn8k1+ihEKfn72xuTCHl8CpaM8pYvNLfgK5Po7N
 6wAg==
X-Gm-Message-State: APjAAAXcjbiGDy9u0v8wkfz+bOttepR9hT1uePJg0eJwUiRVylDjB6mP
 KYPoARzK1D/zYEBG4KBMAstEFw==
X-Google-Smtp-Source: APXvYqwTyHgSg/cxnKBD8L12fEiq1FOGHlPjtblwqZIi3rlfrTBLeWORyEUBWUqW9Ti8T5WEwgpk8g==
X-Received: by 2002:a17:90a:ec02:: with SMTP id l2mr539214pjy.12.1581965429922; 
 Mon, 17 Feb 2020 10:50:29 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 n2sm1607404pgi.48.2020.02.17.10.50.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 10:50:29 -0800 (PST)
Subject: Re: [PATCH v5 12/79] arm/cubieboard: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-13-imammedo@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <228b228f-c7e9-5674-5edd-a565a93be603@linaro.org>
Date: Mon, 17 Feb 2020 10:50:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-13-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: b.galvani@gmail.com, Paolo Bonzini <pbonzini@redhat.com>
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
> While at it, get rid of no longer needed CubieBoardState wrapper.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Andrew Jones <drjones@redhat.com>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

