Received: from eggs.gnu.org ([208.118.235.92]:53683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eogiL-000310-AP
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 21:35:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eoghH-0002ss-62
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 21:34:29 -0500
Date: Thu, 22 Feb 2018 13:12:54 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180222021254.GB2164@umbus.fritz.box>
References: <20180219181922.21586-1-mark.cave-ayland@ilande.co.uk>
	<20180219181922.21586-9-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CdrF4e02JqNVZeln"
Content-Disposition: inline
In-Reply-To: <20180219181922.21586-9-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 08/11] openpic: move OpenPIC state and
 related definitions to openpic.h
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


--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2018 at 06:19:19PM +0000, Mark Cave-Ayland wrote:
> This is to faciliate access to OpenPICState when wiring up the PIC to the=
 macio
> controller.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/intc/openpic.c        | 157 -----------------------------------------=
-----
>  include/hw/ppc/openpic.h | 160 +++++++++++++++++++++++++++++++++++++++++=
+++++-
>  2 files changed, 159 insertions(+), 158 deletions(-)
>=20
> diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
> index 9159a06f07..811cee9b26 100644
> --- a/hw/intc/openpic.c
> +++ b/hw/intc/openpic.c
> @@ -63,10 +63,6 @@ static int get_current_cpu(void);
>          } \
>      } while (0)
> =20
> -#define MAX_CPU     32
> -#define MAX_MSI     8
> -#define VID         0x03 /* MPIC version ID */
> -
>  /* OpenPIC capability flags */
>  #define OPENPIC_FLAG_IDR_CRIT     (1 << 0)
>  #define OPENPIC_FLAG_ILR          (2 << 0)
> @@ -85,35 +81,6 @@ static int get_current_cpu(void);
>  #define OPENPIC_CPU_REG_START        0x20000
>  #define OPENPIC_CPU_REG_SIZE         0x100 + ((MAX_CPU - 1) * 0x1000)
> =20
> -/* Raven */
> -#define RAVEN_MAX_CPU      2
> -#define RAVEN_MAX_EXT     48
> -#define RAVEN_MAX_IRQ     64
> -#define RAVEN_MAX_TMR      OPENPIC_MAX_TMR
> -#define RAVEN_MAX_IPI      OPENPIC_MAX_IPI
> -
> -/* KeyLargo */
> -#define KEYLARGO_MAX_CPU  4
> -#define KEYLARGO_MAX_EXT  64
> -#define KEYLARGO_MAX_IPI  4
> -#define KEYLARGO_MAX_IRQ  (64 + KEYLARGO_MAX_IPI)
> -#define KEYLARGO_MAX_TMR  0
> -#define KEYLARGO_IPI_IRQ  (KEYLARGO_MAX_EXT) /* First IPI IRQ */
> -/* Timers don't exist but this makes the code happy... */
> -#define KEYLARGO_TMR_IRQ  (KEYLARGO_IPI_IRQ + KEYLARGO_MAX_IPI)
> -
> -/* Interrupt definitions */
> -#define RAVEN_FE_IRQ     (RAVEN_MAX_EXT)     /* Internal functional IRQ =
*/
> -#define RAVEN_ERR_IRQ    (RAVEN_MAX_EXT + 1) /* Error IRQ */
> -#define RAVEN_TMR_IRQ    (RAVEN_MAX_EXT + 2) /* First timer IRQ */
> -#define RAVEN_IPI_IRQ    (RAVEN_TMR_IRQ + RAVEN_MAX_TMR) /* First IPI IR=
Q */
> -/* First doorbell IRQ */
> -#define RAVEN_DBL_IRQ    (RAVEN_IPI_IRQ + (RAVEN_MAX_CPU * RAVEN_MAX_IPI=
))
> -
> -typedef struct FslMpicInfo {
> -    int max_ext;
> -} FslMpicInfo;
> -
>  static FslMpicInfo fsl_mpic_20 =3D {
>      .max_ext =3D 12,
>  };
> @@ -211,55 +178,6 @@ static void openpic_cpu_write_internal(void *opaque,=
 hwaddr addr,
>                                         uint32_t val, int idx);
>  static void openpic_reset(DeviceState *d);
> =20
> -typedef enum IRQType {
> -    IRQ_TYPE_NORMAL =3D 0,
> -    IRQ_TYPE_FSLINT,        /* FSL internal interrupt -- level only */
> -    IRQ_TYPE_FSLSPECIAL,    /* FSL timer/IPI interrupt, edge, no polarit=
y */
> -} IRQType;
> -
> -/* Round up to the nearest 64 IRQs so that the queue length
> - * won't change when moving between 32 and 64 bit hosts.
> - */
> -#define IRQQUEUE_SIZE_BITS ((OPENPIC_MAX_IRQ + 63) & ~63)
> -
> -typedef struct IRQQueue {
> -    unsigned long *queue;
> -    int32_t queue_size; /* Only used for VMSTATE_BITMAP */
> -    int next;
> -    int priority;
> -} IRQQueue;
> -
> -typedef struct IRQSource {
> -    uint32_t ivpr;  /* IRQ vector/priority register */
> -    uint32_t idr;   /* IRQ destination register */
> -    uint32_t destmask; /* bitmap of CPU destinations */
> -    int last_cpu;
> -    int output;     /* IRQ level, e.g. OPENPIC_OUTPUT_INT */
> -    int pending;    /* TRUE if IRQ is pending */
> -    IRQType type;
> -    bool level:1;   /* level-triggered */
> -    bool nomask:1;  /* critical interrupts ignore mask on some FSL MPICs=
 */
> -} IRQSource;
> -
> -#define IVPR_MASK_SHIFT       31
> -#define IVPR_MASK_MASK        (1U << IVPR_MASK_SHIFT)
> -#define IVPR_ACTIVITY_SHIFT   30
> -#define IVPR_ACTIVITY_MASK    (1U << IVPR_ACTIVITY_SHIFT)
> -#define IVPR_MODE_SHIFT       29
> -#define IVPR_MODE_MASK        (1U << IVPR_MODE_SHIFT)
> -#define IVPR_POLARITY_SHIFT   23
> -#define IVPR_POLARITY_MASK    (1U << IVPR_POLARITY_SHIFT)
> -#define IVPR_SENSE_SHIFT      22
> -#define IVPR_SENSE_MASK       (1U << IVPR_SENSE_SHIFT)
> -
> -#define IVPR_PRIORITY_MASK     (0xFU << 16)
> -#define IVPR_PRIORITY(_ivprr_) ((int)(((_ivprr_) & IVPR_PRIORITY_MASK) >=
> 16))
> -#define IVPR_VECTOR(opp, _ivprr_) ((_ivprr_) & (opp)->vector_mask)
> -
> -/* IDR[EP/CI] are only for FSL MPIC prior to v4.0 */
> -#define IDR_EP      0x80000000  /* external pin */
> -#define IDR_CI      0x40000000  /* critical interrupt */
> -
>  /* Convert between openpic clock ticks and nanosecs.  In the hardware th=
e clock
>     frequency is driven by board inputs to the PIC which the PIC would th=
en
>     divide by 4 or 8.  For now hard code to 25MZ.
> @@ -275,81 +193,6 @@ static inline uint64_t ticks_to_ns(uint64_t ticks)
>      return ticks * OPENPIC_TIMER_NS_PER_TICK;
>  }
> =20
> -typedef struct OpenPICTimer {
> -    uint32_t tccr;  /* Global timer current count register */
> -    uint32_t tbcr;  /* Global timer base count register */
> -    int                   n_IRQ;
> -    bool                  qemu_timer_active; /* Is the qemu_timer is run=
ning? */
> -    struct QEMUTimer     *qemu_timer;
> -    struct OpenPICState  *opp;          /* Device timer is part of. */
> -    /* The QEMU_CLOCK_VIRTUAL time (in ns) corresponding to the last
> -       current_count written or read, only defined if qemu_timer_active.=
 */
