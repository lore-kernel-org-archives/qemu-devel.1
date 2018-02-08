Received: from eggs.gnu.org ([2001:4830:134:3::10]:59956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ejtI2-0006HW-0z
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:59:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ejtHx-0003yW-Gd
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:59:30 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54952 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ejtHx-0003yH-Bq
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:59:25 -0500
References: <20180207175014.11157-1-lcapitulino@redhat.com>
	<20180207175014.11157-2-lcapitulino@redhat.com>
	<20180208195939.GJ13301@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dab9dcff-619f-9c0f-0c8c-f6542b73ca88@redhat.com>
Date: Thu, 8 Feb 2018 14:59:17 -0600
MIME-Version: 1.0
In-Reply-To: <20180208195939.GJ13301@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] qmp: add query-cpus-fast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Luiz Capitulino <lcapitulino@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berrange@redhat.com, mihajlov@linux.vnet.ibm.com

On 02/08/2018 01:59 PM, Eduardo Habkost wrote:
> On Wed, Feb 07, 2018 at 12:50:13PM -0500, Luiz Capitulino wrote:
>> The query-cpus command has an extremely serious side effect:
>> it always interrupt all running vCPUs so that they can run
>> ioctl calls. This can cause a huge performance degradation for
>> some workloads. And most of the information retrieved by the
>> ioctl calls are not even used by query-cpus.
>>
>> This commit introduces a replacement for query-cpus called
>> query-cpus-fast, which has the following features:
>>

>> +# Notes: @halted is a transient state that changes frequently.  By the time the
>> +#        data is sent to the client, the guest may no longer be halted.
>> +##
>> +{ 'struct': 'CpuInfo2',
>> +  'data': {'cpu-index': 'int', '*halted': 'bool', 'qom-path': 'str',
>> +           'thread-id': 'int', '*props': 'CpuInstanceProperties' } }
> 
> This will require duplicating struct fields every time we add a
> new field to query-cpus-fast (e.g. how would VIktor's
> CpuInfoS390State patch[1] look like if rebased on top of yours?).
> 
> One way to avoid that is to use CpuInfo for both, and make all
> "slow"  fields optional.  Another option is to use QAPI
> inheritance, but it could be a little complicated if unions are
> involved?

Inheritance is better than optional fields for the sake of introspection 
learning which fields to expect.

Put the common fields to both interfaces in the base class, then have 
the slower (older) CpuInfo class extend the base class to add the 
additional fields.

Unions should be able to inherit just fine from structs (after all, a 
flat union requires a struct base); but if we need two layers of unions, 
we'll need to enhance QAPI code generation first.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
