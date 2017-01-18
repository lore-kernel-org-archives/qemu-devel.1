Received: from eggs.gnu.org ([2001:4830:134:3::10]:52002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cTq79-0001js-Ml
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 08:17:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cTq76-0006c4-DZ
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 08:17:23 -0500
Received: from [59.151.112.132] (port=51012 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cTq75-0006bS-Vq
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 08:17:20 -0500
References: <1484743207-10721-1-git-send-email-douly.fnst@cn.fujitsu.com>
	<1484743207-10721-2-git-send-email-douly.fnst@cn.fujitsu.com>
	<20170118125627.GU3491@thinpad.lan.raisama.net>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <070f9509-d7c9-4d2e-3c52-3d9496f8235f@cn.fujitsu.com>
Date: Wed, 18 Jan 2017 21:17:09 +0800
MIME-Version: 1.0
In-Reply-To: <20170118125627.GU3491@thinpad.lan.raisama.net>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] cpu: Make the mapping of CPUs and NUMA
 nodes in cpu_common_realizefn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, imammedo@redhat.com, peter.maydell@linaro.org, vilanova@ac.upc.edu, izumi.taku@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com, fanc.fnst@cn.fujitsu.com

Hi, Eduardo

At 01/18/2017 08:56 PM, Eduardo Habkost wrote:
> On Wed, Jan 18, 2017 at 08:40:05PM +0800, Dou Liyang wrote:
>> Current default way of seting the CPUState::numa_node might be wrong
>> in case on cold/hot-plug CPUs. Making the users confused why the
>> NUMA info is different beetween the guests and monitor.
>>
>> Make the mapping of CPUs and NUMA nodes in qom/cpu.c:
>> cpu_common_realizefn(), where each VCPUs need to realize.
>>
>> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
>
> parse_numa_opts() is called a long time before any CPU is
> created, so this should be safe.
>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>
> (But we can squash patch 2/3 and patch 3/3 in this patch).

OK, :)

Thanks,
	Liyang.

>
>> ---
>>  qom/cpu.c | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/qom/cpu.c b/qom/cpu.c
>> index 61ee0cb..e08dceb 100644
>> --- a/qom/cpu.c
>> +++ b/qom/cpu.c
>> @@ -23,6 +23,7 @@
>>  #include "qemu-common.h"
>>  #include "qom/cpu.h"
>>  #include "sysemu/kvm.h"
>> +#include "sysemu/numa.h"
>>  #include "qemu/notify.h"
>>  #include "qemu/log.h"
>>  #include "exec/log.h"
>> @@ -338,6 +339,18 @@ static void cpu_common_parse_features(const char *typename, char *features,
>>      }
>>  }
>>
>> +static void cpu_common_map_numa_node(CPUState *cpu)
>> +{
>> +    int i;
>> +
>> +    for (i = 0; i < nb_numa_nodes; i++) {
>> +        assert(cpu->cpu_index < max_cpus);
>> +        if (test_bit(cpu->cpu_index, numa_info[i].node_cpu)) {
>> +            cpu->numa_node = i;
>> +        }
>> +    }
>> +}
>> +
>>  static void cpu_common_realizefn(DeviceState *dev, Error **errp)
>>  {
>>      CPUState *cpu = CPU(dev);
>> @@ -347,6 +360,8 @@ static void cpu_common_realizefn(DeviceState *dev, Error **errp)
>>          cpu_resume(cpu);
>>      }
>>
>> +    cpu_common_map_numa_node(cpu);
>> +
>>      /* NOTE: latest generic point where the cpu is fully realized */
>>      trace_init_vcpu(cpu);
>>  }
>> --
>> 2.5.5
>>
>>
>>
>
