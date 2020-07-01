Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54261C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:24:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16AFD207F5
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OsN6Sy2v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16AFD207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqebX-0005wO-Do
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 11:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqeOA-0005Lt-4a
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:11:09 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53519
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqeO7-0002M6-2O
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:11:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593616261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3OzkLmjp2/6OT377j2dxBv/5JQQ05QCE0dQNnMjasKY=;
 b=OsN6Sy2vwvbRXwrsgUGHjjl55qpXsPx4Dw/H2gMq34z7Glv7lf/nDHUo4FbktvR01D+W6W
 yo4RYYruUA1IObJXwhttOqM7GM5huMVJuYCrNW4AOcA+Gwqtjwg96Xuegcuqwv2YYwsPYS
 KyRjWk8wCWsHUkGLZX5itF6nm94Xdh8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-p9Rr8LvzOPSBiR9tz1ZD3Q-1; Wed, 01 Jul 2020 11:10:57 -0400
X-MC-Unique: p9Rr8LvzOPSBiR9tz1ZD3Q-1
Received: by mail-ed1-f72.google.com with SMTP id cn4so16813529edb.9
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 08:10:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=3OzkLmjp2/6OT377j2dxBv/5JQQ05QCE0dQNnMjasKY=;
 b=ZV0vdh9+V3UuYPL2/E/IWe79q1KDwrKFT4EOpxVrWgpOstDtkZy3rEExBAV/QMgOOn
 rWCnSrgLjpVowqtdhOyJIIetRJvEIfqvhBH1DABYp75zJFCsd7/bTml4XHIHGrZK+lcN
 zdZlV5RgF45vgJq2IYukA3cfoEjliMmlpTPNMrjtN+4LLM+b3JfsssHhV/Z3+bbY1uRr
 O+0acbyE6DOFEOHH8v3t0bsu2IeHB4kShWgAFbNCqu87nYkbQJcgBtzhB5gm/3UCa0TH
 LzG0ctM87JZhGRkUp1/cWN3r53PrXulEnoN5wMZA//A86aLX6G4RZdfX66LqrE2+cOKR
 Fcwg==
X-Gm-Message-State: AOAM530ADmUeEnDpd8RbZ18q4xOI9rrE0buJTR+/jABn+KHwEzzLNNVP
 gYd2NWql7hCVZ7zQLiJt/VP7iM6XEnr9jc6Ydt+uTOovAvbGalJZgbro7376ORST1UTDnAN81NP
 C9Q8No4U/V0ULSWU=
X-Received: by 2002:a17:906:35d2:: with SMTP id
 p18mr24456296ejb.393.1593616256218; 
 Wed, 01 Jul 2020 08:10:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRsyWL+FnQ+2J4ypqMaTDn8KOMxKU/MhqjZ2pwt5D4D1Yx8kgojUgOqxbplfComQUP53vs5g==
X-Received: by 2002:a17:906:35d2:: with SMTP id
 p18mr24456276ejb.393.1593616256004; 
 Wed, 01 Jul 2020 08:10:56 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id c10sm97656edt.22.2020.07.01.08.10.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2020 08:10:55 -0700 (PDT)
Subject: Re: [PATCH 2/2] xen: cleanup unrealized flash devices
To: Jason Andryuk <jandryuk@gmail.com>
References: <20200624121841.17971-1-paul@xen.org>
 <20200624121841.17971-3-paul@xen.org>
 <33e594dd-dbfa-7c57-1cf5-0852e8fc8e1d@redhat.com>
 <000701d64ef5$6568f660$303ae320$@xen.org>
 <9e591254-d215-d5af-38d2-fd5b65f84a43@redhat.com>
 <000801d64f75$c604f570$520ee050$@xen.org>
 <CAKf6xpvNTVqK263pdSARyoWnzP8g9SRoSqvhnLLwyYadjR1ChQ@mail.gmail.com>
 <07cc67e9-aeaa-1947-43db-c00716bead01@redhat.com>
 <5c00f6a5-3f86-258e-999f-956eef825d14@redhat.com>
 <CAKf6xpuiQBhvChwfikaLd4tvKVUn3oo88wbsMVw7P11ehV-EYQ@mail.gmail.com>
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
Message-ID: <7cec82ad-208c-04d9-4ad7-8656cc914516@redhat.com>
Date: Wed, 1 Jul 2020 17:10:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAKf6xpuiQBhvChwfikaLd4tvKVUn3oo88wbsMVw7P11ehV-EYQ@mail.gmail.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 00:56:58
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paul Durrant <pdurrant@amazon.com>,
 Paul Durrant <paul@xen.org>, QEMU <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 xen-devel <xen-devel@lists.xenproject.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/1/20 4:59 PM, Jason Andryuk wrote:
