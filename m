Received: from eggs.gnu.org ([2001:4830:134:3::10]:37579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1ebXql-0004kE-Qa
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 15:28:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1ebXqk-0000x3-Ks
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 15:28:51 -0500
Received: from mail-it0-x229.google.com ([2607:f8b0:4001:c0b::229]:37813)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
	id 1ebXqk-0000wN-G7
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 15:28:50 -0500
Received: by mail-it0-x229.google.com with SMTP id q8so6415029itb.2
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 12:28:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <176e66bb-7990-20da-a82f-fbabd9b4ed88@redhat.com>
References: <CAFEAcA8F4iO91c8OGtDbHQ_hqzY+9ka41PW4q+ES9sYGRUha0g@mail.gmail.com>
	<176e66bb-7990-20da-a82f-fbabd9b4ed88@redhat.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 16 Jan 2018 20:28:49 +0000
Message-ID: <CAKv+Gu__twgv27OxV=ORHywzeotk3+TNYo_-=bSjdFokfmXyGw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] QEMU virt board: extending various limits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrew Jones <drjones@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Wei Huang <wei@redhat.com>, "Leif Lindholm (Linaro address)" <leif.lindholm@linaro.org>

On 16 January 2018 at 20:18, Laszlo Ersek <lersek@redhat.com> wrote:
> (adding Ard, Igor, Wei, Leif)
>
> On 01/16/18 16:07, Peter Maydell wrote:
>> We've had discussions before about the various limits in the virt
>> board imposed by its current address space layout:
>>  * number of CPUs limited to 123 (not enough space for more redistributors)
>>  * number of PCIe devices limited by size of ECAM space
>>  * max memory size limits
>>  * (anything else?)
>>
>> If we want to try to fix these this release cycle now would be a good
>> point to figure out our approach so that we have plenty of time to do
>> it in.
>>
>> (Relatedly, I notice patches on list for kvm that allow userspace to
>> set the guest physical address size, which may affect how we want
>> to do this.)
>>
>> I'm not going to have time to look at this but am happy to provide
>> my opinions on whatever proposals other people would like to suggest.
>>
>> Probably the first thing to do is figure out whether we can
>> raise these limits without having to have a flag day (ie just
>> with changing the device tree we provide the guest), or if we
>> really have a hard compat break here. We should also try to
>> fix all these things at once rather than potentially breaking
>> guests several times...
>
> I've quite lost the context on this since we last talked about it. :) My
> request would be that Drew and Igor please (re)state their preferences,
> and Ard and myself should put "firmware price tags" on those ideas.
>
> As far as I remember, the sticking point from last time was whether
> guest UEFI remains permitted to rely on the RAM base being fixed at 1GB
> (i.e. if UEFI is at liberty to ignore x0 on entry). This decision
> provides a framework for all further area movements, and represents a
> large difference in firmware difficulty.
>
> (Personally I'd be ready to *accept* a consensus that UEFI should cope
> with a dynamic x0 on entry -- I'm neither proposing nor arguing against
> the notion. The large additional complexity in the firmware should be
> clear up-front however -- it'll take more time, more bugs, more human
> resources. My last writeup is at
> <http://mid.mail-archive.com/4cce2b8b-a411-bd5d-a06f-b0b80a5fb2f1@redhat.com>,
> although I think Ard has modified some of the code since, so parts of
> that text are no longer up to date.)
>

The 'contract' was 1 MB at 0x40000000 but UEFI never used more than
512 KB of that without checking the DT. With only very minor changes,
we could repurpose this range as 'non-secure SRAM', use it as
temporary PEI memory and use whatever the DT describes for DRAM, PCIe
etc.

For the firmware side, this would be a very natural fit with what the
code currently does, and with what many x86 and ARM bare metal
platforms do as well. Of course, I am clueless when it comes to the
QEMU side of these things, so perhaps this is a terrible idea.
