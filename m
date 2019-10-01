Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BE6ECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 15:04:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89AE020679
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 15:04:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j4zixZk6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89AE020679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFJhF-0004ov-FV
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 11:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42460)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iFJfu-0004F8-Ri
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 11:02:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iFJft-0005ok-KO
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 11:02:50 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:33591)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iFJft-0005nq-AJ
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 11:02:49 -0400
Received: by mail-pf1-x443.google.com with SMTP id q10so8215787pfl.0
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 08:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=uUlH9siQyuFoZKL5TvfF0WXHYXLRpTR6mgnVnxWFD3w=;
 b=j4zixZk6Yd/Dy/PBG4I+QxYknHXieQlH+h4pcLbeJ5vHX6qN1H+vsiTVl27X9Ly5GC
 9E13R7hrF/itIqEPt++kIT/xySs8TzGAc1sYoqNBu/Y9wZ4RRMsXlD+muNtjK1LxqnBK
 cv5VqH+1UwZsKmUmgSuT7/H993jj8K7ApcyPN6Lq7VqlrB2iBf45hbtlS7KGXiSDzSkO
 16uNm3hr/2L1EiHu9HluDJN0zUyIPYAdZgzYZOiYDzMBAlJYUcs6Xrjm1VZh0yOFTeQg
 vVfq8ygycGOWJIl/0oXagqZ+oYwRqOoHx2uOS/ALXJHLU4mtMgvkps/6zrTBUU/egBJD
 4J3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uUlH9siQyuFoZKL5TvfF0WXHYXLRpTR6mgnVnxWFD3w=;
 b=WGFafVamM8uxaZeAqCn44FnsJsBHrUFOST3nln54XZbEMyaWXjzsLBcuNEIYDcMANZ
 67//Qz/eSQo2o5jut3RUjaCMt8GEnwIdiGFroU6CFcwKRuLn2ziq5tC9boJVvPYJHAUA
 lAjthroMqmhv9sFFi9OhdsWeVEWTHPqxUhR7GmnB77FT0xXmv5Ujqn3zC3NOvPJQ46Wp
 YUz0XGB/Z7A2B5D11kk+n25n+7mJC24k0nMCNte2mZdvKz4plAsATLcUtGdODSGPrxLf
 5aG0IKEzn+DWksvmAPspQEDqkmT9x6yVljpPix3QcuTDXjz8NklXc0ob3NjToMjADGJz
 /0cg==
X-Gm-Message-State: APjAAAXBk87p9sjRvbLKphwhBFXlJm7aeWJn5n1/icdOsfp/4Z7OmCkZ
 U/I1YSbvamsUvozpkcUDVWy8sw==
X-Google-Smtp-Source: APXvYqxnZE9IWeGItUIK77oBnUBdby4pSw9cnVBd5+rVuyhAt4VESw1/GM1jjsmhl2c+Mle5RBOdEQ==
X-Received: by 2002:a63:4e44:: with SMTP id o4mr30498248pgl.103.1569942167937; 
 Tue, 01 Oct 2019 08:02:47 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id r185sm16865666pfr.68.2019.10.01.08.02.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 01 Oct 2019 08:02:47 -0700 (PDT)
Subject: Re: [PATCH v4 00/18] target/s390: Use tcg unwinding for ilen
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190927193925.23567-1-richard.henderson@linaro.org>
 <82c5292f-3c57-24d2-2237-d8058014243a@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <1058cc2e-6ec3-384a-ac70-1be46312dc96@linaro.org>
Date: Tue, 1 Oct 2019 08:02:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <82c5292f-3c57-24d2-2237-d8058014243a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/1/19 1:07 AM, David Hildenbrand wrote:
> On 27.09.19 21:39, Richard Henderson wrote:
>> Based-on: <20190925125236.4043-1-david@redhat.com> \
>>   ("s390x/mmu: DAT translation rewrite")
>>
>> Based-on: <20190926101627.23376-1-david@redhat.com> \
>>   ("s390x/mmu: Implement more facilities") \
>>   With the suggested follow-up for patch 2 re ilen.
>>
>> Which should mean that this applies on top of David's
>> current s390x tree.  ;-)
> 
> Indeed, both are located at
> 	https://github.com/davidhildenbrand/qemu/tree/mmu
> 
> Once I have more feedback on "s390x/mmu: Implement more facilities", I
> am going to pick up this series and give it a good test. Then send it
> upstream (either via Conny, due to the CPU model change, or directly).
> Sounds good?
> 

Yep, thanks!


r~

