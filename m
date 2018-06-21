Received: from eggs.gnu.org ([2001:4830:134:3::10]:57454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fVz3H-0007Fv-HR
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 08:51:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fVz3D-0004no-Km
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 08:51:03 -0400
Received: from 8.mo177.mail-out.ovh.net ([46.105.61.98]:42226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fVz3D-0004hK-BV
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 08:50:59 -0400
Received: from player716.ha.ovh.net (unknown [10.109.108.80])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 7B1A0B736F
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 14:50:42 +0200 (CEST)
References: <20180618063606.2513-1-david@gibson.dropbear.id.au>
	<20180618063606.2513-9-david@gibson.dropbear.id.au>
	<f829daa0-c870-f835-2195-df795c0e47b9@kaod.org>
	<20180621115247.GA2009@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <471b50ee-8f18-9fcc-10c7-8f5bca8c8cd3@kaod.org>
Date: Thu, 21 Jun 2018 14:50:32 +0200
MIME-Version: 1.0
In-Reply-To: <20180621115247.GA2009@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 8/9] spapr: Limit available pagesizes to
 provide a consistent guest environment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: groug@kaod.org, abologna@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, aik@ozlabs.ru

On 06/21/2018 01:52 PM, David Gibson wrote:
> On Thu, Jun 21, 2018 at 09:01:27AM +0200, C=E9dric Le Goater wrote:
>> On 06/18/2018 08:36 AM, David Gibson wrote:
>>> KVM HV has some limitations (deriving from the hardware) that mean no=
t all
>>> host-cpu supported pagesizes may be usable in the guest.  At present =
this
>>> means that KVM guests and TCG guests may see different available page=
 sizes
>>> even if they notionally have the same vcpu model.  This is confusing =
and
>>> also prevents migration between TCG and KVM.
>>>
>>> This patch makes the environment consistent by always allowing the sa=
me set
>>> of pagesizes.  Since we can't remove the KVM limitations, we do this =
by
>>> always applying the same limitations it has, even to TCG guests.
>>>
>>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>>>
>>> ---
>>>  hw/ppc/spapr_caps.c | 33 +++++++++++++++++++++++++++++++++
>>>  1 file changed, 33 insertions(+)
>>>
>>> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
>>> index 9fc739b3f5..0584c7c6ab 100644
>>> --- a/hw/ppc/spapr_caps.c
>>> +++ b/hw/ppc/spapr_caps.c
>>> @@ -334,6 +334,38 @@ static void cap_hpt_maxpagesize_apply(sPAPRMachi=
neState *spapr,
>>>      spapr_check_pagesize(spapr, qemu_getrampagesize(), errp);
>>>  }
>>> =20
>>> +static bool spapr_pagesize_cb(void *opaque, uint32_t seg_pshift, uin=
t32_t pshift)
>>> +{
>>> +    unsigned maxshift =3D *((unsigned *)opaque);
>>> +
>>> +    assert(pshift >=3D seg_pshift);
>>
>> you could check that elsewhere.
>=20
> Um.. I'm not sure what you're getting at.

you could put the assert in ppc_hash64_filter_pagesizes(), that is where
the parameters are coming from.

>>> +    /* Don't allow the guest to use pages bigger than the configured
>>> +     * maximum size */
>>> +    if (pshift > maxshift) {
>>> +        return false;
>>> +    }
>>> +
>>> +    /* For whatever reason, KVM doesn't allow multiple pagesizes
>>> +     * within a segment, *except* for the case of 16M pages in a 4k =
or
>>> +     * 64k segment.  Always exclude other cases, so that TCG and KVM
>>> +     * guests see a consistent environment */
>>> +    if ((pshift !=3D seg_pshift) && (pshift !=3D 24)) {
>>> +        return false;
>>> +    }
>=20
> Note the stanza above, I'll refer to it below.

ok.

>=20
>>> +
>>> +    return true;
>>> +}
>>
>> So, do we really need ppc_hash64_filter_pagesizes() to have a callback=
 ?=20
>=20
> I agree that it seems overly involved, but it was the best way I could
> see to logically separate the TCG / softmmu specific logic from the
> spapr specific logic.

ok. I agree then.

Reviewed-by: C=E9dric Le Goater <clg@kaod.org>

Thanks,

C.

>> It seems that we only use the routine once in the patchset and that th=
e
>> only thing we need to check is 'maxshift'.
>=20
> Not quite.  An earlier draft had this routine just take a max page
> size and clamp accordingly.  But that failed when I wrote the code to
> check against the KVM capabilities, because KVM also excludes some
> other pagesize combinations.  That's what the stanza I point out above
> is about
>=20
>> Do you envision other usage of the routine ?
>=20
> Not really, no.
>=20
>>
>> Thanks,
>>
>> C.
>>
>>> +static void cap_hpt_maxpagesize_cpu_apply(sPAPRMachineState *spapr,
>>> +                                          PowerPCCPU *cpu,
>>> +                                          uint8_t val, Error **errp)
>>> +{
>>> +    unsigned maxshift =3D val;
>>> +
>>> +    ppc_hash64_filter_pagesizes(cpu, spapr_pagesize_cb, &maxshift);
>>> +}
>>> +
>>>  sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] =3D {
>>>      [SPAPR_CAP_HTM] =3D {
>>>          .name =3D "htm",
>>> @@ -401,6 +433,7 @@ sPAPRCapabilityInfo capability_table[SPAPR_CAP_NU=
M] =3D {
>>>          .set =3D spapr_cap_set_pagesize,
>>>          .type =3D "int",
>>>          .apply =3D cap_hpt_maxpagesize_apply,
>>> +        .cpu_apply =3D cap_hpt_maxpagesize_cpu_apply,
>>>      },
>>>  };
>>> =20
>>>
>>
>=20
