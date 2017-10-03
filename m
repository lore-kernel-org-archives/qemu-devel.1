Received: from eggs.gnu.org ([2001:4830:134:3::10]:42530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dzJOv-00016t-VA
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 05:22:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dzJOr-0006X6-AE
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 05:22:05 -0400
Date: Tue, 3 Oct 2017 20:21:51 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171003092151.GM3260@umbus.fritz.box>
References: <20171003051701.17721-1-aik@ozlabs.ru>
	<20171003064025.GK3260@umbus.fritz.box>
	<5c423fec-f247-015e-1c7a-5eefec584fc0@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1rguoi8KZGYj2k4L"
Content-Disposition: inline
In-Reply-To: <5c423fec-f247-015e-1c7a-5eefec584fc0@ozlabs.ru>
Subject: Re: [Qemu-devel] [RFC PATCH qemu v2] ppc/spapr: Receive and store
 device tree blob from SLOF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Aravinda Prasad <aravinda@linux.vnet.ibm.com>, Balbir Singh <bsingharora@gmail.com>


--1rguoi8KZGYj2k4L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 03, 2017 at 07:48:27PM +1100, Alexey Kardashevskiy wrote:
> On 03/10/17 17:40, David Gibson wrote:
> > On Tue, Oct 03, 2017 at 04:17:01PM +1100, Alexey Kardashevskiy wrote:
> >> SLOF receives a device tree and updates it with various properties
> >> before switching to the guest kernel and QEMU is not aware of any chan=
ges
> >> made by SLOF. Since there is no real RTAS and QEMU implements it,
> >> it makes sense to pass the SLOF device tree to QEMU so the latter could
> >> implement RTAS related tasks better.
> >>
> >> Specifially, now QEMU can find out the actual XICS phandle (for PHB
> >> hotplug) and the RTAS linux,rtas-entry/base properties (for firmware
> >> assisted NMI - FWNMI).
> >>
> >> This stores the initial DT blob in the sPAPR machine and replaces it
> >> in the KVMPPC_H_UPDATE_DT (new private hypercall) handler.
> >>
> >> This implements a very basic validity check of the new blob - magic and
> >> size are checked; the new blob size should not increase more than twic=
e.
> >>
> >> This requires SLOF update: "fdt: Pass the resulting device tree to QEM=
U".
> >>
> >> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >> ---
> >>
> >> I could store just a size of the QEMU's blob, or a tree, not sure
> >> which one makes more sense here.
> >>
> >> This allows up to 2 times blob increase. Not 1.5 just to avoid
> >> float/double, just looks a bit ugly imho.
> >> ---
> >>  include/hw/ppc/spapr.h |  4 +++-
> >>  hw/ppc/spapr.c         |  4 +++-
> >>  hw/ppc/spapr_hcall.c   | 33 +++++++++++++++++++++++++++++++++
> >>  hw/ppc/trace-events    |  2 ++
> >>  4 files changed, 41 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> >> index a805b817a5..09f3a54dc2 100644
> >> --- a/include/hw/ppc/spapr.h
> >> +++ b/include/hw/ppc/spapr.h
> >> @@ -92,6 +92,7 @@ struct sPAPRMachineState {
> >>      int vrma_adjust;
> >>      ssize_t rtas_size;
> >>      void *rtas_blob;
> >> +    void *fdt_blob;
> >>      long kernel_size;
> >>      bool kernel_le;
> >>      uint32_t initrd_base;
> >> @@ -400,7 +401,8 @@ struct sPAPRMachineState {
> >>  #define KVMPPC_H_LOGICAL_MEMOP  (KVMPPC_HCALL_BASE + 0x1)
> >>  /* Client Architecture support */
> >>  #define KVMPPC_H_CAS            (KVMPPC_HCALL_BASE + 0x2)
> >> -#define KVMPPC_HCALL_MAX        KVMPPC_H_CAS
> >> +#define KVMPPC_H_UPDATE_DT      (KVMPPC_HCALL_BASE + 0x3)
> >> +#define KVMPPC_HCALL_MAX        KVMPPC_H_UPDATE_DT
> >> =20
> >>  typedef struct sPAPRDeviceTreeUpdateHeader {
> >>      uint32_t version_id;
> >> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >> index 17ea77618c..b471f7e1ff 100644
> >> --- a/hw/ppc/spapr.c
> >> +++ b/hw/ppc/spapr.c
> >> @@ -1453,7 +1453,9 @@ static void ppc_spapr_reset(void)
> >>      /* Load the fdt */
> >>      qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
> >>      cpu_physical_memory_write(fdt_addr, fdt, fdt_totalsize(fdt));
> >> -    g_free(fdt);
> >> +    g_free(spapr->fdt_blob);
> >> +    spapr->fdt_blob =3D fdt;
> >> +    spapr->fdt_size =3D fdt_totalsize(fdt);
> >> =20
> >>      /* Set up the entry state */
> >>      first_ppc_cpu =3D POWERPC_CPU(first_cpu);
> >> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> >> index 57bb411394..a11831d3b2 100644
> >> --- a/hw/ppc/spapr_hcall.c
> >> +++ b/hw/ppc/spapr_hcall.c
> >> @@ -1635,6 +1635,37 @@ static target_ulong h_client_architecture_suppo=
rt(PowerPCCPU *cpu,
> >>      return H_SUCCESS;
> >>  }
> >> =20
> >> +static target_ulong h_update_dt(PowerPCCPU *cpu, sPAPRMachineState *s=
papr,
> >> +                                target_ulong opcode, target_ulong *ar=
gs)
> >> +{
> >> +    target_ulong dt =3D ppc64_phys_to_real(args[0]);
> >> +    struct fdt_header hdr =3D { 0 };
> >> +    unsigned cb, magic, old_cb =3D fdt_totalsize(spapr->fdt_blob);
> >> +
> >> +    cpu_physical_memory_read(dt, &hdr, sizeof(hdr));
> >> +    cb =3D fdt32_to_cpu(hdr.totalsize);
> >> +    magic =3D fdt32_to_cpu(hdr.magic);
> >> +    if (magic !=3D FDT_MAGIC || cb / old_cb > 2) {
> >=20
> > Uh.. no.  This prevents the guest from gobbling arbitrary amounts of
> > qemu RAM _in one go_, but it can still call h_update_dt arbitrarily
> > often, doubling the amount of memory consumed each time.
> >=20
> > You need to compare the updated DT size with the _original_ DT size,
> > not just the last DT size.
>=20
>=20
> Ah, right. Does it still make sense to store the original DT in the
> machine?

I think so.  Doing so will probably make the fallback easier where we
use the original tree we gave to the guest, if h_update_dt was never
called.

> >> +        trace_spapr_update_dt_failed(old_cb, cb, magic);
> >> +        return H_PARAMETER;
> >> +    }
> >=20
> > Still needs more sanity checks here.  At least check version and that
> > each of the sub-blocks fits correctly within totalsize.
> >=20
> > Maybe I should add an fdt_fsck() function to libfdt, hmm...
>=20
>=20
> ookay, I just assumed libfdt checks for subblock sizes.

Well.. it does.  Or at least should.  But for something so basic, I'd
prefer to check it up front, rather than only catch it when we try to
actually try to look something up in the tree.

For one thing it's safer in case there _is_ a bug in libfdt.  But even
if there's not, I expect it's going to be a lot easier to debug if we
get an error at the time of h_update_dt, rather than stashing away of
blob of garbage and only finding out when we attempt a phb hotplug.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--1rguoi8KZGYj2k4L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnTVq0ACgkQbDjKyiDZ
s5JmTxAAm5uEZM/yKmYw+ImpLaAfs1Adf118oQwnztZ9Lw7sjYbnwI5dzyUXeRqQ
22wPs0Sj76/TvRVykv434mZ+9EEuBQizUgu444r7Bipqnvzd1RbKnYuqdqFZ0L6I
qLypK8rZqj9kSOvJDpDYTZkXqOIUaJWAkTA3e8ui14DxN7+u8gf+GHQ6Yae6KFhe
JZDTWP+yyTN5eZl5u4htgKSO5USnH8+4qjkC9ODLkFxwKRWpfJ1aazC/K57rP30c
59aEEO+pFDSeYHzy3p9Z9mOtE8GHwfDC8pA4vdlITXms34pk8cSJNFKWYzUjut2x
mtZfZGs+FNWuEYf+GHJqkv6qCgMEkRNCSX3QOF/COOyDdJ9iZmpQwOcwV/Sr9JkG
JYrjKYcv7Lrgwd1wALXShjZgTOMGG/PTP0LkPIlOwxVGNRzeqQxSwTBGl9QIizh+
MrCOPB6DWZRKVSEw0I41wTb82Py7cDnlAIe5HMo41gdufZidLz9rSgf3sS0uWwzV
nMVNM8+aJlMb9cy8nndsE0i0ntwmg/vCBLtv5falZ4M4HjsVIzmpUvYGgagE8P0Y
ptcIOAwxBW8tYLnXQfy9Hlq9BwainJojOVNOHJGWErJXuqe+CWthtwUuaQVgbvKE
4VPXwkVRIma+LNSefgW3rTZoQC/J/KImJn5x04y3FjxVlgYaqB0=
=xjyS
-----END PGP SIGNATURE-----

--1rguoi8KZGYj2k4L--
