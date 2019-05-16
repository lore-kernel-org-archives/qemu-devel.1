Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C082AC04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 20:06:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E52C20818
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 20:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFCL7Dns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E52C20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34717 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRMdd-0002zv-97
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 16:06:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hRMcp-0002gF-E6
	for qemu-devel@nongnu.org; Thu, 16 May 2019 16:05:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hRMcn-0006it-Tc
	for qemu-devel@nongnu.org; Thu, 16 May 2019 16:05:11 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38509)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hRMcn-0006f1-Kr
	for qemu-devel@nongnu.org; Thu, 16 May 2019 16:05:09 -0400
Received: by mail-wr1-x444.google.com with SMTP id d18so4727587wrs.5
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 13:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:subject:to:cc:references:from:openpgp:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=60E3jZtCmY0KKdUjVUI+4ExFyw9mf7w+Ye9pueHG+fY=;
	b=MFCL7DnsG3NdWQaceTuJTpIWWHnv/scijO/FyqYo8yDp94G6RYEoDN3EH7WpsChN/9
	47Hbo8451X71EW4E67z1TzzPQZFt1LlLvmDBhLr4xU/spyJ/OIoJ9dSQai7Kjduy1n+n
	DtGuS+3ZbyyPoDbqYeTWyJwLMXpuGIWrjPoQcfV+5EUIFRV9MrBHgRsmBvWPsie1HqcB
	YleVYpRrmlCj97I2gryFrOILrV9JAxdP5GsSXAykidyS9wkPf0vV3YNRHF/TMKW6cwE4
	+Jaxy3eUm+pTgaqJzArniA5pX/DFCFDWvjtuf+1nYy5K6VGnUy3Ww48aSa8Ou2OQQeYt
	WYNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
	:message-id:date:user-agent:mime-version:in-reply-to
	:content-language:content-transfer-encoding;
	bh=60E3jZtCmY0KKdUjVUI+4ExFyw9mf7w+Ye9pueHG+fY=;
	b=ELavHX3zgBu+a2YubIk25JPO/aI7PEVJF5NsCuDa5sobg2NAXgEPFHV6rKjatnRdFG
	/X9V1EnPEGaBeyeSgcjCJ/1DOjOEC9/8xAU4Nab6qNMhQzmfWlNp6Q+mQMfKqDmjVrQm
	OzyUiSx2DjdZ4Nv10tGYUTHenaBo6admSdO6NuyIGlo0LTHC7jcdNTr3IkdhbAWrZLR7
	301tDHlN9owoUUUm+xd8xvoiwcI6P+ENPqqsG4vlBqayh/Qbixy6MCqJKq+fNDi28H50
	tFaqfd0u6pq/INmr3ZqhT9SVS2pQhhkxlVoNhyFTnCB7XOXvn2tfsUp6sPyn8/c8rLX5
	/pxw==
X-Gm-Message-State: APjAAAWoknJJB+cJ1PEsJ/RFluMSCXZMMfkn8nkVbh2fP78pMbwJnL49
	LTe6kh/o/lDRpS+cOmwigTs=
X-Google-Smtp-Source: APXvYqzXkxfcAT2fkesaGSkeiqKA5DBmhiuynsBrlwolCcKUzcYMYIJ4qqNr+tl0Nyt6Vcdpj19bcQ==
X-Received: by 2002:a5d:6610:: with SMTP id n16mr23480165wru.250.1558037106745;
	Thu, 16 May 2019 13:05:06 -0700 (PDT)
Received: from [192.168.1.43] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	j82sm8628445wmj.40.2019.05.16.13.05.03
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 May 2019 13:05:04 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20190423110034.1260142-1-jakub.jermar@kernkonzept.com>
	<ab4b6d04-74f9-2f12-829d-9df8c1b1c4ca@redhat.com>
	<6ae8d347-149d-e7eb-bb02-90aba44c5bbd@kernkonzept.com>
	<1e9a8595-4653-4900-b747-236f9888b893@kernkonzept.com>
	<04a4fcca-0db9-46f8-ac41-0d770b0dc5d6@kernkonzept.com>
	<f9f1b930-2381-b343-854f-70e2590c9b73@redhat.com>
	<CAL1e-=jFH7+cHGUJsmUKpEAkwohagfM5WVb4-rGSozsEkzFrTA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Openpgp: url=http://pgp.mit.edu/pks/lookup?op=get&search=0xE3E32C2CDEADC0DE
