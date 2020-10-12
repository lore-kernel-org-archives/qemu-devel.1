Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLACK,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2779C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 01:06:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCE0F2074D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 01:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="Ry1PkM16"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCE0F2074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRmIc-0008VE-Tj
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 21:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aik@ozlabs.ru>) id 1kRmI2-0007za-20
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 21:06:14 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:35998)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aik@ozlabs.ru>) id 1kRmHz-00063p-9O
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 21:06:13 -0400
Received: by mail-pf1-x443.google.com with SMTP id b26so12030110pff.3
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2020 18:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=gzmn2Ak3ot/ti4GX+YGJWjS+0humCs5SHfQkTSTyXlI=;
 b=Ry1PkM16CUPKB6qcxlw/9lS9LtAJMJrbChjPoxHBOn6TcmT8XIbPMgVyCW18gI+HPQ
 uC8k8D5sf8VHg2OOHMseC+AGuEzR28Bo5hLGeR+5x5I8/Gky4JqRAYpNzhiv/10mzewj
 SNUXUJicvK12045Eq1VjUpyo2jxW4SCvKcfdHHAhssJP2z/WBrYwItb0th+yhQGvASFH
 8BT/MDg0b/eqRzQ9Hw2RLT18z+Oe86nxqqqIK6WovsTofXdPSwAwJbne+kHxdyAfocuc
 mbMD8Rjx5XGtbzmVipj1QG2VpSAJZoKnVgzXnxF87mDMXlQ+PDrsbt/3j7teqmNJJxYr
 TwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gzmn2Ak3ot/ti4GX+YGJWjS+0humCs5SHfQkTSTyXlI=;
 b=oLaTbu2uZtBTJhVlQ0TBFNGpJ7rLYG4piFqJuXnQqqSQ4gm2ECRVKjvSCeSNoqJtGB
 v1Y8E6Op6tX1/FTSkbbChHwa7pX3OlSjwjDybbqOyMW0RdfOAcW2jFhz8rQzXmjH1nDK
 h8TNk8Hn1ODEYeNzv93UPjcvsCpvk+NCl0xCFQzfORjvgkFkpOgCc1XgdTNOVPT65yLS
 9DrQ9ksxDXfnRKiKb3Nfmp2zQu/pCfCHtU0sWnV0ODsg08f75XqIKbYU3uScy8R9KZh3
 4MuBXIm1nM7OZ+Ff2HK1MQXVZDK0jFQakpp+3hlSl9dzGVwntZq6BBCluV87y3STsG3b
 z1Lg==
X-Gm-Message-State: AOAM531SsV5RbP4p1RbBk4eYa5XY3jCu+MI8414efzUvL6alevFUVoje
 zxO4tRy3r36G7uuK9Wu7jDvHbNT8wdo8dLdx
X-Google-Smtp-Source: ABdhPJyOGSd+EaWEtmbxBiACl7iuNVZEyBA1QfZg7PggXQ5UlyVvxB0bQ5iaMqkqRKb+q1On+/lD5g==
X-Received: by 2002:a17:90a:bf92:: with SMTP id
 d18mr17086120pjs.210.1602464767673; 
 Sun, 11 Oct 2020 18:06:07 -0700 (PDT)
Received: from [192.168.10.88] (124-171-83-152.dyn.iinet.net.au.
 [124.171.83.152])
 by smtp.gmail.com with UTF8SMTPSA id u18sm18412148pgk.18.2020.10.11.18.06.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Oct 2020 18:06:06 -0700 (PDT)
Subject: Re: [PATCH qemu v9] spapr: Implement Open Firmware client interface
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
References: <20200513035826.14205-1-aik@ozlabs.ru>
 <e5ddf04a-0d68-3cb8-2b84-47a43e234a59@ozlabs.ru>
 <f7e9ff41-de7a-c0d5-f004-51a2046ce0a0@ozlabs.ru>
 <434cdf49-5b80-5620-2635-079ee4b4ebad@ozlabs.ru>
 <86e79b6a-0032-56da-a066-9f02df361298@ozlabs.ru>
 <20200716132249.GB5607@umbus.fritz.box>
 <24e83a34-6788-d9ee-ca07-6833778d81df@ozlabs.ru>
Message-ID: <35aeefc4-bdfc-65c5-afe5-1cd2579db3e4@ozlabs.ru>
Date: Mon, 12 Oct 2020 12:06:02 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:82.0) Gecko/20100101
 Thunderbird/82.0
