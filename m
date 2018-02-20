Received: from eggs.gnu.org ([2001:4830:134:3::10]:58185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1enzRn-000526-K2
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 23:22:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1enzRm-0006u8-8Q
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 23:22:31 -0500
Date: Tue, 20 Feb 2018 15:20:57 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180220042057.GL1109@umbus.fritz.box>
References: <20180219181922.21586-1-mark.cave-ayland@ilande.co.uk>
	<20180219181922.21586-5-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aYrjF+tKt+ApYAdb"
Content-Disposition: inline
In-Reply-To: <20180219181922.21586-5-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 04/11] heathrow: convert to trace-events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--aYrjF+tKt+ApYAdb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2018 at 06:19:15PM +0000, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/intc/heathrow_pic.c         | 31 ++++++++++++-------------------
>  hw/intc/trace-events           |  5 +++++
>  include/hw/intc/heathrow_pic.h |  1 +
>  3 files changed, 18 insertions(+), 19 deletions(-)
>=20
> diff --git a/hw/intc/heathrow_pic.c b/hw/intc/heathrow_pic.c
> index 7bf44e0d86..afe0b08cbb 100644
> --- a/hw/intc/heathrow_pic.c
> +++ b/hw/intc/heathrow_pic.c
> @@ -26,16 +26,7 @@
>  #include "hw/hw.h"
>  #include "hw/ppc/mac.h"
>  #include "hw/intc/heathrow_pic.h"
> -
> -/* debug PIC */
> -//#define DEBUG_PIC
> -
> -#ifdef DEBUG_PIC
> -#define PIC_DPRINTF(fmt, ...)                                   \
> -    do { printf("PIC: " fmt , ## __VA_ARGS__); } while (0)
> -#else
> -#define PIC_DPRINTF(fmt, ...)
> -#endif
> +#include "trace.h"
> =20
>  static inline int heathrow_check_irq(HeathrowPICState *pic)
>  {
> @@ -61,7 +52,7 @@ static void heathrow_write(void *opaque, hwaddr addr,
>      unsigned int n;
> =20
>      n =3D ((addr & 0xfff) - 0x10) >> 4;
> -    PIC_DPRINTF("writel: " TARGET_FMT_plx " %u: %08x\n", addr, n, value);
> +    trace_heathrow_write(addr, n, value);
>      if (n >=3D 2)
>          return;
>      pic =3D &s->pics[n];
> @@ -109,7 +100,7 @@ static uint64_t heathrow_read(void *opaque, hwaddr ad=
dr,
>              break;
>          }
>      }
> -    PIC_DPRINTF("readl: " TARGET_FMT_plx " %u: %08x\n", addr, n, value);
> +    trace_heathrow_read(addr, n, value);
>      return value;
>  }
> =20
> @@ -124,16 +115,18 @@ static void heathrow_set_irq(void *opaque, int num,=
 int level)
>      HeathrowState *s =3D opaque;
>      HeathrowPICState *pic;
>      unsigned int irq_bit;
> +    int last_level =3D (s->last_levels & (num << 1UL)) ? 1 : 0;
> =20
> -#if defined(DEBUG)
> -    {
> -        static int last_level[64];
> -        if (last_level[num] !=3D level) {
> -            PIC_DPRINTF("set_irq: num=3D0x%02x level=3D%d\n", num, level=
);
> -            last_level[num] =3D level;
> +    if (last_level !=3D level) {
> +        trace_heathrow_set_irq(num, level);
> +
> +        if (level) {
> +            s->last_levels |=3D (num << 1UL);
> +        } else {
> +            s->last_levels &=3D ~(num << 1UL);

Cleaning up this last_level stuff is a good idea, but is a bit more
involved than merely converting to trace-events.

It's also not really the "last" level - it's effectively maintaining
the current level of the input irqs.  .. and isn't that information
already within the HeathrowPICState structure?

>          }
>      }
> -#endif
> +
>      pic =3D &s->pics[1 - (num >> 5)];
>      irq_bit =3D 1 << (num & 0x1f);
>      if (level) {
> diff --git a/hw/intc/trace-events b/hw/intc/trace-events
> index 4092d2825e..55e8c2570c 100644
> --- a/hw/intc/trace-events
> +++ b/hw/intc/trace-events
> @@ -186,3 +186,8 @@ nvic_complete_irq(int irq, bool secure) "NVIC complet=
e IRQ %d (secure %d)"
>  nvic_set_irq_level(int irq, int level) "NVIC external irq %d level set t=
o %d"
>  nvic_sysreg_read(uint64_t addr, uint32_t value, unsigned size) "NVIC sys=
reg read addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
>  nvic_sysreg_write(uint64_t addr, uint32_t value, unsigned size) "NVIC sy=
sreg write addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
> +
> +# hw/intc/heathrow_pic.c
> +heathrow_write(uint64_t addr, unsigned int n, uint64_t value) "0x%"PRIx6=
4" %u: 0x%"PRIx64
> +heathrow_read(uint64_t addr, unsigned int n, uint64_t value) "0x%"PRIx64=
" %u: 0x%"PRIx64
> +heathrow_set_irq(int num, int level) "set_irq: num=3D0x%02x level=3D%d"
> diff --git a/include/hw/intc/heathrow_pic.h b/include/hw/intc/heathrow_pi=
c.h
> index bc3ffaab87..878a0f7cdb 100644
> --- a/include/hw/intc/heathrow_pic.h
> +++ b/include/hw/intc/heathrow_pic.h
> @@ -42,6 +42,7 @@ typedef struct HeathrowState {
>      MemoryRegion mem;
>      HeathrowPICState pics[2];
>      qemu_irq *irqs;
> +    uint64_t last_levels;
>  } HeathrowState;
> =20
>  #define HEATHROW_NUM_IRQS 64

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--aYrjF+tKt+ApYAdb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqLoicACgkQbDjKyiDZ
s5KwPw//XGssKEOxCQNkg01Zicv8FBv4R8sHAn7bQunG0MFf0KVjos8Z/yOrcHkc
C5Mbrs/yVY6JLsxrpJaPygAF4sLjeuIUB3TRLvx7CJUC1r2yHQckV3mfPtXyFRWs
zs8hPZFHkkrILdjDrBTAk0a2hH7TgNjMaVULE77Yqg7aeM6tWA7qhFLpU3p+RnuJ
xOL78e7psTOZE4jVC7bFGnZ+J6bKd64cDc+32DI6obEvj2sqWDPzSD/kAsXKQCRY
9c3Lggjta7xxsuLWf9G1nbXgueDrqOHjdSo9Fn7OUX+Us3dffRJam23Wfb6cjrab
OB3ksCpBmq+mJ0C0xYpXR7hEZR1R2hnYY4JAt/N5FBCR0GGewyg6itzJc+Laa7PF
ZDi6oWyFA8I6hz94b2oyMlXpsgdgwtrsn1XGD/R9DSfxjzJBbphFwQDFbUPvBne/
Ypc38yIiHIzH7d1XIInh58fSb2RdnlzYq+V9PhEYUDk8hciiz54h4CSqMuHC/+w+
+ZYBaUEZNNFKcAZcrYoNRT8yUoj46eRuY0q5QcGdBnZ3d3NcIt4WwEeDZnCcHLgO
JwEdn+zo1JrOKAu/1+ggh5W7WuofWPwsNkKxP/X/QppkQ7oiBd/cDep+vlJs8Ro7
tmXWOkLjJNYJoQ9jm5aNjfVFEsQF01Aig7x8Ci09ghQIaazL+tU=
=4pya
-----END PGP SIGNATURE-----

--aYrjF+tKt+ApYAdb--
