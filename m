Received: from eggs.gnu.org ([2001:4830:134:3::10]:54399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1ddGiZ-0000We-DS
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 10:03:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1ddGiU-0003Gd-Ne
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 10:03:15 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:6741)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1ddGiU-0003Df-Ht
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 10:03:10 -0400
References: <1501682311-16370-1-git-send-email-yongbok.kim@imgtec.com>
	<0f0aa868-90a9-12a4-36ea-63c569a8b869@amsat.org>
From: Yongbok Kim <yongbok.kim@imgtec.com>
Message-ID: <07eb4179-b7a2-2244-1ac3-a67680a945b3@imgtec.com>
Date: Thu, 3 Aug 2017 15:03:06 +0100
MIME-Version: 1.0
In-Reply-To: <0f0aa868-90a9-12a4-36ea-63c569a8b869@amsat.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] target-mips: apply CP0.PageMask before
 writing into TLB entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org



On 02/08/2017 19:56, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Leon,
>=20
> On 08/02/2017 10:58 AM, Yongbok Kim wrote:
>> From: Leon Alrae <leon.alrae@imgtec.com>
>>
>> PFN0 and PFN1 have to be masked out with PageMask_Mask.
>>
>> Signed-off-by: Leon Alrae <leon.alrae@imgtec.com>
>> Reviewed-by: Yongbok Kim <yongbok.kim@imgtec.com>
>> [Yongbok Kim:
>>    Added commit message]
>> Signed-off-by: Yongbok Kim <yongbok.kim@imgtec.com>
>> ---
>>   target/mips/op_helper.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
>> index 526f8e4..320f2b0 100644
>> --- a/target/mips/op_helper.c
>> +++ b/target/mips/op_helper.c
>> @@ -2008,6 +2008,7 @@ static inline uint64_t
>> get_tlb_pfn_from_entrylo(uint64_t entrylo)
>>   static void r4k_fill_tlb(CPUMIPSState *env, int idx)
>>   {
>>       r4k_tlb_t *tlb;
>> +    uint64_t mask =3D env->CP0_PageMask >> (TARGET_PAGE_BITS + 1);
>>         /* XXX: detect conflicting TLBs and raise a MCHECK exception w=
hen
>> needed */
>>       tlb =3D &env->tlb->mmu.r4k.tlb[idx];
>> @@ -2028,13 +2029,13 @@ static void r4k_fill_tlb(CPUMIPSState *env, in=
t idx)
>>       tlb->C0 =3D (env->CP0_EntryLo0 >> 3) & 0x7;
>>       tlb->XI0 =3D (env->CP0_EntryLo0 >> CP0EnLo_XI) & 1;
>>       tlb->RI0 =3D (env->CP0_EntryLo0 >> CP0EnLo_RI) & 1;
>> -    tlb->PFN[0] =3D get_tlb_pfn_from_entrylo(env->CP0_EntryLo0) << 12=
;
>> +    tlb->PFN[0] =3D (get_tlb_pfn_from_entrylo(env->CP0_EntryLo0) & ~m=
ask)
>> << 12;
>>       tlb->V1 =3D (env->CP0_EntryLo1 & 2) !=3D 0;
>>       tlb->D1 =3D (env->CP0_EntryLo1 & 4) !=3D 0;
>>       tlb->C1 =3D (env->CP0_EntryLo1 >> 3) & 0x7;
>>       tlb->XI1 =3D (env->CP0_EntryLo1 >> CP0EnLo_XI) & 1;
>>       tlb->RI1 =3D (env->CP0_EntryLo1 >> CP0EnLo_RI) & 1;
>> -    tlb->PFN[1] =3D get_tlb_pfn_from_entrylo(env->CP0_EntryLo1) << 12=
;
>> +    tlb->PFN[1] =3D (get_tlb_pfn_from_entrylo(env->CP0_EntryLo1) & ~m=
ask)
>> << 12;
>>   }
>>     void r4k_helper_tlbinv(CPUMIPSState *env)
>>
>=20
> What about refactoring get_tlb_pfn_from_entrylo(uint64_t entrylo) ->
> r4k_get_tlb_pfn_from_entrylo(uint64_t entrylo, uint64_t pagemask) to
> directly masked pfn?
>=20
> Regards,
>=20
> Phil.

Hi Phil,

Leon left Imagination a year ago and this patch is one of his remainders.
I agree to refactor the inline function but it is paired with other inlin=
e
function get_entrylo_pfn_from_tlb(). I will send another patch for both o=
f
them but it should be after 2.10.

Regards,
Yongbok
