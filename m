Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A93C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 19:47:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 743F621532
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 19:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LqV/ZOw3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 743F621532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFN70-0004LB-K0
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 15:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFN65-0003gm-Bn
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 15:46:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22683
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kFN63-00069U-7D
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 15:46:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599507994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=s0aJSzprLOcOzx03or6Da6vqQb9tdGcU5CLWmCvMngs=;
 b=LqV/ZOw39xaWcKzsirgq+8qodV0a9F9z6Wx5lsLIYFC+JZ8ToX0S5e0BKU57K7O2iPvfRx
 tmdf74aqbRDwRAchoLi0FcvzTRiDUSjkjA2KPFpc2Y2kzFOAdHynApubMbnMGjSyDRg3PA
 DPudsmxO9PlX/Xor2PRgpK5IacT+5Nk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-g9KB1flUN7mIUuF-CzxRQQ-1; Mon, 07 Sep 2020 15:46:32 -0400
X-MC-Unique: g9KB1flUN7mIUuF-CzxRQQ-1
Received: by mail-wr1-f71.google.com with SMTP id r15so6002584wrt.8
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 12:46:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=s0aJSzprLOcOzx03or6Da6vqQb9tdGcU5CLWmCvMngs=;
 b=Svf2tjBi8dp0WjlZhBcPTXU3i1h+RMpF6lzpYY3qNNioH/F8AYBpYYv5Zfy20iUjwS
 o1I3cZzeOed0GnwXNWU6JSJj3/G0DQkyTmoXoImcp81FvX+X0njKCdcewDH9ViqWhJc1
 ZePjFiHy2HsQaZQ8H0lzRO46m8GaJKx97VXrzjZYgw4SkxRIyWpV9tll6hJAoISZqrYh
 vqpVt11psInvrPS81e6GoVczCAkc+WgPKstucyieN48vknz8j70FqueKCSvsECAP0ZkM
 ZViHoYcxBgpN5Rm9KtqAN9lfTBr3Pk1gOnfkw5FJ9ThMHphLLgL8r/JuvTeCGVl9Nw/I
 gejA==
X-Gm-Message-State: AOAM533s+Chx+UP11Lbh/KO6qxyFcQfdvHNIWH5u9EwJyt952R2JXw08
 A4+2EigeNzfc1N6cBNCGOocTbNhd2Quf7c3VuPkAmHugd07P7NQ8tml3yDX2BjEHFKHyL5dGWzT
 VVHudUnMZUS58QHA=
X-Received: by 2002:a05:600c:2118:: with SMTP id
 u24mr807808wml.59.1599507991104; 
 Mon, 07 Sep 2020 12:46:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzoOdABf7dkO9kUVgfMoOcQxZVzNcRB6E1dwpfGJg99SdTw9YgiQ8Ic8a9sL8kseJW5T9NyRQ==
X-Received: by 2002:a05:600c:2118:: with SMTP id
 u24mr807777wml.59.1599507990807; 
 Mon, 07 Sep 2020 12:46:30 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id u66sm28680116wmg.44.2020.09.07.12.46.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2020 12:46:30 -0700 (PDT)
