Received: from eggs.gnu.org ([209.51.188.92]:57308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1gyPXv-0000VZ-Vb
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 18:20:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1gyPXo-0001yj-GA
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 18:20:25 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51038
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <muriloo@linux.ibm.com>)
	id 1gyPXm-0001xk-Or
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 18:20:20 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1PNJHCQ076740
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 18:20:17 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qvscy1dyj-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 18:20:16 -0500
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <muriloo@linux.ibm.com>;
	Mon, 25 Feb 2019 23:20:16 -0000
Date: Mon, 25 Feb 2019 20:20:09 -0300
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
References: <20190225162325.24008-1-maxiwell@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190225162325.24008-1-maxiwell@linux.ibm.com>
Message-Id: <20190225232009.GB30778@kermit.br.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2] spapr-rtas: add ibm,
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
Cc: qemu-devel@nongnu.org, "open list:sPAPR" <qemu-ppc@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>

Hi, Maxiwell.

On Mon, Feb 25, 2019 at 01:23:25PM -0300, Maxiwell S. Garcia wrote:
> This adds a handler for ibm,get-vpd RTAS calls, allowing pseries
> guest to collect host information. It is disabled by default to
> avoid unwanted information leakage. To enable it, use:
> =E2=80=98-M pseries,vpd-export=3Don=E2=80=99

The patch for setting host-serial and host-model already landed Gibson's
ppc-for-4.0 branch:

  commit 9e584f45868f6945c1282c938278038cba0e4af2
  Author: Prasad J Pandit <pjp@fedoraproject.org>
  Date:   Mon Feb 18 23:43:49 2019 +0530

      ppc: add host-serial and host-model machine attributes (CVE-2019-89=
34)


QEMU should only return host-serial and host-model from the host if the
following combination of parameters are provided:

  -M host-serial=3Dpassthrough,host-model=3Dpassthrough,vpd-export=3Don

If host-serial or host-model are set with a user-string, ibm,get-vpd shou=
ld
honor these values and return them, not exposing host information by acci=
dent.

I'm not even sure if we need vpd-export=3D<bool> setting. Its logic could=
 be
derived from the presence of host-serial=3Dpassthrough and host-model=3Dp=
assthrough
options.

What do you think?

>
> Only the SE and TM keywords are returned at the moment:
> SE for Machine or Cabinet Serial Number and
> TM for Machine Type and Model.
>
> Powerpc-utils tools can dispatch RTAS calls to retrieve host
> information using this ibm,get-vpd interface. The 'host-serial'
> and 'host-model' nodes of device-tree hold the same information but
> in a static manner, which is useless after a migration operation.
>
> Signed-off-by: Maxiwell S. Garcia <maxiwell@linux.ibm.com>
> ---
>  hw/ppc/spapr.c         | 21 ++++++++++
>  hw/ppc/spapr_rtas.c    | 95 ++++++++++++++++++++++++++++++++++++++++++
>  include/hw/ppc/spapr.h | 17 +++++++-
>  3 files changed, 132 insertions(+), 1 deletion(-)
>
> Update v2:
> - rtas_ibm_get_vpd(): fix initialization values
>
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index abf9ebce59..09fd9e2ebb 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3026,6 +3026,20 @@ static char *spapr_get_fw_dev_path(FWPathProvide=
r *p, BusState *bus,
>      return NULL;
>  }
>
> +static bool spapr_get_vpd_export(Object *obj, Error **errp)
> +{
> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> +
> +    return spapr->vpd_export;
> +}
> +
> +static void spapr_set_vpd_export(Object *obj, bool value, Error **errp=
)
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
>
>      spapr->htab_fd =3D -1;
> +    spapr->vpd_export =3D false;
>      spapr->use_hotplug_event_source =3D true;
>      object_property_add_str(obj, "kvm-type",
>                              spapr_get_kvm_type, spapr_set_kvm_type, NU=
LL);
> @@ -3182,6 +3197,12 @@ static void spapr_instance_init(Object *obj)
>      object_property_add_bool(obj, "vfio-no-msix-emulation",
>                               spapr_get_msix_emulation, NULL, NULL);
>
> +    object_property_add_bool(obj, "vpd-export", spapr_get_vpd_export,
> +                             spapr_set_vpd_export, NULL);
> +    object_property_set_description(obj, "vpd-export",
> +                                    "Export Host's VPD information to =
guest",
> +                                    &error_abort);
> +
>      /* The machine class defines the default interrupt controller mode=
 */
