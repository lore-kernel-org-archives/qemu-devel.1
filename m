Received: from eggs.gnu.org ([2001:4830:134:3::10]:38309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fVxm0-0002op-HD
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 07:29:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fVxlz-0008Fm-5U
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 07:29:08 -0400
Date: Thu, 21 Jun 2018 21:11:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180621111117.GJ32328@umbus.fritz.box>
References: <20180618063606.2513-1-david@gibson.dropbear.id.au>
	<20180618063606.2513-7-david@gibson.dropbear.id.au>
	<20180621122914.6d918b54@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yhze8HlyfmXt1APY"
Content-Disposition: inline
In-Reply-To: <20180621122914.6d918b54@bahia.lan>
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
To: Greg Kurz <groug@kaod.org>
Cc: abologna@redhat.com, clg@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, aik@ozlabs.ru


--yhze8HlyfmXt1APY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 21, 2018 at 12:29:14PM +0200, Greg Kurz wrote:
> On Mon, 18 Jun 2018 16:36:03 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
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
> s/SPAPR_CAP_HPT_MPS/SPAPR_CAP_HPT_MAXPAGESIZE

Fixed.

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
>=20
> Even if in this precise case QEMU will always exit gracefully since
> errp =3D=3D &error_fatal, passing errp several times is a fragile pattern.
> It may cause a crash if *errp was already allocated.
>=20
> Maybe use a local_err variable and error_propagate() or at least return
> in the (val < 12) block above.

Actually, just a return; after the first error should be sufficient.
I've put that in.

>=20
> Rest looks good. With the two issues addressed:
>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>
>=20
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
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--yhze8HlyfmXt1APY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsrh9UACgkQbDjKyiDZ
s5Je6w/+PbY8dfTR+xqf623k9psYgitDXY7cbK9FPzy16lxGY8jQ9a16H+l2iVwK
905G6jHZEbEH5+4jQ3pQcOaBdu3r6FSFUizH0ga/qGaCeYhSBQVxrVm7vEiyoy//
CDxX9QF7UcsIEwIK4zG7ntWRpUf0neCcgcQtq0Ui58E9zfal3Rd0l1//NCIkbvXQ
1ynaGQhH8vBIbbQs5CrT0rdNwiOz5FDvLOKl3GJSdObCWoPIbj2oc4e+sVfHYDEH
imaxP7raAH5XIVwUXC01GPzRlwYMZZ9/r1CbDjTVNkF56jijhNAWXEc0ZFOxFxCS
jtKwNo6+DAQg6w6niSHXjjrPpvW1GIIh67oPStTuDr+3ww+Q0mJn1cSpOev1ArqT
zx4mkmxO5sy34y+4RqtXr9EmJhtzVkmNfZ4QfBOYfehELvT9ZmeGofVdKWzcbEew
+VfImCfDLf5VzeJUNzOrTOVtxQzGcVIGN40XV3wOXRC2fqHwGC1arUoA4ZIZ2yuh
dy8Su2uBBhbJTGiVJ/GqOoa422G6Td0AdW1yRkSkLwU5T1GjUGqjBFP8CkheCTJh
mwurKm3sN8DS0Tqf4iTcCRni0d1gqcItk8G8E1IUFuv6j45y6i314jwRZiWqq1fs
R7f2EUM2/68fGdH6/NT8ApjfL7fiegAYaZpBL2cvr45uTp5FfFo=
=Cw+S
-----END PGP SIGNATURE-----

--yhze8HlyfmXt1APY--
