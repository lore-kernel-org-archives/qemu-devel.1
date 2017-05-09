Received: from eggs.gnu.org ([2001:4830:134:3::10]:37892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8FtI-0007Jv-G0
	for qemu-devel@nongnu.org; Tue, 09 May 2017 20:54:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8FtH-0000hV-Cn
	for qemu-devel@nongnu.org; Tue, 09 May 2017 20:54:08 -0400
Date: Tue, 9 May 2017 17:11:19 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170509071119.GP25748@umbus.fritz.box>
References: <1488999936-16898-1-git-send-email-thuth@redhat.com>
	<a44802fe-780c-8a5d-ba1d-a9969748f19d@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="THYEXwetZJOK3OLY"
Content-Disposition: inline
In-Reply-To: <a44802fe-780c-8a5d-ba1d-a9969748f19d@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] target/ppc: Avoid printing
 wrong aliases in CPU help text
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>


--THYEXwetZJOK3OLY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 09, 2017 at 06:49:29AM +0200, Thomas Huth wrote:
> On 08.03.2017 20:05, Thomas Huth wrote:
> > When running with KVM, we update the "family" CPU alias to point
> > to the right host CPU type, so that it is for example possible to
> > use "-cpu POWER8" on a POWER8NVL host. However, the function for
> > printing the list of available CPU models is called earlier than
> > the KVM setup code, so the output of "-cpu help" is wrong in that
> > case. Since it would be somewhat ugly anyway to have different
> > help texts depending on whether "-enable-kvm" has been specified
> > or not, we should better always print the same text, so fix this
> > issue by printing "alias for preferred XXX CPU" instead.
> >=20
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >  target/ppc/cpu.h            |  1 +
> >  target/ppc/kvm.c            | 12 ------------
> >  target/ppc/translate_init.c | 27 +++++++++++++++++++++++++--
> >  3 files changed, 26 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> > index 7c4a1f5..21752ff 100644
> > --- a/target/ppc/cpu.h
> > +++ b/target/ppc/cpu.h
> > @@ -1216,6 +1216,7 @@ static inline PowerPCCPU *ppc_env_get_cpu(CPUPPCS=
tate *env)
> > =20
> >  PowerPCCPUClass *ppc_cpu_class_by_pvr(uint32_t pvr);
> >  PowerPCCPUClass *ppc_cpu_class_by_pvr_mask(uint32_t pvr);
> > +PowerPCCPUClass *ppc_cpu_get_family_class(PowerPCCPUClass *pcc);
> > =20
> >  struct PPCVirtualHypervisor {
> >      Object parent;
> > diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> > index 9f1f132..585e6d3 100644
> > --- a/target/ppc/kvm.c
> > +++ b/target/ppc/kvm.c
> > @@ -2304,18 +2304,6 @@ bool kvmppc_has_cap_htm(void)
> >      return cap_htm;
> >  }
> > =20
> > -static PowerPCCPUClass *ppc_cpu_get_family_class(PowerPCCPUClass *pcc)
> > -{
> > -    ObjectClass *oc =3D OBJECT_CLASS(pcc);
> > -
> > -    while (oc && !object_class_is_abstract(oc)) {
> > -        oc =3D object_class_get_parent(oc);
> > -    }
> > -    assert(oc);
> > -
> > -    return POWERPC_CPU_CLASS(oc);
> > -}
> > -
> >  PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void)
> >  {
> >      uint32_t host_pvr =3D mfpvr();
> > diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> > index c1a9014..9e9c37f 100644
> > --- a/target/ppc/translate_init.c
> > +++ b/target/ppc/translate_init.c
> > @@ -10249,6 +10249,18 @@ PowerPCCPU *cpu_ppc_init(const char *cpu_model)
> >      return POWERPC_CPU(cpu_generic_init(TYPE_POWERPC_CPU, cpu_model));
> >  }
> > =20
> > +PowerPCCPUClass *ppc_cpu_get_family_class(PowerPCCPUClass *pcc)
> > +{
> > +    ObjectClass *oc =3D OBJECT_CLASS(pcc);
> > +
> > +    while (oc && !object_class_is_abstract(oc)) {
> > +        oc =3D object_class_get_parent(oc);
> > +    }
> > +    assert(oc);
> > +
> > +    return POWERPC_CPU_CLASS(oc);
> > +}
> > +
> >  /* Sort by PVR, ordering special case "host" last. */
> >  static gint ppc_cpu_list_compare(gconstpointer a, gconstpointer b)
> >  {
> > @@ -10280,6 +10292,7 @@ static void ppc_cpu_list_entry(gpointer data, g=
pointer user_data)
> >      ObjectClass *oc =3D data;
> >      CPUListState *s =3D user_data;
> >      PowerPCCPUClass *pcc =3D POWERPC_CPU_CLASS(oc);
> > +    DeviceClass *family =3D DEVICE_CLASS(ppc_cpu_get_family_class(pcc)=
);
> >      const char *typename =3D object_class_get_name(oc);
> >      char *name;
> >      int i;
> > @@ -10302,8 +10315,18 @@ static void ppc_cpu_list_entry(gpointer data, =
gpointer user_data)
> >          if (alias_oc !=3D oc) {
> >              continue;
> >          }
> > -        (*s->cpu_fprintf)(s->file, "PowerPC %-16s (alias for %s)\n",
> > -                          alias->alias, name);
> > +        /*
> > +         * If running with KVM, we might update the family alias later=
, so
> > +         * avoid printing the wrong alias here and use "preferred" ins=
tead
> > +         */
> > +        if (strcmp(alias->alias, family->desc) =3D=3D 0) {
> > +            (*s->cpu_fprintf)(s->file,
> > +                              "PowerPC %-16s (alias for preferred %s C=
PU)\n",
> > +                              alias->alias, family->desc);
> > +        } else {
> > +            (*s->cpu_fprintf)(s->file, "PowerPC %-16s (alias for %s)\n=
",
> > +                              alias->alias, name);
> > +        }
> >      }
> >      g_free(name);
> >  }
> >=20
>=20
> Ping!
>=20
> ... I think this got somehow lost in the 2.9 rush ...

