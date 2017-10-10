Received: from eggs.gnu.org ([2001:4830:134:3::10]:55131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e21N5-0008BV-0K
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 16:43:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e21N0-0007LL-4s
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 16:43:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44872)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e21Mz-0007Km-RV
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 16:43:18 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9AKhE1v047388
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 16:43:14 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dh30r00cf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 16:43:14 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 10 Oct 2017 16:43:13 -0400
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
	<20171009225623.29232-39-marcandre.lureau@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 10 Oct 2017 16:43:10 -0400
MIME-Version: 1.0
In-Reply-To: <20171009225623.29232-39-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <232c73f8-d745-14b5-caed-b5de8d6863de@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 38/42] tpm: add TPM interface to lookup TPM
 version
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
> Do not hardcode TPM device model to lookup version, use an interface
> instead.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   include/sysemu/tpm.h | 5 ++---
>   hw/tpm/tpm_tis.c     | 5 +++--
>   2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
> index dbd2b0cc7a..9439330cf1 100644
> --- a/include/sysemu/tpm.h
> +++ b/include/sysemu/tpm.h
> @@ -38,6 +38,7 @@ typedef struct TPMIfClass {
>
>       enum TpmModel model;
>       void (*request_completed)(TPMIf *obj);
> +    enum TPMVersion (*get_version)(TPMIf *obj);
>   } TPMIfClass;
>
>   int tpm_config_parse(QemuOptsList *opts_list, const char *optarg);
> @@ -53,15 +54,13 @@ static inline TPMIf *tpm_find(void)
>       return TPM_IF(obj);
>   }
>
> -TPMVersion tpm_tis_get_tpm_version(Object *obj);
> -
>   static inline TPMVersion tpm_get_version(TPMIf *ti)
>   {
>       if (!ti) {
>           return TPM_VERSION_UNSPEC;
>       }
>
> -    return tpm_tis_get_tpm_version(OBJECT(ti));
> +    return TPM_IF_GET_CLASS(ti)->get_version(ti);
>   }
>
>   #endif /* QEMU_TPM_H */
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index 954b7b0e5d..6aac9bfe6b 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -989,9 +989,9 @@ static void tpm_tis_realloc_buffer(TPMSizedBuffer *=
sb)
>   /*
>    * Get the TPMVersion of the backend device being used
>    */
> -TPMVersion tpm_tis_get_tpm_version(Object *obj)
> +static enum TPMVersion tpm_tis_get_tpm_version(TPMIf *ti)
>   {
> -    TPMState *s =3D TPM(obj);
> +    TPMState *s =3D TPM(ti);
>
>       return tpm_backend_get_tpm_version(s->be_driver);
>   }
> @@ -1097,6 +1097,7 @@ static void tpm_tis_class_init(ObjectClass *klass=
, void *data)
>       dc->reset =3D tpm_tis_reset;
>       dc->vmsd  =3D &vmstate_tpm_tis;
>       tc->model =3D TPM_MODEL_TPM_TIS;
> +    tc->get_version =3D tpm_tis_get_tpm_version;
>       tc->request_completed =3D tpm_tis_request_completed;
>   }
>

Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
