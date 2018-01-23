Received: from eggs.gnu.org ([2001:4830:134:3::10]:57459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ee3Ti-0004fO-7F
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 13:39:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ee3Tf-000472-2M
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 13:39:26 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53870
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1ee3Te-00045r-T7
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 13:39:23 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0NIYnaC018784
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 13:39:22 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fp82fppsd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 13:39:20 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 23 Jan 2018 11:39:20 -0700
References: <20180119141105.29095-1-marcandre.lureau@redhat.com>
	<20180119141105.29095-3-marcandre.lureau@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 23 Jan 2018 13:39:17 -0500
MIME-Version: 1.0
In-Reply-To: <20180119141105.29095-3-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <757c53c8-c3ba-aa35-0fb5-c6b8807ab3e5@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/5] tpm: replace GThreadPool with AIO
 threadpool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

On 01/19/2018 09:11 AM, Marc-Andr=C3=A9 Lureau wrote:
> The TPM backend uses a GThreadPool to handle IO in a seperate
> thread. However, GThreadPool isn't integrated with Qemu main loops,
> making it unnecessarily complicated to deal with.
>
> Qemu has a AIO threadpool, that is better integrated with loops and
> various IO functions, provides completion BH by default etc.
>
> Remove the only user of GThreadPool from qemu, use AIO threadpool.
>
> Note that the backend:
> - no longer accepts queing multiple requests (unneeded so far)
> - increase ref to itself when handling a command, for extra safety
> - tpm_backend_thread_end() is renamed tpm_backend_finish_sync() and
> will wait for completion of BH (request_completed), which will help
> migration handling.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

I have been using this for a while:
Tested-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>


