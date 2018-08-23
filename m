Received: from eggs.gnu.org ([2001:4830:134:3::10]:52222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chrisfriedt@gmail.com>) id 1fsw3J-0005Uf-Ez
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 16:17:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chrisfriedt@gmail.com>) id 1fsvnv-0003kw-7I
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 16:02:04 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:39979)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <chrisfriedt@gmail.com>)
	id 1fsvnv-0003kp-2A
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 16:02:03 -0400
Received: by mail-oi0-x243.google.com with SMTP id l202-v6so4538691oig.7
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 13:02:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAF4BF-R8iAkeHXFPHazY2Tmr+Yh=WrG4yKx=LVm7rRLBnxKseA@mail.gmail.com>
	<CAFEAcA_y2-N_aaG4W4rQABsTe=B++pSMp53_kKay0_MjGT4WpA@mail.gmail.com>
	<CAF4BF-RzCr_hx6iAPR3pQ_eAChue38eTE646EOou6XE6FkNSVQ@mail.gmail.com>
In-Reply-To: <CAF4BF-RzCr_hx6iAPR3pQ_eAChue38eTE646EOou6XE6FkNSVQ@mail.gmail.com>
From: Christopher Friedt <chrisfriedt@gmail.com>
Date: Thu, 23 Aug 2018 16:01:50 -0400
Message-ID: <CAF4BF-Tb74eNHuNMXNXJZAXq4UQ=mG3BOd4Dnswe+WY89q1Miw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] Fix ARM v7m gen_intermediate_code()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Thu., Aug. 23, 2018, 3:50 p.m. Christopher Friedt, <chrisfriedt@gmail.com>
wrote:

>
>
> On Thu., Aug. 23, 2018, 2:20 p.m. Peter Maydell, <peter.maydell@linaro.org>
> wrote:
>
>> On 23 August 2018 at 17:36, Christopher Friedt <chrisfriedt@gmail.com>
>> wrote:
>>
>> happen to have a copy on your lake, but the short answer
>> is that bit 1 must be set, exactly because this is what
>> defines whether EPSR.T is set on exception entry.
>>
>
> Doh! You're right, although I checked for that in my rom vector table. As
> it turns out, I relocated my vtable to ram and *then* zeroed bss, which
> would obviously clear the T bit.
>

Ok, not right. The vtable entries all do have the T bit set and I was
zeroing the bss first after all. All isr entries are either 0x2e9 (no-op
isr), 0x2ff (no-op fault handler), or 0 (for reserved), so the T bit is set
everywhere it needs to be.

It would seem there is an underlying issue with the T bit not getting set
upon exception invocation, and my previous patch was more of a bandaid
solution. It would be fairly straightforward to come up with a short
assembly fragment that verifiably demonstrates the problem in this case.

Let me see what I can do.

C

>
