Received: from eggs.gnu.org ([2001:4830:134:3::10]:54468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1ddnol-00069d-Me
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 21:23:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1ddnok-0001Ov-Kq
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 21:23:51 -0400
Date: Sat, 5 Aug 2017 03:23:43 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20170805012343.GC4859@toto>
References: <1501867249-1924-1-git-send-email-peter.maydell@linaro.org>
	<1501867249-1924-5-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1501867249-1924-5-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 4/8] boards.h: Define new flag
 ignore_memory_transaction_failures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, patches@linaro.org

On Fri, Aug 04, 2017 at 06:20:45PM +0100, Peter Maydell wrote:
> Define a new MachineClass field ignore_memory_transaction_failures.
> If this is flag is true then the CPU will ignore memory transaction
> failures which should cause the CPU to take an exception due to an
> access to an unassigned physical address; the transaction will
> instead return zero (for a read) or be ignored (for a write).  This
> should be set only by legacy board models which rely on the old
> RAZ/WI behaviour for handling devices that QEMU does not yet model.
> New board models should instead use "unimplemented-device" for all
> memory ranges where the guest will attempt to probe for a device that
> QEMU doesn't implement and a stub device is required.
> 
> We need this for ARM boards, where we're about to implement support for
> generating external aborts on memory transaction failures. Too many
> of our legacy board models rely on the RAZ/WI behaviour and we
> would break currently working guests when their "probe for device"
> code provoked an external abort rather than a RAZ.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> ---
>  include/hw/boards.h | 11 +++++++++++
>  include/qom/cpu.h   |  7 ++++++-
>  qom/cpu.c           |  7 +++++++
>  3 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 3363dd1..7f044d1 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -131,6 +131,16 @@ typedef struct {
>   *    size than the target architecture's minimum. (Attempting to create
>   *    such a CPU will fail.) Note that changing this is a migration
>   *    compatibility break for the machine.
> + * @ignore_memory_transaction_failures:
> + *    If this is flag is true then the CPU will ignore memory transaction
> + *    failures which should cause the CPU to take an exception due to an
> + *    access to an unassigned physical address; the transaction will instead
> + *    return zero (for a read) or be ignored (for a write). This should be
> + *    set only by legacy board models which rely on the old RAZ/WI behaviour
> + *    for handling devices that QEMU does not yet model. New board models
> + *    should instead use "unimplemented-device" for all memory ranges where
> + *    the guest will attempt to probe for a device that QEMU doesn't
> + *    implement and a stub device is required.
>   */
>  struct MachineClass {
>      /*< private >*/
> @@ -171,6 +181,7 @@ struct MachineClass {
>      bool rom_file_has_mr;
>      int minimum_page_bits;
>      bool has_hotpluggable_cpus;
> +    bool ignore_memory_transaction_failures;
>      int numa_mem_align_shift;
>      void (*numa_auto_assign_ram)(MachineClass *mc, NodeInfo *nodes,
>                                   int nb_nodes, ram_addr_t size);
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index fc54d55..8cff86f 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -311,6 +311,9 @@ struct qemu_work_item;
>   * @trace_dstate_delayed: Delayed changes to trace_dstate (includes all changes
>   *                        to @trace_dstate).
>   * @trace_dstate: Dynamic tracing state of events for this vCPU (bitmask).
> + * @ignore_memory_transaction_failures: Cached copy of the MachineState
> + *    flag of the same name: allows the board to suppress calling of the
> + *    CPU do_transaction_failed hook function.
>   *
>   * State of one CPU core or thread.
>   */
> @@ -397,6 +400,8 @@ struct CPUState {
>       */
>      bool throttle_thread_scheduled;
>  
> +    bool ignore_memory_transaction_failures;
> +
>      /* Note that this is accessed at the start of every TB via a negative
>         offset from AREG0.  Leave this field at the end so as to make the
>         (absolute value) offset as small as possible.  This reduces code
> @@ -853,7 +858,7 @@ static inline void cpu_transaction_failed(CPUState *cpu, hwaddr physaddr,
>  {
>      CPUClass *cc = CPU_GET_CLASS(cpu);
>  
> -    if (cc->do_transaction_failed) {
> +    if (!cpu->ignore_memory_transaction_failures && cc->do_transaction_failed) {
>          cc->do_transaction_failed(cpu, physaddr, addr, size, access_type,
>                                    mmu_idx, attrs, response, retaddr);
>      }
> diff --git a/qom/cpu.c b/qom/cpu.c
> index 4f38db0..d8dcf64 100644
> --- a/qom/cpu.c
> +++ b/qom/cpu.c
> @@ -29,6 +29,7 @@
>  #include "exec/cpu-common.h"
>  #include "qemu/error-report.h"
>  #include "sysemu/sysemu.h"
> +#include "hw/boards.h"
>  #include "hw/qdev-properties.h"
>  #include "trace-root.h"
>  
> @@ -360,6 +361,12 @@ static void cpu_common_parse_features(const char *typename, char *features,
>  static void cpu_common_realizefn(DeviceState *dev, Error **errp)
>  {
>      CPUState *cpu = CPU(dev);
> +    Object *machine = qdev_get_machine();
> +    ObjectClass *oc = object_get_class(machine);
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +
> +    cpu->ignore_memory_transaction_failures =
> +        mc->ignore_memory_transaction_failures;
>  
>      if (dev->hotplugged) {
>          cpu_synchronize_post_init(cpu);
> -- 
> 2.7.4
> 
> 