Message-ID: <847cc518-5e38-228d-b152-4d8169ecb3ed@amsat.org>
Date: Thu, 16 May 2019 22:05:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=jFH7+cHGUJsmUKpEAkwohagfM5WVb4-rGSozsEkzFrTA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v2] mips: Decide to map PAGE_EXEC in
 map_address
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-devel@nongnu.org,
	Jakub Jermar <jakub.jermar@kernkonzept.com>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Leon Alrae <leon.alrae@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/16/19 8:04 PM, Aleksandar Markovic wrote:
> On May 16, 2019 6:31 PM, "Philippe Mathieu-Daudé" <philmd@redhat.com> wrote:
>>
>> Hi Jakub,
>>
>> On 5/16/19 3:10 PM, Jakub Jermar wrote:
>>> Hi,
>>>
>>> On 5/3/19 12:02 PM, Jakub Jermar wrote:
>>>> Hi,
>>>>
>>>> On 4/23/19 4:58 PM, Jakub Jermar wrote:
>>>>> Hi Philippe!
>>>>>
>>>>> On 4/23/19 3:48 PM, Philippe Mathieu-Daudé wrote:
>>>>>> Hi Jakub,
>>>>>>
>>>>>> On 4/23/19 1:00 PM, Jakub Jermář wrote:
>>>>>>> This commit addresses QEMU Bug #1825311:
>>>>>>>
>>>>>>>   mips_cpu_handle_mmu_fault renders all accessed pages executable
>>>>>>>
>>>>>>> It allows finer-grained control over whether the accessed page
> should be
>>>>>>> executable by moving the decision to the underlying map_address
>>>>>>> function, which has more information for this.
>>>>>>>
>>>>>>> As a result, pages that have the XI bit set in the TLB and are
> accessed
>>>>>>> for read/write, don't suddenly end up being executable.
>>>>>>>
>>>>>>
>>>>>> Fixes: https://bugs.launchpad.net/qemu/+bug/1825311
>>>>>>
>>>>>>> Signed-off-by: Jakub Jermář <jakub.jermar@kernkonzept.com>
>>>>>>> ---
>>>>>>>  target/mips/helper.c | 17 ++++++++++-------
>>>>>>>  1 file changed, 10 insertions(+), 7 deletions(-)
>>>>>>>
>>>>>>> diff --git a/target/mips/helper.c b/target/mips/helper.c
>>>>>>> index c44cdca3b5..132d073fbe 100644
>>>>>>> --- a/target/mips/helper.c
>>>>>>> +++ b/target/mips/helper.c
>>>>>>> @@ -43,7 +43,7 @@ int no_mmu_map_address (CPUMIPSState *env, hwaddr
> *physical, int *prot,
>>>>>>>                          target_ulong address, int rw, int
> access_type)
>>>>>>>  {
>>>>>>>      *physical = address;
>>>>>>> -    *prot = PAGE_READ | PAGE_WRITE;
>>>>>>> +    *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
>>>>>>>      return TLBRET_MATCH;
>>>>>>>  }
>>>>>>>
>>>>>>> @@ -61,7 +61,7 @@ int fixed_mmu_map_address (CPUMIPSState *env,
> hwaddr *physical, int *prot,
>>>>>>>      else
>>>>>>>          *physical = address;
>>>>>>>
>>>>>>> -    *prot = PAGE_READ | PAGE_WRITE;
>>>>>>> +    *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
>>>>>>>      return TLBRET_MATCH;
>>>>>>>  }
>>>>>>>
>>>>>>> @@ -101,6 +101,9 @@ int r4k_map_address (CPUMIPSState *env, hwaddr
> *physical, int *prot,
>>>>>>>                  *prot = PAGE_READ;
>>>>>>>                  if (n ? tlb->D1 : tlb->D0)
>>>>>>>                      *prot |= PAGE_WRITE;
>>>>>>> +                if (!(n ? tlb->XI1 : tlb->XI0)) {
>>>>>>> +                    *prot |= PAGE_EXEC;
>>>>>>> +                }
>>>>>>
>>>>>> This was indeed missed in commit 2fb58b73746e.
>>
>> Aleksandar, if this patch is OK with you, can you amend this comment,
>> and add the "Fixes:" tag too when applying? Thanks!
> 
> Yes, definitely, Philippe, that is not a problem.
> 
> Thanks for helping out!
> 
> I tested Jakub's scenario too, it works as expected, but I am not concerned
> about it as much as about regression tests. Knowing that you have many MIPS
> test kernels and images, may I ask you to test some of them WITH Jakub's
> fix (so indepenently of myself anf Jakub), just to confirm that there are
> no regressions?

Yes, I can do that (during next WE).

FYI I try to test all QEMU MIPS boards at least once a month (except the
Jazz board, I don't have handy setup and think Hervé does test it).
It is time consuming so I'm investing time to offload that testing with
Avocado slowly. This will take me some months (at least 2 QEMU releases).

I'm also regularly testing embedded firmwares on boards not yet
upstreamed (which are of my interest) and am working on a Avocado test
setup too. I wish I can upstream the whole work this year...

> C’est vraiment gentil de votre part.

;)

> 
> Aleksandar
> 
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>
>>>>>>
>>>>>>>                  return TLBRET_MATCH;
>>>>>>>              }
>>>>>>>              return TLBRET_DIRTY;
>>>>>>> @@ -182,7 +185,7 @@ static int
> get_seg_physical_address(CPUMIPSState *env, hwaddr *physical,
>>>>>>>      } else {
>>>>>>>          /* The segment is unmapped */
>>>>>>>          *physical = physical_base | (real_address & segmask);
>>>>>>> -        *prot = PAGE_READ | PAGE_WRITE;
>>>>>>> +        *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
>>>>>>>          return TLBRET_MATCH;
>>>>>>>      }
>>>>>>>  }
>>>>>>> @@ -913,8 +916,8 @@ int mips_cpu_handle_mmu_fault(CPUState *cs,
> vaddr address, int size, int rw,
>>>>>>>      }
>>>>>>>      if (ret == TLBRET_MATCH) {
>>>>>>>          tlb_set_page(cs, address & TARGET_PAGE_MASK,
>>>>>>> -                     physical & TARGET_PAGE_MASK, prot | PAGE_EXEC,
>>>>>>> -                     mmu_idx, TARGET_PAGE_SIZE);
>>>>>>> +                     physical & TARGET_PAGE_MASK, prot, mmu_idx,
>>>>>>> +                     TARGET_PAGE_SIZE);
>>>>>>>          ret = 0;
>>>>>>>      } else if (ret < 0)
>>>>>>>  #endif
>>>>>>> @@ -936,8 +939,8 @@ int mips_cpu_handle_mmu_fault(CPUState *cs,
> vaddr address, int size, int rw,
>>>>>>>                                             address, rw,
> access_type, mmu_idx);
>>>>>>>                  if (ret == TLBRET_MATCH) {
>>>>>>>                      tlb_set_page(cs, address & TARGET_PAGE_MASK,
>>>>>>> -                            physical & TARGET_PAGE_MASK, prot |
> PAGE_EXEC,
>>>>>>> -                            mmu_idx, TARGET_PAGE_SIZE);
>>>>>>> +                            physical & TARGET_PAGE_MASK, prot,
> mmu_idx,
>>>>>>> +                            TARGET_PAGE_SIZE);
>>>>>>>                      ret = 0;
>>>>>>>                      return ret;
>>>>>>>                  }
>>>>>>>
>>>>>>
>>>>>> Your patch looks correct, but I'd like to test it.
>>>>>> Do you have a reproducer?
>>>>>> Can you describe the command line you used?
>>>>>
>>>>> I've just attached a reproducer image and script to the bug. It's a
>>>>> 32-bit little-endian test binary running on top of the L4Re
> microkernel.
>>
>> I can't get the "TAP" output you described on launchpad.
>>
>>>>> Let me know if you also need a 64-bit version.
>>
>> 64-bit version is welcomed.
>>
>>>>> I tested both 32 and 64-bit versions of the reproducer and also
> checked
>>>>> to see that the the other images I have lying around here (Linux
> 2.6.32
>>>>> big endian and HelenOS master little-endian, both 32-bit for 4Kc)
>>>>> continue to run without regressions.
>>
>> Yes, definitively an improvement:
>> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>
>> Regards,
>>
>> Phil.
>>

