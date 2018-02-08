Received: from eggs.gnu.org ([2001:4830:134:3::10]:45159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1ejpaW-0002UF-7y
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:02:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1ejpaR-0002MQ-8P
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:02:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37062
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1ejpaR-0002MH-1J
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:02:15 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w18H0oxN069146
	for <qemu-devel@nongnu.org>; Thu, 8 Feb 2018 12:02:13 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g0s2cd3f3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 12:02:12 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Thu, 8 Feb 2018 17:02:10 -0000
References: <1518083288-20410-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<20180208090904.5a9c88df@redhat.com>
	<20180208162126.3426623b.cohuck@redhat.com>
	<20180208103024.35d962c9@redhat.com>
	<2b9e79d9-9c13-3edc-38f4-80062824e0b6@linux.vnet.ibm.com>
	<20180208112216.0c4b6f3c@redhat.com>
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Thu, 8 Feb 2018 18:02:07 +0100
MIME-Version: 1.0
In-Reply-To: <20180208112216.0c4b6f3c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Message-Id: <8808a5f2-aeff-e6c7-1a17-3c4ccaf91c4a@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] S390: Expose s390-specific CPU info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luiz Capitulino <lcapitulino@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Eric Blake <eblake@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On 08.02.2018 17:22, Luiz Capitulino wrote:
> On Thu, 8 Feb 2018 16:52:28 +0100
> Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com> wrote:
> 
>> diff --git a/qapi-schema.json b/qapi-schema.json
>> index 12c7dc8..0b36860 100644
>> --- a/qapi-schema.json
>> +++ b/qapi-schema.json
>> @@ -607,7 +607,27 @@
>>  ##
>>  { 'struct': 'CpuInfo2',
>>    'data': {'cpu-index': 'int', '*halted': 'bool', 'qom-path': 'str',
>> -           'thread-id': 'int', '*props': 'CpuInstanceProperties' } }
>> +           'thread-id': 'int', '*props': 'CpuInstanceProperties',
>> +           '*archdata': 'CpuInfoArchData' } }
>> +
>> +##
>> +# @CpuInfoArchData:
>> +#
>> +# Architecure specific information about a virtual CPU
>> +#
>> +# Since: 2.12
>> +#
>> +##
>> +{ 'union': 'CpuInfoArchData',
>> +  'base': { 'arch': 'CpuInfoArch' },
>> +  'discriminator': 'arch',
>> +  'data': { 'x86': 'CpuInfoOther',
>> +            'sparc': 'CpuInfoOther',
>> +            'ppc': 'CpuInfoOther',
>> +            'mips': 'CpuInfoOther',
>> +            'tricore': 'CpuInfoOther',
>> +            's390': 'CpuInfoS390',
>> +            'other': 'CpuInfoOther' } }
>>  
>>  ##
>>  # @query-cpus-fast:
> 
> I don't think you need CpuInfoArchData, you can have S390CpuState
> instead and ignore the other archs. It's not like all archs data
> can be returned at the same time, and also you start having to
> replicate that arch string list everywhere. Lastly, the arch name
> is returned by query-target, so no need to duplicate that one either.
> 
I don't think I really understood your suggestion. Was it to assume that
only s390 will have arch-specific data?. I.e. something along the lines of
-           'thread-id': 'int', '*props': 'CpuInstanceProperties' } }
+           'thread-id': 'int', '*props': 'CpuInstanceProperties',
+           '*archdata': 'CpuInfoS390' } }

or some kind of in-line, anonymous union? I have to confess I'm pretty
QAPI-illiterate, so I may have done it overly complicated. At least it
feels that way.

-- 
Regards,
 Viktor Mihajlovski