> -    uint64_t              origin_time;
> -} OpenPICTimer;
> -
> -typedef struct OpenPICMSI {
> -    uint32_t msir;   /* Shared Message Signaled Interrupt Register */
> -} OpenPICMSI;
> -
> -typedef struct IRQDest {
> -    int32_t ctpr; /* CPU current task priority */
> -    IRQQueue raised;
> -    IRQQueue servicing;
> -    qemu_irq *irqs;
> -
> -    /* Count of IRQ sources asserting on non-INT outputs */
> -    uint32_t outputs_active[OPENPIC_OUTPUT_NB];
> -} IRQDest;
> -
> -#define OPENPIC(obj) OBJECT_CHECK(OpenPICState, (obj), TYPE_OPENPIC)
> -
> -typedef struct OpenPICState {
> -    /*< private >*/
> -    SysBusDevice parent_obj;
> -    /*< public >*/
> -
> -    MemoryRegion mem;
> -
> -    /* Behavior control */
> -    FslMpicInfo *fsl;
> -    uint32_t model;
> -    uint32_t flags;
> -    uint32_t nb_irqs;
> -    uint32_t vid;
> -    uint32_t vir; /* Vendor identification register */
> -    uint32_t vector_mask;
> -    uint32_t tfrr_reset;
> -    uint32_t ivpr_reset;
> -    uint32_t idr_reset;
> -    uint32_t brr1;
> -    uint32_t mpic_mode_mask;
> -
> -    /* Sub-regions */
> -    MemoryRegion sub_io_mem[6];
> -
> -    /* Global registers */
> -    uint32_t frr; /* Feature reporting register */
> -    uint32_t gcr; /* Global configuration register  */
> -    uint32_t pir; /* Processor initialization register */
> -    uint32_t spve; /* Spurious vector register */
> -    uint32_t tfrr; /* Timer frequency reporting register */
> -    /* Source registers */
> -    IRQSource src[OPENPIC_MAX_IRQ];
> -    /* Local registers per output pin */
> -    IRQDest dst[MAX_CPU];
> -    uint32_t nb_cpus;
> -    /* Timer registers */
> -    OpenPICTimer timers[OPENPIC_MAX_TMR];
> -    uint32_t max_tmr;
> -
> -    /* Shared MSI registers */
> -    OpenPICMSI msi[MAX_MSI];
> -    uint32_t max_irq;
> -    uint32_t irq_ipi0;
> -    uint32_t irq_tim0;
> -    uint32_t irq_msi;
> -} OpenPICState;
> -
>  static inline void IRQ_setbit(IRQQueue *q, int n_IRQ)
>  {
>      set_bit(n_IRQ, q->queue);
> diff --git a/include/hw/ppc/openpic.h b/include/hw/ppc/openpic.h
> index e55ce546aa..366a98794e 100644
> --- a/include/hw/ppc/openpic.h
> +++ b/include/hw/ppc/openpic.h
> @@ -2,10 +2,13 @@
>  #define OPENPIC_H
> =20
>  #include "qemu-common.h"
> +#include "hw/sysbus.h"
>  #include "hw/qdev-core.h"
>  #include "qom/cpu.h"
> =20
> -#define TYPE_OPENPIC "openpic"
> +#define MAX_CPU     32
> +#define MAX_MSI     8
> +#define VID         0x03 /* MPIC version ID */
> =20
>  /* OpenPIC have 5 outputs per CPU connected and one IRQ out single outpu=
t */
>  enum {
> @@ -28,6 +31,161 @@ enum {
>  #define OPENPIC_MAX_IRQ     (OPENPIC_MAX_SRC + OPENPIC_MAX_IPI + \
>                               OPENPIC_MAX_TMR)
> =20
> +/* Raven */
> +#define RAVEN_MAX_CPU      2
> +#define RAVEN_MAX_EXT     48
> +#define RAVEN_MAX_IRQ     64
> +#define RAVEN_MAX_TMR      OPENPIC_MAX_TMR
> +#define RAVEN_MAX_IPI      OPENPIC_MAX_IPI
> +
> +/* KeyLargo */
> +#define KEYLARGO_MAX_CPU  4
> +#define KEYLARGO_MAX_EXT  64
> +#define KEYLARGO_MAX_IPI  4
> +#define KEYLARGO_MAX_IRQ  (64 + KEYLARGO_MAX_IPI)
> +#define KEYLARGO_MAX_TMR  0
> +#define KEYLARGO_IPI_IRQ  (KEYLARGO_MAX_EXT) /* First IPI IRQ */
> +/* Timers don't exist but this makes the code happy... */
> +#define KEYLARGO_TMR_IRQ  (KEYLARGO_IPI_IRQ + KEYLARGO_MAX_IPI)
> +
> +/* Interrupt definitions */
> +#define RAVEN_FE_IRQ     (RAVEN_MAX_EXT)     /* Internal functional IRQ =
*/
> +#define RAVEN_ERR_IRQ    (RAVEN_MAX_EXT + 1) /* Error IRQ */
> +#define RAVEN_TMR_IRQ    (RAVEN_MAX_EXT + 2) /* First timer IRQ */
> +#define RAVEN_IPI_IRQ    (RAVEN_TMR_IRQ + RAVEN_MAX_TMR) /* First IPI IR=
Q */
> +/* First doorbell IRQ */
> +#define RAVEN_DBL_IRQ    (RAVEN_IPI_IRQ + (RAVEN_MAX_CPU * RAVEN_MAX_IPI=
))
> +
> +typedef struct FslMpicInfo {
> +    int max_ext;
> +} FslMpicInfo;
> +
> +typedef enum IRQType {
> +    IRQ_TYPE_NORMAL =3D 0,
> +    IRQ_TYPE_FSLINT,        /* FSL internal interrupt -- level only */
> +    IRQ_TYPE_FSLSPECIAL,    /* FSL timer/IPI interrupt, edge, no polarit=
y */
> +} IRQType;
> +
> +/* Round up to the nearest 64 IRQs so that the queue length
> + * won't change when moving between 32 and 64 bit hosts.
> + */
> +#define IRQQUEUE_SIZE_BITS ((OPENPIC_MAX_IRQ + 63) & ~63)
> +
> +typedef struct IRQQueue {
> +    unsigned long *queue;
> +    int32_t queue_size; /* Only used for VMSTATE_BITMAP */
> +    int next;
> +    int priority;
> +} IRQQueue;
> +
> +typedef struct IRQSource {
> +    uint32_t ivpr;  /* IRQ vector/priority register */
> +    uint32_t idr;   /* IRQ destination register */
> +    uint32_t destmask; /* bitmap of CPU destinations */
> +    int last_cpu;
> +    int output;     /* IRQ level, e.g. OPENPIC_OUTPUT_INT */
> +    int pending;    /* TRUE if IRQ is pending */
> +    IRQType type;
> +    bool level:1;   /* level-triggered */
> +    bool nomask:1;  /* critical interrupts ignore mask on some FSL MPICs=
 */
> +} IRQSource;
> +
> +#define IVPR_MASK_SHIFT       31
> +#define IVPR_MASK_MASK        (1U << IVPR_MASK_SHIFT)
> +#define IVPR_ACTIVITY_SHIFT   30
> +#define IVPR_ACTIVITY_MASK    (1U << IVPR_ACTIVITY_SHIFT)
> +#define IVPR_MODE_SHIFT       29
> +#define IVPR_MODE_MASK        (1U << IVPR_MODE_SHIFT)
> +#define IVPR_POLARITY_SHIFT   23
> +#define IVPR_POLARITY_MASK    (1U << IVPR_POLARITY_SHIFT)
> +#define IVPR_SENSE_SHIFT      22
> +#define IVPR_SENSE_MASK       (1U << IVPR_SENSE_SHIFT)
> +
> +#define IVPR_PRIORITY_MASK     (0xFU << 16)
> +#define IVPR_PRIORITY(_ivprr_) ((int)(((_ivprr_) & IVPR_PRIORITY_MASK) >=
> 16))
> +#define IVPR_VECTOR(opp, _ivprr_) ((_ivprr_) & (opp)->vector_mask)
> +
> +/* IDR[EP/CI] are only for FSL MPIC prior to v4.0 */
> +#define IDR_EP      0x80000000  /* external pin */
> +#define IDR_CI      0x40000000  /* critical interrupt */
> +
> +typedef struct OpenPICTimer {
> +    uint32_t tccr;  /* Global timer current count register */
> +    uint32_t tbcr;  /* Global timer base count register */
> +    int                   n_IRQ;
> +    bool                  qemu_timer_active; /* Is the qemu_timer is run=
ning? */
> +    struct QEMUTimer     *qemu_timer;
> +    struct OpenPICState  *opp;          /* Device timer is part of. */
> +    /* The QEMU_CLOCK_VIRTUAL time (in ns) corresponding to the last
> +       current_count written or read, only defined if qemu_timer_active.=
 */
> +    uint64_t              origin_time;
> +} OpenPICTimer;
> +
> +typedef struct OpenPICMSI {
> +    uint32_t msir;   /* Shared Message Signaled Interrupt Register */
> +} OpenPICMSI;
> +
> +typedef struct IRQDest {
> +    int32_t ctpr; /* CPU current task priority */
> +    IRQQueue raised;
> +    IRQQueue servicing;
> +    qemu_irq *irqs;
> +
> +    /* Count of IRQ sources asserting on non-INT outputs */
> +    uint32_t outputs_active[OPENPIC_OUTPUT_NB];
> +} IRQDest;
> +
> +#define TYPE_OPENPIC "openpic"
> +#define OPENPIC(obj) OBJECT_CHECK(OpenPICState, (obj), TYPE_OPENPIC)
> +
> +typedef struct OpenPICState {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +    /*< public >*/
> +
> +    MemoryRegion mem;
> +
> +    /* Behavior control */
> +    FslMpicInfo *fsl;
> +    uint32_t model;
> +    uint32_t flags;
> +    uint32_t nb_irqs;
> +    uint32_t vid;
> +    uint32_t vir; /* Vendor identification register */
> +    uint32_t vector_mask;
> +    uint32_t tfrr_reset;
> +    uint32_t ivpr_reset;
> +    uint32_t idr_reset;
> +    uint32_t brr1;
> +    uint32_t mpic_mode_mask;
> +
> +    /* Sub-regions */
> +    MemoryRegion sub_io_mem[6];
> +
> +    /* Global registers */
> +    uint32_t frr; /* Feature reporting register */
> +    uint32_t gcr; /* Global configuration register  */
> +    uint32_t pir; /* Processor initialization register */
> +    uint32_t spve; /* Spurious vector register */
> +    uint32_t tfrr; /* Timer frequency reporting register */
> +    /* Source registers */
> +    IRQSource src[OPENPIC_MAX_IRQ];
> +    /* Local registers per output pin */
> +    IRQDest dst[MAX_CPU];
> +    uint32_t nb_cpus;
> +    /* Timer registers */
> +    OpenPICTimer timers[OPENPIC_MAX_TMR];
> +    uint32_t max_tmr;
> +
> +    /* Shared MSI registers */
> +    OpenPICMSI msi[MAX_MSI];
> +    uint32_t max_irq;
> +    uint32_t irq_ipi0;
> +    uint32_t irq_tim0;
> +    uint32_t irq_msi;
> +} OpenPICState;
> +
> +
>  #define TYPE_KVM_OPENPIC "kvm-openpic"
>  int kvm_openpic_connect_vcpu(DeviceState *d, CPUState *cs);
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqOJyYACgkQbDjKyiDZ
s5INDhAA5TfB+fJcYGv/iLgXI07ygc23zCsth4gLJHwu8nTgJw7aQ88ScXhGRVsd
GFs3d2JdqI+9DH0u2vWOhScxQSBnAhjTl1JUoKP7O1s4mQDbL/atZhne+TmfQjj6
+FIBZFCdSDAD8PPv/4oJjGaGXkfJgSAEg7Knm/lsKD2BMbYq0Kz3UCCMfioX/ncv
vWbLNqMsBg/C9lSVnKD8kiMCtxH7c04fiPnI8xwIs5y4wHaqNGqcU++ZdxegsWv3
u9s/8dFQeC3a7kS7zarw0SA6h6D9PWggaB6/9YCDW4Q2Ac2agx7VO/7h4sm3HgSV
Tp5R36wfxic4AqPt5DqAa8/YJHeWxxFWK1L9hPPvXVB65Gv6xxk+wwMS+RfLl6cN
iBOfSAk6fI2sgcKDvuobVKcgUEa5/1+gCCS2cGHlRsjfZQSFdbxkP8wlUAo+fpgP
RvMudPkBy6Mmcuc12z/PU2HSX6gK1yUJSD7e6fGr7On3LKWfUYNjIang8vslW9sA
1JnslTJXp9GKz94W1QXzhg1amiHrysV6XxE2vEekhKoe/qNyjpkbq+fkD4DDMUyj
nY+DoFqLeTepuOyxPXDRTB6v2m3XkeutM8VKw0buYLqmAbvEO9G4Q5QFZxRxkgre
8QM8e6/JVaLnfkkR6MKE6/8SkbQsMoBaNLTJ7pF6HcEXB5AOf9c=
=fZiv
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--
