Received: from eggs.gnu.org ([2001:4830:134:3::10]:60340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cvOfQ-0001ej-Ex
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 09:38:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cvOfN-0004Sj-HP
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 09:38:40 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:33738)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cvOfN-0004SU-0c
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 09:38:37 -0400
Received: by mail-lf0-x242.google.com with SMTP id r36so15591547lfi.0
	for <qemu-devel@nongnu.org>; Tue, 04 Apr 2017 06:38:36 -0700 (PDT)
MIME-Version: 1.0
References: <f0ecef1-1e43-ffff-2060-7f0da40dc7c5@redhat.com>
	<1491301699-11436-1-git-send-email-amarnath.valluri@intel.com>
In-Reply-To: <1491301699-11436-1-git-send-email-amarnath.valluri@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 04 Apr 2017 13:38:24 +0000
Message-ID: <CAJ+F1CKG92kaqp=T4F_j1+TrpMLWvXm=p-i8qHZ2V=17=RDY3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 5/7] tmp backend: Add new api to read
 backend tpm options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amarnath Valluri <amarnath.valluri@intel.com>, qemu-devel@nongnu.org

Hi

On Tue, Apr 4, 2017 at 12:32 PM Amarnath Valluri <amarnath.valluri@intel.co=
m>
wrote:

> TPM configuration options are backend implementation details and shall no=
t
> be
> part of base TPMBackend object, and these shall not be accessed directly
> outside
> of the class, hence added a new tpm backend api,
> tpm_backend_get_tpm_options()
> to read the backend configured options.
>
> Added new method, get_tpm_options() to TPMDriverOps., which shall be
> implemented
> by the derived classes to return configured tpm options.
>
> Made TPMPassthroughOptions type inherited from newly defined TPMOptions
> base type.
> The TPMOptions base type is intentionally left empty and supposed to be
> inherited by all backend implementations to define their tpm configuratio=
n
> options.
>
>
General idea seems good to me


> Signed-off-by: Amarnath Valluri <amarnath.valluri@intel.com>
> ---
>  backends/tpm.c               | 12 ++++++----
>  hw/tpm/tpm_passthrough.c     | 55
> +++++++++++++++++++++++++++++++++++---------
>  include/sysemu/tpm_backend.h | 15 ++++++++++--
>  qapi-schema.json             | 14 +++++++++--
>  tpm.c                        | 13 ++---------
>  5 files changed, 78 insertions(+), 31 deletions(-)
>
> diff --git a/backends/tpm.c b/backends/tpm.c
> index 0bdc5af..98aafd8 100644
> --- a/backends/tpm.c
> +++ b/backends/tpm.c
> @@ -153,6 +153,13 @@ TPMVersion tpm_backend_get_tpm_version(TPMBackend *s=
)
>      return k->ops->get_tpm_version(s);
>  }
>
> +TPMOptions *tpm_backend_get_tpm_options(TPMBackend *s)
> +{
> +    TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
> +
> +    return k->ops->get_tpm_options ? k->ops->get_tpm_options(s) : NULL;
> +}
>

Probably can be made mandatory instead.

  static bool tpm_backend_prop_get_opened(Object *obj, Error **errp)
>  {
>      TPMBackend *s =3D TPM_BACKEND(obj);
> @@ -205,9 +212,6 @@ static void tpm_backend_instance_init(Object *obj)
>      s->tpm_state =3D NULL;
>      s->thread_pool =3D NULL;
>      s->recv_data_callback =3D NULL;
> -    s->path =3D NULL;
> -    s->cancel_path =3D NULL;
> -
>  }
>
>  static void tpm_backend_instance_finalize(Object *obj)
> @@ -215,8 +219,6 @@ static void tpm_backend_instance_finalize(Object *obj=
)
>      TPMBackend *s =3D TPM_BACKEND(obj);
>
>      g_free(s->id);
> -    g_free(s->path);
> -    g_free(s->cancel_path);
>
     tpm_backend_thread_end(s);
