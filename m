Received: from eggs.gnu.org ([2001:4830:134:3::10]:38696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eEkq6-0006tw-BC
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 18:41:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eEkq0-0005JS-SW
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 18:41:58 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:56120)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eEkq0-0005I1-LN
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 18:41:52 -0500
Received: by mail-wr0-x243.google.com with SMTP id l8so18942986wre.12
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 15:41:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1510696349-5151-3-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1510696349-5151-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1510696349-5151-3-git-send-email-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 15 Nov 2017 00:41:49 +0100
Message-ID: <CAJ+F1CJnyiMm4A-BUTnL3m0+q2k+Y8y3cpcJiiicYN2V1Tpj6A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 for-2.11 2/3] tpm_tis: Return
 TPM_VERSION_UNSPEC in case of BE failure
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

On Tue, Nov 14, 2017 at 10:52 PM, Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
> In case the backend has a failure, such as the tpm_emulator's CMD_INIT
> failing, the TIS goes into failure mode and does not respond to reads
> or writes to MMIO registers. In this case we need to prevent the ACPI
> table from being added and the straight-forward way is to indicate that
> there's no known TPM version being used.
>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

(we can probably iterate to improve the code around that later)

> ---
>  hw/tpm/tpm_tis.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index 7402528..fec2fc6 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -1008,6 +1008,10 @@ TPMVersion tpm_tis_get_tpm_version(Object *obj)
>  {
>      TPMState *s =3D TPM(obj);
>
> +    if (tpm_backend_had_startup_error(s->be_driver)) {
> +        return TPM_VERSION_UNSPEC;
> +    }
> +
>      return tpm_backend_get_tpm_version(s->be_driver);
>  }
>
> --
> 2.5.5
>



--=20
Marc-Andr=C3=A9 Lureau
