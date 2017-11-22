Received: from eggs.gnu.org ([2001:4830:134:3::10]:59623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eHaBL-0003Za-8W
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 13:55:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eHaBI-00024i-Ki
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 13:55:35 -0500
Received: from 10.mo179.mail-out.ovh.net ([46.105.79.46]:35765)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eHaBI-0001zR-Ec
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 13:55:32 -0500
Received: from player168.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 192647EF40
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 19:55:20 +0100 (CET)
References: <20171120100347.8601-1-clg@kaod.org>
	<20171120100347.8601-2-clg@kaod.org>
	<20171122023334.GC2380@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <33f46311-f94a-d0d0-82d7-f26a1d5e1526@kaod.org>
Date: Wed, 22 Nov 2017 19:55:14 +0100
MIME-Version: 1.0
In-Reply-To: <20171122023334.GC2380@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12 v3 1/3] spapr/rtas: disable the
 decrementer interrupt when a CPU is unplugged
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On 11/22/2017 03:33 AM, David Gibson wrote:
> On Mon, Nov 20, 2017 at 11:03:45AM +0100, C=E9dric Le Goater wrote:
>> When a CPU is stopped with the 'stop-self' RTAS call, its state
>> 'halted' is switched to 1 and, in this case, the MSR is not taken into
>> account anymore in the cpu_has_work() routine. Only the pending
>> hardware interrupts are checked with their LPCR:PECE* enablement bit.
>>
>> If the DECR timer fires after 'stop-self' is called and before the CPU
>> 'stop' state is reached, the nearly-dead CPU will have some work to do
>> and the guest will crash. This case happens very frequently with the
>> not yet upstream P9 XIVE exploitation mode. In XICS mode, the DECR is
>> occasionally fired but after 'stop' state, so no work is to be done
>> and the guest survives.
>>
>> I suspect there is a race between the QEMU mainloop triggering the
>> timers and the TCG CPU thread but I could not quite identify the root
>> cause. To be safe, let's disable in the LPCR all the exceptions which
>> can cause an exit while the CPU is in power-saving mode and reenable
>> them when the CPU is started.
>>
>> For this purpose, we introduce a little helper routine to calculate
>> the PECE bits for a processor variant. We could also use the mask
>> value LPCR_PECE_L_MASK for the P8 and P9 processors. bit 47 and 48 are
>> reserved on P7 but it is still compatible.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> I'm not thrilled about addressing this without 100% knowing what's
> going on,=20

me either :/ I have spent hours, days, on QEMU logs trying to catch=20
a possible race in the state machine of the CPUs and didn't find it.
I need a better understanding of the internals.=20

> but this seems like a sensible change in any case, so I'm ok
> with applying something like this.
>
> A detail however..
>=20
> [snip]
>>  #if !defined(CONFIG_USER_ONLY)
>> +
>> +target_ulong cpu_ppc_papr_pece_bits(CPUPPCState *env)
>> +{
>> +    switch (env->mmu_model) {
>> +    case POWERPC_MMU_3_00:
>> +        return LPCR_PDEE | LPCR_HDEE | LPCR_EEE | LPCR_DEE | LPCR_OEE=
;
>> +    default:
>> +        /* P7 and P8 has slightly different PECE bits, mostly because=
 P8 adds
>> +         * bit 47 and 48 which are reserved on P7. Here we set them a=
ll, which
>> +         * will work as expected for both implementations
>> +         */
>> +        return LPCR_P8_PECE0 | LPCR_P8_PECE1 | LPCR_P8_PECE2 | LPCR_P=
8_PECE3 |
>> +            LPCR_P8_PECE4;
>> +    }
>> +}
>=20
> ..since we're working in this area, might as well clean up this
> inappropriate use of mmu_model.  Two options which I'd be ok with:
>=20
> 1) Add a pece_bits field to the PowerPCCPUClass, correctly initialized
> for the various processors.
>=20
> 2) A similar helper but using ppc_check_compat() to check the arch
> level, instead of using env->mmu_model.
>=20

OK.=20

Thanks,

C.
