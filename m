Received: from eggs.gnu.org ([2001:4830:134:3::10]:35709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ejjO3-00028H-CM
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 05:25:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ejjNx-0001RO-6J
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 05:25:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55114
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1ejjNw-0001R8-VP
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 05:24:57 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w18AOIAB087595
	for <qemu-devel@nongnu.org>; Thu, 8 Feb 2018 05:24:55 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g0gmu9vw7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 05:24:54 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 8 Feb 2018 10:24:52 -0000
References: <1518083288-20410-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<20180208111633.0e8a6237.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 8 Feb 2018 11:24:48 +0100
MIME-Version: 1.0
In-Reply-To: <20180208111633.0e8a6237.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <ef7d8fbd-42b0-2d28-c3c2-ab96a8e52e5f@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] S390: Expose s390-specific CPU info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>, Eric Blake <eblake@redhat.com>



On 02/08/2018 11:16 AM, Cornelia Huck wrote:
> On Thu,  8 Feb 2018 10:48:08 +0100
> Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com> wrote:
> 
> [added some cc:s]
> 
>> Presently s390x is the only architecture not exposing specific
>> CPU information via QMP query-cpus. Upstream discussion has shown
>> that it could make sense to report the architecture specific CPU
>> state, e.g. to detect that a CPU has been stopped.
>>
>> With this change the output of query-cpus will look like this on
>> s390:
>>
>>     [{"arch": "s390", "current": true,
>>       "props": {"core-id": 0}, "cpu_state": "operating", "CPU": 0,
>>       "qom_path": "/machine/unattached/device[0]",
>>       "halted": false, "thread_id": 63115},
>>      {"arch": "s390", "current": false,
>>       "props": {"core-id": 1}, "cpu_state": "stopped", "CPU": 1,
>>       "qom_path": "/machine/unattached/device[1]",
>>       "halted": true, "thread_id": 63116}]
>>
>> Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
>> ---
>>  cpus.c                     |  6 ++++++
>>  hmp.c                      |  4 ++++
>>  hw/s390x/s390-virtio-ccw.c |  2 +-
>>  qapi-schema.json           | 25 ++++++++++++++++++++++++-
>>  target/s390x/cpu.c         | 24 ++++++++++++------------
>>  target/s390x/cpu.h         |  7 ++-----
>>  target/s390x/kvm.c         |  8 ++++----
>>  target/s390x/sigp.c        | 38 +++++++++++++++++++-------------------
>>  8 files changed, 72 insertions(+), 42 deletions(-)
>>
>> diff --git a/cpus.c b/cpus.c
>> index 2cb0af9..39e46dd 100644
>> --- a/cpus.c
>> +++ b/cpus.c
>> @@ -2033,6 +2033,9 @@ CpuInfoList *qmp_query_cpus(Error **errp)
>>  #elif defined(TARGET_TRICORE)
>>          TriCoreCPU *tricore_cpu = TRICORE_CPU(cpu);
>>          CPUTriCoreState *env = &tricore_cpu->env;
>> +#elif defined(TARGET_S390X)
>> +        S390CPU *s390_cpu = S390_CPU(cpu);
>> +        CPUS390XState *env = &s390_cpu->env;
>>  #endif
>>  
>>          cpu_synchronize_state(cpu);
>> @@ -2060,6 +2063,9 @@ CpuInfoList *qmp_query_cpus(Error **errp)
>>  #elif defined(TARGET_TRICORE)
>>          info->value->arch = CPU_INFO_ARCH_TRICORE;
>>          info->value->u.tricore.PC = env->PC;
>> +#elif defined(TARGET_S390X)
>> +        info->value->arch = CPU_INFO_ARCH_S390;
>> +        info->value->u.s390.cpu_state = env->cpu_state;
>>  #else
>>          info->value->arch = CPU_INFO_ARCH_OTHER;
>>  #endif
>> diff --git a/hmp.c b/hmp.c
>> index b3de32d..37e04c3 100644
>> --- a/hmp.c
>> +++ b/hmp.c
>> @@ -390,6 +390,10 @@ void hmp_info_cpus(Monitor *mon, const QDict *qdict)
>>          case CPU_INFO_ARCH_TRICORE:
>>              monitor_printf(mon, " PC=0x%016" PRIx64, cpu->value->u.tricore.PC);
>>              break;
>> +        case CPU_INFO_ARCH_S390:
>> +            monitor_printf(mon, " state=%s",
>> +                           CpuInfoS390State_str(cpu->value->u.s390.cpu_state));
>> +            break;
>>          default:
>>              break;
>>          }
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index 3807dcb..3e6360e 100644
>> --- a/hw/s390x/s390-virtio-ccw.c
>> +++ b/hw/s390x/s390-virtio-ccw.c
>> @@ -373,7 +373,7 @@ static void s390_machine_reset(void)
>>  
>>      /* all cpus are stopped - configure and start the ipl cpu only */
>>      s390_ipl_prepare_cpu(ipl_cpu);
>> -    s390_cpu_set_state(CPU_STATE_OPERATING, ipl_cpu);
>> +    s390_cpu_set_state(CPU_INFOS390_STATE_OPERATING, ipl_cpu);
> 
> Exposing the state as a QAPI enum has the unfortunate side effect of
> that new name. It feels slightly awkward to me, as it is a state for
> real decisions and not just for info statements...

I asked Viktor to use the qapi enum instead of having two sets of defines that
we need to keep in sync. (in fact 3, as the kernel kvm mpstate definition is also
there).

But yes, the INFO in that name is somewhat strange. No good idea though.
