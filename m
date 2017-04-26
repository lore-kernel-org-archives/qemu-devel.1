Received: from eggs.gnu.org ([2001:4830:134:3::10]:60350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1d3T0z-0000Ly-T2
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 15:54:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1d3T0v-0000rz-1L
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 15:54:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46101)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1d3T0u-0000qN-Nd
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 15:54:12 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3QJrn9f072832
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 15:54:11 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a2eby5v5w-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 15:54:11 -0400
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 26 Apr 2017 13:54:10 -0600
References: <20170426183721.7482-1-dgilbert@redhat.com>
	<20170426183721.7482-2-dgilbert@redhat.com>
	<8a107a40-073c-8181-75aa-e5700f2900a7@de.ibm.com>
	<20170426190442.GG2394@work-vm>
	<a56800e0-53c5-8e30-4b6b-eaab088ad449@de.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 26 Apr 2017 21:54:05 +0200
MIME-Version: 1.0
In-Reply-To: <a56800e0-53c5-8e30-4b6b-eaab088ad449@de.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Message-Id: <43b13188-7fa4-5994-2415-fe29388f1093@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] Postcopy: Force allocation of all-zero
 precopy pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, aarcange@redhat.com
Cc: qemu-devel@nongnu.org, quintela@redhat.com, lvivier@redhat.com, peterx@redhat.com

On 04/26/2017 09:52 PM, Christian Borntraeger wrote:
> On 04/26/2017 09:04 PM, Dr. David Alan Gilbert wrote:
>> * Christian Borntraeger (borntraeger@de.ibm.com) wrote:
>>> On 04/26/2017 08:37 PM, Dr. David Alan Gilbert (git) wrote:
>>>> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>>>>
>>>> When an all-zero page is received during the precopy
>>>> phase of a postcopy-enabled migration we must force
>>>> allocation otherwise accesses to the page will still
>>>> get blocked by userfault.
>>>>
>>>> Symptom:
>>>>   a) If the page is accessed by a device during device-load
>>>>     then we get a deadlock as the source finishes sending
>>>>     all its pages but the destination device-load is still
>>>>     paused and so doesn't clean up.
>>>>
>>>>   b) If the page is accessed later, then the thread will stay
>>>>     paused until the end of migration rather than carrying on
>>>>     running, until we release userfault at the end.
>>>>
>>>> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>>> Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>>
>>> CC stable? after all the guest hangs on both sides
>>>
>>> Has survived 40 migrations (usually failed at the 2nd)
>>> Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>
>> Great...but.....
>> Andrea (added to the mail) says this shouldn't be necessary.
>> The read we were doing in the is_zero_range() should have been sufficient
>> to get the page mapped and that zero page should have survived.
> 
> We do not do is_zero_range if ch==0 because of lazy evaluation, no?

Sorry misread that code. We do.
