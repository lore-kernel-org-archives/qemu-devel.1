Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121D2C2D0A7
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 14:06:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25C482064B
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 14:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bjulM1Bj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25C482064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFHmb-0003zo-VH
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 10:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFHlz-0003UU-92
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 10:05:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32041)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFHlv-0004CK-3j
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 10:05:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599487525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sbWGDPqO2uAMek2hNQ/FWNWcTCyk3I2MVKL6Mr62ysU=;
 b=bjulM1BjMsSj4o7PxfwxMtkDLkEGiMScpsniXdHIGwQsWq3y/FhVhBbxqIfhgXwDkN+g+1
 /SmYXj94PvJ2UDMweJYwP8F9bn13LhqDLuXWN0880i0TR3zBNbT3IQ9m9F3IixVTIYRasy
 pKUC5zxqlsiLapz7UE1b3JlRPyq3RQE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-NtO1QQK0NRSjlOi5m07RlQ-1; Mon, 07 Sep 2020 10:05:24 -0400
X-MC-Unique: NtO1QQK0NRSjlOi5m07RlQ-1
Received: by mail-ed1-f69.google.com with SMTP id c25so4932054edx.11
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 07:05:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=sbWGDPqO2uAMek2hNQ/FWNWcTCyk3I2MVKL6Mr62ysU=;
 b=g6HEr0yY2vANMrkq53GAJCeGmnypv8JX3JKWMeGa/WkEp9SGDA4GnTiBvZ+dITh4PG
 lQHihmw67R+V1JpG2eXl8HLLwJDqhOanQbo9s4OQX5CpbS5P2z5UEJh9fLMW3E0vdrfV
 ttbG7i+dACklYGyOkoKYY6G+erm/YQ8iuTGKfuIuwCVBTzgVigSCaxIT3M/YcBSH5Y2S
 Uhgbj0lkUCIxNu82sXS6S1LaALtCww4GZ6BqWuRE5T3/NWzH43PvZO5vE1nwaB7zLWat
 a3jLbsPdK7mHrl7xb2zwwXalaUnCBFiBWgwgrKIA893jiBfoK2DKg6vzSBdXGc3E61KR
 sZCQ==
X-Gm-Message-State: AOAM5306rt2KaBBvfMuM8YOtuw10n3Srm9stTcIC1UWoFeHapxeAg7iC
 KI5JhKAPf88WKHyNdyOH8Q2Pt0Azm6eZCf7QKooaQi2lNeuQ/hk03zzWOPBj69b9nuG+KMt5a5O
 pBSTzjm3dvUmGj3o=
X-Received: by 2002:a17:906:3e0c:: with SMTP id
 k12mr20765957eji.189.1599487522879; 
 Mon, 07 Sep 2020 07:05:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/xPcaiZagb9tspNvywNHFueG4YgcSoFESBtxnl3wpZOeFaXqXKL+p/d+wYQhLAab6UNdFQA==
X-Received: by 2002:a17:906:3e0c:: with SMTP id
 k12mr20765926eji.189.1599487522602; 
 Mon, 07 Sep 2020 07:05:22 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id ot19sm15311554ejb.121.2020.09.07.07.05.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2020 07:05:21 -0700 (PDT)
Subject: Re: [PULL 00/30] ppc-for-5.2 queue 20200904
To: Laurent Vivier <lvivier@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Peter Maydell <peter.maydell@linaro.org>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>
References: <20200904034719.673626-1-david@gibson.dropbear.id.au>
 <CAFEAcA8xCpRBcsCaozEXnCuM5SqWr5ZEDrwLjs+8va=316_70Q@mail.gmail.com>
 <20200907023800.GJ341806@yekko.fritz.box>
 <675253df-b750-1a0a-5447-9dadef1accba@redhat.com>
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
Message-ID: <7c287125-70b3-4330-fd5c-8e644e1c347d@redhat.com>
Date: Mon, 7 Sep 2020 16:05:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <675253df-b750-1a0a-5447-9dadef1accba@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 03:52:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.825, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Greg Kurz <groug@kaod.org>, Daniel Henrique Barboza <danielhb413@gmail.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Cornelia Huck <cohuck@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Thiago,

