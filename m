Received: from eggs.gnu.org ([2001:4830:134:3::10]:46771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cbepq-0007ch-3v
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 21:51:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cbepo-0006zF-B6
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 21:51:50 -0500
Date: Thu, 9 Feb 2017 13:42:45 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170209024245.GV17644@umbus.fritz.box>
References: <cover.1486436185.git.sam.bobroff@au1.ibm.com>
	<0d06b1c772cf35947e9f095202ab4ca2a50aaf76.1486436186.git.sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dIV3CY5swYZsO92m"
Content-Disposition: inline
In-Reply-To: <0d06b1c772cf35947e9f095202ab4ca2a50aaf76.1486436186.git.sam.bobroff@au1.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH 8/9] spapr: Advertise ISA 3.0 MMU
 features in pa_features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--dIV3CY5swYZsO92m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 07, 2017 at 01:56:51PM +1100, Sam Bobroff wrote:
> Set the default ibm,pa_features bits for ISA 3.0.
>=20
> Providing the radix MMU support bit in ibm,pa-features will cause some
> recent (e.g. 4.9) kernels to attempt to initialize the MMU as if they
> were a radix host, which will cause them to crash. So, if a guest
> performs a client architecture support call without indicating ISA
> 3.00 support (specifically, if they do not indicate that they support
> either new radix or new hash mode) then the radix bit is removed from
> ibm,pa-features to avoid triggering the bug.
>=20
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
> ---
>  hw/ppc/spapr.c         | 125 +++++++++++++++++++++++++++++++------------=
------
>  hw/ppc/spapr_hcall.c   |   4 +-
>  include/hw/ppc/spapr.h |   1 +
>  3 files changed, 83 insertions(+), 47 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index c6a3a638cd..325a9c587b 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -194,6 +194,76 @@ static int spapr_fixup_cpu_numa_dt(void *fdt, int of=
fset, CPUState *cs)
>      return ret;
>  }
> =20
> +/* Populate the "ibm,pa-features" property */
> +static int spapr_populate_pa_features(CPUPPCState *env, void *fdt, int o=
ffset,
> +                                      bool legacy_guest)
> +{
> +    uint8_t pa_features_206[] =3D { 6, 0,
> +        0xf6, 0x1f, 0xc7, 0x00, 0x80, 0xc0 };
> +    uint8_t pa_features_207[] =3D { 24, 0,
> +        0xf6, 0x1f, 0xc7, 0xc0, 0x80, 0xf0,
> +        0x80, 0x00, 0x00, 0x00, 0x00, 0x00,
> +        0x00, 0x00, 0x00, 0x00, 0x80, 0x00,
> +        0x80, 0x00, 0x80, 0x00, 0x00, 0x00 };
> +    uint8_t pa_features_300[70 + 2] =3D { 70, 0,
> +        0xf6, 0x3f, 0xc7, 0xc0, 0x80, 0xf0, /* 0 - 5 */
> +        0x80, 0x00, 0x00, 0x00, 0x00, 0x00, /* 6 - 11 */
> +        0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 12 - 17 */
> +        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 18 - 23 */
> +        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 24 - 29 */
> +        0x80, 0x00, 0x80, 0x00, 0xC0, 0x00, /* 30 - 35 */
> +        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 36 - 41 */
> +        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 42 - 47 */
> +        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 48 - 53 */
> +        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 54 - 59 */
> +        0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 60 - 64 */
> +        0x00, 0x00, 0x00, 0x00,             /* 66 - 69 */
> +        };
> +    uint8_t *pa_features;
> +    size_t pa_size;
> +
> +    switch (env->mmu_model) {
> +    case POWERPC_MMU_2_06:
> +    case POWERPC_MMU_2_06a:
> +        pa_features =3D pa_features_206;
> +        pa_size =3D sizeof(pa_features_206);
> +        break;
> +    case POWERPC_MMU_2_07:
> +    case POWERPC_MMU_2_07a:
> +        pa_features =3D pa_features_207;
> +        pa_size =3D sizeof(pa_features_207);
> +        break;
> +    case POWERPC_MMU_3_00:
> +        pa_features =3D pa_features_300;
> +        pa_size =3D sizeof(pa_features_300);
> +        break;
> +    default:
> +        return 0; /* TODO, this is actually an error! */
> +    }
> +
> +    if (env->ci_large_pages) {
> +        /*
> +         * Note: we keep CI large pages off by default because a 64K cap=
able
> +         * guest provisioned with large pages might otherwise try to map=
 a qemu
> +         * framebuffer (or other kind of memory mapped PCI BAR) using 64=
K pages
> +         * even if that qemu runs on a 4k host.
> +         * We dd this bit back here if we are confident this is not an i=
ssue
> +         */
> +        pa_features[3] |=3D 0x20;
> +    }
> +    if (kvmppc_has_cap_htm() && pa_size > 24) {
> +        pa_features[24] |=3D 0x80;    /* Transactional memory support */
> +    }
> +    if (legacy_guest && pa_size > 40) {
> +        /* Workaround for broken kernels that attempt (guest) radix
> +         * mode when they can't handle it, if they see the radix bit set
> +         * in pa-features. So hide it from them. */
> +        pa_features[40 + 2] &=3D ~0x80; /* Radix MMU */
> +    }
> +
> +    return fdt_setprop(fdt, offset, "ibm,pa-features", pa_features, pa_s=
ize);
> +}
> +
>  static int spapr_fixup_cpu_dt(void *fdt, sPAPRMachineState *spapr)
>  {
>      int ret =3D 0, offset, cpus_offset;
> @@ -204,6 +274,7 @@ static int spapr_fixup_cpu_dt(void *fdt, sPAPRMachine=
State *spapr)
> =20
>      CPU_FOREACH(cs) {
>          PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +        CPUPPCState *env =3D &cpu->env;
>          DeviceClass *dc =3D DEVICE_GET_CLASS(cs);
>          int index =3D ppc_get_vcpu_dt_id(cpu);
> =20
> @@ -245,6 +316,12 @@ static int spapr_fixup_cpu_dt(void *fdt, sPAPRMachin=
eState *spapr)
>          if (ret < 0) {
>              return ret;
>          }
> +
> +        ret =3D spapr_populate_pa_features(env, fdt, offset,
> +                                         spapr->cas_legacy_guest_workaro=
und);
> +        if (ret < 0) {
> +            return ret;
> +        }
>      }
>      return ret;
>  }
> @@ -346,51 +423,6 @@ static int spapr_populate_memory(sPAPRMachineState *=
spapr, void *fdt)
>      return 0;
>  }
> =20
> -/* Populate the "ibm,pa-features" property */
> -static void spapr_populate_pa_features(CPUPPCState *env, void *fdt, int =
offset)
> -{
> -    uint8_t pa_features_206[] =3D { 6, 0,
> -        0xf6, 0x1f, 0xc7, 0x00, 0x80, 0xc0 };
> -    uint8_t pa_features_207[] =3D { 24, 0,
> -        0xf6, 0x1f, 0xc7, 0xc0, 0x80, 0xf0,
> -        0x80, 0x00, 0x00, 0x00, 0x00, 0x00,
> -        0x00, 0x00, 0x00, 0x00, 0x80, 0x00,
> -        0x80, 0x00, 0x80, 0x00, 0x00, 0x00 };
> -    uint8_t *pa_features;
> -    size_t pa_size;
> -
> -    switch (env->mmu_model) {
> -    case POWERPC_MMU_2_06:
> -    case POWERPC_MMU_2_06a:
> -        pa_features =3D pa_features_206;
> -        pa_size =3D sizeof(pa_features_206);
> -        break;
> -    case POWERPC_MMU_2_07:
> -    case POWERPC_MMU_2_07a:
> -        pa_features =3D pa_features_207;
> -        pa_size =3D sizeof(pa_features_207);
> -        break;
> -    default:
> -        return;
> -    }
> -
> -    if (env->ci_large_pages) {
> -        /*
> -         * Note: we keep CI large pages off by default because a 64K cap=
able
> -         * guest provisioned with large pages might otherwise try to map=
 a qemu
> -         * framebuffer (or other kind of memory mapped PCI BAR) using 64=
K pages
> -         * even if that qemu runs on a 4k host.
> -         * We dd this bit back here if we are confident this is not an i=
ssue
> -         */
> -        pa_features[3] |=3D 0x20;
> -    }
> -    if (kvmppc_has_cap_htm() && pa_size > 24) {
> -        pa_features[24] |=3D 0x80;    /* Transactional memory support */
> -    }
> -
> -    _FDT((fdt_setprop(fdt, offset, "ibm,pa-features", pa_features, pa_si=
ze)));
> -}
> -
>  static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offset,
>                                    sPAPRMachineState *spapr)
>  {
> @@ -484,7 +516,7 @@ static void spapr_populate_cpu_dt(CPUState *cs, void =
*fdt, int offset,
>                            page_sizes_prop, page_sizes_prop_size)));
>      }
> =20
> -    spapr_populate_pa_features(env, fdt, offset);
> +    _FDT(spapr_populate_pa_features(env, fdt, offset, false));
> =20
>      _FDT((fdt_setprop_cell(fdt, offset, "ibm,chip-id",
>                             cs->cpu_index / vcpus_per_socket)));
> @@ -1870,6 +1902,7 @@ static void ppc_spapr_init(MachineState *machine)
>      }
>      spapr_ovec_set(spapr->ov5, OV5_SEG_HCALL);
>      spapr_ovec_set(spapr->ov5, OV5_SHOOTDOWN);
> +    spapr_ovec_set(spapr->ov5, OV5_SEG_HCALL);