Subject: Re: [PULL 00/30] ppc-for-5.2 queue 20200904
To: Laurent Vivier <lvivier@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20200904034719.673626-1-david@gibson.dropbear.id.au>
 <CAFEAcA8xCpRBcsCaozEXnCuM5SqWr5ZEDrwLjs+8va=316_70Q@mail.gmail.com>
 <20200907023800.GJ341806@yekko.fritz.box>
 <675253df-b750-1a0a-5447-9dadef1accba@redhat.com>
 <7c287125-70b3-4330-fd5c-8e644e1c347d@redhat.com>
 <ffee957d-0428-d167-c1ab-3fe67b4d8c7c@redhat.com>
 <20200907165132.683d2880.cohuck@redhat.com>
 <f93673f9-3e83-ef5f-9628-819b25908e43@redhat.com>
 <77b63a31-48a8-c77f-9956-7511db170594@redhat.com>
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
Message-ID: <0bca4e6e-f4ba-2108-ecaf-c3daaadbdb26@redhat.com>
Date: Mon, 7 Sep 2020 21:46:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <77b63a31-48a8-c77f-9956-7511db170594@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 03:19:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.825, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Greg Kurz <groug@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>, Thiago Jung Bauermann <bauerman@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/7/20 7:26 PM, Laurent Vivier wrote:
> On 07/09/2020 18:29, Laurent Vivier wrote:
>> On 07/09/2020 16:51, Cornelia Huck wrote:
>>> On Mon, 7 Sep 2020 16:31:24 +0200
>>> Laurent Vivier <lvivier@redhat.com> wrote:
>>>
>>>> On 07/09/2020 16:05, Philippe Mathieu-Daudé wrote:
>>>>> Hi Thiago,
>>>>>
>>>>> On 9/7/20 3:29 PM, Laurent Vivier wrote:  
>>>>>> On 07/09/2020 04:38, David Gibson wrote:  
>>>>>>> On Sun, Sep 06, 2020 at 04:20:10PM +0100, Peter Maydell wrote:  
>>>
>>>>>>>> The 'check-tcg' tests for the linux-user static build also
>>>>>>>> failed on an s390x test:
>>>>>>>>
>>>>>>>>   CHECK   debian-s390x-cross
>>>>>>>>   BUILD   s390x-linux-user guest-tests with docker qemu/debian-s390x-cross
>>>>>>>>   RUN     tests for s390x
>>>>>>>>   TEST    threadcount on s390x
>>>>>>>> Unhandled trap: 0x10003  
>>>>>>
>>>>>> This is EXCP_HALTED (include/exec/cpu-all.h)
>>>>>>
>>>>>> The message error comes from cpu_loop() in linux-user/s390x/cpu_loop.c.
>>>>>>
>>>>>> The trap can only come from accel/tcg/cpu-exec.c
>>>>>>
>>>>>>     679 int cpu_exec(CPUState *cpu)
>>>>>>     680 {
>>>>>> ...
>>>>>>     688     if (cpu_handle_halt(cpu)) {
>>>>>>     689         return EXCP_HALTED;
>>>>>>     690     }
>>>>>>
>>>>>> and
>>>>>>
>>>>>>     428 static inline bool cpu_handle_halt(CPUState *cpu)
>>>>>>     429 {
>>>>>>     430     if (cpu->halted) {
>>>>>> ...
>>>>>>     441         if (!cpu_has_work(cpu)) {
>>>>>>     442             return true;
>>>>>>     443         }
>>>>>>
>>>>>> and
>>>>>>
>>>>>>      58 static bool s390_cpu_has_work(CPUState *cs)
>>>>>>      59 {
>>>>>>      60     S390CPU *cpu = S390_CPU(cs);
>>>>>>      61
>>>>>>      62     /* STOPPED cpus can never wake up */
>>>>>>      63     if (s390_cpu_get_state(cpu) != S390_CPU_STATE_LOAD &&
>>>>>>      64         s390_cpu_get_state(cpu) != S390_CPU_STATE_OPERATING) {
>>>>>>      65         return false;
>>>>>>      66     }
>>>>>>      67
>>>>>>      68     if (!(cs->interrupt_request & CPU_INTERRUPT_HARD)) {
>>>>>>      69         return false;
>>>>>>      70     }
>>>>>>      71
>>>>>>      72     return s390_cpu_has_int(cpu);
>>>>>>      73 }
>>>>>>
>>>>>> and in target/s390x/cpu.h:
>>>>>>
>>>>>>     772 #ifndef CONFIG_USER_ONLY
>>>>>>     773 unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu);
>>>>>>     774 #else
>>>>>>     775 static inline unsigned int s390_cpu_set_state(uint8_t cpu_state,
>>>>>> S390CPU *cpu)
>>>>>>     776 {
>>>>>>     777     return 0;
>>>>>>     778 }
>>>>>>     779 #endif /* CONFIG_USER_ONLY */
>>>>>>     780 static inline uint8_t s390_cpu_get_state(S390CPU *cpu)
>>>>>>     781 {
>>>>>>     782     return cpu->env.cpu_state;
>>>>>>     783 }
>>>>>>
>>>>>> As cpu_state is never set, perhaps in case of linux-user it should
>>>>>> always return S390_CPU_STATE_OPERATING?
>>>
>>> Possibly, we should not have any state handling for linux-user.
>>>
>>
>> I did that, but now 390_cpu_has_work() is false because
>> CPU_INTERRUPT_HARD is not set in cs->interrupt_request.
>>
>> I think we should not enter in cpu_loop() with halted set to 1.
>>
>> Before the patch of this series, s390_cpu_reset() is called twice, and
>> on the second call, halted is already 0.
>>
>> With start_powered_off set to true in initfn, on the first reset
>> "halted" is 0 and on the second it is 1 (because it has been copied from
>> start_powered_off) and so cpu_loop() starts with halted set to 1 and fails.
> 
> What is happening:
> 
> [without start_powered_off]
> 
>   1- halted is set to 1 in s390x_cpu_initfn()
>   2- halted is set to 0 in s390x_cpu_reset() by parent_reset()
>      (cpu_common_reset()
>   3- cpu_loop() is always entered with halted set to 0
> 
> [with start_powered_off]
> 
>   1- halted is set to start_powered_off (1) in s390x_cpu_reset() by
>      parent_reset() (cpu_common_reset()
>   2- cpu_loop() is always entered with halted set to 1
> 
> So in the first case, cpu_loop() is always started with halted set to 0
> and in the second case with halted set to 1.
> 
> And I think, with linux-user, it should never be started with halted set
> to 1.
> 
> We can't add a "#ifdef CONFIG_USER_ONLY" in hw/core/cpu.c to set halted
> to 0 because it is in the common files, but we can do:
> 
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index 73d7d6007e8e..749cd548f0f3 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -291,9 +291,9 @@ static void s390_cpu_initfn(Object *obj)
>      S390CPU *cpu = S390_CPU(obj);
> 
>      cpu_set_cpustate_pointers(cpu);
> -    cs->start_powered_off = true;
>      cs->exception_index = EXCP_HLT;
>  #if !defined(CONFIG_USER_ONLY)
> +    cs->start_powered_off = true;
>      object_property_add(obj, "crash-information", "GuestPanicInformation",
>                          s390_cpu_get_crash_info_qom, NULL, NULL, NULL);
>      cpu->env.tod_timer =

This looks like the correct fix indeed :)
(Maybe worth adding a comment around).

Thanks for investigating!

> 
> Thanks,
> Laurent


