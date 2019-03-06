Received: from eggs.gnu.org ([209.51.188.92]:55920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h1NKy-00042d-6z
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 22:35:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h1NKt-0000B0-Hw
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 22:35:18 -0500
Date: Wed, 6 Mar 2019 14:34:58 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190306033457.GA12603@umbus.fritz.box>
References: <20190228200438.5726-1-maxiwell@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
In-Reply-To: <20190228200438.5726-1-maxiwell@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4] spapr-rtas: add ibm,
 get-vpd RTAS interface
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


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 28, 2019 at 05:04:37PM -0300, Maxiwell S. Garcia wrote:
> This adds a handler for ibm,get-vpd RTAS calls, allowing pseries guest
> to collect host information. It is disabled by default to avoid unwanted
> information leakage. To enable it, use:
>=20
> =E2=80=98-M pseries,host-serial=3D{passthrough|string},host-model=3D{pass=
through|string}=E2=80=99
>=20
> Only the SE and TM keywords are returned at the moment.
> SE for Machine or Cabinet Serial Number and
> TM for Machine Type and Model
>=20
> The SE and TM keywords are controlled by 'host-serial' and 'host-model'
> options, respectively. In the case of 'passthrough', the SE shows the
> host 'system-id' information and the TM shows the host 'model' informatio=
n.
>=20
> Powerpc-utils tools can dispatch RTAS calls to retrieve host
> information using this ibm,get-vpd interface. The 'host-serial'
> and 'host-model' nodes of device-tree hold the same information but
> in a static manner, which is useless after a migration operation.
>=20
> Signed-off-by: Maxiwell S. Garcia <maxiwell@linux.ibm.com>
> ---
>  hw/ppc/spapr_rtas.c    | 121 +++++++++++++++++++++++++++++++++++++++++
>  include/hw/ppc/spapr.h |  17 +++++-
>  2 files changed, 137 insertions(+), 1 deletion(-)
>=20
> Update v4:
>     * Allows enable/disable host-serial and host-model options individual=
ly
>=20
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 7a2cb786a3..785c453eb6 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -287,6 +287,123 @@ static void rtas_ibm_set_system_parameter(PowerPCCP=
U *cpu,
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
> +static void rtas_ibm_get_vpd_register_keywords(sPAPRMachineState *sm)
> +{
> +    sm->rtas_vpd_keywords =3D g_malloc0(sizeof(uint8_t) *
> +                            RTAS_IBM_VPD_KEYWORDS_MAX);
> +
> +    int i =3D 0;
> +    if (sm->host_serial && !g_str_equal(sm->host_serial, "none")) {
> +        sm->rtas_vpd_keywords[i++] =3D RTAS_IBM_VPD_KEYWORD_SE;
> +    }
> +    if (sm->host_model && !g_str_equal(sm->host_model, "none")) {
> +        sm->rtas_vpd_keywords[i++] =3D RTAS_IBM_VPD_KEYWORD_TM;
> +    }

Creating this "index" of keywords, then constructing each keyword's
value as we step through it seems quite complex.  It might be simpler
to just generate the whole VPD as an array of structs, indexed by
sequence number at reset time, then have get-vpd just copy that out to
the guest.

That said, the current approach does work, so I'm ok to leave it if
it's too much trouble to rework.

> +}
> +
> +static void rtas_ibm_get_vpd(PowerPCCPU *cpu,
> +                             sPAPRMachineState *spapr,
> +                             uint32_t token, uint32_t nargs,
> +                             target_ulong args,
> +                             uint32_t nret, target_ulong rets)
> +{
> +    target_ulong loc_code_addr;
> +    target_ulong work_area_addr;
> +    target_ulong work_area_size;
> +    target_ulong seq_number;
> +    unsigned char loc_code =3D 0;
> +    unsigned int next_seq_number =3D 1;
> +    int status =3D RTAS_IBM_GET_VPD_PARAMETER_ERROR;
> +    int ret =3D RTAS_OUT_PARAM_ERROR;
> +    char *buf =3D NULL;
> +    char *vpd_field =3D NULL;
> +    unsigned int vpd_field_len =3D 0;
> +
> +    /* RTAS not authorized if no keywords have been registered */
> +    if (!spapr->rtas_vpd_keywords[0]) {
> +        vpd_ret(rets, RTAS_OUT_NOT_AUTHORIZED, 1, 0);
> +        return;
> +    }
> +
> +    loc_code_addr =3D rtas_ld(args, 0);
> +    work_area_addr =3D rtas_ld(args, 1);
> +    work_area_size =3D rtas_ld(args, 2);
> +    seq_number =3D rtas_ld(args, 3);
> +
> +    /* Specific Location Code is not supported and seq_number */
> +    /* must be checked to avoid out of bound index error */
> +    cpu_physical_memory_read(loc_code_addr, &loc_code, 1);
> +    if ((loc_code !=3D 0) || (seq_number <=3D 0) ||
> +        (seq_number > RTAS_IBM_VPD_KEYWORDS_MAX)) {
> +        vpd_ret(rets, RTAS_IBM_GET_VPD_PARAMETER_ERROR, 1, 0);
> +        return;
> +    }
> +
> +    switch (spapr->rtas_vpd_keywords[seq_number - 1]) {
> +    case RTAS_IBM_VPD_KEYWORD_SE:
> +        if (g_str_equal(spapr->host_serial, "passthrough")) {
> +            /* -M host-serial=3Dpassthrough */
> +            if (kvmppc_get_host_serial(&buf)) {
> +                /* LoPAPR: SE for Machine or Cabinet Serial Number */
> +                vpd_field =3D g_strdup_printf("SE %s", buf);
> +            }
> +        } else {
> +            vpd_field =3D g_strdup_printf("SE %s", spapr->host_serial);
> +        }

I'd like to see a helper function to avoid duplicating this logic
between the vpd code and the device tree generation.

> +        break;
> +    case RTAS_IBM_VPD_KEYWORD_TM:
> +        if (g_str_equal(spapr->host_model, "passthrough")) {
> +            /* -M host-model=3Dpassthrough */
> +            if (kvmppc_get_host_model(&buf)) {
> +                /* LoPAPR: TM for Machine Type and Model */
> +                vpd_field =3D g_strdup_printf("TM %s", buf);
> +            }
> +        } else {
> +            vpd_field =3D g_strdup_printf("TM %s", spapr->host_model);
> +        }

Same here.

> +        break;
> +    }
> +
> +    if (vpd_field) {
> +        vpd_field_len =3D strlen(vpd_field);
> +        ret =3D vpd_st(work_area_addr, work_area_size,
> +                     vpd_field, vpd_field_len + 1);
> +
> +        if (ret =3D=3D 0) {
> +            next_seq_number =3D seq_number + 1;
> +            if (spapr->rtas_vpd_keywords[next_seq_number - 1]) {

This isn't safe.  You only have exactly as many entries in your table
as the maximum number of populated entries (2).  So, if the table is
full, this will read base the end of the table.

> +                status =3D RTAS_IBM_GET_VPD_CONTINUE;
> +            } else {
> +                status =3D RTAS_IBM_GET_VPD_SUCCESS;
> +                next_seq_number =3D 1;
> +            }
> +        }
> +    }
> +
> +    vpd_ret(rets, status, next_seq_number, vpd_field_len);
> +    g_free(vpd_field);
> +    g_free(buf);
> +}
> +
>  static void rtas_ibm_os_term(PowerPCCPU *cpu,
>                              sPAPRMachineState *spapr,
>                              uint32_t token, uint32_t nargs,
> @@ -464,6 +581,8 @@ void spapr_load_rtas(sPAPRMachineState *spapr, void *=
fdt, hwaddr addr)
>                       fdt_strerror(ret));
>          exit(1);
>      }
> +
> +    rtas_ibm_get_vpd_register_keywords(spapr);
>  }
> =20
>  static void core_rtas_register_types(void)
> @@ -485,6 +604,8 @@ static void core_rtas_register_types(void)
>                          rtas_ibm_set_system_parameter);
>      spapr_rtas_register(RTAS_IBM_OS_TERM, "ibm,os-term",
>                          rtas_ibm_os_term);
> +    spapr_rtas_register(RTAS_IBM_GET_VPD, "ibm,get-vpd",
> +                        rtas_ibm_get_vpd);
>      spapr_rtas_register(RTAS_SET_POWER_LEVEL, "set-power-level",
>                          rtas_set_power_level);
>      spapr_rtas_register(RTAS_GET_POWER_LEVEL, "get-power-level",
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 59073a7579..ebf314a15c 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -153,6 +153,7 @@ struct sPAPRMachineState {
>      struct PPCTimebase tb;
>      bool has_graphics;
>      uint32_t vsmt;       /* Virtual SMT mode (KVM's "core stride") */
> +    uint8_t *rtas_vpd_keywords;
> =20
>      Notifier epow_notifier;
>      QTAILQ_HEAD(, sPAPREventLogEntry) pending_events;
> @@ -608,14 +609,28 @@ target_ulong spapr_hypercall(PowerPCCPU *cpu, targe=
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
> +#define RTAS_IBM_VPD_KEYWORDS_MAX   2

AFAICT, these values aren't designated by PAPR, they're just internal.
In which case they seem like an unnecessary extra layer of
indirection.  And the fact that they'll be mostly-but-not-always equal
to the sequence_number sounds like a recipe for confusion.

> +
>  /* RTAS indicator/sensor types
>   *
>   * as defined by PAPR+ 2.7 7.3.5.4, Table 41

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx/P98ACgkQbDjKyiDZ
s5JMNw/+OvNGJP6MsSlIV7P2ZZCvbfBqrnZyx43xsKpjjwqq7MlVw3HlQkkU7CdO
w2kNpRDr7/DIZht4PZACa+qb45Z6y5wHwfZP/4dWG/pCe+rzHstWAc4zYdMtoSpb
6h2m5ZDo7Wa8dE0pCzwprG53dicsdc8KOHhQffIf59fOjjkVOJJiyKWhu84L7BDM
M9SGbzAJJ8b1ch8ZHH/rPRLC5a58ya/o0zcn8aQ0TWyzIggP0Fp7tU5aCd62qGgk
QiYfrJUy7vlaSxJLO9fbTUZ7li/EZgtzOQsW4H3yVwwl4iusOopT2LaeYmF8Yu1G
bEUvS5yhar4oiteVBChXK30/sxON4tzNU3Q6UQ5XeuQQVeCBe/T83TLdME7kosPw
wOUfisHSqGyZW0Gj+1ad9pBOo1guiyMVxncGbwQd2QOVFxbcwbd8aOSVt4AdzQMf
eBqBitu55iL5no7vvG1gO/KcLS/9aT3f3FAgbM1puizQLUn/3sO4V059cF7yo4Zy
AOgJaATzHhvYiUp1MfjYlE+n1VtpJrMK+7SpRGjXhpxcLQjHjapaTLSApPE5bc63
fixNJ7B2R540fb3NF128/CHq6pJQxRql/AmOXmFcfmyl9ng0fkUoJAiAmdbT9z8K
2eCzqxrBGI9bK3jFH0JcjLE4zNeFqavsAQEGKD5CzZ12wA2H5u8=
=634C
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
