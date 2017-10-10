Received: from eggs.gnu.org ([2001:4830:134:3::10]:52265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e21Br-0004BC-KI
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 16:31:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e21Bo-0002ye-H0
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 16:31:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35134)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e21Bo-0002yU-82
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 16:31:44 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9AKVG12033291
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 16:31:39 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dh2mx93yp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 16:31:39 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 10 Oct 2017 14:31:38 -0600
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
	<20171009225623.29232-32-marcandre.lureau@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 10 Oct 2017 16:31:35 -0400
MIME-Version: 1.0
In-Reply-To: <20171009225623.29232-32-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <c8f20c4a-3366-dad6-a5d4-2cafc4beee21@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 31/42] tpm-backend: move set 'id' to common
 code
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
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

> ---
>   include/sysemu/tpm_backend.h |  2 +-
>   hw/tpm/tpm_emulator.c        | 12 +++---------
>   hw/tpm/tpm_passthrough.c     |  9 +++------
>   tpm.c                        |  3 ++-
>   4 files changed, 9 insertions(+), 17 deletions(-)
>
> diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.=
h
> index 594bb50782..881be97ee3 100644
> --- a/include/sysemu/tpm_backend.h
> +++ b/include/sysemu/tpm_backend.h
> @@ -64,7 +64,7 @@ struct TPMBackendClass {
>       /* get a descriptive text of the backend to display to the user *=
/
>       const char *desc;
>
> -    TPMBackend *(*create)(QemuOpts *opts, const char *id);
> +    TPMBackend *(*create)(QemuOpts *opts);
>
>       /* start up the TPM on the backend - optional */
>       int (*startup_tpm)(TPMBackend *t);
> diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
> index 36454837b3..315819329b 100644
> --- a/hw/tpm/tpm_emulator.c
> +++ b/hw/tpm/tpm_emulator.c
> @@ -453,22 +453,16 @@ err:
>       return -1;
>   }
>
> -static TPMBackend *tpm_emulator_create(QemuOpts *opts, const char *id)
> +static TPMBackend *tpm_emulator_create(QemuOpts *opts)
>   {
>       TPMBackend *tb =3D TPM_BACKEND(object_new(TYPE_TPM_EMULATOR));
>
> -    tb->id =3D g_strdup(id);
> -
>       if (tpm_emulator_handle_device_opts(TPM_EMULATOR(tb), opts)) {
> -        goto err_exit;
> +        object_unref(OBJECT(tb));
> +        return NULL;
>       }
>
>       return tb;
> -
> -err_exit:
> -    object_unref(OBJECT(tb));
> -
> -    return NULL;
>   }
>
>   static TpmTypeOptions *tpm_emulator_get_tpm_options(TPMBackend *tb)
> diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
> index 9326cbfdc9..7371d50739 100644
> --- a/hw/tpm/tpm_passthrough.c
> +++ b/hw/tpm/tpm_passthrough.c
> @@ -284,13 +284,10 @@ tpm_passthrough_handle_device_opts(TPMPassthruSta=
te *tpm_pt, QemuOpts *opts)
>       return 1;
>   }
>
> -static TPMBackend *tpm_passthrough_create(QemuOpts *opts, const char *=
id)
> +static TPMBackend *tpm_passthrough_create(QemuOpts *opts)
>   {
>       Object *obj =3D object_new(TYPE_TPM_PASSTHROUGH);
> -    TPMBackend *tb =3D TPM_BACKEND(obj);
> -    TPMPassthruState *tpm_pt =3D TPM_PASSTHROUGH(tb);
> -
> -    tb->id =3D g_strdup(id);
> +    TPMPassthruState *tpm_pt =3D TPM_PASSTHROUGH(obj);
>
>       if (tpm_passthrough_handle_device_opts(tpm_pt, opts)) {
>           goto err_exit;
> @@ -301,7 +298,7 @@ static TPMBackend *tpm_passthrough_create(QemuOpts =
*opts, const char *id)
>           goto err_exit;
>       }
>
> -    return tb;
> +    return TPM_BACKEND(obj);
>
>   err_exit:
>       object_unref(obj);
> diff --git a/tpm.c b/tpm.c
> index a46ee5f144..37298f3f03 100644
> --- a/tpm.c
> +++ b/tpm.c
> @@ -129,11 +129,12 @@ static int tpm_init_tpmdev(void *dummy, QemuOpts =
*opts, Error **errp)
>           return 1;
>       }
>
> -    drv =3D be->create(opts, id);
> +    drv =3D be->create(opts);
>       if (!drv) {
>           return 1;
>       }
>
> +    drv->id =3D g_strdup(id);
>       QLIST_INSERT_HEAD(&tpm_backends, drv, list);
>
>       return 0;
