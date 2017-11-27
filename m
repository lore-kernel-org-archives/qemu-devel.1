Received: from eggs.gnu.org ([2001:4830:134:3::10]:45383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eJE04-0008Ck-Lw
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 02:38:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eJE00-00005X-QK
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 02:38:44 -0500
Date: Mon, 27 Nov 2017 18:09:23 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171127070923.GD11775@umbus.fritz.box>
References: <cover.1511731946.git.mdavidsaver@gmail.com>
	<c05b2d1ba26e250658fa1b68747ae7ca7c488ed2.1511731946.git.mdavidsaver@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xB0nW4MQa6jZONgY"
Content-Disposition: inline
In-Reply-To: <c05b2d1ba26e250658fa1b68747ae7ca7c488ed2.1511731946.git.mdavidsaver@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 01/17] openpic: debug w/ info_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Davidsaver <mdavidsaver@gmail.com>
Cc: Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--xB0nW4MQa6jZONgY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 26, 2017 at 03:58:59PM -0600, Michael Davidsaver wrote:
> Replace *printf() with *_report().
> Remove trailing new lines.
>=20
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>

Applied to ppc-for-2.12.

> ---
>  hw/intc/openpic.c | 102 +++++++++++++++++++++++++++---------------------=
------
>  1 file changed, 51 insertions(+), 51 deletions(-)
>=20
> diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
> index 10d6e871fb..9159a06f07 100644
> --- a/hw/intc/openpic.c
> +++ b/hw/intc/openpic.c
> @@ -46,6 +46,7 @@
>  #include "qapi/qmp/qerror.h"
>  #include "qemu/log.h"
>  #include "qemu/timer.h"
> +#include "qemu/error-report.h"
> =20
>  //#define DEBUG_OPENPIC
> =20
> @@ -58,8 +59,7 @@ static const int debug_openpic =3D 0;
>  static int get_current_cpu(void);
>  #define DPRINTF(fmt, ...) do { \
>          if (debug_openpic) { \
> -            printf("Core%d: ", get_current_cpu()); \
> -            printf(fmt , ## __VA_ARGS__); \
> +            info_report("Core%d: " fmt, get_current_cpu(), ## __VA_ARGS_=
_); \
>          } \
>      } while (0)
> =20
> @@ -173,7 +173,7 @@ static int inttgt_to_output(int inttgt)
>          }
>      }
> =20
> -    fprintf(stderr, "%s: unsupported inttgt %d\n", __func__, inttgt);
> +    error_report("%s: unsupported inttgt %d", __func__, inttgt);
>      return OPENPIC_OUTPUT_INT;
>  }
> =20
> @@ -372,7 +372,7 @@ static void IRQ_check(OpenPICState *opp, IRQQueue *q)
>              break;
>          }
> =20
> -        DPRINTF("IRQ_check: irq %d set ivpr_pr=3D%d pr=3D%d\n",
> +        DPRINTF("IRQ_check: irq %d set ivpr_pr=3D%d pr=3D%d",
>                  irq, IVPR_PRIORITY(opp->src[irq].ivpr), priority);
> =20
>          if (IVPR_PRIORITY(opp->src[irq].ivpr) > priority) {
> @@ -403,11 +403,11 @@ static void IRQ_local_pipe(OpenPICState *opp, int n=
_CPU, int n_IRQ,
>      dst =3D &opp->dst[n_CPU];
>      src =3D &opp->src[n_IRQ];
> =20
> -    DPRINTF("%s: IRQ %d active %d was %d\n",
> +    DPRINTF("%s: IRQ %d active %d was %d",
>              __func__, n_IRQ, active, was_active);
> =20
>      if (src->output !=3D OPENPIC_OUTPUT_INT) {
> -        DPRINTF("%s: output %d irq %d active %d was %d count %d\n",
> +        DPRINTF("%s: output %d irq %d active %d was %d count %d",
>                  __func__, src->output, n_IRQ, active, was_active,
>                  dst->outputs_active[src->output]);
> =20
> @@ -417,13 +417,13 @@ static void IRQ_local_pipe(OpenPICState *opp, int n=
_CPU, int n_IRQ,
>           */
>          if (active) {
>              if (!was_active && dst->outputs_active[src->output]++ =3D=3D=
 0) {
> -                DPRINTF("%s: Raise OpenPIC output %d cpu %d irq %d\n",
> +                DPRINTF("%s: Raise OpenPIC output %d cpu %d irq %d",
>                          __func__, src->output, n_CPU, n_IRQ);
>                  qemu_irq_raise(dst->irqs[src->output]);
>              }
>          } else {
>              if (was_active && --dst->outputs_active[src->output] =3D=3D =
0) {
> -                DPRINTF("%s: Lower OpenPIC output %d cpu %d irq %d\n",
> +                DPRINTF("%s: Lower OpenPIC output %d cpu %d irq %d",
>                          __func__, src->output, n_CPU, n_IRQ);
>                  qemu_irq_lower(dst->irqs[src->output]);
>              }
> @@ -446,7 +446,7 @@ static void IRQ_local_pipe(OpenPICState *opp, int n_C=
PU, int n_IRQ,
>      IRQ_check(opp, &dst->raised);
> =20
>      if (active && priority <=3D dst->ctpr) {
> -        DPRINTF("%s: IRQ %d priority %d too low for ctpr %d on CPU %d\n",
> +        DPRINTF("%s: IRQ %d priority %d too low for ctpr %d on CPU %d",
>                  __func__, n_IRQ, priority, dst->ctpr, n_CPU);
>          active =3D 0;
>      }
> @@ -454,10 +454,10 @@ static void IRQ_local_pipe(OpenPICState *opp, int n=
_CPU, int n_IRQ,
>      if (active) {
>          if (IRQ_get_next(opp, &dst->servicing) >=3D 0 &&
>                  priority <=3D dst->servicing.priority) {
> -            DPRINTF("%s: IRQ %d is hidden by servicing IRQ %d on CPU %d\=
n",
> +            DPRINTF("%s: IRQ %d is hidden by servicing IRQ %d on CPU %d",
>                      __func__, n_IRQ, dst->servicing.next, n_CPU);
>          } else {
> -            DPRINTF("%s: Raise OpenPIC INT output cpu %d irq %d/%d\n",
> +            DPRINTF("%s: Raise OpenPIC INT output cpu %d irq %d/%d",
>                      __func__, n_CPU, n_IRQ, dst->raised.next);
>              qemu_irq_raise(opp->dst[n_CPU].irqs[OPENPIC_OUTPUT_INT]);
>          }
> @@ -465,12 +465,12 @@ static void IRQ_local_pipe(OpenPICState *opp, int n=
_CPU, int n_IRQ,
>          IRQ_get_next(opp, &dst->servicing);
>          if (dst->raised.priority > dst->ctpr &&
>                  dst->raised.priority > dst->servicing.priority) {
> -            DPRINTF("%s: IRQ %d inactive, IRQ %d prio %d above %d/%d, CP=
U %d\n",
> +            DPRINTF("%s: IRQ %d inactive, IRQ %d prio %d above %d/%d, CP=
U %d",
>                      __func__, n_IRQ, dst->raised.next, dst->raised.prior=
ity,
>                      dst->ctpr, dst->servicing.priority, n_CPU);
>              /* IRQ line stays asserted */
>          } else {
> -            DPRINTF("%s: IRQ %d inactive, current prio %d/%d, CPU %d\n",
> +            DPRINTF("%s: IRQ %d inactive, current prio %d/%d, CPU %d",
>                      __func__, n_IRQ, dst->ctpr, dst->servicing.priority,=
 n_CPU);
>              qemu_irq_lower(opp->dst[n_CPU].irqs[OPENPIC_OUTPUT_INT]);
>          }
> @@ -489,7 +489,7 @@ static void openpic_update_irq(OpenPICState *opp, int=
 n_IRQ)
> =20
>      if ((src->ivpr & IVPR_MASK_MASK) && !src->nomask) {
>          /* Interrupt source is disabled */
> -        DPRINTF("%s: IRQ %d is disabled\n", __func__, n_IRQ);
> +        DPRINTF("%s: IRQ %d is disabled", __func__, n_IRQ);
>          active =3D false;
>      }
> =20
> @@ -500,7 +500,7 @@ static void openpic_update_irq(OpenPICState *opp, int=
 n_IRQ)
>       * ctpr may have changed and we need to withdraw the interrupt.
>       */
>      if (!active && !was_active) {
> -        DPRINTF("%s: IRQ %d is already inactive\n", __func__, n_IRQ);
> +        DPRINTF("%s: IRQ %d is already inactive", __func__, n_IRQ);
>          return;
>      }
> =20
> @@ -512,7 +512,7 @@ static void openpic_update_irq(OpenPICState *opp, int=
 n_IRQ)
> =20
>      if (src->destmask =3D=3D 0) {
>          /* No target */
> -        DPRINTF("%s: IRQ %d has no target\n", __func__, n_IRQ);
> +        DPRINTF("%s: IRQ %d has no target", __func__, n_IRQ);
>          return;
>      }
> =20
> @@ -547,12 +547,12 @@ static void openpic_set_irq(void *opaque, int n_IRQ=
, int level)
>      IRQSource *src;
> =20
>      if (n_IRQ >=3D OPENPIC_MAX_IRQ) {
> -        fprintf(stderr, "%s: IRQ %d out of range\n", __func__, n_IRQ);
> +        error_report("%s: IRQ %d out of range", __func__, n_IRQ);
>          abort();
>      }
> =20
>      src =3D &opp->src[n_IRQ];
> -    DPRINTF("openpic: set irq %d =3D %d ivpr=3D0x%08x\n",
> +    DPRINTF("openpic: set irq %d =3D %d ivpr=3D0x%08x",
>              n_IRQ, level, src->ivpr);
>      if (src->level) {
>          /* level-sensitive irq */
> @@ -612,13 +612,13 @@ static inline void write_IRQreg_idr(OpenPICState *o=
pp, int n_IRQ, uint32_t val)
>      }
> =20
>      src->idr =3D val & mask;
> -    DPRINTF("Set IDR %d to 0x%08x\n", n_IRQ, src->idr);
> +    DPRINTF("Set IDR %d to 0x%08x", n_IRQ, src->idr);
> =20
>      if (opp->flags & OPENPIC_FLAG_IDR_CRIT) {
>          if (src->idr & crit_mask) {
>              if (src->idr & normal_mask) {
>                  DPRINTF("%s: IRQ configured for multiple output types, u=
sing "
> -                        "critical\n", __func__);
> +                        "critical", __func__);
>              }
> =20
>              src->output =3D OPENPIC_OUTPUT_CINT;
> @@ -648,7 +648,7 @@ static inline void write_IRQreg_ilr(OpenPICState *opp=
, int n_IRQ, uint32_t val)
>          IRQSource *src =3D &opp->src[n_IRQ];
> =20
>          src->output =3D inttgt_to_output(val & ILR_INTTGT_MASK);
> -        DPRINTF("Set ILR %d to 0x%08x, output %d\n", n_IRQ, src->idr,
> +        DPRINTF("Set ILR %d to 0x%08x, output %d", n_IRQ, src->idr,
>                  src->output);
> =20
>          /* TODO: on MPIC v4.0 only, set nomask for non-INT */
> @@ -688,7 +688,7 @@ static inline void write_IRQreg_ivpr(OpenPICState *op=
p, int n_IRQ, uint32_t val)
>      }
> =20
>      openpic_update_irq(opp, n_IRQ);
> -    DPRINTF("Set IVPR %d to 0x%08x -> 0x%08x\n", n_IRQ, val,
> +    DPRINTF("Set IVPR %d to 0x%08x -> 0x%08x", n_IRQ, val,
>              opp->src[n_IRQ].ivpr);
>  }
> =20
> @@ -719,7 +719,7 @@ static void openpic_gbl_write(void *opaque, hwaddr ad=
dr, uint64_t val,
>      IRQDest *dst;
>      int idx;
> =20
> -    DPRINTF("%s: addr %#" HWADDR_PRIx " <=3D %08" PRIx64 "\n",
> +    DPRINTF("%s: addr %#" HWADDR_PRIx " <=3D %08" PRIx64,
>              __func__, addr, val);
>      if (addr & 0xF) {
>          return;
> @@ -747,11 +747,11 @@ static void openpic_gbl_write(void *opaque, hwaddr =
addr, uint64_t val,
>      case 0x1090: /* PIR */
>          for (idx =3D 0; idx < opp->nb_cpus; idx++) {
>              if ((val & (1 << idx)) && !(opp->pir & (1 << idx))) {
> -                DPRINTF("Raise OpenPIC RESET output for CPU %d\n", idx);
> +                DPRINTF("Raise OpenPIC RESET output for CPU %d", idx);
>                  dst =3D &opp->dst[idx];
>                  qemu_irq_raise(dst->irqs[OPENPIC_OUTPUT_RESET]);
>              } else if (!(val & (1 << idx)) && (opp->pir & (1 << idx))) {
> -                DPRINTF("Lower OpenPIC RESET output for CPU %d\n", idx);
> +                DPRINTF("Lower OpenPIC RESET output for CPU %d", idx);
>                  dst =3D &opp->dst[idx];
>                  qemu_irq_lower(dst->irqs[OPENPIC_OUTPUT_RESET]);
>              }
> @@ -781,7 +781,7 @@ static uint64_t openpic_gbl_read(void *opaque, hwaddr=
 addr, unsigned len)
>      OpenPICState *opp =3D opaque;
>      uint32_t retval;
> =20
> -    DPRINTF("%s: addr %#" HWADDR_PRIx "\n", __func__, addr);
> +    DPRINTF("%s: addr %#" HWADDR_PRIx, __func__, addr);
>      retval =3D 0xFFFFFFFF;
>      if (addr & 0xF) {
>          return retval;
> @@ -828,7 +828,7 @@ static uint64_t openpic_gbl_read(void *opaque, hwaddr=
 addr, unsigned len)
>      default:
>          break;
>      }
> -    DPRINTF("%s: =3D> 0x%08x\n", __func__, retval);
> +    DPRINTF("%s: =3D> 0x%08x", __func__, retval);
> =20
>      return retval;
>  }
> @@ -843,7 +843,7 @@ static void qemu_timer_cb(void *opaque)
>      uint32_t val =3D   tmr->tbcr & ~TBCR_CI;
>      uint32_t tog =3D ((tmr->tccr & TCCR_TOG) ^ TCCR_TOG);  /* invert tog=
gle. */
> =20
> -    DPRINTF("%s n_IRQ=3D%d\n", __func__, n_IRQ);
> +    DPRINTF("%s n_IRQ=3D%d", __func__, n_IRQ);
>      /* Reload current count from base count and setup timer. */
>      tmr->tccr =3D val | tog;
>      openpic_tmr_set_tmr(tmr, val, /*enabled=3D*/true);
> @@ -898,7 +898,7 @@ static void openpic_tmr_write(void *opaque, hwaddr ad=
dr, uint64_t val,
>      OpenPICState *opp =3D opaque;
>      int idx;
> =20
> -    DPRINTF("%s: addr %#" HWADDR_PRIx " <=3D %08" PRIx64 "\n",
> +    DPRINTF("%s: addr %#" HWADDR_PRIx " <=3D %08" PRIx64,
>              __func__, (addr + 0x10f0), val);
>      if (addr & 0xF) {
>          return;
> @@ -943,7 +943,7 @@ static uint64_t openpic_tmr_read(void *opaque, hwaddr=
 addr, unsigned len)
>      uint32_t retval =3D -1;
>      int idx;
> =20
> -    DPRINTF("%s: addr %#" HWADDR_PRIx "\n", __func__, addr + 0x10f0);
> +    DPRINTF("%s: addr %#" HWADDR_PRIx, __func__, addr + 0x10f0);
>      if (addr & 0xF) {
>          goto out;
>      }
> @@ -970,7 +970,7 @@ static uint64_t openpic_tmr_read(void *opaque, hwaddr=
 addr, unsigned len)
>      }
> =20
>  out:
> -    DPRINTF("%s: =3D> 0x%08x\n", __func__, retval);
> +    DPRINTF("%s: =3D> 0x%08x", __func__, retval);
> =20
>      return retval;
>  }
> @@ -981,7 +981,7 @@ static void openpic_src_write(void *opaque, hwaddr ad=
dr, uint64_t val,
>      OpenPICState *opp =3D opaque;
>      int idx;
> =20
> -    DPRINTF("%s: addr %#" HWADDR_PRIx " <=3D %08" PRIx64 "\n",
> +    DPRINTF("%s: addr %#" HWADDR_PRIx " <=3D %08" PRIx64,
>              __func__, addr, val);
> =20
>      addr =3D addr & 0xffff;
> @@ -1006,7 +1006,7 @@ static uint64_t openpic_src_read(void *opaque, uint=
64_t addr, unsigned len)
>      uint32_t retval;
>      int idx;
> =20
> -    DPRINTF("%s: addr %#" HWADDR_PRIx "\n", __func__, addr);
> +    DPRINTF("%s: addr %#" HWADDR_PRIx, __func__, addr);
>      retval =3D 0xFFFFFFFF;
> =20
>      addr =3D addr & 0xffff;
> @@ -1024,7 +1024,7 @@ static uint64_t openpic_src_read(void *opaque, uint=
64_t addr, unsigned len)
>          break;
>      }
> =20
> -    DPRINTF("%s: =3D> 0x%08x\n", __func__, retval);
> +    DPRINTF("%s: =3D> 0x%08x", __func__, retval);
>      return retval;
>  }
> =20
> @@ -1035,7 +1035,7 @@ static void openpic_msi_write(void *opaque, hwaddr =
addr, uint64_t val,
>      int idx =3D opp->irq_msi;
>      int srs, ibs;
> =20
> -    DPRINTF("%s: addr %#" HWADDR_PRIx " <=3D 0x%08" PRIx64 "\n",
> +    DPRINTF("%s: addr %#" HWADDR_PRIx " <=3D 0x%08" PRIx64,
>              __func__, addr, val);
>      if (addr & 0xF) {
>          return;
> @@ -1061,7 +1061,7 @@ static uint64_t openpic_msi_read(void *opaque, hwad=
dr addr, unsigned size)
>      uint64_t r =3D 0;
>      int i, srs;
> =20
> -    DPRINTF("%s: addr %#" HWADDR_PRIx "\n", __func__, addr);
> +    DPRINTF("%s: addr %#" HWADDR_PRIx, __func__, addr);
>      if (addr & 0xF) {
>          return -1;
>      }
> @@ -1096,7 +1096,7 @@ static uint64_t openpic_summary_read(void *opaque, =
hwaddr addr, unsigned size)
>  {
>      uint64_t r =3D 0;
> =20
> -    DPRINTF("%s: addr %#" HWADDR_PRIx "\n", __func__, addr);
> +    DPRINTF("%s: addr %#" HWADDR_PRIx, __func__, addr);
> =20
>      /* TODO: EISR/EIMR */
> =20
> @@ -1106,7 +1106,7 @@ static uint64_t openpic_summary_read(void *opaque, =
hwaddr addr, unsigned size)
>  static void openpic_summary_write(void *opaque, hwaddr addr, uint64_t va=
l,
>                                    unsigned size)
>  {
> -    DPRINTF("%s: addr %#" HWADDR_PRIx " <=3D 0x%08" PRIx64 "\n",
> +    DPRINTF("%s: addr %#" HWADDR_PRIx " <=3D 0x%08" PRIx64,
>              __func__, addr, val);
> =20
>      /* TODO: EISR/EIMR */
> @@ -1120,7 +1120,7 @@ static void openpic_cpu_write_internal(void *opaque=
, hwaddr addr,
>      IRQDest *dst;
>      int s_IRQ, n_IRQ;
> =20
> -    DPRINTF("%s: cpu %d addr %#" HWADDR_PRIx " <=3D 0x%08x\n", __func__,=
 idx,
> +    DPRINTF("%s: cpu %d addr %#" HWADDR_PRIx " <=3D 0x%08x", __func__, i=
dx,
>              addr, val);
> =20
>      if (idx < 0 || idx >=3D opp->nb_cpus) {
> @@ -1146,16 +1146,16 @@ static void openpic_cpu_write_internal(void *opaq=
ue, hwaddr addr,
>      case 0x80: /* CTPR */
>          dst->ctpr =3D val & 0x0000000F;
> =20
> -        DPRINTF("%s: set CPU %d ctpr to %d, raised %d servicing %d\n",
> +        DPRINTF("%s: set CPU %d ctpr to %d, raised %d servicing %d",
>                  __func__, idx, dst->ctpr, dst->raised.priority,
>                  dst->servicing.priority);
> =20
>          if (dst->raised.priority <=3D dst->ctpr) {
> -            DPRINTF("%s: Lower OpenPIC INT output cpu %d due to ctpr\n",
> +            DPRINTF("%s: Lower OpenPIC INT output cpu %d due to ctpr",
>                      __func__, idx);
>              qemu_irq_lower(dst->irqs[OPENPIC_OUTPUT_INT]);
>          } else if (dst->raised.priority > dst->servicing.priority) {
> -            DPRINTF("%s: Raise OpenPIC INT output cpu %d irq %d\n",
> +            DPRINTF("%s: Raise OpenPIC INT output cpu %d irq %d",
>                      __func__, idx, dst->raised.next);
>              qemu_irq_raise(dst->irqs[OPENPIC_OUTPUT_INT]);
>          }
> @@ -1168,11 +1168,11 @@ static void openpic_cpu_write_internal(void *opaq=
ue, hwaddr addr,
>          /* Read-only register */
>          break;
>      case 0xB0: /* EOI */
> -        DPRINTF("EOI\n");
> +        DPRINTF("EOI");
>          s_IRQ =3D IRQ_get_next(opp, &dst->servicing);
> =20
>          if (s_IRQ < 0) {
> -            DPRINTF("%s: EOI with no interrupt in service\n", __func__);
> +            DPRINTF("%s: EOI with no interrupt in service", __func__);
>              break;
>          }
> =20
> @@ -1185,7 +1185,7 @@ static void openpic_cpu_write_internal(void *opaque=
, hwaddr addr,
>          if (n_IRQ !=3D -1 &&
>              (s_IRQ =3D=3D -1 ||
>               IVPR_PRIORITY(src->ivpr) > dst->servicing.priority)) {
> -            DPRINTF("Raise OpenPIC INT output cpu %d irq %d\n",
> +            DPRINTF("Raise OpenPIC INT output cpu %d irq %d",
>                      idx, n_IRQ);
>              qemu_irq_raise(opp->dst[idx].irqs[OPENPIC_OUTPUT_INT]);
>          }
> @@ -1207,11 +1207,11 @@ static uint32_t openpic_iack(OpenPICState *opp, I=
RQDest *dst, int cpu)
>      IRQSource *src;
>      int retval, irq;
> =20
> -    DPRINTF("Lower OpenPIC INT output\n");
> +    DPRINTF("Lower OpenPIC INT output");
>      qemu_irq_lower(dst->irqs[OPENPIC_OUTPUT_INT]);
> =20
>      irq =3D IRQ_get_next(opp, &dst->raised);
> -    DPRINTF("IACK: irq=3D%d\n", irq);
> +    DPRINTF("IACK: irq=3D%d", irq);
> =20
>      if (irq =3D=3D -1) {
>          /* No more interrupt pending */
> @@ -1221,7 +1221,7 @@ static uint32_t openpic_iack(OpenPICState *opp, IRQ=
Dest *dst, int cpu)
>      src =3D &opp->src[irq];
>      if (!(src->ivpr & IVPR_ACTIVITY_MASK) ||
>              !(IVPR_PRIORITY(src->ivpr) > dst->ctpr)) {
> -        fprintf(stderr, "%s: bad raised IRQ %d ctpr %d ivpr 0x%08x\n",
> +        error_report("%s: bad raised IRQ %d ctpr %d ivpr 0x%08x",
>                  __func__, irq, dst->ctpr, src->ivpr);
>          openpic_update_irq(opp, irq);
>          retval =3D opp->spve;
> @@ -1241,7 +1241,7 @@ static uint32_t openpic_iack(OpenPICState *opp, IRQ=
Dest *dst, int cpu)
>      /* Timers and IPIs support multicast. */
>      if (((irq >=3D opp->irq_ipi0) && (irq < (opp->irq_ipi0 + OPENPIC_MAX=
_IPI))) ||
>          ((irq >=3D opp->irq_tim0) && (irq < (opp->irq_tim0 + OPENPIC_MAX=
_TMR)))) {
> -        DPRINTF("irq is IPI or TMR\n");
> +        DPRINTF("irq is IPI or TMR");
>          src->destmask &=3D ~(1 << cpu);
>          if (src->destmask && !src->level) {
>              /* trigger on CPUs that didn't know about it yet */
> @@ -1262,7 +1262,7 @@ static uint32_t openpic_cpu_read_internal(void *opa=
que, hwaddr addr,
>      IRQDest *dst;
>      uint32_t retval;
> =20
> -    DPRINTF("%s: cpu %d addr %#" HWADDR_PRIx "\n", __func__, idx, addr);
> +    DPRINTF("%s: cpu %d addr %#" HWADDR_PRIx, __func__, idx, addr);
>      retval =3D 0xFFFFFFFF;
> =20
>      if (idx < 0 || idx >=3D opp->nb_cpus) {
> @@ -1290,7 +1290,7 @@ static uint32_t openpic_cpu_read_internal(void *opa=
que, hwaddr addr,
>      default:
>          break;
>      }
> -    DPRINTF("%s: =3D> 0x%08x\n", __func__, retval);
> +    DPRINTF("%s: =3D> 0x%08x", __func__, retval);
> =20
>      return retval;
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--xB0nW4MQa6jZONgY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlobuiMACgkQbDjKyiDZ
s5K38RAA2oRpZNqgALyKb2LEhPELZ0JBNUv4n9YLyM6qtpCRlq8n+kQ6u+DxNrgX
92nxiUeTJaL47LTn9fMS1yJrqoZX4VL1xFMeswiboUu82oPmKdksaiwnY/Gon7xi
lG3XR/UF71umUHwaYyfkalmShsHynV2WgTidlf+aDBLQA0fFtcpv2WkmLU3txTlP
pgLXapy4EtFgS3ctHoJ6ZvLVfqslcT72qmF4TjSLIFIS8ndTsYEuss7LJMZxLQLH
sLl/Lv8K8RQ4EfRE/AY7zSZ8n/RrBrLWgYVMZFl9tUiXvID13Fpq87Z2q90csuL8
xK8I1YoWJP+SJMrI0dxclohDc4aTArrbuKQwLOLglPWlNllf9mfFmEGZukRoYQpm
iKyxKkdzqyO3IMofcuDyy7Uaw83zpd796DV8AkbK44mRqeqAuLkVydAHojf6nnZa
nPgBPYvuosdXdyc6wBplg9SFvquZILK0ye13zLHU4MHgz/Qi/6yxFDnJdYqbBXH3
JnznYkmkEvZtubjiC9CZviIaPZE/BnU6bQUbfTa9PDjM3Y3nT3UyjkYN5WT66fLD
DjyrOygJZ0RhrySk3gWMMuGRnSIPbsFm8fzoYcxp3Ry5V4CbWU1KVvSKfAtVQ2rc
6FAN7prTYIqKZZFOffFTb17qUiY4rkLE6JZSgdu3HhsX2TzDFGE=
=YnkK
-----END PGP SIGNATURE-----

--xB0nW4MQa6jZONgY--
