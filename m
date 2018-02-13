Received: from eggs.gnu.org ([2001:4830:134:3::10]:36761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1eldCY-0005vB-5v
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:13:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1eldCV-0001aB-FY
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:13:02 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60540
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1eldCV-0001Zp-9N
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:12:59 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1DG9COA112410
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 11:12:58 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2g426mbnpk-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 11:12:58 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Tue, 13 Feb 2018 16:12:56 -0000
References: <1518437672-7724-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<1518437672-7724-4-git-send-email-mihajlov@linux.vnet.ibm.com>
	<20180212172332.6d5c3232.cohuck@redhat.com>
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Tue, 13 Feb 2018 17:12:50 +0100
MIME-Version: 1.0
In-Reply-To: <20180212172332.6d5c3232.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Message-Id: <0152b654-a745-271f-2984-e9e078d986ed@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] qmp: add architecture specific cpu
 data for query-cpus-fast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: agraf@suse.de, ehabkost@redhat.com, crosthwaite.peter@gmail.com, armbru@redhat.com, david@redhat.com, qemu-devel@nongnu.org, lcapitulino@redhat.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, pbonzini@redhat.com, dgilbert@redhat.com, rth@twiddle.net

On 12.02.2018 17:23, Cornelia Huck wrote:
[...]
>> diff --git a/cpus.c b/cpus.c
>> index 6df6660..af67826 100644
>> --- a/cpus.c
>> +++ b/cpus.c
>> @@ -2166,6 +2166,10 @@ CpuInfoFastList *qmp_query_cpus_fast(Error **errp)
>>      MachineClass *mc = MACHINE_GET_CLASS(ms);
>>      CpuInfoFastList *head = NULL, *cur_item = NULL;
>>      CPUState *cpu;
>> +#if defined(TARGET_S390X)
>> +    S390CPU *s390_cpu;
>> +    CPUS390XState *env;
>> +#endif
>>  
>>      CPU_FOREACH(cpu) {
>>          CpuInfoFastList *info = g_malloc0(sizeof(*info));
>> @@ -2183,6 +2187,12 @@ CpuInfoFastList *qmp_query_cpus_fast(Error **errp)
>>              info->value->props = props;
>>          }
>>  
>> +#if defined(TARGET_S390X)
>> +        s390_cpu = S390_CPU(cpu);
>> +        env = &s390_cpu->env;
> 
> You should be able to omit the s390_cpu variable by using
> 
>            env = &S390_CPU(cpu)->env;
> 
True, but I wanted to stay in style with the code in qmp_query_cpus.
>> +        info->value->arch = CPU_INFO_ARCH_S390;
>> +        info->value->u.s390.cpu_state = env->cpu_state;
>> +#endif
>>          if (!cur_item) {
>>              head = cur_item = info;
>>          } else {
> 
> As you mentioned in the patch description, the duplication is a bit
> awkward. I'll let the QAPI experts judge that; otherwise, this looks
> fine to me.
> 

-- 
Regards,
 Viktor Mihajlovski
