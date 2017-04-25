Received: from eggs.gnu.org ([2001:4830:134:3::10]:46038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1d354N-0002bk-GC
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 14:20:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1d354J-0006pX-Cc
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 14:20:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42834)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1d354J-0006od-3c
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 14:20:07 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3PI91KO141935
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 14:20:04 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a28hfhpyd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 14:20:04 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 25 Apr 2017 12:20:02 -0600
References: <1491575431-32170-1-git-send-email-amarnath.valluri@intel.com>
	<1491575431-32170-2-git-send-email-amarnath.valluri@intel.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 25 Apr 2017 14:19:56 -0400
MIME-Version: 1.0
In-Reply-To: <1491575431-32170-2-git-send-email-amarnath.valluri@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <083d7ebb-268c-c46f-1728-df40b14938da@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/9] tpm-backend: Remove unneeded member
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
Cc: patrick.ohly@intel.com, marcandre.lureau@gmail.com

On 04/07/2017 10:30 AM, Amarnath Valluri wrote:
> TPMDriverOps inside TPMBackend is not required, as it is supposed to be a class
> member. The only possible reason for keeping in TPMBackend was, to get the
> backend type in tpm.c where dedicated backend api, tpm_backend_get_type() is
> present.
>
> Signed-off-by: Amarnath Valluri <amarnath.valluri@intel.com>
> ---
>   hw/tpm/tpm_passthrough.c     | 4 ----
>   include/sysemu/tpm_backend.h | 1 -
>   tpm.c                        | 2 +-
>   3 files changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
> index 9234eb3..a0baf5f 100644
> --- a/hw/tpm/tpm_passthrough.c
> +++ b/hw/tpm/tpm_passthrough.c
> @@ -46,8 +46,6 @@
>   #define TPM_PASSTHROUGH(obj) \
>       OBJECT_CHECK(TPMPassthruState, (obj), TYPE_TPM_PASSTHROUGH)
>
> -static const TPMDriverOps tpm_passthrough_driver;
> -
>   /* data structures */
>   typedef struct TPMPassthruThreadParams {
>       TPMState *tpm_state;
> @@ -462,8 +460,6 @@ static TPMBackend *tpm_passthrough_create(QemuOpts *opts, const char *id)
>       /* let frontend set the fe_model to proper value */
>       tb->fe_model = -1;
>
> -    tb->ops = &tpm_passthrough_driver;
> -
>       if (tpm_passthrough_handle_device_opts(opts, tb)) {
>           goto err_exit;
>       }
> diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
> index b58f52d..e7f590d 100644
> --- a/include/sysemu/tpm_backend.h
> +++ b/include/sysemu/tpm_backend.h
> @@ -50,7 +50,6 @@ struct TPMBackend {
>       enum TpmModel fe_model;
>       char *path;
>       char *cancel_path;
> -    const TPMDriverOps *ops;
>
>       QLIST_ENTRY(TPMBackend) list;
>   };
> diff --git a/tpm.c b/tpm.c
> index 9a7c711..0ee021a 100644
> --- a/tpm.c
> +++ b/tpm.c
> @@ -258,7 +258,7 @@ static TPMInfo *qmp_query_tpm_inst(TPMBackend *drv)
>       res->model = drv->fe_model;
>       res->options = g_new0(TpmTypeOptions, 1);
>
> -    switch (drv->ops->type) {
> +    switch (tpm_backend_get_type(drv)) {
>       case TPM_TYPE_PASSTHROUGH:
>           res->options->type = TPM_TYPE_OPTIONS_KIND_PASSTHROUGH;
>           tpo = g_new0(TPMPassthroughOptions, 1);


Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
