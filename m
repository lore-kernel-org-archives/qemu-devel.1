Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D128C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 15:14:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36AD221848
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 15:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HG0d2xVD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36AD221848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAy91-0003ub-A1
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 11:14:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34225)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iAy7q-0002hR-A1
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 11:13:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iAy7p-0006NM-Af
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 11:13:42 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:37327)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iAy7p-0006N4-3r
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 11:13:41 -0400
Received: by mail-pg1-x541.google.com with SMTP id c17so2083336pgg.4
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 08:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=YWZQAR4nNPGNzbWZCC+dgJTyUlz1aq8g6PTYCWu7BB4=;
 b=HG0d2xVDRCfQkptARtsn+Ns0j1LUGA7hJHr3Kme37lh2NPRbIqvDMoSse4MNUVMxZT
 w8UfI5m+KhId+VXaNxPVplGc0BTl/+mq49sbYhQ2eTgc/TI+biiooqbf77K789a80MmY
 wKsZGE7SYzSAI2NUZrnD6YDdRNXrnNxwBCkfzpyCe79PDHXnDFEC+uLMe6CIOD6UP8Z6
 4oxwKNxxa910bCzEslVz708IY1Qmv3BikAUKC7hsYY2LHRoNPSAVJYZtVMVyNjIVbx17
 cJ4vjrP4OX//Ztq+s7HDOxxWI2IF6uO0wL0MwiXCePrQcyXqECYQBTrfXZTikUw9zaP1
 9MxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YWZQAR4nNPGNzbWZCC+dgJTyUlz1aq8g6PTYCWu7BB4=;
 b=SM86yQY1pcSepxTwvBwW1usB3wOcg/UWI3cGOsy1LlREuKiQWofv6BQCNrIt5EyrhK
 d6HFS2ZI0pBVfcFlRaZIRYAIr4DphBXzVMiwFwSMNn0W3T2Sr9AweU1FC19524Rcd8ge
 V7tZQLeK3z8xW11IvU9h754luxMzrBSOL6TTn7tPgQPohM2LQisn7+5MdY8bq6OyLHUx
 4PMtztiDLvBJblzfmktMqrBDRgSFL/RW7ZwS9vV1RNjEb2iIA+HY9tYgTK1DWkFSulhb
 HwaSZ9Z5UPirLJ6IOJkprlQexAiqlTyZuGeAPKvis8GkAd8bQKh90WyO6neI9j4WBVjg
 itrw==
X-Gm-Message-State: APjAAAWJDFqVBjg6X0RXi2wpaEraxAlxVIviEFWROiVlumU8SGrydBjX
 9hwEoU9qW8FL1Z6Y9lkkftPKlg==
X-Google-Smtp-Source: APXvYqx6rZh39DCDigCmH2E3devIBT8Eth6gWmbOj4urjXoqjVODBSchtuJvmjcl15FFe9LSaVnmaQ==
X-Received: by 2002:a17:90a:9a8b:: with SMTP id
 e11mr4165142pjp.98.1568906019668; 
 Thu, 19 Sep 2019 08:13:39 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id h4sm18585308pgg.81.2019.09.19.08.13.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 19 Sep 2019 08:13:39 -0700 (PDT)
Subject: Re: [RFC v2 3/5] cputlb: Introduce TLB_BSWAP
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190918180251.32003-1-richard.henderson@linaro.org>
 <20190918180251.32003-4-richard.henderson@linaro.org>
 <1b0987d1-2606-8278-374b-8e383aec3c51@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <6faa10ae-5c98-777f-4bbc-692ec6aab511@linaro.org>
Date: Thu, 19 Sep 2019 08:13:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1b0987d1-2606-8278-374b-8e383aec3c51@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/19/19 8:09 AM, David Hildenbrand wrote:
> On 18.09.19 20:02, Richard Henderson wrote:
>> Handle bswap on ram directly in load/store_helper.  This fixes a
>> bug with the previous implementation in that one cannot use the
>> I/O path for RAM.
>>
>> Fixes: a26fc6f5152b47f1
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  include/exec/cpu-all.h |   2 +
>>  accel/tcg/cputlb.c     | 105 +++++++++++++++++++++--------------------
>>  2 files changed, 57 insertions(+), 50 deletions(-)
>>
>> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
>> index d2d443c4f9..3928edab9a 100644
>> --- a/include/exec/cpu-all.h
>> +++ b/include/exec/cpu-all.h
>> @@ -331,6 +331,8 @@ CPUArchState *cpu_copy(CPUArchState *env);
>>  #define TLB_MMIO            (1 << (TARGET_PAGE_BITS - 3))
>>  /* Set if TLB entry contains a watchpoint.  */
>>  #define TLB_WATCHPOINT      (1 << (TARGET_PAGE_BITS - 4))
>> +/* Set if TLB entry requires byte swap.  */
>> +#define TLB_BSWAP           (1 << (TARGET_PAGE_BITS - 5))
> 
> Shouldn't you also take care of TLB_BSWAP in probe_access?

Yes, I should.  I guess like TLB_MMIO and return NULL.  Thanks.

>> +        if (unlikely(tlb_addr & TLB_BSWAP)) {
>> +            return direct_swap(haddr);
>> +        } else {
>> +            return direct(haddr);
>> +        }
> 
> You can drop the else statement and just return.

Sure.

> I assume this patch does not yet result in the issues you are
> experiencing, right?

Correct.  It is only the last patch here that has problems.


r~

