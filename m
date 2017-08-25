Received: from eggs.gnu.org ([2001:4830:134:3::10]:40630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dlEgG-00037B-Rp
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 09:29:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dlEgD-0005mc-Ni
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 09:29:48 -0400
Date: Fri, 25 Aug 2017 23:24:11 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170825132411.GL2772@umbus.fritz.box>
References: <1503562911-2776-1-git-send-email-imammedo@redhat.com>
	<1503562911-2776-2-git-send-email-imammedo@redhat.com>
	<20170825013047.GP5379@umbus.fritz.box>
	<20170825092822.2f987391@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UUBKWyapWpFAak7q"
Content-Disposition: inline
In-Reply-To: <20170825092822.2f987391@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11 1/6] ppc: use macros to make cpu
 type name from string literal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>


--UUBKWyapWpFAak7q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 25, 2017 at 09:28:22AM +0200, Igor Mammedov wrote:
> On Fri, 25 Aug 2017 11:30:47 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Thu, Aug 24, 2017 at 10:21:46AM +0200, Igor Mammedov wrote:
> > > Replace
> > >   "-" TYPE_POWERPC_CPU
> > > when composing cpu type name from cpu model string literal
> > > and the same pattern in format strings with
> > >  POWERPC_CPU_TYPE_SUFFIX and POWERPC_CPU_TYPE_NAME(model)
> > > macroses like we do in x86.
> > >=20
> > > Later POWERPC_CPU_TYPE_NAME() will be used to define default
> > > cpu type per machine type and as bonus it will be consistent
> > > and easy grep-able pattern across all other targets that I'm
> > > plannig to treat the same way.
> > >=20
> > > Signed-off-by: Igor Mammedov <imammedo@redhat.com> =20
> >=20
> > Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> >=20
> > I'm assuming you'll stage this for 2.11.
> I've been hoping that it would go via your tree

Ok, I can do that if you prefer.

>=20
> >=20
> > > ---
> > >  target/ppc/cpu.h            | 3 +++
> > >  target/ppc/kvm_ppc.h        | 2 +-
> > >  target/ppc/cpu-models.c     | 2 +-
> > >  target/ppc/kvm.c            | 2 +-
> > >  target/ppc/translate_init.c | 6 +++---
> > >  5 files changed, 9 insertions(+), 6 deletions(-)
> > >=20
> > > diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> > > index 12f0949..0512393 100644
> > > --- a/target/ppc/cpu.h
> > > +++ b/target/ppc/cpu.h
> > > @@ -1354,6 +1354,9 @@ int ppc_dcr_write (ppc_dcr_t *dcr_env, int dcrn=
, uint32_t val);
> > > =20
> > >  #define cpu_init(cpu_model) cpu_generic_init(TYPE_POWERPC_CPU, cpu_m=
odel)
> > > =20
> > > +#define POWERPC_CPU_TYPE_SUFFIX "-" TYPE_POWERPC_CPU
> > > +#define POWERPC_CPU_TYPE_NAME(model) model POWERPC_CPU_TYPE_SUFFIX
> > > +
> > >  #define cpu_signal_handler cpu_ppc_signal_handler
> > >  #define cpu_list ppc_cpu_list
> > > =20
> > > diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> > > index 6bc6fb3..bcb40f2 100644
> > > --- a/target/ppc/kvm_ppc.h
> > > +++ b/target/ppc/kvm_ppc.h
> > > @@ -9,7 +9,7 @@
> > >  #ifndef KVM_PPC_H
> > >  #define KVM_PPC_H
> > > =20
> > > -#define TYPE_HOST_POWERPC_CPU "host-" TYPE_POWERPC_CPU
> > > +#define TYPE_HOST_POWERPC_CPU POWERPC_CPU_TYPE_NAME("host")
> > > =20
> > >  #ifdef CONFIG_KVM
> > > =20
> > > diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
> > > index 4d3e635..8b27962 100644
> > > --- a/target/ppc/cpu-models.c
> > > +++ b/target/ppc/cpu-models.c
> > > @@ -51,7 +51,7 @@
> > >                                                                      =
        \
> > >      static const TypeInfo                                           =
        \