MIME-Version: 1.0
In-Reply-To: <24e83a34-6788-d9ee-ca07-6833778d81df@ozlabs.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=aik@ozlabs.ru; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 29/09/2020 20:35, Alexey Kardashevskiy wrote:
> 
> 
> On 16/07/2020 23:22, David Gibson wrote:
>> On Thu, Jul 16, 2020 at 07:04:56PM +1000, Alexey Kardashevskiy wrote:
>>> Ping? I kinda realize it is not going to replace SLOF any time soon but
>>> still...
>>
>> Yeah, I know.   I just haven't had time to consider it.  Priority
>> starvation.
> 
> 
> Still? :)

Ping?

> 
> 
>>> On 07/07/2020 10:34, Alexey Kardashevskiy wrote:
>>>> Ping?
>>>>
>>>>
>>>> On 24/06/2020 10:28, Alexey Kardashevskiy wrote:
>>>>> Ping?
>>>>>
>>>>> On 02/06/2020 21:40, Alexey Kardashevskiy wrote:
>>>>>> Ping?
>>>>>>
>>>>>> On 13/05/2020 13:58, Alexey Kardashevskiy wrote:
>>>>>>> The PAPR platform which describes an OS environment that's 
>>>>>>> presented by
>>>>>>> a combination of a hypervisor and firmware. The features it 
>>>>>>> specifies
>>>>>>> require collaboration between the firmware and the hypervisor.
>>>>>>>
>>>>>>> Since the beginning, the runtime component of the firmware (RTAS) 
>>>>>>> has
>>>>>>> been implemented as a 20 byte shim which simply forwards it to
>>>>>>> a hypercall implemented in qemu. The boot time firmware component is
>>>>>>> SLOF - but a build that's specific to qemu, and has always needed 
>>>>>>> to be
>>>>>>> updated in sync with it. Even though we've managed to limit the 
>>>>>>> amount
>>>>>>> of runtime communication we need between qemu and SLOF, there's 
>>>>>>> some,
>>>>>>> and it has become increasingly awkward to handle as we've 
>>>>>>> implemented
>>>>>>> new features.
>>>>>>>
>>>>>>> This implements a boot time OF client interface (CI) which is
>>>>>>> enabled by a new "x-vof" pseries machine option (stands for 
>>>>>>> "Virtual Open
>>>>>>> Firmware). When enabled, QEMU implements the custom H_OF_CLIENT 
>>>>>>> hcall
>>>>>>> which implements Open Firmware Client Interface (OF CI). This allows
>>>>>>> using a smaller stateless firmware which does not have to manage
>>>>>>> the device tree.
>>>>>>>
>>>>>>> The new "vof.bin" firmware image is included with source code under
>>>>>>> pc-bios/. It also includes RTAS blob.
>>>>>>>
>>>>>>> This implements a handful of CI methods just to get -kernel/-initrd
>>>>>>> working. In particular, this implements the device tree fetching and
>>>>>>> simple memory allocator - "claim" (an OF CI memory allocator) and 
>>>>>>> updates
>>>>>>> "/memory@0/available" to report the client about available memory.
>>>>>>>
>>>>>>> This implements changing some device tree properties which we 
>>>>>>> know how
>>>>>>> to deal with, the rest is ignored. To allow changes, this skips
>>>>>>> fdt_pack() when x-vof=on as not packing the blob leaves some room 
>>>>>>> for
>>>>>>> appending.
>>>>>>>
>>>>>>> In absence of SLOF, this assigns phandles to device tree nodes to 
>>>>>>> make
>>>>>>> device tree traversing work.
>>>>>>>
>>>>>>> When x-vof=on, this adds "/chosen" every time QEMU (re)builds a 
>>>>>>> tree.
>>>>>>>
>>>>>>> This adds basic instances support which are managed by a hash map
>>>>>>> ihandle -> [phandle].
>>>>>>>
>>>>>>> Before the guest started, the used memory is:
>>>>>>> 0..4000 - the initial firmware
>>>>>>> 10000..180000 - stack
>>>>>>>
>>>>>>> This OF CI does not implement "interpret".
>>>>>>>
>>>>>>> With this basic support, this can only boot into kernel directly.
>>>>>>> However this is just enough for the petitboot kernel and 
>>>>>>> initradmdisk to
>>>>>>> boot from any possible source. Note this requires reasonably 
>>>>>>> recent guest
>>>>>>> kernel with:
>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=df5be5be8735 
>>>>>>>
>>>>>>>
>>>>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>>>>> ---
>>>>>>>
>>>
>>>
>>
> 

-- 
Alexey

