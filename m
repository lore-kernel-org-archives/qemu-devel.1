Received: from eggs.gnu.org ([2001:4830:134:3::10]:38318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fVxm0-0002ot-PV
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 07:29:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fVxlz-0008G1-8V
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 07:29:08 -0400
Date: Thu, 21 Jun 2018 21:06:23 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180621110623.GI32328@umbus.fritz.box>
References: <20180618063606.2513-1-david@gibson.dropbear.id.au>
	<20180618063606.2513-7-david@gibson.dropbear.id.au>
	<e5ab358f-726a-add0-c2d2-27c157ca1925@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YrQNB5Deg1WGKZi3"
Content-Disposition: inline
In-Reply-To: <e5ab358f-726a-add0-c2d2-27c157ca1925@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 6/9] spapr: Use maximum page size
 capability to simplify memory backend checking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: groug@kaod.org, abologna@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, aik@ozlabs.ru


--YrQNB5Deg1WGKZi3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 21, 2018 at 08:29:36AM +0200, C=E9dric Le Goater wrote:
> On 06/18/2018 08:36 AM, David Gibson wrote:
> > The way we used to handle KVM allowable guest pagesizes for PAPR guests
> > required some convoluted checking of memory attached to the guest.
> >=20
> > The allowable pagesizes advertised to the guest cpus depended on the me=
mory
> > which was attached at boot, but then we needed to ensure that any memory
> > later hotplugged didn't change which pagesizes were allowed.
> >=20
> > Now that we have an explicit machine option to control the allowable
> > maximum pagesize we can simplify this.  We just check all memory backen=
ds
> > against that declared pagesize.  We check base and cold-plugged memory =
at
> > reset time, and hotplugged memory at pre_plug() time.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>=20
> One minor question below.
>=20
> Nevertheless,
>=20
> Reviewed-by: C=E9dric Le Goater <clg@kaod.org>

