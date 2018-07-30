Received: from eggs.gnu.org ([2001:4830:134:3::10]:41571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fk9f1-0007c8-F5
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 11:00:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fk9ex-0004AJ-Da
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 11:00:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39336
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1fk9ex-0004A1-70
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 11:00:31 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w6UExQF1041907
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 11:00:30 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2kj49d9w18-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 11:00:29 -0400
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 30 Jul 2018 16:00:26 +0100
References: <1532959766-53343-1-git-send-email-borntraeger@de.ibm.com>
	<1bf75ad8-dc90-b94e-0ead-53fdbc72dd4f@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 30 Jul 2018 17:00:19 +0200
MIME-Version: 1.0
In-Reply-To: <1bf75ad8-dc90-b94e-0ead-53fdbc72dd4f@redhat.com>
Content-Language: en-US
Message-Id: <b894e494-1dfc-8953-79e9-fde3f9560c77@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 1/1] s390x/sclp: fix maxram
 calculation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.vnet.ibm.com>, imbrenda@linux.vnet.ibm.com, Richard Henderson <rth@twiddle.net>



On 07/30/2018 04:34 PM, David Hildenbrand wrote:
> On 30.07.2018 16:09, Christian Borntraeger wrote:
>> We clamp down ram_size to match the sclp increment size. We do
>> not do the same for maxram_size, which means for large guests
>> with some sizes (e.g. -m 50000) maxram_size differs from ram_size.
>> This can break other code (e.g. CMMA migration) which uses maxram_size
>> to calculate the number of pages and then throws some errors.
> 
> So the only problem is that the buffer size between source and target
> differ?

The problem is that the target tries to access a non-existing buffer when 
committing all cmma value, so the kernel returns with EFAULT.
> 
>>
>> Fixes: 82fab5c5b90e468f3e9d54c ("s390x/sclp: remove memory hotplug support")
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> CC: qemu-stable@nongnu.org
>> CC: David Hildenbrand <david@redhat.com>
>> ---
>>  hw/s390x/sclp.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
>> index bd2a024..4510a80 100644
>> --- a/hw/s390x/sclp.c
>> +++ b/hw/s390x/sclp.c
>> @@ -320,6 +320,7 @@ static void sclp_memory_init(SCLPDevice *sclp)
>>      initial_mem = initial_mem >> increment_size << increment_size;
>>  
>>      machine->ram_size = initial_mem;
>> +    machine->maxram_size = initial_mem;
>>      /* let's propagate the changed ram size into the global variable. */
>>      ram_size = initial_mem;
>>  }
>>
> 
> I even have a private patch for that already :)
