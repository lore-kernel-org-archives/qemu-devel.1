Received: from eggs.gnu.org ([2001:4830:134:3::10]:56886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fpZQS-0003PO-BM
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 09:32:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fpZQP-0003ZP-3R
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 09:31:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41800 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fpZQO-0003Z7-Tg
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 09:31:53 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <CAFEAcA-OY_4v3apC4xcB7HQwN=BGqdxuQenhnPntOXqybUx5hA@mail.gmail.com>
	(Peter Maydell's message of "Tue, 14 Aug 2018 13:06:50 +0100")
References: <20180808114830.7169-1-quintela@redhat.com>
	<20180808114830.7169-3-quintela@redhat.com>
	<6c9bcc5b-21f0-60a8-bb8d-56861c2d4bd9@redhat.com>
	<87ftzhw50t.fsf@trasno.org>
	<1169fde5-2c97-bf04-d3eb-8b43d49b37f6@redhat.com>
	<CAFEAcA-OY_4v3apC4xcB7HQwN=BGqdxuQenhnPntOXqybUx5hA@mail.gmail.com>
Reply-To: quintela@redhat.com
Date: Tue, 14 Aug 2018 15:31:39 +0200
Message-ID: <87bma5vzus.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 02/22] config: CONFIG_SERIAL* is already
 in pci.mak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Peter Maydell <peter.maydell@linaro.org> wrote:
> On 14 August 2018 at 12:52, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> On 14/08/2018 13:40, Juan Quintela wrote:
>>>> CONFIG_SERIAL is a dependency of both CONFIG_SERIAL and
>>>> CONFIG_SERIAL_PCI.
>>>
>>> I guess you here mean CONFIG_SERIAL_ISA or CONFIG_SERIAL_PCI.  That is
>>> not enough.  CONFIG_SERIAL really means CONFIG_SERIAL_COMMON, and things
>>> like riscv* require it
>>
>> Right, I would put
>>
>>    CONFIG_SERIAL=y
>>    CONFIG_SERIAL_ISA=y
>>
>> in superio.mak and
>>
>>    CONFIG_SERIAL=y
>>    CONFIG_SERIAL_PCI=y
>>
>> in pci.mak.
>
> What about the boards that use the serial.c code but do not
> have PCI, ISA or a superio chip? That is, all the boards/devices
> that call serial_mm_init() directly to create a memory-mapped
> 16550.

That is what I mean that changing CONFIG_SERIAL to
$(call lor,$(CONFIG_SERIAL_ISA), $(CONFIG_SERIAL_PCI))

is not enough.


> (If anybody feels like trying to do a complicated refactoring,
> serial_mm_init() is a pretty ugly legacy API around some
> non-QOMified core 16550 code...)

It is really, really interesting, we have:

- serial_init()
  used is sh4, mips and imx serial

- serial_mm_init()
  loads of places

- serial_hds_isa_init()
  sparc64, ppc, other mips, and pc

And now you can start getting creative with qom.

O:-)

Later, Juan.
