Received: from eggs.gnu.org ([2001:4830:134:3::10]:50502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e7d83-0004FB-04
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 04:03:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e7d7z-0006Lm-4D
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 04:03:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41458)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e7d7y-0006KC-MM
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 04:02:59 -0400
Date: Thu, 26 Oct 2017 10:02:45 +0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171026080245.GA26955@localhost.localdomain>
References: <1508722422-3861-1-git-send-email-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1508722422-3861-1-git-send-email-douly.fnst@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH v4] NUMA: Enable adding NUMA node implicitly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Takao Indoh <indou.takao@jp.fujitsu.com>, "Michael S. Tsirkin" <mst@redhat.com>, Izumi Taku <izumi.taku@jp.fujitsu.com>, David Hildenbrand <david@redhat.com>, f4bug@amsat.org, Alistair Francis <alistair23@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Hi,

Sorry for taking so long to review it:

On Mon, Oct 23, 2017 at 09:33:42AM +0800, Dou Liyang wrote:
> Linux and Windows need ACPI SRAT table to make memory hotplug work properly,
> however currently QEMU doesn't create SRAT table if numa options aren't present
> on CLI.
> 
> Which breaks both linux and windows guests in certain conditions:
>  * Windows: won't enable memory hotplug without SRAT table at all
>  * Linux: if QEMU is started with initial memory all below 4Gb and no SRAT table
>    present, guest kernel will use nommu DMA ops, which breaks 32bit hw drivers
>    when memory is hotplugged and guest tries to use it with that drivers.
> 
> Fix above issues by automatically creating a numa node when QEMU is started with
> memory hotplug enabled but without '-numa' options on CLI.
> (PS: auto-create numa node only for new machine types so not to break migration).
> 
> Which would provide SRAT table to guests without explicit -numa options on CLI
> and would allow:
>  * Windows: to enable memory hotplug
>  * Linux: switch to SWIOTLB DMA ops, to bounce DMA transfers to 32bit allocated
>    buffers that legacy drivers/hw can handle.
> 
> [Rewritten by Igor]
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
> ---
[...]
> diff --git a/numa.c b/numa.c
> index 100a67f..ba8d813 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -423,12 +423,32 @@ void numa_default_auto_assign_ram(MachineClass *mc, NodeInfo *nodes,
>      nodes[i].node_mem = size - usedmem;
>  }
>  
> -void parse_numa_opts(MachineState *ms)
> +void parse_numa_opts(MachineState *ms, uint64_t ram_slots)
>  {
>      int i;
>      MachineClass *mc = MACHINE_GET_CLASS(ms);
> +    QemuOptsList *numa_opts = qemu_find_opts("numa");
>  
> -    if (qemu_opts_foreach(qemu_find_opts("numa"), parse_numa, ms, NULL)) {
> +    /*
> +     * If memory hotplug is enabled (slots > 0) but without '-numa'
> +     * options explicitly on CLI, guestes will break.
> +     *
> +     *   Windows: won't enable memory hotplug without SRAT table at all
> +     *
> +     *   Linux: if QEMU is started with initial memory all below 4Gb
> +     *   and no SRAT table present, guest kernel will use nommu DMA ops,
> +     *   which breaks 32bit hw drivers when memory is hotplugged and
> +     *   guest tries to use it with that drivers.
> +     *
> +     * Enable NUMA implicitly by adding a new NUMA node automatically.
> +     */
> +    if (ram_slots > 0 && QTAILQ_EMPTY(&numa_opts->head)) {
> +        if (mc->auto_enable_numa_with_memhp) {

If you move the code after qemu_opts_foreach(), you could just
check if nb_numa_nodes is 0 instead of peeking at
numa_opts->head.


> +            qemu_opts_parse_noisily(numa_opts, "node", true);
> +        }
> +    }

Calling qemu_opts_parse*() has additional user-visible side
effects (it can make -writeconfig include the new option,
depending on the initialization ordering).  Affecting QemuOpts
depending on the machine-type breaks the separation between
machine configuration from machine initialization, so I would
like to avoid it.

We could simply call parse_numa_node() (after making it increment
nb_numa_nodes automatically).

e.g.:


diff --git a/numa.c b/numa.c
index 8d78d959f6..da18e42ce7 100644
--- a/numa.c
+++ b/numa.c
@@ -216,6 +216,7 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
     }
     numa_info[nodenr].present = true;
     max_numa_nodeid = MAX(max_numa_nodeid, nodenr + 1);
+    nb_numa_nodes++;
 }
 
 static void parse_numa_distance(NumaDistOptions *dist, Error **errp)
@@ -282,7 +283,6 @@ static int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
         if (err) {
             goto end;
         }
-        nb_numa_nodes++;
         break;
     case NUMA_OPTIONS_TYPE_DIST:
         parse_numa_distance(&object->u.dist, &err);
@@ -433,6 +433,26 @@ void parse_numa_opts(MachineState *ms)
         exit(1);
     }
 
+    /*
+     * If memory hotplug is enabled (slots > 0) but without '-numa'
+     * options explicitly on CLI, guestes will break.
+     *
+     *   Windows: won't enable memory hotplug without SRAT table at all
+     *
+     *   Linux: if QEMU is started with initial memory all below 4Gb
+     *   and no SRAT table present, guest kernel will use nommu DMA ops,
+     *   which breaks 32bit hw drivers when memory is hotplugged and
+     *   guest tries to use it with that drivers.
+     *
+     * Enable NUMA implicitly by adding a new NUMA node automatically.
+     */
+    if (ms->ram_slots > 0 && nb_numa_nodes == 0 &&
+        mc->auto_enable_numa_with_memhp) {
+        NumaNodeOptions node = { };
+        parse_numa_node(ms, &node, &error_abort);
+    }
+
+
     assert(max_numa_nodeid <= MAX_NODES);
 
     /* No support for sparse NUMA node IDs yet: */

> +
> +    if (qemu_opts_foreach(numa_opts, parse_numa, ms, NULL)) {
>          exit(1);
>      }
>  
> diff --git a/vl.c b/vl.c
> index 0723835..516d0c9 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4677,8 +4677,6 @@ int main(int argc, char **argv, char **envp)
>      default_drive(default_floppy, snapshot, IF_FLOPPY, 0, FD_OPTS);
>      default_drive(default_sdcard, snapshot, IF_SD, 0, SD_OPTS);
>  
> -    parse_numa_opts(current_machine);
> -
>      if (qemu_opts_foreach(qemu_find_opts("mon"),
>                            mon_init_func, NULL, NULL)) {
>          exit(1);
> @@ -4728,6 +4726,7 @@ int main(int argc, char **argv, char **envp)
>      current_machine->boot_order = boot_order;
>      current_machine->cpu_model = cpu_model;
>  
> +    parse_numa_opts(current_machine, ram_slots);

Why did you add a ram_slots argument if it's already present at
current_machine->ram_slots?

>  
>      /* parse features once if machine provides default cpu_type */
>      if (machine_class->default_cpu_type) {
> -- 
> 2.5.5
> 
> 
> 
> 

-- 
Eduardo
