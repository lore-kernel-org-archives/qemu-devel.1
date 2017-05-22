Received: from eggs.gnu.org ([2001:4830:134:3::10]:53773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dCdax-0006Tp-Pf
	for qemu-devel@nongnu.org; Sun, 21 May 2017 23:01:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dCdaw-0005XL-Kn
	for qemu-devel@nongnu.org; Sun, 21 May 2017 23:01:19 -0400
Date: Mon, 22 May 2017 12:35:08 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170522023508.GI30246@umbus.fritz.box>
References: <1495172439-1504-1-git-send-email-bharata@linux.vnet.ibm.com>
	<1495172439-1504-3-git-send-email-bharata@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Encpt1P6Mxii2VuT"
Content-Disposition: inline
In-Reply-To: <1495172439-1504-3-git-send-email-bharata@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 2/4] spapr: Unregister HPT savevm
 handlers for radix guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, sam.bobroff@au1.ibm.com, rnsastry@linux.vnet.ibm.com


--Encpt1P6Mxii2VuT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 19, 2017 at 11:10:37AM +0530, Bharata B Rao wrote:
> HPT gets created by default for TCG guests and later when the guest turns
> out to be a radix guest, the HPT is destroyed when guest does
> H_REGISTER_PROC_TBL hcall. Let HTAB savevm handlers registration and
> unregistration follow the same model so that we don't end up having
> unrequired HTAB savevm handlers for radix guests.
>=20
> This also ensures that HTAB savevm handlers seemlessly get destroyed and
> recreated like HTAB itself when hash guest reboots.
>=20
> HTAB savevm handlers registration/unregistration is now done from
> spapr_reallocate_hpt() which itself is called from one of the
> savevm_htab_handlers.htab_load(). To cater to this circular dependency
> spapr_reallocate_hpt() is made global.
>=20
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>


Weirdly, diff seems to have done a terrible job at minimizing the
patch below.  AFAICT this is really just a one line addition to
spapr_free_hpt() and spapr_reallocate_hpt().

