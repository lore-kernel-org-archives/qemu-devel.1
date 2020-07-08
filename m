Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48008C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:20:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C52502065F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UTVazGw5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C52502065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtIR0-00005m-1C
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jtHuS-0004dp-RC
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:47:20 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53478
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jtHuR-0004cb-3J
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 17:47:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594244838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HpsZJqnmIq/VxcM7U7OUI9Ufp4/qy81hRLaJm1qUoFk=;
 b=UTVazGw5EsuTgIWesZSv+cObLXcxnj02KPQQKLRuHyzrzb7GF42hQ1LnITrPDbk1p9IA/T
 tld/FIllDwkfc8IvMPkZZKtXEuapXkbSXHEzxmH6MmENmMEIMvXpn/OWWyRyJ6uQeH1y6J
 WssyJjCy45St/QCnrHacdq8hwizQTR0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-SDNpNPtZPTOeJGj-3kxjIw-1; Wed, 08 Jul 2020 12:46:01 -0400
X-MC-Unique: SDNpNPtZPTOeJGj-3kxjIw-1
Received: by mail-wm1-f72.google.com with SMTP id f68so4743567wmf.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 09:46:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=HpsZJqnmIq/VxcM7U7OUI9Ufp4/qy81hRLaJm1qUoFk=;
 b=PiAUND9CNbUMOaJQd75RU4bvC5B58LZVw670U0uyWJQ1Cq7u2v3Da47ZjFoR+rICuq
 kwH+SP/wSYzcs/qoNTMfzExxd2eDuxlDmhq7BYU0PCJbBUQrQ1E+OH3xx9RWCe2hvWXS
 bSYbIeU01oY69jYqdribqumZLii1fTgGvgStlKi4+d9YUOqjEVu8Qxj7LtCK4HZAxKMG
 5+dV02rUF4xLPp87Al4kW8KCUCMKbLO3TmS5M3D0q2FcRbi9rjHiZji+34UabmzWkrrN
 vmomq8q15sfNcxKwKLVWFdm2B0PseBFxjNC6yt/oifBqJ+q9tSAhkHjCWmj/+lAuu36S
 1jHQ==
X-Gm-Message-State: AOAM533p0tiMwqHmEYikp1ruzsFLSaM7i0lnmLL4t5rln/CvEHHPtnH+
 6XjcyJJl+Vo0Jw+Q1AM69uw7l9vgbJvTc6vFnjAYz4uxtcTDfOQYXy52Mlv7/WLQJA7G8tjPP8x
 1yI8MK8LDZV0DpBg=
X-Received: by 2002:a5d:4603:: with SMTP id t3mr63924706wrq.38.1594226759862; 
 Wed, 08 Jul 2020 09:45:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8NAtJo0zNfdSi1Y40mIlVb8e0Q0cR/XcvyoXEXcOR2ggP/w4RsINwR11GDOjbsfFkGC1Pjw==
X-Received: by 2002:a5d:4603:: with SMTP id t3mr63924679wrq.38.1594226759557; 
 Wed, 08 Jul 2020 09:45:59 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id k126sm570421wmf.3.2020.07.08.09.45.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2020 09:45:59 -0700 (PDT)
Subject: Re: [PATCH] cpu: Add starts_halted() method
To: Eduardo Habkost <ehabkost@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200707204333.261506-1-bauerman@linux.ibm.com>
 <20200707214917.GX7276@habkost.net> <87y2nu3nxq.fsf@morokweng.localdomain>
 <c53b36b7-ee7b-bb66-8220-cce788fd631d@redhat.com>
 <20200708100038.GG18595@umbus.fritz.box>
 <CAFEAcA9V7Uha9-rz+JY-5HkazCWuTk1vkLnw1m9Lw-bXXKbkvw@mail.gmail.com>
 <20200708152540.GZ7276@habkost.net>
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
Message-ID: <da4b5a4c-7a72-6e07-b423-1487ad358c31@redhat.com>
Date: Wed, 8 Jul 2020 18:45:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200708152540.GZ7276@habkost.net>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/8/20 5:25 PM, Eduardo Habkost wrote:
> On Wed, Jul 08, 2020 at 02:14:03PM +0100, Peter Maydell wrote:
>> On Wed, 8 Jul 2020 at 12:12, David Gibson <david@gibson.dropbear.id.au> wrote:
>>> On Wed, Jul 08, 2020 at 10:38:29AM +0200, Philippe Mathieu-DaudÃ© wrote:
>>>> Class boolean field certainly sounds better, but I am not sure this
>>>> is a property of the machine. Rather the arch? So move the field
>>>> to CPUClass? Maybe not, let's discuss :)
>>>
>>> It is absolutely a property of the machine.  e.g. I don't think we
>>> want this for powernv.  pseries is a bit of a special case since it is
>>> explicitly a paravirt platform.  But even for emulated hardware, the
>>> board can absolutely strap things so that cpus do or don't start
>>> immediately.
>>
>> It's a property of the individual CPU, I think. One common setup
>> for Arm systems is that the primary CPU starts powered up but
>> the secondaries all start powered down.
> 
> Both statements can be true.  It can be a property of the
> individual CPU (although I'm not convinced it has to), but it
> still needs to be controlled by the machine.

From what said Peter, I understand this is a property of the
chipset. Chipsets are modelled unevenly.

IIUC QEMU started with single-core CPUs.
CPUState had same meaning for 'core' or 'cpu', 1-1 mapping.

Then multicore CPUs could be easily modelled using multiple
single-core CPUs, usually created in the machine code.

Then we moved to SoC models, creating the cores in the SoC.
Some SoCs have array of cores, eventually heterogeneous
(see the ZynqMP). We have containers of CPUState.

On an ARM-based SoC, you might have the first core started
(as said Peter) or not.

BCM2836 / BCM2837 and ZynqMP start will all ARM cores off.
On the BCM chipsets, a DSP core will boot the ARM cores.
On the ZynqMP, a MicroBlaze core boots them.
As QEMU doesn't models heterogeneous architectures, we start
modelling after the unmodelled cores booted us, so either one
or all cores on.

In this case, we narrowed down the 'start-powered-off' field
to the SoC, which happens to be how ARM SoCs are modelled.


Chipsets providing a JTAG interface can have a SRST signal,
the "system reset". When a JTAG probe is attached, it can
keeps the whole chipset in a reset state. This is equivalent
to QEMU '-S' mode (single step mode).


I don't know about pseries hardware, but if this is 'explicit
to paravirt platform', then I expect this to be the same with
other accelerators/architectures.

If paravirtualized -> cores start off by default. Let the
hypervisor start them. So still a property of the CPUState
depending on the accelerator used?


Regards,

Phil.


