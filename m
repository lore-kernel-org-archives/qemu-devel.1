Received: from eggs.gnu.org ([2001:4830:134:3::10]:39804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cxuuc-0005uG-Ps
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:28:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cxuuZ-0004VY-Nh
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:28:46 -0400
Received: from 10.mo173.mail-out.ovh.net ([46.105.74.148]:47264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cxuuZ-0004Tf-Hb
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:28:43 -0400
Received: from player778.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id E266031457
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 14:28:35 +0200 (CEST)
References: <20170406102249.20383-1-nikunj@linux.vnet.ibm.com>
	<6029cef4-0a41-cde0-b3c9-6b6ad9bde572@kaod.org>
	<87vaqgrds2.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<a74b9ee8-1b9d-244b-8046-b116fedb55f1@kaod.org>
	<25dcb89b-35be-ea27-8719-7b446f464694@kaod.org>
	<87lgr8ji2f.fsf@linaro.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <04c9f03f-7f04-ebce-15f1-988db1fb2c1d@kaod.org>
Date: Tue, 11 Apr 2017 14:28:22 +0200
MIME-Version: 1.0
In-Reply-To: <87lgr8ji2f.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH RFC v1 0/3] Enable MTTCG on PPC64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net, programmingkidx@gmail.com, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On 04/10/2017 07:20 PM, Alex Benn=C3=A9e wrote:
>=20
> C=C3=A9dric Le Goater <clg@kaod.org> writes:
>=20
>> On 04/07/2017 08:07 AM, C=C3=A9dric Le Goater wrote:
>>> On 04/07/2017 07:24 AM, Nikunj A Dadhania wrote:
>>>> C=C3=A9dric Le Goater <clg@kaod.org> writes:
>>>>
>>>>> Hello Nikunj,
>>>>>
>>>>> On 04/06/2017 12:22 PM, Nikunj A Dadhania wrote:
>>>>>> The series enables Multi-Threaded TCG on PPC64
>>>>>>
>>>>>> Patch 01: Use atomic_cmpxchg in store conditional
>>>>>>       02: Handle first write to page during atomic operation
>>>>>>       03: Generate memory barriers for sync/isync and load/store c=
onditional
>>>>>>
>>>>>> Patches are based on ppc-for-2.10
>>>>>>
>>>>>> Tested using following:
>>>>>> ./ppc64-softmmu/qemu-system-ppc64 -cpu POWER8 -vga none -nographic=
 -machine pseries,usb=3Doff -m 2G  -smp 8,cores=3D8,threads=3D1 -accel tc=
g,thread=3Dmulti  f23.img
>>>>>
>>>>> I tried it with a Ubuntu 16.04.2 guest using stress --cpu 8. It loo=
ked
>>>>> good : the CPU usage of QEMU reached 760% on the host.
>>>>
>>>> Cool.
>>>>
>>>>>> Todo:
>>>>>> * Enable other machine types and PPC32.
>>>>>
>>>>> I am quite ignorant on the topic.
>>>>> Have you looked at what it would take to emulate support of the HW
>>>>> threads ?
>>>>
>>>> We would need to implement msgsndp (doorbell support for IPI between
>>>> threads of same core)
>>>
>>> ok. I get it. Thanks,
>>>
>>>>> and the PowerNV machine ?
>>>>
>>>> Haven't tried it, should work. Just give a shot, let me know if you =
see problems.
>>>
>>> sure. pnv is still on 2.9, so I will rebase on 2.10, merge your
>>> patches  and tell you.
>>
>> The system seems to be spinning in skiboot in cpu_idle/relax when
>> starting the linux kernel. It finally boots, but it is rather long.
>> David has merged enough to test if you want to give it a try.
>=20
> Does PPC have Wait-for-irq or similar "sleeping" instructions?
>=20
> We had to ensure we were not jumping out of the cpu loop and suspend
> normally.

I really don't know.=20

Ben, now that we have mttcg activated by default on ppc, it takes=20
a while for the linux kernel to do the early setup. I think we are
in the code section where we spin loop the secondaries. Most of the
time is spent in skiboot under cpu_idle/relax.

Any idea where that could come from ?=20

> See c22edfebff29f63d793032e4fbd42a035bb73e27 for an example.

Thanks for the hint.

C.=20
