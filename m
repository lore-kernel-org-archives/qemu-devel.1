Received: from eggs.gnu.org ([2001:4830:134:3::10]:37742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fj27e-0006gR-2B
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 08:45:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fj27a-0002QA-SE
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 08:45:30 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180727095421.386-1-luc.michel@greensocs.com>
	<20180727095421.386-9-luc.michel@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <03210035-38cb-8d83-fb27-72c9acee36e2@amsat.org>
Date: Fri, 27 Jul 2018 09:45:16 -0300
MIME-Version: 1.0
In-Reply-To: <20180727095421.386-9-luc.michel@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v5 08/20] intc/arm_gic: Refactor
 secure/ns access check in the CPU interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luc Michel <luc.michel@greensocs.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, mark.burton@greensocs.com, saipava@xilinx.com, edgari@xilinx.com, qemu-arm@nongnu.org, Jan Kiszka <jan.kiszka@web.de>

On 07/27/2018 06:54 AM, Luc Michel wrote:
> An access to the CPU interface is non-secure if the current GIC instance
> implements the security extensions, and the memory access is actually
> non-secure. Until then, it was checked with tests such as
>   if (s->security_extn && !attrs.secure) { ... }
> in various places of the CPU interface code.
> 
> With the implementation of the virtualization extensions, those tests
> must be updated to take into account whether we are in a vCPU interface
> or not. This is because the exposed vCPU interface does not implement
> security extensions.
> 
> This commits replaces all those tests with a call to the
> gic_cpu_ns_access() function to check if the current access to the CPU
> interface is non-secure. This function takes into account whether the
> current CPU is a vCPU or not.
> 
> Note that this function is used only in the (v)CPU interface code path.
> The distributor code path is left unchanged, as the distributor is not
> exposed to vCPUs at all.
> 
> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/intc/arm_gic.c | 39 ++++++++++++++++++++++-----------------
>  1 file changed, 22 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
> index 41141fee53..94d5982e2a 100644
> --- a/hw/intc/arm_gic.c
> +++ b/hw/intc/arm_gic.c
> @@ -72,10 +72,15 @@ static inline int gic_get_current_vcpu(GICState *s)
>  static inline bool gic_has_groups(GICState *s)
>  {
>      return s->revision == 2 || s->security_extn;
>  }
>  
> +static inline bool gic_cpu_ns_access(GICState *s, int cpu, MemTxAttrs attrs)
> +{
> +    return !gic_is_vcpu(cpu) && s->security_extn && !attrs.secure;
> +}
> +
>  /* TODO: Many places that call this routine could be optimized.  */
>  /* Update interrupt status after enabled or pending bits have been changed.  */
>  static void gic_update(GICState *s)
>  {
>      int best_irq;
> @@ -219,11 +224,11 @@ static uint16_t gic_get_current_pending_irq(GICState *s, int cpu,
>      if (pending_irq < GIC_MAXIRQ && gic_has_groups(s)) {
>          int group = GIC_DIST_TEST_GROUP(pending_irq, (1 << cpu));
>          /* On a GIC without the security extensions, reading this register
>           * behaves in the same way as a secure access to a GIC with them.
>           */
> -        bool secure = !s->security_extn || attrs.secure;
> +        bool secure = !gic_cpu_ns_access(s, cpu, attrs);
>  
>          if (group == 0 && !secure) {
>              /* Group0 interrupts hidden from Non-secure access */
>              return 1023;
>          }
> @@ -426,11 +431,11 @@ static uint32_t gic_dist_get_priority(GICState *s, int cpu, int irq,
>  }
>  
>  static void gic_set_priority_mask(GICState *s, int cpu, uint8_t pmask,
>                                    MemTxAttrs attrs)
>  {
> -    if (s->security_extn && !attrs.secure) {
> +    if (gic_cpu_ns_access(s, cpu, attrs)) {
>          if (s->priority_mask[cpu] & 0x80) {
>              /* Priority Mask in upper half */
>              pmask = 0x80 | (pmask >> 1);
>          } else {
>              /* Non-secure write ignored if priority mask is in lower half */
> @@ -442,11 +447,11 @@ static void gic_set_priority_mask(GICState *s, int cpu, uint8_t pmask,
>  
>  static uint32_t gic_get_priority_mask(GICState *s, int cpu, MemTxAttrs attrs)
>  {
>      uint32_t pmask = s->priority_mask[cpu];
>  
> -    if (s->security_extn && !attrs.secure) {
> +    if (gic_cpu_ns_access(s, cpu, attrs)) {
>          if (pmask & 0x80) {
>              /* Priority Mask in upper half, return Non-secure view */
>              pmask = (pmask << 1) & 0xff;
>          } else {
>              /* Priority Mask in lower half, RAZ */
> @@ -458,11 +463,11 @@ static uint32_t gic_get_priority_mask(GICState *s, int cpu, MemTxAttrs attrs)
>  
>  static uint32_t gic_get_cpu_control(GICState *s, int cpu, MemTxAttrs attrs)
>  {
>      uint32_t ret = s->cpu_ctlr[cpu];
>  
> -    if (s->security_extn && !attrs.secure) {
> +    if (gic_cpu_ns_access(s, cpu, attrs)) {
>          /* Construct the NS banked view of GICC_CTLR from the correct
>           * bits of the S banked view. We don't need to move the bypass
>           * control bits because we don't implement that (IMPDEF) part
>           * of the GIC architecture.
>           */
> @@ -474,11 +479,11 @@ static uint32_t gic_get_cpu_control(GICState *s, int cpu, MemTxAttrs attrs)
>  static void gic_set_cpu_control(GICState *s, int cpu, uint32_t value,
>                                  MemTxAttrs attrs)
>  {
>      uint32_t mask;
>  
> -    if (s->security_extn && !attrs.secure) {
> +    if (gic_cpu_ns_access(s, cpu, attrs)) {
>          /* The NS view can only write certain bits in the register;
>           * the rest are unchanged
>           */
>          mask = GICC_CTLR_EN_GRP1;
>          if (s->revision == 2) {
> @@ -505,11 +510,11 @@ static uint8_t gic_get_running_priority(GICState *s, int cpu, MemTxAttrs attrs)
>      if ((s->revision != REV_11MPCORE) && (s->running_priority[cpu] > 0xff)) {
>          /* Idle priority */
>          return 0xff;
>      }
>  
> -    if (s->security_extn && !attrs.secure) {
> +    if (gic_cpu_ns_access(s, cpu, attrs)) {
>          if (s->running_priority[cpu] & 0x80) {
>              /* Running priority in upper half of range: return the Non-secure
>               * view of the priority.
>               */
>              return s->running_priority[cpu] << 1;
> @@ -529,11 +534,11 @@ static bool gic_eoi_split(GICState *s, int cpu, MemTxAttrs attrs)
>  {
>      if (s->revision != 2) {
>          /* Before GICv2 prio-drop and deactivate are not separable */
>          return false;
>      }
> -    if (s->security_extn && !attrs.secure) {
> +    if (gic_cpu_ns_access(s, cpu, attrs)) {
>          return s->cpu_ctlr[cpu] & GICC_CTLR_EOIMODE_NS;
>      }
>      return s->cpu_ctlr[cpu] & GICC_CTLR_EOIMODE;
>  }
>  
> @@ -561,11 +566,11 @@ static void gic_deactivate_irq(GICState *s, int cpu, int irq, MemTxAttrs attrs)
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "gic_deactivate_irq: GICC_DIR write when EOIMode clear");
>          return;
>      }
>  
> -    if (s->security_extn && !attrs.secure && !group) {
> +    if (gic_cpu_ns_access(s, cpu, attrs) && !group) {
>          DPRINTF("Non-secure DI for Group0 interrupt %d ignored\n", irq);
>          return;
>      }
>  
>      GIC_DIST_CLEAR_ACTIVE(irq, cm);
> @@ -603,11 +608,11 @@ static void gic_complete_irq(GICState *s, int cpu, int irq, MemTxAttrs attrs)
>          }
>      }
>  
>      group = gic_has_groups(s) && GIC_DIST_TEST_GROUP(irq, cm);
>  
> -    if (s->security_extn && !attrs.secure && !group) {
> +    if (gic_cpu_ns_access(s, cpu, attrs) && !group) {
>          DPRINTF("Non-secure EOI for Group0 interrupt %d ignored\n", irq);
>          return;
>      }
>  
>      /* Secure EOI with GICC_CTLR.AckCtl == 0 when the IRQ is a Group 1
> @@ -1279,11 +1284,11 @@ static MemTxResult gic_cpu_read(GICState *s, int cpu, int offset,
>          break;
>      case 0x04: /* Priority mask */
>          *data = gic_get_priority_mask(s, cpu, attrs);
>          break;
>      case 0x08: /* Binary Point */
> -        if (s->security_extn && !attrs.secure) {
> +        if (gic_cpu_ns_access(s, cpu, attrs)) {
>              if (s->cpu_ctlr[cpu] & GICC_CTLR_CBPR) {
>                  /* NS view of BPR when CBPR is 1 */
>                  *data = MIN(s->bpr[cpu] + 1, 7);
>              } else {
>                  /* BPR is banked. Non-secure copy stored in ABPR. */
> @@ -1306,11 +1311,11 @@ static MemTxResult gic_cpu_read(GICState *s, int cpu, int offset,
>          /* GIC v2, no security: ABPR
>           * GIC v1, no security: not implemented (RAZ/WI)
>           * With security extensions, secure access: ABPR (alias of NS BPR)
>           * With security extensions, nonsecure access: RAZ/WI
>           */
> -        if (!gic_has_groups(s) || (s->security_extn && !attrs.secure)) {
> +        if (!gic_has_groups(s) || (gic_cpu_ns_access(s, cpu, attrs))) {

Superfluous parenthesis,

>              *data = 0;
>          } else {
>              *data = s->abpr[cpu];
>          }
>          break;
> @@ -1318,11 +1323,11 @@ static MemTxResult gic_cpu_read(GICState *s, int cpu, int offset,
>      {
>          int regno = (offset - 0xd0) / 4;
>  
>          if (regno >= GIC_NR_APRS || s->revision != 2) {
>              *data = 0;
> -        } else if (s->security_extn && !attrs.secure) {
> +        } else if (gic_cpu_ns_access(s, cpu, attrs)) {
>              /* NS view of GICC_APR<n> is the top half of GIC_NSAPR<n> */
>              *data = gic_apr_ns_view(s, regno, cpu);
>          } else {
>              *data = s->apr[regno][cpu];
>          }
> @@ -1331,11 +1336,11 @@ static MemTxResult gic_cpu_read(GICState *s, int cpu, int offset,
>      case 0xe0: case 0xe4: case 0xe8: case 0xec:
>      {
>          int regno = (offset - 0xe0) / 4;
>  
>          if (regno >= GIC_NR_APRS || s->revision != 2 || !gic_has_groups(s) ||
> -            (s->security_extn && !attrs.secure)) {
> +            gic_cpu_ns_access(s, cpu, attrs)) {
>              *data = 0;
>          } else {
>              *data = s->nsapr[regno][cpu];
>          }
>          break;
> @@ -1358,11 +1363,11 @@ static MemTxResult gic_cpu_write(GICState *s, int cpu, int offset,
>          break;
>      case 0x04: /* Priority mask */
>          gic_set_priority_mask(s, cpu, value, attrs);
>          break;
>      case 0x08: /* Binary Point */
> -        if (s->security_extn && !attrs.secure) {
> +        if (gic_cpu_ns_access(s, cpu, attrs)) {
>              if (s->cpu_ctlr[cpu] & GICC_CTLR_CBPR) {
>                  /* WI when CBPR is 1 */
>                  return MEMTX_OK;
>              } else {
>                  s->abpr[cpu] = MAX(value & 0x7, GIC_MIN_ABPR);
> @@ -1373,11 +1378,11 @@ static MemTxResult gic_cpu_write(GICState *s, int cpu, int offset,
>          break;
>      case 0x10: /* End Of Interrupt */
>          gic_complete_irq(s, cpu, value & 0x3ff, attrs);
>          return MEMTX_OK;
>      case 0x1c: /* Aliased Binary Point */
> -        if (!gic_has_groups(s) || (s->security_extn && !attrs.secure)) {
> +        if (!gic_has_groups(s) || (gic_cpu_ns_access(s, cpu, attrs))) {

Ditto,

>              /* unimplemented, or NS access: RAZ/WI */
>              return MEMTX_OK;
>          } else {
>              s->abpr[cpu] = MAX(value & 0x7, GIC_MIN_ABPR);
>          }
> @@ -1387,11 +1392,11 @@ static MemTxResult gic_cpu_write(GICState *s, int cpu, int offset,
>          int regno = (offset - 0xd0) / 4;
>  
>          if (regno >= GIC_NR_APRS || s->revision != 2) {
>              return MEMTX_OK;
>          }
> -        if (s->security_extn && !attrs.secure) {
> +        if (gic_cpu_ns_access(s, cpu, attrs)) {
>              /* NS view of GICC_APR<n> is the top half of GIC_NSAPR<n> */
>              gic_apr_write_ns_view(s, regno, cpu, value);
>          } else {
>              s->apr[regno][cpu] = value;
>          }
> @@ -1402,11 +1407,11 @@ static MemTxResult gic_cpu_write(GICState *s, int cpu, int offset,
>          int regno = (offset - 0xe0) / 4;
>  
>          if (regno >= GIC_NR_APRS || s->revision != 2) {
>              return MEMTX_OK;
>          }
> -        if (!gic_has_groups(s) || (s->security_extn && !attrs.secure)) {
> +        if (!gic_has_groups(s) || (gic_cpu_ns_access(s, cpu, attrs))) {

Ditto.

>              return MEMTX_OK;
>          }
>          s->nsapr[regno][cpu] = value;
>          break;
>      }
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