> ---
>  hw/ppc/spapr.c         | 99 +++++++++++++++++++++++++-------------------=
------
>  include/hw/ppc/spapr.h |  2 +
>  2 files changed, 52 insertions(+), 49 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 91f7434..daf335c 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1233,53 +1233,7 @@ void spapr_free_hpt(sPAPRMachineState *spapr)
>      spapr->htab =3D NULL;
>      spapr->htab_shift =3D 0;
>      close_htab_fd(spapr);
> -}
> -
> -static void spapr_reallocate_hpt(sPAPRMachineState *spapr, int shift,
> -                                 Error **errp)
> -{
> -    long rc;
> -
> -    /* Clean up any HPT info from a previous boot */
> -    spapr_free_hpt(spapr);
> -
> -    rc =3D kvmppc_reset_htab(shift);
> -    if (rc < 0) {
> -        /* kernel-side HPT needed, but couldn't allocate one */
> -        error_setg_errno(errp, errno,
> -                         "Failed to allocate KVM HPT of order %d (try sm=
aller maxmem?)",
> -                         shift);
> -        /* This is almost certainly fatal, but if the caller really
> -         * wants to carry on with shift =3D=3D 0, it's welcome to try */
> -    } else if (rc > 0) {
> -        /* kernel-side HPT allocated */
> -        if (rc !=3D shift) {
> -            error_setg(errp,
> -                       "Requested order %d HPT, but kernel allocated ord=
er %ld (try smaller maxmem?)",
> -                       shift, rc);
> -        }
> -
> -        spapr->htab_shift =3D shift;
> -        spapr->htab =3D NULL;
> -    } else {
> -        /* kernel-side HPT not needed, allocate in userspace instead */
> -        size_t size =3D 1ULL << shift;
> -        int i;
> -
> -        spapr->htab =3D qemu_memalign(size, size);
> -        if (!spapr->htab) {
> -            error_setg_errno(errp, errno,
> -                             "Could not allocate HPT of order %d", shift=
);
> -            return;
> -        }
> -
> -        memset(spapr->htab, 0, size);
> -        spapr->htab_shift =3D shift;
> -
> -        for (i =3D 0; i < size / HASH_PTE_SIZE_64; i++) {
> -            DIRTY_HPTE(HPTE(spapr->htab, i));
> -        }
> -    }
> +    unregister_savevm_live(NULL, "spapr/htab", spapr);
>  }
> =20
>  void spapr_setup_hpt_and_vrma(sPAPRMachineState *spapr)
> @@ -1879,6 +1833,55 @@ static SaveVMHandlers savevm_htab_handlers =3D {
>      .load_state =3D htab_load,
>  };
> =20
> +void spapr_reallocate_hpt(sPAPRMachineState *spapr, int shift,
> +                                 Error **errp)
> +{
> +    long rc;
> +
> +    /* Clean up any HPT info from a previous boot */
> +    spapr_free_hpt(spapr);
> +
> +    rc =3D kvmppc_reset_htab(shift);
> +    if (rc < 0) {
> +        /* kernel-side HPT needed, but couldn't allocate one */
> +        error_setg_errno(errp, errno,
> +                         "Failed to allocate KVM HPT of order %d (try sm=
aller maxmem?)",
> +                         shift);
> +        /* This is almost certainly fatal, but if the caller really
> +         * wants to carry on with shift =3D=3D 0, it's welcome to try */
> +    } else if (rc > 0) {
> +        /* kernel-side HPT allocated */
> +        if (rc !=3D shift) {
> +            error_setg(errp,
> +                       "Requested order %d HPT, but kernel allocated ord=
er %ld (try smaller maxmem?)",
> +                       shift, rc);
> +        }
> +
> +        spapr->htab_shift =3D shift;
> +        spapr->htab =3D NULL;
> +    } else {
> +        /* kernel-side HPT not needed, allocate in userspace instead */
> +        size_t size =3D 1ULL << shift;
> +        int i;
> +
> +        spapr->htab =3D qemu_memalign(size, size);
> +        if (!spapr->htab) {
> +            error_setg_errno(errp, errno,
> +                             "Could not allocate HPT of order %d", shift=
);
> +            return;
> +        }
> +
> +        memset(spapr->htab, 0, size);
> +        spapr->htab_shift =3D shift;
> +
> +        for (i =3D 0; i < size / HASH_PTE_SIZE_64; i++) {
> +            DIRTY_HPTE(HPTE(spapr->htab, i));
> +        }
> +    }
> +    register_savevm_live(NULL, "spapr/htab", -1, 1,
> +                         &savevm_htab_handlers, spapr);
> +}
> +
>  static void spapr_boot_set(void *opaque, const char *boot_device,
>                             Error **errp)
>  {
> @@ -2341,8 +2344,6 @@ static void ppc_spapr_init(MachineState *machine)
>       * interface, this is a legacy from the sPAPREnvironment structure
>       * which predated MachineState but had a similar function */
>      vmstate_register(NULL, 0, &vmstate_spapr, spapr);
> -    register_savevm_live(NULL, "spapr/htab", -1, 1,
> -                         &savevm_htab_handlers, spapr);
> =20
>      /* used by RTAS */
>      QTAILQ_INIT(&spapr->ccs_list);
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index f875dc4..e581c4a 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -637,6 +637,8 @@ void spapr_hotplug_req_remove_by_count_indexed(sPAPRD=
RConnectorType drc_type,
>                                                 uint32_t count, uint32_t =
index);
>  void *spapr_populate_hotplug_cpu_dt(CPUState *cs, int *fdt_offset,
>                                      sPAPRMachineState *spapr);
> +void spapr_reallocate_hpt(sPAPRMachineState *spapr, int shift,
> +                                 Error **errp);
> =20
>  /* rtas-configure-connector state */
>  struct sPAPRConfigureConnectorState {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Encpt1P6Mxii2VuT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZIk5bAAoJEGw4ysog2bOS14UP/2jNO0nQF9zPB9IomxY3NnQu
BbBy4evX4l5dBYqAkJFlLwIxKenn9s2hGQQjiBwB9bkFxhg68km82R3FbCAmkzWf
vosztOdv9UxT7a69EOSFOIcKVUQrJyQWGJe7QC/zIl42pFMo0+yuS7HqMGxUgncf
PPksKDp4PSXbxLMUtcVegxpqkidvwjQMCJACueljwDnKcT/XWcYViBunD/mltmQE
3FMDW7q6faB+2vcowwzYTiM9U9kQkOSXWwK8okd5tNHDq+vrVL+W5JgfG0dm2zu3
0vyQ8ilFldeqq/exKS2jpcu4tokfb3t1Z9ODeKwIovWPOCfg7sQA92vSlEmfXwxM
AVR6H6RhFKYRrl+xlTvCAXjgs0/1LZBDuXWqM8DZ5dbmAvJ5uTG+ySXwIjxtx+/R
BLjgkXnCwFAmXrTXVWre2x3/GxSMjp9hAls1/jtykIi0LbjB95uGo9rucOz5jIjG
R/OsrMcWIX8Az++8gZCUc4IPL01YHe+AuYfvxxLmtYbOmR4ZunQ+tRGUd2nb8UZS
1w6eymAm2oitvzM0xNUIucxmGxwcCP+RLa51o8DTq3pPjI5At9WvbVBdtFkkdfvD
S3xcF/p00ISm4XrXtk08nHGBteu4ablpZYaWDQ2ZoL6xGyYwCUt60Aq6IfV030ZI
asyw8TAZD/lIzA3j6Jjk
=+7yR
-----END PGP SIGNATURE-----

--Encpt1P6Mxii2VuT--
