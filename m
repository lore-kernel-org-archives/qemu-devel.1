Received: from eggs.gnu.org ([2001:4830:134:3::10]:51300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1ek3oU-0005eA-JR
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 03:13:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1ek3oP-0001SO-Kl
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 03:13:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58596)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1ek3oP-0001QX-Aw
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 03:13:37 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w198CDQS115723
	for <qemu-devel@nongnu.org>; Fri, 9 Feb 2018 03:13:35 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g158t6v9q-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 03:13:35 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Fri, 9 Feb 2018 08:13:32 -0000
References: <20180207175014.11157-1-lcapitulino@redhat.com>
	<20180207175014.11157-2-lcapitulino@redhat.com>
	<20180208195939.GJ13301@localhost.localdomain>
	<dab9dcff-619f-9c0f-0c8c-f6542b73ca88@redhat.com>
	<20180208214143.GF13981@localhost.localdomain>
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Fri, 9 Feb 2018 09:13:28 +0100
MIME-Version: 1.0
In-Reply-To: <20180208214143.GF13981@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Message-Id: <a794b84e-cbbc-e7f7-4e89-25224e1860aa@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] qmp: add query-cpus-fast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: Luiz Capitulino <lcapitulino@redhat.com>, qemu-devel@nongnu.org, armbru@redhat.com, berrange@redhat.com

On 08.02.2018 22:41, Eduardo Habkost wrote:
> On Thu, Feb 08, 2018 at 02:59:17PM -0600, Eric Blake wrote:
>> On 02/08/2018 01:59 PM, Eduardo Habkost wrote:
>>> On Wed, Feb 07, 2018 at 12:50:13PM -0500, Luiz Capitulino wrote:
>>>> The query-cpus command has an extremely serious side effect:
>>>> it always interrupt all running vCPUs so that they can run
>>>> ioctl calls. This can cause a huge performance degradation for
>>>> some workloads. And most of the information retrieved by the
>>>> ioctl calls are not even used by query-cpus.
>>>>
>>>> This commit introduces a replacement for query-cpus called
>>>> query-cpus-fast, which has the following features:
>>>>
>>
>>>> +# Notes: @halted is a transient state that changes frequently.  By the time the
>>>> +#        data is sent to the client, the guest may no longer be halted.
>>>> +##
>>>> +{ 'struct': 'CpuInfo2',
>>>> +  'data': {'cpu-index': 'int', '*halted': 'bool', 'qom-path': 'str',
>>>> +           'thread-id': 'int', '*props': 'CpuInstanceProperties' } }
>>>
>>> This will require duplicating struct fields every time we add a
>>> new field to query-cpus-fast (e.g. how would VIktor's
>>> CpuInfoS390State patch[1] look like if rebased on top of yours?).
>>>
>>> One way to avoid that is to use CpuInfo for both, and make all
>>> "slow"  fields optional.  Another option is to use QAPI
>>> inheritance, but it could be a little complicated if unions are
>>> involved?
>>
>> Inheritance is better than optional fields for the sake of introspection
>> learning which fields to expect.
>>
>> Put the common fields to both interfaces in the base class, then have the
>> slower (older) CpuInfo class extend the base class to add the additional
>> fields.
>>
>> Unions should be able to inherit just fine from structs (after all, a flat
>> union requires a struct base); but if we need two layers of unions, we'll
>> need to enhance QAPI code generation first.
> 
> If we can't do union-union inheritance yet, maybe we can work around it this
> way:
> 
> # fields that are always returned by both query-cpus and query-cpus-fast
> { 'struct': 'BothCpuInfoBase',
>   'data': {'cpu': 'int', 'qom_path': 'str', 'thread_id': 'int',
>            '*props': 'CpuInstanceProperties' } }
> 
> # fields that are always returned by query-cpus
> { 'struct': 'CpuInfoBase',
>   'base': 'BothCpuInfoBase',
>   'data': {'current': 'bool', 'halted': 'bool', 'arch': 'CpuInfoArch' } }
> 
> # query-cpus return value
> { 'union': 'CpuInfo',
>   'base': 'CpuInfoBase',
>   'discriminator': 'arch',
>   'data': { 'x86': 'CpuInfoX86',
>             's390': 'CpuInfoS390',
>             'sparc': 'CpuInfoSPARC',
>             'ppc': 'CpuInfoPPC',
>             'mips': 'CpuInfoMIPS',
>             'tricore': 'CpuInfoTricore',
>             'other': 'CpuInfoOther' } }
> 
> # fields that are always returned by query-cpus-fast
> { 'struct': 'FastCpuInfoBase',
>   'base': 'BothCpuInfoBase',
>   'data': { 'arch': 'CpuInfoArch' } }
> 
> # return value of query-cpus-fast
> { 'union': 'FastCpuInfo',
>   'base': 'FastCpuInfoBase',
>   'discriminator': 'arch',
>   'data': { 'x86': 'CpuInfoOther',
>             's390': 'FastCpuInfoS390',
>             'sparc': 'CpuInfoOther',
>             'ppc': 'CpuInfoOther',
>             'mips': 'CpuInfoOther',
>             'tricore': 'CpuInfoOther',
>             'other': 'CpuInfoOther' } }
> 
> # fields returned by both query-cpus and query-cpus-fast on s390
> { 'struct': 'FastCpuInfoS390',
>   'data': { 'fast_field': 'int' } }
> 
> # fields returned by query-cpus on s390
> { 'struct': 'CpuInfoS390',
>   'base': 'FastCpuInfoS390',
>   'data': { 'slow_field': 'int' } }
> 
This is not exactly pretty, but would provide the functionality (and
flexibility) I'd expect.

-- 
Regards,
 Viktor Mihajlovski
