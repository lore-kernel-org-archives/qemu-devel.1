Received: from eggs.gnu.org ([2001:4830:134:3::10]:47655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fEb0Q-0006iG-Kd
	for qemu-devel@nongnu.org; Fri, 04 May 2018 09:44:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fEb0M-0004jA-Fl
	for qemu-devel@nongnu.org; Fri, 04 May 2018 09:44:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44858
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1fEb0M-0004ei-AG
	for qemu-devel@nongnu.org; Fri, 04 May 2018 09:44:10 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w44DeqZO058879
	for <qemu-devel@nongnu.org>; Fri, 4 May 2018 09:44:06 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2hrnxuetyh-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 09:44:05 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 4 May 2018 14:44:04 +0100
References: <20180504131605.22816-1-cohuck@redhat.com>
	<1655b27f-5e41-faf4-ad91-8f19d4dc340e@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 4 May 2018 15:44:01 +0200
MIME-Version: 1.0
In-Reply-To: <1655b27f-5e41-faf4-ad91-8f19d4dc340e@redhat.com>
Content-Language: en-US
Message-Id: <b2f107ef-9d97-3eb7-5dd3-7f6c39d9778a@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH] s390x/css: disabled
 subchannels cannot be status pending
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>
Cc: Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org



On 05/04/2018 03:39 PM, Thomas Huth wrote:
> On 04.05.2018 15:16, Cornelia Huck wrote:
>> The 3270 code will try to post an attention interrupt when the
>> 3270 emulator (e.g. x3270) attaches. If the guest has not yet
>> enabled the subchannel for the 3270 device, we will give it a
>> spurious status during msch when it does so later.
>>
>> To fix this, just don't do anything in css_conditional_io_interrupt()
>> if the subchannel is not enabled. The 3270 code will work fine with
>> that, and the other user of this function (virtio-ccw) never
>> attempts to post an interrupt for a disabled device to begin with.
>>
>> Reported-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

I agree with your understanding of the PoP.

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

>> ---
>>  hw/s390x/css.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
>> index 301bf1772f..56c3fa8c89 100644
>> --- a/hw/s390x/css.c
>> +++ b/hw/s390x/css.c
>> @@ -616,6 +616,14 @@ void css_inject_io_interrupt(SubchDev *sch)
>>  
>>  void css_conditional_io_interrupt(SubchDev *sch)
>>  {
>> +    /*
>> +     * If the subchannel is not enabled, it is not made status pending
>> +     * (see PoP p. 16-17, "Status Control").
>> +     */
>> +    if (!(sch->curr_status.pmcw.flags & PMCW_FLAGS_MASK_ENA)) {
>> +        return;
>> +    }
>> +
>>      /*
>>       * If the subchannel is not currently status pending, make it pending
>>       * with alert status.
>>
> 
> Tested-by: Thomas Huth <thuth@redhat.com>
> 
