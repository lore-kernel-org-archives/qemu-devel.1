Received: from eggs.gnu.org ([2001:4830:134:3::10]:35278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fE7Ah-0007oz-L6
	for qemu-devel@nongnu.org; Thu, 03 May 2018 01:52:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fE7Ae-0005wr-Gm
	for qemu-devel@nongnu.org; Thu, 03 May 2018 01:52:51 -0400
Received: from 5.mo7.mail-out.ovh.net ([178.32.120.239]:59032)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fE7Ae-0005mz-9z
	for qemu-devel@nongnu.org; Thu, 03 May 2018 01:52:48 -0400
Received: from player714.ha.ovh.net (unknown [10.109.105.118])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id E35EDA4A05
	for <qemu-devel@nongnu.org>; Thu,  3 May 2018 07:52:37 +0200 (CEST)
References: <20180424113045.25687-1-clg@kaod.org>
	<20180424113045.25687-5-clg@kaod.org>
	<f949a056-23c2-fcfa-d9e0-6a2cb1142051@kaod.org>
	<f33e541e-b026-b933-7926-10a29b300a20@kaod.org>
	<20180503005824.GD13229@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <6e331f5e-47f2-6525-7807-a5c262e13a4c@kaod.org>
Date: Thu, 3 May 2018 07:52:32 +0200
MIME-Version: 1.0
In-Reply-To: <20180503005824.GD13229@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 4/5] target/ppc: add hash MMU support
 for PowerNV POWER9 machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

On 05/03/2018 02:58 AM, David Gibson wrote:
> On Tue, Apr 24, 2018 at 02:41:47PM +0200, C=E9dric Le Goater wrote:
>> On 04/24/2018 02:03 PM, C=E9dric Le Goater wrote:
>>>> +hwaddr ppc_hash64_hpt_reg(PowerPCCPU *cpu)
>>>> +{
>>>> +    CPUPPCState *env =3D &cpu->env;
>>>> +
>>>> +    /* We should not reach this routine on sPAPR machines */
>>>> +    assert(!cpu->vhyp);
>>>> +
>>>> +    /* PowerNV machine */
>>>> +    if (msr_hv) {
>>>> +        if (env->mmu_model & POWERPC_MMU_3_00) {
>>>> +            return ppc64_v3_get_patbe0(cpu);
>>>> +        } else {
>>>> +            return cpu->env.spr[SPR_SDR1];
>>>> +        }
>>>> +    } else {
>>>> +        error_report("PowerNV guest support Unimplemented");
>>>> +        exit(1);
>>>
>>> I just noticed that this breaks 970 CPUs ...
>>
>> How about ?
>=20
> Hmm.. I'm not actually seeing why it breaks 970.

it does not have MSR_SHV bit.

> I really want to ditch 970 support, but we have to go through the
> deprecation process first.

Is it causing a lot of maintenance issues ?=20

>>
>>     if (env->mmu_model < POWERPC_MMU_2_07) {
>>         return cpu->env.spr[SPR_SDR1];
>>     }
>>
>>     /* P8/P9 PowerNV machine */
>>     if (msr_hv) {
>>         if (env->mmu_model =3D=3D POWERPC_MMU_3_00) {
>>             return ppc64_v3_get_patbe0(cpu);
>>         } else {
>>             return cpu->env.spr[SPR_SDR1];
>>         }
>>     } else {
>>         error_report("PowerNV guest support Unimplemented");
>>         exit(1);
>>     }
>>
>> and I have to fix all the :
>>
>> 	env->mmu_model & POWERPC_MMU_3_00
>>
>> by :
>>
>> 	env->mmu_model =3D=3D POWERPC_MMU_3_00
>>
>> I tripped over with the recent changes
>=20
> Right.. eventually I actually want this to be something more like
> 	if (cpu->radix64_opts)
> but I'm not sure on the details yet.

OK.

C.
