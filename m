Received: from eggs.gnu.org ([2001:4830:134:3::10]:51762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dkJcc-0000F6-8y
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 20:34:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dkJcb-0006dT-DB
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 20:34:14 -0400
Date: Wed, 23 Aug 2017 10:34:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170823003404.GD5379@umbus.fritz.box>
References: <20170822042416.26758-1-david@gibson.dropbear.id.au>
	<CAFEAcA-iuizr9eh3=ZkPPT+YxfWzvUFzbWB-aA_Mo5BiDkrzQQ@mail.gmail.com>
	<b1167424-0f05-aad7-f456-22ca0aee2000@redhat.com>
	<CAFEAcA8dJe5uB-tUoeF=dE_q8HG_LLAmLUHdfR0XZihGN5JFXA@mail.gmail.com>
	<329bff28-5804-2d39-7bd8-9336eaaf9d26@redhat.com>
	<CAFEAcA9LUgCEAnMxuk_4Pdn9_rUuzTdyqH66Sp-VZy9K0gz-_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3Pql8miugIZX0722"
Content-Disposition: inline
In-Reply-To: <CAFEAcA9LUgCEAnMxuk_4Pdn9_rUuzTdyqH66Sp-VZy9K0gz-_g@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 0/7] ppc-for-2.10 queue 20170822
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Laurent Vivier <lvivier@redhat.com>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>


--3Pql8miugIZX0722
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 22, 2017 at 11:52:00AM +0100, Peter Maydell wrote:
> On 22 August 2017 at 11:41, Laurent Vivier <lvivier@redhat.com> wrote:
> > On 22/08/2017 11:53, Peter Maydell wrote:
> >> On 22 August 2017 at 10:43, Laurent Vivier <lvivier@redhat.com> wrote:
> >>> On 22/08/2017 11:34, Peter Maydell wrote:
> >>>> I get a make check failure on ppc64 Linux:
> >>>>
> >>>> TEST: tests/postcopy-test... (pid=3D12468)
> >>>>   /ppc64/postcopy:
> >>>> Broken pipe
> >>>> qemu-system-ppc64: RP: Received invalid message 0x0000 length 0x0000
> >>>> FAIL
> >>>> GTester: last random seed: R02Se5468e06f561627824306d95b0566d2b
> >>>> (pid=3D13011)
> >>>> FAIL: tests/postcopy-test
> >
> > The problem is in:
> >
> > bool kvmppc_pvr_workaround_required(PowerPCCPU *cpu)
> > {
> >     CPUState *cs =3D CPU(cpu);
> >
> >     if (cap_ppc_pvr_compat) {
> >         return false;
> >     }
> >
> >     return !kvmppc_is_pr(cs->kvm_state);
> > }
> >
> > It guesses !kvm pr means kvm_hv. That is not true, it can be TCG.
> >
> > This fixes the problem for me:
> > --- a/target/ppc/kvm.c
> > +++ b/target/ppc/kvm.c
> > @@ -2817,5 +2817,5 @@ bool kvmppc_pvr_workaround_required(PowerPCCPU *c=
pu)
> >          return false;
> >      }
> >
> > -    return !kvmppc_is_pr(cs->kvm_state);
> > +    return kvm_enabled() && !kvmppc_is_pr(cs->kvm_state);
> >  }
>=20
> Yep, fixes the failure for me too. David, can you respin your
> pull request, please?

Done.  In the interests of getting it out quickly, I haven't done the
full usual set of tests, though I have done a make check on a ppc host
both with and without KVM available.  A tweaked version of the fix
above is the only change, so I'm hoping the testing round on the
previous pullreq should suffice.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3Pql8miugIZX0722
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmczXwACgkQbDjKyiDZ
s5IbTA//Q5nqvDWwkaOOiFZdPynaVAIpHxAwG8Yk53C+j+sHZDHZ/BS7tsni02hk
5DasWRIQjRcw5wSgh5Mg00id+/ruRUX7uy6K+zJXvYqnCP76Kz7BfwpaOixZIupG
E/C6vUUDNuEA7yvKYNmTj6gcRsVrhVt+NQFMYY1p2PG3+YhOIpWraeu5TdsdjzDx
cVR2athaVRKsOs1Bq7hvZvm7in1gUTfkHZ28ND2Z6fIYU7A/3BLsQdVTx/Kya0cy
ROAeraDly61VV+1Y6aBTA+Fo40rPzTD16n99D7IzAPAA00EtqHTImK9xevOmgIGK
oGLU0OavDuVQamDj0CEc+kO3mfqgfYhVLzuppTQ7d29lk9TI2HKq5qOvg6edLKww
MGSpo05ZyQMdf8YjRck3Mjxb4/fi7PjRLgrTwoLafcFhElbiNBniU0rMiJT9rxKh
0cHvmse1HSMrB6jUixOhTxRZohfkWMW26j5gxLbUsWaJrHJup611y7guiLb5wP2E
XhEgFFSPktMaeP2IQxhX8iD1qe99qHwtt/7jJpyjAbwPXQR+HGXQdJehly1+uqRu
wzwJltZfgXsg0EgJ6neJEzkHv9xgOEK/R1YIP3LwhkY5msuB9VT4ooMwXYHqaRqX
ZEHqAUvJuZ3Gg/tV0CO+AEMmllQmNCtT7ChO3juj6lGAxl/KYjU=
=KUpP
-----END PGP SIGNATURE-----

--3Pql8miugIZX0722--
