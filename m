Received: from eggs.gnu.org ([2001:4830:134:3::10]:36888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e1yy5-0004mW-RP
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 14:09:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e1yy0-00007d-QA
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 14:09:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57326
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e1yy0-00007Y-Jm
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 14:09:20 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9AI4EVZ080861
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 14:09:14 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dh2gramhw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 14:09:14 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 10 Oct 2017 12:09:13 -0600
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
	<20171009225623.29232-21-marcandre.lureau@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 10 Oct 2017 14:09:10 -0400
MIME-Version: 1.0
In-Reply-To: <20171009225623.29232-21-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <7d9a2c04-3f5f-5080-66cd-7c913457c428@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 20/42] tpm: add a QOM TPM interface
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
> This will simplify backend / interface objects relationship, so the
> frontend interface will simply have to implement the TPM QOM interface.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

> ---
>   hw/tpm/tpm_int.h | 17 +++++++++++++++++
>   backends/tpm.c   |  8 ++++++++
>   hw/tpm/tpm_tis.c |  4 ++++
>   3 files changed, 29 insertions(+)
>
> diff --git a/hw/tpm/tpm_int.h b/hw/tpm/tpm_int.h
> index e231d0eb4f..eb02e7760c 100644
> --- a/hw/tpm/tpm_int.h
> +++ b/hw/tpm/tpm_int.h
> @@ -13,6 +13,23 @@
>   #define TPM_TPM_INT_H
>
>   #include "qemu/osdep.h"
> +#include "qom/object.h"
> +
> +#define TYPE_TPM_IF "tpm-if"
> +#define TPM_IF_CLASS(klass) \
> +    OBJECT_CLASS_CHECK(TPMIfClass, (klass), TYPE_TPM_IF)
> +#define TPM_IF_GET_CLASS(obj) \
> +    OBJECT_GET_CLASS(TPMIfClass, (obj), TYPE_TPM_IF)
> +#define TPM_IF(obj) \
> +    INTERFACE_CHECK(TPMIf, (obj), TYPE_TPM_IF)
> +
> +typedef struct TPMIf {
> +    Object parent_obj;
> +} TPMIf;
> +
> +typedef struct TPMIfClass {
> +    InterfaceClass parent_class;
> +} TPMIfClass;
>
>   #define TPM_STANDARD_CMDLINE_OPTS               \
>       { \
> diff --git a/backends/tpm.c b/backends/tpm.c
> index dc7c831ff8..87c5c09179 100644
> --- a/backends/tpm.c
> +++ b/backends/tpm.c
> @@ -17,6 +17,7 @@
>   #include "qapi/error.h"
>   #include "qapi/qmp/qerror.h"
>   #include "sysemu/tpm.h"
> +#include "hw/tpm/tpm_int.h"
>   #include "qemu/thread.h"
>
>   static void tpm_backend_worker_thread(gpointer data, gpointer user_da=
ta)
> @@ -209,9 +210,16 @@ static const TypeInfo tpm_backend_info =3D {
>       .abstract =3D true,
>   };
>
> +static const TypeInfo tpm_if_info =3D {
> +    .name =3D TYPE_TPM_IF,
> +    .parent =3D TYPE_INTERFACE,
> +    .class_size =3D sizeof(TPMIfClass),
> +};
> +
>   static void register_types(void)
>   {
>       type_register_static(&tpm_backend_info);
> +    type_register_static(&tpm_if_info);
>   }
>
>   type_init(register_types);
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index d84eec48b4..dbb50043ac 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -1123,6 +1123,10 @@ static const TypeInfo tpm_tis_info =3D {
>       .instance_size =3D sizeof(TPMState),
>       .instance_init =3D tpm_tis_initfn,
>       .class_init  =3D tpm_tis_class_init,
> +    .interfaces =3D (InterfaceInfo[]) {
> +        { TYPE_TPM_IF },
> +        { }
> +    }
>   };
>
>   static void tpm_tis_register(void)
