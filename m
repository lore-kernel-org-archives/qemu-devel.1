Received: from eggs.gnu.org ([2001:4830:134:3::10]:57844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e5C3D-0001mR-Df
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 10:44:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e5C3A-0008F4-9q
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 10:43:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45916)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e5C3A-0008Dp-07
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 10:43:56 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9JEhmSI091045
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 10:43:52 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dpv5fg1t3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 10:43:49 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 19 Oct 2017 08:43:43 -0600
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
	<20171009225623.29232-9-marcandre.lureau@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 19 Oct 2017 10:43:39 -0400
MIME-Version: 1.0
In-Reply-To: <20171009225623.29232-9-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <75b2a93c-3429-cf33-fa8d-83e589256cc6@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 08/42] tpm: remove TPMDriverOps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: amarnath.valluri@intel.com

On 10/09/2017 06:55 PM, Marc-Andr=C3=A9 Lureau wrote:
> Use TPMBackendClass to hold class methods/fields.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

> ---
>   include/sysemu/tpm_backend.h | 15 +++++----------
>   backends/tpm.c               | 31 ++++++++++++++++---------------
>   hw/tpm/tpm_emulator.c        | 29 ++++++++++++-----------------
>   hw/tpm/tpm_passthrough.c     | 25 +++++++++++--------------
>   tpm.c                        | 20 +++++++++-----------
>   scripts/checkpatch.pl        |  1 -
>   6 files changed, 53 insertions(+), 68 deletions(-)
>
> diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.=
h
> index 63093551a1..a4288df038 100644
> --- a/include/sysemu/tpm_backend.h
> +++ b/include/sysemu/tpm_backend.h
> @@ -29,7 +29,7 @@
>
>   typedef struct TPMBackendClass TPMBackendClass;
>   typedef struct TPMBackend TPMBackend;
> -typedef struct TPMDriverOps TPMDriverOps;
> +
>   typedef void (TPMRecvDataCB)(TPMState *, uint8_t locty, bool selftest=
_done);
>
>   typedef enum TPMBackendCmd {
> @@ -59,14 +59,6 @@ struct TPMBackend {
>   struct TPMBackendClass {
>       ObjectClass parent_class;
>
> -    const TPMDriverOps *ops;
> -
> -    void (*opened)(TPMBackend *s, Error **errp);
> -
> -    void (*handle_request)(TPMBackend *s, TPMBackendCmd cmd);
> -};
> -
> -struct TPMDriverOps {
>       enum TpmType type;
>       const QemuOptDesc *opts;
>       /* get a descriptive text of the backend to display to the user *=
/
> @@ -90,8 +82,11 @@ struct TPMDriverOps {
>       TPMVersion (*get_tpm_version)(TPMBackend *t);
>
>       TpmTypeOptions *(*get_tpm_options)(TPMBackend *t);
> -};
>
> +    void (*opened)(TPMBackend *s, Error **errp);
> +
> +    void (*handle_request)(TPMBackend *s, TPMBackendCmd cmd);
> +};
>
>   /**
>    * tpm_backend_get_type:
> diff --git a/backends/tpm.c b/backends/tpm.c
> index 37c84b7c66..ca3a78eea8 100644
> --- a/backends/tpm.c
> +++ b/backends/tpm.c
> @@ -41,7 +41,7 @@ enum TpmType tpm_backend_get_type(TPMBackend *s)
>   {
>       TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
>
> -    return k->ops->type;
> +    return k->type;
>   }
>
>   int tpm_backend_init(TPMBackend *s, TPMState *state,
> @@ -53,7 +53,7 @@ int tpm_backend_init(TPMBackend *s, TPMState *state,
>       s->recv_data_callback =3D datacb;
>       s->had_startup_error =3D false;
>
> -    return k->ops->init ? k->ops->init(s) : 0;
> +    return k->init ? k->init(s) : 0;
>   }
>
>   int tpm_backend_startup_tpm(TPMBackend *s)
> @@ -68,7 +68,7 @@ int tpm_backend_startup_tpm(TPMBackend *s)
>                                          NULL);
>       g_thread_pool_push(s->thread_pool, (gpointer)TPM_BACKEND_CMD_INIT=
, NULL);
>
> -    res =3D k->ops->startup_tpm ? k->ops->startup_tpm(s) : 0;
> +    res =3D k->startup_tpm ? k->startup_tpm(s) : 0;
>
>       s->had_startup_error =3D (res !=3D 0);
>
> @@ -90,8 +90,8 @@ void tpm_backend_reset(TPMBackend *s)
>   {
>       TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
>
> -    if (k->ops->reset) {
> -        k->ops->reset(s);
> +    if (k->reset) {
> +        k->reset(s);
>       }
>
>       tpm_backend_thread_end(s);
> @@ -103,34 +103,34 @@ void tpm_backend_cancel_cmd(TPMBackend *s)
>   {
>       TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
>
> -    assert(k->ops->cancel_cmd);
> +    assert(k->cancel_cmd);
>
> -    k->ops->cancel_cmd(s);
> +    k->cancel_cmd(s);
>   }
>
>   bool tpm_backend_get_tpm_established_flag(TPMBackend *s)
>   {
>       TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
>
> -    return k->ops->get_tpm_established_flag ?
> -           k->ops->get_tpm_established_flag(s) : false;
> +    return k->get_tpm_established_flag ?
> +           k->get_tpm_established_flag(s) : false;
>   }
>
>   int tpm_backend_reset_tpm_established_flag(TPMBackend *s, uint8_t loc=
ty)
>   {
>       TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
>
> -    return k->ops->reset_tpm_established_flag ?
> -           k->ops->reset_tpm_established_flag(s, locty) : 0;
> +    return k->reset_tpm_established_flag ?
> +           k->reset_tpm_established_flag(s, locty) : 0;
>   }
>
>   TPMVersion tpm_backend_get_tpm_version(TPMBackend *s)
>   {
>       TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
>
> -    assert(k->ops->get_tpm_version);
> +    assert(k->get_tpm_version);
>
> -    return k->ops->get_tpm_version(s);
> +    return k->get_tpm_version(s);
>   }
>
>   TPMInfo *tpm_backend_query_tpm(TPMBackend *s)
> @@ -140,8 +140,9 @@ TPMInfo *tpm_backend_query_tpm(TPMBackend *s)
>
>       info->id =3D g_strdup(s->id);
>       info->model =3D s->fe_model;
> -    info->options =3D k->ops->get_tpm_options ?
> -                    k->ops->get_tpm_options(s) : NULL;
> +    if (k->get_tpm_options) {
> +        info->options =3D k->get_tpm_options(s);
> +    }
>
>       return info;
>   }
> diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
> index 9e24a5f30e..bb5a65b492 100644
> --- a/hw/tpm/tpm_emulator.c
> +++ b/hw/tpm/tpm_emulator.c
> @@ -60,8 +60,6 @@
>
>   #define TPM_EMULATOR_IMPLEMENTS_ALL_CAPS(S, cap) (((S)->caps & (cap))=
 =3D=3D (cap))
>
> -static const TPMDriverOps tpm_emulator_driver;
> -
>   /* data structures */
>   typedef struct TPMEmulator {
>       TPMBackend parent;
> @@ -504,20 +502,6 @@ static const QemuOptDesc tpm_emulator_cmdline_opts=
[] =3D {
>       { /* end of list */ },
>   };
>
> -static const TPMDriverOps tpm_emulator_driver =3D {
> -    .type                     =3D TPM_TYPE_EMULATOR,
> -    .opts                     =3D tpm_emulator_cmdline_opts,
> -    .desc                     =3D "TPM emulator backend driver",
> -
> -    .create                   =3D tpm_emulator_create,
> -    .startup_tpm              =3D tpm_emulator_startup_tpm,
> -    .cancel_cmd               =3D tpm_emulator_cancel_cmd,
> -    .get_tpm_established_flag =3D tpm_emulator_get_tpm_established_fla=
g,
> -    .reset_tpm_established_flag =3D tpm_emulator_reset_tpm_established=
_flag,
> -    .get_tpm_version          =3D tpm_emulator_get_tpm_version,
> -    .get_tpm_options          =3D tpm_emulator_get_tpm_options,
> -};
> -
>   static void tpm_emulator_inst_init(Object *obj)
>   {
>       TPMEmulator *tpm_emu =3D TPM_EMULATOR(obj);
> @@ -565,7 +549,18 @@ static void tpm_emulator_inst_finalize(Object *obj=
)
>   static void tpm_emulator_class_init(ObjectClass *klass, void *data)
>   {
>       TPMBackendClass *tbc =3D TPM_BACKEND_CLASS(klass);
> -    tbc->ops =3D &tpm_emulator_driver;
> +
> +    tbc->type =3D TPM_TYPE_EMULATOR;
> +    tbc->opts =3D tpm_emulator_cmdline_opts;
> +    tbc->desc =3D "TPM emulator backend driver";
> +    tbc->create =3D tpm_emulator_create;
> +    tbc->startup_tpm =3D tpm_emulator_startup_tpm;
> +    tbc->cancel_cmd =3D tpm_emulator_cancel_cmd;
> +    tbc->get_tpm_established_flag =3D tpm_emulator_get_tpm_established=
_flag;
> +    tbc->reset_tpm_established_flag =3D tpm_emulator_reset_tpm_establi=
shed_flag;
> +    tbc->get_tpm_version =3D tpm_emulator_get_tpm_version;
> +    tbc->get_tpm_options =3D tpm_emulator_get_tpm_options;
> +
>       tbc->handle_request =3D tpm_emulator_handle_request;
>   }
>
> diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
> index f04eab3e63..d9da99bc8e 100644
> --- a/hw/tpm/tpm_passthrough.c
> +++ b/hw/tpm/tpm_passthrough.c
> @@ -365,19 +365,6 @@ static const QemuOptDesc tpm_passthrough_cmdline_o=
pts[] =3D {
>       { /* end of list */ },
>   };
>
> -static const TPMDriverOps tpm_passthrough_driver =3D {
> -    .type                     =3D TPM_TYPE_PASSTHROUGH,
> -    .opts                     =3D tpm_passthrough_cmdline_opts,
> -    .desc                     =3D "Passthrough TPM backend driver",
> -    .create                   =3D tpm_passthrough_create,
> -    .reset                    =3D tpm_passthrough_reset,
> -    .cancel_cmd               =3D tpm_passthrough_cancel_cmd,
> -    .get_tpm_established_flag =3D tpm_passthrough_get_tpm_established_=
flag,
> -    .reset_tpm_established_flag =3D tpm_passthrough_reset_tpm_establis=
hed_flag,
> -    .get_tpm_version          =3D tpm_passthrough_get_tpm_version,
> -    .get_tpm_options          =3D tpm_passthrough_get_tpm_options,
> -};
> -
>   static void tpm_passthrough_inst_init(Object *obj)
>   {
>       TPMPassthruState *tpm_pt =3D TPM_PASSTHROUGH(obj);
> @@ -402,7 +389,17 @@ static void tpm_passthrough_class_init(ObjectClass=
 *klass, void *data)
>   {
>       TPMBackendClass *tbc =3D TPM_BACKEND_CLASS(klass);
>
> -    tbc->ops =3D &tpm_passthrough_driver;
> +    tbc->type =3D TPM_TYPE_PASSTHROUGH;
> +    tbc->opts =3D tpm_passthrough_cmdline_opts;
> +    tbc->desc =3D "Passthrough TPM backend driver";
> +    tbc->create =3D tpm_passthrough_create;
> +    tbc->reset =3D tpm_passthrough_reset;
> +    tbc->cancel_cmd =3D tpm_passthrough_cancel_cmd;
> +    tbc->get_tpm_established_flag =3D tpm_passthrough_get_tpm_establis=
hed_flag;
> +    tbc->reset_tpm_established_flag =3D
> +        tpm_passthrough_reset_tpm_established_flag;
> +    tbc->get_tpm_version =3D tpm_passthrough_get_tpm_version;
> +    tbc->get_tpm_options =3D tpm_passthrough_get_tpm_options;
>       tbc->handle_request =3D tpm_passthrough_handle_request;
>   }
>
> diff --git a/tpm.c b/tpm.c
> index 75a589b837..4882501bd7 100644
> --- a/tpm.c
> +++ b/tpm.c
> @@ -32,11 +32,10 @@ void tpm_register_model(enum TpmModel model)
>
>   #ifdef CONFIG_TPM
>
> -static const TPMDriverOps *
> -tpm_driver_find_by_type(enum TpmType type)
> +static const TPMBackendClass *
> +tpm_be_find_by_type(enum TpmType type)
>   {
>       ObjectClass *oc;
> -    TPMBackendClass *bc;
>       char *typename =3D g_strdup_printf("tpm-%s", TpmType_str(type));
>
>       oc =3D object_class_by_name(typename);
> @@ -46,8 +45,7 @@ tpm_driver_find_by_type(enum TpmType type)
>           return NULL;
>       }
>
> -    bc =3D TPM_BACKEND_CLASS(oc);
> -    return bc->ops;
> +    return TPM_BACKEND_CLASS(oc);
>   }
>
>   /*
> @@ -61,11 +59,11 @@ static void tpm_display_backend_drivers(void)
>       fprintf(stderr, "Supported TPM types (choose only one):\n");
>
>       for (i =3D 0; i < TPM_TYPE__MAX; i++) {
> -        const TPMDriverOps *ops =3D tpm_driver_find_by_type(i);
> -        if (!ops) {
> +        const TPMBackendClass *bc =3D tpm_be_find_by_type(i);
> +        if (!bc) {
>               continue;
>           }
> -        fprintf(stderr, "%12s   %s\n", TpmType_str(i), ops->desc);
> +        fprintf(stderr, "%12s   %s\n", TpmType_str(i), bc->desc);
>       }
>       fprintf(stderr, "\n");
>   }
> @@ -92,7 +90,7 @@ static int configure_tpm(QemuOpts *opts)
>   {
>       const char *value;
>       const char *id;
> -    const TPMDriverOps *be;
> +    const TPMBackendClass *be;
>       TPMBackend *drv;
>       Error *local_err =3D NULL;
>       int i;
> @@ -116,7 +114,7 @@ static int configure_tpm(QemuOpts *opts)
>       }
>
>       i =3D qapi_enum_parse(&TpmType_lookup, value, -1, NULL);
> -    be =3D i >=3D 0 ? tpm_driver_find_by_type(i) : NULL;
> +    be =3D i >=3D 0 ? tpm_be_find_by_type(i) : NULL;
>       if (be =3D=3D NULL) {
>           error_report(QERR_INVALID_PARAMETER_VALUE,
>                        "type", "a TPM backend type");
> @@ -234,7 +232,7 @@ TpmTypeList *qmp_query_tpm_types(Error **errp)
>       TpmTypeList *head =3D NULL, *prev =3D NULL, *cur_item;
>
>       for (i =3D 0; i < TPM_TYPE__MAX; i++) {
> -        if (!tpm_driver_find_by_type(i)) {
> +        if (!tpm_be_find_by_type(i)) {
>               continue;
>           }
>           cur_item =3D g_new0(TpmTypeList, 1);
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 0c41f1212f..c9529df67f 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2602,7 +2602,6 @@ sub process {
>   				SCSIBusInfo|
>   				SCSIReqOps|
>   				Spice[A-Z][a-zA-Z0-9]*Interface|
> -				TPMDriverOps|
>   				USBDesc[A-Z][a-zA-Z0-9]*|
>   				VhostOps|
>   				VMStateDescription|
