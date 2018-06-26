Received: from eggs.gnu.org ([2001:4830:134:3::10]:37361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fXk6r-0002F3-GO
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 05:18:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fXk6m-0008FH-Cg
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 05:18:01 -0400
References: <20180619093124.24011-1-luc.michel@greensocs.com>
	<20180619093124.24011-6-luc.michel@greensocs.com>
	<CAFEAcA8rKk+G_PYr4t5L=0zy3Hv-wB_7Wbe9zn+H_ZE9bLLn=A@mail.gmail.com>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <40f915c1-6f91-1b0c-3cc7-8a4e5ca77f5b@greensocs.com>
Date: Tue, 26 Jun 2018 11:17:25 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8rKk+G_PYr4t5L=0zy3Hv-wB_7Wbe9zn+H_ZE9bLLn=A@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lCf6B6Q27VTimfdKtlJ7mbzfu7j8js2KV"
Subject: Re: [Qemu-devel] [PATCH v2 5/7] intc/arm_gic: Add virtualization
 extensions logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>, Mark Burton <mark.burton@greensocs.com>, Jan Kiszka <jan.kiszka@web.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lCf6B6Q27VTimfdKtlJ7mbzfu7j8js2KV
From: Luc Michel <luc.michel@greensocs.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>,
 Mark Burton <mark.burton@greensocs.com>, Jan Kiszka <jan.kiszka@web.de>
Message-ID: <40f915c1-6f91-1b0c-3cc7-8a4e5ca77f5b@greensocs.com>
Subject: Re: [PATCH v2 5/7] intc/arm_gic: Add virtualization extensions logic
References: <20180619093124.24011-1-luc.michel@greensocs.com>
 <20180619093124.24011-6-luc.michel@greensocs.com>
 <CAFEAcA8rKk+G_PYr4t5L=0zy3Hv-wB_7Wbe9zn+H_ZE9bLLn=A@mail.gmail.com>
In-Reply-To: <CAFEAcA8rKk+G_PYr4t5L=0zy3Hv-wB_7Wbe9zn+H_ZE9bLLn=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 06/25/2018 04:23 PM, Peter Maydell wrote:
> On 19 June 2018 at 10:31,  <luc.michel@greensocs.com> wrote:
>> From: Luc MICHEL <luc.michel@greensocs.com>
>>
>> This commit adds the actual implementation of the GICv2 virtualization=

>> extensions logic.
>>
>> For the vCPU interfaces, most of the existing CPU interface code is
>> reused. Calls to macros or functions modifying the distributor state a=
re
>> replaced with equivalent generic inline functions that act either on t=
he
>> distributor or on the virtual interface, given that the current CPU is=
 a
>> physical or a virtual one. For vCPU MMIO, the call is simply forwarded=

>> to the CPU read/write functions, with the CPU id being incremented by
>> GIC_CPU_NR (vCPU id =3D CPU id + GIC_CPU_NR), and by faking a secure
>> access (exposed vCPU interfaces do not implement security extensions.
>> Faking a secure access allows to go through the "secure or no security=

>> extension" logic in the CPU interface).
>>
>> The gic_update logic is generalized to handle vCPUs. The main differen=
ce
>> is the way the best IRQ is selected. This part has been split into two=

>> inline functions `gic_get_best_(v)irq`. The other difference is how we=

>> determine if IRQ distribution is enabled or not (split in
>> `gic_dist_enabled`).
>>
>> Regarding list registers (LR) handling, some caching is done in the GI=
C
>> state to avoid repetitive LR iteration. The following information is
>> cached:
>>   * vIRQ to LR mapping, in s->virq_lr_entry,
>>   * the EISR and ELRSR registers,
>>   * the LRs in the pending state, in s->pending_lrs.
>> This cache is kept up-to-date with some maintenance functions, and is
>> recomputed when the GIC state is loaded from a VMState restoration.
>=20
> Did you measure to determine whether the caching is worth the effort?
> The kernel has to rewrite the LR registers fairly often as it enters
> and exits the guest, whereas for instance it doesn't ever read the EISR=

> at all as far as I can tell, and whenever it reads the ELRSR it then
> writes all the LRs, so LR writes are definitely more frequent than
> ELRSR reads. If you take my suggestion from patch 4 of implementing
> 4 LRs rather than 64 then the overhead of iterating them all is also
> 8x smaller.)
You are probably right, I didn't try to profile this part of the code to
see if the caching is worst the effort. Now that I see the way Xen uses
the GICv2, it's pretty clear that a "on-demand" computation of ELRSR and
EISR would probably be better.

However, I think the "virq_lr_entry" part of the caching is the
interesting one as it allows to resolve a vIRQ =E2=86=92 LR mapping in O(=
1), and
is used in a lot of vCPU interface operations. But as you said, if we
default to 4 LRs, then the LR iteration cost is pretty low.

So, removing the caching mechanism would lead to:
  * no more h_eisr, h_elrsr, pending_lrs in the GIC state,
  * on-demand computation when needed,
  * The vIRQ =E2=86=92 LR mapping could be kept, but with 4 LRs it's prob=
ably
not worst it.

What do you think? For now I'm preparing the v3 without caching at all.
I'll be able to do some profiling if needed between the two versions.

>=20
>> Signed-off-by: Luc MICHEL <luc.michel@greensocs.com>
>> ---
>>  hw/intc/arm_gic.c      | 648 +++++++++++++++++++++++++++++++++++-----=
-
>>  hw/intc/gic_internal.h | 198 +++++++++++++
>>  2 files changed, 754 insertions(+), 92 deletions(-)
>=20
> This is painfully large to review. Compare the patchset that
> added virt support to GICv3, which broke things down into
> more digestible pieces (mostly ~250 lines a patch):
> https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg01243.html
OK :-) Sorry about that, let's split the beast then.
Thanks for the pre-review.

>=20
> I've added a few review notes below but just scanned the rest,
> as it's too hard to review as it is.
>=20
>> +static inline void gic_get_best_virq(GICState *s, int cpu,
>> +                                     int *best_irq, int *best_prio, i=
nt *group)
>> +{
>> +    int lr =3D 0;
>> +    uint64_t lrs_in_use;
>> +
>> +    /* In-use LRs have their corresponding bit cleared. */
>> +    lrs_in_use =3D ~(s->h_elrsr[cpu]);
>> +
>> +#if GIC_NR_LR < 64
>> +    /* Ignore unimplemented LRs */
>> +    lrs_in_use &=3D (1 << GIC_NR_LR) - 1;
>> +#endif
>=20
> MAKE_64BIT_MASK() allows you to avoid the ifdef.
>=20
>> +
>> +    *best_irq =3D 1023;
>> +    *best_prio =3D 0x100;
>> +
>> +    while (lrs_in_use) {
>> +        if (lrs_in_use & 0x1) {
>> +            uint32_t lr_entry =3D s->h_lr[lr][cpu];
>> +            int state =3D GICH_LR_STATE(lr_entry);
>> +
>> +            if (state =3D=3D GICH_LR_STATE_PENDING) {
>> +                int prio =3D GICH_LR_PRIORITY(lr_entry);
>> +
>> +                if (prio < *best_prio) {
>> +                    *best_prio =3D prio;
>> +                    *best_irq =3D GICH_LR_VIRT_ID(lr_entry);
>> +                    *group =3D GICH_LR_GROUP(lr_entry);
>> +                }
>> +            }
>> +        }
>> +
>> +        lrs_in_use >>=3D 1;
>> +        lr++;
>> +    }
>> +}
>> +
>> +/* Return true if IRQ distribution is enabled:
>> + *      - in the distributor, for the given group mask if virt if fal=
se,
>> + *      - in the given CPU virtual interface if virt is true. */
>> +static inline bool gic_dist_enabled(GICState *s, int cpu, bool virt,
>> +                                    int group_mask)
>> +{
>> +    return (virt && (s->h_hcr[cpu] & GICH_HCR_EN))
>> +        || (!virt && (s->ctlr & group_mask));
>> +}
>=20
> HCR.EN doesn't have anything to do with the distributor
> (which is part of the non-virt related bits of the GIC),
> so it's a bit weird that we're testing it in a function
> named gic_dist_enabled().
OK. The name is misleading indeed. I wanted to factor this as the code
in gic_update_internal was becoming hard to read.
This function tells if signaling of IRQs is enabled or not:
  - when virt is false, from the distributor to the CPU iface,
  - when virt is true, from the virtual interface to the vCPU iface.

