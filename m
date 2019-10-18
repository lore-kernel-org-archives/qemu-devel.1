Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFF6CA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:50:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8AAA21D7C
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BPPRIdXP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8AAA21D7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41275 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLTaG-0008TD-LY
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 10:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36252)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iLTXC-0005hi-Af
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:47:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iLTXA-0001Em-SJ
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:47:17 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:46611)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iLTXA-0001BU-29
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:47:16 -0400
Received: by mail-pg1-x542.google.com with SMTP id e15so3484895pgu.13
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 07:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=K2Vvc+S/UnKmPbfZ3+bzxYzKb19mODDOoIc/zGxqYmw=;
 b=BPPRIdXP9t5jUJONY5qgh6FBuvSNeWsySFNVhI9POJ5lj/Ew/RXPBCvB/tzCpNB9JA
 Hobn7WscmqY9Ogf5IRzOKaaN6QnL/YLAq1S5F0ogGPLAR3EOddeoWB/3OqelNhv3mCwN
 uxfpdcSVonkC0b+yrhEs5GcaObFtEFiayLl27KvOhN7ap3h9pQDRz7SuEHQ0DUFb3YeZ
 7NrmqpP4WjeJ4cFVC/8RNuwrHPYtNmtxSwRIx6/bgSZUfbFAXf55sw6NfuGRvGxDxD7k
 1yXsvZ3iyBz5ZdLPLiVG2COacmoBiC9lYE1tlG9+Fa7/B6arim5YNqtue6nFN++hTGqV
 81JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=K2Vvc+S/UnKmPbfZ3+bzxYzKb19mODDOoIc/zGxqYmw=;
 b=Ja7JseySc/4kMVUPzO0R9Eu2b6qu5/Rvqpk5C7/xzIQllX1yzW5ND3fYeMY+7zwiqM
 xS/zlrr7hgebtRjjWdkT46X05FszJ/SMtGRUKES3Lq8pN0cHOF2EciIwAiLRyIlCQ+sS
 hCCwyOBE7ZHsygcewZVW9hL15hXb/fAeoeSRqEmCQn5IBuDdajjbIfJq9MeAiXlYEK0n
 kn7Qg24h1KRBH011wo2ZI2H5+j0/HTKd3k2sxW5uffihP4FfrZqS1fsh9GJzusedkLUh
 +L9hv9LxQvRPutNelnDnfkodvo7zhezejCagXV0XcWOuqtdIsdYO78ADdkOQD030AezG
 6xjg==
X-Gm-Message-State: APjAAAXXCEn1Xr84sDvJssf+btLQhjKNtSHdO144woVmsHlKYiWDFXvp
 mNU2u/Uf21y2G4y/NasWJyhfsw==
X-Google-Smtp-Source: APXvYqwUfEEeafUMCgKyuQfNVxR1okDHWt8hcMXGfP8AF6han0JNmiTIsK8l86N1ITduvGNRKvlXDQ==
X-Received: by 2002:a63:165b:: with SMTP id 27mr10505348pgw.420.1571410034759; 
 Fri, 18 Oct 2019 07:47:14 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 16sm6765304pfi.55.2019.10.18.07.47.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Oct 2019 07:47:13 -0700 (PDT)
Subject: Re: [PATCH 1/4] target/arm: Vectorize USHL and SSHL
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191017044232.27601-1-richard.henderson@linaro.org>
 <20191017044232.27601-2-richard.henderson@linaro.org>
 <874l07pdio.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <754b51c2-fa2b-bb30-6395-411e7668bb64@linaro.org>
Date: Fri, 18 Oct 2019 07:47:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <874l07pdio.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/17/19 9:01 AM, Alex Bennée wrote:
>> +    /*
>> +     * Rely on the TCG guarantee that out of range shifts produce
>> +     * unspecified results, not undefined behaviour (i.e. no trap).
>> +     * Discard out-of-range results after the fact.
>> +     */
>> +    tcg_gen_ext8s_i32(lsh, b);
>> +    tcg_gen_neg_i32(rsh, lsh);
>> +    tcg_gen_shl_i32(lval, a, lsh);
>> +    tcg_gen_shr_i32(rval, a, rsh);
>> +    tcg_gen_movcond_i32(TCG_COND_LTU, d, lsh, max, lval, zero);
>> +    tcg_gen_movcond_i32(TCG_COND_LTU, d, rsh, max, rval, d);
> 
> Do these get dead coded away if the shift is a const?

They would, although because of the form of the instruction, as a variable
shift from a vector element, I don't expect it to ever be const.  We will have
just read the value from env memory.


r~

