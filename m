Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CD3C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 10:33:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE8B52073E
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 10:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g433mTlz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE8B52073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqwXS-0007pC-1S
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 06:33:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqwVf-0006Xr-Nu
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 06:32:03 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48891
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqwVc-0004KC-0i
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 06:32:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593685918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=IwDfJD5iKL+9AfxoOCXMuVOFD4vlahoIuzMipzDGKbM=;
 b=g433mTlzSt3r6UHqObpXKDwAN64LN2/FfnY/iqRSPvTNx+lT2P3jynUB+TGWMFni0cOsLJ
 X7QVhfkTYRRywMmo8hkRb8eZPiMwC/0ihjKBYap1WQCGL6C5K/IpPyU8Bbny6elp/wIZ7p
 Zh1VvPuN8XVFv/5JDdtFBOrm7pdWxk0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-qDxoN0-UO_evEaUIs4nS2Q-1; Thu, 02 Jul 2020 06:31:56 -0400
X-MC-Unique: qDxoN0-UO_evEaUIs4nS2Q-1
Received: by mail-ed1-f70.google.com with SMTP id v7so26546256ede.15
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 03:31:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=IwDfJD5iKL+9AfxoOCXMuVOFD4vlahoIuzMipzDGKbM=;
 b=qOdj4TZD1QWiGFw9/ZFqAwH9ULLlBFcsjae1mnWpP4eO2zVdAfRku3VD0+cx1oZRcc
 azWcAkVIrf/PHtfOIsY2a3cLI4K7wVIfDG6v//LgF2D7onBdaZM+TRvqu5mRN7goRXLI
 GEcyUXhd7vmHwNH5qJsytwaHUXzpFGabMairpQlbig36opP/yui1wWR9Tj+pcMV5yCSc
 HTL77rt7AvW8Hooj1HVBddUOasZrZ63TX1srY/B3xQKcFctTBnilSgbe6ab7Uut4wpf5
 zmFnnJNp9jNymXc/ZkmLMF4mwv2lZEV6RtT3YL6okNwf17u7k/l7yECzHfs0q3B9JX2Y
 bLZw==
X-Gm-Message-State: AOAM530fDFjvsofWsP4pIff0Be8fY50IdnZnQ2eX3Bt3x5+TDqYJ+1Fq
 02YemzANFtuPzcUQT6SioLFfEoo8+ibqskFSG3jJBNfvnIi7EDfEGBLk/4U5URbgRxjUOU5jTMA
 V0qV+X984M06b3/4=
X-Received: by 2002:a50:9f22:: with SMTP id b31mr34608006edf.24.1593685915527; 
 Thu, 02 Jul 2020 03:31:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxTR1DNH1Renbrj2wj57bIzo0AszvNNWzOc5QJlMQjonx/dskYbNHT/GauzRzSmsh0FrYFpw==
X-Received: by 2002:a50:9f22:: with SMTP id b31mr34607980edf.24.1593685915273; 
 Thu, 02 Jul 2020 03:31:55 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id p14sm6279150ejl.115.2020.07.02.03.31.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2020 03:31:54 -0700 (PDT)
Subject: Re: [PATCH] cpus: Move CPU code from exec.c to cpus.c
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200701175432.18892-1-philmd@redhat.com>
 <b476ded8-fbd6-f9d5-66b7-67e7128e86fd@redhat.com>
 <34ef8d81-4559-9887-3420-c0045bb83d46@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <17db4d17-7e50-5a57-202e-8c3dac43db44@redhat.com>
Date: Thu, 2 Jul 2020 12:31:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <34ef8d81-4559-9887-3420-c0045bb83d46@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 04:18:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/2/20 12:21 PM, Paolo Bonzini wrote:
> On 02/07/20 11:38, Paolo Bonzini wrote:
>> On 01/07/20 19:54, Philippe Mathieu-Daudé wrote:
>>> This code was introduced with SMP support in commit 6a00d60127,
>>> later commit 296af7c952 moved CPU parts to cpus.c but forgot this
>>> code. Move now and simplify ifdef'ry.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>> ---
>>>  cpus.c | 18 ++++++++++++++++++
>>>  exec.c | 22 ----------------------
>>>  2 files changed, 18 insertions(+), 22 deletions(-)
>>>
>>> diff --git a/cpus.c b/cpus.c
>>> index 41d1c5099f..472686cbbc 100644
>>> --- a/cpus.c
>>> +++ b/cpus.c
>>> @@ -92,6 +92,11 @@ static unsigned int throttle_percentage;
>>>  #define CPU_THROTTLE_PCT_MAX 99
>>>  #define CPU_THROTTLE_TIMESLICE_NS 10000000
>>>  
>>> +CPUTailQ cpus = QTAILQ_HEAD_INITIALIZER(cpus);
>>> +
>>> +/* current CPU in the current thread. It is only valid inside cpu_exec() */
>>> +__thread CPUState *current_cpu;
>>> +
>>>  bool cpu_is_stopped(CPUState *cpu)
>>>  {
>>>      return cpu->stopped || !runstate_is_running();
>>> @@ -134,6 +139,19 @@ static bool all_cpu_threads_idle(void)
>>>      return true;
>>>  }
>>>  
>>> +CPUState *qemu_get_cpu(int index)
>>> +{
>>> +    CPUState *cpu;
>>> +
>>> +    CPU_FOREACH(cpu) {
>>> +        if (cpu->cpu_index == index) {
>>> +            return cpu;
>>> +        }
>>> +    }
>>> +
>>> +    return NULL;
>>> +}
>>> +
>>>  /***********************************************************/
>>>  /* guest cycle counter */
>>>  
>>> diff --git a/exec.c b/exec.c
>>> index 21926dc9c7..997b7db15f 100644
>>> --- a/exec.c
>>> +++ b/exec.c
>>> @@ -98,12 +98,6 @@ AddressSpace address_space_memory;
>>>  static MemoryRegion io_mem_unassigned;
>>>  #endif
>>>  
>>> -CPUTailQ cpus = QTAILQ_HEAD_INITIALIZER(cpus);
>>> -
>>> -/* current CPU in the current thread. It is only valid inside
>>> -   cpu_exec() */
>>> -__thread CPUState *current_cpu;
>>> -
>>>  uintptr_t qemu_host_page_size;
>>>  intptr_t qemu_host_page_mask;
>>>  
>>> @@ -832,22 +826,6 @@ const VMStateDescription vmstate_cpu_common = {
>>>      }
>>>  };
>>>  
>>> -#endif
>>> -
>>> -CPUState *qemu_get_cpu(int index)
>>> -{
>>> -    CPUState *cpu;
>>> -
>>> -    CPU_FOREACH(cpu) {
>>> -        if (cpu->cpu_index == index) {
>>> -            return cpu;
>>> -        }
>>> -    }
>>> -
>>> -    return NULL;
>>> -}
>>> -
>>> -#if !defined(CONFIG_USER_ONLY)
>>>  void cpu_address_space_init(CPUState *cpu, int asidx,
>>>                              const char *prefix, MemoryRegion *mr)
>>>  {
>>>
>>
>> Queued, thanks.
>>
>> Paolo
>>
>>
> 
> Wait... this is in exec.c because cpus.c is not linked into user-mode
> emulators.

Oops sorry. This should be moved to cpus-common.c then. Will respin.


