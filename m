Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE97CC4CECF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 16:08:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A96120835
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 16:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ebu0ol3W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A96120835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCQt7-0006WB-H7
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 12:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54878)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iCQlM-0001j8-Jf
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:00:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iCQlK-0003pd-Cx
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:00:31 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:33666)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iCQlK-0003oy-5l
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 12:00:30 -0400
Received: by mail-pf1-x444.google.com with SMTP id q10so9411746pfl.0
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 09:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=UCMgeYOl9zoTl+hdz5OtfFV9SpHKjNdjLvwU6IF7s6c=;
 b=Ebu0ol3WNqgYGcDM/UmqSUQObIIFSijAi1LRFsDB7t5TVOc5ytiOZ7nlEMZOvZqK1p
 2Cq1//7ik9wS/p8iBw+1dDZvYn+iAVQC3Kc2YHA5j5J4lJy6n0dvlD39kcXBBA2dPeak
 Mbs9eSrCfQmLpatBGWJyfHl+gnjxmzv0d4wpQkOQJMrWEcTHCzqq/MhOVLU2iggpyyDH
 3l+7hJYc/RapBTQIGOHHqoVJ0Av3k+SNAcpOIbI/sSQIUhCtrCIlEJllD4US6UEarQgD
 rGQfIJD0stEGGIGud0vs74Uc1B9/XTHshM6PaNdkXoZhTaFtNyuy9UgzKuc6gJdfNmXx
 gseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UCMgeYOl9zoTl+hdz5OtfFV9SpHKjNdjLvwU6IF7s6c=;
 b=kpSzCRmDt2f/8nsFKLtZbrZDFSxX2zvbJ8Xx5SWiNok5QGAKh8b3Gct+yNwNH9XPtK
 eX9a0sw2H8oJ9C9FaL1N6gye3JA+8xbdNKY00dXS6TJsEHXkPoWybz+rsIznK1CKLZmH
 C9PNxZk2hmuDD/X8e5phfKOr/iL0SGjxB4cQO7pCx4EfGCcBGwQOnDMEpjbR4V+qC8Mu
 5QlD42f+21qpcP62I0Ki4yU9xMDI5dbTPn4SqGaL0YIS5Hkc/xFAx+fgHbXuGZ0qTsE9
 iv2I4z2GqgHyEgmAxmT71CYCdWwrZ+UcrgvzRmJIyvxGv/SoYq7Zx3RA4qQhII9RLMRi
 VV1Q==
X-Gm-Message-State: APjAAAVZd3IZPm8bdY4FP2JjqQJwAHa3e0SWwRO6zoE2KDbOdtVpUQG4
 sccZT3/mUz3imOZ2jbBsSNisVg==
X-Google-Smtp-Source: APXvYqyMA4TyjPZfEhjaSkxYxrfwA+NfzFh0cU50XxlSq9mrn4uI3ynIxQVBpZn217egtgcKFl6GAg==
X-Received: by 2002:aa7:8f08:: with SMTP id x8mr343886pfr.48.1569254428418;
 Mon, 23 Sep 2019 09:00:28 -0700 (PDT)
Received: from [172.20.32.216] ([12.157.10.118])
 by smtp.gmail.com with ESMTPSA id k66sm12398132pjb.11.2019.09.23.09.00.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 23 Sep 2019 09:00:27 -0700 (PDT)
Subject: Re: [PATCH v3 08/20] cputlb: Disable __always_inline__ without
 optimization
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20190922035458.14879-1-richard.henderson@linaro.org>
 <20190922035458.14879-9-richard.henderson@linaro.org>
 <4c505d4b-751e-911d-4b2e-fe90a9d5ab02@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <ce2f8cc3-a97a-b15f-2816-b85d66bc7c17@linaro.org>
Date: Mon, 23 Sep 2019 09:00:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4c505d4b-751e-911d-4b2e-fe90a9d5ab02@redhat.com>
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
Cc: alex.bennee@linaro.org, stefanha@redhat.com, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/23/19 2:45 AM, Paolo Bonzini wrote:
> On 22/09/19 05:54, Richard Henderson wrote:
>> +/*
>> + * Forced inlining may be desired to encourage constant propagation
>> + * of function parameters.  However, it can also make debugging harder,
>> + * so disable it for a non-optimizing build.
>> + */
>> +#if defined(__OPTIMIZE__) && __has_attribute(always_inline)
>> +#define QEMU_ALWAYS_INLINE  __attribute__((always_inline))
> 
> GCC doesn't have __has_attribute, does it?

It does, since at least gcc 5.  And now I realize that's only a reorganization
of the support and not when it was introduced.


r~

