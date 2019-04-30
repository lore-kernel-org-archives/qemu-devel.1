Received: from eggs.gnu.org ([209.51.188.92]:60067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1hLNF0-0004Ew-2J
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 03:31:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <like.xu@linux.intel.com>) id 1hLNEw-0004MO-VD
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 03:31:48 -0400
References: <1553849325-44201-1-git-send-email-like.xu@linux.intel.com>
	<1553849325-44201-3-git-send-email-like.xu@linux.intel.com>
	<20190404162555.0a2267ee@redhat.com>
From: Like Xu <like.xu@linux.intel.com>
Message-ID: <a765e3ac-45e6-310e-aa66-7036b5717a26@linux.intel.com>
Date: Tue, 30 Apr 2019 15:30:31 +0800
MIME-Version: 1.0
In-Reply-To: <20190404162555.0a2267ee@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/9] cpu/topology: add general support for
 machine properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, like.xu@intel.com, Paolo Bonzini <pbonzini@redhat.com>

On 2019/4/4 22:25, Igor Mammedov wrote:
> On Fri, 29 Mar 2019 16:48:38 +0800
> Like Xu <like.xu@linux.intel.com> wrote:
> 

<snipp>
> 
>> diff --git a/cpus.c b/cpus.c
>> index e83f72b..834a697 100644
>> --- a/cpus.c
>> +++ b/cpus.c
>> @@ -2067,6 +2067,10 @@ static void qemu_dummy_start_vcpu(CPUState *cpu)
>>   
>>   void qemu_init_vcpu(CPUState *cpu)
>>   {
>> +    MachineState *ms = MACHINE(qdev_get_machine());
>> +    unsigned int smp_cores = ms->topo.smp_cores;
>> +    unsigned int smp_threads = ms->topo.smp_threads;
> 
> (***)
> for once it probably will crash *-user builds
> and secondly the purpose of getting rid of smp_foo globals
> is disentangle layer violations and not replace it with another global
> (qdev_get_machine()).

I am happy to follow this rule on cpu-topo refactoring work, but 
sometimes calling qdev_get_machine() is inevitable.

> 
> What should be done is to make a properties of nr_cores/nr_threads and set
> them from the parent object that creates CPUs. The point is CPUs shouldn't
> reach out outside itself to fish out data bits it needs, it's responsibility
> of creator to feed to being create CPU needed properties.
> 
> This kind of refactoring probably deserves its own series and should precede
> -smp refactoring as it doesn't depend on CpuTopology at all.
> 

The division of responsibility for this case (refactoring 
qemu_init_vcpu) seems to be a poisonous apple.

The prerequisite for setting cpu-> nr_cores / nr_threads from the parent 
is that the CPU has been created, so if any process during 
initialization needs this topo information, it will use the default 
values form cpu_common_initfn() instead of user-configured parameters.

We may not want to repeat those assignment operations using the new 
values and what do you think, Igor?

<snipp>
