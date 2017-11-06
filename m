Received: from eggs.gnu.org ([2001:4830:134:3::10]:49319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eBmfW-0001LW-4u
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 14:02:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eBmfS-0000EV-76
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 14:02:46 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54222
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eBmfS-0000E9-0l
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 14:02:42 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA6IxIjW186354
	for <qemu-devel@nongnu.org>; Mon, 6 Nov 2017 14:02:37 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2e2u0m0q3m-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 14:02:36 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 6 Nov 2017 12:02:36 -0700
References: <20171106183925.16747-1-marcandre.lureau@redhat.com>
	<20171106183925.16747-4-marcandre.lureau@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon, 6 Nov 2017 14:02:31 -0500
MIME-Version: 1.0
In-Reply-To: <20171106183925.16747-4-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <982c744d-01d6-7ac4-fb15-ef3e24a47fc4@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 03/28] tpm-backend: store TPMIf
 interface, improve backend_init()
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

On 11/06/2017 01:39 PM, Marc-Andr=C3=A9 Lureau wrote:
> Store the TPM interface, the actual object may be different from
> TPMState. Keep a reference on the interface, and check the backend
> wasn't already initialized.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>


> ---
>   include/sysemu/tpm.h         |  2 +-
>   include/sysemu/tpm_backend.h |  6 +++---
>   backends/tpm.c               | 11 +++++++++--
>   hw/tpm/tpm_emulator.c        |  4 ++--
>   hw/tpm/tpm_passthrough.c     |  4 ++--
>   hw/tpm/tpm_tis.c             |  2 +-
>   6 files changed, 18 insertions(+), 11 deletions(-)
>
> diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
> index 452cdb9cb7..fb1719e5e4 100644
> --- a/include/sysemu/tpm.h
> +++ b/include/sysemu/tpm.h
> @@ -12,8 +12,8 @@
>   #ifndef QEMU_TPM_H
>   #define QEMU_TPM_H
>
> -#include "qemu/option.h"
>   #include "qom/object.h"
> +#include "qapi-types.h"
>
>   typedef struct TPMState TPMState;
>
> diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.=
h
> index 03ea5a3400..b5f21ed8f1 100644
> --- a/include/sysemu/tpm_backend.h
> +++ b/include/sysemu/tpm_backend.h
> @@ -43,8 +43,8 @@ struct TPMBackend {
>       Object parent;
>
>       /*< protected >*/
> +    TPMIf *tpmif;
>       bool opened;
> -    TPMState *tpm_state;
>       GThreadPool *thread_pool;
>       bool had_startup_error;
>
> @@ -96,14 +96,14 @@ enum TpmType tpm_backend_get_type(TPMBackend *s);
>   /**
>    * tpm_backend_init:
>    * @s: the backend to initialized
> - * @state: TPMState
> + * @tpmif: TPM interface
>    * @datacb: callback for sending data to frontend
>    *
>    * Initialize the backend with the given variables.
>    *
>    * Returns 0 on success.
>    */
> -int tpm_backend_init(TPMBackend *s, TPMState *state);
> +int tpm_backend_init(TPMBackend *s, TPMIf *tpmif);
>
>   /**
>    * tpm_backend_startup_tpm:
> diff --git a/backends/tpm.c b/backends/tpm.c
> index 1e416d7f90..86f0e7e915 100644
> --- a/backends/tpm.c
> +++ b/backends/tpm.c
> @@ -43,9 +43,15 @@ enum TpmType tpm_backend_get_type(TPMBackend *s)
>       return k->type;
>   }
>
> -int tpm_backend_init(TPMBackend *s, TPMState *state)
> +int tpm_backend_init(TPMBackend *s, TPMIf *tpmif)
>   {
> -    s->tpm_state =3D state;
> +    if (s->tpmif) {
> +        return -1;
> +    }
> +
> +    s->tpmif =3D tpmif;
> +    object_ref(OBJECT(tpmif));
> +
>       s->had_startup_error =3D false;
>
>       return 0;
> @@ -193,6 +199,7 @@ static void tpm_backend_instance_finalize(Object *o=
bj)
>   {
>       TPMBackend *s =3D TPM_BACKEND(obj);
>
> +    object_unref(OBJECT(s->tpmif));
>       g_free(s->id);
>       tpm_backend_thread_end(s);
>   }
> diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
> index 9aaec8e3ef..6bf025c7e2 100644
> --- a/hw/tpm/tpm_emulator.c
> +++ b/hw/tpm/tpm_emulator.c
> @@ -176,7 +176,7 @@ static int tpm_emulator_set_locality(TPMEmulator *t=
pm_emu, uint8_t locty_number,
>   static void tpm_emulator_handle_request(TPMBackend *tb, TPMBackendCmd=
 *cmd)
>   {
>       TPMEmulator *tpm_emu =3D TPM_EMULATOR(tb);
> -    TPMIfClass *tic =3D TPM_IF_GET_CLASS(tb->tpm_state);
> +    TPMIfClass *tic =3D TPM_IF_GET_CLASS(tb->tpmif);
>       Error *err =3D NULL;
>
>       DPRINTF("processing TPM command");
> @@ -191,7 +191,7 @@ static void tpm_emulator_handle_request(TPMBackend =
*tb, TPMBackendCmd *cmd)
>           goto error;
>       }
>
> -    tic->request_completed(TPM_IF(tb->tpm_state));
> +    tic->request_completed(tb->tpmif);
>       return;
>
>   error:
> diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
> index c440aff4b2..2ad74badca 100644
> --- a/hw/tpm/tpm_passthrough.c
> +++ b/hw/tpm/tpm_passthrough.c
> @@ -139,14 +139,14 @@ err_exit:
>   static void tpm_passthrough_handle_request(TPMBackend *tb, TPMBackend=
Cmd *cmd)
>   {
>       TPMPassthruState *tpm_pt =3D TPM_PASSTHROUGH(tb);
> -    TPMIfClass *tic =3D TPM_IF_GET_CLASS(tb->tpm_state);
> +    TPMIfClass *tic =3D TPM_IF_GET_CLASS(tb->tpmif);
>
>       DPRINTF("tpm_passthrough: processing command %p\n", cmd);
>
>       tpm_passthrough_unix_tx_bufs(tpm_pt, cmd->in, cmd->in_len,
>                                    cmd->out, cmd->out_len, &cmd->selfte=
st_done);
>
> -    tic->request_completed(TPM_IF(tb->tpm_state));
> +    tic->request_completed(tb->tpmif);
>   }
>
>   static void tpm_passthrough_reset(TPMBackend *tb)
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index c5c534d7f2..34ceec91c3 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -1078,7 +1078,7 @@ static void tpm_tis_realizefn(DeviceState *dev, E=
rror **errp)
>
>       s->be_driver->fe_model =3D TPM_MODEL_TPM_TIS;
>
> -    if (tpm_backend_init(s->be_driver, s)) {
> +    if (tpm_backend_init(s->be_driver, TPM_IF(s))) {
>           error_setg(errp, "tpm_tis: backend driver with id %s could no=
t be "
>                      "initialized", s->backend);
>           return;
