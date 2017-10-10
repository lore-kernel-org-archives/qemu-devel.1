Received: from eggs.gnu.org ([2001:4830:134:3::10]:37902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e1z2H-0006NZ-IX
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 14:13:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e1z2C-0001KB-Fx
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 14:13:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39186
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e1z2C-0001Ju-9y
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 14:13:40 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9AI4FFw013374
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 14:13:36 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dh2snsswg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 14:13:36 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 10 Oct 2017 12:13:35 -0600
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
	<20171009225623.29232-33-marcandre.lureau@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 10 Oct 2017 14:13:31 -0400
MIME-Version: 1.0
In-Reply-To: <20171009225623.29232-33-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <d7c162f5-9643-d4c4-0ed0-4ab52b766139@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 32/42] tpm-passthrough: make it safer to
 destroy after creation
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
> Check fds values before closing, to avoid close(-1).
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Typicall free() can be called with a NULL pointer.  I am also fine with=20
this change here,  but could we move the fd < 0 check into qemu_close?

Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

> ---
>   hw/tpm/tpm_passthrough.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
> index 7371d50739..aa9167e3c6 100644
> --- a/hw/tpm/tpm_passthrough.c
> +++ b/hw/tpm/tpm_passthrough.c
> @@ -347,8 +347,12 @@ static void tpm_passthrough_inst_finalize(Object *=
obj)
>  =20
>       tpm_passthrough_cancel_cmd(TPM_BACKEND(obj));
>  =20
> -    qemu_close(tpm_pt->tpm_fd);
> -    qemu_close(tpm_pt->cancel_fd);
> +    if (tpm_pt->tpm_fd >=3D 0) {
> +        qemu_close(tpm_pt->tpm_fd);
> +    }
> +    if (tpm_pt->cancel_fd >=3D 0) {
> +        qemu_close(tpm_pt->cancel_fd);
> +    }
>       qapi_free_TPMPassthroughOptions(tpm_pt->options);
>   }
>  =20
