Received: from eggs.gnu.org ([2001:4830:134:3::10]:52698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eBo3x-0000Rf-Dy
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 15:32:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eBo3s-00051y-Cw
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 15:32:05 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37682
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eBo3s-00051p-71
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 15:32:00 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA6KTpkP010336
	for <qemu-devel@nongnu.org>; Mon, 6 Nov 2017 15:31:55 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2e2xtqg3pu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 15:31:53 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 6 Nov 2017 13:31:53 -0700
References: <20171106183925.16747-1-marcandre.lureau@redhat.com>
	<20171106183925.16747-28-marcandre.lureau@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon, 6 Nov 2017 15:31:49 -0500
MIME-Version: 1.0
In-Reply-To: <20171106183925.16747-28-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <e3a75278-6167-12a4-74d7-c63ff23f71ea@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 27/28] tpm-tis: use DEFINE_PROP_TPMBE
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
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

> ---
>   hw/tpm/tpm_tis.c | 12 ++----------
>   1 file changed, 2 insertions(+), 10 deletions(-)
>
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index dccc56ab09..a00779f3aa 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -86,7 +86,6 @@ typedef struct TPMState {
>
>       TPMBackendCmd cmd;
>
> -    char *backend;
>       TPMBackend *be_driver;
>       TPMVersion be_tpm_version;
>   } TPMState;
> @@ -1049,7 +1048,7 @@ static const VMStateDescription vmstate_tpm_tis =3D=
 {
>
>   static Property tpm_tis_properties[] =3D {
>       DEFINE_PROP_UINT32("irq", TPMState, irq_num, TPM_TIS_IRQ),
> -    DEFINE_PROP_STRING("tpmdev", TPMState, backend),
> +    DEFINE_PROP_TPMBE("tpmdev", TPMState, be_driver),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>
> @@ -1062,17 +1061,10 @@ static void tpm_tis_realizefn(DeviceState *dev,=
 Error **errp)
>           return;
>       }
>
> -    s->be_driver =3D qemu_find_tpm_be(s->backend);
>       if (!s->be_driver) {
> -        error_setg(errp, "backend driver with id %s could not be found=
",
> -                   s->backend);
> +        error_setg(errp, "'tpmdev' property is required");
>           return;
>       }
> -
> -    if (tpm_backend_init(s->be_driver, TPM_IF(s), errp)) {
> -        return;
> -    }
> -
>       if (s->irq_num > 15) {
>           error_setg(errp, "IRQ %d is outside valid range of 0 to 15",
>                      s->irq_num);
