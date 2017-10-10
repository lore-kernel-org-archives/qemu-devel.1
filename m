Received: from eggs.gnu.org ([2001:4830:134:3::10]:46375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e1wdN-000077-UW
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:39:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e1wdK-00010W-RI
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:39:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59318
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e1wdK-00010J-Ll
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:39:50 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9AFXoMA076790
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 11:39:46 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dgygw5bcq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 11:39:46 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 10 Oct 2017 11:39:45 -0400
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
	<20171009225623.29232-16-marcandre.lureau@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 10 Oct 2017 11:39:42 -0400
MIME-Version: 1.0
In-Reply-To: <20171009225623.29232-16-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <09d2dafb-103c-5c09-91e6-598ed501875d@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 15/42] tpm-emulator: fix error handling
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
> The previous patch cleaned up a bit error handling, and exposed an
> existing bug: error_report_err() could be called with a NULL error.
> Instead, make tpm_emulator_set_locality() set the error.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

> ---
>   hw/tpm/tpm_emulator.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
> index 788ab9876d..25a6258c10 100644
> --- a/hw/tpm/tpm_emulator.c
> +++ b/hw/tpm/tpm_emulator.c
> @@ -141,7 +141,8 @@ static int tpm_emulator_unix_tx_bufs(TPMEmulator *t=
pm_emu,
>       return 0;
>   }
>  =20
> -static int tpm_emulator_set_locality(TPMEmulator *tpm_emu, uint8_t loc=
ty_number)
> +static int tpm_emulator_set_locality(TPMEmulator *tpm_emu, uint8_t loc=
ty_number,
> +                                     Error **errp)
>   {
>       ptm_loc loc;
>  =20
> @@ -155,15 +156,15 @@ static int tpm_emulator_set_locality(TPMEmulator =
*tpm_emu, uint8_t locty_number)
>       loc.u.req.loc =3D locty_number;
>       if (tpm_emulator_ctrlcmd(&tpm_emu->ctrl_chr, CMD_SET_LOCALITY, &l=
oc,
>                                sizeof(loc), sizeof(loc)) < 0) {
> -        error_report("tpm-emulator: could not set locality : %s",
> -                     strerror(errno));
> +        error_setg(errp, "tpm-emulator: could not set locality : %s",
> +                   strerror(errno));
>           return -1;
>       }
>  =20
>       loc.u.resp.tpm_result =3D be32_to_cpu(loc.u.resp.tpm_result);
>       if (loc.u.resp.tpm_result !=3D 0) {
> -        error_report("tpm-emulator: TPM result for set locality : 0x%x=
",
> -                     loc.u.resp.tpm_result);
> +        error_setg(errp, "tpm-emulator: TPM result for set locality : =
0x%x",
> +                   loc.u.resp.tpm_result);
>           return -1;
>       }
>  =20
> @@ -179,7 +180,8 @@ static void tpm_emulator_handle_request(TPMBackend =
*tb, TPMBackendCmd *cmd)
>  =20
>       DPRINTF("processing TPM command");
>  =20
> -    if (tpm_emulator_set_locality(tpm_emu, tb->tpm_state->locty_number=
) < 0) {
> +    if (tpm_emulator_set_locality(tpm_emu,
> +                                  tb->tpm_state->locty_number, &err) <=
 0) {
>           goto error;
>       }
>  =20
