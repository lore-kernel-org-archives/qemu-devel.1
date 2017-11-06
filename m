Received: from eggs.gnu.org ([2001:4830:134:3::10]:47746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eBmbM-0006Iy-J8
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:58:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eBmbI-00070a-MK
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:58:28 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59482)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eBmbI-0006zo-DL
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:58:24 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA6Ivd7E090490
	for <qemu-devel@nongnu.org>; Mon, 6 Nov 2017 13:58:16 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e2ue8y454-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 13:58:15 -0500
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 6 Nov 2017 13:58:14 -0500
References: <20171106183925.16747-1-marcandre.lureau@redhat.com>
	<20171106183925.16747-3-marcandre.lureau@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon, 6 Nov 2017 13:58:12 -0500
MIME-Version: 1.0
In-Reply-To: <20171106183925.16747-3-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <fe8b09e1-eb10-c151-f951-4e030998d5cc@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 02/28] tpm: move TpmIf in
 include/sysemu/tpm.h
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

On 11/06/2017 01:38 PM, Marc-Andr=C3=A9 Lureau wrote:
> This is a better location than hw/tpm, since we are going to use the
> interface from outside hw/tpm.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

> ---
>   hw/tpm/tpm_int.h     | 22 +---------------------
>   include/sysemu/tpm.h | 19 +++++++++++++++++++
>   backends/tpm.c       |  1 -
>   3 files changed, 20 insertions(+), 22 deletions(-)
>
> diff --git a/hw/tpm/tpm_int.h b/hw/tpm/tpm_int.h
> index 9c045b6691..1df5883f3c 100644
> --- a/hw/tpm/tpm_int.h
> +++ b/hw/tpm/tpm_int.h
> @@ -13,28 +13,8 @@
>   #define TPM_TPM_INT_H
>
>   #include "qemu/osdep.h"
> -#include "qom/object.h"
>
> -#define TYPE_TPM_IF "tpm-if"
> -#define TPM_IF_CLASS(klass) \
> -    OBJECT_CLASS_CHECK(TPMIfClass, (klass), TYPE_TPM_IF)
> -#define TPM_IF_GET_CLASS(obj) \
> -    OBJECT_GET_CLASS(TPMIfClass, (obj), TYPE_TPM_IF)
> -#define TPM_IF(obj) \
> -    INTERFACE_CHECK(TPMIf, (obj), TYPE_TPM_IF)
> -
> -typedef struct TPMIf {
> -    Object parent_obj;
> -} TPMIf;
> -
> -typedef struct TPMIfClass {
> -    InterfaceClass parent_class;
> -
> -    /* run in thread pool by backend */
> -    void (*request_completed)(TPMIf *obj);
> -} TPMIfClass;
> -
> -#define TPM_STANDARD_CMDLINE_OPTS               \
> +#define TPM_STANDARD_CMDLINE_OPTS \
>       { \
>           .name =3D "type", \
>           .type =3D QEMU_OPT_STRING, \
> diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
> index d7a2bd8556..452cdb9cb7 100644
> --- a/include/sysemu/tpm.h
> +++ b/include/sysemu/tpm.h
> @@ -27,6 +27,25 @@ typedef enum  TPMVersion {
>       TPM_VERSION_2_0 =3D 2,
>   } TPMVersion;
>
> +#define TYPE_TPM_IF "tpm-if"
> +#define TPM_IF_CLASS(klass)                                 \
> +    OBJECT_CLASS_CHECK(TPMIfClass, (klass), TYPE_TPM_IF)
> +#define TPM_IF_GET_CLASS(obj)                           \
> +    OBJECT_GET_CLASS(TPMIfClass, (obj), TYPE_TPM_IF)
> +#define TPM_IF(obj)                             \
> +    INTERFACE_CHECK(TPMIf, (obj), TYPE_TPM_IF)
> +
> +typedef struct TPMIf {
> +    Object parent_obj;
> +} TPMIf;
> +
> +typedef struct TPMIfClass {
> +    InterfaceClass parent_class;
> +
> +    /* run in thread pool by backend */
> +    void (*request_completed)(TPMIf *obj);
> +} TPMIfClass;
> +
>   TPMVersion tpm_tis_get_tpm_version(Object *obj);
>
>   #define TYPE_TPM_TIS                "tpm-tis"
> diff --git a/backends/tpm.c b/backends/tpm.c
> index 5763f6f369..1e416d7f90 100644
> --- a/backends/tpm.c
> +++ b/backends/tpm.c
> @@ -17,7 +17,6 @@
>   #include "qapi/error.h"
>   #include "qapi/qmp/qerror.h"
>   #include "sysemu/tpm.h"
> -#include "hw/tpm/tpm_int.h"
>   #include "qemu/thread.h"
>
>   static void tpm_backend_worker_thread(gpointer data, gpointer user_da=
ta)