On 9/7/20 3:29 PM, Laurent Vivier wrote:
> On 07/09/2020 04:38, David Gibson wrote:
>> On Sun, Sep 06, 2020 at 04:20:10PM +0100, Peter Maydell wrote:
>>> On Fri, 4 Sep 2020 at 04:47, David Gibson <david@gibson.dropbear.id.au> wrote:
>>>>
>>>> The following changes since commit 67a7bfe560a1bba59efab085cb3430f45176d382:
>>>>
>>>>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2020-09-03' into staging (2020-09-03 16:58:25 +0100)
>>>>
>>>> are available in the Git repository at:
>>>>
>>>>   git://github.com/dgibson/qemu.git tags/ppc-for-5.2-20200904
>>>>
>>>> for you to fetch changes up to b172606ecf29a140073f7787251a9d70ecb53b6e:
>>>>
>>>>   spapr_numa: move NVLink2 associativity handling to spapr_numa.c (2020-09-04 13:40:09 +1000)
>>>>
>>>> ----------------------------------------------------------------
>>>> ppc patch queue 2020-09-04
>>>>
>>>> Next pull request for qemu-5.2.  The biggest thing here is the
>>>> generalization of ARM's start-powered-off machine property to all
>>>> targets.  This can fix a number of odd little edge cases where KVM
>>>> could run vcpus before they were properly initialized.  This does
>>>> include changes to a number of files that aren't normally in my
>>>> purview.  There are suitable Acked-by lines and Peter requested this
>>>> come in via my tree, since the most pressing requirement for it is in
>>>> pseries machines with the POWER secure virtual machine facility.
>>>>
>>>> In addition we have:
>>>>  * The start of Daniel Barboza's rework and clean up of pseries
>>>>    machine NUMA handling
>>>>  * Correction to behaviour of the nvdimm= generic machine property on
>>>>    pseries
>>>>  * An optimization to the allocation of XIVE interrupts on KVM
>>>>  * Some fixes for confused behaviour with kernel_irqchip when both
>>>>    XICS and XIVE are in play
>>>>  * Add HIOMAP comamnd to pnv flash
>>>>  * Properly advertise the fact that spapr_vscsi doesn't handle
>>>>    hotplugged disks
>>>>  * Some assorted minor enhancements
>>>
>>> Hi -- this fails to build for Windows:
>>>
>>> ../../hw/ppc/spapr_numa.c: In function 'spapr_numa_fixup_cpu_dt':
>>> ../../hw/ppc/spapr_numa.c:77:5: error: unknown type name 'uint'
>>>      uint vcpu_assoc_size = NUMA_ASSOC_SIZE + 1;
>>>      ^
>>
>> Huh, that's weird.  My testing run was less thorough than I'd usually
>> do, because so many tests were broken on the master branch, but I was
>> pretty sure I did do successful mingw builds.
>>
>>> That should probably be using one of the standard C types.
>>
>> Done.
>>
>>> The 'check-tcg' tests for the linux-user static build also
>>> failed on an s390x test:
>>>
>>>   CHECK   debian-s390x-cross
>>>   BUILD   s390x-linux-user guest-tests with docker qemu/debian-s390x-cross
>>>   RUN     tests for s390x
>>>   TEST    threadcount on s390x
>>> Unhandled trap: 0x10003
> 
> This is EXCP_HALTED (include/exec/cpu-all.h)
> 
> The message error comes from cpu_loop() in linux-user/s390x/cpu_loop.c.
> 
> The trap can only come from accel/tcg/cpu-exec.c
> 
>     679 int cpu_exec(CPUState *cpu)
>     680 {
> ...
>     688     if (cpu_handle_halt(cpu)) {
>     689         return EXCP_HALTED;
>     690     }
> 
> and
> 
>     428 static inline bool cpu_handle_halt(CPUState *cpu)
>     429 {
>     430     if (cpu->halted) {
> ...
>     441         if (!cpu_has_work(cpu)) {
>     442             return true;
>     443         }
> 
> and
> 
>      58 static bool s390_cpu_has_work(CPUState *cs)
>      59 {
>      60     S390CPU *cpu = S390_CPU(cs);
>      61
>      62     /* STOPPED cpus can never wake up */
>      63     if (s390_cpu_get_state(cpu) != S390_CPU_STATE_LOAD &&
>      64         s390_cpu_get_state(cpu) != S390_CPU_STATE_OPERATING) {
>      65         return false;
>      66     }
>      67
>      68     if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
>      69         return false;
>      70     }
>      71
>      72     return s390_cpu_has_int(cpu);
>      73 }
> 
> and in target/s390x/cpu.h:
> 
>     772 #ifndef CONFIG_USER_ONLY
>     773 unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu);
>     774 #else
>     775 static inline unsigned int s390_cpu_set_state(uint8_t cpu_state,
> S390CPU *cpu)
>     776 {
>     777     return 0;
>     778 }
>     779 #endif /* CONFIG_USER_ONLY */
>     780 static inline uint8_t s390_cpu_get_state(S390CPU *cpu)
>     781 {
>     782     return cpu->env.cpu_state;
>     783 }
> 
> As cpu_state is never set, perhaps in case of linux-user it should
> always return S390_CPU_STATE_OPERATING?
> 
> Something like:
> 
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index 035427521cec..8a8628fcdcc6 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -771,16 +771,20 @@ int s390_assign_subch_ioeventfd(EventNotifier
> *notifier, uint32_t sch_id,
>                                  int vq, bool assign);
>  #ifndef CONFIG_USER_ONLY
>  unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu);
> +static inline uint8_t s390_cpu_get_state(S390CPU *cpu)
> +{
> +    return cpu->env.cpu_state;
> +}
>  #else
>  static inline unsigned int s390_cpu_set_state(uint8_t cpu_state,
> S390CPU *cpu)
>  {
>      return 0;
>  }
> -#endif /* CONFIG_USER_ONLY */
>  static inline uint8_t s390_cpu_get_state(S390CPU *cpu)
>  {
> -    return cpu->env.cpu_state;
> +    return S390_CPU_STATE_OPERATING;
>  }
> +#endif /* CONFIG_USER_ONLY */

Since this is the effect of your "target/s390x: Use start-powered-off
CPUState property" patch, can you have a look please?

> 
> Thanks,
> Laurent
> 
>>> PSW=mask 0000000180000000 addr 00000000010004f0 cc 00
>>> R00=0000000000000000 R01=0000000000000000 R02=0000000000000000
>>> R03=0000000000000000
>>> R04=0000000000000000 R05=0000000000000000 R06=0000000000000000
>>> R07=0000000000000000
>>> R08=0000000000000000 R09=0000000000000000 R10=0000000000000000
>>> R11=0000000000000000
>>> R12=0000000000000000 R13=0000000000000000 R14=0000000000000000
>>> R15=00000040008006c0
>>>
>>> ../Makefile.target:153: recipe for target 'run-threadcount' failed
>>> make[2]: *** [run-threadcount] Error 1
>>
>> Bother.  I did see that failure on Travis, but assumed it was a false
>> positive because there were so many failures on master there.
>>
> 
> 


