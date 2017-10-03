Received: from eggs.gnu.org ([2001:4830:134:3::10]:57476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dzGsk-0003xe-66
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 02:40:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dzGsg-0002fk-CH
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 02:40:42 -0400
Date: Tue, 3 Oct 2017 17:40:25 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171003064025.GK3260@umbus.fritz.box>
References: <20171003051701.17721-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Z9t8O/5YJLB6LEUl"
Content-Disposition: inline
In-Reply-To: <20171003051701.17721-1-aik@ozlabs.ru>
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


--Z9t8O/5YJLB6LEUl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 03, 2017 at 04:17:01PM +1100, Alexey Kardashevskiy wrote:
> SLOF receives a device tree and updates it with various properties
> before switching to the guest kernel and QEMU is not aware of any changes
> made by SLOF. Since there is no real RTAS and QEMU implements it,
> it makes sense to pass the SLOF device tree to QEMU so the latter could
> implement RTAS related tasks better.
>=20
> Specifially, now QEMU can find out the actual XICS phandle (for PHB
> hotplug) and the RTAS linux,rtas-entry/base properties (for firmware
> assisted NMI - FWNMI).
>=20
> This stores the initial DT blob in the sPAPR machine and replaces it
> in the KVMPPC_H_UPDATE_DT (new private hypercall) handler.
>=20
> This implements a very basic validity check of the new blob - magic and
> size are checked; the new blob size should not increase more than twice.
>=20
> This requires SLOF update: "fdt: Pass the resulting device tree to QEMU".
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>=20
> I could store just a size of the QEMU's blob, or a tree, not sure
> which one makes more sense here.
>=20
> This allows up to 2 times blob increase. Not 1.5 just to avoid
> float/double, just looks a bit ugly imho.
> ---
>  include/hw/ppc/spapr.h |  4 +++-
>  hw/ppc/spapr.c         |  4 +++-
>  hw/ppc/spapr_hcall.c   | 33 +++++++++++++++++++++++++++++++++
>  hw/ppc/trace-events    |  2 ++
>  4 files changed, 41 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index a805b817a5..09f3a54dc2 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -92,6 +92,7 @@ struct sPAPRMachineState {
>      int vrma_adjust;
>      ssize_t rtas_size;
>      void *rtas_blob;
> +    void *fdt_blob;
>      long kernel_size;
>      bool kernel_le;
>      uint32_t initrd_base;
> @@ -400,7 +401,8 @@ struct sPAPRMachineState {
>  #define KVMPPC_H_LOGICAL_MEMOP  (KVMPPC_HCALL_BASE + 0x1)
>  /* Client Architecture support */
>  #define KVMPPC_H_CAS            (KVMPPC_HCALL_BASE + 0x2)
> -#define KVMPPC_HCALL_MAX        KVMPPC_H_CAS
> +#define KVMPPC_H_UPDATE_DT      (KVMPPC_HCALL_BASE + 0x3)
> +#define KVMPPC_HCALL_MAX        KVMPPC_H_UPDATE_DT
> =20
>  typedef struct sPAPRDeviceTreeUpdateHeader {
>      uint32_t version_id;
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 17ea77618c..b471f7e1ff 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1453,7 +1453,9 @@ static void ppc_spapr_reset(void)
>      /* Load the fdt */
>      qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
>      cpu_physical_memory_write(fdt_addr, fdt, fdt_totalsize(fdt));
> -    g_free(fdt);
> +    g_free(spapr->fdt_blob);
> +    spapr->fdt_blob =3D fdt;
> +    spapr->fdt_size =3D fdt_totalsize(fdt);
> =20
>      /* Set up the entry state */
>      first_ppc_cpu =3D POWERPC_CPU(first_cpu);
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 57bb411394..a11831d3b2 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1635,6 +1635,37 @@ static target_ulong h_client_architecture_support(=
PowerPCCPU *cpu,
>      return H_SUCCESS;
>  }
> =20
> +static target_ulong h_update_dt(PowerPCCPU *cpu, sPAPRMachineState *spap=
r,
> +                                target_ulong opcode, target_ulong *args)
> +{
> +    target_ulong dt =3D ppc64_phys_to_real(args[0]);
> +    struct fdt_header hdr =3D { 0 };
> +    unsigned cb, magic, old_cb =3D fdt_totalsize(spapr->fdt_blob);
> +
> +    cpu_physical_memory_read(dt, &hdr, sizeof(hdr));
> +    cb =3D fdt32_to_cpu(hdr.totalsize);
> +    magic =3D fdt32_to_cpu(hdr.magic);
> +    if (magic !=3D FDT_MAGIC || cb / old_cb > 2) {

Uh.. no.  This prevents the guest from gobbling arbitrary amounts of
qemu RAM _in one go_, but it can still call h_update_dt arbitrarily
often, doubling the amount of memory consumed each time.

You need to compare the updated DT size with the _original_ DT size,
not just the last DT size.

> +        trace_spapr_update_dt_failed(old_cb, cb, magic);
> +        return H_PARAMETER;
> +    }

Still needs more sanity checks here.  At least check version and that
each of the sub-blocks fits correctly within totalsize.

Maybe I should add an fdt_fsck() function to libfdt, hmm...

> +
> +    g_free(spapr->fdt_blob);
> +    spapr->fdt_blob =3D g_malloc0(cb);
> +    cpu_physical_memory_read(dt, spapr->fdt_blob, cb);
> +
> +#ifdef DEBUG
> +    {
> +        FILE *f =3D fopen("dbg.dtb", "wb");
> +        fwrite(spapr->fdt_blob, cb, 1, f);
> +        fclose(f);
> +    }
> +#endif
> +    trace_spapr_update_dt(cb);
> +
> +    return H_SUCCESS;
> +}
> +
>  static spapr_hcall_fn papr_hypercall_table[(MAX_HCALL_OPCODE / 4) + 1];
>  static spapr_hcall_fn kvmppc_hypercall_table[KVMPPC_HCALL_MAX - KVMPPC_H=
CALL_BASE + 1];
> =20
> @@ -1732,6 +1763,8 @@ static void hypercall_register_types(void)
> =20
>      /* ibm,client-architecture-support support */
>      spapr_register_hypercall(KVMPPC_H_CAS, h_client_architecture_support=
);
> +
> +    spapr_register_hypercall(KVMPPC_H_UPDATE_DT, h_update_dt);
>  }
> =20
>  type_init(hypercall_register_types)
> diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
> index 4a6a6490fa..60ee4e3a4b 100644
> --- a/hw/ppc/trace-events
> +++ b/hw/ppc/trace-events
> @@ -18,6 +18,8 @@ spapr_cas_pvr_try(uint32_t pvr) "0x%x"
>  spapr_cas_pvr(uint32_t cur_pvr, bool explicit_match, uint32_t new_pvr) "=
current=3D0x%x, explicit_match=3D%u, new=3D0x%x"
>  spapr_h_resize_hpt_prepare(uint64_t flags, uint64_t shift) "flags=3D0x%"=
PRIx64", shift=3D%"PRIu64
>  spapr_h_resize_hpt_commit(uint64_t flags, uint64_t shift) "flags=3D0x%"P=
RIx64", shift=3D%"PRIu64
> +spapr_update_dt(unsigned cb) "New blob %u bytes"
> +spapr_update_dt_failed(unsigned cbold, unsigned cbnew, unsigned magic) "=
Old blob %u bytes, new blob %u bytes, magic 0x%x"
> =20
>  # hw/ppc/spapr_iommu.c
>  spapr_iommu_put(uint64_t liobn, uint64_t ioba, uint64_t tce, uint64_t re=
t) "liobn=3D0x%"PRIx64" ioba=3D0x%"PRIx64" tce=3D0x%"PRIx64" ret=3D%"PRId64

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Z9t8O/5YJLB6LEUl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnTMNcACgkQbDjKyiDZ
s5JCKA/9Hyh+p5WYkm34a0blDQVeYmOkHnxDxrM7xHa985LSTQdT8/dLITUMkWH2
aZm14uCOettXBfVy7NgFdus83eHHL4o1LqZL+59sQBXSgYJ2SPz881aq8Q5VXqF/
kBuZ2Zdui1LDqXQSWjoMJp8hGRd8hqjHP1+/Xae/bWRl8vTb/X4AybeoDg/oPpAp
dBeBH138eyHN/WNL53MZukeAdHdCxa12/KZQtJNyTSNSL1Ur7pEjsD/xH2hLKlln
3/1BLSIa+IwUaQljdJHULAPI3KfZgiLiyyfyRJbkKHHIsCNeiMRU03+2E4i4S/IB
Sbm5ZsJqoLHTUGtAHjr5QKztltlhfGAi8SESwAvs/WmTVwNXl4vxVH1isfz2XbAZ
YEKtvQtgLafHB8TBqa3xkbnNgJfQiuFRwpf8KtERy6tB0eKYDj6nvAkL1Jo4gnHo
w7wT/TZVvnVkgOzhHA7so7eMKHj1lF/bHvD9TVLy2RtH5idKUh3dubkshgRKge3p
apNqB9qiygf3Gz4oUvr3mzQ/sRYoNCp8Z2AtvO0E/5oYBqv7d51MQlc0nCWAGDNh
MvC0j2vK/CIcO3NEon6usaK2LD+LWiXFHmvFg5x5YTBhaIOklPs97N3dJIwJ1MkT
j3Ok6cSxL+5FFLFsFviAjkdNQRuTRUSl47jznpwpnCuPalg6SM4=
=I+ue
-----END PGP SIGNATURE-----

--Z9t8O/5YJLB6LEUl--
