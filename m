Received: from eggs.gnu.org ([2001:4830:134:3::10]:34566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1d6G6b-0002c4-VY
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:43:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1d6G6b-0001cM-3M
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:43:37 -0400
Date: Thu, 4 May 2017 14:43:27 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20170504124327.kn5jpivkomijohwi@kamzik.brq.redhat.com>
References: <1493816238-33120-1-git-send-email-imammedo@redhat.com>
	<1493816238-33120-21-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1493816238-33120-21-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 20/24] machine: call machine init from
 wrapper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org

On Wed, May 03, 2017 at 02:57:14PM +0200, Igor Mammedov wrote:
> add machine_run_board_init() wrapper that calls machine
> init for now but in follow up patches it will be used
> to run generic machine code that should run before
> machine init.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  include/hw/boards.h | 1 +
>  hw/core/machine.c   | 6 ++++++
>  vl.c                | 2 +-
>  3 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 1f518a1..0e74484 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -32,6 +32,7 @@ void memory_region_allocate_system_memory(MemoryRegion *mr, Object *owner,
>  MachineClass *find_default_machine(void);
>  extern MachineState *current_machine;
>  
> +void machine_run_board_init(MachineState *machine);
>  bool machine_usb(MachineState *machine);
>  bool machine_kernel_irqchip_allowed(MachineState *machine);
>  bool machine_kernel_irqchip_required(MachineState *machine);
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index a63f17b..217b4f4 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -648,6 +648,12 @@ bool machine_mem_merge(MachineState *machine)
>      return machine->mem_merge;
>  }
>  
> +void machine_run_board_init(MachineState *machine)
> +{
> +    MachineClass *machine_class = MACHINE_GET_CLASS(machine);
> +    machine_class->init(machine);
> +}
> +
>  static void machine_class_finalize(ObjectClass *klass, void *data)
>  {
>      MachineClass *mc = MACHINE_CLASS(klass);
> diff --git a/vl.c b/vl.c
> index fe4741d..ac46d6e 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4562,7 +4562,7 @@ int main(int argc, char **argv, char **envp)
>      current_machine->boot_order = boot_order;
>      current_machine->cpu_model = cpu_model;
>  
> -    machine_class->init(current_machine);
> +    machine_run_board_init(current_machine);
>  
>      realtime_init();
>  
> -- 
> 2.7.4
>

Reviewed-by: Andrew Jones <drjones@redhat.com> 
