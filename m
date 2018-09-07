Received: from eggs.gnu.org ([2001:4830:134:3::10]:51767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@antfield.fr>) id 1fyBTK-00059m-Os
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 03:46:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@antfield.fr>) id 1fyBTJ-0003Nc-L8
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 03:46:30 -0400
References: <20180824161819.11085-1-peter.maydell@linaro.org>
From: Luc Michel <luc.michel@antfield.fr>
Message-ID: <07ec9f46-7e11-cd28-2afa-b429f5b46bfc@antfield.fr>
Date: Fri, 7 Sep 2018 09:46:12 +0200
MIME-Version: 1.0
In-Reply-To: <20180824161819.11085-1-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7AdPgvmHAU0iaKS6eTvqPFazlG9amWJIS"
Subject: Re: [Qemu-devel] [PATCH] hw/intc/arm_gic: Drop GIC_BASE_IRQ macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7AdPgvmHAU0iaKS6eTvqPFazlG9amWJIS
From: Luc Michel <luc.michel@antfield.fr>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: patches@linaro.org
Message-ID: <07ec9f46-7e11-cd28-2afa-b429f5b46bfc@antfield.fr>
Subject: Re: [Qemu-devel] [PATCH] hw/intc/arm_gic: Drop GIC_BASE_IRQ macro
References: <20180824161819.11085-1-peter.maydell@linaro.org>
In-Reply-To: <20180824161819.11085-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 8/24/18 6:18 PM, Peter Maydell wrote:
> The GIC_BASE_IRQ macro is a leftover from when we shared code
> between the GICv2 and the v7M NVIC. Since the NVIC is now
> split off, GIC_BASE_IRQ is always 0, and we can just delete it.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

> ---
>  hw/intc/gic_internal.h   |  2 --
>  hw/intc/arm_gic.c        | 31 ++++++++++++++-----------------
>  hw/intc/arm_gic_common.c |  1 -
>  3 files changed, 14 insertions(+), 20 deletions(-)
>=20
> diff --git a/hw/intc/gic_internal.h b/hw/intc/gic_internal.h
> index 45c2af0bf59..8d29b40ca10 100644
> --- a/hw/intc/gic_internal.h
> +++ b/hw/intc/gic_internal.h
> @@ -26,8 +26,6 @@
> =20
>  #define ALL_CPU_MASK ((unsigned)(((1 << GIC_NCPU) - 1)))
> =20
> -#define GIC_BASE_IRQ 0
> -
>  #define GIC_DIST_SET_ENABLED(irq, cm) (s->irq_state[irq].enabled |=3D =
(cm))
>  #define GIC_DIST_CLEAR_ENABLED(irq, cm) (s->irq_state[irq].enabled &=3D=
 ~(cm))
>  #define GIC_DIST_TEST_ENABLED(irq, cm) ((s->irq_state[irq].enabled & (=
cm)) !=3D 0)
> diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
> index 542b4b93eab..b3ac2d11fc5 100644
> --- a/hw/intc/arm_gic.c
> +++ b/hw/intc/arm_gic.c
> @@ -955,7 +955,7 @@ static uint32_t gic_dist_readb(void *opaque, hwaddr=
 offset, MemTxAttrs attrs)
