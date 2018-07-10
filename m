Received: from eggs.gnu.org ([2001:4830:134:3::10]:43836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1fcnoH-0001PZ-GN
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 04:15:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1fcnoE-0000US-CS
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 04:15:45 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:43429
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1fcnoD-0000Ta-TE
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 04:15:42 -0400
References: <20180704132239.6506-1-douly.fnst@cn.fujitsu.com>
	<20180710094253.0c122846@redhat.com>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <2052cdff-3dea-1267-3442-39557637b2d4@cn.fujitsu.com>
Date: Tue, 10 Jul 2018 16:15:30 +0800
MIME-Version: 1.0
In-Reply-To: <20180710094253.0c122846@redhat.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] hw/machine: Remove the Zero check of
 nb_numa_nodes for numa_complete_configuration()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com

Hi Igor,

At 07/10/2018 03:42 PM, Igor Mammedov wrote:
> On Wed, 4 Jul 2018 21:22:39 +0800
> Dou Liyang <douly.fnst@cn.fujitsu.com> wrote:
> 
>> Commit 7a3099fc9c5c("numa: postpone options post-processing till machine_run_board_init()")
>> broke the commit 7b8be49d36fc("NUMA: Enable adding NUMA node implicitly").
>>
>> The machine_run_board_init() doesn't do NUMA setup if nb_numa_nodes=0,
>> but the numa_complete_configuration need add a new node if memory hotplug
>> is enabled (slots > 0) even nb_numa_nodes=0.
>>
>> So, Remove the check for numa_complete_configuration() to fix this.
>>
>> Fixes 7a3099fc9c5c("numa: postpone options post-processing till machine_run_board_init()")
>> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
>> ---
>> v1 --> v2:
>>    -Fix it to pass the "make check".
>> ---
>>   hw/core/machine.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index 2077328bcc..32b3c5a7d3 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -791,10 +791,9 @@ void machine_run_board_init(MachineState *machine)
>>   {
>>       MachineClass *machine_class = MACHINE_GET_CLASS(machine);
>>   
>> -    if (nb_numa_nodes) {
>> -        numa_complete_configuration(machine);
>> +    numa_complete_configuration(machine);
>> +    if (nb_numa_nodes)
>>           machine_numa_finish_cpu_init(machine);
>> -    }
> missing curly brackets, should look like:
>         if (nb_numa_nodes) {
>             machine_numa_finish_cpu_init(machine);
>         }
> 
> with that fixed
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> 

Thank you, Igor.

Due to Eduardo has sent the pull request of this patch,
Can I fix this and send v2 patch now?

Thanks,
	dou
>>   
>>       /* If the machine supports the valid_cpu_types check and the user
>>        * specified a CPU with -cpu check here that the user CPU is supported.
> 
> 
> 
> 