> On Wed, Jul 1, 2020 at 8:55 AM Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>> On 7/1/20 2:40 PM, Philippe Mathieu-Daudé wrote:
>>> On 7/1/20 2:25 PM, Jason Andryuk wrote:
>>>> On Wed, Jul 1, 2020 at 3:03 AM Paul Durrant <xadimgnik@gmail.com> wrote:
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Philippe Mathieu-Daudé <philmd@redhat.com>
>>>>>> Sent: 30 June 2020 18:27
>>>>>> To: paul@xen.org; xen-devel@lists.xenproject.org; qemu-devel@nongnu.org
>>>>>> Cc: 'Eduardo Habkost' <ehabkost@redhat.com>; 'Michael S. Tsirkin' <mst@redhat.com>; 'Paul Durrant'
>>>>>> <pdurrant@amazon.com>; 'Jason Andryuk' <jandryuk@gmail.com>; 'Paolo Bonzini' <pbonzini@redhat.com>;
>>>>>> 'Richard Henderson' <rth@twiddle.net>
>>>>>> Subject: Re: [PATCH 2/2] xen: cleanup unrealized flash devices
>>>>>>
>>>>>> On 6/30/20 5:44 PM, Paul Durrant wrote:
>>>>>>>> -----Original Message-----
>>>>>>>> From: Philippe Mathieu-Daudé <philmd@redhat.com>
>>>>>>>> Sent: 30 June 2020 16:26
>>>>>>>> To: Paul Durrant <paul@xen.org>; xen-devel@lists.xenproject.org; qemu-devel@nongnu.org
>>>>>>>> Cc: Eduardo Habkost <ehabkost@redhat.com>; Michael S. Tsirkin <mst@redhat.com>; Paul Durrant
>>>>>>>> <pdurrant@amazon.com>; Jason Andryuk <jandryuk@gmail.com>; Paolo Bonzini <pbonzini@redhat.com>;
>>>>>>>> Richard Henderson <rth@twiddle.net>
>>>>>>>> Subject: Re: [PATCH 2/2] xen: cleanup unrealized flash devices
>>>>>>>>
>>>>>>>> On 6/24/20 2:18 PM, Paul Durrant wrote:
>>>>>>>>> From: Paul Durrant <pdurrant@amazon.com>
>>>>>>>>>
>>>>>>>>> The generic pc_machine_initfn() calls pc_system_flash_create() which creates
>>>>>>>>> 'system.flash0' and 'system.flash1' devices. These devices are then realized
>>>>>>>>> by pc_system_flash_map() which is called from pc_system_firmware_init() which
>>>>>>>>> itself is called via pc_memory_init(). The latter however is not called when
>>>>>>>>> xen_enable() is true and hence the following assertion fails:
>>>>>>>>>
>>>>>>>>> qemu-system-i386: hw/core/qdev.c:439: qdev_assert_realized_properly:
>>>>>>>>> Assertion `dev->realized' failed
>>>>>>>>>
>>>>>>>>> These flash devices are unneeded when using Xen so this patch avoids the
>>>>>>>>> assertion by simply removing them using pc_system_flash_cleanup_unused().
>>>>>>>>>
>>>>>>>>> Reported-by: Jason Andryuk <jandryuk@gmail.com>
>>>>>>>>> Fixes: ebc29e1beab0 ("pc: Support firmware configuration with -blockdev")
>>>>>>>>> Signed-off-by: Paul Durrant <pdurrant@amazon.com>
>>>>>>>>> Tested-by: Jason Andryuk <jandryuk@gmail.com>
>>>>>>>>> ---
>>>>>>>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>>>>>>>> Cc: Richard Henderson <rth@twiddle.net>
>>>>>>>>> Cc: Eduardo Habkost <ehabkost@redhat.com>
>>>>>>>>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>>>>>>>>> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>>>>>>>>> ---
>>>>>>>>>  hw/i386/pc_piix.c    | 9 ++++++---
>>>>>>>>>  hw/i386/pc_sysfw.c   | 2 +-
>>>>>>>>>  include/hw/i386/pc.h | 1 +
>>>>>>>>>  3 files changed, 8 insertions(+), 4 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>>>>>>>>> index 1497d0e4ae..977d40afb8 100644
>>>>>>>>> --- a/hw/i386/pc_piix.c
>>>>>>>>> +++ b/hw/i386/pc_piix.c
>>>>>>>>> @@ -186,9 +186,12 @@ static void pc_init1(MachineState *machine,
>>>>>>>>>      if (!xen_enabled()) {
>>>>>>>>>          pc_memory_init(pcms, system_memory,
>>>>>>>>>                         rom_memory, &ram_memory);
>>>>>>>>> -    } else if (machine->kernel_filename != NULL) {
>>>>>>>>> -        /* For xen HVM direct kernel boot, load linux here */
>>>>>>>>> -        xen_load_linux(pcms);
>>>>>>>>> +    } else {
>>>>>>>>> +        pc_system_flash_cleanup_unused(pcms);
>>>>>>>>
>>>>>>>> TIL pc_system_flash_cleanup_unused().
>>>>>>>>
>>>>>>>> What about restricting at the source?
>>>>>>>>
>>>>>>>
>>>>>>> And leave the devices in place? They are not relevant for Xen, so why not clean up?
>>>>>>
>>>>>> No, I meant to not create them in the first place, instead of
>>>>>> create+destroy.
>>>>>>
>>>>>> Anyway what you did works, so I don't have any problem.
>>>>>
>>>>> IIUC Jason originally tried restricting creation but encountered a problem because xen_enabled() would always return false at that point, because machine creation occurs before accelerators are initialized.
>>>>
>>>> Correct.  Quoting my previous email:
>>>> """
>>>> Removing the call to pc_system_flash_create() from pc_machine_initfn()
>>>> lets QEMU startup and run a Xen HVM again.  xen_enabled() doesn't work
>>>> there since accelerators have not been initialized yes, I guess?
>>>
>>> Ah, I missed that. You pointed at the bug here :)
>>>
>>> I think pc_system_flash_create() shouldn't be called in init() but
>>> realize().
>>
>> Hmm this is a MachineClass, not qdev, so no realize().
>>
>> In softmmu/vl.c we have:
>>
>> 4152     configure_accelerators(argv[0]);
>> ....
>> 4327     if (!xen_enabled()) { // so xen_enable() is working
>> 4328         /* On 32-bit hosts, QEMU is limited by virtual address space */
>> 4329         if (ram_size > (2047 << 20) && HOST_LONG_BITS == 32) {
>> 4330             error_report("at most 2047 MB RAM can be simulated");
>> 4331             exit(1);
>> 4332         }
>> 4333     }
>> ....
>> 4348     machine_run_board_init(current_machine);
>>
>> which calls in hw/core/machine.c:
>>
>> 1089 void machine_run_board_init(MachineState *machine)
>> 1090 {
>> 1091     MachineClass *machine_class = MACHINE_GET_CLASS(machine);
>> ....
>> 1138     machine_class->init(machine);
>> 1139 }
>>
>>          -> pc_machine_class_init()
>>
>> This should come after:
>>
>>          -> pc_machine_initfn()
>>
>>             -> pc_system_flash_create(pcms)
> 
> Sorry, I'm not following the flow you want.

Well, I was simply trying to understand what was wrong, and
what we should fix so you don't have to create flash devices
then destroy them when using Xen.

I already said Paul patch is OK and gave my R-b to it.

> 
> The xen_enabled() call in vl.c may always fail.  Or at least in most
> common Xen usage.  Xen HVMs are started with machine xenfv and don't
> specify an accelerator.  You need to process the xenfv default machine
> opts to process "accel=xen".  Actually, I don't know how the
> accelerator initialization works, but xen_accel_class_init() needs to
> be called to set `ac->allowed = &xen_allowed`.  xen_allowed is the
> return value of xen_enabled() and the accelerator initialization must
> toggle it.

Since you are happy how this current works, I'm also fine with it,
I won't investigate further.

Regards,

Phil.


