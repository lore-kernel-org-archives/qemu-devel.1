Received: from eggs.gnu.org ([2001:4830:134:3::10]:51039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1e7uv5-0007R8-Tz
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 23:02:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1e7uv0-0001wv-Vl
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 23:02:51 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:52370
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1e7uv0-0001vd-2v
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 23:02:46 -0400
References: <1508722422-3861-1-git-send-email-douly.fnst@cn.fujitsu.com>
	<20171026080245.GA26955@localhost.localdomain>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <7d39acb9-1c1b-ff55-be1f-b250735e3872@cn.fujitsu.com>
Date: Fri, 27 Oct 2017 11:02:31 +0800
MIME-Version: 1.0
In-Reply-To: <20171026080245.GA26955@localhost.localdomain>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4] NUMA: Enable adding NUMA node implicitly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Takao Indoh <indou.takao@jp.fujitsu.com>, "Michael S. Tsirkin" <mst@redhat.com>, Izumi Taku <izumi.taku@jp.fujitsu.com>, David Hildenbrand <david@redhat.com>, f4bug@amsat.org, Alistair Francis <alistair23@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

Deer Eduardo,

At 10/26/2017 04:02 PM, Eduardo Habkost wrote:
> Hi,
>
> Sorry for taking so long to review it:

Not matter. It's my honor!

>
> On Mon, Oct 23, 2017 at 09:33:42AM +0800, Dou Liyang wrote:

[...]

>> +     */
>> +    if (ram_slots > 0 && QTAILQ_EMPTY(&numa_opts->head)) {
>> +        if (mc->auto_enable_numa_with_memhp) {
>
> If you move the code after qemu_opts_foreach(), you could just
> check if nb_numa_nodes is 0 instead of peeking at
> numa_opts->head.
>
>
>> +            qemu_opts_parse_noisily(numa_opts, "node", true);
>> +        }
>> +    }
>
> Calling qemu_opts_parse*() has additional user-visible side
> effects (it can make -writeconfig include the new option,
> depending on the initialization ordering).  Affecting QemuOpts
> depending on the machine-type breaks the separation between
> machine configuration from machine initialization, so I would
> like to avoid it.
>
Yes, Indeed. Thank you so much for kind explanation!

> We could simply call parse_numa_node() (after making it increment
> nb_numa_nodes automatically).
>

Yes, I will use it in the next version.

> e.g.:
>
>
> diff --git a/numa.c b/numa.c
> index 8d78d959f6..da18e42ce7 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -216,6 +216,7 @@ static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
>      }
>      numa_info[nodenr].present = true;
>      max_numa_nodeid = MAX(max_numa_nodeid, nodenr + 1);
> +    nb_numa_nodes++;
>  }
>
>  static void parse_numa_distance(NumaDistOptions *dist, Error **errp)
> @@ -282,7 +283,6 @@ static int parse_numa(void *opaque, QemuOpts *opts, Error **errp)
>          if (err) {
>              goto end;
>          }
> -        nb_numa_nodes++;
>          break;
>      case NUMA_OPTIONS_TYPE_DIST:
>          parse_numa_distance(&object->u.dist, &err);
> @@ -433,6 +433,26 @@ void parse_numa_opts(MachineState *ms)
>          exit(1);
>      }
>
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
> +    if (ms->ram_slots > 0 && nb_numa_nodes == 0 &&
> +        mc->auto_enable_numa_with_memhp) {
> +        NumaNodeOptions node = { };
> +        parse_numa_node(ms, &node, &error_abort);
> +    }
> +
> +
>      assert(max_numa_nodeid <= MAX_NODES);
>
>      /* No support for sparse NUMA node IDs yet: */
>
>> +
>> +    if (qemu_opts_foreach(numa_opts, parse_numa, ms, NULL)) {
>>          exit(1);
>>      }
>>
>> diff --git a/vl.c b/vl.c
>> index 0723835..516d0c9 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -4677,8 +4677,6 @@ int main(int argc, char **argv, char **envp)
>>      default_drive(default_floppy, snapshot, IF_FLOPPY, 0, FD_OPTS);
>>      default_drive(default_sdcard, snapshot, IF_SD, 0, SD_OPTS);
>>
>> -    parse_numa_opts(current_machine);
>> -
>>      if (qemu_opts_foreach(qemu_find_opts("mon"),
>>                            mon_init_func, NULL, NULL)) {
>>          exit(1);
>> @@ -4728,6 +4726,7 @@ int main(int argc, char **argv, char **envp)
>>      current_machine->boot_order = boot_order;
>>      current_machine->cpu_model = cpu_model;
>>
>> +    parse_numa_opts(current_machine, ram_slots);
>
> Why did you add a ram_slots argument if it's already present at
> current_machine->ram_slots?

Oops, Forgot to update it after moving it behind the setup of
current_machine. will remove the redundant ram_slots argument.

Thanks,
	dou
>
>>
>>      /* parse features once if machine provides default cpu_type */
>>      if (machine_class->default_cpu_type) {
>> --
>> 2.5.5
>>
>>
>>
>>
>
