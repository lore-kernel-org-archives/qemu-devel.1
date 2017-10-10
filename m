Received: from eggs.gnu.org ([2001:4830:134:3::10]:41067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e1zC9-0005AG-1H
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 14:23:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e1zC4-0006lx-Uk
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 14:23:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41714)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e1zC4-0006lh-Lk
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 14:23:52 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9AINVik146775
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 14:23:48 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dh2s6jedk-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 14:23:48 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 10 Oct 2017 14:23:47 -0400
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
	<20171009225623.29232-40-marcandre.lureau@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 10 Oct 2017 14:23:44 -0400
MIME-Version: 1.0
In-Reply-To: <20171009225623.29232-40-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <f9b0e988-a986-d6b7-60cf-3e12a220ad5f@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 39/42] tpm: add tpm_cmd_get_size() to
 tpm_util
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
> The function is generally useful and used in the following patches.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>


> ---
>   hw/tpm/tpm_util.h | 8 +++++++-
>   hw/tpm/tpm_tis.c  | 3 ++-
>   2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/hw/tpm/tpm_util.h b/hw/tpm/tpm_util.h
> index 2f7c96146d..aca10c97bf 100644
> --- a/hw/tpm/tpm_util.h
> +++ b/hw/tpm/tpm_util.h
> @@ -22,7 +22,8 @@
>   #ifndef TPM_TPM_UTIL_H
>   #define TPM_TPM_UTIL_H
>  =20
> -#include "sysemu/tpm_backend.h"
> +#include "sysemu/tpm.h"
> +#include "qemu/bswap.h"
>  =20
>   void tpm_util_write_fatal_error_response(uint8_t *out, uint32_t out_l=
en);
>  =20
> @@ -30,4 +31,9 @@ bool tpm_util_is_selftest(const uint8_t *in, uint32_t=
 in_len);
>  =20
>   int tpm_util_test_tpmdev(int tpm_fd, TPMVersion *tpm_version);
>  =20
> +static inline uint32_t tpm_cmd_get_size(const void *b)
> +{
> +    return be32_to_cpu(*(const uint32_t *)(b + 2));
> +}
> +
>   #endif /* TPM_TPM_UTIL_H */
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index 6aac9bfe6b..d0e1aac247 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -30,6 +30,7 @@
>   #include "hw/pci/pci_ids.h"
>   #include "sysemu/tpm_backend.h"
>   #include "tpm_int.h"
> +#include "tpm_util.h"
>  =20
>   #define TPM_TIS_NUM_LOCALITIES      5     /* per spec */
>   #define TPM_TIS_LOCALITY_SHIFT      12
> @@ -216,7 +217,7 @@ static uint8_t tpm_tis_locality_from_addr(hwaddr ad=
dr)
>  =20
>   static uint32_t tpm_tis_get_size_from_buffer(const TPMSizedBuffer *sb=
)
>   {
> -    return be32_to_cpu(*(uint32_t *)&sb->buffer[2]);
> +    return tpm_cmd_get_size(sb->buffer);
>   }
>  =20
>   static void tpm_tis_show_buffer(const TPMSizedBuffer *sb, const char =
*string)
