Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D71FC54FCB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 16:52:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CF062080C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 16:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="soVdPXk0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CF062080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT706-0008D7-C3
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 12:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50972)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jT6t2-0003ug-N2
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 12:45:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jT6t1-0000C6-GZ
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 12:45:40 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:35621)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jT6t1-00009K-1X
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 12:45:39 -0400
Received: by mail-pf1-x444.google.com with SMTP id r14so9266307pfg.2
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 09:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=nY4WAPPvJj0E1d2OBpT0hEobW4iCmcMkCcfKzd/kz+4=;
 b=soVdPXk03IZ01AvyeNo+4syJLwjbZqBG5nsQZafH9yDKdiQxZcrUY8S1Vrh9OTRk90
 /O92eVgvHy1SdFPGdMtFeL4/h0MIV/N3MGnEup8sYvAznXv1oKuAnY16g3hdnRIKZBGy
 Gbbpof0KM2V7D7snx+xj5/j0e8S+IUgmow+TU/cBDOeqn22YdTZG90nHAPmPxjzP0hZr
 O3AmJiOVkYsaLIZSM+4I6K5h1QvYM1BgMaJ2cn6KYJYJ2bf5MHliEA1Ljg7YQkIJhhw+
 cDZ2yHHAZEt0UlRPK+55Li2LCEb1S40E6F+bhjgT+8D9EB7DCVR7vSKtxEx2WQSGFDg9
 t7RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nY4WAPPvJj0E1d2OBpT0hEobW4iCmcMkCcfKzd/kz+4=;
 b=F2HoPzz90rLyfds26PBdh/RzM/eGlbtvTDTFJIxksc8AaUszXsRTbSfo6Plqhcq+GV
 CaYCvRUZNMXcRIikA8dcFStwK3OfOd0R3v8NkJRyCsMmzgirrHpDlgLwPO7B/72c6SSZ
 30puLUFGbWWoSy220KMl2BPBgNmLsfEBR7y1ukBEKPNtZoeHmH4jJE3Vdm5Qe5iQWCsd
 x7UHq2Ogans7Yye9B/myopu/kQulN8NJUgl8n1FZZwYOePZZfC7y+8+ov9aImXafneq8
 cbvbr3jTDveWPL4Yd8nHHsPjc+0KoXvRB67Cs55TYLZEgXOPd2reKXJYNa0wHuLhot/g
 UVlA==
X-Gm-Message-State: AGi0Pubu1ZM4wXkeES+VUWZN+soJcEHwFBrAU3+RR7F7CaxiOEC96846
 u2Vo/kr79ygmjwEUHrYuNkkPIQ==
X-Google-Smtp-Source: APiQypK7VrE/Xp2JLrxVK5rF9WlW9COD1LLZfiuLN4lag9huA3lhwP2f/2+ASXgrY0yjTP0nBfTH+g==
X-Received: by 2002:aa7:962c:: with SMTP id r12mr25644732pfg.232.1588005937049; 
 Mon, 27 Apr 2020 09:45:37 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id w9sm13177437pff.101.2020.04.27.09.45.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2020 09:45:36 -0700 (PDT)
Subject: Re: [PATCH v3 13/18] target/arm: Update contiguous first-fault and
 no-fault loads
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200422043309.18430-1-richard.henderson@linaro.org>
 <20200422043309.18430-14-richard.henderson@linaro.org>
 <CAFEAcA8oWP9XGzD+pb_VhDth8zx8j1Gz4vwiK+dArpw8x1BmqA@mail.gmail.com>
 <22c1fd55-7cd3-6320-1f90-40d1bd2cc883@linaro.org>
 <CAFEAcA-iqrEi_wQ+mBN1NtrEKq3uDYPoDunqW5e9KV6ivz3-SQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d148806b-c7f1-fefc-bfb4-fcefb81ab509@linaro.org>
Date: Mon, 27 Apr 2020 09:45:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-iqrEi_wQ+mBN1NtrEKq3uDYPoDunqW5e9KV6ivz3-SQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/27/20 9:32 AM, Peter Maydell wrote:
>>>> +     * From this point on, all memory operations are MemSingleNF.
>>>> +     *
>>>> +     * Per the MemSingleNF pseudocode, a no-fault load from Device memory
>>>> +     * must not actually hit the bus -- it returns (UNKNOWN, FAULT) instead.
>>>> +     * If you map non-RAM with Normal memory attributes and do a NF
>>>> +     * load then it should access the bus -- but doing so is illegal.
>>>> +     *
>>>> +     * While we do not have access to the memory attributes from the PTE
>>>> +     * to tell Device memory from Normal memory, we can validly assume that
>>>> +     * non-RAM has been mapped as Device memory.  Thus we indicate fault
>>>> +     * on all MMIO.
>>>
>>> I still don't understand why this is right. All non-RAM is MMIO
>>> but not all MMIO is non-RAM; so you might have something that's
>>> MMIO (at least for the moment) and has been mapped Normal. That
>>> shouldn't fault.
>>
>> Everything that must go through the slow path has TLB_MMIO set.
> 
> Yes. But not everything that goes through the slow path is Device memory.
> We can (should) fault on all accesses to Device memory, but we can't
> fault on all accesses that are slow-pathed, because some of them could
> be entirely valid Normal memory.

We *can* indicate fault from MemSingleNF for any reason whatsoever, or no
reason whatsoever.

> // Implementation may suppress NF load for any reason
> if ConstrainUnpredictableBool(Unpredictable_NONFAULT) then
>   return (bits(8*size) UNKNOWN, TRUE);

What I'm trying to talk about above, is the third statement in MemSingleNF,

> // Non-fault load from Device memory must not be performed externally
> if memaddrdesc.memattrs.memtype == MemType_Device then
>   return (bits(8*size) UNKNOWN, TRUE);

and the reason we can't actually test MemType_Device here.

If you have better wording for that, I'm all ears.  But I don't think there's
an actual bug here.


r~

