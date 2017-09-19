Received: from eggs.gnu.org ([2001:4830:134:3::10]:35388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1duJ1H-0007HW-34
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:57:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1duJ1D-0002hK-1N
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:56:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54494)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1duJ1C-0002gU-OC
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:56:54 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8JDsr5g011522
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 09:56:52 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d30021nrm-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 09:56:52 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 19 Sep 2017 14:56:49 +0100
References: <20170919074314.10350-1-borntraeger@de.ibm.com>
	<70c1733f-6ff7-ddd0-2799-308bf6ad2dd2@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 19 Sep 2017 15:56:46 +0200
MIME-Version: 1.0
In-Reply-To: <70c1733f-6ff7-ddd0-2799-308bf6ad2dd2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <0f1c2678-bf5d-d931-eb7d-0baaf1b4b675@de.ibm.com>
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
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>, Jing Liu <liujbjl@linux.vnet.ibm.com>



On 09/19/2017 03:14 PM, David Hildenbrand wrote:
> 
>>      CPUState *cs = CPU(obj);
>> @@ -291,6 +345,8 @@ static void s390_cpu_initfn(Object *obj)
>>      cs->exception_index = EXCP_HLT;
>>      object_property_add(OBJECT(cpu), "id", "int64_t", s390x_cpu_get_id,
>>                          s390x_cpu_set_id, NULL, NULL, NULL);
>> +    object_property_add(obj, "crash-information", "GuestPanicInformation",
>> +                        s390x_cpu_get_crash_info_qom, NULL, NULL, NULL, NULL);
>>      s390_cpu_model_register_props(obj);
>>  #if !defined(CONFIG_USER_ONLY)
>>      qemu_get_timedate(&tm, 0);
>> @@ -517,6 +573,7 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
>>      cc->do_interrupt = s390_cpu_do_interrupt;
>>  #endif
>>      cc->dump_state = s390_cpu_dump_state;
>> +    cc->get_crash_info = s390x_cpu_get_crash_info;
>>      cc->set_pc = s390_cpu_set_pc;
>>      cc->gdb_read_register = s390_cpu_gdb_read_register;
>>      cc->gdb_write_register = s390_cpu_gdb_write_register;
>> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
>> index 0bd97a5..dba32db 100644
>> --- a/target/s390x/cpu.h
>> +++ b/target/s390x/cpu.h
>> @@ -396,6 +396,12 @@ static inline void cpu_get_tb_cpu_state(CPUS390XState* env, target_ulong *pc,
>>  #define EXCP_IO  7 /* I/O interrupt */
>>  #define EXCP_MCHK 8 /* machine check */
>>  
>> +/* Crash cases. */
>> +#define EXCP_CRASH_PGM 9
>> +#define EXCP_CRASH_EXT 10
>> +#define EXCP_CRASH_WAITPSW 11
>> +#define EXCP_CRASH_OPEREXC 12
>> +
> 
> Okay, looking at cpu_handle_exception() I am pretty sure this won't work
> with TCG unless cpu->exception_index >= EXCP_INTERRUPT. Maybe define new
> EXCP_CRASH or store this information somewhere else inside s390 CPU?

Just asking: 
Would it be ok to define EXCP_CRASH as 0x20000 or so?
