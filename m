Received: from eggs.gnu.org ([2001:4830:134:3::10]:38386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dsmBQ-0007GP-Eo
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:41:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dsmBN-0002d8-Af
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:41:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42200)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dsmBN-0002cw-1S
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:41:05 -0400
Date: Fri, 15 Sep 2017 09:40:44 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170915084044.GE13610@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1505464398-28897-1-git-send-email-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1505464398-28897-1-git-send-email-douly.fnst@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [RFC PATCH] NUMA: Enable adding NUMA node
 implicitly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Takao Indoh <indou.takao@jp.fujitsu.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Izumi Taku <izumi.taku@jp.fujitsu.com>, David Hildenbrand <david@redhat.com>, f4bug@amsat.org, Alistair Francis <alistair23@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Fri, Sep 15, 2017 at 04:33:18PM +0800, Dou Liyang wrote:
> In QEMU, if we enable NUMA and have nodes, QEMU will build ACPI SRAT table
> for transfering NUMA configuration to the guest. So, the maximum memory in
> SRAT can be used to determine whether to use the swiotlb for IOMMU or not.
> 
> However, if QEmu doesn't enable NUMA explicitly on CLI, The SRAT will
> never be built. When memory hotplug is enabled, some guest's devices may
> start failing due to SWIOTLB is disabled.
> 
> Add numa_implicit_add_node0 in struct MachineClass, Invoke it before QEMU
> parse NUMA options to enable adding NUMA node implicitly.
> 
> Reported-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Alistair Francis <alistair23@gmail.com>
> Cc: f4bug@amsat.org
> Cc: Takao Indoh <indou.takao@jp.fujitsu.com>
> Cc: Izumi Taku <izumi.taku@jp.fujitsu.com>
> 
> ---
>  hw/i386/pc.c        |  6 ++++++
>  include/hw/boards.h |  4 ++++
>  vl.c                | 14 ++++++++++++++
>  3 files changed, 24 insertions(+)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 2108104..3c40117 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -2308,6 +2308,11 @@ static const CPUArchIdList *pc_possible_cpu_arch_ids(MachineState *ms)
>      return ms->possible_cpus;
>  }
>  
> +static void numa_implicit_add_node0(void)
> +{
> +    qemu_opts_parse_noisily(qemu_find_opts("numa"), "node", true);
> +}
> +
>  static void x86_nmi(NMIState *n, int cpu_index, Error **errp)
>  {
>      /* cpu index isn't used */
> @@ -2349,6 +2354,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
>      mc->get_hotplug_handler = pc_get_hotpug_handler;
>      mc->cpu_index_to_instance_props = pc_cpu_index_to_props;
>      mc->possible_cpu_arch_ids = pc_possible_cpu_arch_ids;
> +    mc->numa_implicit_add_node0 = numa_implicit_add_node0;
>      mc->has_hotpluggable_cpus = true;
>      mc->default_boot_order = "cad";
>      mc->hot_add_cpu = pc_hot_add_cpu;
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 7f044d1..898d841 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -141,6 +141,8 @@ typedef struct {
>   *    should instead use "unimplemented-device" for all memory ranges where
>   *    the guest will attempt to probe for a device that QEMU doesn't
>   *    implement and a stub device is required.
> + * @numa_implicit_add_node0:
> + *    Enable NUMA implicitly by add a NUMA node.
>   */
>  struct MachineClass {
>      /*< private >*/
> @@ -191,6 +193,8 @@ struct MachineClass {
>      CpuInstanceProperties (*cpu_index_to_instance_props)(MachineState *machine,
>                                                           unsigned cpu_index);
>      const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *machine);
> +
> +    void (*numa_implicit_add_node0)(void);
>  };
>  
>  /**
> diff --git a/vl.c b/vl.c
> index fb1f05b..814a5fa 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -3030,6 +3030,7 @@ int main(int argc, char **argv, char **envp)
>      Error *main_loop_err = NULL;
>      Error *err = NULL;
>      bool list_data_dirs = false;
> +    bool has_numa_config_in_CLI = false;
>      typedef struct BlockdevOptions_queue {
>          BlockdevOptions *bdo;
>          Location loc;
> @@ -3293,6 +3294,7 @@ int main(int argc, char **argv, char **envp)
>                  if (!opts) {
>                      exit(1);
>                  }
> +                has_numa_config_in_CLI = true;
>                  break;
>              case QEMU_OPTION_display:
>                  display_type = select_display(optarg);
> @@ -4585,6 +4587,18 @@ int main(int argc, char **argv, char **envp)
>      default_drive(default_floppy, snapshot, IF_FLOPPY, 0, FD_OPTS);
>      default_drive(default_sdcard, snapshot, IF_SD, 0, SD_OPTS);
>  
> +    /*
> +     * If memory hotplug is enabled i.e. slots > 0 and user hasn't add
> +     * NUMA nodes explicitly on CLI
> +     *
> +     * Enable NUMA implicitly for guest to know the maximum memory
> +     * from ACPI SRAT table, which is used for SWIOTLB.
> +     */
> +    if (ram_slots > 0 && !has_numa_config_in_CLI) {
> +        if (machine_class->numa_implicit_add_node0) {
> +            machine_class->numa_implicit_add_node0();
> +        }
> +    }

Won't this change guest ABI and so break migration/save/restore ?

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
