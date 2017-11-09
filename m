Received: from eggs.gnu.org ([2001:4830:134:3::10]:50622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eClcD-0007eX-Go
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 07:07:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eClcC-0007vz-LL
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 07:07:25 -0500
Received: from mail-ua0-x242.google.com ([2607:f8b0:400c:c08::242]:44586)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eClcC-0007vS-Gh
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 07:07:24 -0500
Received: by mail-ua0-x242.google.com with SMTP id f46so4227979uae.1
	for <qemu-devel@nongnu.org>; Thu, 09 Nov 2017 04:07:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1510173421-19895-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1510173421-19895-1-git-send-email-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 9 Nov 2017 13:07:23 +0100
Message-ID: <CAJ+F1CJsVUrbXg0E0CGPcba+=_kbZkKsry_n9Xa2e=X_9uwL+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] tpm_emulator: Add a caching layer for
 the TPM Established flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: QEMU <qemu-devel@nongnu.org>, Amarnath Valluri <amarnath.valluri@intel.com>

Hi

On Wed, Nov 8, 2017 at 9:37 PM, Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
> Add a caching layer for the TPM established flag so that we don't
> need to go to the emulator every time the flag is read by accessing
> the REG_ACCESS register.
>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>
> v1->v2:
>  - move the caching to the backend layer since detecting the
>    TPM 1.2 TSC_ResetEstablishmentBit() command is easier to do
>    here.

What about the HASH_START? Is this not supported by qemu TIS? Is the
function gone or done differently with TPM2 or CRB?

> ---
>  hw/tpm/tpm_emulator.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
> index 9aaec8e..507e2cb 100644
> --- a/hw/tpm/tpm_emulator.c
> +++ b/hw/tpm/tpm_emulator.c
> @@ -71,6 +71,9 @@ typedef struct TPMEmulator {
>      ptm_cap caps; /* capabilities of the TPM */
>      uint8_t cur_locty_number; /* last set locality */
>      Error *migration_blocker;
> +
> +    unsigned int established_flag:1;
> +    unsigned int established_flag_cached:1;
>  } TPMEmulator;
>
>
> @@ -277,16 +280,22 @@ static bool tpm_emulator_get_tpm_established_flag(T=
PMBackend *tb)
>      TPMEmulator *tpm_emu =3D TPM_EMULATOR(tb);
>      ptm_est est;
>
> -    DPRINTF("%s", __func__);
> +    if (tpm_emu->established_flag_cached) {
> +        return tpm_emu->established_flag;
> +    }
> +
>      if (tpm_emulator_ctrlcmd(&tpm_emu->ctrl_chr, CMD_GET_TPMESTABLISHED,=
 &est,
>                               0, sizeof(est)) < 0) {
>          error_report("tpm-emulator: Could not get the TPM established fl=
ag: %s",
>                       strerror(errno));
>          return false;
>      }
> -    DPRINTF("established flag: %0x", est.u.resp.bit);
> +    DPRINTF("got established flag: %0x", est.u.resp.bit);
> +
> +    tpm_emu->established_flag_cached =3D 1;
> +    tpm_emu->established_flag =3D (est.u.resp.bit !=3D 0);
>
> -    return (est.u.resp.bit !=3D 0);
> +    return tpm_emu->established_flag;
>  }
>
>  static int tpm_emulator_reset_tpm_established_flag(TPMBackend *tb,
> @@ -317,6 +326,8 @@ static int tpm_emulator_reset_tpm_established_flag(TP=
MBackend *tb,
>          return -1;
>      }
>
> +    tpm_emu->established_flag_cached =3D 0;
> +
>      return 0;
>  }
>
> --
> 2.5.5
>
>



--=20
Marc-Andr=C3=A9 Lureau
