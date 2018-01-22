Received: from eggs.gnu.org ([2001:4830:134:3::10]:52518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1edeui-0004hU-AZ
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 11:25:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1edeue-0004VG-8v
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 11:25:40 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:42582)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1edeud-0004Sy-Oj
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 11:25:36 -0500
From: Alexey Perevalov <a.perevalov@samsung.com>
Message-id: <016e04bd-3ee3-dffc-943f-394c8583c886@samsung.com>
Date: Mon, 22 Jan 2018 19:25:27 +0300
MIME-version: 1.0
In-reply-to: <CAFEAcA-4HcQwWk2rEUuUc2PyGP8hnopbrL2zVOLiCayP3S7FrQ@mail.gmail.com>
Content-type: text/plain; charset="utf-8"; format="flowed"
Content-transfer-encoding: 7bit
Content-language: en-GB
References: <20180115115309.23982-1-quintela@redhat.com>
	<CAFEAcA-SxiJyKa84UwG8CESpkTXEM9AG5HqEgpPrzSFwrTPzYg@mail.gmail.com>
	<CGME20180119162746epcas1p2143cef3a97b076ce3fbc0b79d7d347b7@epcas1p2.samsung.com>
	<d746e2e8-3690-c27e-f816-9892b36d8a1c@amsat.org>
	<f399b096-6e75-c04f-bb02-80e327de45c4@samsung.com>
	<CAFEAcA-S5yB-3itnRJ41JriJYbsu2EKs9qjPjMC0488vsCZrRw@mail.gmail.com>
	<87h8rg2jdh.fsf@secure.laptop>
	<CAFEAcA-4HcQwWk2rEUuUc2PyGP8hnopbrL2zVOLiCayP3S7FrQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/27] Migration pull
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Juan Quintela <quintela@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Laurent Vivier <lvivier@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 01/22/2018 01:03 PM, Peter Maydell wrote:
> On 20 January 2018 at 23:36, Juan Quintela <quintela@redhat.com> wrote:
>> Peter Maydell <peter.maydell@linaro.org> wrote:
>>> On 19 January 2018 at 16:43, Alexey Perevalov <a.perevalov@samsung.com> wrote:
>>>> As I remember, I tested build in QEMU's docker build system,
>>>> but now I checked it on i386 Ubuntu, and yes linker says about unresolved
>>>> atomic symbols. Next week, I'll have a time to investigate it deeper.
>>> This sounds like exactly the problem I pointed out in a previous
>>> round of this patchset :-(
>>>
>>> https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg02103.html
>>>
>>> Ignoring comments and sending patches anyway makes me grumpy,
>>> especially when the result is exactly "fails obscurely on
>>> some architectures only"...
>> It compiles for me.  F25 i686 gcc.  I did change it to use intptr_t
>> instead of uint64_t.  So, I don't know what is going on here.
> Did you change it to not use the 'nocheck' versions of the macros?
> The code in master uses 'nocheck' which has exactly the effect
> of masking this bug on i686...
>
>> So, I can agree that we have to fix anything that don't work, but I
>> can't agree that I didn't care about comments, at least I tried to fix
>> the problems you pointed me to.
> I said the could should probably not use the nocheck macros. The
> code in master is still using those macros, wrongly, which is why
> this problem shows only on ppc32 and not all 32-bit hosts.
clang doesn't have atomic_*_8 function set on 32 platform,
but gcc has.

I also checked on ubuntu server 12.04, looks like no "ATOMIC_RELAXED" in
both gcc and clang toolchain, so

following code
atomic_xchg__nocheck(&a64, b64);
is expanding to
(({ asm volatile("" ::: "memory"); (void)0; }), 
__sync_lock_test_and_set(&a64, b64));
and we don't have problem neither in gcc nor in clang. Maybe it's not so 
effective
from performance point of view.

I like glib approach.
#if defined(__ATOMIC_SEQ_CST) && !defined(__clang__)
there __ATOMIC_SEQ_CST instead of __ATOMIC_RELAXED in QEMU, but it 
doesn't matter.
But clang has atomic_*_[1, 2, 4] functions, so it's not reasonable to 
avoid using clang
for all cases.

I want to keep 64bit atomic operations in migration.
Maybe add into atomic.h additional check for clang and 64bit pointer and 
in this case use
(({ asm volatile("" ::: "memory"); (void)0; }), 
__sync_lock_test_and_set(&a64, b64));
?


>
> thanks
> -- PMM
>
>
>

-- 
Best regards,
Alexey Perevalov
