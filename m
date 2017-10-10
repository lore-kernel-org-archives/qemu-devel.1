Received: from eggs.gnu.org ([2001:4830:134:3::10]:37669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e1kRc-0002T6-Lh
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 22:38:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e1kRZ-00027O-I5
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 22:38:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58678)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e1kRZ-00026m-9O
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 22:38:53 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9A2cmss101408
	for <qemu-devel@nongnu.org>; Mon, 9 Oct 2017 22:38:48 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dgbtck9g3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 22:38:47 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 9 Oct 2017 20:38:46 -0600
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
	<20171009225623.29232-5-marcandre.lureau@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon, 9 Oct 2017 22:38:42 -0400
MIME-Version: 1.0
In-Reply-To: <20171009225623.29232-5-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <d77d7d64-f64e-b208-0160-40adbb8521b5@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/42] tpm: lookup tpm backend class in
 tpm_driver_find_by_type()
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

On 10/09/2017 06:55 PM, Marc-Andr=C3=A9 Lureau wrote:
> One step towards removing TPMDriverOps and driver registration.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>


> ---
>   tpm.c | 29 +++++++++++++++++++++--------
>   1 file changed, 21 insertions(+), 8 deletions(-)
>
> diff --git a/tpm.c b/tpm.c
> index bc7d7470a8..04de8da5fd 100644
> --- a/tpm.c
> +++ b/tpm.c
> @@ -47,6 +47,24 @@ void tpm_register_driver(const TPMDriverOps *tdo)
>       be_drivers[tdo->type] =3D tdo;
>   }
>
> +static const TPMDriverOps *
> +tpm_driver_find_by_type(enum TpmType type)
> +{
> +    ObjectClass *oc;
> +    TPMBackendClass *bc;
> +    char *typename =3D g_strdup_printf("tpm-%s", TpmType_str(type));
> +
> +    oc =3D object_class_by_name(typename);
> +    g_free(typename);
> +
> +    if (!object_class_dynamic_cast(oc, TYPE_TPM_BACKEND)) {
> +        return NULL;
> +    }
> +
> +    bc =3D TPM_BACKEND_CLASS(oc);
> +    return bc->ops;
> +}
> +
>   /*
>    * Walk the list of available TPM backend drivers and display them on=
 the
>    * screen.
> @@ -58,11 +76,11 @@ static void tpm_display_backend_drivers(void)
>       fprintf(stderr, "Supported TPM types (choose only one):\n");
>
>       for (i =3D 0; i < TPM_TYPE__MAX; i++) {
> -        if (be_drivers[i] =3D=3D NULL) {
> +        const TPMDriverOps *ops =3D tpm_driver_find_by_type(i);
> +        if (!ops) {
>               continue;
>           }
> -        fprintf(stderr, "%12s   %s\n",
> -                TpmType_str(i), be_drivers[i]->desc);
> +        fprintf(stderr, "%12s   %s\n", TpmType_str(i), ops->desc);
>       }
>       fprintf(stderr, "\n");
>   }
> @@ -196,11 +214,6 @@ int tpm_config_parse(QemuOptsList *opts_list, cons=
t char *optarg)
>
>   #endif /* CONFIG_TPM */
>
> -static const TPMDriverOps *tpm_driver_find_by_type(enum TpmType type)
> -{
> -    return be_drivers[type];
> -}
> -
>   /*
>    * Walk the list of active TPM backends and collect information about=
 them
>    * following the schema description in qapi-schema.json.
