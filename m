Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EF9ECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 18:03:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A601721D79
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 18:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tw+pGVXk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A601721D79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFMUL-0004Gi-7o
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 14:03:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37996)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iFMRL-0002b4-V8
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 14:00:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iFMRL-0007h1-05
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:59:59 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:33512)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iFMRK-0007gQ-PP
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:59:58 -0400
Received: by mail-pg1-x543.google.com with SMTP id q1so2171155pgb.0
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 10:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=SFJLAxMxRgMAOruAs1NxSyXkuAOhN8XfQESEQ+1HUAY=;
 b=Tw+pGVXkUr8Kax3pKrFyWM8P9PqikGEnfYt0p/YEZLpVbAXNN1r9NuGinZ3pHqBAGo
 LDvODXDiSP+Zt8GWEtc3PrjcLFORmD6d11D4CPWkV7muDK6Nck9OE2uXgiiWCgvHkTNQ
 2QyJZxl24erschMiiGqUwni36Tjk36MSvsFYlVizdtbnyObEBepD1MdKvI60wcH2+W6i
 cUuTQnZxs/Mnu3mc5pnGMCMFHcSNdGnjlLJLx2j2XJNJgnQvaP/CL/jVuXHfHpZ0HLq0
 5j0U5z4Xp0DZ1dNz+8qlkYcDM/GLmSSax/y+lm69szleSVVetygseKsmiTE430Mu+pTm
 sx5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SFJLAxMxRgMAOruAs1NxSyXkuAOhN8XfQESEQ+1HUAY=;
 b=ILUFx51Rpo5UWxeM+gMUuRTWU8w6lQ5bdz8mQis87m59w79Rrd7yz6gSdXqeB7Ukxl
 oUypxYoa4dqIrcqmYObk6ILymxKehj8lI0tn4E/7+vYHwGF0e3nPq2yZaliqxY5ZRSEs
 bHJLFDGaFLxAhSIr6yvk8pMNaDbRlzJ3OGKOWOZOz/eYwR8SSbRX0CUwn+C6YZ+1yapm
 GDTYaStqAZyZYeGBv1648epE9KO5qpuEwqPc1dy56C+kGHSesCTzdv3kZXMYf3+9qg75
 XG/c1LRCFhJEtu9maFJ9zB4lN7oHAn2jJZdle3tx0D4jUeY6bS0PdmAX+M3sCds52ada
 fxBA==
X-Gm-Message-State: APjAAAWaS8EG/b4Pf0RzNEwHQpXaQ+iMa902JEX7M4TmzXDUOaDGkFY8
 hu+X6hIEnT89Ne6jAtxRV2c3vA==
X-Google-Smtp-Source: APXvYqxbFJE0zV1Q5zAKldLXgPHXpJn8izUHBdtkxCKbvtSKASHiZqlA619G2WbBKnvEILupo6v13Q==
X-Received: by 2002:a63:465c:: with SMTP id v28mr31849646pgk.310.1569952797543; 
 Tue, 01 Oct 2019 10:59:57 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f185sm5023192pfb.183.2019.10.01.10.59.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 01 Oct 2019 10:59:56 -0700 (PDT)
Subject: Re: [PATCH v5 9/9] target/arm/kvm: host cpu: Add support for sve<N>
 properties
To: Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20191001125845.8793-1-drjones@redhat.com>
 <20191001125845.8793-10-drjones@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <a4f3be1b-533b-1089-6bdf-1ac3f4da4ef3@linaro.org>
Date: Tue, 1 Oct 2019 10:59:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191001125845.8793-10-drjones@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: peter.maydell@linaro.org, armbru@redhat.com, eric.auger@redhat.com,
 imammedo@redhat.com, alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/1/19 5:58 AM, Andrew Jones wrote:
> Allow cpu 'host' to enable SVE when it's available, unless the
> user chooses to disable it with the added 'sve=off' cpu property.
> Also give the user the ability to select vector lengths with the
> sve<N> properties. We don't adopt 'max' cpu's other sve property,
> sve-max-vq, because that property is difficult to use with KVM.
> That property assumes all vector lengths in the range from 1 up
> to and including the specified maximum length are supported, but
> there may be optional lengths not supported by the host in that
> range. With KVM one must be more specific when enabling vector
> lengths.
> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


