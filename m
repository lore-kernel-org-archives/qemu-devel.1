Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B8DC4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 10:36:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4143B207C4
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 10:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="1b8B/kNb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4143B207C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNCzo-00027Y-1u
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 06:36:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aik@ozlabs.ru>) id 1kNCye-0001Bv-Ft
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 06:35:20 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:38612)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aik@ozlabs.ru>) id 1kNCyb-00075M-Nb
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 06:35:20 -0400
Received: by mail-pg1-x544.google.com with SMTP id 5so3536377pgf.5
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 03:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=hu/DnEzv+N1WTogD8U6m75+7hBo3s8MUQql4IDgOh50=;
 b=1b8B/kNbgcNazD4C1ggy30dUue6r51U+OpXBDWfZzqhbx8fT2EHxEkkLS+Ldvy8o5C
 foFIQvBkMZax6v7SU13gjeuc1kB1YAMywAQOvG94qHxxHMCxLgzqanqfpDWhqABAD+cX
 AW+HXJ9eEM5MenKCQNQLlmpJGprSd3EpFh+S5ro/VlTTOccjWAncjuV4oqK8meB2HQ+Z
 eqwHW3a0Utdt640WmH2/RSU+o59AkSnle9vN7TsotPtDSPQH2MHZVWEvIVudN7UreVIp
 y7AyJJo6TKpE3A/Vo1tVBiTc/Cdbja5Gf+qit4BBHfhOcNTCG6gsrjzEydqJWgvRCcJg
 36Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hu/DnEzv+N1WTogD8U6m75+7hBo3s8MUQql4IDgOh50=;
 b=aNGu6FtHo59v5MUUdnwDHTECiFjYydg7KjdY1GnRm3zJBJVA7Ma6dRweHohyTeTL5q
 yEf2/pOiBvHhy/c4GSulrHUB8m6FckIoL6LW3AJRE6LfzFQKJMhRYiO3TNInQYf85DjQ
 EQIr6GT5ez3i3JaVOWL3nNW+iJpw0xnBbM0JbFvHvkRnr4z2d+Vj4G/Eki3E0KMA6ZWk
 ViMUNhJVs0BqTDyfTar7Gox5Dsm0ABatnkjNPXfG1HGjse6m3jSwA0BaAK2bH6phCp9k
 tiTGEQQl6J79pbDScm/lSmqCJ8VT8WlzxiMp5CQlbkVE1B8pOCFFeuvY/2plWL1sIPNx
 SzuA==
X-Gm-Message-State: AOAM533v57LCQtA35UKKIdzaO09cpUQ1cK6KmzJGKDEH0taCHBfZHoI3
 82mz5E3vTqkGeFCklbgl8eRBN/jW7lKmES+E
X-Google-Smtp-Source: ABdhPJw47juzHa7FGUUao5fyt0xh8xNPhX6iRt9EccE0hycDoxlUnef0kj1Vla/HAkiz8Dch614eKw==
X-Received: by 2002:a17:902:b686:b029:d1:e5e7:bdd6 with SMTP id
 c6-20020a170902b686b02900d1e5e7bdd6mr3837040pls.54.1601375714480; 
 Tue, 29 Sep 2020 03:35:14 -0700 (PDT)
Received: from [192.168.10.88] (124-171-83-152.dyn.iinet.net.au.
 [124.171.83.152])
 by smtp.gmail.com with UTF8SMTPSA id u22sm4304713pgi.85.2020.09.29.03.35.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2020 03:35:13 -0700 (PDT)
Subject: Re: [PATCH qemu v9] spapr: Implement Open Firmware client interface
To: David Gibson <david@gibson.dropbear.id.au>
References: <20200513035826.14205-1-aik@ozlabs.ru>
 <e5ddf04a-0d68-3cb8-2b84-47a43e234a59@ozlabs.ru>
 <f7e9ff41-de7a-c0d5-f004-51a2046ce0a0@ozlabs.ru>
 <434cdf49-5b80-5620-2635-079ee4b4ebad@ozlabs.ru>
 <86e79b6a-0032-56da-a066-9f02df361298@ozlabs.ru>
 <20200716132249.GB5607@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <24e83a34-6788-d9ee-ca07-6833778d81df@ozlabs.ru>
