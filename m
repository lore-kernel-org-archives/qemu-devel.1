Received: from eggs.gnu.org ([2001:4830:134:3::10]:41531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cjqdk-00080a-HJ
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 12:05:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cjqdj-00078a-Ha
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 12:05:12 -0500
References: <20170302195337.31558-1-alex.bennee@linaro.org>
	<20170302195337.31558-12-alex.bennee@linaro.org>
From: Frederic Konrad <fred.konrad@greensocs.com>
Message-ID: <4e71b620-8ebd-0f66-f032-64fb8cc98b9f@greensocs.com>
Date: Fri, 3 Mar 2017 18:05:02 +0100
MIME-Version: 1.0
In-Reply-To: <20170302195337.31558-12-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 11/11] hw/intc/arm_gic: modernise the
 DPRINTF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, rth@twiddle.net, pbonzini@redhat.com, mttcg@listserver.greensocs.com, nikunj@linux.vnet.ibm.com, a.rigo@virtualopensystems.com, qemu-devel@nongnu.org, cota@braap.org, "open list:ARM cores" <qemu-arm@nongnu.org>, bobby.prani@gmail.com

Hi Alex,

On 03/02/2017 08:53 PM, Alex Benn=C3=A9e wrote:
> While I was debugging the icount issues I realised a bunch of the
> messages look quite similar. I've fixed this by including __func__ in
> the debug print. At the same time I move the a modern if (GATE) style
> printf which ensures the compiler can check for format string errors
> even if the code gets optimised away in the non-DEBUG_GIC case.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  hw/intc/arm_gic.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
> index 8e5a9d8a3e..b305d9032a 100644
> --- a/hw/intc/arm_gic.c
> +++ b/hw/intc/arm_gic.c
> @@ -26,15 +26,20 @@
>  #include "qemu/log.h"
>  #include "trace.h"
> =20
> -//#define DEBUG_GIC
> +/* #define DEBUG_GIC */
> =20
>  #ifdef DEBUG_GIC
> -#define DPRINTF(fmt, ...) \
> -do { fprintf(stderr, "arm_gic: " fmt , ## __VA_ARGS__); } while (0)
> +#define DEBUG_GIC_GATE 1
>  #else
> -#define DPRINTF(fmt, ...) do {} while(0)
> +#define DEBUG_GIC_GATE 0
>  #endif
> =20
> +#define DPRINTF(fmt, ...) do {                                        =
  \
> +        if (DEBUG_GIC_GATE) {                                         =
  \
> +            fprintf(stderr, "%s: " fmt, __func__, ## __VA_ARGS__);    =
  \
> +        }                                                             =
  \
> +    } while (0)
> +

Seems a prefered way is using qemu_log instead of fprintf?

Thanks,
Fred

>  static const uint8_t gic_id_11mpcore[] =3D {
>      0x00, 0x00, 0x00, 0x00, 0x90, 0x13, 0x04, 0x00, 0x0d, 0xf0, 0x05, =
0xb1
>  };
>=20
