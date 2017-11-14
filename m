Received: from eggs.gnu.org ([2001:4830:134:3::10]:36359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1eEPrh-0004jT-8w
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 20:18:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1eEPrc-0004tz-7E
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 20:18:13 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:19956
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1eEPrb-0004rl-E5
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 20:18:08 -0500
References: <1509074154-25109-1-git-send-email-douly.fnst@cn.fujitsu.com>
	<20171114010417-mutt-send-email-mst@kernel.org>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <e9dcc419-f59e-c095-e833-94dae386e37c@cn.fujitsu.com>
Date: Tue, 14 Nov 2017 09:17:53 +0800
MIME-Version: 1.0
In-Reply-To: <20171114010417-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5] NUMA: Enable adding NUMA node implicitly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair23@gmail.com>, f4bug@amsat.org, Takao Indoh <indou.takao@jp.fujitsu.com>, Izumi Taku <izumi.taku@jp.fujitsu.com>

Hi Michael,

[...]
> Seems to cause build failures:
> /scm/qemu/numa.c:452:13: error: too many arguments to function ‘parse_numa_node’
>              parse_numa_node(ms, &node, NULL, NULL);
>

Yes, commit

   cc001888b780 ("numa: fixup parsed NumaNodeOptions earlier")

removed a argument from the function recently.

I will rebase this patch.

Thanks,
	dou.

>
>> ---
>> changelog V4 --> V5:
>>
>>   - Avoid calling qemu_opts_parse*()
>>   - Add a new NUMA node by calling parse_numa_node() directly
>>   - Remove the redundant argument in parse_numa_opts()
>>
>> These all were suggested by Eduardo.
>>
>> ---
>>  hw/i386/pc.c        |  1 +
>>  hw/i386/pc_piix.c   |  1 +
>>  hw/i386/pc_q35.c    |  1 +
>>  include/hw/boards.h |  1 +
>>  numa.c              | 21 ++++++++++++++++++++-
>>  vl.c                |  3 +--
>>  6 files changed, 25 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>> index 8e307f7..ec4eb97 100644
>> --- a/hw/i386/pc.c
>> +++ b/hw/i386/pc.c
>> @@ -2325,6 +2325,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
>>      mc->cpu_index_to_instance_props = pc_cpu_index_to_props;
>>      mc->get_default_cpu_node_id = pc_get_default_cpu_node_id;
>>      mc->possible_cpu_arch_ids = pc_possible_cpu_arch_ids;
>> +    mc->auto_enable_numa_with_memhp = true;
>>      mc->has_hotpluggable_cpus = true;
>>      mc->default_boot_order = "cad";
>>      mc->hot_add_cpu = pc_hot_add_cpu;
>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>> index f79d5cb..5e47528 100644
>> --- a/hw/i386/pc_piix.c
>> +++ b/hw/i386/pc_piix.c
>> @@ -446,6 +446,7 @@ static void pc_i440fx_2_10_machine_options(MachineClass *m)
>>      m->is_default = 0;
>>      m->alias = NULL;
>>      SET_MACHINE_COMPAT(m, PC_COMPAT_2_10);
>> +    m->auto_enable_numa_with_memhp = false;
>>  }
>>
>>  DEFINE_I440FX_MACHINE(v2_10, "pc-i440fx-2.10", NULL,
>> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
>> index da3ea60..d606004 100644
>> --- a/hw/i386/pc_q35.c
>> +++ b/hw/i386/pc_q35.c
>> @@ -318,6 +318,7 @@ static void pc_q35_2_10_machine_options(MachineClass *m)
>>      m->alias = NULL;
>>      SET_MACHINE_COMPAT(m, PC_COMPAT_2_10);
>>      m->numa_auto_assign_ram = numa_legacy_auto_assign_ram;
>> +    m->auto_enable_numa_with_memhp = false;
>>  }
>>
>>  DEFINE_Q35_MACHINE(v2_10, "pc-q35-2.10", NULL,
>> diff --git a/include/hw/boards.h b/include/hw/boards.h
>> index 191a5b3..f1077f1 100644
>> --- a/include/hw/boards.h
>> +++ b/include/hw/boards.h
>> @@ -192,6 +192,7 @@ struct MachineClass {
>>      bool ignore_memory_transaction_failures;
>>      int numa_mem_align_shift;
>>      const char **valid_cpu_types;
>> +    bool auto_enable_numa_with_memhp;
>>      void (*numa_auto_assign_ram)(MachineClass *mc, NodeInfo *nodes,
>>                                   int nb_nodes, ram_addr_t size);
>>
>> diff --git a/numa.c b/numa.c
>> index 100a67f..4d12f30 100644
>> --- a/numa.c
>> +++ b/numa.c
>> @@ -221,6 +221,7 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
>>      }
>>      numa_info[nodenr].present = true;
>>      max_numa_nodeid = MAX(max_numa_nodeid, nodenr + 1);
>> +    nb_numa_nodes++;
>>  }
>>
>>  static void parse_numa_distance(NumaDistOptions *dist, Error **errp)
>> @@ -281,7 +282,6 @@ static int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
>>          if (err) {
>>              goto end;
>>          }
>> -        nb_numa_nodes++;
>>          break;
>>      case NUMA_OPTIONS_TYPE_DIST:
>>          parse_numa_distance(&object->u.dist, &err);
>> @@ -432,6 +432,25 @@ void parse_numa_opts(MachineState *ms)
>>          exit(1);
>>      }
>>
>> +    /*
>> +     * If memory hotplug is enabled (slots > 0) but without '-numa'
>> +     * options explicitly on CLI, guestes will break.
>> +     *
>> +     *   Windows: won't enable memory hotplug without SRAT table at all
>> +     *
>> +     *   Linux: if QEMU is started with initial memory all below 4Gb
>> +     *   and no SRAT table present, guest kernel will use nommu DMA ops,
>> +     *   which breaks 32bit hw drivers when memory is hotplugged and
>> +     *   guest tries to use it with that drivers.
>> +     *
>> +     * Enable NUMA implicitly by adding a new NUMA node automatically.
>> +     */
>> +    if (ms->ram_slots > 0 && nb_numa_nodes == 0 &&
>> +        mc->auto_enable_numa_with_memhp) {
>> +            NumaNodeOptions node = { };
>> +            parse_numa_node(ms, &node, NULL, NULL);
>> +    }
>> +
>>      assert(max_numa_nodeid <= MAX_NODES);
>>
>>      /* No support for sparse NUMA node IDs yet: */
>> diff --git a/vl.c b/vl.c
>> index ec29909..be332d1 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -4675,8 +4675,6 @@ int main(int argc, char **argv, char **envp)
>>      default_drive(default_floppy, snapshot, IF_FLOPPY, 0, FD_OPTS);
>>      default_drive(default_sdcard, snapshot, IF_SD, 0, SD_OPTS);
>>
>> -    parse_numa_opts(current_machine);
>> -
>>      if (qemu_opts_foreach(qemu_find_opts("mon"),
>>                            mon_init_func, NULL, NULL)) {
>>          exit(1);
>> @@ -4726,6 +4724,7 @@ int main(int argc, char **argv, char **envp)
>>      current_machine->boot_order = boot_order;
>>      current_machine->cpu_model = cpu_model;
>>
>> +    parse_numa_opts(current_machine);
>>
>>      /* parse features once if machine provides default cpu_type */
>>      if (machine_class->default_cpu_type) {
>> --
>> 2.5.5
>>
>>
>
>
>
