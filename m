Received: from eggs.gnu.org ([2001:4830:134:3::10]:45642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1cYELA-0006a9-Qs
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:58:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1cYEL6-0005Ax-J4
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:58:00 -0500
Received: from mout.web.de ([217.72.192.78]:54985)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jan.kiszka@web.de>) id 1cYEL6-00058B-8g
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:57:56 -0500
References: <8a51513f-59d7-a361-a4ef-99679aa460fb@siemens.com>
	<874m0peu50.fsf@dusky.pond.sub.org>
	<533e0b17-4d60-a584-5680-559834013c68@web.de>
	<87inp05m8m.fsf@dusky.pond.sub.org>
	<4504afce-c62e-c54f-33a3-483f16dc4530@web.de>
	<87inoxvuya.fsf@dusky.pond.sub.org>
	<5c8e949c-66c7-a24f-c839-61b5354b5c32@web.de>
	<87mve8rb9i.fsf@dusky.pond.sub.org>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <79f50a9f-4cc9-ff57-ccfd-aede71211774@web.de>
Date: Mon, 30 Jan 2017 16:57:33 +0100
MIME-Version: 1.0
In-Reply-To: <87mve8rb9i.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Towards an ivshmem 2.0?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Jailhouse <jailhouse-dev@googlegroups.com>, qemu-devel <qemu-devel@nongnu.org>

On 2017-01-30 13:19, Markus Armbruster wrote:
>>> Can you explain why not letting the guest map the shared memory into its
>>> address space on its own just like any other piece of device memory is a
>>> requirement?
>>
>> It requires reconfiguration of the sensitive 2nd level page tables
>> during runtime of the guest. We are avoiding the neccessery checking and
>> synchronization measures so far which reduces code complexity further.
> 
> You mean the hypervisor needs to act when the guest maps BARs, and that
> gives the guest an attack vector?

Possibly, at least correctness issue will arise. We need to add TLB
flushes e.g., something that is not needed right now with the mappings
remaining static while a guest is running.

> 
> Don't you have to deal with that anyway, for other PCI devices?

Physical devices are presented to the guest with their BARs programmed
(as if the firmware did that already), and Jailhouse denies
reprogramming (only for the purpose of size discovery). Linux is fine
with that, and RTOSes ported to Jailhouse only become simpler.

Virtualized regions are trapped-and-emulate anyway, so no need for
reprogramming the mappings

Jan
