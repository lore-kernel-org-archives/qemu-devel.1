Received: from eggs.gnu.org ([2001:4830:134:3::10]:37567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1djyXb-0003M9-RF
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 22:03:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1djyXY-0004Bf-27
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 22:03:39 -0400
Date: Tue, 22 Aug 2017 12:02:58 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170822020258.GX12356@umbus.fritz.box>
References: <20170821200036.15036-1-bauerman@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Zfao1/4IORAeFOVj"
Content-Disposition: inline
In-Reply-To: <20170821200036.15036-1-bauerman@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] spapr: Add ibm,
 processor-storage-keys property to CPU DT node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Ram Pai <linuxram@us.ibm.com>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>


--Zfao1/4IORAeFOVj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 21, 2017 at 05:00:36PM -0300, Thiago Jung Bauermann wrote:
> LoPAPR says:
>=20
>     =E2=80=9Cibm,processor-storage-keys=E2=80=9D
>=20
>     property name indicating the number of virtual storage keys supported
>     by the processor described by this node.
>=20
>     prop-encoded-array: Consists of two cells encoded as with encode-int.
>     The first cell represents the number of virtual storage keys supported
>     for data accesses while the second cell represents the number of
>     virtual storage keys supported for instruction accesses. The cell val=
ue
>     of zero indicates that no storage keys are supported for the access
>     type.
>=20
> pHyp provides the property above but there's a bug in P8 firmware where t=
he
> second cell is zero even though POWER8 supports instruction access keys.
> This bug will be fixed for P9.
>=20
> Tested with KVM on POWER8 Firenze machine and with TCG on x86_64 machine.
>=20
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>

Regardless of anything else, this clearly won't go in until 2.11 opens.