>      spapr->irq =3D smc->irq;
>      object_property_add_str(obj, "ic-mode", spapr_get_ic_mode,
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index d6a0952154..fbf589c502 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -287,6 +287,99 @@ static void rtas_ibm_set_system_parameter(PowerPCC=
PU *cpu,
>      rtas_st(rets, 0, ret);
>  }
>
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
> +                           const int next_seq_number, const int bytes_=
returned)
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
> +    unsigned int next_seq_number =3D 1;
> +    int status =3D RTAS_IBM_GET_VPD_PARAMETER_ERROR;
> +    int ret =3D RTAS_OUT_PARAM_ERROR;
> +    char *vpd_field =3D NULL;
> +    unsigned int vpd_field_len =3D 0;
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
> +                vpd_field =3D g_strdup_printf("SE %s", host_serial);
> +                g_free(host_serial);
> +            }
> +            break;
> +        }
> +        case RTAS_IBM_VPD_KEYWORD_TM: {
> +            char *host_model;
> +            if (kvmppc_get_host_model(&host_model)) {
> +                /* LoPAPR: TM for Machine Type and Model */
> +                vpd_field =3D g_strdup_printf("TM %s", host_model);
> +                g_free(host_model);
> +            }
> +            break;
> +        }
> +    }

We don't have an explicit recommendation in CODING_STYLE to indent the ca=
ses of
a switch-case statement at the same level but it's very common in QEMU's =
code
base. Perhaps we could follow it here, for example:

  switch (var) {
  case A:
      do_a();
      break;
  case B:
      do_b();
      break;
  }

> +
> +    if (vpd_field) {
> +        vpd_field_len =3D strlen(vpd_field);
> +        ret =3D vpd_st(work_area_addr, work_area_size,
> +                     vpd_field, vpd_field_len + 1);
> +
> +        if (ret =3D=3D 0) {
> +            if (seq_number =3D=3D RTAS_IBM_VPD_KEYWORD_LAST) {
> +                status =3D RTAS_IBM_GET_VPD_SUCCESS;
> +            } else {
> +                status =3D RTAS_IBM_GET_VPD_CONTINUE;
> +                next_seq_number =3D seq_number + 1;
> +            }
> +        }
> +    }
> +
> +    vpd_ret(rets, status, next_seq_number, vpd_field_len);
> +    g_free(vpd_field);
> +}
> +
>  static void rtas_ibm_os_term(PowerPCCPU *cpu,
>                              sPAPRMachineState *spapr,
>                              uint32_t token, uint32_t nargs,
> @@ -485,6 +578,8 @@ static void core_rtas_register_types(void)
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
>
>      bool cmd_line_caps[SPAPR_CAP_NUM];
>      sPAPRCapabilities def, eff, mig;
> @@ -605,14 +606,28 @@ target_ulong spapr_hypercall(PowerPCCPU *cpu, tar=
get_ulong opcode,
>  #define RTAS_IBM_CREATE_PE_DMA_WINDOW           (RTAS_TOKEN_BASE + 0x2=
7)
>  #define RTAS_IBM_REMOVE_PE_DMA_WINDOW           (RTAS_TOKEN_BASE + 0x2=
8)
>  #define RTAS_IBM_RESET_PE_DMA_WINDOW            (RTAS_TOKEN_BASE + 0x2=
9)
> +#define RTAS_IBM_GET_VPD                        (RTAS_TOKEN_BASE + 0x2=
A)
>
> -#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2=
A)
> +#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2=
B)
>
>  /* RTAS ibm,get-system-parameter token values */
>  #define RTAS_SYSPARM_SPLPAR_CHARACTERISTICS      20
>  #define RTAS_SYSPARM_DIAGNOSTICS_RUN_MODE        42
>  #define RTAS_SYSPARM_UUID                        48
>
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
> --
> 2.20.1
>
>

--
Murilo
