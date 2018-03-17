Received: from eggs.gnu.org ([2001:4830:134:3::10]:47520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ex9uj-0003Cx-K1
	for qemu-devel@nongnu.org; Sat, 17 Mar 2018 07:22:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ex9ue-0003bn-MS
	for qemu-devel@nongnu.org; Sat, 17 Mar 2018 07:22:17 -0400
Date: Sat, 17 Mar 2018 12:22:02 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <CAFEAcA95=S4A6EhP1ZZROxCUT4iQzC6g8xiHixm9yRtOkbkM1Q@mail.gmail.com>
Message-ID: <alpine.BSF.2.21.1803171212100.8314@zero.eik.bme.hu>
References: <20180315041903.10046-1-david@gibson.dropbear.id.au>
	<CAFEAcA9Uv_EyW6E=6cp+9QDCa4w13WxHQ5pCGp6E-3iOhq-mWg@mail.gmail.com>
	<20180317040215.GE4525@umbus.fritz.box>
	<CAFEAcA95=S4A6EhP1ZZROxCUT4iQzC6g8xiHixm9yRtOkbkM1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [Qemu-ppc] [PULL 0/9] ppc-for-2.12 queue 20180315
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, surajjs@au1.ibm.com

On Sat, 17 Mar 2018, Peter Maydell wrote:
> On 17 March 2018 at 04:02, David Gibson <david@gibson.dropbear.id.au> wrote:
>> On Fri, Mar 16, 2018 at 05:25:04PM +0000, Peter Maydell wrote:
>>> Hi -- this looks like it provokes new runtime error warnings from the
>>> clang sanitizer:
>>
>> Hrm.  What options do you need to trip these warnings?  Just using
>> --cc=clang doesn't give them to me, and using --enable-sanitizers
>> gives my piles of unrelated warnings.
>
> https://wiki.qemu.org/Testing#clang_UBSan documents the necessary
> cflags.
>
>>
>>>
>>> TEST: tests/boot-serial-test... (pid=926)
>>>   /ppc/boot-serial/ppce500:                                            OK
>>>   /ppc/boot-serial/prep:                                               OK
>>>   /ppc/boot-serial/40p:                                                OK
>>>   /ppc/boot-serial/g3beige:                                            OK
>>>   /ppc/boot-serial/mac99:                                              OK
>>>   /ppc/boot-serial/sam460ex:
>>> /home/petmay01/linaro/qemu-for-merges/target/ppc/translate.c:2979:15:
>>> runtime error: load of value 142, which is not a valid value for type
>>> 'bool'
>>> OK
>>>
>>> TEST: tests/boot-serial-test... (pid=1016)
>>>   /ppc64/boot-serial/ppce500:                                          OK
>>>   /ppc64/boot-serial/prep:                                             OK
>>>   /ppc64/boot-serial/40p:                                              OK
>>>   /ppc64/boot-serial/mac99:                                            OK
>>>   /ppc64/boot-serial/pseries:                                          OK
>>>   /ppc64/boot-serial/powernv:                                          OK
>>>   /ppc64/boot-serial/sam460ex:
>>> /home/petmay01/linaro/qemu-for-merges/target/ppc/translate.c:2979:15:
>>> runtime error: load of value 85, which is not a valid value for type
>>> 'bool'
>>> OK
>>>
>>> Looks like you're not initializing ctx->lazy_tlb_flush for all configs:
>>>     if (env->mmu_model == POWERPC_MMU_32B ||
>>>         env->mmu_model == POWERPC_MMU_601 ||
>>>         (env->mmu_model & POWERPC_MMU_64B))
>>>             ctx->lazy_tlb_flush = true;
>>>
>>> should perhaps be
>>>     ctx->lazy_tlb_flush =
>>>         env->mmu_model == POWERPC_MMU_32B ||
>>>         env->mmu_model == POWERPC_MMU_601 ||
>>>         (env->mmu_model & POWERPC_MMU_64B);
>>>
>>> ?
>>
>> Uh.. maybe.. except I don't see anything in the series that would be
>> likely to change that behaviour.
>
> I imagine it's "tests/boot-serial: Test the sam460ex board" --
> this code was previously not being exercised in 'make check',
> and now it is.

I'm not sure what could cause this in case of sam460ex. It has PPC440 
which has POWERPC_MMU_BOOKE but the ppce500 should also have that and a 
similar u-boot and that does not produce this error. Is there maybe some 
initialisation of some structure I've missed somewhere? But these 
DisasContext structs seem to be internal to TCG so I'm not sure what could 
be missing outside of TCG to avoid this. Could be that the different 
u-boot version does something that triggers this while the one for ppce500 
does not execute code that causes this warning during the test?

Regards,
BALATON Zoltan
