Received: from eggs.gnu.org ([2001:4830:134:3::10]:43967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1elcIB-00044Q-A1
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:14:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1elcI8-0002Jq-LL
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:14:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55632)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1elcI8-0002J2-DG
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:14:44 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1DFEXT2086613
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 10:14:43 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g3xf4jwh6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 10:14:41 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Tue, 13 Feb 2018 15:14:38 -0000
References: <1518437672-7724-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<1518437672-7724-3-git-send-email-mihajlov@linux.vnet.ibm.com>
	<20180212165012.GD2545@work-vm>
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Tue, 13 Feb 2018 16:14:33 +0100
MIME-Version: 1.0
In-Reply-To: <20180212165012.GD2545@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Message-Id: <888b36f3-837d-2a58-eecf-a67a8b0492d4@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] qmp: add query-cpus-fast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, lcapitulino@redhat.com, ehabkost@redhat.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, rth@twiddle.net, cohuck@redhat.com, borntraeger@de.ibm.com, agraf@suse.de, david@redhat.com, eblake@redhat.com, armbru@redhat.com, berrange@redhat.com

On 12.02.2018 17:50, Dr. David Alan Gilbert wrote:
[...]
>> diff --git a/hmp.c b/hmp.c
>> index a6b94b7..598bfe5 100644
>> --- a/hmp.c
>> +++ b/hmp.c
>> @@ -410,6 +410,27 @@ void hmp_info_cpus(Monitor *mon, const QDict *qdict)
>>      qapi_free_CpuInfoList(cpu_list);
>>  }
>>  
>> +void hmp_info_cpus_fast(Monitor *mon, const QDict *qdict)
>> +{
>> +    CpuInfoFastList *head, *cpu;
>> +    TargetInfo *target;
>> +
>> +    target = qmp_query_target(NULL);
>> +    monitor_printf(mon, "CPU architecture is '%s'\n\n", target->arch);
>> +    qapi_free_TargetInfo(target);
>> +
>> +    head = qmp_query_cpus_fast(NULL);
>> +
>> +    for (cpu = head; cpu; cpu = cpu->next) {
>> +        monitor_printf(mon, "CPU%" PRId64 "\n", cpu->value->cpu_index);
>> +        monitor_printf(mon, " thread-id=%" PRId64 "\n", cpu->value->thread_id);
>> +        monitor_printf(mon, " qom-path=%s\n", cpu->value->qom_path);
>> +        monitor_printf(mon, "\n");
>> +    }
I started some prototyping in libvirt and stumbled over the changed
layout of "info cpus_fast" vs. "info cpus". IMHO it would be better to
stick with the original format (one line per CPU). I'll post a v2.
>> +
>> +    qapi_free_CpuInfoFastList(head);
>> +}
>> +
>>  static void print_block_info(Monitor *mon, BlockInfo *info,
>>                               BlockDeviceInfo *inserted, bool verbose)
>>  {
>> diff --git a/hmp.h b/hmp.h
>> index 1143db4..93fb4e4 100644
>> --- a/hmp.h
>> +++ b/hmp.h
>> @@ -29,6 +29,7 @@ void hmp_info_migrate_capabilities(Monitor *mon, const QDict *qdict);
>>  void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict);
>>  void hmp_info_migrate_cache_size(Monitor *mon, const QDict *qdict);
>>  void hmp_info_cpus(Monitor *mon, const QDict *qdict);
>> +void hmp_info_cpus_fast(Monitor *mon, const QDict *qdict);
>>  void hmp_info_block(Monitor *mon, const QDict *qdict);
>>  void hmp_info_blockstats(Monitor *mon, const QDict *qdict);
>>  void hmp_info_vnc(Monitor *mon, const QDict *qdict);
> 
> For HMP:
> 
> Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 
[...]

-- 
Regards,
 Viktor Mihajlovski
