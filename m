Received: from eggs.gnu.org ([2001:4830:134:3::10]:45541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dSMEY-0006bd-4G
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 07:43:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dSMEU-00029J-U2
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 07:43:10 -0400
Date: Tue, 4 Jul 2017 21:41:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170704114151.GG2180@umbus.fritz.box>
References: <20170704110126.26806-1-lvivier@redhat.com>
	<20170704110126.26806-3-lvivier@redhat.com>
	<20170704131500.3ef448c8@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HB4mHL4PVvkpZAgW"
Content-Disposition: inline
In-Reply-To: <20170704131500.3ef448c8@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH v4 2/2] target/ppc: move POWER9 DD1
 workaround to init_proc_POWER9()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Laurent Vivier <lvivier@redhat.com>, joserz@linux.vnet.ibm.com, qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, Suraj Singh <sursingh@redhat.com>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Sam Bobroff <sbobroff@redhat.com>


--HB4mHL4PVvkpZAgW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 04, 2017 at 01:15:00PM +0200, Greg Kurz wrote:
> On Tue,  4 Jul 2017 13:01:26 +0200
> Laurent Vivier <lvivier@redhat.com> wrote:
>=20
> > Commit 5f3066d ("target/ppc: Allow workarounds for POWER9 DD1")
> > disables compatibility mode for POWER9 DD1 to allow to
> > boot on POWER9 DD1 host with KVM.
> >=20
> > As the workaround has been added in kvmppc_host_cpu_class_init(),
> > it applies only on CPU created with "-cpu host".
> > As we want to be able to use also "-cpu POWER9" on a POWER9 DD1
> > host, this patch moves the workaround from kvmppc_host_cpu_class_init()
> > to init_proc_POWER9().
> >=20
>=20
> As with ppc_cpu_initfn() in your previous version, init_proc_POWER9() is
> called for every CPU instance.. ie, all CPU will adjust the @pcr_supported
> class attribute...

Ah.. yeah.. I didn't notice that before.  That's definitely not right.

> What about moving the workaround to ppc_POWER9_cpu_family_class_init()
> instead ? This would just require to expose mfpvr() in some header.

Yeah, as someone else pointed out using the host PVR is also
definitely not right (unless you're in a function specifically
connected to the host cpu class).

