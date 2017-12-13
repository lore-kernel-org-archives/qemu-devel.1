Received: from eggs.gnu.org ([2001:4830:134:3::10]:34138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eP4CJ-0006OX-6k
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 05:23:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eP4CI-0002Yf-D5
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 05:23:31 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:43704)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eP4CI-0002YM-6m
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 05:23:30 -0500
Received: by mail-wm0-x241.google.com with SMTP id n138so3927521wmg.2
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 02:23:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1510371554-29833-2-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1510371554-29833-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1510371554-29833-2-git-send-email-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 13 Dec 2017 11:23:28 +0100
Message-ID: <CAJ+F1CLT2yDg25709DO_BbdSL0vY6TOjGYtVCo_gtarB6YNAXg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] tpm_tis: Return TPM_VERSION_UNSPEC in
 case of BE failure
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

On Sat, Nov 11, 2017 at 4:39 AM, Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
> In case the backend has a failure, such as the tpm_emulator's CMD_INIT
> failing, the TIS goes into failure mode and does not respond to reads
> or writes to MMIO registers. In this case we need to prevent the ACPI
> table from being added and the straight-forward way is to indicate that
> there's no known TPM version being used.
>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  hw/tpm/tpm_tis.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index c0a0204..eca3374 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -970,6 +970,10 @@ static enum TPMVersion tpm_tis_get_tpm_version(TPMIf=
 *ti)
>  {
>      TPMState *s =3D TPM(ti);
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
>



--=20
Marc-Andr=C3=A9 Lureau
