Received: from eggs.gnu.org ([2001:4830:134:3::10]:44303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1duIZP-0002JZ-D4
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:28:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1duIZM-0007R5-57
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:28:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38774)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1duIZL-0007P2-So
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:28:08 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8JDPLxF005279
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 09:28:06 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d2yyqfh6t-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 09:28:06 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 19 Sep 2017 14:27:56 +0100
References: <20170919074314.10350-1-borntraeger@de.ibm.com>
	<dba8f914-b9f1-f942-0c57-4cfbadf08655@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 19 Sep 2017 15:27:53 +0200
MIME-Version: 1.0
In-Reply-To: <dba8f914-b9f1-f942-0c57-4cfbadf08655@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <d4297d7f-4b49-8ca9-3b27-abf27f1c3455@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2] s390x/cpu: expose the guest crash
 information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>, Jing Liu <liujbjl@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>



On 09/19/2017 03:06 PM, David Hildenbrand wrote:
> 
>> +##
>> +# @GuestPanicInformationS390:
>> +#
>> +# S390 specific guest panic information (PSW)
>> +#
>> +# Since: 2.11
>> +##
>> +{'struct': 'GuestPanicInformationS390',
>> + 'data': { 'psw-mask': 'uint64',
>> +           'psw-addr': 'uint64',
>> +           'reason': 'str' } }
> 
> Wonder if we should rather use an enum for reason.

Eric asked a similar question. Since this is just a human readable "info"
I would like to keep it as str. This will allow QEMU to add new things without
the need to update libvirt. Ok?

> 
>> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
>> index 74b3e4f..5b835fe 100644
>> --- a/target/s390x/cpu.c
>> +++ b/target/s390x/cpu.c
>> @@ -35,6 +35,8 @@
>>  #include "qemu/error-report.h"
>>  #include "trace.h"
>>  #include "qapi/visitor.h"
>> +#include "qapi-visit.h"
>> +#include "sysemu/hw_accel.h"
>>  #include "exec/exec-all.h"
>>  #ifndef CONFIG_USER_ONLY
>>  #include "hw/hw.h"
>> @@ -276,6 +278,58 @@ static void s390x_cpu_set_id(Object *obj, Visitor *v, const char *name,
>>      cpu->id = value;
>>  }
>>  
> [...]
>> +static void unmanageable_intercept(S390CPU *cpu, int32_t reason, int pswoffset)
>>  {
>>      CPUState *cs = CPU(cpu);
>> +    const char *str;
>>  
>> +    switch (reason) {
>> +    case EXCP_CRASH_PGM:
>> +        str = "program interrupt loop";
>> +        break;
>> +    case EXCP_CRASH_EXT:
>> +        str = "external interrupt loop";
>> +        break;
>> +    case EXCP_CRASH_OPEREXC:
>> +        str = "operation exception loop";
>> +        break;
>> +    default:
>> +        str = "unknown crash reason";
>> +        break;
>> +    }
>>      error_report("Unmanageable %s! CPU%i new PSW: 0x%016lx:%016lx",
>>                   str, cs->cpu_index, ldq_phys(cs->as, cpu->env.psa + pswoffset),
>>                   ldq_phys(cs->as, cpu->env.psa + pswoffset + 8));
>>      s390_cpu_halt(cpu);
>> -    qemu_system_guest_panicked(NULL);
>> +    cs->exception_index = reason;
> 
> Hmmm, this might work for KVM but most probably in the current form not
> for TCG. cpu_handle_exception() will most probably just clear it and
> then exit to the main loop.

I was hoping to avoid the need to add new state, but adding a new variable should
be doable.
