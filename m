Received: from eggs.gnu.org ([2001:4830:134:3::10]:59575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e5Itf-0000CI-CY
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 18:02:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e5Itb-0003yj-CR
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 18:02:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35020
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e5Itb-0003we-73
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 18:02:31 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9JLwgBJ104293
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 18:02:27 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dpyrcvq2k-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 18:02:26 -0400
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 19 Oct 2017 18:02:26 -0400
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
	<20171009225623.29232-25-marcandre.lureau@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 19 Oct 2017 18:02:23 -0400
MIME-Version: 1.0
In-Reply-To: <20171009225623.29232-25-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <8ada207e-8b98-2f24-5e53-8d60870dea4a@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 24/42] tpm-be: call request_completed() out
 of thread
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

On 10/09/2017 06:56 PM, Marc-Andr=C3=A9 Lureau wrote:
> Lift from the backend implementation the responsability to call the
> request_completed() callback outside of thread context. This also

I don't think this is what you are doing here. It's still in thread conte=
xt.

Something is breaking the TIS interface in this patch. The symptom is=20
that SeaBIOS doesn't show its menu anymore.

I have to withdraw my Reviewed-by from this one. It looked sufficiently=20
harmless but it's not.

     Stefan

> simplify frontend/interface work, as they no longer need to care
> whether the callback is called from a different thread.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/tpm/tpm_int.h             |  1 -
>   include/sysemu/tpm_backend.h |  1 +
>   backends/tpm.c               | 15 ++++++++++++++-
>   hw/tpm/tpm_emulator.c        |  2 --
>   hw/tpm/tpm_passthrough.c     |  3 ---
>   hw/tpm/tpm_tis.c             | 36 +++++++++++++----------------------=
-
>   6 files changed, 28 insertions(+), 30 deletions(-)
>
> diff --git a/hw/tpm/tpm_int.h b/hw/tpm/tpm_int.h
> index 9c045b6691..9c49325f03 100644
> --- a/hw/tpm/tpm_int.h
> +++ b/hw/tpm/tpm_int.h
> @@ -30,7 +30,6 @@ typedef struct TPMIf {
>   typedef struct TPMIfClass {
>       InterfaceClass parent_class;
>
> -    /* run in thread pool by backend */
>       void (*request_completed)(TPMIf *obj);
>   } TPMIfClass;
>
> diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.=
h
> index 8d08765b3c..dd4fb288ea 100644
> --- a/include/sysemu/tpm_backend.h
> +++ b/include/sysemu/tpm_backend.h
> @@ -48,6 +48,7 @@ struct TPMBackend {
>       bool opened;
>       GThreadPool *thread_pool;
>       bool had_startup_error;
> +    QEMUBH *bh;
>
>       /* <public> */
>       char *id;
> diff --git a/backends/tpm.c b/backends/tpm.c
> index 86f0e7e915..58f823d54c 100644
> --- a/backends/tpm.c
> +++ b/backends/tpm.c
> @@ -18,14 +18,25 @@
>   #include "qapi/qmp/qerror.h"
>   #include "sysemu/tpm.h"
>   #include "qemu/thread.h"
> +#include "qemu/main-loop.h"
> +
> +static void tpm_backend_request_completed_bh(void *opaque)
> +{
> +    TPMBackend *s =3D TPM_BACKEND(opaque);
> +    TPMIfClass *tic =3D TPM_IF_GET_CLASS(s->tpmif);
> +
> +    tic->request_completed(s->tpmif);
> +}
>
>   static void tpm_backend_worker_thread(gpointer data, gpointer user_da=
ta)
>   {
>       TPMBackend *s =3D TPM_BACKEND(user_data);
> -    TPMBackendClass *k  =3D TPM_BACKEND_GET_CLASS(s);
> +    TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
>
>       assert(k->handle_request !=3D NULL);
>       k->handle_request(s, (TPMBackendCmd *)data);
> +
> +    qemu_bh_schedule(s->bh);
>   }
>
>   static void tpm_backend_thread_end(TPMBackend *s)
> @@ -193,6 +204,7 @@ static void tpm_backend_instance_init(Object *obj)
>                                tpm_backend_prop_set_opened,
>                                NULL);
>       s->fe_model =3D -1;
> +    s->bh =3D qemu_bh_new(tpm_backend_request_completed_bh, s);
>   }
>
>   static void tpm_backend_instance_finalize(Object *obj)
> @@ -202,6 +214,7 @@ static void tpm_backend_instance_finalize(Object *o=
bj)
>       object_unref(OBJECT(s->tpmif));
>       g_free(s->id);
>       tpm_backend_thread_end(s);
> +    qemu_bh_delete(s->bh);
>   }
>
>   static const TypeInfo tpm_backend_info =3D {
> diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
> index 07e7aa4abc..36454837b3 100644
> --- a/hw/tpm/tpm_emulator.c
> +++ b/hw/tpm/tpm_emulator.c
> @@ -176,7 +176,6 @@ static int tpm_emulator_set_locality(TPMEmulator *t=
pm_emu, uint8_t locty_number,
>   static void tpm_emulator_handle_request(TPMBackend *tb, TPMBackendCmd=
 *cmd)
>   {
>       TPMEmulator *tpm_emu =3D TPM_EMULATOR(tb);
> -    TPMIfClass *tic =3D TPM_IF_GET_CLASS(tb->tpmif);
>       Error *err =3D NULL;
>
>       DPRINTF("processing TPM command");
> @@ -191,7 +190,6 @@ static void tpm_emulator_handle_request(TPMBackend =
*tb, TPMBackendCmd *cmd)
>           goto error;
>       }
>
> -    tic->request_completed(tb->tpmif);
>       return;
>
>   error:
> diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
> index 2ad74badca..8c002e4da6 100644
> --- a/hw/tpm/tpm_passthrough.c
> +++ b/hw/tpm/tpm_passthrough.c
> @@ -139,14 +139,11 @@ err_exit:
>   static void tpm_passthrough_handle_request(TPMBackend *tb, TPMBackend=
Cmd *cmd)
>   {
>       TPMPassthruState *tpm_pt =3D TPM_PASSTHROUGH(tb);
> -    TPMIfClass *tic =3D TPM_IF_GET_CLASS(tb->tpmif);
>
>       DPRINTF("tpm_passthrough: processing command %p\n", cmd);
>
>       tpm_passthrough_unix_tx_bufs(tpm_pt, cmd->in, cmd->in_len,
>                                    cmd->out, cmd->out_len, &cmd->selfte=
st_done);
> -
> -    tic->request_completed(tb->tpmif);
>   }
>
>   static void tpm_passthrough_reset(TPMBackend *tb)
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index b3757bfbda..355427ab29 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -76,7 +76,6 @@ typedef struct TPMState {
>       ISADevice busdev;
>       MemoryRegion mmio;
>
> -    QEMUBH *bh;
>       uint32_t offset;
>       uint8_t buf[TPM_TIS_BUFFER_MAX];
>
> @@ -411,10 +410,20 @@ static void tpm_tis_prep_abort(TPMState *s, uint8=
_t locty, uint8_t newlocty)
>       tpm_tis_abort(s, locty);
>   }
>
> -static void tpm_tis_receive_bh(void *opaque)
> +/*
> + * Callback from the TPM to indicate that the response was received.
> + */
> +static void tpm_tis_request_completed(TPMIf *ti)
>   {
> -    TPMState *s =3D opaque;
> -    uint8_t locty =3D s->cmd.locty;
> +    TPMState *s =3D TPM(ti);
> +    uint8_t locty =3D s->locty_number;
> +    uint8_t l;
> +
> +    if (s->cmd.selftest_done) {
> +        for (l =3D 0; l < TPM_TIS_NUM_LOCALITIES; l++) {
> +            s->loc[locty].sts |=3D TPM_TIS_STS_SELFTEST_DONE;
> +        }
> +    }
>
>       tpm_tis_sts_set(&s->loc[locty],
>                       TPM_TIS_STS_VALID | TPM_TIS_STS_DATA_AVAILABLE);
> @@ -430,23 +439,6 @@ static void tpm_tis_receive_bh(void *opaque)
>                         TPM_TIS_INT_DATA_AVAILABLE | TPM_TIS_INT_STS_VA=
LID);
>   }
>
> -static void tpm_tis_request_completed(TPMIf *ti)
> -{
> -    TPMState *s =3D TPM(ti);
> -
> -    bool is_selftest_done =3D s->cmd.selftest_done;
> -    uint8_t locty =3D s->cmd.locty;
> -    uint8_t l;
> -
> -    if (is_selftest_done) {
> -        for (l =3D 0; l < TPM_TIS_NUM_LOCALITIES; l++) {
> -            s->loc[locty].sts |=3D TPM_TIS_STS_SELFTEST_DONE;
> -        }
> -    }
> -
> -    qemu_bh_schedule(s->bh);
> -}
> -
>   /*
>    * Read a byte of response data
>    */
> @@ -1089,8 +1081,6 @@ static void tpm_tis_realizefn(DeviceState *dev, E=
rror **errp)
>           return;
>       }
>
> -    s->bh =3D qemu_bh_new(tpm_tis_receive_bh, s);
> -
>       isa_init_irq(&s->busdev, &s->irq, s->irq_num);
>
>       memory_region_add_subregion(isa_address_space(ISA_DEVICE(dev)),
