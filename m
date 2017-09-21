Received: from eggs.gnu.org ([2001:4830:134:3::10]:55378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dusxc-0005O1-Fh
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 00:19:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dusxZ-0006P1-AY
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 00:19:36 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:1594
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dusxY-0006Lu-Hu
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 00:19:33 -0400
References: <1505464398-28897-1-git-send-email-douly.fnst@cn.fujitsu.com>
	<20170918110846.74476f91@nial.brq.redhat.com>
	<857a7c4c-7593-2365-cee1-7d217be15817@cn.fujitsu.com>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <81826b6c-0b4b-0b06-b354-e07bded5b7cf@cn.fujitsu.com>
Date: Thu, 21 Sep 2017 12:19:17 +0800
MIME-Version: 1.0
In-Reply-To: <857a7c4c-7593-2365-cee1-7d217be15817@cn.fujitsu.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
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
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Takao Indoh <indou.takao@jp.fujitsu.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Izumi Taku <izumi.taku@jp.fujitsu.com>, David Hildenbrand <david@redhat.com>, f4bug@amsat.org, Alistair Francis <alistair23@gmail.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Hi Igor,

I am sorry I missed some comments you gave to me.

my reply is below.
At 09/18/2017 05:24 PM, Dou Liyang wrote:
[...]
>>> ranges where
>>>   *    the guest will attempt to probe for a device that QEMU doesn't
>>>   *    implement and a stub device is required.
>>> + * @numa_implicit_add_node0:
>>> + *    Enable NUMA implicitly by add a NUMA node.
>> how about:
>> s/auto_enable_numa_with_memhp/

Yes, really better than me, will do it.

>> boolean instead, see below how it could improve patch.
>>

I am not really sure why do we want to make this function boolean.

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
>>>      parse_numa_opts(current_machine);
>> it would be better to put this logic inside of parse_numa_opts()
>> I'd suggest to move:
>>
>>     current_machine->ram_size = ram_size;
>>     current_machine->maxram_size = maxram_size;
>>     current_machine->ram_slots = ram_slots;
>>
>> before parse_numa_opts() is called, and then
>> handle 'memhp present+no numa on CLI" logic inside of
>> parse_numa_opts(). With this you won't have to track
>> 'has_numa_config_in_CLI', drop callback numa_implicit_add_node0()
>> and numa nuances would be in place they are supposed to be: numa.c
>>

Is "dropping the callback..." means :

     static void auto_enable_numa_with_memhp(QemuOptsList *list)
     {
         ...
     }

     void parse_numa_opts(MachineState *ms, uint64_t ram_slots)
     {
         QemuOptsList *numa_opts = qemu_find_opts("numa");
         ...
         auto_enable_numa_with_memhp(numa_opts);
         ...
     }

So, No matter what arch it is, if it support NUMA, we will enable NUMA
implicitly when it has already enabled memory hotplug by 
"slot=xx,maxmem=xx" CLI explicitly.

I am not sure that, but this bug only affects x86 as I know, seems no
need to affect other arches which support NUMA as well.

Thanks,
	dou.
>>>
>>>      if (qemu_opts_foreach(qemu_find_opts("mon"),
>>
>>
>>
>>
