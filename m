Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB83C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 08:28:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55801206F4
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 08:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K6d2CCl7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55801206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWcOe-00053W-GW
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 03:28:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50594)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iWcNt-0004cK-Rx
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 03:27:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iWcNs-0004Pz-8g
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 03:27:45 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44543)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iWcNs-0004P0-1K
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 03:27:44 -0500
Received: by mail-wr1-x441.google.com with SMTP id f2so18286791wrs.11
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 00:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=D7E3mSXk+9iqRo7juCss/oKKfpl7GzLAFglXgBjlJ/A=;
 b=K6d2CCl7ayppFEHe1RbbDybKVXAhgIocoSk36PB7Wv5YQ97VEd/gScaRd9XkTV1QKg
 iLUxwcC7h16wEgswgV1TjWHBFfoE1p9RJaFsnebKBb5yF6CA7FscJEkKvItxkOrgIH/o
 rFeoaUWVgYiyEY4A21aHmppJNSoLTRddXFyFAnBy7qhw/wBVFs2cH6u8GShEXSDDqAMs
 XEUz8otnXz+fZOU9jwOTYcZXjZRCIW5p9k6VwvHcdpa3GiBi2VWlT42PP4n8Ojuo+fFb
 cOS+pSSjpJTacpyr3ycf7Egiv15iEUyTwkw4iO133WhoKTVjqstbFJoFo3DdPqY+8183
 QxdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=D7E3mSXk+9iqRo7juCss/oKKfpl7GzLAFglXgBjlJ/A=;
 b=NRQ4MJ70o4bUpJ8/JjrtAnEOqUjIzodLwYQyyYyUys9QtychZ7hHA0jecb74k35Q2W
 8+0zv6XrT+uq3EtVqW3/N85DtdcPa2YvQroLj7MQ0hzluPH6MyQIZGr3+2X18KVcbWrY
 ggKF/hPzJFoAz2VsAV72qgazOO+6Q9PPJO3/PKwbXXGdJrVcTIMvtIqLPFKy55qqnMmm
 hVjhnv3hoO/SR1bXEfvEYd9sWt1wT4Wjn1idBcqnBWybYwEzjRLX+qN/nawR/fTrN4Xy
 BvlANsyeAHRRrZxK2rrR15PiUAXuLhF4aaAkyvZoY+XULtT1+rb/ylQwyLZrMWXRl+Cr
 tFsA==
X-Gm-Message-State: APjAAAV+acdojturjg8qO8hQh/MgYl2HlyN8MS+bBQa9Uq2OSnvqN3Z5
 zlwf7f+ge6yTcsdLUPJrN7Ol0Q==
X-Google-Smtp-Source: APXvYqwIwzALpAkzeLNGAKuLT8JYxv6zvsMLH11Mn87tM4YuCXkzhisVBOyBFETelfu5QnsEbJA84g==
X-Received: by 2002:a5d:6706:: with SMTP id o6mr7956475wru.54.1574065662743;
 Mon, 18 Nov 2019 00:27:42 -0800 (PST)
Received: from [192.168.8.102] (65.red-79-149-41.dynamicip.rima-tde.net.
 [79.149.41.65])
 by smtp.gmail.com with ESMTPSA id f19sm24637730wrf.23.2019.11.18.00.27.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 18 Nov 2019 00:27:42 -0800 (PST)
Subject: Re: [PATCH v2] target/arm: Merge arm_cpu_vq_map_next_smaller into
 sole caller
To: Andrew Jones <drjones@redhat.com>
References: <20191116110642.12454-1-richard.henderson@linaro.org>
 <20191118075822.ztgoawpm7ljthiw7@kamzik.brq.redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <9315f613-346f-20a9-5010-f755d67f9a0f@linaro.org>
Date: Mon, 18 Nov 2019 09:27:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191118075822.ztgoawpm7ljthiw7@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/18/19 8:58 AM, Andrew Jones wrote:
> On Sat, Nov 16, 2019 at 12:06:42PM +0100, Richard Henderson wrote:
>> Coverity reports, in sve_zcr_get_valid_len,
>>
>> "Subtract operation overflows on operands
>> arm_cpu_vq_map_next_smaller(cpu, start_vq + 1U) and 1U"
>>
>> First, the aarch32 stub version of arm_cpu_vq_map_next_smaller,
>> returning 0, does exactly what Coverity reports.  Remove it.
>>
>> Second, the aarch64 version of arm_cpu_vq_map_next_smaller has
>> a set of asserts, but they don't cover the case in question.
>> Further, there is a fair amount of extra arithmetic needed to
>> convert from the 0-based zcr register, to the 1-base vq form,
>> to the 0-based bitmap, and back again.  This can be simplified
>> by leaving the value in the 0-based form.
>>
>> Finally, use test_bit to simplify the common case, where the
>> length in the zcr registers is in fact a supported length.
> 
> I don't see test_bit() getting used in the changes below.

