Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A51C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 07:57:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 911C520772
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 07:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BYHC+Gpj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 911C520772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqu5p-0003gO-SS
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 03:57:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqu44-00021g-7u
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 03:55:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57207
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqu41-0005SV-GB
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 03:55:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593676517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6lfMlaM/HvbmefHsvlqXlSQ0tJvKlJ2MtTJYbilNiH0=;
 b=BYHC+Gpjf6z1gBZh1mUhpFcrWDSrX7R/Ugn3piTtyiB4/8OS26FLFiucSuW3wkSpd9kuUV
 Hv5aN8n/67k6tM8XR5loEKLyT4qRsEDHEP7TZsqWQi+H2akghcVyNJRg8O7sWm7hFgBxXu
 Osfz/0infA+mVOvjNjnmkGRJTvk/vK8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-NW5DNjnZNt2qJQgHAHMOwA-1; Thu, 02 Jul 2020 03:55:13 -0400
X-MC-Unique: NW5DNjnZNt2qJQgHAHMOwA-1
Received: by mail-ej1-f70.google.com with SMTP id cf15so19658680ejb.6
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 00:55:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=6lfMlaM/HvbmefHsvlqXlSQ0tJvKlJ2MtTJYbilNiH0=;
 b=dYLT7r1wSoYTqKDcwygQz477aMqDeg+5q3O7CeB327yO5eZX5TbIeeZj5w32rju1l0
 pXlUQbfVHFKtqHd0VKeQdn9goFBW48SHPSxHIXb1K5aKT0/byOY8bJiaYEGC8fxvINw/
 +QgdbARj1TXxOSmTU8d3HyDv3GaMBGyd/hI/fSLsbbCZcJnqQwF7nkJp7+BpLdZ4J4z0
 DLotu7vq8EasyQepOlzvLrwuoMnqXdseVD4viR+o+GZQfrOxalcrNATdpt6RszLcsX1L
 cwbY4BWFz6KG1t7yqBxJG4mp9RwtSMuUZg3e9gHKfoCRIoaIu/YwUAd5MYH36tUx18DU
 +WDA==
X-Gm-Message-State: AOAM530dNJZqDRrX25W+xPJgAtKC6y4LXjbden2+nM7muU+1d3rxXVzr
 2Ne7M85v4Admm6FUbWIv3YskO3x0IrJqXmLB0ISyqj8pY85Q7jDb6jE90Q+HeeBaM6bK61UY9OE
 KVd1701RTEUCiFgE=
X-Received: by 2002:a17:907:42cb:: with SMTP id
 nz19mr25823196ejb.447.1593676512544; 
 Thu, 02 Jul 2020 00:55:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZNwrZcpE2/3HHJPwFUXuFhtmxfB4mQlcLUQLZwZhWLXbAf7TvrfO7BLJJa3hnxXEJwrTahw==
X-Received: by 2002:a17:907:42cb:: with SMTP id
 nz19mr25823182ejb.447.1593676512313; 
 Thu, 02 Jul 2020 00:55:12 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id gr15sm6210642ejb.84.2020.07.02.00.55.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2020 00:55:11 -0700 (PDT)
Subject: Re: [RFC PATCH] cpus: Initialize current_cpu with the first vCPU
 created
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20200701182100.26930-1-philmd@redhat.com>
 <CAFEAcA8ZKEVySwDAQ+x9xA9bosOs5q20CZLZjBvkXj_d6ZVBuA@mail.gmail.com>
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
Message-ID: <576dcd72-84d4-bab2-7732-29c767d6939a@redhat.com>
Date: Thu, 2 Jul 2020 09:55:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8ZKEVySwDAQ+x9xA9bosOs5q20CZLZjBvkXj_d6ZVBuA@mail.gmail.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 03:23:40
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
Cc: Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Bug 1878645 <1878645@bugs.launchpad.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/1/20 10:35 PM, Peter Maydell wrote:
> On Wed, 1 Jul 2020 at 19:21, Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
>>
>> We can run I/O access with the 'i' or 'o' HMP commands in the
>> monitor. These commands are expected to run on a vCPU. The
>> monitor is not a vCPU thread. To avoid crashing, initialize
>> the 'current_cpu' variable with the first vCPU created. The
>> command executed on the monitor will end using it.
> 
>>
>> RFC because I believe the correct fix is to NOT use current_cpu
>> out of cpus.c, at least use qemu_get_cpu(0) to get the first vCPU.
> 
> Yes, I agree -- I don't think this is the correct fix.
> current_cpu is documented as "only valid inside cpu_exec()",
> ie if you're actually on a vcpu thread you can use it, but if
> you're not on a CPU thread, like the monitor, you need to
> say which vCPU you want to affect. For the monitor, that
> would be the current "default cpu" as set by the "cpu"
> command (cf monitor_set_cpu()). The bug here will be that
> somewhere along the line we are probably missing plumbing
> sufficient to pass down "which CPU do we want".

TIL mon_get_cpu() :)

This is a bit different here, the monitor is not doing an
access on a CPU address space, but directly on the I/O
address space. The APM port is registered by the ICH9
south bridge, and this triggers a SMI exception on a
CPU core, but I have no idea which one, a random one?
Then this particular core will switch to SMM mode.

Another way of seeing this problem, is imagining we
start a PIT timer from the monitor. When the timer
expires, the PIT will interrupt the CPU. Which CPU
to interrupt? We are not in the context of the monitor.

> https://bugs.launchpad.net/qemu/+bug/1602247 is a bug of
> a similar nature -- if the gdbstub does a memory access
> we know which CPU we're trying to do that memory access as,
> but it doesn't get plumbed through and so in the Arm GIC
> register read/write function that looks at current_cpu
> we get a segfault.
> 
> One way to fix this would be to do something akin to how
> real hardware works -- encode into the MemTxAttrs an
> indication of what the transaction master was (eg the
> CPU number for CPUs); then the handful of devices that
> care about which CPU was doing the transaction can use
> that, rather than directly looking at current_cpu, and
> when gdbstub or monitor perform an access that should
> act like it's from a particular CPU they can indicate
> that by supplying appropriate transaction attributes.
> That would potentially be quite a bit of work though
> (but I think it would be a neat design if we want to
> try to fix this kind of "segfault if the user prods
> a device via the monitor" bug).

This is complex stuff. Too early for me to digest, I am
keeping this for later (I am not ignoring your comment).

> 
> +    if (!current_cpu) {
> +        current_cpu = cpu;
> +    }
> 
> Some more specific issues with this -- current_cpu is
> a thread-local variable, so this will set that for
> whatever thread happens to make this call, which
> might or might not be the one that ends up handling
> the monitor command. Also some code assumes that
> current_cpu is non-NULL only if this is a vCPU thread,
> eg sigbus_handler().

Yes, I agree.

> 
> thanks
> -- PMM
> 


