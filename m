Received: from eggs.gnu.org ([2001:4830:134:3::10]:38724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fE9Ey-0004nc-6X
	for qemu-devel@nongnu.org; Thu, 03 May 2018 04:05:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fE9Es-0003sB-Eg
	for qemu-devel@nongnu.org; Thu, 03 May 2018 04:05:24 -0400
Received: from 4.mo179.mail-out.ovh.net ([46.105.36.149]:54456)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fE9Es-0003rW-7g
	for qemu-devel@nongnu.org; Thu, 03 May 2018 04:05:18 -0400
Received: from player714.ha.ovh.net (unknown [10.109.120.125])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 4BA68BC850
	for <qemu-devel@nongnu.org>; Thu,  3 May 2018 10:05:16 +0200 (CEST)
References: <20180424113045.25687-1-clg@kaod.org>
	<20180424113045.25687-5-clg@kaod.org>
	<f949a056-23c2-fcfa-d9e0-6a2cb1142051@kaod.org>
	<f33e541e-b026-b933-7926-10a29b300a20@kaod.org>
	<20180503005824.GD13229@umbus.fritz.box>
	<6e331f5e-47f2-6525-7807-a5c262e13a4c@kaod.org>
	<20180503063603.GX13229@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <3aec8048-472f-2926-a07e-0e854dba48d6@kaod.org>
Date: Thu, 3 May 2018 10:05:11 +0200
MIME-Version: 1.0
In-Reply-To: <20180503063603.GX13229@umbus.fritz.box>
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

On 05/03/2018 08:36 AM, David Gibson wrote:
> On Thu, May 03, 2018 at 07:52:32AM +0200, C=E9dric Le Goater wrote:
>> On 05/03/2018 02:58 AM, David Gibson wrote:
>>> On Tue, Apr 24, 2018 at 02:41:47PM +0200, C=E9dric Le Goater wrote:
>>>> On 04/24/2018 02:03 PM, C=E9dric Le Goater wrote:
>>>>>> +hwaddr ppc_hash64_hpt_reg(PowerPCCPU *cpu)
>>>>>> +{
>>>>>> +    CPUPPCState *env =3D &cpu->env;
>>>>>> +
>>>>>> +    /* We should not reach this routine on sPAPR machines */
>>>>>> +    assert(!cpu->vhyp);
>>>>>> +
>>>>>> +    /* PowerNV machine */
>>>>>> +    if (msr_hv) {
>>>>>> +        if (env->mmu_model & POWERPC_MMU_3_00) {
>>>>>> +            return ppc64_v3_get_patbe0(cpu);
>>>>>> +        } else {
>>>>>> +            return cpu->env.spr[SPR_SDR1];
>>>>>> +        }
>>>>>> +    } else {
>>>>>> +        error_report("PowerNV guest support Unimplemented");
>>>>>> +        exit(1);
>>>>>
>>>>> I just noticed that this breaks 970 CPUs ...
>>>>
>>>> How about ?
>>>
>>> Hmm.. I'm not actually seeing why it breaks 970.
>>
>> it does not have MSR_SHV bit.
>=20
> It does, actually.  At least, as long as it's not strapped into "Apple
> mode".

ah. this is why the tests are failing then :=20

tests/boot-serial-test.c:    { "ppc64", "mac99", "", "PowerPC,970FX" },

C.

>=20
>>> I really want to ditch 970 support, but we have to go through the
>>> deprecation process first.
>>
>> Is it causing a lot of maintenance issues ?
>=20
> Enough.  The explicit RMA allocation stuff is a particular pain.
>=20
