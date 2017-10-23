Received: from eggs.gnu.org ([2001:4830:134:3::10]:35868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e6dBN-0004S8-Kg
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 09:54:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e6dBI-0002xl-PH
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 09:54:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36906
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e6dBI-0002wS-Io
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 09:54:16 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9NDs9oC074349
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 09:54:11 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dsh6y1uym-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 23 Oct 2017 09:54:10 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 23 Oct 2017 07:53:50 -0600
References: <20171023120200.DE9BC74569A@zero.eik.bme.hu>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon, 23 Oct 2017 09:53:46 -0400
MIME-Version: 1.0
In-Reply-To: <20171023120200.DE9BC74569A@zero.eik.bme.hu>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <0d188b16-7824-81d4-6bae-58f0cb77a452@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2] Fix compile with --disable-tpm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Philippe Mathieu-Daude <f4bug@amsat.org>

On 10/23/2017 06:24 AM, BALATON Zoltan wrote:
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Tested-by: Stefan Berger <stefanb@linux.vnet.ibm.com>


> ---
>   tpm.c | 35 ++++++++++++++++++-----------------
>   1 file changed, 18 insertions(+), 17 deletions(-)
>
> diff --git a/tpm.c b/tpm.c
> index 45520f5..ed78ead 100644
> --- a/tpm.c
> +++ b/tpm.c
> @@ -30,8 +30,6 @@ void tpm_register_model(enum TpmModel model)
>       tpm_models[model] = true;
>   }
>
> -#ifdef CONFIG_TPM
> -
>   static const TPMBackendClass *
>   tpm_be_find_by_type(enum TpmType type)
>   {
> @@ -48,6 +46,8 @@ tpm_be_find_by_type(enum TpmType type)
>       return TPM_BACKEND_CLASS(oc);
>   }
>
> +#ifdef CONFIG_TPM
> +
>   /*
>    * Walk the list of available TPM backend drivers and display them on the
>    * screen.
> @@ -146,20 +146,6 @@ static int tpm_init_tpmdev(void *dummy, QemuOpts *opts, Error **errp)
>   }
>
>   /*
> - * Walk the list of TPM backend drivers that are in use and call their
> - * destroy function to have them cleaned up.
> - */
> -void tpm_cleanup(void)
> -{
> -    TPMBackend *drv, *next;
> -
> -    QLIST_FOREACH_SAFE(drv, &tpm_backends, list, next) {
> -        QLIST_REMOVE(drv, list);
> -        object_unref(OBJECT(drv));
> -    }
> -}
> -
> -/*
>    * Initialize the TPM. Process the tpmdev command line options describing the
>    * TPM backend.
>    */
> @@ -195,6 +181,20 @@ int tpm_config_parse(QemuOptsList *opts_list, const char *optarg)
>   #endif /* CONFIG_TPM */
>
>   /*
> + * Walk the list of TPM backend drivers that are in use and call their
> + * destroy function to have them cleaned up.
> + */
> +void tpm_cleanup(void)
> +{
> +    TPMBackend *drv, *next;
> +
> +    QLIST_FOREACH_SAFE(drv, &tpm_backends, list, next) {
> +        QLIST_REMOVE(drv, list);
> +        object_unref(OBJECT(drv));
> +    }
> +}
> +
> +/*
>    * Walk the list of active TPM backends and collect information about them
>    * following the schema description in qapi-schema.json.
>    */
> @@ -208,8 +208,9 @@ TPMInfoList *qmp_query_tpm(Error **errp)
>               continue;
>           }
>           info = g_new0(TPMInfoList, 1);
> +#ifdef CONFIG_TPM
>           info->value = tpm_backend_query_tpm(drv);
> -
> +#endif
>           if (!cur_item) {
>               head = cur_item = info;
>           } else {