Yes, I think so.  Can you make sure it's rebased and repost, please.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--THYEXwetZJOK3OLY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZEWuXAAoJEGw4ysog2bOSGKUQAI1D+ShaGSizvFCYBF36Rdxl
A2OiayB8QSykO/tgQlSnfC72DOxBh/90men1JN+u1Qd2TZtOKQtH1wVbn/mwyYIg
RTBpidbR2DNQiPgYujT1T5Whdtd/wCtCLJSKPt3WGiV+tJxJpBl9X1V+nyFKuoBF
RwsH+nXkDJgGBnHttPCx7MO0rrBvRvmPQjadmqpbWa79h91Q1DFWzEy2nJjURIeB
ECLwGQp/nD5DLZmLUyt5pPBMyveoZTKu0UZzEwLDZIM/ggcSX7Dm9+qJ1GhPzagV
QDPJUg7Nt2fHuSA50ywqifN2EfmC3PStYfCz85dpKvC3MPNJy9VGFSYJ72AI8f3c
1BgUff8yh1fU9WNfHsM94P3GY6PRquiMkbcG8u7cOFMUwvlReh8PJduh2eQYHiyc
dCnuggqO38/7Z2LA1Ixw6YFYiiVdHyYAHiDoEVKYf0eBDOKiEIKO05nYQF6z5ZiC
8+PjC17OkHEkhTGPNHIZ++X+G8dafLofZ8aKsI9TuBQFcsE8ZjPGBAgKTOQVF3xh
zvofA7pUEZasNcvXkc8yeFOl4aaaqKUqyN9bJLIsakm1gYXmDyyw0tNi5fw9CLyF
NkVnMLh4o6EIcyM/hXGzVqyOJeFEPMDCv/EQ/OxThbX48BBYxdpqfIkP4qjZ2vPK
fBF/Ar7H6GhqwuITytpY
=8Kv8
-----END PGP SIGNATURE-----

--THYEXwetZJOK3OLY--
