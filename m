Received: from eggs.gnu.org ([2001:4830:134:3::10]:33841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dIpIK-00005p-7r
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 00:43:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dIpIH-0007R5-2I
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 00:43:40 -0400
Date: Thu, 8 Jun 2017 14:38:41 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170608043841.GB25805@umbus.fritz.box>
References: <20170607070732.23312-1-david@gibson.dropbear.id.au>
	<3de884c3-c386-c024-e401-faa459dbf0b4@redhat.com>
	<75cc682a-4203-30a5-fab3-22f4e1671532@redhat.com>
	<9ef08f1d-33d3-4494-2e91-2456d5764ecf@redhat.com>
	<20170608001809.GM13397@umbus.fritz.box>
	<4778e778-1257-3a58-155c-a987faccf189@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
Content-Disposition: inline
In-Reply-To: <4778e778-1257-3a58-155c-a987faccf189@redhat.com>
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
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, mdroth@linux.vnet.ibm.com, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 08, 2017 at 06:33:57AM +0200, Thomas Huth wrote:
> On 08.06.2017 02:18, David Gibson wrote:
> > On Wed, Jun 07, 2017 at 07:10:55PM +0200, Thomas Huth wrote:
> >> On 07.06.2017 16:34, Paolo Bonzini wrote:
> >>>
> >>>
> >>> On 07/06/2017 09:33, Thomas Huth wrote:
> >>>> On 07.06.2017 09:07, David Gibson wrote:
> >>>>> The pseries machine type doesn't usually use the 'pvpanic' device a=
s such,
> >>>>> because it has a firmware/hypervisor facility with roughly the same
> >>>>> purpose.  The 'ibm,os-term' RTAS call notifies the hypervisor that =
the
> >>>>> guest has crashed.
> >>>>>
> >>>>> Our implementation of this call was sending a GUEST_PANICKED qmp ev=
ent;
> >>>>> however, it was not doing the other usual panic actions, making its
> >>>>> behaviour different from pvpanic for no good reason.
> >>>>>
> >>>>> To correct this, we should call qemu_system_guest_panicked() rather=
 than
> >>>>> directly sending the panic event.
> >>>>>
> >>>>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> >>>>> ---
> >>>>>  hw/ppc/spapr_rtas.c | 7 ++-----
> >>>>>  1 file changed, 2 insertions(+), 5 deletions(-)
> >>>>>
> >>>>> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> >>>>> index 707c4d4..94a2799 100644
> >>>>> --- a/hw/ppc/spapr_rtas.c
> >>>>> +++ b/hw/ppc/spapr_rtas.c
> >>>>> @@ -293,12 +293,9 @@ static void rtas_ibm_os_term(PowerPCCPU *cpu,
> >>>>>                              target_ulong args,
> >>>>>                              uint32_t nret, target_ulong rets)
> >>>>>  {
> >>>>> -    target_ulong ret =3D 0;
> >>>>> +    qemu_system_guest_panicked(NULL);
> >>>>> =20
> >>>>> -    qapi_event_send_guest_panicked(GUEST_PANIC_ACTION_PAUSE, false=
, NULL,
> >>>>> -                                   &error_abort);
> >>>>> -
> >>>>> -    rtas_st(rets, 0, ret);
> >>>>> +    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> >>>>>  }
> >>>>> =20
> >>>>>  static void rtas_set_power_level(PowerPCCPU *cpu, sPAPRMachineStat=
e *spapr,
> >>>>>
> >>>>
> >>>> If I get that qemu_system_guest_panicked() function right, it will s=
top
> >>>> the VM, won't it? That contradicts the LoPAPR spec that says that the
> >>>> RTAS call returns if the "ibm,extended-os-term" property is availabl=
e in
> >>>> the device tree.
> >>>
> >>> It does return... but only after the user starts the guest again with
> >>> "cont".
> >>
> >> OK, I guess that's enough to say that the "ibm,extended-os-term"
> >> property can stay ... so I think the patch is fine as it is right now.
> >=20
> > So.. can I have an R-b?
>=20
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Thanks.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZONTRAAoJEGw4ysog2bOSeiIQAMMw3SsIVI8G+VdrqJfPH1ke
EUmvMOvjDVEHOVS1a0vf8u5Ujp8ycsVjh2xqKC/eJhHccjRtn91y+PU9xYZ46Mxe
urNrMjxb9j7oBT83cV8QpZz3cj1N1IglGCZW1IEHFK1p0tbntIPQIxQks4aHI4u+
eYs3R9o3DvqnJQpDdEAmxi/89mVmOSznvfJ+nFQ68yUIaIHup9kJjf2bVG0Iq8tP
M4ALDlZVFx6OgU1xt/yAtJmY3GvEdVKtPeZaAk8yiYv3naMJETDkcOS5QMDeB3QT
E0O031w8puSmrclziyuZOUXveC6kPGPdMmhTiu+W38VDTXaIv7NJWx9AI5GPfODt
EDuZ0gnelipNoQ+oXATAwvmyGXGehKvqPGcBQWefhnXuzEeGBwxwzmX8y1GXtkOK
xTdevcnBfpWAj2VWjZMgF7aPk0xhiwpEy2cm0k3FbA9QJZmWY6VB5GJGDMBMkfsU
ZxvnYalA32QYiVk9lJgnRrz4mkrY7C3yVBQpSz2L9FffcpwOwOjrJrjIJJgXy/mL
YgOXyavAnkI79TwrGbmTIgUwPFvaLV+8zUHIXhUJAKq7+uIibBxQj2xEPjPnOEvT
SLjBiGwm9sXq+5Hw2Km5IWL3s4J8R+Y/sY91Cx6I7M07A2LiqUQGxrtP726JH3ir
w5udNPlWUxZJBLRewzqw
=ATtx
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--
