Received: from eggs.gnu.org ([2001:4830:134:3::10]:59657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dIp94-00059j-MR
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 00:34:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dIp90-0003vw-Ot
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 00:34:06 -0400
References: <20170607070732.23312-1-david@gibson.dropbear.id.au>
	<3de884c3-c386-c024-e401-faa459dbf0b4@redhat.com>
	<75cc682a-4203-30a5-fab3-22f4e1671532@redhat.com>
	<9ef08f1d-33d3-4494-2e91-2456d5764ecf@redhat.com>
	<20170608001809.GM13397@umbus.fritz.box>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4778e778-1257-3a58-155c-a987faccf189@redhat.com>
Date: Thu, 8 Jun 2017 06:33:57 +0200
MIME-Version: 1.0
In-Reply-To: <20170608001809.GM13397@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="6OjusJgPjWqwtHVrI0BS36nnPC4gRMgXP"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] pseries: Correct panic
 behaviour for pseries machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Paolo Bonzini <pbonzini@redhat.com>, mdroth@linux.vnet.ibm.com, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6OjusJgPjWqwtHVrI0BS36nnPC4gRMgXP
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 08.06.2017 02:18, David Gibson wrote:
> On Wed, Jun 07, 2017 at 07:10:55PM +0200, Thomas Huth wrote:
>> On 07.06.2017 16:34, Paolo Bonzini wrote:
>>>
>>>
>>> On 07/06/2017 09:33, Thomas Huth wrote:
>>>> On 07.06.2017 09:07, David Gibson wrote:
>>>>> The pseries machine type doesn't usually use the 'pvpanic' device a=
s such,
>>>>> because it has a firmware/hypervisor facility with roughly the same=

>>>>> purpose.  The 'ibm,os-term' RTAS call notifies the hypervisor that =
the
>>>>> guest has crashed.
>>>>>
>>>>> Our implementation of this call was sending a GUEST_PANICKED qmp ev=
ent;
>>>>> however, it was not doing the other usual panic actions, making its=

>>>>> behaviour different from pvpanic for no good reason.
>>>>>
>>>>> To correct this, we should call qemu_system_guest_panicked() rather=
 than
>>>>> directly sending the panic event.
>>>>>
>>>>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>>>>> ---
>>>>>  hw/ppc/spapr_rtas.c | 7 ++-----
>>>>>  1 file changed, 2 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
>>>>> index 707c4d4..94a2799 100644
>>>>> --- a/hw/ppc/spapr_rtas.c
>>>>> +++ b/hw/ppc/spapr_rtas.c
>>>>> @@ -293,12 +293,9 @@ static void rtas_ibm_os_term(PowerPCCPU *cpu,
>>>>>                              target_ulong args,
>>>>>                              uint32_t nret, target_ulong rets)
>>>>>  {
>>>>> -    target_ulong ret =3D 0;
>>>>> +    qemu_system_guest_panicked(NULL);
>>>>> =20
>>>>> -    qapi_event_send_guest_panicked(GUEST_PANIC_ACTION_PAUSE, false=
, NULL,
>>>>> -                                   &error_abort);
>>>>> -
>>>>> -    rtas_st(rets, 0, ret);
>>>>> +    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
>>>>>  }
>>>>> =20
>>>>>  static void rtas_set_power_level(PowerPCCPU *cpu, sPAPRMachineStat=
e *spapr,
>>>>>
>>>>
>>>> If I get that qemu_system_guest_panicked() function right, it will s=
top
>>>> the VM, won't it? That contradicts the LoPAPR spec that says that th=
e
>>>> RTAS call returns if the "ibm,extended-os-term" property is availabl=
e in
>>>> the device tree.
>>>
>>> It does return... but only after the user starts the guest again with=

>>> "cont".
>>
>> OK, I guess that's enough to say that the "ibm,extended-os-term"
>> property can stay ... so I think the patch is fine as it is right now.=

>=20
> So.. can I have an R-b?

Reviewed-by: Thomas Huth <thuth@redhat.com>


--6OjusJgPjWqwtHVrI0BS36nnPC4gRMgXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZONO2AAoJEC7Z13T+cC21I0QP/3EGcdvMuk4Jk1MW4bRL0YR5
26FQ8R2JS0Y9SBT+XeKEyvSbMobGjR/EHaT2cmcK4CSn5WYHko3P6OQiSPZ2GpcY
50MH+un2Nn3cSPxoeZNP8vuOgVN/LdMHphPYlb4ydpHekIjRIilLyujT4N85N04c
GHivROXPVrhOF2KKV62e8S1y0/76Ir46zY+cOHIO4Hl+Njrpn4gQtg15Zr1uNY2F
s207pFCT0a+ARj8z/Xke5BhSaRmXnuHpSc7q0P6fPil1CyD0RuhDyHBPj6j6mOpU
OqZeWBrjh6RXe0luhVugBeX4LPV5j/5OOJpyrzo2L3nsP1RvSVPJUydOKBrJfh7R
Uqow31MjuoZ2A+pjCnBL4azIndxsIZPVjHqNZeor1SYGi9DEAGmdtgmB1Tf4x7lk
p2er1isralQtpW3K4KpVTZLgyepgyupqH83a2rBW/D+Mk2pppPKpq1exuDPnfWyr
2E4Ol31rZW0o9V6mRkvK72JQV7YOxhayzminhvhdqSja7isTAhhnK3AqWaO40hF3
x2NcO4gxIyWwhVEbIMAodnDnAc5REnll5N/B+WdreMPh2SVE80esf1VSXbvZh7hR
sMGjGxYn3tRtXkN3B+kQ7WMBBfpEAqT6W46T+WEpaCegPNr0XdDZ3vi0T16A1nXc
NUMHtzgzIIaPAhUr8Bx/
=X/s5
-----END PGP SIGNATURE-----

--6OjusJgPjWqwtHVrI0BS36nnPC4gRMgXP--
