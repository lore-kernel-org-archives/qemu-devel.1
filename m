Received: from eggs.gnu.org ([2001:4830:134:3::10]:48162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e1wiZ-00041F-EX
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:45:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e1wiT-0003iA-2v
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:45:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44063
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e1wiS-0003gy-To
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:45:09 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9AFhJ08160698
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 11:45:05 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dgwese8nf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 11:45:05 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 10 Oct 2017 11:45:05 -0400
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
	<20171009225623.29232-18-marcandre.lureau@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 10 Oct 2017 11:45:01 -0400
MIME-Version: 1.0
In-Reply-To: <20171009225623.29232-18-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <a420d160-5793-723d-f3d9-7380b22e9e61@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 17/42] tpm-tis: move TPMState to TIS header
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
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/tpm/tpm_int.h  | 23 ++---------------------
>   hw/tpm/tpm_tis.h  | 19 +++++++++++++++++++
>   hw/tpm/tpm_util.c |  1 +
>   3 files changed, 22 insertions(+), 21 deletions(-)
>
> diff --git a/hw/tpm/tpm_int.h b/hw/tpm/tpm_int.h
> index 252c4082ef..e231d0eb4f 100644
> --- a/hw/tpm/tpm_int.h
> +++ b/hw/tpm/tpm_int.h
> @@ -12,28 +12,9 @@
>   #ifndef TPM_TPM_INT_H
>   #define TPM_TPM_INT_H
>  =20
> -#include "exec/memory.h"
> -#include "tpm_tis.h"
> +#include "qemu/osdep.h"
>  =20
> -/* overall state of the TPM interface */
> -struct TPMState {
> -    ISADevice busdev;
> -    MemoryRegion mmio;
> -
> -    union {
> -        TPMTISEmuState tis;
> -    } s;
> -
> -    TPMBackendCmd cmd;
> -
> -    char *backend;
> -    TPMBackend *be_driver;
> -    TPMVersion be_tpm_version;
> -};
> -
> -#define TPM(obj) OBJECT_CHECK(TPMState, (obj), TYPE_TPM_TIS)
> -
> -#define TPM_STANDARD_CMDLINE_OPTS \
> +#define TPM_STANDARD_CMDLINE_OPTS               \
>       { \
>           .name =3D "type", \
>           .type =3D QEMU_OPT_STRING, \
> diff --git a/hw/tpm/tpm_tis.h b/hw/tpm/tpm_tis.h
> index 31e612a7f4..30e35eef64 100644
> --- a/hw/tpm/tpm_tis.h
> +++ b/hw/tpm/tpm_tis.h
> @@ -72,4 +72,23 @@ typedef struct TPMTISEmuState {
>       uint32_t irq_num;
>   } TPMTISEmuState;
>  =20
> +/* overall state of the TPM interface */
> +struct TPMState {
> +    ISADevice busdev;
> +    MemoryRegion mmio;
> +
> +    union {
> +        TPMTISEmuState tis;
> +    } s;
> +
> +    uint8_t     locty_number;

This one probably shouldn't be here at this point. You seem to have=20
added it in the move?



> +    TPMBackendCmd cmd;
> +
> +    char *backend;
> +    TPMBackend *be_driver;
> +    TPMVersion be_tpm_version;
> +};
> +
> +#define TPM(obj) OBJECT_CHECK(TPMState, (obj), TYPE_TPM_TIS)
> +
>   #endif /* TPM_TPM_TIS_H */
> diff --git a/hw/tpm/tpm_util.c b/hw/tpm/tpm_util.c
> index fb929f6e92..7dc5b08824 100644
> --- a/hw/tpm/tpm_util.c
> +++ b/hw/tpm/tpm_util.c
> @@ -22,6 +22,7 @@
>   #include "qemu/osdep.h"
>   #include "tpm_util.h"
>   #include "tpm_int.h"
> +#include "exec/memory.h"
>  =20
>   /*
>    * Write an error message in the given output buffer.
