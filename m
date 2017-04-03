Received: from eggs.gnu.org ([2001:4830:134:3::10]:49645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cv5N1-0004D4-Kv
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 13:02:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cv5N0-0003uB-HO
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 13:02:23 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:36682)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cv5N0-0003tr-5M
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 13:02:22 -0400
Received: by mail-lf0-x241.google.com with SMTP id n78so13485044lfi.3
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 10:02:21 -0700 (PDT)
MIME-Version: 1.0
References: <1490965817-16913-1-git-send-email-amarnath.valluri@intel.com>
	<1490965817-16913-2-git-send-email-amarnath.valluri@intel.com>
In-Reply-To: <1490965817-16913-2-git-send-email-amarnath.valluri@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 03 Apr 2017 17:02:09 +0000
Message-ID: <CAJ+F1C+EbE=rb7Dkz7pd1XDbDXVO8w09nQAPauSyBvXjfX_3yA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/7] tpm-backend: Remove unneeded member
 variable from backend class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amarnath Valluri <amarnath.valluri@intel.com>, qemu-devel@nongnu.org
Cc: patrick.ohly@intel.com, stefanb@linux.vnet.ibm.com

Hi

On Fri, Mar 31, 2017 at 4:58 PM Amarnath Valluri <amarnath.valluri@intel.co=
m>
wrote:

> TPMDriverOps inside TPMBackend is not required, as it is supposed to be a
> class
> member. The only possible reason for keeping in TPMBackend was, to get th=
e
> backend type in tpm.c where dedicated backend api, tpm_backend_get_type()
> is
> present.
>
> Signed-off-by: Amarnath Valluri <amarnath.valluri@intel.com>
>


Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


---
>  hw/tpm/tpm_passthrough.c     | 4 ----
>  include/sysemu/tpm_backend.h | 1 -
>  tpm.c                        | 2 +-
>  3 files changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
> index 9234eb3..a0baf5f 100644
> --- a/hw/tpm/tpm_passthrough.c
> +++ b/hw/tpm/tpm_passthrough.c
> @@ -46,8 +46,6 @@
>  #define TPM_PASSTHROUGH(obj) \
>      OBJECT_CHECK(TPMPassthruState, (obj), TYPE_TPM_PASSTHROUGH)
>
> -static const TPMDriverOps tpm_passthrough_driver;
> -
>  /* data structures */
>  typedef struct TPMPassthruThreadParams {
>      TPMState *tpm_state;
> @@ -462,8 +460,6 @@ static TPMBackend *tpm_passthrough_create(QemuOpts
> *opts, const char *id)
>      /* let frontend set the fe_model to proper value */
>      tb->fe_model =3D -1;
>
> -    tb->ops =3D &tpm_passthrough_driver;
> -
>      if (tpm_passthrough_handle_device_opts(opts, tb)) {
>          goto err_exit;
>      }
> diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
> index b58f52d..e7f590d 100644
> --- a/include/sysemu/tpm_backend.h
> +++ b/include/sysemu/tpm_backend.h
> @@ -50,7 +50,6 @@ struct TPMBackend {
>      enum TpmModel fe_model;
>      char *path;
>      char *cancel_path;
> -    const TPMDriverOps *ops;
>
>      QLIST_ENTRY(TPMBackend) list;
>  };
> diff --git a/tpm.c b/tpm.c
> index 9a7c711..0ee021a 100644
> --- a/tpm.c
> +++ b/tpm.c
> @@ -258,7 +258,7 @@ static TPMInfo *qmp_query_tpm_inst(TPMBackend *drv)
>      res->model =3D drv->fe_model;
>      res->options =3D g_new0(TpmTypeOptions, 1);
>
> -    switch (drv->ops->type) {
> +    switch (tpm_backend_get_type(drv)) {
>      case TPM_TYPE_PASSTHROUGH:
>          res->options->type =3D TPM_TYPE_OPTIONS_KIND_PASSTHROUGH;
>          tpo =3D g_new0(TPMPassthroughOptions, 1);
> --
> 2.7.4
>
>
> --
Marc-Andr=C3=A9 Lureau