> ---
>   include/sysemu/tpm_backend.h | 12 ++++++++--
>   backends/tpm.c               | 52 +++++++++++++++++++++++------------=
---------
>   2 files changed, 37 insertions(+), 27 deletions(-)
>
> diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.=
h
> index 0d6c994a62..a69593e0cd 100644
> --- a/include/sysemu/tpm_backend.h
> +++ b/include/sysemu/tpm_backend.h
> @@ -45,9 +45,8 @@ struct TPMBackend {
>       /*< protected >*/
>       TPMIf *tpmif;
>       bool opened;
> -    GThreadPool *thread_pool;
>       bool had_startup_error;
> -    QEMUBH *bh;
> +    TPMBackendCmd *cmd;
>
>       /* <public> */
>       char *id;
> @@ -196,6 +195,15 @@ TPMVersion tpm_backend_get_tpm_version(TPMBackend =
*s);
>    */
>   size_t tpm_backend_get_buffer_size(TPMBackend *s);
>
> +/**
> + * tpm_backend_finish_sync:
> + * @s: the backend to call into
> + *
> + * Finish the pending command synchronously (this will call aio_poll()
> + * on qemu main AIOContext until it ends)
> + */
> +void tpm_backend_finish_sync(TPMBackend *s);
> +
>   /**
>    * tpm_backend_query_tpm:
>    * @s: the backend
> diff --git a/backends/tpm.c b/backends/tpm.c
> index 91222c5164..143807aa37 100644
> --- a/backends/tpm.c
> +++ b/backends/tpm.c
> @@ -19,30 +19,35 @@
>   #include "sysemu/tpm.h"
>   #include "qemu/thread.h"
>   #include "qemu/main-loop.h"
> +#include "block/thread-pool.h"
> +#include "qemu/error-report.h"
>
> -static void tpm_backend_request_completed_bh(void *opaque)
> +static void tpm_backend_request_completed(void *opaque, int ret)
>   {
>       TPMBackend *s =3D TPM_BACKEND(opaque);
>       TPMIfClass *tic =3D TPM_IF_GET_CLASS(s->tpmif);
>
>       tic->request_completed(s->tpmif);
> +
> +    /* no need for atomic, as long the BQL is taken */
> +    s->cmd =3D NULL;
> +    object_unref(OBJECT(s));
>   }
>
> -static void tpm_backend_worker_thread(gpointer data, gpointer user_dat=
a)
> +static int tpm_backend_worker_thread(gpointer data)
>   {
> -    TPMBackend *s =3D TPM_BACKEND(user_data);
> +    TPMBackend *s =3D TPM_BACKEND(data);
>       TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
>
> -    k->handle_request(s, (TPMBackendCmd *)data);
> +    k->handle_request(s, s->cmd);
>
> -    qemu_bh_schedule(s->bh);
> +    return 0;
>   }
>
> -static void tpm_backend_thread_end(TPMBackend *s)
> +void tpm_backend_finish_sync(TPMBackend *s)
>   {
> -    if (s->thread_pool) {
> -        g_thread_pool_free(s->thread_pool, FALSE, TRUE);
> -        s->thread_pool =3D NULL;
> +    while (s->cmd) {
> +        aio_poll(qemu_get_aio_context(), true);
>       }
>   }
>
> @@ -74,10 +79,7 @@ int tpm_backend_startup_tpm(TPMBackend *s, size_t bu=
ffersize)
>       TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
>
>       /* terminate a running TPM */
> -    tpm_backend_thread_end(s);
> -
> -    s->thread_pool =3D g_thread_pool_new(tpm_backend_worker_thread, s,=
 1, TRUE,
> -                                       NULL);
> +    tpm_backend_finish_sync(s);
>
>       res =3D k->startup_tpm ? k->startup_tpm(s, buffersize) : 0;
>
> @@ -93,7 +95,17 @@ bool tpm_backend_had_startup_error(TPMBackend *s)
>
>   void tpm_backend_deliver_request(TPMBackend *s, TPMBackendCmd *cmd)
>   {
> -    g_thread_pool_push(s->thread_pool, cmd, NULL);
> +    ThreadPool *pool =3D aio_get_thread_pool(qemu_get_aio_context());
> +
> +    if (s->cmd !=3D NULL) {
> +        error_report("There is a TPM request pending");
> +        return;
> +    }
> +
> +    s->cmd =3D cmd;
> +    object_ref(OBJECT(s));
> +    thread_pool_submit_aio(pool, tpm_backend_worker_thread, s,
> +                           tpm_backend_request_completed, s);
>   }
>
>   void tpm_backend_reset(TPMBackend *s)
> @@ -104,7 +116,7 @@ void tpm_backend_reset(TPMBackend *s)
>           k->reset(s);
>       }
>
> -    tpm_backend_thread_end(s);
> +    tpm_backend_finish_sync(s);
>
>       s->had_startup_error =3D false;
>   }
> @@ -159,28 +171,18 @@ TPMInfo *tpm_backend_query_tpm(TPMBackend *s)
>       return info;
>   }
>
> -static void tpm_backend_instance_init(Object *obj)
> -{
> -    TPMBackend *s =3D TPM_BACKEND(obj);
> -
> -    s->bh =3D qemu_bh_new(tpm_backend_request_completed_bh, s);
> -}
> -
>   static void tpm_backend_instance_finalize(Object *obj)
>   {
>       TPMBackend *s =3D TPM_BACKEND(obj);
>
>       object_unref(OBJECT(s->tpmif));
>       g_free(s->id);
> -    tpm_backend_thread_end(s);
> -    qemu_bh_delete(s->bh);
>   }
>
>   static const TypeInfo tpm_backend_info =3D {
>       .name =3D TYPE_TPM_BACKEND,
>       .parent =3D TYPE_OBJECT,
>       .instance_size =3D sizeof(TPMBackend),
> -    .instance_init =3D tpm_backend_instance_init,
>       .instance_finalize =3D tpm_backend_instance_finalize,
>       .class_size =3D sizeof(TPMBackendClass),
>       .abstract =3D true,
