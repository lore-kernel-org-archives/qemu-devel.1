Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F16FC432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 16:10:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 393952146E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 16:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q3AtsZkC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 393952146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD9s4-0002Hj-KM
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 12:10:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38949)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iD9jj-0002d8-RP
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 12:01:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iD9jh-0005cC-Ta
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 12:01:51 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40663)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iD9jh-0005bo-L9
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 12:01:49 -0400
Received: by mail-wm1-x341.google.com with SMTP id b24so5549993wmj.5
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 09:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=gDm0a7DR+YHYGtadIwZtQJxiWkOTI/LNC2/7T5owi+w=;
 b=q3AtsZkCWtsc1CPH+NEmTh9S9wS/b7FModuXNLzBM/mLkNlDanF8XmoPyZBa6oiuJk
 kDXrUqfe96WD7FvvkQctapeeMMYhdZn86air24c1NjYjr8bL/aDc4Ju6+eUS9No+jC+M
 nVJcPPYDKPeLQ2fwPhfnL4hBmjlszpRCxt9yhq+FsCU60SrCRJ15BoHsUFmwYocR+csh
 xi87sIbmILpF9JI6mSztzOQzdDg9xdu3vZQTX2STqDUenIizoVdTWBy3yCeZ8IiaJtoy
 inx88STK4Sk2lCvtgtem0sHKpzgBFHVp4+TizB11UKh9ltzZszgoF2jkKe3GSQv4mfyX
 ZgrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=gDm0a7DR+YHYGtadIwZtQJxiWkOTI/LNC2/7T5owi+w=;
 b=Mtip+U4Z7eUrwPvzKQZHM+fpcTHLVTbr7DXtlMXwBc4rsrmCGnL8q9Jx78tCSo+1Gn
 Y4bWWaVcusnibj7+4FlTdPqEbStzp1s2S9Yr+fkdEQ8b8MQXQ4EacsBa5KhevHYaNDBs
 Tfup64fl6GwouFO3wJgYJGHpvDEsGSLSo4Ikckr1ll2lxoqpobou4veyY3x3hW30oW+j
 9jBLOiq6jmU7IJPEWJcaRhq31BYVty+mZ9QNgmqatslSL65hArWmGfM8AQzg7nEDgPRT
 N7Z+ZAm0gsTjglVySQGxjG01YWDkHkXWLTYOvbDbJ66vUgODAGR/3bWrvtvTH4HLgmuz
 T6cg==
X-Gm-Message-State: APjAAAVjQ1S9eFemNLu88vT6vDGa1AQugC+0SwDRSFr15frqeHK2I56N
 pIDGVdjjkrrrLPVxpocwRotGTg==
X-Google-Smtp-Source: APXvYqxKRaL++Mm7gu7CxYfduOp4rUbVTyE4IjI+dOtRMrLYacH8tbJWfj4Sgkj7pNI1QEiiF0So/w==
X-Received: by 2002:a7b:c252:: with SMTP id b18mr5104129wmj.68.1569427307452; 
 Wed, 25 Sep 2019 09:01:47 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i5sm4181585wmd.21.2019.09.25.09.01.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2019 09:01:46 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B4B6D1FF87;
 Wed, 25 Sep 2019 17:01:45 +0100 (BST)
References: <20190923230004.9231-1-richard.henderson@linaro.org>
 <20190923230004.9231-9-richard.henderson@linaro.org>
 <87v9th9qnz.fsf@linaro.org>
 <080af734-eccb-16c9-2664-72dd26ff460c@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4 08/16] cputlb: Move ROM handling from I/O path to TLB
 path
In-reply-to: <080af734-eccb-16c9-2664-72dd26ff460c@redhat.com>
Date: Wed, 25 Sep 2019 17:01:45 +0100
Message-ID: <87tv909xg6.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: pbonzini@redhat.com, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


David Hildenbrand <david@redhat.com> writes:

> On 25.09.19 02:16, Alex Benn=C3=A9e wrote:
>>
>> Richard Henderson <richard.henderson@linaro.org> writes:
>>
>>> It does not require going through the whole I/O path
>>> in order to discard a write.
>>>
>>> Reviewed-by: David Hildenbrand <david@redhat.com>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>  include/exec/cpu-all.h    |  5 ++++-
>>>  include/exec/cpu-common.h |  1 -
>>>  accel/tcg/cputlb.c        | 35 +++++++++++++++++++--------------
>>>  exec.c                    | 41 +--------------------------------------
>>>  4 files changed, 25 insertions(+), 57 deletions(-)
>>>
>>> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
>>> index d148bded35..26547cd6dd 100644
>>> --- a/include/exec/cpu-all.h
>>> +++ b/include/exec/cpu-all.h
>> <snip>
>>> @@ -822,16 +821,17 @@ void tlb_set_page_with_attrs(CPUState *cpu, targe=
t_ulong vaddr,
>>>
>>>      tn.addr_write =3D -1;
>>>      if (prot & PAGE_WRITE) {
>>> -        if ((memory_region_is_ram(section->mr) && section->readonly)
>>> -            || memory_region_is_romd(section->mr)) {
>>> -            /* Write access calls the I/O callback.  */
>>> -            tn.addr_write =3D address | TLB_MMIO;
>>> -        } else if (memory_region_is_ram(section->mr)
>>> -                   && cpu_physical_memory_is_clean(
>>> -                       memory_region_get_ram_addr(section->mr) + xlat)=
) {
>>> -            tn.addr_write =3D address | TLB_NOTDIRTY;
>>> -        } else {
>>> -            tn.addr_write =3D address;
>>> +        tn.addr_write =3D address;
>>> +        if (memory_region_is_romd(section->mr)) {
>>> +            /* Use the MMIO path so that the device can switch states.=
 */
>>> +            tn.addr_write |=3D TLB_MMIO;
>>> +        } else if (memory_region_is_ram(section->mr)) {
>>> +            if (section->readonly) {
>>> +                tn.addr_write |=3D TLB_ROM;
>>> +            } else if (cpu_physical_memory_is_clean(
>>> +                        memory_region_get_ram_addr(section->mr) + xlat=
)) {
>>> +                tn.addr_write |=3D TLB_NOTDIRTY;
>>> +            }
>>
>> This reads a bit weird because we are saying romd isn't a ROM but
>> something that identifies as RAM can be ROM rather than just a memory
>> protected piece of RAM.
>>
>
> I proposed a bunch of alternatives as reply to v3 (e.g.,
> TLB_DISCARD_WRITES), either Richard missed them or I missed his reply
> :)

That certainly passes the "does what it says on the tin" test.

>
>>>          }
>>>          if (prot & PAGE_WRITE_INV) {
>>>              tn.addr_write |=3D TLB_INVALID_MASK;
>>
>> So at the moment I don't see what the TLB_ROM flag gives us that setting
>> TLB_INVALID doesn't - either way we won't make the write to our
>> ram-not-ram-rom.
>
> TLB_INVALID will trigger a new MMU translation on every access to fill
> the TLB. TLB_ROM states that we have a valid entry, but that writes are
> to be discarded.

Ahh yes, I didn't notice it because it's hidden in he tlb_hit check.

--
Alex Benn=C3=A9e

