Received: from eggs.gnu.org ([2001:4830:134:3::10]:58286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d3Evn-00083x-8h
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 00:52:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d3Evk-00067V-01
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 00:51:59 -0400
Date: Wed, 26 Apr 2017 14:34:41 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170426043441.GN16882@umbus.fritz.box>
References: <201704212158.v3LLwNYl031738@linux03a.ddci.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MSd2ShuMixI0uVaZ"
Content-Disposition: inline
In-Reply-To: <201704212158.v3LLwNYl031738@linux03a.ddci.com>
Subject: Re: [Qemu-devel] Subject: [PATCH] target-ppc: Add global timer
 group A to open-pic.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Larson <alarson@ddci.com>
Cc: agraf@suse.de, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--MSd2ShuMixI0uVaZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 21, 2017 at 02:58:23PM -0700, Aaron Larson wrote:
> Add global timer group A to open-pic.  This patch is still somewhat
> dubious because I'm not sure how to determine what QEMU wants for the
> timer frequency.  Suggestions solicited.
>=20
> Signed-off-by: Aaron Larson <alarson@ddci.com>
> ---
>  hw/intc/openpic.c | 134 ++++++++++++++++++++++++++++++++++++++++++++++--=
------
>  1 file changed, 116 insertions(+), 18 deletions(-)
>=20
> diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
> index 4349e45..769a31a 100644
> --- a/hw/intc/openpic.c
> +++ b/hw/intc/openpic.c
> @@ -45,6 +45,7 @@
>  #include "qemu/bitops.h"
>  #include "qapi/qmp/qerror.h"
>  #include "qemu/log.h"
> +#include "qemu/timer.h"
> =20
>  //#define DEBUG_OPENPIC
> =20
> @@ -54,8 +55,10 @@ static const int debug_openpic =3D 1;
>  static const int debug_openpic =3D 0;
>  #endif
> =20
> +static int get_current_cpu(void);
>  #define DPRINTF(fmt, ...) do { \
>          if (debug_openpic) { \
> +            printf("Core%d: ", get_current_cpu()); \
>              printf(fmt , ## __VA_ARGS__); \
>          } \
>      } while (0)
> @@ -246,9 +249,24 @@ typedef struct IRQSource {
>  #define IDR_EP      0x80000000  /* external pin */
>  #define IDR_CI      0x40000000  /* critical interrupt */
> =20
> +/* Conversion between ticks and nanosecs: TODO: need better way for this.
> + Assume a 100mhz clock, divided by 8, or 25mhz
> + 25,000,000 ticks/sec, 25,000/ms, 25/us, 1 tick/40ns
> +*/

I'm not sure what you mean by "ticks" here.  Ticks of the openpic
clock itself?  Or something internal to qemu?

> +#define CONV_FACTOR 40LL
> +static inline uint64_t ns_to_ticks(uint64_t ns)   { return ns   / CONV_F=
ACTOR; }
> +static inline uint64_t ticks_to_ns(uint64_t tick) { return tick * CONV_F=
ACTOR; }
> +
>  typedef struct OpenPICTimer {
>      uint32_t tccr;  /* Global timer current count register */
>      uint32_t tbcr;  /* Global timer base count register */
> +    int                   n_IRQ;
> +    bool                  qemu_timer_active; /* Is the qemu_timer is run=
ning? */
> +    struct QEMUTimer     *qemu_timer;   /* May be 0 if not created. */

s/0/NULL/

> +    struct OpenPICState  *opp;          /* device timer is part of. */
> +    /* the time corresponding to the last current_count written or read,
> +       only defined if qemu_timer_active. */
> +    uint64_t              originTime;

time by what measure?

>  } OpenPICTimer;
> =20
>  typedef struct OpenPICMSI {
> @@ -795,37 +813,102 @@ static uint64_t openpic_gbl_read(void *opaque, hwa=
ddr addr, unsigned len)
>      return retval;
>  }
> =20
> +static void openpic_tmr_set_tmr(OpenPICTimer *tmr, uint32_t val, bool en=
abled);
> +
> +static void qemu_timer_cb(void *opaque)
> +{
> +    OpenPICTimer *tmr =3D opaque;
> +    OpenPICState *opp =3D tmr->opp;
> +    uint32_t      n_IRQ =3D tmr->n_IRQ;
> +    uint32_t val =3D   tmr->tbcr & ~TBCR_CI;
> +    uint32_t tog =3D ((tmr->tccr & TCCR_TOG) ^ TCCR_TOG);  /* invert tog=
gle. */
> +
> +    DPRINTF("%s n_IRQ=3D%d\n", __func__, n_IRQ);
> +    /* reload current count from base count and setup timer. */
> +    tmr->tccr =3D val | tog;
> +    openpic_tmr_set_tmr(tmr, val, /*enabled=3D*/true);
> +    /* raise the interrupt. */
> +    opp->src[n_IRQ].destmask =3D read_IRQreg_idr(opp, n_IRQ);
> +    openpic_set_irq(opp, n_IRQ, 1);
> +    openpic_set_irq(opp, n_IRQ, 0);
> +}
> +
> +/* If enabled is true, arranges for an interrupt to be raised val clocks=
 into
> +   the future, if enabled is false cancels the timer. */
> +static void openpic_tmr_set_tmr(OpenPICTimer *tmr, uint32_t val, bool en=
abled)
> +{
> +    /* if timer doesn't exist, create it. */
> +    if (tmr->qemu_timer =3D=3D 0) {

Please use =3D=3D NULL, or just !tmr->qemu_timer

> +        tmr->qemu_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, &qemu_timer=
_cb, tmr);
> +        DPRINTF("Created timer for n_IRQ %d\n", tmr->n_IRQ);
> +    }
> +    uint64_t ns =3D ticks_to_ns(val & ~TCCR_TOG);
> +    /* A count of zero causes a timer to be set to expire immediately.  =
This
> +       effectively stops the simulation so we don't honor that configura=
tion.
> +       On real hardware, this would generate an interrupt on every clock=
 cycle
> +       if the interrupt was unmasked. */
> +    if ((ns =3D=3D 0) || !enabled) {
> +        tmr->qemu_timer_active =3D false;
> +        tmr->tccr =3D tmr->tccr & TCCR_TOG;
> +        timer_del(tmr->qemu_timer); /* set timer to never expire. */
> +    } else {
> +        tmr->qemu_timer_active =3D true;
> +        uint64_t now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +        tmr->originTime =3D now;
> +        timer_mod(tmr->qemu_timer, now + ns);     /* set timer expiratio=
n. */
> +    }
> +}
> +
> +/* Returns the currrent tccr value, i.e., timer value (in clocks) with
> +   appropriate TOG. */
> +static uint64_t openpic_tmr_get_timer(OpenPICTimer *tmr)
> +{
> +    uint64_t retval;
> +    if (!tmr->qemu_timer_active) {
> +        retval =3D tmr->tccr;
> +    } else {
> +        uint64_t now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +        uint64_t used =3D now - tmr->originTime;  /* nsecs */
> +        uint32_t used_ticks =3D (uint32_t)ns_to_ticks(used);
> +        uint32_t count =3D (tmr->tccr & ~TCCR_TOG) - used_ticks;
> +        retval =3D (uint32_t)((tmr->tccr & TCCR_TOG) | (count & ~TCCR_TO=
G));
> +    }
> +    return retval;
> +}
> +
>  static void openpic_tmr_write(void *opaque, hwaddr addr, uint64_t val,
> -                                unsigned len)
> +                              unsigned len)
>  {
>      OpenPICState *opp =3D opaque;
>      int idx;
> =20
> -    addr +=3D 0x10f0;
> -
>      DPRINTF("%s: addr %#" HWADDR_PRIx " <=3D %08" PRIx64 "\n",
> -            __func__, addr, val);
> +            __func__, (addr + 0x10f0), val);
>      if (addr & 0xF) {
>          return;
>      }
> =20
> -    if (addr =3D=3D 0x10f0) {
> +    if (addr =3D=3D 0) {
>          /* TFRR */
>          opp->tfrr =3D val;
>          return;
>      }
> -
> +    addr -=3D 0x10;  /* correct for TFRR */
>      idx =3D (addr >> 6) & 0x3;
> -    addr =3D addr & 0x30;
> =20
>      switch (addr & 0x30) {
>      case 0x00: /* TCCR */
>          break;
>      case 0x10: /* TBCR */
> -        if ((opp->timers[idx].tccr & TCCR_TOG) !=3D 0 &&
> -            (val & TBCR_CI) =3D=3D 0 &&
> -            (opp->timers[idx].tbcr & TBCR_CI) !=3D 0) {
> -            opp->timers[idx].tccr &=3D ~TCCR_TOG;
> +        /* Did the enable status change? */
> +        if ((opp->timers[idx].tbcr & TBCR_CI) !=3D (val & TBCR_CI)) {
> +            /* Did "Count Inhibit" transition from 1 to 0? */
> +            if ((val & TBCR_CI) =3D=3D 0) {
> +                opp->timers[idx].tccr =3D val & ~TCCR_TOG;
> +            }
> +            openpic_tmr_set_tmr(&opp->timers[idx],
> +                                (val & ~TBCR_CI),
> +                                /*enabled=3D*/((val & TBCR_CI) =3D=3D 0)=
);
>          }
>          opp->timers[idx].tbcr =3D val;
>          break;
> @@ -844,27 +927,28 @@ static uint64_t openpic_tmr_read(void *opaque, hwad=
dr addr, unsigned len)
>      uint32_t retval =3D -1;
>      int idx;
> =20
> -    DPRINTF("%s: addr %#" HWADDR_PRIx "\n", __func__, addr);
> +    DPRINTF("%s: addr %#" HWADDR_PRIx "\n", __func__, addr + 0x10f0);
>      if (addr & 0xF) {
>          goto out;
>      }
> -    idx =3D (addr >> 6) & 0x3;
> -    if (addr =3D=3D 0x0) {
> +    if (addr =3D=3D 0) {
>          /* TFRR */
>          retval =3D opp->tfrr;
>          goto out;
>      }
> +    addr -=3D 0x10;  /* correct for TFRR */
> +    idx =3D (addr >> 6) & 0x3;
>      switch (addr & 0x30) {
>      case 0x00: /* TCCR */
> -        retval =3D opp->timers[idx].tccr;
> +        retval =3D openpic_tmr_get_timer(&opp->timers[idx]);
>          break;
>      case 0x10: /* TBCR */
>          retval =3D opp->timers[idx].tbcr;
>          break;
> -    case 0x20: /* TIPV */
> +    case 0x20: /* TVPR */
>          retval =3D read_IRQreg_ivpr(opp, opp->irq_tim0 + idx);
>          break;
> -    case 0x30: /* TIDE (TIDR) */
> +    case 0x30: /* TDR */
>          retval =3D read_IRQreg_idr(opp, opp->irq_tim0 + idx);
>          break;
>      }
> @@ -1138,7 +1222,10 @@ static uint32_t openpic_iack(OpenPICState *opp, IR=
QDest *dst, int cpu)
>          IRQ_resetbit(&dst->raised, irq);
>      }
> =20
> -    if ((irq >=3D opp->irq_ipi0) &&  (irq < (opp->irq_ipi0 + OPENPIC_MAX=
_IPI))) {
> +    /* Timers and IPIs support multicast. */
> +    if (((irq >=3D opp->irq_ipi0) && (irq < (opp->irq_ipi0 + OPENPIC_MAX=
_IPI))) ||
> +        ((irq >=3D opp->irq_tim0) && (irq < (opp->irq_tim0 + OPENPIC_MAX=
_TMR)))) {
> +        DPRINTF("irq is IPI or TMR\n");
>          src->destmask &=3D ~(1 << cpu);
>          if (src->destmask && !src->level) {
>              /* trigger on CPUs that didn't know about it yet */
> @@ -1343,6 +1430,10 @@ static void openpic_reset(DeviceState *d)
>      for (i =3D 0; i < OPENPIC_MAX_TMR; i++) {
>          opp->timers[i].tccr =3D 0;
>          opp->timers[i].tbcr =3D TBCR_CI;
> +        if (opp->timers[i].qemu_timer_active) {
> +            timer_del(opp->timers[i].qemu_timer);  /* Inhibit timer */
> +            opp->timers[i].qemu_timer_active =3D 0;
> +        }
>      }
>      /* Go out of RESET state */
>      opp->gcr =3D 0;
> @@ -1393,6 +1484,13 @@ static void fsl_common_init(OpenPICState *opp)
>          opp->src[i].type =3D IRQ_TYPE_FSLSPECIAL;
>          opp->src[i].level =3D false;
>      }
> +
> +    for (i =3D 0; i < OPENPIC_MAX_TMR; i++) {
> +        opp->timers[i].n_IRQ =3D opp->irq_tim0 + i;
> +        opp->timers[i].qemu_timer_active =3D 0;
> +        opp->timers[i].qemu_timer =3D 0;
> +        opp->timers[i].opp =3D opp;
> +    }
>  }
> =20
>  static void map_list(OpenPICState *opp, const MemReg *list, int *count)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--MSd2ShuMixI0uVaZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZACNhAAoJEGw4ysog2bOSh4EP/1wX4Ztz+jPjKAKTpd9SwPBV
8yRe02mZ3dhiVwkCgC6vbIKw7vE7pxo/1Rdyivp6stI1AFJBp/txFdiYLEcXJBDn
/2qcer3UZjHAq8GyfqmfTQY0Dn4q/d0X2fVWHKRRyjvRY4fATEIze9zVRuH64TMt
qbZC18FORyHzA5Y0NpSdZqQjxoF/c+e7K/G2d1hWrqdg4Ayv6QLYrufSonVi2mwn
V3h3Q8/zq1tUQNVvKMZh0nSHrcJhPjM1fsidTnXo526bIaYvDmruaCrJEfH0Qys1
TuoCYQjb5yCjmJx0NBAgrVLoHAyTa9NlaqIMThdBhp4HiERwDAud157h5hbKSpt6
2opagsrNsRAaP/18a5OIQBNhNVJhHrAOXW2pVJMl+lR9VAB819Jc2Pom+UFUxmEV
H+27aeNg3Vsd2+T6FHSOcGAc4SWEBGT3N8fp0GJzP6f0Dw26a7EIitRmI3l8gx5P
ZjJOPW2bCaudpQ/luQIsXYT/kml2Nr4aPCGwtWqnBbsv+nUspt1jSOYNRitPv2uv
pe1/3kwdT3b69M0VFhEwtKMWR0FcstTMXm7VV1U8WQVPO+8NAwV00CWgGYprwVVK
6j4ADfgOHk9UxTA/Z4d/Ox3EBB3fFPEDDURjts0RLYp3vuoQPUSXqnFirtwAlDSU
S8BI8mvZQ8mkfVuIIYsJ
=nHl2
-----END PGP SIGNATURE-----

--MSd2ShuMixI0uVaZ--
