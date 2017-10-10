Received: from eggs.gnu.org ([2001:4830:134:3::10]:48013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e20xn-0005dR-Jf
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 16:17:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e20xk-0004RG-D2
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 16:17:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57510
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e20xk-0004Qr-6r
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 16:17:12 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9AKDpt9140285
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 16:17:09 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dh31dq14h-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 16:17:08 -0400
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 10 Oct 2017 14:17:07 -0600
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
	<20171009225623.29232-22-marcandre.lureau@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 10 Oct 2017 16:17:03 -0400
MIME-Version: 1.0
In-Reply-To: <20171009225623.29232-22-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <792a1bc6-160f-36ff-956d-4f2f3c0f51a5@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 21/42] tpm: move recv_data_callback to TPM
 interface
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
> Simplify the TPM backend setup, move callback to TPM interface.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

> ---
>   hw/tpm/tpm_int.h             |  3 +++
>   include/sysemu/tpm_backend.h |  6 +-----
>   backends/tpm.c               |  4 +---
>   hw/tpm/tpm_emulator.c        |  3 ++-
>   hw/tpm/tpm_passthrough.c     |  3 ++-
>   hw/tpm/tpm_tis.c             | 11 ++++++-----
>   6 files changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/hw/tpm/tpm_int.h b/hw/tpm/tpm_int.h
> index eb02e7760c..9c045b6691 100644
> --- a/hw/tpm/tpm_int.h
> +++ b/hw/tpm/tpm_int.h
> @@ -29,6 +29,9 @@ typedef struct TPMIf {
>
>   typedef struct TPMIfClass {
>       InterfaceClass parent_class;
> +
> +    /* run in thread pool by backend */
> +    void (*request_completed)(TPMIf *obj);
>   } TPMIfClass;
>
>   #define TPM_STANDARD_CMDLINE_OPTS               \
> diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.=
h
> index 3bb90be3de..03ea5a3400 100644
> --- a/include/sysemu/tpm_backend.h
> +++ b/include/sysemu/tpm_backend.h
> @@ -30,8 +30,6 @@
>   typedef struct TPMBackendClass TPMBackendClass;
>   typedef struct TPMBackend TPMBackend;
>
> -typedef void (TPMRecvDataCB)(TPMState *);
> -
>   typedef struct TPMBackendCmd {
>       uint8_t locty;
>       const uint8_t *in;
> @@ -48,7 +46,6 @@ struct TPMBackend {
>       bool opened;
>       TPMState *tpm_state;
>       GThreadPool *thread_pool;
> -    TPMRecvDataCB *recv_data_callback;
>       bool had_startup_error;
>
>       /* <public> */
> @@ -106,8 +103,7 @@ enum TpmType tpm_backend_get_type(TPMBackend *s);
>    *
>    * Returns 0 on success.
>    */
> -int tpm_backend_init(TPMBackend *s, TPMState *state,
> -                     TPMRecvDataCB *datacb);
> +int tpm_backend_init(TPMBackend *s, TPMState *state);
>
>   /**
>    * tpm_backend_startup_tpm:
> diff --git a/backends/tpm.c b/backends/tpm.c
> index 87c5c09179..5763f6f369 100644
> --- a/backends/tpm.c
> +++ b/backends/tpm.c
> @@ -44,11 +44,9 @@ enum TpmType tpm_backend_get_type(TPMBackend *s)
>       return k->type;
>   }
>
> -int tpm_backend_init(TPMBackend *s, TPMState *state,
> -                     TPMRecvDataCB *datacb)
> +int tpm_backend_init(TPMBackend *s, TPMState *state)
>   {
>       s->tpm_state =3D state;
> -    s->recv_data_callback =3D datacb;
>       s->had_startup_error =3D false;
>
>       return 0;
> diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
> index 407ac97651..f04f4e0830 100644
> --- a/hw/tpm/tpm_emulator.c
> +++ b/hw/tpm/tpm_emulator.c
> @@ -176,6 +176,7 @@ static int tpm_emulator_set_locality(TPMEmulator *t=
pm_emu, uint8_t locty_number,
>   static void tpm_emulator_handle_request(TPMBackend *tb, TPMBackendCmd=
 *cmd)
>   {
>       TPMEmulator *tpm_emu =3D TPM_EMULATOR(tb);
> +    TPMIfClass *tic =3D TPM_IF_GET_CLASS(tb->tpm_state);
>       Error *err =3D NULL;
>
>       DPRINTF("processing TPM command");
> @@ -190,7 +191,7 @@ static void tpm_emulator_handle_request(TPMBackend =
*tb, TPMBackendCmd *cmd)
>           goto error;
>       }
>
> -    tb->recv_data_callback(tb->tpm_state);
> +    tic->request_completed(TPM_IF(tb->tpm_state));
>       return;
>
>   error:
> diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
> index 4274164a61..c440aff4b2 100644
> --- a/hw/tpm/tpm_passthrough.c
> +++ b/hw/tpm/tpm_passthrough.c
> @@ -139,13 +139,14 @@ err_exit:
>   static void tpm_passthrough_handle_request(TPMBackend *tb, TPMBackend=
Cmd *cmd)
>   {
>       TPMPassthruState *tpm_pt =3D TPM_PASSTHROUGH(tb);
> +    TPMIfClass *tic =3D TPM_IF_GET_CLASS(tb->tpm_state);
>
>       DPRINTF("tpm_passthrough: processing command %p\n", cmd);
>
>       tpm_passthrough_unix_tx_bufs(tpm_pt, cmd->in, cmd->in_len,
>                                    cmd->out, cmd->out_len, &cmd->selfte=
st_done);
>
> -    tb->recv_data_callback(tb->tpm_state);
> +    tic->request_completed(TPM_IF(tb->tpm_state));
>   }
>
>   static void tpm_passthrough_reset(TPMBackend *tb)
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index dbb50043ac..8c5cac5fa5 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -430,11 +430,10 @@ static void tpm_tis_receive_bh(void *opaque)
>                         TPM_TIS_INT_DATA_AVAILABLE | TPM_TIS_INT_STS_VA=
LID);
>   }
>
> -/*
> - * Callback from the TPM to indicate that the response was received.
> - */
> -static void tpm_tis_receive_cb(TPMState *s)
> +static void tpm_tis_request_completed(TPMIf *ti)
>   {
> +    TPMState *s =3D TPM(ti);
> +
>       bool is_selftest_done =3D s->cmd.selftest_done;
>       uint8_t locty =3D s->cmd.locty;
>       uint8_t l;
> @@ -1078,7 +1077,7 @@ static void tpm_tis_realizefn(DeviceState *dev, E=
rror **errp)
>
>       s->be_driver->fe_model =3D TPM_MODEL_TPM_TIS;
>
> -    if (tpm_backend_init(s->be_driver, s, tpm_tis_receive_cb)) {
> +    if (tpm_backend_init(s->be_driver, s)) {
>           error_setg(errp, "tpm_tis: backend driver with id %s could no=
t be "
>                      "initialized", s->backend);
>           return;
> @@ -1110,11 +1109,13 @@ static void tpm_tis_initfn(Object *obj)
>   static void tpm_tis_class_init(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    TPMIfClass *tc =3D TPM_IF_CLASS(klass);
>
>       dc->realize =3D tpm_tis_realizefn;
>       dc->props =3D tpm_tis_properties;
>       dc->reset =3D tpm_tis_reset;
>       dc->vmsd  =3D &vmstate_tpm_tis;
> +    tc->request_completed =3D tpm_tis_request_completed;
>   }
>
>   static const TypeInfo tpm_tis_info =3D {
