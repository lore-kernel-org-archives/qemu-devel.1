Received: from eggs.gnu.org ([2001:4830:134:3::10]:53375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dFeDp-0006yz-6R
	for qemu-devel@nongnu.org; Tue, 30 May 2017 06:17:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dFeDm-0003Pg-3Z
	for qemu-devel@nongnu.org; Tue, 30 May 2017 06:17:53 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:35792)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dFeDl-0003PJ-SJ
	for qemu-devel@nongnu.org; Tue, 30 May 2017 06:17:50 -0400
Received: by mail-lf0-x244.google.com with SMTP id 99so8432200lfu.2
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 03:17:49 -0700 (PDT)
Date: Tue, 30 May 2017 11:17:46 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170530101746.GA25884@stefanha-x1.localdomain>
References: <20170529193016.6888-1-aurelien@aurel32.net>
	<20170529193016.6888-3-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <20170529193016.6888-3-aurelien@aurel32.net>
Subject: Re: [Qemu-devel] [PULL 2/5] target/sh4: fix reset when using a
 kernel and an initrd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 29, 2017 at 09:30:13PM +0200, Aurelien Jarno wrote:
> When a masked exception happens, the SH4 CPU generates a non-masked
> reset exception, which then jumps to the reset vector at address
> 0xA0000000. While this is emulated correctly in QEMU, this does not
> work when using a kernel and initrd as this address then contain an
> illegal instruction (and there is no guarantee the kernel and initrd
> haven't been overwritten).
>=20
> Therefore call qemu_system_reset_request to reload the kernel and initrd
> and load the program counter to the kernel entry point.
>=20
> Reviewed-by: Richard Henderson <rth@twiddle.net>
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> ---
>  target/sh4/helper.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/target/sh4/helper.c b/target/sh4/helper.c
> index 4c024f9529..5296e7cf4e 100644
> --- a/target/sh4/helper.c
> +++ b/target/sh4/helper.c
> @@ -21,6 +21,7 @@
>  #include "cpu.h"
>  #include "exec/exec-all.h"
>  #include "exec/log.h"
> +#include "sysemu/sysemu.h"
> =20
>  #if !defined(CONFIG_USER_ONLY)
>  #include "hw/sh4/sh_intc.h"
> @@ -92,7 +93,14 @@ void superh_cpu_do_interrupt(CPUState *cs)
> =20
>      if (env->sr & (1u << SR_BL)) {
>          if (do_exp && cs->exception_index !=3D 0x1e0) {
> -            cs->exception_index =3D 0x000; /* masked exception -> reset =
*/
> +            /* In theory a masked exception generates a reset exception,
> +               which in turn jumps to the reset vector. However this only
> +               works when using a bootloader. When using a kernel and an
> +               initrd, they need to be reloaded and the program counter
> +               should be loaded with the kernel entry point.
> +               qemu_system_reset_request takes care of that.  */
> +            qemu_system_reset_request();
> +            return;

The qemu_system_reset_request() prototype is changing.  There is a
conflict with another merged pull request.  Please rebase onto
https://github.com/stefanha/qemu.git staging.

target/sh4/helper.c:102:39: error: too few arguments to function call, sing=
le argument 'reason' was not specified
            qemu_system_reset_request();
            ~~~~~~~~~~~~~~~~~~~~~~~~~ ^

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLUbKAAoJEJykq7OBq3PIu88IAMh1v+81pbwaK7wFiqnoCWge
7fwZctwnsYooc4eFXr5BGMNs1SetnkLUcppS2+Z4lnXZ4nhg+iLifuWd3fZMo+0m
letta3inQIcfRS8jFMqQMThjyFpo2t7GXekBIQ7wJN+1uZfsOZwwGJ2YcP3+CIDU
/fa+KHJqCo8YktkfPnGFGGLfcVKMaGqa5pJNVRZnRM6p13G/W6sapTeEQJc0TSMi
85JPoNZ2l1HfE2zz3ye7nBIjg5OanWFPT21SRypLgTPw4l4cx+CKRyMsZwOgKsao
bylFNvSmMvL3GJuKAxZOcgT8eJ+QwdV9/FSV+ZU3BjThEYr14ZlpyAqLazTWztg=
=uyUd
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
