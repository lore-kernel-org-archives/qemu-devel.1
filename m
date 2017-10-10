Received: from eggs.gnu.org ([2001:4830:134:3::10]:47237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e1wgG-00029L-3d
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:42:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e1wgC-0002SH-6B
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:42:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54528
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e1wgB-0002Rt-W4
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:42:48 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9AFgigr101449
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 11:42:44 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dgwp7n031-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 11:42:43 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 10 Oct 2017 11:42:38 -0400
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
	<20171009225623.29232-17-marcandre.lureau@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 10 Oct 2017 11:42:35 -0400
MIME-Version: 1.0
In-Reply-To: <20171009225623.29232-17-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <30ea7c97-a07e-7f94-0e44-9b644794053a@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 16/42] tpm: remove locty_data from TPMState
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
> Keep it internal to tpm-tis instead.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

> ---
>   hw/tpm/tpm_int.h      |  2 --
>   hw/tpm/tpm_emulator.c |  3 +--
>   hw/tpm/tpm_tis.c      | 12 +++++-------
>   3 files changed, 6 insertions(+), 11 deletions(-)
>
> diff --git a/hw/tpm/tpm_int.h b/hw/tpm/tpm_int.h
> index 6d7b3dc850..252c4082ef 100644
> --- a/hw/tpm/tpm_int.h
> +++ b/hw/tpm/tpm_int.h
> @@ -24,8 +24,6 @@ struct TPMState {
>           TPMTISEmuState tis;
>       } s;
>  =20
> -    uint8_t     locty_number;
> -    TPMLocality *locty_data;
>       TPMBackendCmd cmd;
>  =20
>       char *backend;
> diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
> index 25a6258c10..407ac97651 100644
> --- a/hw/tpm/tpm_emulator.c
> +++ b/hw/tpm/tpm_emulator.c
> @@ -180,8 +180,7 @@ static void tpm_emulator_handle_request(TPMBackend =
*tb, TPMBackendCmd *cmd)
>  =20
>       DPRINTF("processing TPM command");
>  =20
> -    if (tpm_emulator_set_locality(tpm_emu,
> -                                  tb->tpm_state->locty_number, &err) <=
 0) {
> +    if (tpm_emulator_set_locality(tpm_emu, cmd->locty, &err) < 0) {
>           goto error;
>       }
>  =20
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index ffed7bfaf9..ad2845622e 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -203,12 +203,10 @@ static void tpm_tis_sts_set(TPMLocality *l, uint3=
2_t flags)
>   static void tpm_tis_tpm_send(TPMState *s, uint8_t locty)
>   {
>       TPMTISEmuState *tis =3D &s->s.tis;
> +    TPMLocality *locty_data =3D &tis->loc[locty];
>  =20
>       tpm_tis_show_buffer(&tis->loc[locty].w_buffer, "tpm_tis: To TPM")=
;
>  =20
> -    s->locty_number =3D locty;
> -    s->locty_data =3D &tis->loc[locty];
> -
>       /*
>        * w_offset serves as length indicator for length of data;
>        * it's reset when the response comes back
> @@ -217,10 +215,10 @@ static void tpm_tis_tpm_send(TPMState *s, uint8_t=
 locty)
>  =20
>       s->cmd =3D (TPMBackendCmd) {
>           .locty =3D locty,
> -        .in =3D s->locty_data->w_buffer.buffer,
> -        .in_len =3D s->locty_data->w_offset,
> -        .out =3D s->locty_data->r_buffer.buffer,
> -        .out_len =3D s->locty_data->r_buffer.size
> +        .in =3D locty_data->w_buffer.buffer,
> +        .in_len =3D locty_data->w_offset,
> +        .out =3D locty_data->r_buffer.buffer,
> +        .out_len =3D locty_data->r_buffer.size
>       };
>  =20
>       tpm_backend_deliver_request(s->be_driver, &s->cmd);