> ---
>=20
> The sysfs files are provided by this patch for Linux:
>=20
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2017-August/162005.html
>=20
> I realize that this patch can't be committed before the Linux one goes in,
> but I'd appreciate feedback so that it will be ready by the time the kern=
el
> side is accepted.
>=20
>  hw/ppc/spapr.c         | 76 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  include/hw/ppc/spapr.h |  6 ++++
>  2 files changed, 82 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index f7a19720dcdf..a665e4d830f7 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -605,6 +605,80 @@ static void spapr_populate_cpu_dt(CPUState *cs, void=
 *fdt, int offset,
>                            pcc->radix_page_info->count *
>                            sizeof(radix_AP_encodings[0]))));
>      }
> +
> +    if (spapr->storage_keys) {
> +        uint32_t val[2];
> +
> +        val[0] =3D cpu_to_be32(spapr->storage_keys);
> +        val[1] =3D spapr->insn_keys ? val[0] : 0;
> +
> +        _FDT(fdt_setprop(fdt, offset, "ibm,processor-storage-keys",
> +                         val, sizeof(val)));
> +    }
> +}
> +
> +#define SYSFS_PROT_KEYS_PATH "/sys/kernel/mm/protection_keys/"
> +#define SYSFS_USABLE_STORAGE_KEYS SYSFS_PROT_KEYS_PATH "usable_keys"
> +#define SYSFS_DISABLE_EXEC_KEYS SYSFS_PROT_KEYS_PATH "disable_execute_su=
pported"
> +
> +static void setup_storage_keys(CPUPPCState *env, sPAPRMachineState *spap=
r)
> +{
> +    if (!(env->mmu_model & POWERPC_MMU_AMR))
> +        return;
> +
> +    if (kvm_enabled()) {
> +        char buf[sizeof("false\n")];
> +        uint32_t keys;
> +        FILE *fd;

For starters, reasonably complex kvm-only code like this should go
into target/ppc/kvm.c.

But, there's a more fundamental problem.  Automatically adjusting
guest visible parameters based on the host's capabilities is really
problematic: if you migrate to a host with different capabilities
what's usable suddenly changes, but the guest can't know.

The usual way to deal with this is instead to have explicit machine
parameters to control the value, and check if those are possible on
the host.  It's then up to the user and/or management layer to set the
parameters suitable to allow migration between all machines that they
care about.


> +        /*
> +         * With KVM, we allow the guest to use the keys which the kernel=
 tells
> +         * us are available.
> +         */
> +
> +        fd =3D fopen(SYSFS_USABLE_STORAGE_KEYS, "r");
> +        if (!fd) {
> +            error_report("%s: open %s failed", __func__,
> +                         SYSFS_USABLE_STORAGE_KEYS);
> +            return;
> +        }
> +
> +        if (fscanf(fd, "%u", &keys) !=3D 1) {
> +            error_report("%s: error reading %s", __func__,
> +                         SYSFS_USABLE_STORAGE_KEYS);
> +            fclose(fd);
> +            return;
> +        }
> +
> +        fclose(fd);
> +
> +        /* Now find out whether the keys can be used for instruction acc=
ess. */
> +
> +        fd =3D fopen(SYSFS_DISABLE_EXEC_KEYS, "r");
> +        if (!fd) {
> +            error_report("%s: open %s failed", __func__,
> +                         SYSFS_USABLE_STORAGE_KEYS);
> +            return;
> +        }
> +
> +        if (!fread(buf, 1, sizeof(buf), fd)) {
> +            error_report("%s: error reading %s", __func__,
> +                         SYSFS_DISABLE_EXEC_KEYS);
> +            fclose(fd);
> +            return;
> +        }
> +
> +        fclose(fd);
> +
> +        spapr->storage_keys =3D keys;
> +        spapr->insn_keys =3D !strncmp(buf, "true\n", sizeof(buf));
> +    } else {
> +        /* Without KVM, all keys provided by the architecture are availa=
ble. */
> +        spapr->storage_keys =3D 32;
> +
> +        /* POWER7 doesn't support instruction access keys. */
> +        spapr->insn_keys =3D POWERPC_MMU_VER(env->mmu_model) !=3D POWERP=
C_MMU_VER_2_06;
> +    }
>  }
> =20
>  static void spapr_populate_cpus_dt_node(void *fdt, sPAPRMachineState *sp=
apr)
> @@ -619,6 +693,8 @@ static void spapr_populate_cpus_dt_node(void *fdt, sP=
APRMachineState *spapr)
>      _FDT((fdt_setprop_cell(fdt, cpus_offset, "#address-cells", 0x1)));
>      _FDT((fdt_setprop_cell(fdt, cpus_offset, "#size-cells", 0x0)));
> =20
> +    setup_storage_keys(&POWERPC_CPU(first_cpu)->env, spapr);
> +
>      /*
>       * We walk the CPUs in reverse order to ensure that CPU DT nodes
>       * created by fdt_add_subnode() end up in the right order in FDT
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 2a303a705c17..15af12010779 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -122,6 +122,12 @@ struct sPAPRMachineState {
>       * occurs during the unplug process. */
>      QTAILQ_HEAD(, sPAPRDIMMState) pending_dimm_unplugs;
> =20
> +    /* Number of processor storage keys available to the guest. */
> +    uint32_t storage_keys;
> +
> +    /* Whether storage keys can control instruction access. */
> +    bool insn_keys;
> +
>      /*< public >*/
>      char *kvm_type;
>      MemoryHotplugState hotplug_memory;
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Zfao1/4IORAeFOVj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmbkNAACgkQbDjKyiDZ
s5LlQBAAlCZ3f1jAKM8bTEbnzr3DfJQxON33DuU6y6CMCsR7JNUxGkVh/lG/frkM
xiatnMyC+Rs5FXv1yvvDUNYh3HmiSdmek5/UGlARsTfwpHeoRZYRgY06nkSac5JL
BEf5itFPwn5KSLDfJ5aV2arxD6mlJYomGMsdwZX6c5ly5Q1Yl2VXE0F8ZclnGW4m
zNbvnpQXGLlTRFOkL1bM1FhP8qnqS/fVW483sceCMFOd5Lb062QDwlHGIv3/+NUd
bPw/vdcdaoZ/a/xVVM4cJ8/GKo+8jBUEOMeBZ5Z7hV/eM9sveAsKyJwm2NFQfQTv
Vw+HG6AG8x6LLK73D9L0/cVWG4dKuonzkhp6DPCwMulsd7KZ296CeU7AHiE4/ZfH
OOITAocDuxMjBrAKLKKWqy1QySGG2XuYT4KOVaTEp/FJxud9yY7RUTOuTRVNBPFp
LKR721qdfNjX9nZ0G7pZ9WrGEvj6iCMX5Bv8uJOn+GotbXwthtSSoNZjjT+A92iJ
k0IrBhKq0s0FhlDEuI8IZQdkxpLtbIf7osntURuZ4z7O6OBcnyNWRwIkV3xgfQDM
wSV8UnjtvZvyMN4HEw/miKvczRCAGxvQ6hgb3zLBhAhHozeL8BZZaM8E/5J/DaY8
WhiMUNcEpDvX1NjXuQ5pvNdRr9nhx/mcD4jFjnmIEXyL89tcT1s=
=vn1o
-----END PGP SIGNATURE-----

--Zfao1/4IORAeFOVj--
