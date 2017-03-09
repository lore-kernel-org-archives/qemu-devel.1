Received: from eggs.gnu.org ([2001:4830:134:3::10]:45201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cm1V0-0003N8-5Y
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 12:05:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cm1Uw-0000nU-77
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 12:05:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58970)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1cm1Uv-0000mX-U7
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 12:05:06 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v29Gx0SK020757
	for <qemu-devel@nongnu.org>; Thu, 9 Mar 2017 12:05:04 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 292hvs59au-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 09 Mar 2017 12:05:03 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 9 Mar 2017 17:05:01 -0000
References: <20170309132216.23482-1-dgilbert@redhat.com>
	<20170309132216.23482-3-dgilbert@redhat.com>
	<1584ce47-ec53-efc7-b790-5288252121ed@linux.vnet.ibm.com>
	<20170309160610.GH2480@work-vm>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 9 Mar 2017 18:04:56 +0100
MIME-Version: 1.0
In-Reply-To: <20170309160610.GH2480@work-vm>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Message-Id: <a81c0e8a-4a2b-50e5-eb9f-b548fe2a749b@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] postcopy: Check for shared memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, lvivier@redhat.com, pbonzini@redhat.com



On 03/09/2017 05:06 PM, Dr. David Alan Gilbert wrote:
> * Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
>>
>>
>> On 03/09/2017 02:22 PM, Dr. David Alan Gilbert (git) wrote:
>>> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>>>
>>> Postcopy doesn't support migration of RAM shared with another process
>>> yet (we've got a bunch of things to understand).
>>> Check for the case and don't allow postcopy to be enabled.
>>>
>>> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>> ---
>>>  migration/postcopy-ram.c | 18 ++++++++++++++++++
>>>  1 file changed, 18 insertions(+)
>>>
>>> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
>>> index effbeb6..dc80dbb 100644
>>> --- a/migration/postcopy-ram.c
>>> +++ b/migration/postcopy-ram.c
>>> @@ -95,6 +95,19 @@ static bool ufd_version_check(int ufd)
>>>      return true;
>>>  }
>>>
>>> +/* Callback from postcopy_ram_supported_by_host block iterator.
>>> + */
>>> +static int test_range_shared(const char *block_name, void *host_addr,
>>> +                             ram_addr_t offset, ram_addr_t length, void *opaque)
>>> +{
>>> +    if (qemu_ram_is_shared(qemu_ram_block_by_name(block_name))) {
>>> +        error_report("Postcopy on shared RAM (%s) is not yet supported",
>>> +                     block_name);
>>> +        return 1;
>>> +    }
>>> +    return 0;
>>> +}
>>> +
>>
>> Hm, this stuff with the iterator seemed a bit strange (too complicated)
>> first, but I'm not familiar with this code. I have no idea why is
>> RAMBlockIterFunc
>>  
>> typedef int (RAMBlockIterFunc)(const char *block_name, void *host_addr,
>>     ram_addr_t offset, ram_addr_t length, void *opaque)
>>
>> and not 
>>
>> typedef int (RAMBlockIterFunc)(RAMBlock *block, void *opaque).
>>
>> The reason does not seem to be abstraction.
> 
> It is, it's because the contents of RAMBlock are private.
> 


That's kind of half-backed abstraction. One can get a pointer to
RAMBlock, just like you did, and then do operations on it, just like you
did. So it would have been perfectly normal to use a pointer to RAMBlock
(incomplete type) and provide accessors (getters) reflecting the public
interface of RAMBlock. Well it may be helpful for making undesired usage
patterns hard, I do not know if this is the reason. (What I mean is if I
wanted to see these just for a single block I have a pointer to, I would
probably have to iterate over all blocks get a pointer by name and
compare it with my pointer, if it matches I have the values. So if such
usage is undesired, it's well reflected in the design).

The whole question is kind of off-topic -- my curious nature is making me
less productive again...

Regards,
Halil
