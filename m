Received: from eggs.gnu.org ([2001:4830:134:3::10]:50017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eBrzr-0001M6-A2
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 19:44:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eBrzq-0001Pb-5O
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 19:44:07 -0500
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20171106201332.GA2152@flamenco>
References: <1509734853-3014-1-git-send-email-cota@braap.org>
	<20171103185610.GA3907@flamenco>
	<20171103200233.GI3111@localhost.localdomain>
	<20171103222407.GA22411@flamenco>
	<20171106141022.GO3111@localhost.localdomain>
	<20171106201332.GA2152@flamenco>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Mon, 6 Nov 2017 16:43:34 -0800
Message-ID: <CAKmqyKO41gHX1Y0+rq8wMygf+ZoZLvOJPzqhfviPsgbDGHecsQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw: add .min_cpus and .default_cpus fields
 to machine_class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>

On Mon, Nov 6, 2017 at 12:13 PM, Emilio G. Cota <cota@braap.org> wrote:
> On Mon, Nov 06, 2017 at 12:10:22 -0200, Eduardo Habkost wrote:
>> IMO, initialization state doesn't belong to CPUClass.  We already
>> have a single accelerator object in MachineState::accelerator,
>> and tcg_initialized could be moved to a AccelState::initialized
>> field.
>
> I don't know how to cleanly get AccelState from a CPUClass pointer
> (as I said I'm not familiar with object code / qom) -- suggestions
> welcome! The best I could come up in the limited time I have for
> this is to use a static bool, as shown below.
>
>
> ---8<---
>
> Subject: [PATCH] qom: move CPUClass.tcg_initialize to a global
>
> 55c3cee ("qom: Introduce CPUClass.tcg_initialize", 2017-10-24)
> introduces a per-CPUClass bool that we check so that the target CPU
> is initialized for TCG only once. This works well except when
> we end up creating more than one CPUClass, in which case we end
> up incorrectly initializing TCG more than once, i.e. once for
> each CPUClass.
>
> This can be replicated with:
>   $ aarch64-softmmu/qemu-system-aarch64 -machine xlnx-zcu102 -smp 6 \
>       -global driver=xlnx,,zynqmp,property=has_rpu,value=on
> In this case the class name of the "RPUs" is prefixed by "cortex-r5-",
> whereas the "regular" CPUs are prefixed by "cortex-a53-". This
> results in two CPUClass instances being created.
>
> Fix it by introducing a static variable, so that only the first
> target CPU being initialized will initialize the target-dependent
> part of TCG, regardless of CPUClass instances.
>
> Fixes: 55c3ceef61fcf06fc98ddc752b7cce788ce7680b
> Signed-off-by: Emilio G. Cota <cota@braap.org>

This works great for me, is this ok to be applied?

Thanks,
Alistair

> ---
>  exec.c            | 5 +++--
>  include/qom/cpu.h | 1 -
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/exec.c b/exec.c
> index 97a24a8..8b579c0 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -792,11 +792,12 @@ void cpu_exec_initfn(CPUState *cpu)
>  void cpu_exec_realizefn(CPUState *cpu, Error **errp)
>  {
>      CPUClass *cc = CPU_GET_CLASS(cpu);
> +    static bool tcg_target_initialized;
>
>      cpu_list_add(cpu);
>
> -    if (tcg_enabled() && !cc->tcg_initialized) {
> -        cc->tcg_initialized = true;
> +    if (tcg_enabled() && !tcg_target_initialized) {
> +        tcg_target_initialized = true;
>          cc->tcg_initialize();
>      }
>
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index fa4b0c9..c2fa151 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -209,7 +209,6 @@ typedef struct CPUClass {
>      /* Keep non-pointer data at the end to minimize holes.  */
>      int gdb_num_core_regs;
>      bool gdb_stop_before_watchpoint;
> -    bool tcg_initialized;
>  } CPUClass;
>
>  #ifdef HOST_WORDS_BIGENDIAN
> --
> 2.7.4
>
>
