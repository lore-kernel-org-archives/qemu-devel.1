Return-Path: <SRS0=DnLG=2S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1110C2D0C8
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 20:48:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C489208C4
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Dec 2019 20:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TiH+iXXE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C489208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilJ0x-0006L1-JZ
	for qemu-devel@archiver.kernel.org; Sat, 28 Dec 2019 15:48:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35753)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ilJ0K-0005vE-VP
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 15:48:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ilJ0J-00031G-LS
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 15:48:08 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:39724)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ilJ0J-0002we-DE
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 15:48:07 -0500
Received: by mail-pf1-x442.google.com with SMTP id q10so16420638pfs.6
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2019 12:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=9YNMi9zFpWY5rgYTnqllXbCQfN/tUZVJtEWND4qVNA0=;
 b=TiH+iXXETMztuI/cK5lP38+3DxUYr/vDhIhllFXr4K5KXcTTrQTRFQ/B/chcyz/NQE
 M6139ofUe5lMB+ORj9O5BTOB7xDNDklaG0om2m8vxVdLPaLhUlnv3kf0Sbi/PoVWO/Jl
 pJJEezqzncEjCPcQiCQIq7Pd22/80fb2e/CI4L+WulRkarQdONu04A3KyylanJjxdMcZ
 VO9dFzJAC3k9A5kDIgo7ckArBy2FmVbQDRJslMQBxqlUhzmbSJJOoldGw/mf/nCXbj5j
 bZ1Dx2TKgo1D/fHYzysp3uUXJ7zsDQpfHKOPJ2DxMs4r+hkaClz454kiHZFLtEUYFRaI
 8PgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9YNMi9zFpWY5rgYTnqllXbCQfN/tUZVJtEWND4qVNA0=;
 b=hnlkbYCtKP6ze58sNYyKzNCaxmHpNQlYXfEhuk7uQt11t0X4OcfzO3iNO0HbDCl1/H
 AKB4JySsyr1OhEeclh3QZPoTbquIfV4DH/oOqYegkNkdz5AySwlzyOAT51zhhsV3B66S
 ZMPlnUmi6HwKHFsDTR5colH+l5rlDs7ycT9oHs1kYur0CJenF0pyO8etu5aZeGVfC+vA
 Z99qhkatM9Ar43qKsfkBQJDpSCTxGljk7IWDTFRlYBvR5Mi0QSpUnL6b0mKTWQ6My28t
 9B0OudH1hPFtdKh0DtWgCfoEShHQgWSj/ToQrz8gIdX615e5WLzpvO1UwUrfK/koi0ld
 sy5Q==
X-Gm-Message-State: APjAAAXcsGoWoE30htgleUh8MZILI4aCWeoE04QAeJKuJgbM2FWPBa8h
 RaHO3MSfEihRl0xdswI8aealAkjeVQ3gsg==
X-Google-Smtp-Source: APXvYqz/C01olTxtDTA8tAVKWlsI3e/O5LYgz/1rOyqUJy8cENs3mFM+2aEVn+7WoxIm0WBGE1ar9g==
X-Received: by 2002:aa7:92c2:: with SMTP id k2mr38344601pfa.93.1577566085922; 
 Sat, 28 Dec 2019 12:48:05 -0800 (PST)
Received: from [192.168.1.118] (194-223-58-9.tpgi.com.au. [194.223.58.9])
 by smtp.gmail.com with ESMTPSA id z30sm46389226pff.131.2019.12.28.12.48.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Dec 2019 12:48:05 -0800 (PST)
Subject: Re: [PATCH v2 03/28] trace: Remove trace_mem_build_info_no_se_[bl]e
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191216221158.29572-1-richard.henderson@linaro.org>
 <20191216221158.29572-4-richard.henderson@linaro.org>
 <8736dfdkb9.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <038a278b-cc59-1fcf-08d5-e34a97cbf3b1@linaro.org>
Date: Sun, 29 Dec 2019 07:48:00 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <8736dfdkb9.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/21/19 3:38 AM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> It is easy for the atomic helpers to use trace_mem_build_info
>> directly, without resorting to symbol pasting.  For this usage,
>> we cannot use trace_mem_get_info, because the MemOp does not
>> support 16-byte accesses.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  accel/tcg/atomic_template.h | 67 +++++++++++++------------------------
>>  trace/mem-internal.h        | 17 ----------
>>  2 files changed, 24 insertions(+), 60 deletions(-)
>>
>> diff --git a/accel/tcg/atomic_template.h b/accel/tcg/atomic_template.h
>> index 837676231f..26969487d6 100644
>> --- a/accel/tcg/atomic_template.h
>> +++ b/accel/tcg/atomic_template.h
>> @@ -64,13 +64,10 @@
>>     the ATOMIC_NAME macro, and redefined below.  */
>>  #if DATA_SIZE == 1
>>  # define END
>> -# define MEND _be /* either le or be would be fine */
>>  #elif defined(HOST_WORDS_BIGENDIAN)
>>  # define END  _be
>> -# define MEND _be
>>  #else
>>  # define END  _le
>> -# define MEND _le
>>  #endif
>>  
>>  ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, target_ulong addr,
>> @@ -79,8 +76,8 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, target_ulong addr,
>>      ATOMIC_MMU_DECLS;
>>      DATA_TYPE *haddr = ATOMIC_MMU_LOOKUP;
>>      DATA_TYPE ret;
>> -    uint16_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false,
>> -                                                           ATOMIC_MMU_IDX);
>> +    uint16_t info = trace_mem_build_info(SHIFT, false, 0, false,
> 
> What is MEND meant to be? Shouldn't we use the appropriate MO_TE instead
> of 0 for these helpers?

See the first hunk, where MEND is removed.  It's based on HOST_WORDS_BIGENDIAN,
so no we don't use MO_TE.


r~

