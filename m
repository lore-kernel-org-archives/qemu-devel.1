Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C65C4CEC6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 19:08:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B79A2081B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 19:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kvzIOYxR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B79A2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8URp-0005tX-KR
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 15:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36469)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i8UR6-0005Tl-Tw
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 15:07:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i8UR5-0006hT-Mz
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 15:07:20 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:38138)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i8UR5-0006gB-H3
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 15:07:19 -0400
Received: by mail-qk1-x744.google.com with SMTP id u186so1863594qkc.5
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 12:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=GLTNWMx+xJ5k8y3FvE8AjVRzOp9zp77o3il4ctxrWw0=;
 b=kvzIOYxRz70nR2Oz3cApH37igUVQSDPCbW51bO7hIVjlF/DuJf2CpIFJVdDTFT1a+0
 AXsgBU42dlInUks7t+F8k8n1G0koT0vxQfbavjBORNA0Wa5OpBuT7pb1/ZA2vyV/lxxe
 o3m1FH8pEzp+d4V+HbzSyiXRz2/cgeQvByPATEim7YRMCGpKw0qk0MTVBQArZaq4VdcC
 tBTQAzeQpJsvh4sAkRUT0pNQ+SQLVupn6fxOBUFXVKLel53GewZPJgyY5zLCWk2YGHVF
 mWCh9te6sHuLpAEQ4RcbKvOY76j5m72Mvw9nsz5BQgfd+mQkm6H9X/ownOnZ2tEOExUW
 v7AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GLTNWMx+xJ5k8y3FvE8AjVRzOp9zp77o3il4ctxrWw0=;
 b=iLmXX9qUM8WoszAgYfZPwiRQq0R9d5gwP8ZL4YF2zLccQ3czL5LOQ4LigSEHb9y7E0
 aa216Xvw7w1BG0QV2sC3x29eIN4hHea9BXvd2abndJyiUKyzpPgplTs/UibJNb9ETMn4
 OtVOUBV47rsRRW74wENEqFOloCvQNIbMVRj5ZYeWQsTtPwQH46ganb5h4NpxgmKCWQrD
 ROX+lE0q3tYtyN9VaO+SqTiYPoGCkuKGgCDw4Vq4uSXt/KgzZ3+WFWo5bKqUrqUNs04P
 ykL6/KQoyp+e40DHFEk5KeZ9LXYly/gO7RyX3w7enpYdtyfiP6d133j2tEZMBX4Pu12W
 rXXw==
X-Gm-Message-State: APjAAAVLBqm/EpYQOthRzPD4ylPVHwXUzaAvDl2PmmQ50M5kreLXv4+S
 blK1OdYEXQoHYyn1KAraIHoVdQ==
X-Google-Smtp-Source: APXvYqwkJtgeXFbR4iESsetIZtOir2P5kSdmvMPfSlVwVRcOY0tBGG1MM/LOGvgxn850nanPf9ZyXg==
X-Received: by 2002:a37:6d2:: with SMTP id 201mr42409656qkg.106.1568315237888; 
 Thu, 12 Sep 2019 12:07:17 -0700 (PDT)
Received: from [172.20.5.51] ([67.69.50.154])
 by smtp.gmail.com with ESMTPSA id m24sm11011556qkk.89.2019.09.12.12.07.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Sep 2019 12:07:17 -0700 (PDT)
To: Tony Nguyen <tony.nguyen@bt.com>
References: <20190911014353.5926-1-richard.henderson@linaro.org>
 <20190911014353.5926-4-richard.henderson@linaro.org>
 <20190911145629.GB42643@imac.local>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <1bc14887-b0f1-12d2-5cbb-29564635eb5c@linaro.org>
Date: Thu, 12 Sep 2019 15:07:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190911145629.GB42643@imac.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::744
Subject: Re: [Qemu-devel] [PATCH 3/3] cputlb: Introduce TLB_BSWAP
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
Cc: peter.maydell@linaro.org, mark.cave-ayland@ilande.co.uk,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/11/19 10:56 AM, Tony Nguyen wrote:
>> @@ -1372,26 +1364,27 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
>>              /* On watchpoint hit, this will longjmp out.  */
>>              cpu_check_watchpoint(env_cpu(env), addr, size,
>>                                   iotlbentry->attrs, BP_MEM_READ, retaddr);
>> -
>> -            /* The backing page may or may not require I/O.  */
>> -            tlb_addr &= ~TLB_WATCHPOINT;
>> -            if ((tlb_addr & ~TARGET_PAGE_MASK) == 0) {
>> -                goto do_aligned_access;
>> -            }
>>          }
>>  
>>          /* Handle I/O access.  */
>> -        return io_readx(env, iotlbentry, mmu_idx, addr,
>> -                        retaddr, access_type, op);
>> -    }
>> +        if (likely(tlb_addr & TLB_MMIO)) {
>> +            return io_readx(env, iotlbentry, mmu_idx, addr,
>> +                            retaddr, access_type,
>> +                            op ^ (tlb_addr & TLB_BSWAP ? MO_BSWAP : 0));
>> +        }
> 
> Previously, the end of if (unlikely(tlb_addr & ~TARGET_PAGE_MASK)) branch
> called and returned the result of io_readx.

Correct.  However, rather thank clearing TLB_WATCHPOINT and TLB_BSWAP, it
seemed easier to test for those bits that *do* require that we call io_readx.

As we've seen from the bug leading to this patch set, it's invalid to call
io_readx on anything that doesn't have TLB_MMIO set -- we'll either crash due
to the missing read accessor or reach the point at which we issue a bus error
for an i/o operation without a device.

BTW, there's a bug in this same location for store_helper in that I need to
also test for TLB_NOTDIRTY, which also goes through io_writex for the moment.
That bug is trivially shown during the make check migration tests.  Due to the
late hour I failed to run those before posting this patch set.  Will be fixed
in v2.


r~

