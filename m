Received: from eggs.gnu.org ([2001:4830:134:3::10]:57583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fAxGg-0001oP-EK
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 08:41:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fAxGc-0008C6-IT
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 08:41:58 -0400
Received: from 7.mo2.mail-out.ovh.net ([188.165.48.182]:52162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fAxGc-0008B7-C9
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 08:41:54 -0400
Received: from player774.ha.ovh.net (unknown [10.109.105.44])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id B262B12EE75
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 14:41:52 +0200 (CEST)
References: <20180424113045.25687-1-clg@kaod.org>
	<20180424113045.25687-5-clg@kaod.org>
	<f949a056-23c2-fcfa-d9e0-6a2cb1142051@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <f33e541e-b026-b933-7926-10a29b300a20@kaod.org>
Date: Tue, 24 Apr 2018 14:41:47 +0200
MIME-Version: 1.0
In-Reply-To: <f949a056-23c2-fcfa-d9e0-6a2cb1142051@kaod.org>
Content-Type: text/plain; charset=utf-8
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
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

On 04/24/2018 02:03 PM, C=C3=A9dric Le Goater wrote:
>> +hwaddr ppc_hash64_hpt_reg(PowerPCCPU *cpu)
>> +{
>> +    CPUPPCState *env =3D &cpu->env;
>> +
>> +    /* We should not reach this routine on sPAPR machines */
>> +    assert(!cpu->vhyp);
>> +
>> +    /* PowerNV machine */
>> +    if (msr_hv) {
>> +        if (env->mmu_model & POWERPC_MMU_3_00) {
>> +            return ppc64_v3_get_patbe0(cpu);
>> +        } else {
>> +            return cpu->env.spr[SPR_SDR1];
>> +        }
>> +    } else {
>> +        error_report("PowerNV guest support Unimplemented");
>> +        exit(1);
>=20
> I just noticed that this breaks 970 CPUs ...

How about ?

    if (env->mmu_model < POWERPC_MMU_2_07) {
        return cpu->env.spr[SPR_SDR1];
    }

    /* P8/P9 PowerNV machine */
    if (msr_hv) {
        if (env->mmu_model =3D=3D POWERPC_MMU_3_00) {
            return ppc64_v3_get_patbe0(cpu);
        } else {
            return cpu->env.spr[SPR_SDR1];
        }
    } else {
        error_report("PowerNV guest support Unimplemented");
        exit(1);
    }

and I have to fix all the :

	env->mmu_model & POWERPC_MMU_3_00

by :

	env->mmu_model =3D=3D POWERPC_MMU_3_00

I tripped over with the recent changes
=20
C.
