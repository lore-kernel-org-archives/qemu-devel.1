Received: from eggs.gnu.org ([209.51.188.92]:57820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gy8Z5-0001Xz-N1
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 00:12:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gy8Yw-0005ji-Ix
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 00:12:27 -0500
Date: Mon, 25 Feb 2019 16:11:53 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190225051153.GU7668@umbus.fritz.box>
References: <20190223144057.10509-1-maxiwell@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UC+RhZhEc8lcmajv"
Content-Disposition: inline
In-Reply-To: <20190223144057.10509-1-maxiwell@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] spapr-rtas: add ibm, get-vpd RTAS interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>
Cc: qemu-devel@nongnu.org, "open list:sPAPR" <qemu-ppc@nongnu.org>


--UC+RhZhEc8lcmajv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 23, 2019 at 11:40:57AM -0300, Maxiwell S. Garcia wrote:
> This adds a handler for ibm,get-vpd RTAS calls, allowing pseries
> guest to collect host information. It is disabled by default to
> avoid unwanted information leakage. To enable it, use:
> =E2=80=98-M pseries,vpd-export=3Don=E2=80=99
>=20
> Only the SE and TM keywords are returned at the moment:
> SE for Machine or Cabinet Serial Number and
> TM for Machine Type and Model.
>=20
> Powerpc-utils tools can dispatch RTAS calls to retrieve host
> information using this ibm,get-vpd interface. The 'host-serial'
> and 'host-model' nodes of device-tree hold the same information but
> in a static manner, which is useless after a migration operation.
>=20
> Signed-off-by: Maxiwell S. Garcia <maxiwell@linux.ibm.com>
> ---
>  hw/ppc/spapr.c         | 21 ++++++++++
>  hw/ppc/spapr_rtas.c    | 93 ++++++++++++++++++++++++++++++++++++++++++
>  include/hw/ppc/spapr.h | 17 +++++++-
>  3 files changed, 130 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index abf9ebce59..09fd9e2ebb 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3026,6 +3026,20 @@ static char *spapr_get_fw_dev_path(FWPathProvider =
*p, BusState *bus,
>      return NULL;
>  }
> =20
> +static bool spapr_get_vpd_export(Object *obj, Error **errp)
> +{
> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> +
> +    return spapr->vpd_export;
> +}
> +
> +static void spapr_set_vpd_export(Object *obj, bool value, Error **errp)
> +{
> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> +
> +    spapr->vpd_export =3D value;
> +}
> +
>  static char *spapr_get_kvm_type(Object *obj, Error **errp)
>  {
>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> @@ -3150,6 +3164,7 @@ static void spapr_instance_init(Object *obj)
>      sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> =20
>      spapr->htab_fd =3D -1;
> +    spapr->vpd_export =3D false;
>      spapr->use_hotplug_event_source =3D true;
>      object_property_add_str(obj, "kvm-type",
>                              spapr_get_kvm_type, spapr_set_kvm_type, NULL=
);
> @@ -3182,6 +3197,12 @@ static void spapr_instance_init(Object *obj)
>      object_property_add_bool(obj, "vfio-no-msix-emulation",
>                               spapr_get_msix_emulation, NULL, NULL);
> =20
> +    object_property_add_bool(obj, "vpd-export", spapr_get_vpd_export,
> +                             spapr_set_vpd_export, NULL);
> +    object_property_set_description(obj, "vpd-export",
> +                                    "Export Host's VPD information to gu=
est",
> +                                    &error_abort);
> +
>      /* The machine class defines the default interrupt controller mode */
>      spapr->irq =3D smc->irq;
>      object_property_add_str(obj, "ic-mode", spapr_get_ic_mode,
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index d6a0952154..214e0edfc5 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -287,6 +287,97 @@ static void rtas_ibm_set_system_parameter(PowerPCCPU=
 *cpu,
>      rtas_st(rets, 0, ret);
>  }
> =20
> +static inline int vpd_st(target_ulong addr, target_ulong len,
> +                         const void *val, uint16_t val_len)
> +{
> +    hwaddr phys =3D ppc64_phys_to_real(addr);
> +    if (len < val_len) {
> +        return RTAS_OUT_PARAM_ERROR;
> +    }
> +    cpu_physical_memory_write(phys, val, val_len);
> +    return RTAS_OUT_SUCCESS;
> +}
> +
> +static inline void vpd_ret(target_ulong rets, const int status,
> +                           const int next_seq_number, const int bytes_re=
turned)
> +{
> +    rtas_st(rets, 0, status);
> +    rtas_st(rets, 1, next_seq_number);
> +    rtas_st(rets, 2, bytes_returned);
> +}
> +
> +static void rtas_ibm_get_vpd(PowerPCCPU *cpu,
> +                             sPAPRMachineState *spapr,
> +                             uint32_t token, uint32_t nargs,
> +                             target_ulong args,
> +                             uint32_t nret, target_ulong rets)
> +{
> +    sPAPRMachineState *sm =3D SPAPR_MACHINE(spapr);
> +    target_ulong loc_code_addr;
> +    target_ulong work_area_addr;
> +    target_ulong work_area_size;
> +    target_ulong seq_number;
> +    unsigned char loc_code =3D 0;
> +    unsigned int next_seq_number =3D 0;
> +    int status =3D RTAS_IBM_GET_VPD_PARAMETER_ERROR;
> +    int ret =3D 0;
> +    char *field =3D '\0';

ITYM
	char *field =3D "\0";

Assigning field to an empty string.  As it is '\0' is being coerced to
an integer (0) then to a pointer (NULL)...

> +
> +    if (!sm->vpd_export) {
> +        vpd_ret(rets, RTAS_OUT_NOT_AUTHORIZED, 1, 0);
> +        return;
> +    }
> +
> +    /* Specific Location Code is not supported */
> +    loc_code_addr =3D rtas_ld(args, 0);
> +    cpu_physical_memory_read(loc_code_addr, &loc_code, 1);
> +    if (loc_code !=3D 0) {
> +        vpd_ret(rets, RTAS_IBM_GET_VPD_PARAMETER_ERROR, 1, 0);
> +        return;
> +    }
> +
> +    work_area_addr =3D rtas_ld(args, 1);
> +    work_area_size =3D rtas_ld(args, 2);
> +    seq_number =3D rtas_ld(args, 3);
> +    switch (seq_number) {
> +        case RTAS_IBM_VPD_KEYWORD_SE: {
> +            char *host_serial;
> +            if (kvmppc_get_host_serial(&host_serial)) {
> +                /* LoPAPR: SE for Machine or Cabinet Serial Number */
> +                field =3D g_strdup_printf("SE %s", host_serial);
> +                ret =3D vpd_st(work_area_addr, work_area_size,
> +                             field, strlen(field) + 1);
> +                g_free(host_serial);
> +            }
> +            break;
> +        }
> +        case RTAS_IBM_VPD_KEYWORD_TM: {
> +            char *host_model;
> +            if (kvmppc_get_host_model(&host_model)) {
> +                /* LoPAPR: TM for Machine Type and Model */
> +                field =3D g_strdup_printf("TM %s", host_model);
> +                ret =3D vpd_st(work_area_addr, work_area_size,
> +                             field, strlen(field) + 1);
> +                g_free(host_model);
> +            }
> +            break;
> +        }
> +    }
> +
> +    if (ret =3D=3D 0) {
> +        if (seq_number =3D=3D RTAS_IBM_VPD_KEYWORD_LAST) {
> +            status =3D RTAS_IBM_GET_VPD_SUCCESS;
> +            next_seq_number =3D 1;
> +        } else {
> +            status =3D RTAS_IBM_GET_VPD_CONTINUE;
> +            next_seq_number =3D seq_number + 1;
> +        }
> +    }
> +
> +    vpd_ret(rets, status, next_seq_number, strlen(field));

=2E.. which it isn't safe to call strlen() on.

> +    g_free(field);

But.. then again, g_free() is safe to call on NULL, but not safe to
call on a statically allocated string.  Either way, something needs
fixing.

> +}
> +
>  static void rtas_ibm_os_term(PowerPCCPU *cpu,
>                              sPAPRMachineState *spapr,
>                              uint32_t token, uint32_t nargs,
> @@ -485,6 +576,8 @@ static void core_rtas_register_types(void)
>                          rtas_ibm_set_system_parameter);
>      spapr_rtas_register(RTAS_IBM_OS_TERM, "ibm,os-term",
>                          rtas_ibm_os_term);
> +    spapr_rtas_register(RTAS_IBM_GET_VPD, "ibm,get-vpd",
> +                        rtas_ibm_get_vpd);
>      spapr_rtas_register(RTAS_SET_POWER_LEVEL, "set-power-level",
>                          rtas_set_power_level);
>      spapr_rtas_register(RTAS_GET_POWER_LEVEL, "get-power-level",
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 631fc5103b..235b22340d 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -183,6 +183,7 @@ struct sPAPRMachineState {
>      sPAPRXive  *xive;
>      sPAPRIrq *irq;
>      qemu_irq *qirqs;
> +    bool vpd_export;
> =20
>      bool cmd_line_caps[SPAPR_CAP_NUM];
>      sPAPRCapabilities def, eff, mig;
> @@ -605,14 +606,28 @@ target_ulong spapr_hypercall(PowerPCCPU *cpu, targe=
t_ulong opcode,
>  #define RTAS_IBM_CREATE_PE_DMA_WINDOW           (RTAS_TOKEN_BASE + 0x27)
>  #define RTAS_IBM_REMOVE_PE_DMA_WINDOW           (RTAS_TOKEN_BASE + 0x28)
>  #define RTAS_IBM_RESET_PE_DMA_WINDOW            (RTAS_TOKEN_BASE + 0x29)
> +#define RTAS_IBM_GET_VPD                        (RTAS_TOKEN_BASE + 0x2A)
> =20
> -#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2A)
> +#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2B)
> =20
>  /* RTAS ibm,get-system-parameter token values */
>  #define RTAS_SYSPARM_SPLPAR_CHARACTERISTICS      20
>  #define RTAS_SYSPARM_DIAGNOSTICS_RUN_MODE        42
>  #define RTAS_SYSPARM_UUID                        48
> =20
> +/* RTAS ibm,get-vpd status values */
> +#define RTAS_IBM_GET_VPD_VPD_CHANGED     -4
> +#define RTAS_IBM_GET_VPD_PARAMETER_ERROR -3
> +#define RTAS_IBM_GET_VPD_HARDWARE_ERROR  -1
> +#define RTAS_IBM_GET_VPD_SUCCESS          0
> +#define RTAS_IBM_GET_VPD_CONTINUE         1
> +
> +/* RTAS ibm,get-vpd keywords index */
> +#define RTAS_IBM_VPD_KEYWORD_SE     1
> +#define RTAS_IBM_VPD_KEYWORD_TM     2
> +
> +#define RTAS_IBM_VPD_KEYWORD_LAST   2
> +
>  /* RTAS indicator/sensor types
>   *
>   * as defined by PAPR+ 2.7 7.3.5.4, Table 41

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--UC+RhZhEc8lcmajv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxzeRcACgkQbDjKyiDZ
s5L1Ng/9E/UYd+C1BjoiSjoZiP5T7M2l3i9hjyQTed0yF9xh0dKO13YywcfL69bv
K0POLhjEOMlKL1L2ul89nKwyZabEaP0btB1MeKKPeHqXfcO5KuS+exXrNbr4HffI
3VlDd8iHTjIG4hCxVN2bL5lOIxgwjOUyYEWF9vmV01WNI87NeUwtJ7wnPs5719df
xQV97b1Y0Bij75kFRMigE0RELF3AWRESPZGWq4QjMH7j5RQihNj9FPLv+xqUDqiu
Pr6v4xcir8ye/ljcvECtup0k6HsNlXvO/JgZWIQ5Lv2NVKOJrSa+/ZRFW2Ddi2AT
T3oDxP/MrqxPRs0QMriLX16wGeHynpVVWhIoKS4Lv9VZtK6TNGm5kkGvamFV/+4v
YyiiTYXscWfuuZpk5tUEbxWUxyveqmKOVMQuLTEPGJ9Sku4MYTuU+6JLGrU5IuG1
vanVS11vjVnMkNcmCccCqUj60wtRLqtCQBfBCFcNHdzIctpin6fMWrh5UJRNxIfm
kes8F2uI2EkjrzAlcs3CSdW/pbuDzSg8spgA8HQrSc/Jagclx7tHVGKALJhhCCyc
6BjA5obXOsrf0UgCnMRgWalgCmaC44hvx/p1A63B2HOrCfMAHn/XfdGpzfskl106
dtFhKNUJB30EcgBe4naEgOgQ5nbe9738/D7QWIaNizuPkT9kUe4=
=hM+T
-----END PGP SIGNATURE-----

--UC+RhZhEc8lcmajv--
