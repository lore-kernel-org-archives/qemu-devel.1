Received: from eggs.gnu.org ([2001:4830:134:3::10]:57229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsUI5-0003iX-DE
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 10:39:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsUI2-0007Vo-8D
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 10:39:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51178 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fsUI2-0007VZ-2h
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 10:39:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BEFD27A7E7
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 14:39:17 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <e7a28115-7834-b76c-3cbf-9ad096e4785a@redhat.com> (Thomas Huth's
	message of "Wed, 22 Aug 2018 12:43:57 +0200")
References: <20180822095421.11765-1-quintela@redhat.com>
	<20180822095421.11765-9-quintela@redhat.com>
	<2385c734-9bec-e745-4d38-d6dbfa9d3ee0@redhat.com>
	<87va823cqd.fsf@trasno.org>
	<e7a28115-7834-b76c-3cbf-9ad096e4785a@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 22 Aug 2018 16:39:09 +0200
Message-ID: <87tvnmo48i.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 08/10] check: Move VMXNET3 test to common
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

Thomas Huth <thuth@redhat.com> wrote:
> On 2018-08-22 12:41, Juan Quintela wrote:
>> Thomas Huth <thuth@redhat.com> wrote:
>>> On 2018-08-22 11:54, Juan Quintela wrote:
>>>> We protect it with CONFIG_VMXNET3_PCI now, so no need to also put it
>>>> on i386.
>>>>
>>>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>>>> ---
>>>>  tests/Makefile.include | 4 ++--
>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>>>> index d524e1bdeb..91ffde3103 100644
>>>> --- a/tests/Makefile.include
>>>> +++ b/tests/Makefile.include
>>>> @@ -247,6 +247,8 @@ check-qtest-pci-$(CONFIG_IVSHMEM_DEVICE) +=
>>>> tests/ivshmem-test$(EXESUF)
>>>>  gcov-files-pci-$(CONFIG_IVSHMEM_DEVICE) += hw/misc/ivshmem.c
>>>>  check-qtest-pci-y += tests/megasas-test$(EXESUF)
>>>>  gcov-files-pci-y += hw/scsi/megasas.c
>>>> +check-qtest-$(CONFIG_VMXNET3_PCI) += tests/vmxnet3-test$(EXESUF)
>>>> +gcov-files-$(CONFIG_VMXNET3_PCI) += hw/net/vmxnet3.c
>>>>  
>>>>  check-qtest-i386-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
>>>>  check-qtest-i386-y += tests/fdc-test$(EXESUF)
>>>> @@ -270,8 +272,6 @@ gcov-files-i386-$(CONFIG_WDT_IB700) +=
>>>> hw/watchdog/watchdog.c hw/watchdog/wdt_ib
>>>>  check-qtest-i386-y += tests/tco-test$(EXESUF)
>>>>  check-qtest-i386-y += $(check-qtest-pci-y)
>>>>  gcov-files-i386-y += $(gcov-files-pci-y)
>>>> -check-qtest-i386-$(CONFIG_VMXNET3_PCI) += tests/vmxnet3-test$(EXESUF)
>>>> -gcov-files-i386-$(CONFIG_VMXNET3_PCI) += hw/net/vmxnet3.c
>>>>  gcov-files-i386-y += hw/net/net_rx_pkt.c
>>>>  gcov-files-i386-y += hw/net/net_tx_pkt.c
>>>>  check-qtest-i386-$(CONFIG_PVPANIC) += tests/pvpanic-test$(EXESUF)
>>>
>>> It shouldn't matter much ... it's a x86-only device, so we could also
>>> keep it there? Or is there an urgent reason to move it?
>> 
>> I was trying to minimize the amount that are architecture specific.  In
>> this particular case it is defined already on i386-softmmu.mak.  So, why
>> should we maintain that info in two places?
>
> Ok, fair.
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>
>> Anyways, I had to stop soon this "cleanup" because there are things like
>> boot-serial-test that don't work on all the boards that define
>> CONFIG_SERIAL :-(
>
> Which ones are missing? Feel free to contribute small assembler programs
> there to increase the test coverage ;-)

moxie, ti and another two or so.  I will try to take another round of
serial "cleanups" next week and will come with a better answer.

Later, Juan.
