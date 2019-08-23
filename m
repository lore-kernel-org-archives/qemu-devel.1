Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05EDC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:42:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB2CC21019
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OJpEmtKu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB2CC21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1Bhq-0003Xe-0c
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 11:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60961)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i1BVY-000750-3h
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:29:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i1BVX-0002ni-7G
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:29:44 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:44079)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i1BVW-0002nN-Vl
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:29:43 -0400
Received: by mail-pf1-x443.google.com with SMTP id c81so6659661pfc.11
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 08:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=poKZlbpCTk8gimLVvqHJjmEAdbcr1/K9oxR2glqA8zQ=;
 b=OJpEmtKuHRwm16h1Nl7vTDoOKaSfzE1xIANsy5V/y8dyBkcrpwzk7ngIMasceAlgJe
 WK05SYPOE/LOCTfDqqiB3J3dVN1tAKVIoRWCZn28BqDtVSqZzB5536kkBuG9RlHuVykE
 vWVgNOJuSgum9JKV6EVsisvRbyqmpaWDVRe8SaiQsGvNz0s9xzF8tDJUC5oVehpsm0th
 VP8aow+CXE3BL1YpkmvoehaYyymgK3Rngc2TmRUkQHPO8QEWqkUebHQkR1nJWjLPwR6A
 NIxuUvSjgjBhJgN47beLGxumcSFj+JrKGbNzOw3IS9MG1MIqmt2UrXyvkSzJv56qkRyf
 bWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=poKZlbpCTk8gimLVvqHJjmEAdbcr1/K9oxR2glqA8zQ=;
 b=laWf4/1aoR5VpbeeVL9hvUSNa1NYM8yE4Qm6HJAPtYh6ung/HTv36rcOiflsxyLcBJ
 hvq7MlXq3cZBDUitSYEWpLwvV4QqLOZCbARKvYsigcPhyGwXvpUiVPXChbENMKMrAD/o
 JfaatGBuSxj7FphCg34qhutmTWMlay7Eyvp97Hqiqt8eZyjxuTmditrY20O+JsxBnECW
 pr+l1SXz8QZ/33e4RdAZE6OFetnuWT8O0WAO7aNmL1Ni31IKly1flH61rvJiSl47eufT
 ZlVKfSrhF7Gw1MO+THO+KhNDKcuXgxbPoulOecCsMVEGk1Sppw5PO3at/ApnGGZ/0pMw
 wQXQ==
X-Gm-Message-State: APjAAAU41waiBLoqNKmR4KNcIGbdP6tjE9Q+VygX/PZXr/0w2TisG+er
 oaSMmsmwJJgD3rmK76kjZ0oVAg==
X-Google-Smtp-Source: APXvYqyyw+ehuqo1sUImScMUdKMN/ImHXtGKybVl09F0V6LCMdTMD7brP385jXMoqAD4FOlLqucTGw==
X-Received: by 2002:a65:6284:: with SMTP id f4mr4644966pgv.416.1566574181684; 
 Fri, 23 Aug 2019 08:29:41 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id br18sm3201940pjb.20.2019.08.23.08.29.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 23 Aug 2019 08:29:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190823100741.9621-1-david@redhat.com>
 <20190823100741.9621-5-david@redhat.com>
 <ae881524-d745-c8e1-5765-157962d2b157@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <47c65454-f624-1b84-6810-7ac77ae9ce5f@linaro.org>
Date: Fri, 23 Aug 2019 08:29:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ae881524-d745-c8e1-5765-157962d2b157@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v1 4/9] tcg: Enforce single page access in
 probe_write() for !CONFIG_USER_ONLY
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
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-s390x@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/23/19 8:28 AM, Richard Henderson wrote:
> On 8/23/19 3:07 AM, David Hildenbrand wrote:
>> While the CONFIG_USER_ONLY variant can handle multiple pages (no MMU), the
>> !CONFIG_USER_ONLY variant can't and won't. We'll want to convert
>> probe_write() to return a host address (similar to tlb_vaddr_to_host())
>> soon. This only works on page granularity.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  accel/tcg/cputlb.c | 2 ++
>>  1 file changed, 2 insertions(+)
> 
> As I just mentioned in the previous, I think the two implementations should match.
> 
> Anyway, the "multiple pages" thing above still means exactly two, since if
> there were three pages involved we were only probing two of them, and the third
> could still be unmapped.

Oh, but the actual code here, is fine.
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