>  }
>
> diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
> index 5b3bf1c..fce1163 100644
> --- a/hw/tpm/tpm_passthrough.c
> +++ b/hw/tpm/tpm_passthrough.c
> @@ -50,6 +50,7 @@
>  struct TPMPassthruState {
>      TPMBackend parent;
>
> +    TPMPassthroughOptions ops;
>      char *tpm_dev;
>      int tpm_fd;
>      bool tpm_executing;
> @@ -314,15 +315,14 @@ static TPMVersion
> tpm_passthrough_get_tpm_version(TPMBackend *tb)
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
> +    if (tpm_pt->ops.cancel_path) {
> +        fd =3D qemu_open(tpm_pt->ops.cancel_path, O_WRONLY);
>          if (fd < 0) {
>              error_report("Could not open TPM cancel path : %s",
>                           strerror(errno));
> @@ -337,7 +337,7 @@ static int
> tpm_passthrough_open_sysfs_cancel(TPMBackend *tb)
>                       dev) < sizeof(path)) {
>              fd =3D qemu_open(path, O_WRONLY);
>              if (fd >=3D 0) {
> -                tb->cancel_path =3D g_strdup(path);
> +                tpm_pt->ops.cancel_path =3D g_strdup(path);
>              } else {
>                  error_report("tpm_passthrough: Could not open TPM cancel=
 "
>                               "path %s : %s", path, strerror(errno));
> @@ -357,17 +357,24 @@ static int
> tpm_passthrough_handle_device_opts(QemuOpts *opts, TPMBackend *tb)
>      const char *value;
>
>      value =3D qemu_opt_get(opts, "cancel-path");
> -    tb->cancel_path =3D g_strdup(value);
> +    if (value) {
> +        tpm_pt->ops.cancel_path =3D g_strdup(value);
> +        tpm_pt->ops.has_cancel_path =3D true;
> +    } else {
> +        tpm_pt->ops.has_cancel_path =3D false;
> +    }
>
>      value =3D qemu_opt_get(opts, "path");
>      if (!value) {
>          value =3D TPM_PASSTHROUGH_DEFAULT_DEVICE;
> +        tpm_pt->ops.has_path =3D false;
> +    } else {
> +        tpm_pt->ops.has_path =3D true;
>      }
>
> +    tpm_pt->ops.path =3D g_strdup(value);
>      tpm_pt->tpm_dev =3D g_strdup(value);
>
> -    tb->path =3D g_strdup(tpm_pt->tpm_dev);
> -
>      tpm_pt->tpm_fd =3D qemu_open(tpm_pt->tpm_dev, O_RDWR);
>      if (tpm_pt->tpm_fd < 0) {
>          error_report("Cannot access TPM device using '%s': %s",
> @@ -388,8 +395,8 @@ static int tpm_passthrough_handle_device_opts(QemuOpt=
s
> *opts, TPMBackend *tb)
>      tpm_pt->tpm_fd =3D -1;
>
>   err_free_parameters:
> -    g_free(tb->path);
> -    tb->path =3D NULL;
> +    g_free(tpm_pt->ops.path);
> +    tpm_pt->ops.path =3D NULL;
>
>      g_free(tpm_pt->tpm_dev);
>      tpm_pt->tpm_dev =3D NULL;
> @@ -409,7 +416,7 @@ static TPMBackend *tpm_passthrough_create(QemuOpts
> *opts, const char *id)
>          goto err_exit;
>      }
>
> -    tpm_pt->cancel_fd =3D tpm_passthrough_open_sysfs_cancel(tb);
> +    tpm_pt->cancel_fd =3D tpm_passthrough_open_sysfs_cancel(tpm_pt);
>      if (tpm_pt->cancel_fd < 0) {
>          goto err_exit;
>      }
> @@ -430,9 +437,34 @@ static void tpm_passthrough_destroy(TPMBackend *tb)
>
>      qemu_close(tpm_pt->tpm_fd);
>      qemu_close(tpm_pt->cancel_fd);
> +
> +    g_free(tpm_pt->ops.path);
> +    g_free(tpm_pt->ops.cancel_path);
>

hmm, if it was allocated instead, you could use
qapi_free_TPMPassthroughOptions().

I think destroy() should be replaced by object finalizer.

     g_free(tpm_pt->tpm_dev);
>  }
>
> +static TPMOptions *tpm_passthrough_get_tpm_options(TPMBackend *tb)
> +{
> +    TPMPassthruState *tpm_pt =3D TPM_PASSTHROUGH(tb);
> +    TPMPassthroughOptions *ops =3D g_new0(TPMPassthroughOptions, 1);
> +
> +    if (!ops) {
> +        return NULL;
> +    }
> +
> +    if (tpm_pt->ops.has_path) {
> +        ops->has_path =3D true;
> +        ops->path =3D g_strdup(tpm_pt->ops.path);
> +    }
> +
> +    if (tpm_pt->ops.has_cancel_path) {
> +        ops->has_cancel_path =3D true;
> +        ops->cancel_path =3D g_strdup(tpm_pt->ops.cancel_path);
> +    }
> +
> +    return (TPMOptions *)ops;
> +}
> +
>  static const QemuOptDesc tpm_passthrough_cmdline_opts[] =3D {
>      TPM_STANDARD_CMDLINE_OPTS,
>      {
> @@ -461,6 +493,7 @@ static const TPMDriverOps tpm_passthrough_driver =3D =
{
>      .get_tpm_established_flag =3D tpm_passthrough_get_tpm_established_fl=
ag,
>      .reset_tpm_established_flag =3D
> tpm_passthrough_reset_tpm_established_flag,
>      .get_tpm_version          =3D tpm_passthrough_get_tpm_version,
> +    .get_tpm_options          =3D tpm_passthrough_get_tpm_options,
>  };
>
>  static void tpm_passthrough_inst_init(Object *obj)
> diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
> index 98b6112..82348a3 100644
> --- a/include/sysemu/tpm_backend.h
> +++ b/include/sysemu/tpm_backend.h
> @@ -41,10 +41,9 @@ struct TPMBackend {
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
> @@ -81,6 +80,8 @@ struct TPMDriverOps {
>      int (*reset_tpm_established_flag)(TPMBackend *t, uint8_t locty);
>
>      TPMVersion (*get_tpm_version)(TPMBackend *t);
> +
> +    TPMOptions* (*get_tpm_options)(TPMBackend *t);
>  };
>
>
> @@ -213,6 +214,16 @@ void tpm_backend_open(TPMBackend *s, Error **errp);
>   */
>  TPMVersion tpm_backend_get_tpm_version(TPMBackend *s);
>
> +/**
> + * tpm_backend_get_tpm_options:
> + * @s: the backend
> + *
> + * Get the backend configuration options
> + *
> + * Returns newly allocated TPMOptions
> + */
> +TPMOptions *tpm_backend_get_tpm_options(TPMBackend *s);
> +
>  TPMBackend *qemu_find_tpm(const char *id);
>
>  const TPMDriverOps *tpm_get_backend_driver(const char *type);
> diff --git a/qapi-schema.json b/qapi-schema.json
> index b921994..2953cbc 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -5140,6 +5140,16 @@
>  { 'command': 'query-tpm-types', 'returns': ['TpmType'] }
>
>  ##
> +# @TPMOptions:
> +#
> +# Base type for TPM options
> +#
> +# Since: 2.10
> +##
> +{ 'struct': 'TPMOptions',
> +  'data': { } }
> +
> +##
>  # @TPMPassthroughOptions:
>  #
>  # Information about the TPM passthrough type
> @@ -5151,8 +5161,8 @@
>  #
>  # Since: 1.5
>  ##
> -{ 'struct': 'TPMPassthroughOptions', 'data': { '*path' : 'str',
> -                                             '*cancel-path' : 'str'} }
> +{ 'struct': 'TPMPassthroughOptions', 'base': 'TPMOptions',
> +  'data': { '*path' : 'str', '*cancel-path' : 'str'} }
>
>  ##
>  # @TpmTypeOptions:
> diff --git a/tpm.c b/tpm.c
> index 0ee021a..c221000 100644
> --- a/tpm.c
> +++ b/tpm.c
> @@ -252,7 +252,6 @@ static const TPMDriverOps
> *tpm_driver_find_by_type(enum TpmType type)
>  static TPMInfo *qmp_query_tpm_inst(TPMBackend *drv)
>  {
>      TPMInfo *res =3D g_new0(TPMInfo, 1);
> -    TPMPassthroughOptions *tpo;
>
>      res->id =3D g_strdup(drv->id);
>      res->model =3D drv->fe_model;
> @@ -261,16 +260,8 @@ static TPMInfo *qmp_query_tpm_inst(TPMBackend *drv)
>      switch (tpm_backend_get_type(drv)) {
>      case TPM_TYPE_PASSTHROUGH:
>          res->options->type =3D TPM_TYPE_OPTIONS_KIND_PASSTHROUGH;
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
> +        res->options->u.passthrough.data =3D
> +            (TPMPassthroughOptions *)tpm_backend_get_tpm_options(drv);
>

Instead of using a class method, and casting the result, I think it would
make sense to call directly a tpm_passthrough_get_options() function.
Alternatively, add a drv->query_tpm() callback to fill the subclass
implementation/instance details.


         break;
>      case TPM_TYPE__MAX:
>          break;
> --
> 2.7.4
>
>
> --
Marc-Andr=C3=A9 Lureau