Dup'ed line above.

> =20
>      /* advertise support for dedicated HP event source to guests */
>      if (spapr->use_hotplug_event_source) {
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 4de511c386..d04f696e65 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -999,7 +999,7 @@ static target_ulong h_client_architecture_support(Pow=
erPCCPU *cpu_,
>          }
>      }
> =20
> -    if (!cpu_version) {
> +    if (!cpu_version  && !spapr->cas_legacy_guest_workaround) {
>          cpu_update =3D false;
>      }
> =20
> @@ -1033,6 +1033,8 @@ static target_ulong h_client_architecture_support(P=
owerPCCPU *cpu_,
>                                          ov5_cas_old, spapr->ov5_cas);
>      spapr_ovec_stderr("update", 16, ov5_updates);
>      fprintf(stderr, "Old CAS reboot flag: %d\n", spapr->cas_reboot);
> +    spapr->cas_legacy_guest_workaround =3D !spapr_ovec_test(ov5_updates,=
 OV5_MMU_RADIX) &&
> +                                         !spapr_ovec_test(ov5_updates, O=
V5_MMU_HASH);

This is a little bit icky, since cas_legacy_guest_workaround isn't
explicitly reset when you have a non-CAS reboot.  In practice it will
probably work, because it is reset on every CAS, but it does mean that
the pre-CAS value can depend on the previous guest booted which is
conceptually incorrect.

I think it would be preferable to determine whether you have a legacy
guest at the point you need it, directly from spapr->ov5_cas.  The CAS
core already manages resets of that correctly across both CAS and
non-CAS reboots.


>      if (!spapr->cas_reboot) {
>          spapr->cas_reboot =3D
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 92bda0f36d..974338d1df 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -77,6 +77,7 @@ struct sPAPRMachineState {
>      sPAPROptionVector *ov5;         /* QEMU-supported option vectors */
>      sPAPROptionVector *ov5_cas;     /* negotiated (via CAS) option vecto=
rs */
>      bool cas_reboot;
> +    bool cas_legacy_guest_workaround;
> =20
>      Notifier epow_notifier;
>      QTAILQ_HEAD(, sPAPREventLogEntry) pending_events;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dIV3CY5swYZsO92m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYm9clAAoJEGw4ysog2bOS9YUP/RRfHjwdi+psPWlyrg1cn2m+
07J30SfIQsuWpyK2t4s44STCGTPF6BsLDxqCeD7tVFhcAQ+Ptg8JxPC5dL2x2Hbb
BS2VFsa5y8F/O8sVKfFgm3I8g41gTrMr/P8nQ1Z6SJuSub4JyHcDvPOHl/mjxnpT
g4rrPHSJ0h8aUQhTODlYyPsmcJvv8anz+khzTHPxddEXWkFBDRWQLl43OqcFGDcZ
CkfWztWR9XwhJ1IgpCEWpNVhT/2Xjrwl1QjE5iChX8raI/ZXX20GKC8YRm/c5mYs
asX4lN42aHXwMjGKiprDSrCoApjeEAFBRA0BQnSzq502TTpRnX7LAk0TnEoGvlm5
oY0QsoBMGGUB5YI2+IHLoShDSJws6F3i6oEHu+ybWxJPATIWbB3LfjbbANVSw/S/
UTnui3mNOy7M9+ESmLVYCme6s9xHqd65HcwGdPilvOeXITY+KbfX9xrxbTMR6TnH
MTmcWZMkSwpc+3avkcOLq0tZVsKnSYqe4oPjX1TyNM262hRsJvva8ox9QrDMcmQW
/DSjzRZYlIYRf8XTuU3AKqljh3Unk1UJFrmnKNBkJWf1pmhM57KxRWEQ3Svjd8zy
CGBXPZJKRDnyHppu5xnOnEbnuwTi67auxyt2LYhBUVepS4buNlbJALJSAQuOSfFY
eAq3sHfZgNQxsaBJo9WL
=pMcZ
-----END PGP SIGNATURE-----

--dIV3CY5swYZsO92m--
