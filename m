Received: from eggs.gnu.org ([2001:4830:134:3::10]:48926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e210k-0007Om-HF
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 16:20:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e210h-0005Ze-7K
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 16:20:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58952)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e210g-0005YX-Pz
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 16:20:15 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9AKJdSY119014
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 16:20:09 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dgyvnat1t-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 16:20:08 -0400
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 10 Oct 2017 16:20:07 -0400
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
	<20171009225623.29232-26-marcandre.lureau@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 10 Oct 2017 16:20:04 -0400
MIME-Version: 1.0
In-Reply-To: <20171009225623.29232-26-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <3258fa8f-8ef3-a43a-aac0-069648a27a47@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 25/42] tpm-be: report error instead of
 front-end
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
> Backend can give more accurate error description, and lift out the job
> from the frontend.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

> ---
>   include/sysemu/tpm_backend.h | 3 ++-
>   backends/tpm.c               | 3 ++-
>   hw/tpm/tpm_tis.c             | 4 +---
>   3 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.=
h
> index dd4fb288ea..51dfc0de9c 100644
> --- a/include/sysemu/tpm_backend.h
> +++ b/include/sysemu/tpm_backend.h
> @@ -100,12 +100,13 @@ enum TpmType tpm_backend_get_type(TPMBackend *s);
>    * @s: the backend to initialized
>    * @tpmif: TPM interface
>    * @datacb: callback for sending data to frontend
> + * @errp: a pointer to return the #Error object if an error occurs.
>    *
>    * Initialize the backend with the given variables.
>    *
>    * Returns 0 on success.
>    */
> -int tpm_backend_init(TPMBackend *s, TPMIf *tpmif);
> +int tpm_backend_init(TPMBackend *s, TPMIf *tpmif, Error **errp);
>
>   /**
>    * tpm_backend_startup_tpm:
> diff --git a/backends/tpm.c b/backends/tpm.c
> index 58f823d54c..7b108bd5d8 100644
> --- a/backends/tpm.c
> +++ b/backends/tpm.c
> @@ -54,9 +54,10 @@ enum TpmType tpm_backend_get_type(TPMBackend *s)
>       return k->type;
>   }
>
> -int tpm_backend_init(TPMBackend *s, TPMIf *tpmif)
> +int tpm_backend_init(TPMBackend *s, TPMIf *tpmif, Error **errp)
>   {
>       if (s->tpmif) {
> +        error_setg(errp, "TPM backend '%s' is already initialized", s-=
>id);
>           return -1;
>       }
>
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index 355427ab29..2fbc760730 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -1069,9 +1069,7 @@ static void tpm_tis_realizefn(DeviceState *dev, E=
rror **errp)
>
>       s->be_driver->fe_model =3D TPM_MODEL_TPM_TIS;
>
> -    if (tpm_backend_init(s->be_driver, TPM_IF(s))) {
> -        error_setg(errp, "tpm_tis: backend driver with id %s could not=
 be "
> -                   "initialized", s->backend);
> +    if (tpm_backend_init(s->be_driver, TPM_IF(s), errp)) {
>           return;
>       }
>
