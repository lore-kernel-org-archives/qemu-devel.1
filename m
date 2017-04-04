Received: from eggs.gnu.org ([2001:4830:134:3::10]:53185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cvOI8-0002tu-Fj
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 09:14:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cvOI3-0002Tu-AI
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 09:14:36 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:33156)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cvOI3-0002Tl-6F
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 09:14:31 -0400
Received: by mail-qk0-x244.google.com with SMTP id p22so23630567qka.0
	for <qemu-devel@nongnu.org>; Tue, 04 Apr 2017 06:14:31 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1490965817-16913-1-git-send-email-amarnath.valluri@intel.com>
	<1490965817-16913-2-git-send-email-amarnath.valluri@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9c9636d3-71c9-4649-7684-f72546414bdc@amsat.org>
Date: Tue, 4 Apr 2017 10:14:27 -0300
MIME-Version: 1.0
In-Reply-To: <1490965817-16913-2-git-send-email-amarnath.valluri@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
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

On 03/31/2017 10:10 AM, Amarnath Valluri wrote:
> TPMDriverOps inside TPMBackend is not required, as it is supposed to be a class
> member. The only possible reason for keeping in TPMBackend was, to get the
> backend type in tpm.c where dedicated backend api, tpm_backend_get_type() is
> present.
>
> Signed-off-by: Amarnath Valluri <amarnath.valluri@intel.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
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
> @@ -462,8 +460,6 @@ static TPMBackend *tpm_passthrough_create(QemuOpts *opts, const char *id)
>      /* let frontend set the fe_model to proper value */
>      tb->fe_model = -1;
>
> -    tb->ops = &tpm_passthrough_driver;
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
>      res->model = drv->fe_model;
>      res->options = g_new0(TpmTypeOptions, 1);
>
> -    switch (drv->ops->type) {
> +    switch (tpm_backend_get_type(drv)) {
>      case TPM_TYPE_PASSTHROUGH:
>          res->options->type = TPM_TYPE_OPTIONS_KIND_PASSTHROUGH;
>          tpo = g_new0(TPMPassthroughOptions, 1);
>
