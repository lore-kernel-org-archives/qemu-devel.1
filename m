Received: from eggs.gnu.org ([2001:4830:134:3::10]:57340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cxcz2-0003br-BW
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 13:20:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cxcyz-0000uN-7t
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 13:20:08 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:35296)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cxcyz-0000tj-1G
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 13:20:05 -0400
Received: by mail-wr0-x233.google.com with SMTP id o21so125173982wrb.2
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 10:20:03 -0700 (PDT)
References: <20170406102249.20383-1-nikunj@linux.vnet.ibm.com>
	<6029cef4-0a41-cde0-b3c9-6b6ad9bde572@kaod.org>
	<87vaqgrds2.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<a74b9ee8-1b9d-244b-8046-b116fedb55f1@kaod.org>
	<25dcb89b-35be-ea27-8719-7b446f464694@kaod.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <25dcb89b-35be-ea27-8719-7b446f464694@kaod.org>
Date: Mon, 10 Apr 2017 18:20:08 +0100
Message-ID: <87lgr8ji2f.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH RFC v1 0/3] Enable MTTCG on PPC64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net, programmingkidx@gmail.com, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com


Cédric Le Goater <clg@kaod.org> writes:

> On 04/07/2017 08:07 AM, Cédric Le Goater wrote:
>> On 04/07/2017 07:24 AM, Nikunj A Dadhania wrote:
>>> Cédric Le Goater <clg@kaod.org> writes:
>>>
>>>> Hello Nikunj,
>>>>
>>>> On 04/06/2017 12:22 PM, Nikunj A Dadhania wrote:
>>>>> The series enables Multi-Threaded TCG on PPC64
>>>>>
>>>>> Patch 01: Use atomic_cmpxchg in store conditional
>>>>>       02: Handle first write to page during atomic operation
>>>>>       03: Generate memory barriers for sync/isync and load/store conditional
>>>>>
>>>>> Patches are based on ppc-for-2.10
>>>>>
>>>>> Tested using following:
>>>>> ./ppc64-softmmu/qemu-system-ppc64 -cpu POWER8 -vga none -nographic -machine pseries,usb=off -m 2G  -smp 8,cores=8,threads=1 -accel tcg,thread=multi  f23.img
>>>>
>>>> I tried it with a Ubuntu 16.04.2 guest using stress --cpu 8. It looked
>>>> good : the CPU usage of QEMU reached 760% on the host.
>>>
>>> Cool.
>>>
>>>>> Todo:
>>>>> * Enable other machine types and PPC32.
>>>>
>>>> I am quite ignorant on the topic.
>>>> Have you looked at what it would take to emulate support of the HW
>>>> threads ?
>>>
>>> We would need to implement msgsndp (doorbell support for IPI between
>>> threads of same core)
>>
>> ok. I get it. Thanks,
>>
>>>> and the PowerNV machine ?
>>>
>>> Haven't tried it, should work. Just give a shot, let me know if you see problems.
>>
>> sure. pnv is still on 2.9, so I will rebase on 2.10, merge your
>> patches  and tell you.
>
> The system seems to be spinning in skiboot in cpu_idle/relax when
> starting the linux kernel. It finally boots, but it is rather long.
> David has merged enough to test if you want to give it a try.

Does PPC have Wait-for-irq or similar "sleeping" instructions?

We had to ensure we were not jumping out of the cpu loop and suspend
normally.

See c22edfebff29f63d793032e4fbd42a035bb73e27 for an example.

--
Alex Bennée