>              res =3D 0;
>              if (!(s->security_extn && !attrs.secure) && gic_has_groups=
(s)) {
>                  /* Every byte offset holds 8 group status bits */
> -                irq =3D (offset - 0x080) * 8 + GIC_BASE_IRQ;
> +                irq =3D (offset - 0x080) * 8;
>                  if (irq >=3D s->num_irq) {
>                      goto bad_reg;
>                  }
> @@ -974,7 +974,6 @@ static uint32_t gic_dist_readb(void *opaque, hwaddr=
 offset, MemTxAttrs attrs)
>              irq =3D (offset - 0x100) * 8;
>          else
>              irq =3D (offset - 0x180) * 8;
> -        irq +=3D GIC_BASE_IRQ;
>          if (irq >=3D s->num_irq)
>              goto bad_reg;
>          res =3D 0;
> @@ -994,7 +993,6 @@ static uint32_t gic_dist_readb(void *opaque, hwaddr=
 offset, MemTxAttrs attrs)
>              irq =3D (offset - 0x200) * 8;
>          else
>              irq =3D (offset - 0x280) * 8;
> -        irq +=3D GIC_BASE_IRQ;
>          if (irq >=3D s->num_irq)
>              goto bad_reg;
>          res =3D 0;
> @@ -1019,7 +1017,6 @@ static uint32_t gic_dist_readb(void *opaque, hwad=
dr offset, MemTxAttrs attrs)
>              goto bad_reg;
>          }
> =20
> -        irq +=3D GIC_BASE_IRQ;
>          if (irq >=3D s->num_irq)
>              goto bad_reg;
>          res =3D 0;
> @@ -1036,7 +1033,7 @@ static uint32_t gic_dist_readb(void *opaque, hwad=
dr offset, MemTxAttrs attrs)
>          }
>      } else if (offset < 0x800) {
>          /* Interrupt Priority.  */
> -        irq =3D (offset - 0x400) + GIC_BASE_IRQ;
> +        irq =3D (offset - 0x400);
>          if (irq >=3D s->num_irq)
>              goto bad_reg;
>          res =3D gic_dist_get_priority(s, cpu, irq, attrs);
> @@ -1046,7 +1043,7 @@ static uint32_t gic_dist_readb(void *opaque, hwad=
dr offset, MemTxAttrs attrs)
>              /* For uniprocessor GICs these RAZ/WI */
>              res =3D 0;
>          } else {
> -            irq =3D (offset - 0x800) + GIC_BASE_IRQ;
> +            irq =3D (offset - 0x800);
>              if (irq >=3D s->num_irq) {
>                  goto bad_reg;
>              }
> @@ -1060,7 +1057,7 @@ static uint32_t gic_dist_readb(void *opaque, hwad=
dr offset, MemTxAttrs attrs)
>          }
>      } else if (offset < 0xf00) {
>          /* Interrupt Configuration.  */
> -        irq =3D (offset - 0xc00) * 4 + GIC_BASE_IRQ;
> +        irq =3D (offset - 0xc00) * 4;
>          if (irq >=3D s->num_irq)
>              goto bad_reg;
>          res =3D 0;
> @@ -1183,7 +1180,7 @@ static void gic_dist_writeb(void *opaque, hwaddr =
offset,
>               */
>              if (!(s->security_extn && !attrs.secure) && gic_has_groups=
(s)) {
>                  /* Every byte offset holds 8 group status bits */
> -                irq =3D (offset - 0x80) * 8 + GIC_BASE_IRQ;
> +                irq =3D (offset - 0x80) * 8;
>                  if (irq >=3D s->num_irq) {
>                      goto bad_reg;
>                  }
> @@ -1204,7 +1201,7 @@ static void gic_dist_writeb(void *opaque, hwaddr =
offset,
>          }
>      } else if (offset < 0x180) {
>          /* Interrupt Set Enable.  */
> -        irq =3D (offset - 0x100) * 8 + GIC_BASE_IRQ;
> +        irq =3D (offset - 0x100) * 8;
>          if (irq >=3D s->num_irq)
>              goto bad_reg;
>          if (irq < GIC_NR_SGIS) {
> @@ -1239,7 +1236,7 @@ static void gic_dist_writeb(void *opaque, hwaddr =
offset,
>          }
>      } else if (offset < 0x200) {
>          /* Interrupt Clear Enable.  */
> -        irq =3D (offset - 0x180) * 8 + GIC_BASE_IRQ;
> +        irq =3D (offset - 0x180) * 8;
>          if (irq >=3D s->num_irq)
>              goto bad_reg;
>          if (irq < GIC_NR_SGIS) {
> @@ -1264,7 +1261,7 @@ static void gic_dist_writeb(void *opaque, hwaddr =
offset,
>          }
>      } else if (offset < 0x280) {
>          /* Interrupt Set Pending.  */
> -        irq =3D (offset - 0x200) * 8 + GIC_BASE_IRQ;
> +        irq =3D (offset - 0x200) * 8;
>          if (irq >=3D s->num_irq)
>              goto bad_reg;
>          if (irq < GIC_NR_SGIS) {
> @@ -1283,7 +1280,7 @@ static void gic_dist_writeb(void *opaque, hwaddr =
offset,
>          }
>      } else if (offset < 0x300) {
>          /* Interrupt Clear Pending.  */
> -        irq =3D (offset - 0x280) * 8 + GIC_BASE_IRQ;
> +        irq =3D (offset - 0x280) * 8;
>          if (irq >=3D s->num_irq)
>              goto bad_reg;
>          if (irq < GIC_NR_SGIS) {
> @@ -1309,7 +1306,7 @@ static void gic_dist_writeb(void *opaque, hwaddr =
offset,
>              goto bad_reg;
>          }
> =20
> -        irq =3D (offset - 0x300) * 8 + GIC_BASE_IRQ;
> +        irq =3D (offset - 0x300) * 8;
>          if (irq >=3D s->num_irq) {
>              goto bad_reg;
>          }
> @@ -1333,7 +1330,7 @@ static void gic_dist_writeb(void *opaque, hwaddr =
offset,
>              goto bad_reg;
>          }
> =20
> -        irq =3D (offset - 0x380) * 8 + GIC_BASE_IRQ;
> +        irq =3D (offset - 0x380) * 8;
>          if (irq >=3D s->num_irq) {
>              goto bad_reg;
>          }
> @@ -1353,7 +1350,7 @@ static void gic_dist_writeb(void *opaque, hwaddr =
offset,
>          }
>      } else if (offset < 0x800) {
>          /* Interrupt Priority.  */
> -        irq =3D (offset - 0x400) + GIC_BASE_IRQ;
> +        irq =3D (offset - 0x400);
>          if (irq >=3D s->num_irq)
>              goto bad_reg;
>          gic_dist_set_priority(s, cpu, irq, value, attrs);
> @@ -1362,7 +1359,7 @@ static void gic_dist_writeb(void *opaque, hwaddr =
offset,
>           * annoying exception of the 11MPCore's GIC.
>           */
>          if (s->num_cpu !=3D 1 || s->revision =3D=3D REV_11MPCORE) {
> -            irq =3D (offset - 0x800) + GIC_BASE_IRQ;
> +            irq =3D (offset - 0x800);
>              if (irq >=3D s->num_irq) {
>                  goto bad_reg;
>              }
> @@ -1375,7 +1372,7 @@ static void gic_dist_writeb(void *opaque, hwaddr =
offset,
>          }
>      } else if (offset < 0xf00) {
>          /* Interrupt Configuration.  */
> -        irq =3D (offset - 0xc00) * 4 + GIC_BASE_IRQ;
> +        irq =3D (offset - 0xc00) * 4;
>          if (irq >=3D s->num_irq)
>              goto bad_reg;
>          if (irq < GIC_NR_SGIS)
> diff --git a/hw/intc/arm_gic_common.c b/hw/intc/arm_gic_common.c
> index 547dc41185e..57569a4e590 100644
> --- a/hw/intc/arm_gic_common.c
> +++ b/hw/intc/arm_gic_common.c
> @@ -191,7 +191,6 @@ static void arm_gic_common_realize(DeviceState *dev=
, Error **errp)
>                     s->num_cpu, GIC_NCPU);
>          return;
>      }
> -    s->num_irq +=3D GIC_BASE_IRQ;
>      if (s->num_irq > GIC_MAXIRQ) {
>          error_setg(errp,
>                     "requested %u interrupt lines exceeds GIC maximum %=
d",
>=20


--7AdPgvmHAU0iaKS6eTvqPFazlG9amWJIS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUvSC0Bi15mxw2PT5d8knW3QnTr4FAluSLMwACgkQd8knW3Qn
Tr5R8RAAnulpmeSiI0zf2gnWz0GvmgixHFTvMnxQvPXxSJG2SRZ9vluWXv/JcwCP
5PzJX5qiaeh7ncpzH/lBt9izyqlAPbca9Clu76vULzt75k4XcdA6fQR6Vk9S/3Pq
aJWRKepuULf8vIFVCC7O/idoFrhdIbxg5sg2RmC8m6WE+qood83IQ6bXopzxjx8T
3WlVXox15iv2vBlwO4u6Bfuw45QfcgEXxWN7SmF6i7ZjIfHnDG7YN7N0D9jrAj35
NWglFweFTlT3/caVtbyear4aQspfzyBPsB8ZRLMF3egLVzv8UycQBMtsUJGNStWh
HkjdzvzqlL/o8yUY0XZVThzunLmAY2oL1kGbVAbM/Ed12j3efDW+JcsJrWiVKH8B
Jsu4BPsV32qlE41lWttMttXuuI1QtWCxNznCupQOfsGweoFeefQRpIk/ZhibmwbR
DpbRpBEhSFv39x3dr+B+PFb+LO3Y+ACmxY8gYt9E83AEuEphOnO7cNp62AG068bL
sWCryLhHls0C41y5rcOfLlrh7dBN2a1W0ceZ+ghYPPwyPlw0MxNXlgJX3xCGGVGP
+J0xZCY71Pe9Eljpa9P/nJTiGsGSGIrN+gFWZTm3XQESTp5haLta7wHT5NzBO8eJ
fCKSq56VqUWqI233rsJ33/ia/hikPJIdqLWRgc7KTGSV50iDCn8=
=G5AK
-----END PGP SIGNATURE-----

--7AdPgvmHAU0iaKS6eTvqPFazlG9amWJIS--
