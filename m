Received: from eggs.gnu.org ([2001:4830:134:3::10]:51024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dtn9M-0003QZ-Kp
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 23:55:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dtn9J-00060q-Iu
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 23:55:12 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:53564
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dtn9I-0005xL-Ma
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 23:55:09 -0400
References: <1505464398-28897-1-git-send-email-douly.fnst@cn.fujitsu.com>
	<20170915084044.GE13610@redhat.com>
	<dc424e80-bd13-576a-314b-716b906538b8@cn.fujitsu.com>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <7103711f-5ab5-0a8f-48d1-bb088df2fb13@cn.fujitsu.com>
Date: Mon, 18 Sep 2017 11:54:50 +0800
MIME-Version: 1.0
In-Reply-To: <dc424e80-bd13-576a-314b-716b906538b8@cn.fujitsu.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Takao Indoh <indou.takao@jp.fujitsu.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Izumi Taku <izumi.taku@jp.fujitsu.com>, David Hildenbrand <david@redhat.com>, f4bug@amsat.org, Alistair Francis <alistair23@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

At 09/15/2017 06:05 PM, Dou Liyang wrote:
> Hi Daniel,
>
> At 09/15/2017 04:40 PM, Daniel P. Berrange wrote:
>> On Fri, Sep 15, 2017 at 04:33:18PM +0800, Dou Liyang wrote:
>>> In QEMU, if we enable NUMA and have nodes, QEMU will build ACPI SRAT
>>> table
>>> for transfering NUMA configuration to the guest. So, the maximum
>>> memory in
>>> SRAT can be used to determine whether to use the swiotlb for IOMMU or
>>> not.
>>>
>>> However, if QEmu doesn't enable NUMA explicitly on CLI, The SRAT will
>>> never be built. When memory hotplug is enabled, some guest's devices may
>>> start failing due to SWIOTLB is disabled.
>>>
>>> Add numa_implicit_add_node0 in struct MachineClass, Invoke it before
>>> QEMU
>>> parse NUMA options to enable adding NUMA node implicitly.
>>>
>>> Reported-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
>>> Suggested-by: Igor Mammedov <imammedo@redhat.com>
>>> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>> Cc: Richard Henderson <rth@twiddle.net>
>>> Cc: Eduardo Habkost <ehabkost@redhat.com>
>>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>>> Cc: Marcel Apfelbaum <marcel@redhat.com>
>>> Cc: Igor Mammedov <imammedo@redhat.com>
>>> Cc: David Hildenbrand <david@redhat.com>
>>> Cc: Thomas Huth <thuth@redhat.com>
>>> Cc: Alistair Francis <alistair23@gmail.com>
>>> Cc: f4bug@amsat.org
>>> Cc: Takao Indoh <indou.takao@jp.fujitsu.com>
>>> Cc: Izumi Taku <izumi.taku@jp.fujitsu.com>
>>>
>>> ---
>>>  hw/i386/pc.c        |  6 ++++++
>>>  include/hw/boards.h |  4 ++++
>>>  vl.c                | 14 ++++++++++++++
>>>  3 files changed, 24 insertions(+)
>>>
>>> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
>>> index 2108104..3c40117 100644
>>> --- a/hw/i386/pc.c
>>> +++ b/hw/i386/pc.c
>>> @@ -2308,6 +2308,11 @@ static const CPUArchIdList
>>> *pc_possible_cpu_arch_ids(MachineState *ms)
>>>      return ms->possible_cpus;
>>>  }
>>>
>>> +static void numa_implicit_add_node0(void)
>>> +{
>>> +    qemu_opts_parse_noisily(qemu_find_opts("numa"), "node", true);
>>> +}
>>> +
>>>  static void x86_nmi(NMIState *n, int cpu_index, Error **errp)
>>>  {
>>>      /* cpu index isn't used */
>>> @@ -2349,6 +2354,7 @@ static void pc_machine_class_init(ObjectClass
>>> *oc, void *data)
>>>      mc->get_hotplug_handler = pc_get_hotpug_handler;
>>>      mc->cpu_index_to_instance_props = pc_cpu_index_to_props;
>>>      mc->possible_cpu_arch_ids = pc_possible_cpu_arch_ids;
>>> +    mc->numa_implicit_add_node0 = numa_implicit_add_node0;
>>>      mc->has_hotpluggable_cpus = true;
>>>      mc->default_boot_order = "cad";
>>>      mc->hot_add_cpu = pc_hot_add_cpu;
>>> diff --git a/include/hw/boards.h b/include/hw/boards.h
>>> index 7f044d1..898d841 100644
>>> --- a/include/hw/boards.h
>>> +++ b/include/hw/boards.h
>>> @@ -141,6 +141,8 @@ typedef struct {
>>>   *    should instead use "unimplemented-device" for all memory
>>> ranges where
>>>   *    the guest will attempt to probe for a device that QEMU doesn't
>>>   *    implement and a stub device is required.
>>> + * @numa_implicit_add_node0:
>>> + *    Enable NUMA implicitly by add a NUMA node.
>>>   */
>>>  struct MachineClass {
>>>      /*< private >*/
>>> @@ -191,6 +193,8 @@ struct MachineClass {
>>>      CpuInstanceProperties
>>> (*cpu_index_to_instance_props)(MachineState *machine,
>>>                                                           unsigned
>>> cpu_index);
>>>      const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState
>>> *machine);
>>> +
>>> +    void (*numa_implicit_add_node0)(void);
>>>  };
>>>
>>>  /**
>>> diff --git a/vl.c b/vl.c
>>> index fb1f05b..814a5fa 100644
>>> --- a/vl.c
>>> +++ b/vl.c
>>> @@ -3030,6 +3030,7 @@ int main(int argc, char **argv, char **envp)
>>>      Error *main_loop_err = NULL;
>>>      Error *err = NULL;
>>>      bool list_data_dirs = false;
>>> +    bool has_numa_config_in_CLI = false;
>>>      typedef struct BlockdevOptions_queue {
>>>          BlockdevOptions *bdo;
>>>          Location loc;
>>> @@ -3293,6 +3294,7 @@ int main(int argc, char **argv, char **envp)
>>>                  if (!opts) {
>>>                      exit(1);
>>>                  }
>>> +                has_numa_config_in_CLI = true;
>>>                  break;
>>>              case QEMU_OPTION_display:
>>>                  display_type = select_display(optarg);
>>> @@ -4585,6 +4587,18 @@ int main(int argc, char **argv, char **envp)
>>>      default_drive(default_floppy, snapshot, IF_FLOPPY, 0, FD_OPTS);
>>>      default_drive(default_sdcard, snapshot, IF_SD, 0, SD_OPTS);
>>>
>>> +    /*
>>> +     * If memory hotplug is enabled i.e. slots > 0 and user hasn't add
>>> +     * NUMA nodes explicitly on CLI
>>> +     *
>>> +     * Enable NUMA implicitly for guest to know the maximum memory
>>> +     * from ACPI SRAT table, which is used for SWIOTLB.
>>> +     */
>>> +    if (ram_slots > 0 && !has_numa_config_in_CLI) {
>>> +        if (machine_class->numa_implicit_add_node0) {
>>> +            machine_class->numa_implicit_add_node0();
>>> +        }
>>> +    }
>>
>> Won't this change guest ABI

Hi Daniel,

No, this will change the ACPI table in following case without NUMA
configuration:

...
-m 128M,slots=4,maxmem=1G
...

How about fixing it by adding

m->numa_implicit_add_node0 = NULL;

in pc_i440fx/q35_2_10_machine_options() ?


  and so break migration/save/restore ?

I did some tests(save/restore), this don't break migration.

Are some situations I didn't consider ?


Thanks,
	dou.
>>
> Thank you for your reply, I can't answer this immediately, I will
> look into it and reply you soon.
>
> This patch works for X86, has no influence on other arch, and we
> can regard it's functionality as "-numa node" in CLI.
>
> Thanks,
>     dou.
>
>
>> Regards,
>> Daniel
>>