Date: Tue, 29 Sep 2020 20:35:09 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:82.0) Gecko/20100101
 Thunderbird/82.0
MIME-Version: 1.0
In-Reply-To: <20200716132249.GB5607@umbus.fritz.box>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=aik@ozlabs.ru; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 16/07/2020 23:22, David Gibson wrote:
> On Thu, Jul 16, 2020 at 07:04:56PM +1000, Alexey Kardashevskiy wrote:
>> Ping? I kinda realize it is not going to replace SLOF any time soon but
>> still...
> 
> Yeah, I know.   I just haven't had time to consider it.  Priority
> starvation.


Still? :)


>> On 07/07/2020 10:34, Alexey Kardashevskiy wrote:
>>> Ping?
>>>
>>>
>>> On 24/06/2020 10:28, Alexey Kardashevskiy wrote:
>>>> Ping?
>>>>
>>>> On 02/06/2020 21:40, Alexey Kardashevskiy wrote:
>>>>> Ping?
>>>>>
>>>>> On 13/05/2020 13:58, Alexey Kardashevskiy wrote:
>>>>>> The PAPR platform which describes an OS environment that's presented by
>>>>>> a combination of a hypervisor and firmware. The features it specifies
>>>>>> require collaboration between the firmware and the hypervisor.
>>>>>>
>>>>>> Since the beginning, the runtime component of the firmware (RTAS) has
>>>>>> been implemented as a 20 byte shim which simply forwards it to
>>>>>> a hypercall implemented in qemu. The boot time firmware component is
>>>>>> SLOF - but a build that's specific to qemu, and has always needed to be
>>>>>> updated in sync with it. Even though we've managed to limit the amount
>>>>>> of runtime communication we need between qemu and SLOF, there's some,
>>>>>> and it has become increasingly awkward to handle as we've implemented
>>>>>> new features.
>>>>>>
>>>>>> This implements a boot time OF client interface (CI) which is
>>>>>> enabled by a new "x-vof" pseries machine option (stands for "Virtual Open
>>>>>> Firmware). When enabled, QEMU implements the custom H_OF_CLIENT hcall
>>>>>> which implements Open Firmware Client Interface (OF CI). This allows
>>>>>> using a smaller stateless firmware which does not have to manage
>>>>>> the device tree.
>>>>>>
>>>>>> The new "vof.bin" firmware image is included with source code under
>>>>>> pc-bios/. It also includes RTAS blob.
>>>>>>
>>>>>> This implements a handful of CI methods just to get -kernel/-initrd
>>>>>> working. In particular, this implements the device tree fetching and
>>>>>> simple memory allocator - "claim" (an OF CI memory allocator) and updates
>>>>>> "/memory@0/available" to report the client about available memory.
>>>>>>
>>>>>> This implements changing some device tree properties which we know how
>>>>>> to deal with, the rest is ignored. To allow changes, this skips
>>>>>> fdt_pack() when x-vof=on as not packing the blob leaves some room for
>>>>>> appending.
>>>>>>
>>>>>> In absence of SLOF, this assigns phandles to device tree nodes to make
>>>>>> device tree traversing work.
>>>>>>
>>>>>> When x-vof=on, this adds "/chosen" every time QEMU (re)builds a tree.
>>>>>>
>>>>>> This adds basic instances support which are managed by a hash map
>>>>>> ihandle -> [phandle].
>>>>>>
>>>>>> Before the guest started, the used memory is:
>>>>>> 0..4000 - the initial firmware
>>>>>> 10000..180000 - stack
>>>>>>
>>>>>> This OF CI does not implement "interpret".
>>>>>>
>>>>>> With this basic support, this can only boot into kernel directly.
>>>>>> However this is just enough for the petitboot kernel and initradmdisk to
>>>>>> boot from any possible source. Note this requires reasonably recent guest
>>>>>> kernel with:
>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=df5be5be8735
>>>>>>
>>>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>>>> ---
>>>>>>
>>
>>
> 

-- 
Alexey

