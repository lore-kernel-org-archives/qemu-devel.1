Received: from eggs.gnu.org ([2001:4830:134:3::10]:48382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1d35BZ-0005Zy-Ku
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 14:27:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1d35BV-0001Lq-Iu
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 14:27:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50429
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1d35BV-0001Lk-C1
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 14:27:33 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3PIO6AC110960
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 14:27:32 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2a1v4s7myv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 14:27:31 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 25 Apr 2017 14:27:31 -0400
References: <1491575431-32170-1-git-send-email-amarnath.valluri@intel.com>
	<1491575431-32170-4-git-send-email-amarnath.valluri@intel.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 25 Apr 2017 14:27:28 -0400
MIME-Version: 1.0
In-Reply-To: <1491575431-32170-4-git-send-email-amarnath.valluri@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <2c0cb635-c42d-3ed5-2449-61d992831e45@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/9] tpm-backend: Initialize and free
 data members in it's own methods
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Amarnath Valluri <amarnath.valluri@intel.com>, qemu-devel@nongnu.org
Cc: patrick.ohly@intel.com, marcandre.lureau@gmail.com, berrange@redhat.com

On 04/07/2017 10:30 AM, Amarnath Valluri wrote:
> Initialize and free TPMBackend data members in it's own instance_init() and
> instance_finalize methods.
>
> Took the opportunity to fix object cleanup in tpm_backend_{create,destroy}
> methods
>
> Signed-off-by: Amarnath Valluri <amarnath.valluri@intel.com>
> ---
>   backends/tpm.c           |  8 ++++++--
>   hw/tpm/tpm_passthrough.c | 18 +++++++++++-------
>   2 files changed, 17 insertions(+), 9 deletions(-)
>
> diff --git a/backends/tpm.c b/backends/tpm.c
> index 0ec0c67..99d2b2b 100644
> --- a/backends/tpm.c
> +++ b/backends/tpm.c
> @@ -57,7 +57,7 @@ void tpm_backend_destroy(TPMBackend *s)
>
>       k->ops->destroy(s);
>
> -    tpm_backend_thread_end(s);
> +    object_unref(OBJECT(s));
>   }
>
>   int tpm_backend_init(TPMBackend *s, TPMState *state,
> @@ -182,11 +182,13 @@ static void tpm_backend_prop_set_opened(Object *obj, bool value, Error **errp)
>
>   static void tpm_backend_instance_init(Object *obj)
>   {
> +    TPMBackend *s = TPM_BACKEND(obj);
> +
>       object_property_add_bool(obj, "opened",
>                                tpm_backend_prop_get_opened,
>                                tpm_backend_prop_set_opened,
>                                NULL);
> -
> +    s->fe_model = -1;
>   }
>
>   static void tpm_backend_instance_finalize(Object *obj)
> @@ -194,6 +196,8 @@ static void tpm_backend_instance_finalize(Object *obj)
>       TPMBackend *s = TPM_BACKEND(obj);
>
>       g_free(s->id);
> +    g_free(s->path);
> +    g_free(s->cancel_path);
>       tpm_backend_thread_end(s);
>   }
>
> diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
> index f50d9cf..65831b5 100644
> --- a/hw/tpm/tpm_passthrough.c
> +++ b/hw/tpm/tpm_passthrough.c
> @@ -417,8 +417,6 @@ static TPMBackend *tpm_passthrough_create(QemuOpts *opts, const char *id)
>       TPMPassthruState *tpm_pt = TPM_PASSTHROUGH(tb);
>
>       tb->id = g_strdup(id);
> -    /* let frontend set the fe_model to proper value */
> -    tb->fe_model = -1;
>
>       if (tpm_passthrough_handle_device_opts(opts, tb)) {
>           goto err_exit;
> @@ -432,7 +430,7 @@ static TPMBackend *tpm_passthrough_create(QemuOpts *opts, const char *id)
>       return tb;
>
>   err_exit:
> -    g_free(tb->id);
> +    object_unref(obj);
>
>       return NULL;
>   }
> @@ -445,10 +443,6 @@ static void tpm_passthrough_destroy(TPMBackend *tb)
>
>       qemu_close(tpm_pt->tpm_fd);
>       qemu_close(tpm_pt->cancel_fd);
> -
> -    g_free(tb->id);
> -    g_free(tb->path);
> -    g_free(tb->cancel_path);


Looks like here you are correcting the error from the previous patch...



>       g_free(tpm_pt->tpm_dev);
>   }
>
> @@ -486,10 +480,20 @@ static const TPMDriverOps tpm_passthrough_driver = {
>
>   static void tpm_passthrough_inst_init(Object *obj)
>   {
> +    TPMPassthruState *tpm_pt = TPM_PASSTHROUGH(obj);
> +
> +    tpm_pt->tpm_fd = -1;
> +    tpm_pt->cancel_fd = -1;
>   }
>
>   static void tpm_passthrough_inst_finalize(Object *obj)
>   {
> +    TPMPassthruState *tpm_pt = TPM_PASSTHROUGH(obj);
> +
> +    tpm_passthrough_cancel_cmd(TPM_BACKEND(obj));
> +
> +    qemu_close(tpm_pt->tpm_fd);
> +    qemu_close(tpm_pt->cancel_fd);
>   }

With these I am wondering whether they should not have been moved here 
from tpm_passthrough_destroy()? The appear there as well.

>   static void tpm_passthrough_class_init(ObjectClass *klass, void *data)
