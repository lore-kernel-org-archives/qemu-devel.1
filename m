Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C86C33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:06:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC55C214AF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="SAty2BDg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC55C214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izkc6-0006jj-JG
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 12:06:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59837)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <n54@gmx.com>) id 1izkVn-0000OR-LM
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:00:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <n54@gmx.com>) id 1izkVm-00028U-4M
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:00:19 -0500
Received: from mout.gmx.net ([212.227.15.15]:44789)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <n54@gmx.com>) id 1izkVl-00026Z-JM
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:00:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1581008396;
 bh=JNCU7gtQsJAiLhtlRQv5Wezh/cw9rczV+fHDWCZKJIM=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=SAty2BDgOHl8/leKhT7jzd1cZEYmqUWRj9RU8AkmJbYfOyk7pOSnixm4jlbvet5u1
 4qeFhoRDQyQfEkTL6NOFowVfhqF9z5+HMjM6e5NyTogWIc5cqpvFnHaPAhxbAxDu2F
 UKRMzHkGX5mNJlnQgImpUKvDskoTH2GdInpuYuqU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.241] ([89.71.135.231]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M9Wuk-1iuGKW28vs-005WgQ; Thu, 06
 Feb 2020 17:59:56 +0100
Subject: Re: [PATCH v2 4/4] Add the NVMM acceleration enlightenments
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20200107124903.16505-1-n54@gmx.com>
 <20200128140945.929-1-n54@gmx.com> <20200128140945.929-5-n54@gmx.com>
 <0ed12efa-eee4-b3ff-8f02-f9c3b80d0e21@redhat.com>
 <2ae4caf9-05fd-b740-2612-e1c1ecafe277@gmx.com>
 <87o8ubuapr.fsf@dusky.pond.sub.org>
 <CAP+75-VnwDz0My7p5Zy3SN2gPeACW0z02MUgrdFnSGiZm6xGXg@mail.gmail.com>
 <e87ac5e1-749e-84a2-2c9e-89ac1c69fcdc@gmx.com>
 <87v9ojst1h.fsf@dusky.pond.sub.org>
 <f05b132a-00e6-9fe6-fc77-81e01cda9db2@gmx.com>
 <2e1a0fbb-6cf7-899a-856b-bc88a436cbd3@redhat.com>
From: Kamil Rytarowski <n54@gmx.com>
Autocrypt: addr=n54@gmx.com; prefer-encrypt=mutual; keydata=
 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
 4XSbcg==
Message-ID: <51319772-8397-8abb-033f-bfb887aa5f38@gmx.com>
Date: Thu, 6 Feb 2020 17:59:08 +0100
User-Agent: Mozilla/5.0 (X11; NetBSD amd64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <2e1a0fbb-6cf7-899a-856b-bc88a436cbd3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8Z8gdB+8BSonmRvbhH/tmn2bkVcqZPzEz/1Op3OvMUlzUGjvzPw
 g0uz3qjRIx4+WUE59nae3VFYgqYZR2+EcoSq5hK8k2E+WFnm4F4AyuiU9izFRBuEMyPP+YO
 ctKqgu+eCXOQmqKou6HwL4jK8Hq4kGSjsDj1BXZkInqqCRaUTMyNkfXEe20KWE2yvp6Lhxw
 PvmDwcblk1cKE88QGQk1Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aGiPAaIbJXE=:70lfjRrjIRxuebD+AJmxSn
 QK8QpG+Qh6cRnXUCZb1MjksGHFUMvyccUyDPCfY72XyzlXqQ6uVZvHxb/UprdQyzuJ8ACUtRL
 JUOH+410jdS1iC9edNV/f/m6tdUEk0ireHS/rCYSHid5Mn591TBeLaV4p5ItDN/Y1FsFFxih/
 d82b9Xr0sfG7TyNgUEQKL+MunivzjsSqx1iT/oe9HAQ+f08WNwZACpLMM5hYFL3Ehq9DxiWXJ
 o4G1Z5CocLVeaJ13dESFRUKpGc8HXaFK11gLjSX0o+XK29aPaDCDoZz2cWypG62eQucTK9dae
 kbQIBZOEEHCBGGXV9LMcyEosqIZzbIwaw/59cRixTnvMgIm8XvUUZWTPyeuyjaDy7P0f9/K01
 EnClb3/w1Nm7EHUHEGrSHQLPVag3sB7cs3hk+LFeLUdsrn0cEKQBFo0+GNtn6uHuTqXHcdca+
 sMGEnQLE4N5tSgJvidhlOV6z0T4CPKcZc7M4rfqEPUmon1B36yoMl1Agv1MqJrkAlDG2PzLXQ
 rZeq8Lr6dvUtDdpS7fdBnHgaK6XigNA2uyX9U7w75181PPdQHyBphpTbPEy6bhovEPAwmIZtL
 oHip791rt4lJhQQM8oToBdeybw6ecZjHb/Pj3DMt1Gmy9pcbomuuIhYVsQb+9JkYDsAsWmiBw
 iMYNQfW5KzzUxIohwahNO8OMEOg3gOHYcsOrAvKTIhqyANGTpYp6rIri90xoeALtUFHJEaCi5
 3IaVzWTbAZbZBt1nX0rJs1qbcOvp+fzFVSx8I44CJojujSLUOUexPRKIJHei3gUZxPX5RMBPL
 SIdTYBFE84oZmVtkdrVuDnGknlc7VokI3wxRy6IcQrmLWqioGILnDj/NKBuEx4BFhc8hjXbkL
 vanaFVf7VqgvOAM9pAlNRT2rBJyKE4a25n7jSIwbgZSsnQ9KQQtcTvAAXo48IVmuBz7IyCQ6k
 7KDv0cNlX4zSb4E4156wEw0AoUXSXyEurRZaN50TG1yhb30UWSZ596qTr0D7t1k1QIErcIuWf
 zNiDWFE289wlpQeC6J1aKZCxXXLze6svZSgM+iKs4wl/YVxjOXcPFLQ/dcr2yZwNUhELCm0it
 puvrM6studJja1GIwPN5a7csyccZV0nks4ntcCDsw8mvWwHPJjjmXRAM6jKtNmUdvt1NkXugy
 2/dO5Eg1VpsPwxIEkWH7b6a1LsdXPabWRTJc42a0CK0trtKLYRabDToMo/Ab26aJLD09Q=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.15
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
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, max@m00nbsd.net,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06.02.2020 17:07, Philippe Mathieu-Daud=C3=A9 wrote:
> On 2/6/20 4:38 PM, Kamil Rytarowski wrote:
>> On 06.02.2020 15:13, Markus Armbruster wrote:
>>> Kamil Rytarowski <n54@gmx.com> writes:
>>>
>>>> On 06.02.2020 14:09, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>> On Thu, Feb 6, 2020 at 2:06 PM Markus Armbruster
>>>>> <armbru@redhat.com> wrote:
>>>>>> Kamil Rytarowski <n54@gmx.com> writes:
>>>>>>
>>>>>>> On 03.02.2020 12:54, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>>>>>> @@ -2029,6 +2072,19 @@ static void
>>>>>>>>> qemu_whpx_start_vcpu(CPUState *cpu)
>>>>>>>>> =C2=A0=C2=A0 #endif
>>>>>>>>> =C2=A0=C2=A0 }
>>>>>>>>>
>>>>>>>>> +static void qemu_nvmm_start_vcpu(CPUState *cpu)
>>>>>>>>> +{
>>>>>>>>> +=C2=A0=C2=A0=C2=A0 char thread_name[VCPU_THREAD_NAME_SIZE];
>>>>>>>>> +
>>>>>>>>> +=C2=A0=C2=A0=C2=A0 cpu->thread =3D g_malloc0(sizeof(QemuThread)=
);
>>>>>>>>> +=C2=A0=C2=A0=C2=A0 cpu->halt_cond =3D g_malloc0(sizeof(QemuCond=
));
>>>>>>>>
>>>>>>>> Nitpick, we prefer g_new0().
>>>>>>>
>>>>>>> In this file other qemu_*_start_vcpu() use=C2=A0 g_malloc0().
>>>>>>>
>>>>>>> I will leave this part unchanged and defer tor future style
>>>>>>> fixups if
>>>>>>> someone is interested.
>>>>>>
>>>>>> Time to re-run Coccinelle with the semantic patch from commit
>>>>>> b45c03f585e.
>>>>>
>>>>> I thought about it, but then noticed it would be clever to modify
>>>>> checkpatch to refuse 'g_malloc0?(.*sizeof.*);'
>>>>>
>>>>>
>>>>
>>>> As the patchset was reviewed, could we please merge it in the current
>>>> (v3) form (*) please?
>>>
>>> No objection.=C2=A0 If I wanted you to clean this up before we accept =
your
>>> work, I would've told you :)
>>>
>>> [...]
>>>
>>>
>>
>> I see. I don't own myself a merge queue so I depend on yours.
>
> As you said [*] you'd love to have this feature in NetBSD 9.0, no
> objection neither. You still need some X86 specialist to review patch 3.
> The usual reviewers Paolo/Eduardo/Richard are currently very busy.
>
> Also while I'd love to use this feature to be able to regularly run QEMU
> CI on NetBSD, I don't have time to test it on a bare metal hardware :|
> Maybe do you know someone from the NetBSD community who already did?
>
> [*] https://www.mail-archive.com/qemu-devel@nongnu.org/msg676199.html
>
>

I'm going to find a person to test it and submit "Tested-by:".