Maybe a name like gic_irq_signaling_enabled() is better?

>=20
>> +
>>  /* TODO: Many places that call this routine could be optimized.  */
>>  /* Update interrupt status after enabled or pending bits have been ch=
anged.  */
>> -static void gic_update(GICState *s)
>> +static inline void gic_update_internal(GICState *s, bool virt)
>>  {
>>      int best_irq;
>>      int best_prio;
>> -    int irq;
>>      int irq_level, fiq_level;
>> -    int cpu;
>> -    int cm;
>> +    int cpu, cpu_iface;
>> +    int group =3D 0;
>> +    qemu_irq *irq_lines =3D virt ? s->parent_virq : s->parent_irq;
>> +    qemu_irq *fiq_lines =3D virt ? s->parent_vfiq : s->parent_fiq;
>>
>>      for (cpu =3D 0; cpu < s->num_cpu; cpu++) {
>> -        cm =3D 1 << cpu;
>> -        s->current_pending[cpu] =3D 1023;
>> -        if (!(s->ctlr & (GICD_CTLR_EN_GRP0 | GICD_CTLR_EN_GRP1))
>> -            || !(s->cpu_ctlr[cpu] & (GICC_CTLR_EN_GRP0 | GICC_CTLR_EN=
_GRP1))) {
>> -            qemu_irq_lower(s->parent_irq[cpu]);
>> -            qemu_irq_lower(s->parent_fiq[cpu]);
>> +        cpu_iface =3D virt ? (cpu + GIC_NCPU) : cpu;
>> +
>> +        s->current_pending[cpu_iface] =3D 1023;
>> +        if (!gic_dist_enabled(s, cpu, virt,
>> +                              GICD_CTLR_EN_GRP0 | GICD_CTLR_EN_GRP1)
>> +            || !(s->cpu_ctlr[cpu_iface] &
>> +                 (GICC_CTLR_EN_GRP0 | GICC_CTLR_EN_GRP1))) {
>> +            qemu_irq_lower(irq_lines[cpu]);
>> +            qemu_irq_lower(fiq_lines[cpu]);
>>              continue;
>>          }
>> -        best_prio =3D 0x100;
>> -        best_irq =3D 1023;
>> -        for (irq =3D 0; irq < s->num_irq; irq++) {
>> -            if (GIC_DIST_TEST_ENABLED(irq, cm) &&
>> -                gic_test_pending(s, irq, cm) &&
>> -                (!GIC_DIST_TEST_ACTIVE(irq, cm)) &&
>> -                (irq < GIC_INTERNAL || GIC_DIST_TARGET(irq) & cm)) {
>> -                if (GIC_DIST_GET_PRIORITY(irq, cpu) < best_prio) {
>> -                    best_prio =3D GIC_DIST_GET_PRIORITY(irq, cpu);
>> -                    best_irq =3D irq;
>> -                }
>> -            }
>> +
>> +        if (virt) {
>> +            gic_get_best_virq(s, cpu, &best_irq, &best_prio, &group);=

>> +        } else {
>> +            gic_get_best_irq(s, cpu, &best_irq, &best_prio, &group);
>>          }
>>
>>          if (best_irq !=3D 1023) {
>>              trace_gic_update_bestirq(cpu, best_irq, best_prio,
>> -                s->priority_mask[cpu], s->running_priority[cpu]);
>> +                s->priority_mask[cpu_iface], s->running_priority[cpu_=
iface]);
>>          }
>>
>>          irq_level =3D fiq_level =3D 0;
>>
>> -        if (best_prio < s->priority_mask[cpu]) {
>> -            s->current_pending[cpu] =3D best_irq;
>> -            if (best_prio < s->running_priority[cpu]) {
>> -                int group =3D GIC_DIST_TEST_GROUP(best_irq, cm);
>> -
>> -                if (extract32(s->ctlr, group, 1) &&
>> -                    extract32(s->cpu_ctlr[cpu], group, 1)) {
>> -                    if (group =3D=3D 0 && s->cpu_ctlr[cpu] & GICC_CTL=
R_FIQ_EN) {
>> +        if (best_prio < s->priority_mask[cpu_iface]) {
>> +            s->current_pending[cpu_iface] =3D best_irq;
>> +            if (best_prio < s->running_priority[cpu_iface]) {
>> +                if (gic_dist_enabled(s, cpu, virt, 1 << group) &&
>> +                    extract32(s->cpu_ctlr[cpu_iface], group, 1)) {
>> +                    if (group =3D=3D 0 &&
>> +                        s->cpu_ctlr[cpu_iface] & GICC_CTLR_FIQ_EN) {
>>                          DPRINTF("Raised pending FIQ %d (cpu %d)\n",
>> -                                best_irq, cpu);
>> +                                best_irq, cpu_iface);
>>                          fiq_level =3D 1;
>> -                        trace_gic_update_set_irq(cpu, "fiq", fiq_leve=
l);
>> +                        trace_gic_update_set_irq(cpu, virt ? "vfiq" :=
 "fiq",
>> +                                                 fiq_level);
>>                      } else {
>>                          DPRINTF("Raised pending IRQ %d (cpu %d)\n",
>> -                                best_irq, cpu);
>> +                                best_irq, cpu_iface);
>>                          irq_level =3D 1;
>> -                        trace_gic_update_set_irq(cpu, "irq", irq_leve=
l);
>> +                        trace_gic_update_set_irq(cpu, virt ? "virq" :=
 "irq",
>> +                                                 irq_level);
>>                      }
>>                  }
>>              }
>>          }
>>
>> -        qemu_set_irq(s->parent_irq[cpu], irq_level);
>> -        qemu_set_irq(s->parent_fiq[cpu], fiq_level);
>> +        qemu_set_irq(irq_lines[cpu], irq_level);
>> +        qemu_set_irq(fiq_lines[cpu], fiq_level);
>>      }
>>  }
>>
>> +static void gic_compute_misr(GICState *s, int cpu)
>> +{
>> +    int val;
>> +    int vcpu =3D cpu + GIC_NCPU;
>> +
>> +    /* EOI */
>> +    val =3D s->h_eisr[cpu] !=3D 0;
>> +    s->h_misr[cpu] =3D val << 0;
>=20
> It would be nice to define and use some constant names for
> the MISR bits here. (Consider using the FIELD macro to
> define shift/mask/etc constants for you.)
>=20
>> +
>> +    /* U: true if only 0 or 1 LR entry is valid */
>> +    val =3D s->h_hcr[cpu] & GICH_HCR_UIE &&
>> +        ((GIC_NR_LR - ctpop64(s->h_elrsr[cpu])) < 2);
>> +    s->h_misr[cpu] |=3D val << 1;
>=20
> I don't think this is correct. Bits in GICH_ELRSRn
> are set if (LRn.State =3D=3D 0 && (LRn.HW =3D=3D 1 || LRn.EOI =3D=3D 0)=
=2E
> But the U bit is set based on how many of the LRs have
> an LRn.State field !=3D 0 -- there is no check on the
> HW or EOI bits here.
Good catch. The doc is indeed clear that we only consider the State
field here, but misled me as it says that null bits in ELRSR correspond
to a "valid" interrupt.
>=20
>=20
>=20
>> +
>> +    /* LRENP: EOICount is not 0 */
>> +    val =3D s->h_hcr[cpu] & GICH_HCR_LRENPIE &&
>> +        ((s->h_hcr[cpu] & GICH_HCR_EOICOUNT) !=3D 0);
>> +    s->h_misr[cpu] |=3D val << 2;
>> +
>> +    /* NP: no pending interrupts. The number of LRs in pending state =
is cached
>> +     * in s->pending_lrs[cpu]. */
>> +    val =3D s->h_hcr[cpu] & GICH_HCR_NPIE &&
>> +        (s->pending_lrs[cpu] =3D=3D 0);
>> +    s->h_misr[cpu] |=3D val << 3;
>> +
>> +    /* VGrp0E: group0 virq signaling enabled */
>> +    val =3D s->h_hcr[cpu] & GICH_HCR_VGRP0EIE &&
>> +        (s->cpu_ctlr[vcpu] & GICC_CTLR_EN_GRP0);
>> +    s->h_misr[cpu] |=3D val << 4;
>> +
>> +    /* VGrp0D: group0 virq signaling disabled */
>> +    val =3D s->h_hcr[cpu] & GICH_HCR_VGRP0DIE &&
>> +        !(s->cpu_ctlr[vcpu] & GICC_CTLR_EN_GRP0);
>> +    s->h_misr[cpu] |=3D val << 5;
>> +
>> +    /* VGrp1E: group1 virq signaling enabled */
>> +    val =3D s->h_hcr[cpu] & GICH_HCR_VGRP1EIE &&
>> +        (s->cpu_ctlr[vcpu] & GICC_CTLR_EN_GRP1);
>> +    s->h_misr[cpu] |=3D val << 6;
>> +
>> +    /* VGrp1D: group1 virq signaling disabled */
>> +    val =3D s->h_hcr[cpu] & GICH_HCR_VGRP1DIE &&
>> +        !(s->cpu_ctlr[vcpu] & GICC_CTLR_EN_GRP1);
>> +    s->h_misr[cpu] |=3D val << 7;
>> +}
>> +
>> +static void gic_update_maintenance(GICState *s)
>> +{
>> +    int cpu =3D 0;
>> +    int maint_level;
>> +
>> +    for (cpu =3D 0; cpu < s->num_cpu; cpu++) {
>> +        gic_compute_misr(s, cpu);
>> +        maint_level =3D (s->h_hcr[cpu] & GICH_HCR_EN) && s->h_misr[cp=
u];
>> +
>> +        qemu_set_irq(s->maintenance_irq[cpu], maint_level);
>> +    }
>> +}
>> +
>> +static void gic_update(GICState *s)
>> +{
>> +    gic_update_internal(s, false);
>> +}
>> +
>> +static void gic_update_virt(GICState *s)
>> +{
>> +    gic_update_internal(s, true);
>> +    gic_update_maintenance(s);
>> +}
>> +
>>  static void gic_set_irq_11mpcore(GICState *s, int irq, int level,
>>                                   int cm, int target)
>>  {
>> @@ -212,7 +358,8 @@ static uint16_t gic_get_current_pending_irq(GICSta=
te *s, int cpu,
>>      uint16_t pending_irq =3D s->current_pending[cpu];
>>
>>      if (pending_irq < GIC_MAXIRQ && gic_has_groups(s)) {
>> -        int group =3D GIC_DIST_TEST_GROUP(pending_irq, (1 << cpu));
>> +        int group =3D gic_test_group(s, pending_irq, cpu);
>> +
>>          /* On a GIC without the security extensions, reading this reg=
ister
>>           * behaves in the same way as a secure access to a GIC with t=
hem.
>>           */
>> @@ -243,7 +390,7 @@ static int gic_get_group_priority(GICState *s, int=
 cpu, int irq)
>>
>>      if (gic_has_groups(s) &&
>>          !(s->cpu_ctlr[cpu] & GICC_CTLR_CBPR) &&
>> -        GIC_DIST_TEST_GROUP(irq, (1 << cpu))) {
>> +        gic_test_group(s, irq, cpu)) {
>>          bpr =3D s->abpr[cpu] - 1;
>>          assert(bpr >=3D 0);
>>      } else {
>> @@ -256,7 +403,7 @@ static int gic_get_group_priority(GICState *s, int=
 cpu, int irq)
>>       */
>>      mask =3D ~0U << ((bpr & 7) + 1);
>>
>> -    return GIC_DIST_GET_PRIORITY(irq, cpu) & mask;
>> +    return gic_get_priority(s, irq, cpu) & mask;
>>  }
>>
>>  static void gic_activate_irq(GICState *s, int cpu, int irq)
>> @@ -265,18 +412,25 @@ static void gic_activate_irq(GICState *s, int cp=
u, int irq)
>>       * and update the running priority.
>>       */
>>      int prio =3D gic_get_group_priority(s, cpu, irq);
>> -    int preemption_level =3D prio >> (GIC_MIN_BPR + 1);
>> +    int min_bpr =3D gic_is_vcpu(cpu) ? GIC_VIRT_MIN_BPR : GIC_MIN_BPR=
;
>> +    int preemption_level =3D prio >> (min_bpr + 1);
>>      int regno =3D preemption_level / 32;
>>      int bitno =3D preemption_level % 32;
>> +    uint32_t *papr =3D NULL;
>>
>> -    if (gic_has_groups(s) && GIC_DIST_TEST_GROUP(irq, (1 << cpu))) {
>> -        s->nsapr[regno][cpu] |=3D (1 << bitno);
>> +    if (gic_is_vcpu(cpu)) {
>> +        assert(regno =3D=3D 0);
>> +        papr =3D &s->h_apr[gic_get_vcpu_real_id(cpu)];
>> +    } else if (gic_has_groups(s) && gic_test_group(s, irq, cpu)) {
>> +        papr =3D &s->nsapr[regno][cpu];
>>      } else {
>> -        s->apr[regno][cpu] |=3D (1 << bitno);
>> +        papr =3D &s->apr[regno][cpu];
>>      }
>>
>> +    *papr |=3D (1 << bitno);
>> +
>>      s->running_priority[cpu] =3D prio;
>> -    GIC_DIST_SET_ACTIVE(irq, 1 << cpu);
>> +    gic_set_active(s, irq, cpu);
>>  }
>>
>>  static int gic_get_prio_from_apr_bits(GICState *s, int cpu)
>> @@ -285,12 +439,22 @@ static int gic_get_prio_from_apr_bits(GICState *=
s, int cpu)
>>       * on the set bits in the Active Priority Registers.
>>       */
>>      int i;
>> -    for (i =3D 0; i < GIC_NR_APRS; i++) {
>> -        uint32_t apr =3D s->apr[i][cpu] | s->nsapr[i][cpu];
>> +    int min_bpr =3D gic_is_vcpu(cpu) ? GIC_VIRT_MIN_BPR : GIC_MIN_BPR=
;
>> +    int nr_aprs =3D gic_is_vcpu(cpu) ? GIC_VIRT_NR_APRS : GIC_NR_APRS=
;
>> +
>> +    for (i =3D 0; i < nr_aprs; i++) {
>> +        uint32_t apr;
>> +
>> +        if (gic_is_vcpu(cpu)) {
>> +            apr =3D s->h_apr[gic_get_vcpu_real_id(cpu)];
>> +        } else {
>> +            apr =3D s->apr[i][cpu] | s->nsapr[i][cpu];
>> +        }
>> +
>>          if (!apr) {
>>              continue;
>>          }
>> -        return (i * 32 + ctz32(apr)) << (GIC_MIN_BPR + 1);
>> +        return (i * 32 + ctz32(apr)) << (min_bpr + 1);
>>      }
>>      return 0x100;
>>  }
>> @@ -314,9 +478,19 @@ static void gic_drop_prio(GICState *s, int cpu, i=
nt group)
>>       * might not do so, and interrupts that should not preempt might =
do so.
>>       */
>>      int i;
>> +    int nr_aprs =3D gic_is_vcpu(cpu) ? GIC_VIRT_NR_APRS : GIC_NR_APRS=
;
>> +
>> +    for (i =3D 0; i < nr_aprs; i++) {
>> +        uint32_t *papr =3D NULL;
>> +
>> +        if (gic_is_vcpu(cpu)) {
>> +            papr =3D &s->h_apr[gic_get_vcpu_real_id(cpu)];
>> +        } else if (group) {
>> +            papr =3D &s->nsapr[i][cpu];
>> +        } else {
>> +            papr =3D &s->apr[i][cpu];
>> +        }
>>
>> -    for (i =3D 0; i < GIC_NR_APRS; i++) {
>> -        uint32_t *papr =3D group ? &s->nsapr[i][cpu] : &s->apr[i][cpu=
];
>>          if (!*papr) {
>>              continue;
>>          }
>> @@ -328,24 +502,51 @@ static void gic_drop_prio(GICState *s, int cpu, =
int group)
>>      s->running_priority[cpu] =3D gic_get_prio_from_apr_bits(s, cpu);
>>  }
>>
>> +static inline uint32_t gic_clear_pending_sgi(GICState *s, int irq, in=
t cpu)
>> +{
>> +    int src;
>> +    uint32_t ret;
>> +
>> +    if (!gic_is_vcpu(cpu)) {
>> +        /* Lookup the source CPU for the SGI and clear this in the
>> +         * sgi_pending map.  Return the src and clear the overall pen=
ding
>> +         * state on this CPU if the SGI is not pending from any CPUs.=

>> +         */
>> +        assert(s->sgi_pending[irq][cpu] !=3D 0);
>> +        src =3D ctz32(s->sgi_pending[irq][cpu]);
>> +        s->sgi_pending[irq][cpu] &=3D ~(1 << src);
>> +        if (s->sgi_pending[irq][cpu] =3D=3D 0) {
>> +            gic_clear_pending(s, irq, cpu);
>> +        }
>> +        ret =3D irq | ((src & 0x7) << 10);
>> +    } else {
>> +        uint32_t *lr_entry =3D gic_get_lr_entry(s, irq, cpu);
>> +        src =3D GICH_LR_CPUID(*lr_entry);
>> +
>> +        gic_clear_pending(s, irq, cpu);
>> +        ret =3D irq | (src << 10);
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>>  uint32_t gic_acknowledge_irq(GICState *s, int cpu, MemTxAttrs attrs)
>>  {
>> -    int ret, irq, src;
>> -    int cm =3D 1 << cpu;
>> +    int ret, irq;
>>
>>      /* gic_get_current_pending_irq() will return 1022 or 1023 appropr=
iately
>>       * for the case where this GIC supports grouping and the pending =
interrupt
>>       * is in the wrong group.
>>       */
>>      irq =3D gic_get_current_pending_irq(s, cpu, attrs);
>> -    trace_gic_acknowledge_irq(cpu, irq);
>> +    trace_gic_acknowledge_irq(gic_get_vcpu_real_id(cpu), irq);
>>
>>      if (irq >=3D GIC_MAXIRQ) {
>>          DPRINTF("ACK, no pending interrupt or it is hidden: %d\n", ir=
q);
>>          return irq;
>>      }
>>
>> -    if (GIC_DIST_GET_PRIORITY(irq, cpu) >=3D s->running_priority[cpu]=
) {
>> +    if (gic_get_priority(s, irq, cpu) >=3D s->running_priority[cpu]) =
{
>>          DPRINTF("ACK, pending interrupt (%d) has insufficient priorit=
y\n", irq);
>>          return 1023;
>>      }
>> @@ -354,37 +555,23 @@ uint32_t gic_acknowledge_irq(GICState *s, int cp=
u, MemTxAttrs attrs)
>>          /* Clear pending flags for both level and edge triggered inte=
rrupts.
>>           * Level triggered IRQs will be reasserted once they become i=
nactive.
>>           */
>> -        GIC_DIST_CLEAR_PENDING(irq, GIC_DIST_TEST_MODEL(irq) ? ALL_CP=
U_MASK
>> -                                                             : cm);
>> +        gic_clear_pending(s, irq, cpu);
>>          ret =3D irq;
>>      } else {
>>          if (irq < GIC_NR_SGIS) {
>> -            /* Lookup the source CPU for the SGI and clear this in th=
e
>> -             * sgi_pending map.  Return the src and clear the overall=
 pending
>> -             * state on this CPU if the SGI is not pending from any C=
PUs.
>> -             */
>> -            assert(s->sgi_pending[irq][cpu] !=3D 0);
>> -            src =3D ctz32(s->sgi_pending[irq][cpu]);
>> -            s->sgi_pending[irq][cpu] &=3D ~(1 << src);
>> -            if (s->sgi_pending[irq][cpu] =3D=3D 0) {
>> -                GIC_DIST_CLEAR_PENDING(irq,
>> -                                       GIC_DIST_TEST_MODEL(irq) ? ALL=
_CPU_MASK
>> -                                                                : cm)=
;
>> -            }
>> -            ret =3D irq | ((src & 0x7) << 10);
>> +            ret =3D gic_clear_pending_sgi(s, irq, cpu);
>>          } else {
>> -            /* Clear pending state for both level and edge triggered
>> -             * interrupts. (level triggered interrupts with an active=
 line
>> -             * remain pending, see gic_test_pending)
>> -             */
>> -            GIC_DIST_CLEAR_PENDING(irq, GIC_DIST_TEST_MODEL(irq) ? AL=
L_CPU_MASK
>> -                                                                 : cm=
);
>> +            gic_clear_pending(s, irq, cpu);
>>              ret =3D irq;
>>          }
>>      }
>>
>>      gic_activate_irq(s, cpu, irq);
>> -    gic_update(s);
>> +    if (gic_is_vcpu(cpu)) {
>> +        gic_update_virt(s);
>> +    } else {
>> +        gic_update(s);
>> +    }
>>      DPRINTF("ACK %d\n", irq);
>>      return ret;
>>  }
>> @@ -534,8 +721,7 @@ static bool gic_eoi_split(GICState *s, int cpu, Me=
mTxAttrs attrs)
>>
>>  static void gic_deactivate_irq(GICState *s, int cpu, int irq, MemTxAt=
trs attrs)
>>  {
>> -    int cm =3D 1 << cpu;
>> -    int group =3D gic_has_groups(s) && GIC_DIST_TEST_GROUP(irq, cm);
>> +    int group =3D gic_has_groups(s) && gic_test_group(s, irq, cpu);
>>
>>      if (!gic_eoi_split(s, cpu, attrs)) {
>>          /* This is UNPREDICTABLE; we choose to ignore it */
>> @@ -549,7 +735,7 @@ static void gic_deactivate_irq(GICState *s, int cp=
u, int irq, MemTxAttrs attrs)
>>          return;
>>      }
>>
>> -    GIC_DIST_CLEAR_ACTIVE(irq, cm);
>> +    gic_clear_active(s, irq, cpu);
>>  }
>>
>>  static void gic_complete_irq(GICState *s, int cpu, int irq, MemTxAttr=
s attrs)
>> @@ -558,6 +744,20 @@ static void gic_complete_irq(GICState *s, int cpu=
, int irq, MemTxAttrs attrs)
>>      int group;
>>
>>      DPRINTF("EOI %d\n", irq);
>> +    if (gic_is_vcpu(cpu) && !gic_virq_is_valid(s, irq, cpu)) {
>> +        /* This vIRQ does not have a valid LR entry. Increment EOICou=
nt and
>> +         * ignore the write. */
>> +
>> +        int rcpu =3D gic_get_vcpu_real_id(cpu);
>> +        int eoicount =3D extract32(s->h_hcr[rcpu], 27, 5) + 1;
>> +
>> +        /* This 5 bits counter wraps to 0 */
>> +        eoicount &=3D 0x1f;
>> +
>> +        s->h_hcr[rcpu] =3D deposit32(s->h_hcr[rcpu], 27, 5, eoicount)=
;
>=20
> Since EOIcount is at the top of a 32-bit register which we represent
> using a uint32_t, we can do the increment and wrap-to-zero without
> having to extract the field and put it back:
>=20
>    s->h_hcr[rcpu] +=3D 1 << 27;
>=20
>> +        return;
>> +    }
>> +
>>      if (irq >=3D s->num_irq) {
>>          /* This handles two cases:
>>           * 1. If software writes the ID of a spurious interrupt [ie 1=
023]
>> @@ -584,7 +784,7 @@ static void gic_complete_irq(GICState *s, int cpu,=
 int irq, MemTxAttrs attrs)
>>          }
>>      }
>>
>> -    group =3D gic_has_groups(s) && GIC_DIST_TEST_GROUP(irq, cm);
>> +    group =3D gic_has_groups(s) && gic_test_group(s, irq, cpu);
>>
>>      if (s->security_extn && !attrs.secure && !group) {
>>          DPRINTF("Non-secure EOI for Group0 interrupt %d ignored\n", i=
rq);
>> @@ -600,9 +800,14 @@ static void gic_complete_irq(GICState *s, int cpu=
, int irq, MemTxAttrs attrs)
>>
>>      /* In GICv2 the guest can choose to split priority-drop and deact=
ivate */
>>      if (!gic_eoi_split(s, cpu, attrs)) {
>> -        GIC_DIST_CLEAR_ACTIVE(irq, cm);
>> +        gic_clear_active(s, irq, cpu);
>> +    }
>> +
>> +    if (gic_is_vcpu(cpu)) {
>> +        gic_update_virt(s);
>> +    } else {
>> +        gic_update(s);
>>      }
>> -    gic_update(s);
>>  }
>>
>>  static uint32_t gic_dist_readb(void *opaque, hwaddr offset, MemTxAttr=
s attrs)
>> @@ -888,8 +1093,9 @@ static void gic_dist_writeb(void *opaque, hwaddr =
offset,
>>
>>          for (i =3D 0; i < 8; i++) {
>>              if (value & (1 << i)) {
>> -                int mask =3D (irq < GIC_INTERNAL) ? (1 << cpu)
>> -                                                : GIC_DIST_TARGET(irq=
 + i);
>> +                int mask =3D
>> +                    (irq < GIC_INTERNAL) ? (1 << cpu)
>> +                                         : GIC_DIST_TARGET(irq + i);
>>                  int cm =3D (irq < GIC_INTERNAL) ? (1 << cpu) : ALL_CP=
U_MASK;
>>
>>                  if (s->security_extn && !attrs.secure &&
>> @@ -1242,12 +1448,15 @@ static MemTxResult gic_cpu_read(GICState *s, i=
nt cpu, int offset,
>>      case 0xd0: case 0xd4: case 0xd8: case 0xdc:
>>      {
>>          int regno =3D (offset - 0xd0) / 4;
>> +        int nr_aprs =3D gic_is_vcpu(cpu) ? GIC_VIRT_NR_APRS : GIC_NR_=
APRS;
>>
>> -        if (regno >=3D GIC_NR_APRS || s->revision !=3D 2) {
>> +        if (regno >=3D nr_aprs || s->revision !=3D 2) {
>>              *data =3D 0;
>>          } else if (s->security_extn && !attrs.secure) {
>>              /* NS view of GICC_APR<n> is the top half of GIC_NSAPR<n>=
 */
>>              *data =3D gic_apr_ns_view(s, regno, cpu);
>> +        } else if (gic_is_vcpu(cpu)) {
>> +            *data =3D s->h_apr[gic_get_vcpu_real_id(cpu)];
>=20
> This should go earlier in the if-ladder -- it's weird to rely on the
> "is this an NS access to a TZ-aware GIC" check not firing.
>=20
>>          } else {
>>              *data =3D s->apr[regno][cpu];
>>          }
>> @@ -1258,7 +1467,7 @@ static MemTxResult gic_cpu_read(GICState *s, int=
 cpu, int offset,
>>          int regno =3D (offset - 0xe0) / 4;
>>
>>          if (regno >=3D GIC_NR_APRS || s->revision !=3D 2 || !gic_has_=
groups(s) ||
>> -            (s->security_extn && !attrs.secure)) {
>> +            (s->security_extn && !attrs.secure) || gic_is_vcpu(cpu)) =
{
>>              *data =3D 0;
>>          } else {
>>              *data =3D s->nsapr[regno][cpu];
>> @@ -1293,7 +1502,8 @@ static MemTxResult gic_cpu_write(GICState *s, in=
t cpu, int offset,
>>                  s->abpr[cpu] =3D MAX(value & 0x7, GIC_MIN_ABPR);
>>              }
>>          } else {
>> -            s->bpr[cpu] =3D MAX(value & 0x7, GIC_MIN_BPR);
>> +            int min_bpr =3D gic_is_vcpu(cpu) ? GIC_VIRT_MIN_BPR : GIC=
_MIN_BPR;
>> +            s->bpr[cpu] =3D MAX(value & 0x7, min_bpr);
>>          }
>>          break;
>>      case 0x10: /* End Of Interrupt */
>> @@ -1310,13 +1520,16 @@ static MemTxResult gic_cpu_write(GICState *s, =
int cpu, int offset,
>>      case 0xd0: case 0xd4: case 0xd8: case 0xdc:
>>      {
>>          int regno =3D (offset - 0xd0) / 4;
>> +        int nr_aprs =3D gic_is_vcpu(cpu) ? GIC_VIRT_NR_APRS : GIC_NR_=
APRS;
>>
>> -        if (regno >=3D GIC_NR_APRS || s->revision !=3D 2) {
>> +        if (regno >=3D nr_aprs || s->revision !=3D 2) {
>>              return MEMTX_OK;
>>          }
>>          if (s->security_extn && !attrs.secure) {
>>              /* NS view of GICC_APR<n> is the top half of GIC_NSAPR<n>=
 */
>>              gic_apr_write_ns_view(s, regno, cpu, value);
>> +        } else if (gic_is_vcpu(cpu)) {
>> +            s->h_apr[gic_get_vcpu_real_id(cpu)] =3D value;
>>          } else {
>>              s->apr[regno][cpu] =3D value;
>>          }
>> @@ -1332,6 +1545,9 @@ static MemTxResult gic_cpu_write(GICState *s, in=
t cpu, int offset,
>>          if (!gic_has_groups(s) || (s->security_extn && !attrs.secure)=
) {
>>              return MEMTX_OK;
>>          }
>> +        if (gic_is_vcpu(cpu)) {
>> +            return MEMTX_OK;
>> +        }
>>          s->nsapr[regno][cpu] =3D value;
>>          break;
>>      }
>> @@ -1344,7 +1560,13 @@ static MemTxResult gic_cpu_write(GICState *s, i=
nt cpu, int offset,
>>                        "gic_cpu_write: Bad offset %x\n", (int)offset);=

>>          return MEMTX_OK;
>>      }
>> -    gic_update(s);
>> +
>> +    if (gic_is_vcpu(cpu)) {
>> +        gic_update_virt(s);
>> +    } else {
>> +        gic_update(s);
>> +    }
>> +
>>      return MEMTX_OK;
>>  }
>>
>> @@ -1384,6 +1606,217 @@ static MemTxResult gic_do_cpu_write(void *opaq=
ue, hwaddr addr,
>>      GICState *s =3D *backref;
>>      int id =3D (backref - s->backref);
>>      return gic_cpu_write(s, id, addr, value, attrs);
>> +
>> +}
>> +
>> +static MemTxResult gic_thisvcpu_read(void *opaque, hwaddr addr, uint6=
4_t *data,
>> +                                    unsigned size, MemTxAttrs attrs)
>> +{
>> +    GICState *s =3D (GICState *)opaque;
>> +
>> +    /* The exposed vCPU interface does not implement security extensi=
ons.
>> +     * Pretend this access is secure to go through the "no security e=
xtension
>> +     * or secure access" path in the CPU interface. */
>> +    attrs.secure =3D 1;
>=20
> I'm not really a fan of this. How much extra checking does it
> actually save us?
Not much actually. One option is to refactor all the occurences of
"s->security_extn && !attrs.secure" in the CPU interface path with a
inline function call, something like:

static inline bool gic_cpu_ns_access(GICState *s, int cpu,
                                     MemTxAttrs attrs)
{
    return !gic_is_vcpu(cpu) && s->security_extn && !attrs.secure;
}

So it adds a comparison, which is probably acceptable.

>=20
>> +
>> +    return gic_cpu_read(s, gic_get_current_cpu(s) + GIC_NCPU,
>> +                        addr, data, attrs);
>> +}
>> +
>> +static MemTxResult gic_thisvcpu_write(void *opaque, hwaddr addr,
>> +                                     uint64_t value, unsigned size,
>> +                                     MemTxAttrs attrs)
>> +{
>> +    GICState *s =3D (GICState *)opaque;
>> +
>> +    attrs.secure =3D 1;
>> +
>> +    return gic_cpu_write(s, gic_get_current_cpu(s) + GIC_NCPU,
>> +                         addr, value, attrs);
>> +}
>> +
>> +static MemTxResult gic_do_vcpu_read(void *opaque, hwaddr addr, uint64=
_t *data,
>> +                                    unsigned size, MemTxAttrs attrs)
>> +{
>> +    GICState **backref =3D (GICState **)opaque;
>> +    GICState *s =3D *backref;
>> +    int id =3D (backref - s->backref);
>> +
>> +    attrs.secure =3D 1;
>> +
>> +    return gic_cpu_read(s, id + GIC_NCPU, addr, data, attrs);
>> +}
>> +
>> +static MemTxResult gic_do_vcpu_write(void *opaque, hwaddr addr,
>> +                                     uint64_t value, unsigned size,
>> +                                     MemTxAttrs attrs)
>> +{
>> +    GICState **backref =3D (GICState **)opaque;
>> +    GICState *s =3D *backref;
>> +    int id =3D (backref - s->backref);
>> +
>> +    attrs.secure =3D 1;
>> +
>> +    return gic_cpu_write(s, id + GIC_NCPU, addr, value, attrs);
>> +
>> +}
>> +
>> +static void gic_vmcr_write(GICState *s, uint32_t value)
>> +{
>> +    int vcpu =3D gic_get_current_vcpu(s);
>> +    uint32_t ctlr;
>> +    uint32_t abpr;
>> +    uint32_t bpr;
>> +    uint32_t prio_mask;
>> +
>> +    /* Always pretend to do a secure access */
>> +    MemTxAttrs attrs =3D { .secure =3D 1 };
>> +
>> +    ctlr =3D extract32(value, 0, 5) & 0x0000021f;
>=20
> The result of extract32() will only have bits [4:0]
> set, so the 0x200 in this mask will never have an
> effect -- why is it here?
I messed up here. This is the extract32 that is wrong, I'm missing the
EOImode flag.
>=20
>=20
>> +    abpr =3D extract32(value, 18, 3);
>> +    bpr =3D extract32(value, 21, 3);
>> +    prio_mask =3D extract32(value, 27, 5) << 3;
>> +
>> +    gic_set_cpu_control(s, vcpu, ctlr, attrs);
>> +    s->abpr[vcpu] =3D MAX(abpr, GIC_VIRT_MIN_ABPR);
>> +    s->bpr[vcpu] =3D MAX(bpr, GIC_VIRT_MIN_BPR);
>> +    gic_set_priority_mask(s, vcpu, prio_mask, attrs);
>> +}
>> +
>> +static void gic_set_lr_entry(GICState *s, int cpu, int lr_num, uint32=
_t entry)
>> +{
>> +    assert(lr_num < GIC_NR_LR);
>> +
>> +    uint32_t prev_entry =3D s->h_lr[lr_num][cpu];
>> +    int irq;
>> +    bool is_free;
>> +
>> +    if (!gic_lr_entry_is_free(prev_entry)) {
>> +        /* The entry was valid, flush it */
>> +        irq =3D GICH_LR_VIRT_ID(prev_entry);
>> +        gic_clear_virq_cache(s, irq, cpu);
>> +    }
>> +
>> +    s->h_lr[lr_num][cpu] =3D entry;
>> +    is_free =3D gic_lr_update(s, lr_num, cpu);
>> +
>> +    if (!is_free) {
>> +        /* Update the vIRQ -> LR entry cache */
>> +        irq =3D GICH_LR_VIRT_ID(entry);
>> +        gic_set_virq_cache(s, irq, cpu, lr_num);
>> +    }
>> +}
>> +
>> +static MemTxResult gic_hyp_read(void *opaque, hwaddr addr, uint64_t *=
data,
>> +                                unsigned size, MemTxAttrs attrs)
>> +{
>> +    GICState *s =3D ARM_GIC(opaque);
>> +    int cpu =3D gic_get_current_cpu(s);
>> +    int vcpu =3D gic_get_current_vcpu(s);
>> +
>> +    switch (addr) {
>> +    case 0x0: /* Hypervisor Control */
>> +        *data =3D s->h_hcr[cpu];
>> +        break;
>> +
>> +    case 0x4: /* VGIC Type */
>> +        *data =3D ((6 - GIC_VIRT_MIN_BPR) << 29)
>> +            | ((GIC_VIRT_MAX_GROUP_PRIO_BITS - 1) << 26)
>> +            | (GIC_NR_LR - 1);
>> +        break;
>> +
>> +    case 0x8: /* Virtual Machine Control */
>> +        *data =3D extract32(s->cpu_ctlr[vcpu], 0, 10);
>> +        *data |=3D extract32(s->abpr[vcpu], 0, 3) << 18;
>> +        *data |=3D extract32(s->bpr[vcpu], 0, 3) << 21;
>> +        *data |=3D extract32(s->priority_mask[vcpu], 3, 5) << 27;
>> +        break;
>> +
>> +    case 0x10: /* Maintenance Interrupt Status */
>> +        *data =3D s->h_misr[cpu];
>> +        break;
>> +
>> +    case 0x20: /* End of Interrupt Status 0 and 1 */
>> +    case 0x24:
>> +        *data =3D (uint32_t) extract64(s->h_eisr[cpu], (addr - 0x20) =
* 8, 32);
>=20
> The uint32_t cast is unnecessary here, I think (also below).
>=20
>> +        break;
>> +
>> +    case 0x30: /* Empty List Status 0 and 1 */
>> +    case 0x34:
>> +        *data =3D (uint32_t) extract64(s->h_elrsr[cpu], (addr - 0x30)=
 * 8, 32);
>> +        break;
>> +
>> +    case 0xf0: /* Active Priorities */
>> +        *data =3D s->h_apr[cpu];
>> +        break;
>> +
>> +    case 0x100 ... 0x1fc: /* List Registers */
>> +    {
>> +        int lr_num =3D (addr - 0x100) / 4;
>> +
>> +        if (lr_num > GIC_NR_LR) {
>> +            *data =3D 0;
>> +        } else {
>> +            *data =3D s->h_lr[lr_num][cpu];
>> +        }
>> +        break;
>> +    }
>> +
>> +    default:
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "gic_hyp_read: Bad offset %" HWADDR_PRIx "\n", =
addr);
>> +        return MEMTX_OK;
>> +    }
>> +
>> +    return MEMTX_OK;
>> +}
>> +
>> +static MemTxResult gic_hyp_write(void *opaque, hwaddr addr, uint64_t =
value,
>> +                                 unsigned size, MemTxAttrs attrs)
>> +{
>> +    GICState *s =3D ARM_GIC(opaque);
>> +    int cpu =3D gic_get_current_cpu(s);
>> +
>> +    switch (addr) {
>> +    case 0x0: /* Hypervisor Control */
>> +        s->h_hcr[cpu] =3D value & 0xf80000ff;
>=20
> You have constants defined for HCR fields so you don't need the
> magic number here.
>=20
>> +        break;
>> +
>> +    case 0x8: /* Virtual Machine Control */
>> +        gic_vmcr_write(s, value);
>> +        break;
>> +
>> +    case 0xf0: /* Active Priorities */
>> +        s->h_apr[cpu] =3D value;
>> +        break;
>> +
>> +    case 0x100 ... 0x1fc: /* List Registers */
>> +    {
>> +        int lr_num =3D (addr - 0x100) / 4;
>> +
>> +        if (lr_num > GIC_NR_LR) {
>> +            return MEMTX_OK;
>> +        }
>> +
>> +        gic_set_lr_entry(s, cpu, lr_num, value & 0xff8fffff);
>> +        break;
>> +    }
>> +
>> +    default:
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "gic_hyp_write: Bad offset %" HWADDR_PRIx "\n",=
 addr);
>> +        return MEMTX_OK;
>> +    }
>> +
>> +    gic_update_virt(s);
>> +    return MEMTX_OK;
>> +}
>> +
>> +static void arm_gic_post_load(GICState *s)
>> +{
>> +    if (s->virt_extn) {
>> +        gic_recompute_virt_cache(s);
>> +    }
>>  }
>>
>>  static const MemoryRegionOps gic_ops[2] =3D {
>> @@ -1405,6 +1838,25 @@ static const MemoryRegionOps gic_cpu_ops =3D {
>>      .endianness =3D DEVICE_NATIVE_ENDIAN,
>>  };
>>
>> +static const MemoryRegionOps gic_virt_ops[2] =3D {
>> +    {
>> +        .read_with_attrs =3D gic_hyp_read,
>> +        .write_with_attrs =3D gic_hyp_write,
>> +        .endianness =3D DEVICE_NATIVE_ENDIAN,
>> +    },
>> +    {
>> +        .read_with_attrs =3D gic_thisvcpu_read,
>> +        .write_with_attrs =3D gic_thisvcpu_write,
>> +        .endianness =3D DEVICE_NATIVE_ENDIAN,
>> +    }
>> +};
>> +
>> +static const MemoryRegionOps gic_vcpu_ops =3D {
>> +    .read_with_attrs =3D gic_do_vcpu_read,
>> +    .write_with_attrs =3D gic_do_vcpu_write,
>> +    .endianness =3D DEVICE_NATIVE_ENDIAN,
>> +};
>> +
>>  static void arm_gic_realize(DeviceState *dev, Error **errp)
>>  {
>>      /* Device instance realize function for the GIC sysbus device */
>> @@ -1427,7 +1879,7 @@ static void arm_gic_realize(DeviceState *dev, Er=
ror **errp)
>>      }
>>
>>      /* This creates distributor and main CPU interface (s->cpuiomem[0=
]) */
>> -    gic_init_irqs_and_mmio(s, gic_set_irq, gic_ops, NULL);
>> +    gic_init_irqs_and_mmio(s, gic_set_irq, gic_ops, gic_virt_ops);
>>
>>      /* Extra core-specific regions for the CPU interfaces. This is
>>       * necessary for "franken-GIC" implementations, for example on
>> @@ -1439,17 +1891,29 @@ static void arm_gic_realize(DeviceState *dev, =
Error **errp)
>>       */
>>      for (i =3D 0; i < s->num_cpu; i++) {
>>          s->backref[i] =3D s;
>> -        memory_region_init_io(&s->cpuiomem[i+1], OBJECT(s), &gic_cpu_=
ops,
>> +        memory_region_init_io(&s->cpuiomem[i + 1], OBJECT(s), &gic_cp=
u_ops,
>>                                &s->backref[i], "gic_cpu", 0x100);
>> -        sysbus_init_mmio(sbd, &s->cpuiomem[i+1]);
>> +        sysbus_init_mmio(sbd, &s->cpuiomem[i + 1]);
>=20
> This sort of stylistic fix to existing code should be in its own patch.=

>=20
>>      }
>> +
>> +    if (s->virt_extn) {
>> +        for (i =3D 0; i < s->num_cpu; i++) {
>> +            memory_region_init_io(&s->vcpuiomem[i + 1], OBJECT(s),
>> +                                  &gic_vcpu_ops, &s->backref[i],
>> +                                  "gic_vcpu", 0x2000);
>> +            sysbus_init_mmio(sbd, &s->vcpuiomem[i + 1]);
>> +        }
>> +    }
>> +
>>  }
>>
>>  static void arm_gic_class_init(ObjectClass *klass, void *data)
>>  {
>>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>> +    ARMGICCommonClass *agcc =3D ARM_GIC_COMMON_CLASS(klass);
>>      ARMGICClass *agc =3D ARM_GIC_CLASS(klass);
>>
>> +    agcc->post_load =3D arm_gic_post_load;
>>      device_class_set_parent_realize(dc, arm_gic_realize, &agc->parent=
_realize);
>>  }
>>
>> diff --git a/hw/intc/gic_internal.h b/hw/intc/gic_internal.h
>> index c85427c8e3..998e4b7854 100644
>> --- a/hw/intc/gic_internal.h
>> +++ b/hw/intc/gic_internal.h
>> @@ -64,6 +64,34 @@
>>  #define GICC_CTLR_EOIMODE    (1U << 9)
>>  #define GICC_CTLR_EOIMODE_NS (1U << 10)
>>
>> +#define GICH_HCR_EN       (1U << 0)
>> +#define GICH_HCR_UIE      (1U << 1)
>> +#define GICH_HCR_LRENPIE  (1U << 2)
>> +#define GICH_HCR_NPIE     (1U << 3)
>> +#define GICH_HCR_VGRP0EIE (1U << 4)
>> +#define GICH_HCR_VGRP0DIE (1U << 5)
>> +#define GICH_HCR_VGRP1EIE (1U << 6)
>> +#define GICH_HCR_VGRP1DIE (1U << 7)
>> +#define GICH_HCR_EOICOUNT (0x1fU << 27)
>> +
>> +#define GICH_LR_STATE_INVALID         0
>> +#define GICH_LR_STATE_PENDING         1
>> +#define GICH_LR_STATE_ACTIVE          2
>> +#define GICH_LR_STATE_ACTIVE_PENDING  3
>> +
>> +#define GICH_LR_VIRT_ID(entry) (extract32(entry, 0, 10))
>> +#define GICH_LR_PHYS_ID(entry) (extract32(entry, 10, 10))
>> +#define GICH_LR_PRIORITY(entry) (extract32(entry, 23, 5) << 3)
>> +#define GICH_LR_STATE(entry) (extract32(entry, 28, 2))
>> +#define GICH_LR_GROUP(entry) (extract32(entry, 30, 1))
>> +#define GICH_LR_HW(entry) (extract32(entry, 31, 1))
>> +#define GICH_LR_EOI(entry) (extract32(entry, 19, 1))
>> +#define GICH_LR_CPUID(entry) (extract32(entry, 10, 3))
>> +
>> +#define GICH_LR_CLEAR_PENDING(entry) ((entry) &=3D ~(1 << 28))
>> +#define GICH_LR_SET_ACTIVE(entry) ((entry) |=3D (1 << 29))
>> +#define GICH_LR_CLEAR_ACTIVE(entry) ((entry) &=3D ~(1 << 29))
>> +
>>  /* Valid bits for GICC_CTLR for GICv1, v1 with security extensions,
>>   * GICv2 and GICv2 with security extensions:
>>   */
>> @@ -99,4 +127,174 @@ static inline bool gic_is_vcpu(int cpu)
>>      return cpu >=3D GIC_NCPU;
>>  }
>>
>> +static inline int gic_get_vcpu_real_id(int cpu)
>> +{
>> +    return (cpu >=3D GIC_NCPU) ? (cpu - GIC_NCPU) : cpu;
>> +}
>> +
>> +static inline bool gic_lr_entry_is_free(uint32_t entry)
>> +{
>> +    return (GICH_LR_STATE(entry) =3D=3D GICH_LR_STATE_INVALID)
>> +        && (GICH_LR_HW(entry) || !GICH_LR_EOI(entry));
>> +}
>> +
>> +static inline bool gic_lr_entry_is_eoi(uint32_t entry)
>> +{
>> +    return (GICH_LR_STATE(entry) =3D=3D GICH_LR_STATE_INVALID)
>> +        && !GICH_LR_HW(entry) && GICH_LR_EOI(entry);
>> +}
>> +
>> +static inline bool gic_virq_is_valid(GICState *s, int irq, int vcpu)
>> +{
>> +    int cpu =3D gic_get_vcpu_real_id(vcpu);
>> +    return s->virq_lr_entry[irq][cpu] !=3D GIC_NR_LR;
>> +}
>> +
>> +/* Return a pointer on the LR entry for a given (irq,vcpu) couple.
>> + * This function requires that the entry actually exists somewhere in=

>> + * the LRs. */
>> +static inline uint32_t *gic_get_lr_entry(GICState *s, int irq, int vc=
pu)
>> +{
>> +    int cpu =3D gic_get_vcpu_real_id(vcpu);
>> +    int lr_num =3D s->virq_lr_entry[irq][cpu];
>> +
>> +    assert(lr_num >=3D 0 && lr_num < GIC_NR_LR);
>> +    return &s->h_lr[lr_num][cpu];
>> +}
>> +
>> +static inline void gic_set_virq_cache(GICState *s, int irq,
>> +                                      int vcpu, int lr_num)
>> +{
>> +    int cpu =3D gic_get_vcpu_real_id(vcpu);
>> +    s->virq_lr_entry[irq][cpu] =3D lr_num;
>> +}
>> +
>> +static inline void gic_clear_virq_cache(GICState *s, int irq, int vcp=
u)
>> +{
>> +    gic_set_virq_cache(s, irq, vcpu, GIC_NR_LR);
>> +}
>> +
>> +static inline bool gic_lr_update(GICState *s, int lr_num, int vcpu)
>> +{
>> +    int cpu =3D gic_get_vcpu_real_id(vcpu);
>> +
>> +    assert(lr_num >=3D 0 && lr_num < GIC_NR_LR);
>> +    uint32_t *entry =3D &s->h_lr[lr_num][cpu];
>> +
>> +    int is_eoi =3D gic_lr_entry_is_eoi(*entry);
>> +    int is_free =3D gic_lr_entry_is_free(*entry);
>> +    int is_pending =3D (GICH_LR_STATE(*entry) =3D=3D GICH_LR_STATE_PE=
NDING);
>> +
>> +    s->h_eisr[cpu] =3D deposit64(s->h_eisr[cpu], lr_num, 1, is_eoi);
>> +    s->h_elrsr[cpu] =3D deposit64(s->h_elrsr[cpu], lr_num, 1, is_free=
);
>> +    s->pending_lrs[cpu] =3D deposit64(s->pending_lrs[cpu], lr_num, 1,=
 is_pending);
>> +
>> +    return is_free;
>> +}
>> +
>> +static inline void gic_lr_update_by_irq(GICState *s, int irq, int vcp=
u)
>> +{
>> +    int cpu =3D gic_get_vcpu_real_id(vcpu);
>> +    int lr_num =3D s->virq_lr_entry[irq][cpu];
>> +
>> +    assert(lr_num !=3D GIC_NR_LR);
>> +    bool is_free =3D gic_lr_update(s, lr_num, vcpu);
>> +
>> +    if (is_free) {
>> +        gic_clear_virq_cache(s, irq, vcpu);
>> +    }
>> +}
>> +
>> +/* Recompute the whole virt cache, including the vIRQ to LR mapping, =
the EISR
>> + * and ELRSR registers, and the LRs in the pending state.
>> + * This function is called after restoring the GIC state from a VMSta=
te. */
>> +static inline void gic_recompute_virt_cache(GICState *s)
>> +{
>> +    int cpu, lr_num;
>> +
>> +    for (cpu =3D 0; cpu < s->num_cpu; cpu++) {
>> +        for (lr_num =3D 0; lr_num < GIC_NR_LR; lr_num++) {
>> +            bool is_free =3D gic_lr_update(s, lr_num, cpu);
>> +            uint32_t entry =3D s->h_lr[lr_num][cpu];
>> +
>> +            if (!is_free) {
>> +                int irq =3D GICH_LR_VIRT_ID(entry);
>> +                gic_set_virq_cache(s, irq, cpu, lr_num);
>> +            }
>> +        }
>> +    }
>> +}
>=20
> Oh, you do have this function; it just wasn't in the patch I
> expected it to be in...
>=20
>> +
>> +static inline bool gic_test_group(GICState *s, int irq, int cpu)
>> +{
>> +    if (gic_is_vcpu(cpu)) {
>> +        uint32_t *entry =3D gic_get_lr_entry(s, irq, cpu);
>> +        return GICH_LR_GROUP(*entry);
>> +    } else {
>> +        return GIC_DIST_TEST_GROUP(irq, 1 << cpu);
>> +    }
>> +}
>> +
>> +static inline void gic_clear_pending(GICState *s, int irq, int cpu)
>> +{
>> +    if (gic_is_vcpu(cpu)) {
>> +        uint32_t *entry =3D gic_get_lr_entry(s, irq, cpu);
>> +        GICH_LR_CLEAR_PENDING(*entry);
>> +        /* Don't recompute the LR cache yet as a clear pending reques=
t is
>> +         * always followed by a set active one. */
>> +    } else {
>> +        /* Clear pending state for both level and edge triggered
>> +         * interrupts. (level triggered interrupts with an active lin=
e
>> +         * remain pending, see gic_test_pending)
>> +         */
>> +        GIC_DIST_CLEAR_PENDING(irq, GIC_DIST_TEST_MODEL(irq) ? ALL_CP=
U_MASK
>> +                                                             : (1 << =
cpu));
>> +    }
>> +}
>> +
>> +static inline void gic_set_active(GICState *s, int irq, int cpu)
>> +{
>> +    if (gic_is_vcpu(cpu)) {
>> +        uint32_t *entry =3D gic_get_lr_entry(s, irq, cpu);
>> +        GICH_LR_SET_ACTIVE(*entry);
>> +        gic_lr_update_by_irq(s, irq, cpu);
>> +    } else {
>> +        GIC_DIST_SET_ACTIVE(irq, 1 << cpu);
>> +    }
>> +}
>> +
>> +static inline void gic_clear_active(GICState *s, int irq, int cpu)
>> +{
>> +    if (gic_is_vcpu(cpu)) {
>> +        uint32_t *entry =3D gic_get_lr_entry(s, irq, cpu);
>> +        GICH_LR_CLEAR_ACTIVE(*entry);
>> +
>> +        if (GICH_LR_HW(*entry)) {
>> +            /* Hardware interrupt. We must forward the deactivation r=
equest to
>> +             * the distributor */
>> +            int phys_irq =3D GICH_LR_PHYS_ID(*entry);
>> +            int rcpu =3D gic_get_vcpu_real_id(cpu);
>> +
>> +            /* Group 0 IRQs deactivation requests are ignored. */
>> +            if (GIC_DIST_TEST_GROUP(phys_irq, 1 << rcpu)) {
>> +                GIC_DIST_CLEAR_ACTIVE(phys_irq, 1 << rcpu);
>> +            }
>> +        }
>> +
>> +        gic_lr_update_by_irq(s, irq, cpu);
>> +    } else {
>> +        GIC_DIST_CLEAR_ACTIVE(irq, 1 << cpu);
>> +    }
>> +}
>> +
>> +static inline int gic_get_priority(GICState *s, int irq, int cpu)
>> +{
>> +    if (gic_is_vcpu(cpu)) {
>> +        uint32_t *entry =3D gic_get_lr_entry(s, irq, cpu);
>> +        return GICH_LR_PRIORITY(*entry);
>> +    } else {
>> +        return GIC_DIST_GET_PRIORITY(irq, cpu);
>> +    }
>> +}
>> +
>>  #endif /* QEMU_ARM_GIC_INTERNAL_H */
>> --
>> 2.17.1
>=20
> thanks
> -- PMM
>=20


--lCf6B6Q27VTimfdKtlJ7mbzfu7j8js2KV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUvSC0Bi15mxw2PT5d8knW3QnTr4FAlsyBKUACgkQd8knW3Qn
Tr7Jxw//bf58KUDW+XpN98O4Nbrk/N6VaT3vWBDHz+d8Eg+Tr4AqbNvSz8WZnnG4
JlYrENBz/gzF8virAH6nrG99NBYIVGztx+OM053YQwNSlIWP2aa8hF0mtR8SG4Jy
iEa2KqKct2GxIv7/uDyKiFJDRkm73zqXksYzFfYg/Taw6XVldP0n+jJvb5+4b0cr
TfCKuNXSruC5dl+qPiKzGtPOVdvsu44Z+lEmdGTTkt51fk27ddtaluYJIFGFsKnI
Lt6T3xGyg43NGIAzId0t1kYgO72ceEgFRq+vQyMkZCxA0E8HtYYEIUmab1O4sAGv
8M9pmwj6lnTFNlV6OtLx7bjp12oXegg+SSeLOuP9ZqwC2VAEba1aVyRLvDgr3f2b
fsVU4LBNhM09OX5OcjR+xbf1LcOWWqjOObP7M0UVtYe1H/BqlQRCAkh+Jc+vvf1g
diSNIksbEkeEifsNYjDC3NfljoIbdKoFcMOdmwAk1v1Nu6fwMJk7c3w+Xbxmwiog
Nh+g79KRaCGY7Vfon5rUNKf1Wk8lDN0xt7OGbiavYM7wOb+sZkQx575y+OsmvWuU
1Fk3F3xDcPrmG8d/ocat5XEWyQr6tj5xs48T7QRWq8gLYlBKsbmR6JRU+C3zY88T
ku20/WENSli3gI2s8ak7tOuryTWexg6eVDY99BRY/F9tV8xvbhc=
=qmzR
-----END PGP SIGNATURE-----

--lCf6B6Q27VTimfdKtlJ7mbzfu7j8js2KV--