> > >      glue(POWERPC_DEF_PREFIX(_pvr, _svr, _type), _cpu_type_info) =3D =
{         \
> > > -        .name       =3D _name "-" TYPE_POWERPC_CPU,                 =
          \
> > > +        .name       =3D POWERPC_CPU_TYPE_NAME(_name),               =
            \
> > >          .parent     =3D stringify(_type) "-family-" TYPE_POWERPC_CPU=
,         \
> > >          .class_init =3D                                             =
          \
> > >              glue(POWERPC_DEF_PREFIX(_pvr, _svr, _type), _cpu_class_i=
nit),   \
> > > diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> > > index 8571379..8590809 100644
> > > --- a/target/ppc/kvm.c
> > > +++ b/target/ppc/kvm.c
> > > @@ -2484,7 +2484,7 @@ static int kvm_ppc_register_host_cpu_type(void)
> > >              char *suffix;
> > > =20
> > >              ppc_cpu_aliases[i].model =3D g_strdup(object_class_get_n=
ame(oc));
> > > -            suffix =3D strstr(ppc_cpu_aliases[i].model, "-"TYPE_POWE=
RPC_CPU);
> > > +            suffix =3D strstr(ppc_cpu_aliases[i].model, POWERPC_CPU_=
TYPE_SUFFIX);
> > >              if (suffix) {
> > >                  *suffix =3D 0;
> > >              }
> > > diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> > > index 43be9a8..f377cf2 100644
> > > --- a/target/ppc/translate_init.c
> > > +++ b/target/ppc/translate_init.c
> > > @@ -10185,7 +10185,7 @@ static gint ppc_cpu_compare_class_name(gconst=
pointer a, gconstpointer b)
> > >      if (strncasecmp(name, object_class_get_name(oc), strlen(name)) =
=3D=3D 0 &&
> > >          ppc_cpu_is_valid(pcc) &&
> > >          strcmp(object_class_get_name(oc) + strlen(name),
> > > -               "-" TYPE_POWERPC_CPU) =3D=3D 0) {
> > > +               POWERPC_CPU_TYPE_SUFFIX) =3D=3D 0) {
> > >          return 0;
> > >      }
> > >      return -1;
> > > @@ -10327,7 +10327,7 @@ static void ppc_cpu_list_entry(gpointer data,=
 gpointer user_data)
> > >      }
> > > =20
> > >      name =3D g_strndup(typename,
> > > -                     strlen(typename) - strlen("-" TYPE_POWERPC_CPU)=
);
> > > +                     strlen(typename) - strlen(POWERPC_CPU_TYPE_SUFF=
IX));
> > >      (*s->cpu_fprintf)(s->file, "PowerPC %-16s PVR %08x\n",
> > >                        name, pcc->pvr);
> > >      for (i =3D 0; ppc_cpu_aliases[i].alias !=3D NULL; i++) {
> > > @@ -10388,7 +10388,7 @@ static void ppc_cpu_defs_entry(gpointer data,=
 gpointer user_data)
> > >      typename =3D object_class_get_name(oc);
> > >      info =3D g_malloc0(sizeof(*info));
> > >      info->name =3D g_strndup(typename,
> > > -                           strlen(typename) - strlen("-" TYPE_POWERP=
C_CPU));
> > > +                           strlen(typename) - strlen(POWERPC_CPU_TYP=
E_SUFFIX));
> > > =20
> > >      entry =3D g_malloc0(sizeof(*entry));
> > >      entry->value =3D info; =20
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--UUBKWyapWpFAak7q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmgJPsACgkQbDjKyiDZ
s5LK2g/5AcqEueSoz6Xzp4N8TMa4zgzIA/JGk+0pbOXYDeJiR/hQz4Aou4kVvxK/
KzQlXABc3nQeYQVPEYfMYnlp9BVukGyuzJ5gtbUNN3QfD9+3F6y4GaGkocngPnR/
ibSRmQb3FaPZ0+el5aVG4j68TZz8L9MiAJC47ImV7BjBRWybSg9Ed2Grr2T8ZOue
jzJrhyfLfLh1uyL0fcMujce6M5410wnq2fZRJwbZSuH/p6mg5hudYRsmuYIyUE3f
RX9eKuUsJZxC6VWKAflgjO6/ojmtccxrucjuCncgYFqhYNmYOkSlgpfvUXgJiTez
N4dNN2VVI698Ny8kVLrv9wFJgaop9LXojctt8zS2iBCDNJ+yLA3mSHROgzm1OnVG
1lgKrwyaH2iHQobJPqbApMlU4VC7ijAFYC8dSX3atdV8nbHbWgLdCdc59EmJeTGh
p0o/ekhNebGBwPPVz1MVlW1UGRTO1HQtaABQ3kkjJ4irR2DJS6JboxwX4nrry+Y3
Sa/Cm+A/zOWCfe8nvIFB2yU20iAOfY4IVVXGqJX290Zr2RR1VAXxSu0TYRujfJye
f0ST1WYzrqAhqR5ePognv3SFcOt0e3e8HniGfsRCTp5yFyJiUIMLCmznVQebamwI
dMs7k+0BodL4LNWzWxUwjXux7bZ9SKeI5UtAZC11jK2EJDA1DVw=
=1i8Q
-----END PGP SIGNATURE-----

--UUBKWyapWpFAak7q--
