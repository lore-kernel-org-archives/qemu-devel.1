Received: from eggs.gnu.org ([2001:4830:134:3::10]:44691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dXPuI-0001qL-42
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:39:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dXPuG-0000S8-AY
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:39:10 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:33405)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dXPuF-0000QE-Tq
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:39:08 -0400
Received: by mail-lf0-x242.google.com with SMTP id t72so1364063lff.0
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 03:39:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1500367747-8992-6-git-send-email-amarnath.valluri@intel.com>
References: <1500367747-8992-1-git-send-email-amarnath.valluri@intel.com>
	<1500367747-8992-6-git-send-email-amarnath.valluri@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 18 Jul 2017 03:39:03 -0700
Message-ID: <CAJ+F1CLcHN1z-ODgvt-C2MT8h1JfbodG=bmBqq4MTj8P8m7ykg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 5/8] tmp backend: Add new api to read
 backend TpmInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amarnath Valluri <amarnath.valluri@intel.com>
Cc: QEMU <qemu-devel@nongnu.org>, Stefan Berger <stefanb@linux.vnet.ibm.com>

Hi

On Tue, Jul 18, 2017 at 1:49 AM, Amarnath Valluri
<amarnath.valluri@intel.com> wrote:
> TPM configuration options are backend implementation details and shall no=
t be
> part of base TPMBackend object, and these shall not be accessed directly =
outside
> of the class, hence added a new interface method, get_tpm_options() to
> TPMDriverOps., which shall be implemented by the derived classes to retur=
n
> configured tpm options.
>
> A new tpm backend api - tpm_backend_query_tpm() which uses _get_tpm_optio=
ns() to
> prepare TpmInfo.
>
> Signed-off-by: Amarnath Valluri <amarnath.valluri@intel.com>
> Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> ---
>  backends/tpm.c               | 22 +++++++++++++--
>  hmp.c                        |  6 ++---
>  hw/tpm/tpm_passthrough.c     | 64 ++++++++++++++++++++++++++++++++++++--=
------
>  include/sysemu/tpm_backend.h | 25 +++++++++++++++--
>  tpm.c                        | 32 +---------------------
>  5 files changed, 100 insertions(+), 49 deletions(-)
>
> diff --git a/backends/tpm.c b/backends/tpm.c
> index 05002e6..4ae6129 100644
> --- a/backends/tpm.c
> +++ b/backends/tpm.c
> @@ -131,6 +131,26 @@ TPMVersion tpm_backend_get_tpm_version(TPMBackend *s=
)
>      return k->ops->get_tpm_version(s);
>  }
>
> +TpmTypeOptions *tpm_backend_get_tpm_options(TPMBackend *s)
> +{
> +    TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
> +
> +    assert(k->ops->get_tpm_options);
> +
> +    return k->ops->get_tpm_options(s);
> +}
> +
> +TPMInfo *tpm_backend_query_tpm(TPMBackend *s)
> +{
> +    TPMInfo *info =3D g_new0(TPMInfo, 1);
> +
> +    info->id =3D g_strdup(s->id);
> +    info->model =3D s->fe_model;
> +    info->options =3D tpm_backend_get_tpm_options(s);
> +
> +    return info;
> +}
> +
>  static bool tpm_backend_prop_get_opened(Object *obj, Error **errp)
>  {
>      TPMBackend *s =3D TPM_BACKEND(obj);
> @@ -185,8 +205,6 @@ static void tpm_backend_instance_finalize(Object *obj=
)
>      TPMBackend *s =3D TPM_BACKEND(obj);
>
>      g_free(s->id);
> -    g_free(s->path);
> -    g_free(s->cancel_path);
>      tpm_backend_thread_end(s);
>  }
>
> diff --git a/hmp.c b/hmp.c
> index d970ea9..7a92e88 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -966,10 +966,10 @@ void hmp_info_tpm(Monitor *mon, const QDict *qdict)
>                         c, TpmModel_lookup[ti->model]);
>
>          monitor_printf(mon, "  \\ %s: type=3D%s",
> -                       ti->id, TpmTypeOptionsKind_lookup[ti->options->ty=
pe]);
> +                       ti->id, TpmType_lookup[ti->options->type]);
>
>          switch (ti->options->type) {
> -        case TPM_TYPE_OPTIONS_KIND_PASSTHROUGH:
> +        case TPM_TYPE_PASSTHROUGH:
>              tpo =3D ti->options->u.passthrough.data;
>              monitor_printf(mon, "%s%s%s%s",
>                             tpo->has_path ? ",path=3D" : "",
> @@ -977,7 +977,7 @@ void hmp_info_tpm(Monitor *mon, const QDict *qdict)
>                             tpo->has_cancel_path ? ",cancel-path=3D" : ""=
,
>                             tpo->has_cancel_path ? tpo->cancel_path : "")=
;
>              break;
> -        case TPM_TYPE_OPTIONS_KIND__MAX:
> +        default:

I would actually use TPM_TYPE__MAX, so that missing cases can be
caught by compiler.

>              break;
>          }
>          monitor_printf(mon, "\n");
> diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
> index a0459a6..c7706e4 100644
> --- a/hw/tpm/tpm_passthrough.c
> +++ b/hw/tpm/tpm_passthrough.c
> @@ -49,6 +49,7 @@
>  struct TPMPassthruState {
>      TPMBackend parent;
>
> +    TPMPassthroughOptions *ops;

"ops" usually refer to "operations" while "opts" is for options. But
to discard any doubt, please rename "options".

>      char *tpm_dev;
>      int tpm_fd;
>      bool tpm_executing;
> @@ -308,15 +309,14 @@ static TPMVersion tpm_passthrough_get_tpm_version(T=
PMBackend *tb)
>   * in Documentation/ABI/stable/sysfs-class-tpm.
>   * From /dev/tpm0 create /sys/class/misc/tpm0/device/cancel
>   */
> -static int tpm_passthrough_open_sysfs_cancel(TPMBackend *tb)
> +static int tpm_passthrough_open_sysfs_cancel(TPMPassthruState *tpm_pt)
>  {
> -    TPMPassthruState *tpm_pt =3D TPM_PASSTHROUGH(tb);
>      int fd =3D -1;
>      char *dev;
>      char path[PATH_MAX];
>
> -    if (tb->cancel_path) {
> -        fd =3D qemu_open(tb->cancel_path, O_WRONLY);
> +    if (tpm_pt->ops->cancel_path) {
> +        fd =3D qemu_open(tpm_pt->ops->cancel_path, O_WRONLY);
>          if (fd < 0) {
>              error_report("Could not open TPM cancel path : %s",
>                           strerror(errno));
> @@ -331,7 +331,7 @@ static int tpm_passthrough_open_sysfs_cancel(TPMBacke=
nd *tb)
>                       dev) < sizeof(path)) {
>              fd =3D qemu_open(path, O_WRONLY);
>              if (fd >=3D 0) {
> -                tb->cancel_path =3D g_strdup(path);
> +                tpm_pt->ops->cancel_path =3D g_strdup(path);
>              } else {
>                  error_report("tpm_passthrough: Could not open TPM cancel=
 "
>                               "path %s : %s", path, strerror(errno));
> @@ -351,17 +351,24 @@ static int tpm_passthrough_handle_device_opts(QemuO=
pts *opts, TPMBackend *tb)
>      const char *value;
>
>      value =3D qemu_opt_get(opts, "cancel-path");
> -    tb->cancel_path =3D g_strdup(value);
> +    if (value) {
> +        tpm_pt->ops->cancel_path =3D g_strdup(value);
> +        tpm_pt->ops->has_cancel_path =3D true;
> +    } else {
> +        tpm_pt->ops->has_cancel_path =3D false;
> +    }
>
>      value =3D qemu_opt_get(opts, "path");
>      if (!value) {
>          value =3D TPM_PASSTHROUGH_DEFAULT_DEVICE;
> +        tpm_pt->ops->has_path =3D false;

One usually prefer to have the true case first.

> +    } else {
> +        tpm_pt->ops->has_path =3D true;
>      }
>
> +    tpm_pt->ops->path =3D g_strdup(value);

Interestingly, ops->path will be set even if ops->has_path =3D false. I
am not sure the visitors will handle that case properly (for visit or
dealloc etc). Could you set ops->has_path =3D true uncondtionnally?



>      tpm_pt->tpm_dev =3D g_strdup(value);
>
> -    tb->path =3D g_strdup(tpm_pt->tpm_dev);
> -
>      tpm_pt->tpm_fd =3D qemu_open(tpm_pt->tpm_dev, O_RDWR);
>      if (tpm_pt->tpm_fd < 0) {
>          error_report("Cannot access TPM device using '%s': %s",
> @@ -382,8 +389,8 @@ static int tpm_passthrough_handle_device_opts(QemuOpt=
s *opts, TPMBackend *tb)
>      tpm_pt->tpm_fd =3D -1;
>
>   err_free_parameters:
> -    g_free(tb->path);
> -    tb->path =3D NULL;
> +    g_free(tpm_pt->ops->path);
> +    tpm_pt->ops->path =3D NULL;
>

Shouldn't it also free cancel_path?

>      g_free(tpm_pt->tpm_dev);
>      tpm_pt->tpm_dev =3D NULL;
> @@ -403,7 +410,7 @@ static TPMBackend *tpm_passthrough_create(QemuOpts *o=
pts, const char *id)
>          goto err_exit;
>      }
>
> -    tpm_pt->cancel_fd =3D tpm_passthrough_open_sysfs_cancel(tb);
> +    tpm_pt->cancel_fd =3D tpm_passthrough_open_sysfs_cancel(tpm_pt);
>      if (tpm_pt->cancel_fd < 0) {
>          goto err_exit;
>      }
> @@ -416,6 +423,38 @@ err_exit:
>      return NULL;
>  }
>
> +static TpmTypeOptions *tpm_passthrough_get_tpm_options(TPMBackend *tb)
> +{
> +    TPMPassthruState *tpm_pt =3D TPM_PASSTHROUGH(tb);
> +    TpmTypeOptions *ops =3D NULL;
> +    TPMPassthroughOptions *pops =3D NULL;
> +
> +    pops =3D g_new0(TPMPassthroughOptions, 1);
> +    if (!pops) {
> +        return NULL;
> +    }
> +

There is no check for small allocation failure elsewhere, I would drop that=
.

> +    if (tpm_pt->ops->has_path) {
> +        pops->has_path =3D true;
> +        pops->path =3D g_strdup(tpm_pt->ops->path);
> +    }
> +
> +    if (tpm_pt->ops->has_cancel_path) {
> +        pops->has_cancel_path =3D true;
> +        pops->cancel_path =3D g_strdup(tpm_pt->ops->cancel_path);
> +    }
> +
> +    ops =3D g_new0(TpmTypeOptions, 1);
> +    if (!ops) {
> +        qapi_free_TPMPassthroughOptions(pops);
> +        return NULL;
> +    }

Same here

> +    ops->type =3D TPM_TYPE_PASSTHROUGH;
> +    ops->u.passthrough.data =3D pops;
> +
> +    return ops;
> +}
> +
>  static const QemuOptDesc tpm_passthrough_cmdline_opts[] =3D {
>      TPM_STANDARD_CMDLINE_OPTS,
>      {
> @@ -443,12 +482,14 @@ static const TPMDriverOps tpm_passthrough_driver =
=3D {
>      .get_tpm_established_flag =3D tpm_passthrough_get_tpm_established_fl=
ag,
>      .reset_tpm_established_flag =3D tpm_passthrough_reset_tpm_establishe=
d_flag,
>      .get_tpm_version          =3D tpm_passthrough_get_tpm_version,
> +    .get_tpm_options          =3D tpm_passthrough_get_tpm_options,
>  };
>
>  static void tpm_passthrough_inst_init(Object *obj)
>  {
>      TPMPassthruState *tpm_pt =3D TPM_PASSTHROUGH(obj);
>
> +    tpm_pt->ops =3D g_new0(TPMPassthroughOptions, 1);
>      tpm_pt->tpm_fd =3D -1;
>      tpm_pt->cancel_fd =3D -1;
>  }
> @@ -462,6 +503,7 @@ static void tpm_passthrough_inst_finalize(Object *obj=
)
>      qemu_close(tpm_pt->tpm_fd);
>      qemu_close(tpm_pt->cancel_fd);
>      g_free(tpm_pt->tpm_dev);
> +    qapi_free_TPMPassthroughOptions(tpm_pt->ops);
>  }
>
>  static void tpm_passthrough_class_init(ObjectClass *klass, void *data)
> diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
> index d6ae463..6e5bb8d 100644
> --- a/include/sysemu/tpm_backend.h
> +++ b/include/sysemu/tpm_backend.h
> @@ -48,10 +48,9 @@ struct TPMBackend {
>      GThreadPool *thread_pool;
>      TPMRecvDataCB *recv_data_callback;
>
> +    /* <public> */
>      char *id;
>      enum TpmModel fe_model;
> -    char *path;
> -    char *cancel_path;
>
>      QLIST_ENTRY(TPMBackend) list;
>  };
> @@ -97,6 +96,8 @@ struct TPMDriverOps {
>      int (*reset_tpm_established_flag)(TPMBackend *t, uint8_t locty);
>
>      TPMVersion (*get_tpm_version)(TPMBackend *t);
> +
> +    TpmTypeOptions *(*get_tpm_options)(TPMBackend *t);
>  };
>
>  /**
> @@ -206,6 +207,26 @@ void tpm_backend_open(TPMBackend *s, Error **errp);
>   */
>  TPMVersion tpm_backend_get_tpm_version(TPMBackend *s);
>
> +/**
> + * tpm_backend_get_tpm_options:
> + * @s: the backend
> + *
> + * Get the backend configuration options
> + *
> + * Returns newly allocated TpmTypeOptions
> + */
> +TpmTypeOptions *tpm_backend_get_tpm_options(TPMBackend *s);
> +
> +/**
> + * tpm_backend_query_tpm:
> + * @s: the backend
> + *
> + * Query backend tpm info
> + *
> + * Returns newly allocated TPMInfo
> + */
> +TPMInfo *tpm_backend_query_tpm(TPMBackend *s);
> +
>  TPMBackend *qemu_find_tpm(const char *id);
>
>  const TPMDriverOps *tpm_get_backend_driver(const char *type);
> diff --git a/tpm.c b/tpm.c
> index 2979508..84e9667 100644
> --- a/tpm.c
> +++ b/tpm.c
> @@ -249,36 +249,6 @@ static const TPMDriverOps *tpm_driver_find_by_type(e=
num TpmType type)
>      return NULL;
>  }
>
> -static TPMInfo *qmp_query_tpm_inst(TPMBackend *drv)
> -{
> -    TPMInfo *res =3D g_new0(TPMInfo, 1);
> -    TPMPassthroughOptions *tpo;
> -
> -    res->id =3D g_strdup(drv->id);
> -    res->model =3D drv->fe_model;
> -    res->options =3D g_new0(TpmTypeOptions, 1);
> -
> -    switch (tpm_backend_get_type(drv)) {
> -    case TPM_TYPE_PASSTHROUGH:
> -        res->options->type =3D TPM_TYPE_OPTIONS_KIND_PASSTHROUGH;
> -        tpo =3D g_new0(TPMPassthroughOptions, 1);
> -        res->options->u.passthrough.data =3D tpo;
> -        if (drv->path) {
> -            tpo->path =3D g_strdup(drv->path);
> -            tpo->has_path =3D true;
> -        }
> -        if (drv->cancel_path) {
> -            tpo->cancel_path =3D g_strdup(drv->cancel_path);
> -            tpo->has_cancel_path =3D true;
> -        }
> -        break;
> -    case TPM_TYPE__MAX:
> -        break;
> -    }
> -
> -    return res;
> -}
> -
>  /*
>   * Walk the list of active TPM backends and collect information about th=
em
>   * following the schema description in qapi-schema.json.
> @@ -293,7 +263,7 @@ TPMInfoList *qmp_query_tpm(Error **errp)
>              continue;
>          }
>          info =3D g_new0(TPMInfoList, 1);
> -        info->value =3D qmp_query_tpm_inst(drv);
> +        info->value =3D tpm_backend_query_tpm(drv);
>
>          if (!cur_item) {
>              head =3D cur_item =3D info;
> --
> 2.7.4
>
>



--=20
Marc-Andr=C3=A9 Lureau
