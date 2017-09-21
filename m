Received: from eggs.gnu.org ([2001:4830:134:3::10]:45717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1duykR-0000dZ-JP
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 06:30:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1duykN-0008K9-CX
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 06:30:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53108
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1duykN-0008IB-7f
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 06:30:19 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8LAT9TQ010437
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 06:30:18 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2d4aemvw9d-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 06:30:18 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 21 Sep 2017 11:30:16 +0100
References: <20170920172314.102710-1-pasic@linux.vnet.ibm.com>
	<20170920172314.102710-3-pasic@linux.vnet.ibm.com>
	<20170921112341.59175a29.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 21 Sep 2017 12:30:11 +0200
MIME-Version: 1.0
In-Reply-To: <20170921112341.59175a29.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <d36a9f7f-bbf1-0815-a0c1-c9f36cdd1803@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] s390x/3270: handle writes of arbitrary
 length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>



On 09/21/2017 11:23 AM, Cornelia Huck wrote:
> On Wed, 20 Sep 2017 19:23:14 +0200
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
>> The problem is, that the current implementation places unrealistic and
>> arbitrary constraints on the length of writes to the device (that is the
>> outbound requests), by asserting ccw.count being such that that even the
>> worst case escaped payload will fit an  more or less arbitrary sized
>> buffer. Actually on protocol level there is nothing to justify such
>> a limitation.
>>
>> Another strange thing is the return value which more or less reflects
>> the size (written) after escaping instead of before escaping. This
>> is strange, because this return value is used to calculate SCSW.count.
> 
> Didn't the Linux driver care about the count?
> 

Maybe Jason can answer that. I did only most basic testing with my patch
applied (and basically no testing without my changes).

>From code perspective I'm sure it does for the reads. For the writes
I did not look into that.

Halil

>>
>> Let us teach 3270 how to deal with arbitrary long writes.
>>
>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
>> Reported-by: Jason J . Herne <jjherne@linux.vnet.ibm.com>
>> Tested-by: Jason J . Herne <jjherne@linux.vnet.ibm.com>
>> ---
>>  hw/char/terminal3270.c | 30 ++++++++++++++++++------------
>>  1 file changed, 18 insertions(+), 12 deletions(-)
> 
> Looks good.
> 