>=20
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -8913,8 +8913,10 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
>      dc->props =3D powerpc_servercpu_properties;
>      pcc->pvr_match =3D ppc_pvr_match_power9;
>      pcc->pcr_mask =3D PCR_COMPAT_2_05 | PCR_COMPAT_2_06 | PCR_COMPAT_2_0=
7;
> -    pcc->pcr_supported =3D PCR_COMPAT_3_00 | PCR_COMPAT_2_07 | PCR_COMPA=
T_2_06 |
> -                         PCR_COMPAT_2_05;
> +    if (!kvm_enabled() || (mfpvr() & 0xffffff00) !=3D CPU_POWERPC_POWER9=
_DD1) {
> +        pcc->pcr_supported =3D PCR_COMPAT_3_00 | PCR_COMPAT_2_07 |
> +                             PCR_COMPAT_2_06 | PCR_COMPAT_2_05;
> +    }
>      pcc->init_proc =3D init_proc_POWER9;
>      pcc->check_pow =3D check_pow_nocheck;
>      cc->has_work =3D cpu_has_work_POWER9;
>=20
> > Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> > ---
> >  target/ppc/kvm.c            | 11 -----------
> >  target/ppc/translate_init.c | 15 ++++++++++++++-
> >  2 files changed, 14 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> > index f2f7c53..9d76817 100644
> > --- a/target/ppc/kvm.c
> > +++ b/target/ppc/kvm.c
> > @@ -2381,17 +2381,6 @@ static void kvmppc_host_cpu_class_init(ObjectCla=
ss *oc, void *data)
> > =20
> >  #if defined(TARGET_PPC64)
> >      pcc->radix_page_info =3D kvm_get_radix_page_info();
> > -
> > -    if ((pcc->pvr & 0xffffff00) =3D=3D CPU_POWERPC_POWER9_DD1) {
> > -        /*
> > -         * POWER9 DD1 has some bugs which make it not really ISA 3.00
> > -         * compliant.  More importantly, advertising ISA 3.00
> > -         * architected mode may prevent guests from activating
> > -         * necessary DD1 workarounds.
> > -         */
> > -        pcc->pcr_supported &=3D ~(PCR_COMPAT_3_00 | PCR_COMPAT_2_07
> > -                                | PCR_COMPAT_2_06 | PCR_COMPAT_2_05);
> > -    }
> >  #endif /* defined(TARGET_PPC64) */
> >  }
> > =20
> > diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> > index 783bf98..a41fe66 100644
> > --- a/target/ppc/translate_init.c
> > +++ b/target/ppc/translate_init.c
> > @@ -8811,6 +8811,8 @@ static struct ppc_radix_page_info POWER9_radix_pa=
ge_info =3D {
> > =20
> >  static void init_proc_POWER9(CPUPPCState *env)
> >  {
> > +    PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
> > +    PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> >      /* Common Registers */
> >      init_proc_book3s_common(env);
> >      gen_spr_book3s_207_dbg(env);
> > @@ -8848,7 +8850,18 @@ static void init_proc_POWER9(CPUPPCState *env)
> > =20
> >      /* Allocate hardware IRQ controller */
> >      init_excp_POWER8(env);
> > -    ppcPOWER7_irq_init(ppc_env_get_cpu(env));
> > +    ppcPOWER7_irq_init(cpu);
> > +
> > +    if ((pcc->pvr & 0xffffff00) =3D=3D CPU_POWERPC_POWER9_DD1) {
> > +        /*
> > +         * POWER9 DD1 has some bugs which make it not really ISA 3.00
> > +         * compliant.  More importantly, advertising ISA 3.00
> > +         * architected mode may prevent guests from activating
> > +         * necessary DD1 workarounds.
> > +         */
> > +        pcc->pcr_supported &=3D ~(PCR_COMPAT_3_00 | PCR_COMPAT_2_07
> > +                                | PCR_COMPAT_2_06 | PCR_COMPAT_2_05);
> > +    }
> >  }
> > =20
> >  static bool ppc_pvr_match_power9(PowerPCCPUClass *pcc, uint32_t pvr)
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--HB4mHL4PVvkpZAgW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZW379AAoJEGw4ysog2bOSjdoP/3slWiWoo9Ot1h/934qodOSa
Ezx5Hyhk8Qa4ktRwCouK+Lr77vtvKLRIrl380L66KqcwQNjGj44lvZPzPl5sa5Ra
I09nszicfQWhxs+VKejIf14i5hKcq2RaVxqAeAaWrVSMVKX9KBK51Ts0kfRGdYku
D7y+ZS6IEz4PlZ5xM8rzMFNummVbJljvu/vDNoHof1urN+fjkxFGKWICe7TTMg0k
Ki0c8SZgzAJFthMPxHGf3v91e8jzlk6sKj9fkXEuh0PXiboXOdlzS3vDqbwXDp9k
LiDG8awjOrSMSutdcXfE10D7X7GEqQOiiNXBobnVU0+UQd1OCEDX6RUSRPxwOyaD
eZrRztpVFVy62dhoUAauWMy3Artbu9Lnf0kc7uSLE95bQBELm2fjri1GoXH8cOL6
8vd4DIyzO17fiyzBylTPwBlb/dyLUzgax5GOipTSdOOdRibC54ARaqe/i/VY8Llz
5sJCOm6cqRerofl4IkvliixPg7mYrwTenlzeGv5nOfMf+RM7h6GEugsIEFhkgFP1
92Z6eQ0Yqyk25ngB3ONkn2aIRBfzqw99Mh3I3wAzqRlgV0Pn0wmnLxYWYXqrGhQF
qMAC0bxHtQg/zSK9Z0HF7H6SsQfFIX29EYHmPpxruinuPlDDZ+zVVS9zL/12PVZG
cUCRBZpyurxzU9tn0t1J
=Sfto
-----END PGP SIGNATURE-----

--HB4mHL4PVvkpZAgW--
