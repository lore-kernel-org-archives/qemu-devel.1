Received: from eggs.gnu.org ([2001:4830:134:3::10]:43298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e1wWR-0004vq-RW
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:32:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e1wWN-0005aK-Ty
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:32:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57107
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e1wWN-0005Zy-Nv
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:32:39 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9AFVMfl127725
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 11:32:35 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dgwesdnu7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 11:32:35 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 10 Oct 2017 09:32:34 -0600
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
	<20171009225623.29232-14-marcandre.lureau@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 10 Oct 2017 11:32:30 -0400
MIME-Version: 1.0
In-Reply-To: <20171009225623.29232-14-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <69f82087-3ab7-b1f3-f043-85e7a467d06f@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 13/42] tpm: remove locty argument from
 receive_cb
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
> The tpm_state is passed as argument, the assert() is pointless since
> we give it the value of tpm_state->locty_number already.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

> ---
>   include/sysemu/tpm_backend.h | 2 +-
>   hw/tpm/tpm_emulator.c        | 3 +--
>   hw/tpm/tpm_passthrough.c     | 4 +---
>   hw/tpm/tpm_tis.c             | 5 ++---
>   4 files changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.=
h
> index 7d7ebfc21d..9c83a512e1 100644
> --- a/include/sysemu/tpm_backend.h
> +++ b/include/sysemu/tpm_backend.h
> @@ -30,7 +30,7 @@
>   typedef struct TPMBackendClass TPMBackendClass;
>   typedef struct TPMBackend TPMBackend;
>  =20
> -typedef void (TPMRecvDataCB)(TPMState *, uint8_t locty, bool selftest_=
done);
> +typedef void (TPMRecvDataCB)(TPMState *, bool selftest_done);
>  =20
>   struct TPMBackend {
>       Object parent;
> diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
> index dadc264182..4fe405353a 100644
> --- a/hw/tpm/tpm_emulator.c
> +++ b/hw/tpm/tpm_emulator.c
> @@ -193,8 +193,7 @@ static void tpm_emulator_handle_request(TPMBackend =
*tb)
>           error_report_err(err);
>       }
>  =20
> -    tb->recv_data_callback(tb->tpm_state, tb->tpm_state->locty_number,
> -                           selftest_done);
> +    tb->recv_data_callback(tb->tpm_state, selftest_done);
>   }
>  =20
>   static int tpm_emulator_probe_caps(TPMEmulator *tpm_emu)
> diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
> index fed3d69799..0ae4596932 100644
> --- a/hw/tpm/tpm_passthrough.c
> +++ b/hw/tpm/tpm_passthrough.c
> @@ -160,9 +160,7 @@ static void tpm_passthrough_handle_request(TPMBacke=
nd *tb)
>                                     tb->tpm_state->locty_data,
>                                     &selftest_done);
>  =20
> -    tb->recv_data_callback(tb->tpm_state,
> -                           tb->tpm_state->locty_number,
> -                           selftest_done);
> +    tb->recv_data_callback(tb->tpm_state, selftest_done);
>   }
>  =20
>   static void tpm_passthrough_reset(TPMBackend *tb)
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index c54dac32de..345a4fbee5 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -371,14 +371,13 @@ static void tpm_tis_receive_bh(void *opaque)
>   /*
>    * Callback from the TPM to indicate that the response was received.
>    */
> -static void tpm_tis_receive_cb(TPMState *s, uint8_t locty,
> +static void tpm_tis_receive_cb(TPMState *s,
>                                  bool is_selftest_done)
>   {
>       TPMTISEmuState *tis =3D &s->s.tis;
> +    uint8_t locty =3D s->locty_number;
>       uint8_t l;
>  =20
> -    assert(s->locty_number =3D=3D locty);
> -
>       if (is_selftest_done) {
>           for (l =3D 0; l < TPM_TIS_NUM_LOCALITIES; l++) {
>               tis->loc[locty].sts |=3D TPM_TIS_STS_SELFTEST_DONE;
