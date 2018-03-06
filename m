Received: from eggs.gnu.org ([2001:4830:134:3::10]:39202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1et7sm-0001Zx-49
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 03:23:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1et7sh-0006F3-6t
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 03:23:36 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43680)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1et7sg-0006Ef-Uj
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 03:23:31 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w268IhmC029813
	for <qemu-devel@nongnu.org>; Tue, 6 Mar 2018 03:23:29 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ghpp99ucx-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Mar 2018 03:23:29 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 6 Mar 2018 08:23:27 -0000
References: <1519407778-23095-1-git-send-email-imbrenda@linux.vnet.ibm.com>
	<1519407778-23095-4-git-send-email-imbrenda@linux.vnet.ibm.com>
	<90dab7d2-be2a-4ab6-ed08-4ce8cac5664f@de.ibm.com>
	<20180305162710.70f680ff.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 6 Mar 2018 09:23:23 +0100
MIME-Version: 1.0
In-Reply-To: <20180305162710.70f680ff.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <d16953b5-e47d-937e-dd61-f0acf302d949@de.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v4 3/3] s390x/sclp: extend
 SCLP event masks to 64 bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org



On 03/05/2018 04:27 PM, Cornelia Huck wrote:
> On Fri, 2 Mar 2018 10:44:46 +0100
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> On 02/23/2018 06:42 PM, Claudio Imbrenda wrote:
>>> Extend the SCLP event masks to 64 bits.
>>>
>>> Notice that using any of the new bits results in a state that cannot be
>>> migrated to an older version.
>>>
>>> Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
>>> ---
>>>  hw/s390x/event-facility.c         | 56 ++++++++++++++++++++++++++++++---------
>>>  include/hw/s390x/event-facility.h |  2 +-
>>>  2 files changed, 45 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
>>> index e04ed9f..c3e39ee 100644
>>> --- a/hw/s390x/event-facility.c
>>> +++ b/hw/s390x/event-facility.c
>>> @@ -30,7 +30,7 @@ struct SCLPEventFacility {
>>>      SysBusDevice parent_obj;
>>>      SCLPEventsBus sbus;
>>>      /* guest's receive mask */
>>> -    sccb_mask_t receive_mask;
>>> +    uint32_t receive_mask_pieces[2];  
>>
>>
>> Before the change, we basically use be32_to_cpu to transfer the byte field into a cpu
>> endianess value. In the end it is actually a bitfield, but for compat we need to keep
>> he reversal. So it will be hard to get this fixed without some kind of ugliness.
> 
> Could we also use a compat mask callback/handler for older machines and
> switch to 64 bit handlers for the default case? Probably would be even
> more ugly, though.

Claudio had a version with a pre/post/load/save handler. Claudio can you repost this
version so that we can have a look what is "less ugly"?
