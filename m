Received: from eggs.gnu.org ([2001:4830:134:3::10]:53735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e21Hx-0005pL-0N
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 16:38:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e21Ht-0005ee-TI
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 16:38:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45722)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e21Ht-0005eP-KA
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 16:38:01 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9AKYfY0098696
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 16:38:00 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dgxvu7q3y-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 16:38:00 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 10 Oct 2017 14:37:59 -0600
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
	<20171009225623.29232-35-marcandre.lureau@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 10 Oct 2017 16:37:56 -0400
MIME-Version: 1.0
In-Reply-To: <20171009225623.29232-35-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <cb9065fe-2fdd-95e6-f030-353f719a458e@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 34/42] tpm-passthrough: workaround a
 possible race
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
> The TPM backend processing thread has common shared variable race
> issues. (they should not be so easy to reach since guest interaction
> with the device is slow compared to host emulation)
>
> An obvious one is setting op_cancelled from device thread after
> calling write(cancel_fd). The backend thread may return before the
> device thread has set the variable. Instead set it before
> cancellation. Even if the write() failed, the end result is command
> get possibly cancelled (even if cancellation came from external
> sources it doesn't matter much).
>
> It's worth to consider removing the backend processing thread for now.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>


> ---
>   hw/tpm/tpm_passthrough.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
> index 0806cf86af..d71d64e8aa 100644
> --- a/hw/tpm/tpm_passthrough.c
> +++ b/hw/tpm/tpm_passthrough.c
> @@ -89,6 +89,7 @@ static int tpm_passthrough_unix_tx_bufs(TPMPassthruSt=
ate *tpm_pt,
>       bool is_selftest;
>       const struct tpm_resp_hdr *hdr;
>
> +    /* FIXME: protect shared variables or use other sync mechanism */
>       tpm_pt->tpm_op_canceled =3D false;
>       tpm_pt->tpm_executing =3D true;
>       *selftest_done =3D false;
> @@ -178,12 +179,11 @@ static void tpm_passthrough_cancel_cmd(TPMBackend=
 *tb)
>        */
>       if (tpm_pt->tpm_executing) {
>           if (tpm_pt->cancel_fd >=3D 0) {
> +            tpm_pt->tpm_op_canceled =3D true;
>               n =3D write(tpm_pt->cancel_fd, "-", 1);
>               if (n !=3D 1) {
>                   error_report("Canceling TPM command failed: %s",
>                                strerror(errno));

Shouldn't we set it to false here ?


> -            } else {
> -                tpm_pt->tpm_op_canceled =3D true;
>               }
>           } else {
>               error_report("Cannot cancel TPM command due to missing "
