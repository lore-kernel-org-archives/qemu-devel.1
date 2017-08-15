Received: from eggs.gnu.org ([2001:4830:134:3::10]:58974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dhQdc-0004QL-AP
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 21:27:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dhQdX-0007ti-Oh
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 21:27:20 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:30330
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1dhQdX-0007sl-Db
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 21:27:15 -0400
References: <1502705471-28407-1-git-send-email-douly.fnst@cn.fujitsu.com>
	<20170814124439.GM3108@localhost.localdomain>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <ad7ef887-7ff5-84f5-dfca-035dcd915c15@cn.fujitsu.com>
Date: Tue, 15 Aug 2017 09:26:46 +0800
MIME-Version: 1.0
In-Reply-To: <20170814124439.GM3108@localhost.localdomain>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] numa: Add a check whether the node0 has
 memory or not
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, dgilbert@redhat.com, armbru@redhat.com, david@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>

Hi Eduardo,

At 08/14/2017 08:44 PM, Eduardo Habkost wrote:
> On Mon, Aug 14, 2017 at 06:11:11PM +0800, Dou Liyang wrote:
>> Currently, Using the fisrt node without memory on the machine makes
>> QEMU unhappy. With this example command line:
>>   ... \
>>   -m 1024M,slots=4,maxmem=32G \
>>   -numa node,nodeid=0 \
>>   -numa node,mem=1024M,nodeid=1 \
>>   -numa node,nodeid=2 \
>>   -numa node,nodeid=3 \
>> Guest reports "No NUMA configuration found" and the NUMA topology is
>> wrong.
>>
>> This is because when QEMU builds ACPI SRAT, it regards node0 as the
>> default node to deal with the memory hole(640K-1M). this means the
>> node0 must have some memory(>1M) firstly.
>>
>> Add a check in parse_numa_opts to avoid this situation.
>>
>> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
>> ---
>>  numa.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/numa.c b/numa.c
>> index e32af04..1d6f73f 100644
>> --- a/numa.c
>> +++ b/numa.c
>> @@ -464,6 +464,10 @@ void parse_numa_opts(MachineState *ms)
>>          if (i == nb_numa_nodes) {
>>              assert(mc->numa_auto_assign_ram);
>>              mc->numa_auto_assign_ram(mc, numa_info, nb_numa_nodes, ram_size);
>> +        } else if (i != 0) {
>> +            error_report("The first NUMA node must have some memory"
>> +                          " for building ACPI SART");
>> +            exit(1);
>
> This doesn't belong to numa.c.  numa.c is generic code, and the
> requirement you described is specific for PC.
>
> Anyway, adding this check would make existing VM configurations
> refuse to run after a QEMU upgrade.  I suggest fixing the bug in
> the ACPI code instead.
>

I see.

If fixing the bug in the ACPI code, I have two solutions:

1). Add a check in build_srat(). If the first node has no memory, QEMU
will exit.

2). Fix the initialization of memory affinity structure to cover this
situation. Using the first node which has memory to deal with the memory
hole.

I prefer solution 2. what about you?

Thanks,
	dou.
