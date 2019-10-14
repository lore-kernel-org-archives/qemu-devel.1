Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592C0C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:41:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CADE20873
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XIEVd9Y8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CADE20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK4LI-0000iI-0O
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 13:41:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50213)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iK4Jd-0007hL-Da
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 13:39:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iK4Jc-0006W3-9k
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 13:39:29 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:36243)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iK4Jc-0006Ty-3i
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 13:39:28 -0400
Received: by mail-pf1-x441.google.com with SMTP id y22so10789282pfr.3
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 10:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=lxNaEz28se1qnVDOSJkdka+thu7Uz5/TIUr18FXjuxA=;
 b=XIEVd9Y8VuU/daW2J8qgpIvzHZuOvm55nvqTBmWuHIb9GoTNQBzUCYQMAGLYnWKeNZ
 /OO/qBq+Mau6ndMqpQTLSv+g/3jg5yiFnfTVFqpFEdCjXFq/e3SPJzlVORd1/ej0qe4j
 0KQe4etCf97oWK+2EuQKs6S1u4aflPGwI+p+3JNaE0psvZMXtcmFwtDwdM/KIFSgwUT9
 y/Bwy8C6mcctFPmmfQoTxIK0EUXkDzn7SS2/DYtJOh+N3XwSMVAYectXrpsTLfYtFHXk
 GniREqZQtCFv0hl2uIqYsSPP0YmUTnAk1CE+FHHxvDb3DdLWUsCI6MypE8FT+XnrjdFl
 Hh1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lxNaEz28se1qnVDOSJkdka+thu7Uz5/TIUr18FXjuxA=;
 b=WwmrpuUwt/s4aScLM2Df6jPhw8sxQ/Khj/4d0uXNBwsrSJfT0fHnRyRvt5OmRV6+XC
 5A+bj59TylT+xoU10hNGokyZcxAhTjficGT5zBKzw/l3BEAQ5/hSvkDz0JuB1/6jqqhI
 CZAHSpx9choajE9k8uy8fP//BQcCXE5RKQEKamYldajcW6f1bMdf/+9QOxTNU8IQFLKb
 PQ9jKjeEZ4hm0Ue9sqv7XEioqNeoUrwOhDP2bkvjpApl1ZEAGCyGK2mteuiKizBGKy7h
 vJ4YcRWXzGeHshhm97NYKc3ZP8bkwtdFvPz3zJA+IgbZsCud+B01wYLgt+/ayNz8OODW
 4qeQ==
X-Gm-Message-State: APjAAAVIelzz4y+Q2u24ZvBEiBZqF9vSXuW7SZYXTTr8L3mFajxeLdxu
 6S9PJ1u3p03HqZqU9VQeKHXw7g==
X-Google-Smtp-Source: APXvYqxgosZ3o8Fdm0fPrv0C7BMm8GGnWXQrR6ciBbvUPk73oyVzlvkdSRgIwQuOV9fHsMLlxspxHQ==
X-Received: by 2002:a65:68c2:: with SMTP id k2mr33871354pgt.241.1571074766494; 
 Mon, 14 Oct 2019 10:39:26 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id l72sm25239015pjb.7.2019.10.14.10.39.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 14 Oct 2019 10:39:25 -0700 (PDT)
Subject: Re: [PATCH v5 52/55] plugins: make howvec plugin more generic
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20191014104948.4291-1-alex.bennee@linaro.org>
 <20191014104948.4291-53-alex.bennee@linaro.org>
 <a05f8601-7c93-8861-4935-6806f5ae3ec3@linaro.org> <87imormeq8.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <af41f3d5-1376-a593-645a-fe863d04b4b3@linaro.org>
Date: Mon, 14 Oct 2019 10:39:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <87imormeq8.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: aaron@os.amperecomputing.com, cota@braap.org, qemu-devel@nongnu.org,
 peter.puhov@futurewei.com, robert.foley@futurewei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/19 10:14 AM, Alex Bennée wrote:
>>> -    /* we expect all instructions to by 32 bits for ARM */
>>> -    g_assert(qemu_plugin_insn_size(insn) == 4);
>>> +    /*
>>> +     * We only match the first 32 bits of the instruction which is
>>> +     * fine for most RISCs but a bit limiting for CISC architectures.
>>> +     * They would probably benefit from a more tailored plugin.
>>> +     * However we can fall back to individual instruction counting.
>>> +     */
>>>      opcode = *((uint32_t *)qemu_plugin_insn_data(insn));
>>
>> This totally ignores the endianness of the host.
>> I'm not keen on reading more than the number of
>> bytes in the insn either...
> 
> I guess we can strncpy the data and ensure it is NULL terminated and use
> the "string" hash function instead. It depends if there are many opcode
> strings with NULL's in them.

Um, plenty.  E.g. "adrp x0, ."


r~


