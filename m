Received: from eggs.gnu.org ([208.118.235.92]:58008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gexry-0001HH-Le
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 02:56:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gexrt-0000gr-IU
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 02:56:44 -0500
Date: Thu, 3 Jan 2019 07:56:38 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190103075638.GA5724@stefanha-x1.localdomain>
References: <20181214145152.27250-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
In-Reply-To: <20181214145152.27250-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] microbit: make -kernel optional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, jim@groklearning.com, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Steffen Gortz <qemu.ml@steffen-goertz.de>, qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>, jusual@mail.ru


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 14, 2018 at 02:51:52PM +0000, Stefan Hajnoczi wrote:
> ARMv7M machine types support -kernel for ELF and raw image files.
> Microbit programs are typically in Intel HEX (.hex) format.  The generic
> loader supports .hex files but it doesn't work as expected:
>=20
>   $ qemu-system-arm -M microbit -device loader,file=3Dmicrobit.hex
>   Guest image must be specified (using -kernel)
>=20
> This error comes from armv7m_load_kernel() but we don't have -kernel in
> this case.
>=20
> This patch makes -kernel optional since most of the time we'll want to
> use -device loader instead.
>=20
> Note that we need to register the reset handler that
> armv7m_load_kernel() used to register for us.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  hw/arm/microbit.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)

Ping

> diff --git a/hw/arm/microbit.c b/hw/arm/microbit.c
> index a734e7f650..638f638792 100644
> --- a/hw/arm/microbit.c
> +++ b/hw/arm/microbit.c
> @@ -14,6 +14,7 @@
>  #include "hw/arm/arm.h"
>  #include "sysemu/sysemu.h"
>  #include "exec/address-spaces.h"
> +#include "qemu/error-report.h"
> =20
>  #include "hw/arm/nrf51_soc.h"
> =20
> @@ -28,6 +29,13 @@ typedef struct {
>  #define MICROBIT_MACHINE(obj) \
>      OBJECT_CHECK(MicrobitMachineState, obj, TYPE_MICROBIT_MACHINE)
> =20
> +static void microbit_cpu_reset(void *opaque)
> +{
> +    ARMCPU *cpu =3D opaque;
> +
> +    cpu_reset(CPU(cpu));
> +}
> +
>  static void microbit_init(MachineState *machine)
>  {
>      MicrobitMachineState *s =3D MICROBIT_MACHINE(machine);
> @@ -41,8 +49,13 @@ static void microbit_init(MachineState *machine)
>                               &error_fatal);
>      object_property_set_bool(soc, true, "realized", &error_fatal);
> =20
> -    armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
> -                       NRF51_SOC(soc)->flash_size);
> +    if (machine->kernel_filename) {
> +        armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
> +                           NRF51_SOC(soc)->flash_size);
> +    } else {
> +        /* armv7m_load_kernel() does this, we need to do it manually her=
e */
> +        qemu_register_reset(microbit_cpu_reset, ARM_CPU(first_cpu));
> +    }
>  }
> =20
>  static void microbit_machine_class_init(ObjectClass *oc, void *data)
> --=20
> 2.19.2
>=20
>=20

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcLcA1AAoJEJykq7OBq3PIoTEH/2xOAU0P4RebFVcOUsh7+uPc
Czfr0L5zoXelNYWU26F8xg7NeQpMGLISAfvVGfL68ptTdYLlVmCj07JUX1qcw0UL
oU/KW2ZYh8ugCGmklCjj8LIpCfiMrBlBh6p8Tgd99g4f4VG4FSaRpXhlpVd5mRQN
tPla/NqMZ/21G6b5vzCEqLFlHN/fCVNcGYQhH+HaP3CmRU8xoMdtwLnnQntWpmXn
z9sZRTIg0Yn1sefCmcdATZwWNlsMbzzsP/FPa3vZaECmNVMJzcXJ9xx3/2qb+xYt
nvGG3a/bbk4EUdeuJ3ROU9nTmKhUHZ3SksQQIO/dYL8mn78fnHpzP+IXGMNlPoE=
=H6T4
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