[snip]
> > @@ -304,6 +305,23 @@ static void cap_safe_indirect_branch_apply(sPAPRMa=
chineState *spapr,
> > =20
> >  #define VALUE_DESC_TRISTATE     " (broken, workaround, fixed)"
> > =20
> > +void spapr_check_pagesize(sPAPRMachineState *spapr, hwaddr pagesize,
> > +                          Error **errp)
> > +{
> > +    hwaddr maxpagesize =3D (1ULL << spapr->eff.caps[SPAPR_CAP_HPT_MPS]=
);
>=20
> I suppose this is SPAPR_CAP_HPT_MAXPAGESIZE now ?=20

Oops.  I thought I'd compile tested all the intermediate patches,
which would have caught this, but apparently not.

Fixed now.

> > +
> > +    if (!kvmppc_hpt_needs_host_contiguous_pages()) {
> > +        return;
> > +    }
> > +
> > +    if (maxpagesize > pagesize) {
> > +        error_setg(errp,
> > +                   "Can't support %"HWADDR_PRIu" kiB guest pages with =
%"
> > +                   HWADDR_PRIu" kiB host pages with this KVM implement=
ation",
> > +                   maxpagesize >> 10, pagesize >> 10);
> > +    }
> > +}
> > +
> >  static void cap_hpt_maxpagesize_apply(sPAPRMachineState *spapr,
> >                                        uint8_t val, Error **errp)
> >  {
> > @@ -312,6 +330,8 @@ static void cap_hpt_maxpagesize_apply(sPAPRMachineS=
tate *spapr,
> >      } else if (val < 16) {
> >          warn_report("Many guests require at least 64kiB hpt-max-page-s=
ize");
> >      }
> > +
> > +    spapr_check_pagesize(spapr, qemu_getrampagesize(), errp);
> >  }
> > =20
> >  sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] =3D {
> > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > index c97593d032..75e2cf2687 100644
> > --- a/include/hw/ppc/spapr.h
> > +++ b/include/hw/ppc/spapr.h
> > @@ -806,4 +806,7 @@ void spapr_caps_cpu_apply(sPAPRMachineState *spapr,=
 PowerPCCPU *cpu);
> >  void spapr_caps_add_properties(sPAPRMachineClass *smc, Error **errp);
> >  int spapr_caps_post_migration(sPAPRMachineState *spapr);
> > =20
> > +void spapr_check_pagesize(sPAPRMachineState *spapr, hwaddr pagesize,
> > +                          Error **errp);
> > +
> >  #endif /* HW_SPAPR_H */
> > diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> > index 50b5d01432..9cfbd388ad 100644
> > --- a/target/ppc/kvm.c
> > +++ b/target/ppc/kvm.c
> > @@ -500,26 +500,12 @@ static void kvm_fixup_page_sizes(PowerPCCPU *cpu)
> >          cpu->hash64_opts->flags &=3D ~PPC_HASH64_1TSEG;
> >      }
> >  }
> > -
> > -bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path)
> > -{
> > -    Object *mem_obj =3D object_resolve_path(obj_path, NULL);
> > -    long pagesize =3D host_memory_backend_pagesize(MEMORY_BACKEND(mem_=
obj));
> > -
> > -    return pagesize >=3D max_cpu_page_size;
> > -}
> > -
> >  #else /* defined (TARGET_PPC64) */
> > =20
> >  static inline void kvm_fixup_page_sizes(PowerPCCPU *cpu)
> >  {
> >  }
> > =20
> > -bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path)
> > -{
> > -    return true;
> > -}
> > -
> >  #endif /* !defined (TARGET_PPC64) */
> > =20
> >  unsigned long kvm_arch_vcpu_id(CPUState *cpu)
> > diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> > index a7ddb8a5d6..443fca0a4e 100644
> > --- a/target/ppc/kvm_ppc.h
> > +++ b/target/ppc/kvm_ppc.h
> > @@ -71,7 +71,6 @@ int kvmppc_resize_hpt_commit(PowerPCCPU *cpu, target_=
ulong flags, int shift);
> >  bool kvmppc_pvr_workaround_required(PowerPCCPU *cpu);
> > =20
> >  bool kvmppc_hpt_needs_host_contiguous_pages(void);
> > -bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path);
> > =20
> >  #else
> > =20
> > @@ -228,11 +227,6 @@ static inline bool kvmppc_hpt_needs_host_contiguou=
s_pages(void)
> >      return false;
> >  }
> > =20
> > -static inline bool kvmppc_is_mem_backend_page_size_ok(const char *obj_=
path)
> > -{
> > -    return true;
> > -}
> > -
> >  static inline bool kvmppc_has_cap_spapr_vfio(void)
> >  {
> >      return false;
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--YrQNB5Deg1WGKZi3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsrhq8ACgkQbDjKyiDZ
s5ImpA//W1C8J9fYcxxbieluSx5kLAYxa0unaSZAr2u4J+Znqx80kRdkzSxWlX2m
J4WaMuQCunZdUfzKkV98B9KeDCKA+2XkU2K5N+V0RRVQjBcbU1D29h7T073Ya9d9
Z6GyR/C+YLMI2DuEcL9ESxl9hJU63vHyeI5/li7CVZEQhTXdHFllXhYqHVOILWKv
LYxNuHOkohosyCu41Qn4AdgDqi7Jo48xyUWdf+KKqWMB6fTvr1G2iG57A7Stni9j
UmFtFx3JIIoTVo2U/zL5Q3fMPwvN1zYbpxl8EgBH0y9SuKecULZkPTNyHrwGn7Ud
x/cKnmtfpoTJ5s07TwzqsyymoTzXi0OZl+S97vcZeRVv5IARvJuQamZoXPl5Xiev
kMLQ4KNomXVsMPSF3v62pOqM2gESmHc/ykHA08w7IyzQuR4GPnUl+z/cPCOvIteg
5hPiAXJAS9eWYTQ6EAq2fLpB2Ja0iVfTudHwwDCRbZ+YL6QX+Ib2HyRVl4droNs3
oAqfPkO//1sZL4kDk/TQ4Dfayhp1x7XBs6VM1wamLmfvbullgrrZa6bl3aF1Guuh
fX7p5j34coni/HHrLpENmcgjEdjd3jpeQPcuVm7dsVKxLa03+aUlhEmaXDWPAwpj
q+/JQfo4ruuNz5HQZmrIXF1kWju1vEmQ8F5Hz2cd4+H25jx8WmY=
=LYle
-----END PGP SIGNATURE-----

--YrQNB5Deg1WGKZi3--
