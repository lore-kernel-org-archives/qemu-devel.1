Received: from eggs.gnu.org ([2001:4830:134:3::10]:56806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cHvbj-0001Br-25
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 11:43:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1cHvbe-000690-6k
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 11:43:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52737)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1cHvbd-00068g-SF
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 11:43:38 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBGGNlRO119444
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 11:43:36 -0500
Received: from e06smtp08.uk.ibm.com (e06smtp08.uk.ibm.com [195.75.94.104])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27che80cty-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 11:43:35 -0500
Received: from localhost
	by e06smtp08.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 16 Dec 2016 16:43:33 -0000
References: <20161215154330.700-1-pasic@linux.vnet.ibm.com>
	<20161216102528.GB4129@stefanha-x1.localdomain>
	<86f7031a-981a-ef51-8a20-0a3c38e88835@linux.vnet.ibm.com>
	<CAJSP0QVZQ=AXb+gZ3VftkYZ2y=SM_3uhV4VMAmK7GEmJYmpgHQ@mail.gmail.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri, 16 Dec 2016 17:43:29 +0100
MIME-Version: 1.0
In-Reply-To: <CAJSP0QVZQ=AXb+gZ3VftkYZ2y=SM_3uhV4VMAmK7GEmJYmpgHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-Id: <c34179a0-edbb-cc28-7c28-aa34936877bd@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] virtio: fix vring->inuse recalc after migr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-stable <qemu-stable@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>



On 12/16/2016 05:12 PM, Stefan Hajnoczi wrote:
>> You are not the first one complaining, so the sentence is definitively
>> bad. What disturbs me regarding your formulation is that we do not use
>> uint16_t to represent neither the ring size nor inuse.
>>
>> How about "Since max ring size < UINT16_MAX it's safe to use modulo
>> UINT16_MAX + 1 subtraction."?
> That doesn't mention "representing the size of the ring" so it's
> unclear what "safe" means.
> 
> Stefan
> 

IMHO it is not about representation but about correct arithmetic.
We introduce the cast, not because representing the ring size as
int is necessarily an issue, but because we ended up with a wrong
result. In my opinion how can 'inuse' be represented correctly and
efficiently concerns the member of struct VirtQueue.

Here the important point is how conversions between signed unsigned
integer types work in C.

"""
6.3.1.3 Signed and unsigned integers
1 When a value with integer type is converted to another integer
type other than _Bool, if  the value can be represented by the new
type, it is unchanged.
2 Otherwise, if the new type is unsigned, the value is converted by
repeatedly adding or  subtracting one more than the maximum value that
can be represented in the new type until the value is in the range
of the new type.
"""

That is we get mod UINT16_MAX + 1  subtraction which is what we
need if we want to calculate the difference between the two counters
under the assumption that the actual conceptual difference (that
is if the counters where of type arbitrary natural) is less or equal that
queue size which is less than UINT16_MAX.

But no strong opinion here. If I did not manage to convince you
now, just tell, and I will be happy to just go with your formulation.

Thanks,

Halil
