Received: from eggs.gnu.org ([2001:4830:134:3::10]:41096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dtzkl-00045m-QM
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 13:22:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dtzki-0001Nl-Ll
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 13:22:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45251)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dtzki-0001MC-Bj
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 13:22:36 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8IHJKG6095259
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 13:22:34 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d2emnre0a-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 13:22:34 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 18 Sep 2017 18:22:31 +0100
References: <20170918163322.206581-1-borntraeger@de.ibm.com>
	<a82be132-6363-6875-9cb2-837eb9787ac4@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 18 Sep 2017 19:22:26 +0200
MIME-Version: 1.0
In-Reply-To: <a82be132-6363-6875-9cb2-837eb9787ac4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <91de41ca-ca4f-8c80-6bbf-e03eefb6ae0a@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] s390x/cpu: expose the guest crash
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



On 09/18/2017 06:51 PM, David Hildenbrand wrote:
>>  # An enumeration of the guest panic information types
>>  #
>> +# @kvm-s390: s390 guest panic information type (Since: 2.11)
>> +#
>>  # Since: 2.9
>>  ##
>>  { 'enum': 'GuestPanicInformationType',
>> -  'data': [ 'hyper-v'] }
>> +  'data': [ 'hyper-v', 'kvm-s390' ] }
>>  
>>  ##
>>  # @GuestPanicInformation:
>> @@ -335,7 +337,8 @@
>>  {'union': 'GuestPanicInformation',
>>   'base': {'type': 'GuestPanicInformationType'},
>>   'discriminator': 'type',
>> - 'data': { 'hyper-v': 'GuestPanicInformationHyperV' } }
>> + 'data': { 'hyper-v': 'GuestPanicInformationHyperV',
>> +           'kvm-s390': 'GuestPanicInformationKVMS390' } }
> 
> kvm-s390 is wrong. This is general s390x and should be named s390/s390x
> and GuestPanicInformationS390(x). One can argue about s390 v s390x. See
> last comment in this mail.


Yes, will remove the kvm part and only use s390. Not sure about s390 vs. s390x.
I slightly prefer the s390 name as in the kernel but I really do not care if
we follow the s390x as in QEMU. Conny, any opinion?

[..]
>>  
>> +static GuestPanicInformation *s390x_cpu_get_crash_info(CPUState *cs)
>> +{
>> +    GuestPanicInformation *panic_info;
>> +    S390CPU *cpu = S390_CPU(cs);
>> +
>> +    cpu_synchronize_state(cs);
> 
> Is this the correct place here? Or rephrasing it: in order to detect an
> crash this should already have been done. E.g. unmanageable_intercept()
> uses cpu->env.psa, which has to be synchronized (especially for older
> kernels).
> 
> So we should rather make sure that all crash paths have synchronized the
> state (e.g. in unmanageable_intercept()).
> [...]

This code will also be called from common code (e.g. if KVM_RUN returns with EFAULT)
so I would like to keep it here. After all cpu_synchronize_state called be called
multiple times without any problems.

> 
>> index d07763f..950ea42 100644
>> --- a/target/s390x/kvm.c
>> +++ b/target/s390x/kvm.c
>> @@ -1941,15 +1941,31 @@ static bool is_special_wait_psw(CPUState *cs)
>>      return cs->kvm_run->psw_addr == 0xfffUL;
>>  }
>>  
>> -static void unmanageable_intercept(S390CPU *cpu, const char *str, int pswoffset)
>> +static void unmanageable_intercept(S390CPU *cpu, int32_t reason, int pswoffset)
>>  {
>>      CPUState *cs = CPU(cpu);
>> +    const char *str;
>>  
>> +    switch (reason) {
>> +    case EXCP_CRASH_PGM:
>> +        str = "program interrupt";
> 
> program interrupt loop

Yes.

> 
>> +        break;
>> +    case EXCP_CRASH_EXT:
>> +        str = "external interrupt";
> 
> ... loop
> 


yes

> [...]
