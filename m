Received: from eggs.gnu.org ([2001:4830:134:3::10]:49390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fDXgk-0001od-Jv
	for qemu-devel@nongnu.org; Tue, 01 May 2018 11:59:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fDXgg-0002Jw-Gw
	for qemu-devel@nongnu.org; Tue, 01 May 2018 11:59:34 -0400
Received: from 9.mo68.mail-out.ovh.net ([46.105.78.111]:53072)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fDXgg-0002B5-9u
	for qemu-devel@nongnu.org; Tue, 01 May 2018 11:59:30 -0400
Received: from player157.ha.ovh.net (unknown [10.109.120.58])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 7C6BAE0BAC
	for <qemu-devel@nongnu.org>; Tue,  1 May 2018 17:59:20 +0200 (CEST)
References: <20180417071722.9399-1-david@gibson.dropbear.id.au>
	<20180417071722.9399-4-david@gibson.dropbear.id.au>
	<a01bebe8-85b7-f2b4-3675-401367471204@kaod.org>
	<20180426064600.GI8800@umbus.fritz.box>
	<5f09ca4d-3c01-7e89-fa87-6340060cf579@kaod.org>
	<20180501063939.GB2520@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <4854f0a6-21f6-f0ed-f3dc-04c948f6734c@kaod.org>
Date: Tue, 1 May 2018 17:59:14 +0200
MIME-Version: 1.0
In-Reply-To: <20180501063939.GB2520@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH for-2.13 03/10] target/ppc:
 Remove unnecessary initialization of LPCR_UPRT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 05/01/2018 08:39 AM, David Gibson wrote:
> On Thu, Apr 26, 2018 at 09:20:11AM +0200, C=E9dric Le Goater wrote:
>> On 04/26/2018 08:46 AM, David Gibson wrote:
>>> On Wed, Apr 25, 2018 at 11:52:18AM +0200, C=E9dric Le Goater wrote:
>>>> On 04/17/2018 09:17 AM, David Gibson wrote:
>>>>> In cpu_ppc_set_papr() the UPRT and GTSE bits of the LPCR are initia=
lized
>>>>> based on on ppc64_radix_guest().  Which seems reasonable, except th=
at
>>>>> ppc64_radix_guest() is based on spapr->patb_entry which is only set=
 up
>>>>> in spapr_machine_reset, called much later than cpu_ppc_set_papr().
>>>>>
>>>>> So the initialization here is pointless.  The base cpu initializati=
on
>>>>> already sets a value that's good enough until the guest uses an hca=
ll to
>>>>> configure it's preferred MMU mode.
>>>>>
>>>>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>>>>> ---
>>>>>  target/ppc/translate_init.c | 16 ----------------
>>>>>  1 file changed, 16 deletions(-)
>>>>>
>>>>> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_ini=
t.c
>>>>> index bb79d23b50..14f346f441 100644
>>>>> --- a/target/ppc/translate_init.c
>>>>> +++ b/target/ppc/translate_init.c
>>>>> @@ -8897,22 +8897,6 @@ void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVi=
rtualHypervisor *vhyp)
>>>>>      lpcr->default_value &=3D ~LPCR_RMLS;
>>>>>      lpcr->default_value |=3D 1ull << LPCR_RMLS_SHIFT;
>>>>> =20
>>>>> -    if (env->mmu_model =3D=3D POWERPC_MMU_3_00) {
>>>>> -        /* By default we choose legacy mode and switch to new hash=
 or radix
>>>>> -         * when a register process table hcall is made. So disable=
 process
>>>>> -         * tables and guest translation shootdown by default
>>>>> -         *
>>>>> -         * Hot-plugged CPUs inherit from the guest radix setting u=
nder
>>>>> -         * KVM but not under TCG. Update the default LPCR to keep =
new
>>>>> -         * CPUs in sync when radix is enabled.
>>>>> -         */
>>>>
>>>>
>>>> This is breaking CPU hotplug under TCG. Should we reintroduce the sa=
me=20
>>>> settings in spapr_cpu_reset() now ?
>>>
>>> Sod.  Yeah, this code is important for the hotplug case.
>>>
>>> But, no, I don't think it should go into reset, I think it should go
>>> into the rtas start-cpu path; it only makes sense for secondary CPUs.
>>
>> yes. I will send a fix.
>=20
> Not sure if this is still on your radar, but if it is, don't bother.
> I've already made a fix (along with various others) and will be
> posting soonish.

As you reverted the changes in the ppc-2.13 branch, I postponed the
changes. Go ahead.=20

Thanks,

C.=20
