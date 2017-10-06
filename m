Received: from eggs.gnu.org ([2001:4830:134:3::10]:52066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0P2y-0005Td-PZ
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 05:36:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0P2u-0000qY-PX
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 05:35:56 -0400
Date: Fri, 6 Oct 2017 20:35:41 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171006093541.GJ10961@umbus.fritz.box>
References: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
	<1507220690-265042-18-git-send-email-imammedo@redhat.com>
	<20171006050439.GV3260@umbus.fritz.box>
	<20171006112005.11850a76@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6J7GEvtanOfV9oXA"
Content-Disposition: inline
In-Reply-To: <20171006112005.11850a76@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH 17/23] ppc: spapr: use generic cpu_model
 parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "open list:ppce500" <qemu-ppc@nongnu.org>


--6J7GEvtanOfV9oXA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 06, 2017 at 11:20:05AM +0200, Igor Mammedov wrote:
> On Fri, 6 Oct 2017 16:04:39 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Thu, Oct 05, 2017 at 06:24:44PM +0200, Igor Mammedov wrote:
> > > use generic cpu_model parsing introduced by
> > >  (6063d4c0f vl.c: convert cpu_model to cpu type and set of global pro=
perties before machine_init())
> > >=20
> > > it allows to:
> > >   * replace sPAPRMachineClass::tcg_default_cpu with
> > >     MachineClass::default_cpu_type
> > >   * drop cpu_parse_cpu_model() from hw/ppc/spapr.c and reuse
> > >     one in vl.c
> > >   * simplify spapr_get_cpu_core_type() by removing
> > >     not needed anymore recurrsion since alias look up
> > >     happens earlier at vl.c and spapr_get_cpu_core_type()
> > >     works only with resulted from that cpu type.
> > >   * spapr no more needs to parse/depend on being phased out
> > >     MachineState::cpu_model, all tha parsing done by generic
> > >     code and target specific callback.
> > >=20
> > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > ---
> > > PS:
> > >   patch is a little bit big but it's hard to split it due
> > >   to dependencies, so pls bear with it. =20
> >=20
> > [snip]
> > > -static int kvm_ppc_register_host_cpu_type(void)
> > > +static int kvm_ppc_register_host_cpu_type(MachineState *ms)
> > >  {
> > >      TypeInfo type_info =3D {
> > >          .name =3D TYPE_HOST_POWERPC_CPU,
> > >          .class_init =3D kvmppc_host_cpu_class_init,
> > >      };
> > > +    MachineClass *mc =3D MACHINE_GET_CLASS(ms);
> > >      PowerPCCPUClass *pvr_pcc;
> > >      ObjectClass *oc;
> > >      DeviceClass *dc;
> > > @@ -2504,6 +2505,8 @@ static int kvm_ppc_register_host_cpu_type(void)
> > >      }
> > >      type_info.parent =3D object_class_get_name(OBJECT_CLASS(pvr_pcc)=
);
> > >      type_register(&type_info);
> > > +    /* override TCG default cpu type with 'host' cpu model */
> > > +    mc->default_cpu_type =3D TYPE_HOST_POWERPC_CPU; =20
> >=20
> > Ugh.  I dislike this, it changes the default cpu type to 'host' for
> > *all* machine types, whereas previously it was just true for pseries.
> > That wasn't by accident.
> >=20
> > In general, I think we want there to be a single default CPU type for
> > a machine, regardless of TCG vs. KVM.  This is particularly true for
> > many of the ppc machine types - they will only work with a CPU in the
> > right "family" (e500 / 440 / POWERx, wahtever); in many of these cases
> > KVM PR is usable, but using -cpu host could easily break the machine
> > type.
> >=20
> > 'pseries' is different, it (and only it) can be used with KVM HV - and
> > usually is.  And KVM HV *only* works with -cpu host, due to hardware
> > limitations.
> I'd keep override in spapr_machine_class_init() but it's not possible
> since it's called before kvm option is parsed and machine is prerequisite=
 for kvm option
>=20
> how about following fixup?
>=20
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index abc222e..48dc3f7 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2505,8 +2505,10 @@ static int kvm_ppc_register_host_cpu_type(MachineS=
tate *ms)
>      }
>      type_info.parent =3D object_class_get_name(OBJECT_CLASS(pvr_pcc));
>      type_register(&type_info);
> -    /* override TCG default cpu type with 'host' cpu model */
> -    mc->default_cpu_type =3D TYPE_HOST_POWERPC_CPU;
> +    if (object_dynamic_cast(ms, TYPE_SPAPR_MACHINE)) {
> +        /* override TCG default cpu type with 'host' cpu model */
> +        mc->default_cpu_type =3D TYPE_HOST_POWERPC_CPU;
> +    }
> =20
>      oc =3D object_class_by_name(type_info.name);
>      g_assert(oc);

Hm, ugly.  But if that's what we have to do, that's what we have to
do.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6J7GEvtanOfV9oXA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnXTmgACgkQbDjKyiDZ
s5JZURAA48oa5MGwkSoRhtmBGdGF1CXzDIrJuO039oj/LeyZ9k1KBOffFjfz35Eb
Zepp6V0p9fCtnHgsbaC0bFioW4Wj6GboiWoFpI5g1WahouJMFbywiv4+LTLC9cy9
7ndEQ9zU62qsH4glMSMkC08+t9aQL79NN1oCSxREI6D/PgJpLO5ll95i668BsWmZ
j/ejxPt2IYjsqHC6ugm/4roK4roYqepvRIN5tm58Iz4gOh6VseuJsBsneoCYf0xg
Wzp9A1BN25CCLZdnKH6VSwgIg7y4Q8s0wascIO5mdwTmwx0PahAjoRojC/RV6PlP
nyWd2aWhIcl7Zgdj6y5Wzi1vvVohkKylk4TcrVcJqCyqx0gQ+hWGMOvXrp8yHK01
/igBPVXuJN8ZUnrooks+TcRTMq2o6xKdLbSHU3ieBdIM3m7k+8/Slhn6VbTgfnht
nvKwNgVbVws0Is6ZNxz5P0OEPvid5TlsT2cdAjYc+U+8KB1EaLkbGEcXbTxtpnsi
WYg5TFVaKb5lE6my3HniIQWgy89bXE4aABQpJgGBAkqMnmhE2XxGFveLtdzCtesE
31l09rLbTDZqPONKGrEhjfpnmv/X/wwfpeYZBS6UV6hbCQAShH1AeWsTOU74NtkW
3BJM1f1F7R/Tj26oqNVzKzMlNTRbhF7c5WYAhP/DTW2KCsGWwW0=
=egct
-----END PGP SIGNATURE-----

--6J7GEvtanOfV9oXA--
