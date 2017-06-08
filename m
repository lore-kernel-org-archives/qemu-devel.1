Received: from eggs.gnu.org ([2001:4830:134:3::10]:55031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dIlSI-0000dD-Em
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 20:37:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dIlSH-0003u0-9o
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 20:37:42 -0400
Date: Thu, 8 Jun 2017 10:18:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170608001809.GM13397@umbus.fritz.box>
References: <20170607070732.23312-1-david@gibson.dropbear.id.au>
	<3de884c3-c386-c024-e401-faa459dbf0b4@redhat.com>
	<75cc682a-4203-30a5-fab3-22f4e1671532@redhat.com>
	<9ef08f1d-33d3-4494-2e91-2456d5764ecf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="H/P/fp31Su+ob3Cg"
Content-Disposition: inline
In-Reply-To: <9ef08f1d-33d3-4494-2e91-2456d5764ecf@redhat.com>
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


--H/P/fp31Su+ob3Cg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 07, 2017 at 07:10:55PM +0200, Thomas Huth wrote:
> On 07.06.2017 16:34, Paolo Bonzini wrote:
> >=20
> >=20
> > On 07/06/2017 09:33, Thomas Huth wrote:
> >> On 07.06.2017 09:07, David Gibson wrote:
> >>> The pseries machine type doesn't usually use the 'pvpanic' device as =
such,
> >>> because it has a firmware/hypervisor facility with roughly the same
> >>> purpose.  The 'ibm,os-term' RTAS call notifies the hypervisor that the
> >>> guest has crashed.
> >>>
> >>> Our implementation of this call was sending a GUEST_PANICKED qmp even=
t;
> >>> however, it was not doing the other usual panic actions, making its
> >>> behaviour different from pvpanic for no good reason.
> >>>
> >>> To correct this, we should call qemu_system_guest_panicked() rather t=
han
> >>> directly sending the panic event.
> >>>
> >>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> >>> ---
> >>>  hw/ppc/spapr_rtas.c | 7 ++-----
> >>>  1 file changed, 2 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> >>> index 707c4d4..94a2799 100644
> >>> --- a/hw/ppc/spapr_rtas.c
> >>> +++ b/hw/ppc/spapr_rtas.c
> >>> @@ -293,12 +293,9 @@ static void rtas_ibm_os_term(PowerPCCPU *cpu,
> >>>                              target_ulong args,
> >>>                              uint32_t nret, target_ulong rets)
> >>>  {
> >>> -    target_ulong ret =3D 0;
> >>> +    qemu_system_guest_panicked(NULL);
> >>> =20
> >>> -    qapi_event_send_guest_panicked(GUEST_PANIC_ACTION_PAUSE, false, =
NULL,
> >>> -                                   &error_abort);
> >>> -
> >>> -    rtas_st(rets, 0, ret);
> >>> +    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
> >>>  }
> >>> =20
> >>>  static void rtas_set_power_level(PowerPCCPU *cpu, sPAPRMachineState =
*spapr,
> >>>
> >>
> >> If I get that qemu_system_guest_panicked() function right, it will stop
> >> the VM, won't it? That contradicts the LoPAPR spec that says that the
> >> RTAS call returns if the "ibm,extended-os-term" property is available =
in
> >> the device tree.
> >=20
> > It does return... but only after the user starts the guest again with
> > "cont".
>=20
> OK, I guess that's enough to say that the "ibm,extended-os-term"
> property can stay ... so I think the patch is fine as it is right now.

So.. can I have an R-b?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--H/P/fp31Su+ob3Cg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZOJe/AAoJEGw4ysog2bOSTMoP/1UakWEEWM2evLdoPP7e49jc
vaFVffiHeiDS9wLlQiTHsCn+lILYaeay3psXkFhBg8ftpuvg0JiW9oZSrBqAcg/M
gEz6sV+gQgaoU/m2mIfxJZ6VLW4intkL85vHmwGIrDQK8onQ9opAxBdB2nU5spVs
KHzd69p1Nv5WbfLyFsZzxYNkmIptCweLAhRz14kyNQvTbTV8kpTNG5JQwqcfLOZd
hYt+p0ZBWJ0UuirynuJY89QNW7OfbWL06aCFhbV2JvYbeq0rZDMCiV+IZn5Q6IEz
R3UmPbz7n3u/O9RTt1h95KdskUTg83fJ0R4ugepEM5tZXWzUa1H3a/sKQm/m0vAK
8rdbHxHvsn9ikO/dGYSUsagfiAw0aF0nZgaqtwdC49PXpXhKYp4Ij1WdiukVtbEA
eQsVxgWacYw/awmt4hbSD6VcP8EPTx6lwFImj4x+eP7oY+f7xcHQXAMrMZwA24wF
RQEHUpAqGn41MU8QGmhGDH0f0cMUVVM9pynAFpj0M8B1SIdLR+npkM1tpbKZZNXt
ePwrVgYEY/NCRfNLPLk2Q9tw4+687cjmNzbhbS15HiJHec8S3LsCJvW+orLgKu69
bDmpkOW0GRC7dzDNjYP8pMe3LVbifReOTpKKpf6lWq+nS3ilELLY7u1Jmx+L0/Jc
tALHvEAO8igA3081B+KE
=WDwM
-----END PGP SIGNATURE-----

--H/P/fp31Su+ob3Cg--