Argh!  It's still uncommitted here in my tree.
I guess I forgot the -a on the git commit --append?

V3 coming up...


r~

> 
>>
>> Reported-by: Coverity (CID 1407217)
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>
>> v2: Merge arm_cpu_vq_map_next_smaller into sve_zcr_get_valid_len,
>>     as suggested by Andrew Jones.
>>
>>     Use test_bit to make the code even more obvious; the
>>     current_length + 1 thing to let us find current_length in the
>>     bitmap seemed unnecessarily clever.
>>
>> ---
>>  target/arm/cpu.h    |  3 ---
>>  target/arm/cpu64.c  | 15 ---------------
>>  target/arm/helper.c |  8 ++++++--
>>  3 files changed, 6 insertions(+), 20 deletions(-)
>>
>> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
>> index e1a66a2d1c..47d24a5375 100644
>> --- a/target/arm/cpu.h
>> +++ b/target/arm/cpu.h
>> @@ -185,12 +185,9 @@ typedef struct {
>>  #ifdef TARGET_AARCH64
>>  # define ARM_MAX_VQ    16
>>  void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp);
>> -uint32_t arm_cpu_vq_map_next_smaller(ARMCPU *cpu, uint32_t vq);
>>  #else
>>  # define ARM_MAX_VQ    1
>>  static inline void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp) { }
>> -static inline uint32_t arm_cpu_vq_map_next_smaller(ARMCPU *cpu, uint32_t vq)
>> -{ return 0; }
>>  #endif
>>  
>>  typedef struct ARMVectorReg {
>> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
>> index 68baf0482f..a39d6fcea3 100644
>> --- a/target/arm/cpu64.c
>> +++ b/target/arm/cpu64.c
>> @@ -458,21 +458,6 @@ void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
>>      cpu->sve_max_vq = max_vq;
>>  }
>>  
>> -uint32_t arm_cpu_vq_map_next_smaller(ARMCPU *cpu, uint32_t vq)
>> -{
>> -    uint32_t bitnum;
>> -
>> -    /*
>> -     * We allow vq == ARM_MAX_VQ + 1 to be input because the caller may want
>> -     * to find the maximum vq enabled, which may be ARM_MAX_VQ, but this
>> -     * function always returns the next smaller than the input.
>> -     */
>> -    assert(vq && vq <= ARM_MAX_VQ + 1);
>> -
>> -    bitnum = find_last_bit(cpu->sve_vq_map, vq - 1);
>> -    return bitnum == vq - 1 ? 0 : bitnum + 1;
>> -}
>> -
>>  static void cpu_max_get_sve_max_vq(Object *obj, Visitor *v, const char *name,
>>                                     void *opaque, Error **errp)
>>  {
>> diff --git a/target/arm/helper.c b/target/arm/helper.c
>> index be67e2c66d..b5ee35a174 100644
>> --- a/target/arm/helper.c
>> +++ b/target/arm/helper.c
>> @@ -5363,9 +5363,13 @@ int sve_exception_el(CPUARMState *env, int el)
>>  
>>  static uint32_t sve_zcr_get_valid_len(ARMCPU *cpu, uint32_t start_len)
>>  {
>> -    uint32_t start_vq = (start_len & 0xf) + 1;
>> +    uint32_t end_len;
>>  
>> -    return arm_cpu_vq_map_next_smaller(cpu, start_vq + 1) - 1;
>> +    start_len &= 0xf;
>> +    end_len = find_last_bit(cpu->sve_vq_map, start_len + 1);
>> +
>> +    assert(end_len <= start_len);
>> +    return end_len;
>>  }
>>  
>>  /*
>> -- 
>> 2.17.1
>>
>>
> 
> Besides the commit message referencing test_bit, but no use of it, this
> looks good to me
> 
> Reviewed-by: Andrew Jones <drjones@redhat.com>
> 


