Received: from eggs.gnu.org ([209.51.188.92]:50800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxiwell@linux.ibm.com>) id 1h1IQm-0001o6-3e
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 17:21:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxiwell@linux.ibm.com>) id 1h1IQh-0004Vz-VC
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 17:20:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41186
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxiwell@linux.ibm.com>)
	id 1h1IQh-0004UO-M1
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 17:20:55 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x25MEIsC015046
	for <qemu-devel@nongnu.org>; Tue, 5 Mar 2019 17:20:52 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2r20b9mbrp-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 17:20:51 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <maxiwell@linux.ibm.com>;
	Tue, 5 Mar 2019 22:20:51 -0000
Date: Tue, 5 Mar 2019 19:20:37 -0300
From: "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>
References: <20190228200438.5726-1-maxiwell@linux.ibm.com>
	<20190305193938.GA17260@kermit.br.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190305193938.GA17260@kermit.br.ibm.com>
Message-Id: <20190305222037.mpazsfp3prw6mbku@maxibm>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v4] spapr-rtas: add ibm,
 get-vpd RTAS interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Cc: "open list:sPAPR" <qemu-ppc@nongnu.org>, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

Hi Murilo,

On Tue, Mar 05, 2019 at 04:39:38PM -0300, Murilo Opsfelder Araujo wrote:
> Hi, Maxiwell.
>=20
> On Thu, Feb 28, 2019 at 05:04:37PM -0300, Maxiwell S. Garcia wrote:
> > This adds a handler for ibm,get-vpd RTAS calls, allowing pseries gues=
t
> > to collect host information. It is disabled by default to avoid unwan=
ted
> > information leakage. To enable it, use:
> >
> > =E2=80=98-M pseries,host-serial=3D{passthrough|string},host-model=3D{=
passthrough|string}=E2=80=99
> >
> > Only the SE and TM keywords are returned at the moment.
> > SE for Machine or Cabinet Serial Number and
> > TM for Machine Type and Model
> >
> > The SE and TM keywords are controlled by 'host-serial' and 'host-mode=
l'
> > options, respectively. In the case of 'passthrough', the SE shows the
> > host 'system-id' information and the TM shows the host 'model' inform=
ation.
> >
> > Powerpc-utils tools can dispatch RTAS calls to retrieve host
> > information using this ibm,get-vpd interface. The 'host-serial'
> > and 'host-model' nodes of device-tree hold the same information but
> > in a static manner, which is useless after a migration operation.
> >
> > Signed-off-by: Maxiwell S. Garcia <maxiwell@linux.ibm.com>
> > ---
> >  hw/ppc/spapr_rtas.c    | 121 +++++++++++++++++++++++++++++++++++++++=
++
> >  include/hw/ppc/spapr.h |  17 +++++-
> >  2 files changed, 137 insertions(+), 1 deletion(-)
> >
> > Update v4:
> >     * Allows enable/disable host-serial and host-model options indivi=
dually
> >
> > diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> > index 7a2cb786a3..785c453eb6 100644
> > --- a/hw/ppc/spapr_rtas.c
> > +++ b/hw/ppc/spapr_rtas.c
> > @@ -287,6 +287,123 @@ static void rtas_ibm_set_system_parameter(Power=
PCCPU *cpu,
> >      rtas_st(rets, 0, ret);
> >  }
> >
> > +static inline int vpd_st(target_ulong addr, target_ulong len,
> > +                         const void *val, uint16_t val_len)
> > +{
> > +    hwaddr phys =3D ppc64_phys_to_real(addr);
> > +    if (len < val_len) {
> > +        return RTAS_OUT_PARAM_ERROR;
> > +    }
> > +    cpu_physical_memory_write(phys, val, val_len);
> > +    return RTAS_OUT_SUCCESS;
> > +}
> > +
> > +static inline void vpd_ret(target_ulong rets, const int status,
> > +                           const int next_seq_number, const int byte=
s_returned)
> > +{
> > +    rtas_st(rets, 0, status);
> > +    rtas_st(rets, 1, next_seq_number);
> > +    rtas_st(rets, 2, bytes_returned);
> > +}
> > +
> > +static void rtas_ibm_get_vpd_register_keywords(sPAPRMachineState *sm=
)
> > +{
> > +    sm->rtas_vpd_keywords =3D g_malloc0(sizeof(uint8_t) *
> > +                            RTAS_IBM_VPD_KEYWORDS_MAX);
> > +
> > +    int i =3D 0;
> > +    if (sm->host_serial && !g_str_equal(sm->host_serial, "none")) {
> > +        sm->rtas_vpd_keywords[i++] =3D RTAS_IBM_VPD_KEYWORD_SE;
> > +    }
> > +    if (sm->host_model && !g_str_equal(sm->host_model, "none")) {
> > +        sm->rtas_vpd_keywords[i++] =3D RTAS_IBM_VPD_KEYWORD_TM;
> > +    }
> > +}
> > +
> > +static void rtas_ibm_get_vpd(PowerPCCPU *cpu,
> > +                             sPAPRMachineState *spapr,
> > +                             uint32_t token, uint32_t nargs,
> > +                             target_ulong args,
> > +                             uint32_t nret, target_ulong rets)
> > +{
> > +    target_ulong loc_code_addr;
> > +    target_ulong work_area_addr;
> > +    target_ulong work_area_size;
> > +    target_ulong seq_number;
> > +    unsigned char loc_code =3D 0;
> > +    unsigned int next_seq_number =3D 1;
> > +    int status =3D RTAS_IBM_GET_VPD_PARAMETER_ERROR;
> > +    int ret =3D RTAS_OUT_PARAM_ERROR;
> > +    char *buf =3D NULL;
> > +    char *vpd_field =3D NULL;
> > +    unsigned int vpd_field_len =3D 0;
> > +
> > +    /* RTAS not authorized if no keywords have been registered */
> > +    if (!spapr->rtas_vpd_keywords[0]) {
> > +        vpd_ret(rets, RTAS_OUT_NOT_AUTHORIZED, 1, 0);
> > +        return;
> > +    }
> > +
> > +    loc_code_addr =3D rtas_ld(args, 0);
> > +    work_area_addr =3D rtas_ld(args, 1);
> > +    work_area_size =3D rtas_ld(args, 2);
> > +    seq_number =3D rtas_ld(args, 3);
> > +
> > +    /* Specific Location Code is not supported and seq_number */
> > +    /* must be checked to avoid out of bound index error */
> > +    cpu_physical_memory_read(loc_code_addr, &loc_code, 1);
> > +    if ((loc_code !=3D 0) || (seq_number <=3D 0) ||
> > +        (seq_number > RTAS_IBM_VPD_KEYWORDS_MAX)) {
> > +        vpd_ret(rets, RTAS_IBM_GET_VPD_PARAMETER_ERROR, 1, 0);
> > +        return;
> > +    }
> > +
> > +    switch (spapr->rtas_vpd_keywords[seq_number - 1]) {
>=20
> Since seq_number comes from guest userspace, we shouldn't rely its
> value will always be within the range of the array.
>=20
> We could perhaps return RTAS_OUT_NOT_AUTHORIZED if `seq_number - 1`
> extrapolates the array range that holds the registered keywords.
>=20

The seq_number is tested in the 'if' statement before access
the rtas_vpd_keywords array and it's returns RTAS_IBM_GET_VPD_PARAMETER_E=
RROR
in case of out of bound index.

> > +    case RTAS_IBM_VPD_KEYWORD_SE:
> > +        if (g_str_equal(spapr->host_serial, "passthrough")) {
> > +            /* -M host-serial=3Dpassthrough */
> > +            if (kvmppc_get_host_serial(&buf)) {
> > +                /* LoPAPR: SE for Machine or Cabinet Serial Number *=
/
> > +                vpd_field =3D g_strdup_printf("SE %s", buf);
> > +            }
> > +        } else {
> > +            vpd_field =3D g_strdup_printf("SE %s", spapr->host_seria=
l);
> > +        }
> > +        break;
> > +    case RTAS_IBM_VPD_KEYWORD_TM:
> > +        if (g_str_equal(spapr->host_model, "passthrough")) {
> > +            /* -M host-model=3Dpassthrough */
> > +            if (kvmppc_get_host_model(&buf)) {
> > +                /* LoPAPR: TM for Machine Type and Model */
> > +                vpd_field =3D g_strdup_printf("TM %s", buf);
> > +            }
> > +        } else {
> > +            vpd_field =3D g_strdup_printf("TM %s", spapr->host_model=
);
> > +        }
> > +        break;
> > +    }
> > +
> > +    if (vpd_field) {
> > +        vpd_field_len =3D strlen(vpd_field);
> > +        ret =3D vpd_st(work_area_addr, work_area_size,
> > +                     vpd_field, vpd_field_len + 1);
> > +
> > +        if (ret =3D=3D 0) {
> > +            next_seq_number =3D seq_number + 1;
> > +            if (spapr->rtas_vpd_keywords[next_seq_number - 1]) {
> > +                status =3D RTAS_IBM_GET_VPD_CONTINUE;
> > +            } else {
> > +                status =3D RTAS_IBM_GET_VPD_SUCCESS;
> > +                next_seq_number =3D 1;
>=20
> If spapr->rtas_vpd_keywords[next_seq_number - 1] doesn't exist,
> shouldn't we set next_seq_number=3DRTAS_IBM_VPD_KEYWORDS_MAX here,
> indicating next_seq_number reached the last registered keyword?
>=20

The LoPAPR DRAFT v11 24March2016, page 239, says to return 1 if no more
calls are required.

> > +            }
> > +        }
> > +    }
> > +
> > +    vpd_ret(rets, status, next_seq_number, vpd_field_len);
> > +    g_free(vpd_field);
> > +    g_free(buf);
> > +}
> > +
> >  static void rtas_ibm_os_term(PowerPCCPU *cpu,
> >                              sPAPRMachineState *spapr,
> >                              uint32_t token, uint32_t nargs,
> > @@ -464,6 +581,8 @@ void spapr_load_rtas(sPAPRMachineState *spapr, vo=
id *fdt, hwaddr addr)
> >                       fdt_strerror(ret));
> >          exit(1);
> >      }
> > +
> > +    rtas_ibm_get_vpd_register_keywords(spapr);
> >  }
> >
> >  static void core_rtas_register_types(void)
> > @@ -485,6 +604,8 @@ static void core_rtas_register_types(void)
> >                          rtas_ibm_set_system_parameter);
> >      spapr_rtas_register(RTAS_IBM_OS_TERM, "ibm,os-term",
> >                          rtas_ibm_os_term);
> > +    spapr_rtas_register(RTAS_IBM_GET_VPD, "ibm,get-vpd",
> > +                        rtas_ibm_get_vpd);
> >      spapr_rtas_register(RTAS_SET_POWER_LEVEL, "set-power-level",
> >                          rtas_set_power_level);
> >      spapr_rtas_register(RTAS_GET_POWER_LEVEL, "get-power-level",
> > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > index 59073a7579..ebf314a15c 100644
> > --- a/include/hw/ppc/spapr.h
> > +++ b/include/hw/ppc/spapr.h
> > @@ -153,6 +153,7 @@ struct sPAPRMachineState {
> >      struct PPCTimebase tb;
> >      bool has_graphics;
> >      uint32_t vsmt;       /* Virtual SMT mode (KVM's "core stride") *=
/
> > +    uint8_t *rtas_vpd_keywords;
> >
> >      Notifier epow_notifier;
> >      QTAILQ_HEAD(, sPAPREventLogEntry) pending_events;
> > @@ -608,14 +609,28 @@ target_ulong spapr_hypercall(PowerPCCPU *cpu, t=
arget_ulong opcode,
> >  #define RTAS_IBM_CREATE_PE_DMA_WINDOW           (RTAS_TOKEN_BASE + 0=
x27)
> >  #define RTAS_IBM_REMOVE_PE_DMA_WINDOW           (RTAS_TOKEN_BASE + 0=
x28)
> >  #define RTAS_IBM_RESET_PE_DMA_WINDOW            (RTAS_TOKEN_BASE + 0=
x29)
> > +#define RTAS_IBM_GET_VPD                        (RTAS_TOKEN_BASE + 0=
x2A)
> >
> > -#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0=
x2A)
> > +#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0=
x2B)
> >
> >  /* RTAS ibm,get-system-parameter token values */
> >  #define RTAS_SYSPARM_SPLPAR_CHARACTERISTICS      20
> >  #define RTAS_SYSPARM_DIAGNOSTICS_RUN_MODE        42
> >  #define RTAS_SYSPARM_UUID                        48
> >
> > +/* RTAS ibm,get-vpd status values */
> > +#define RTAS_IBM_GET_VPD_VPD_CHANGED     -4
> > +#define RTAS_IBM_GET_VPD_PARAMETER_ERROR -3
> > +#define RTAS_IBM_GET_VPD_HARDWARE_ERROR  -1
> > +#define RTAS_IBM_GET_VPD_SUCCESS          0
> > +#define RTAS_IBM_GET_VPD_CONTINUE         1
> > +
> > +/* RTAS ibm,get-vpd keywords index */
> > +#define RTAS_IBM_VPD_KEYWORD_SE     1
> > +#define RTAS_IBM_VPD_KEYWORD_TM     2
> > +
> > +#define RTAS_IBM_VPD_KEYWORDS_MAX   2
> > +
> >  /* RTAS indicator/sensor types
> >   *
> >   * as defined by PAPR+ 2.7 7.3.5.4, Table 41
> > --
> > 2.20.1
> >
> >
>=20
> --
> Murilo
>=20
>=20

Thanks for review
