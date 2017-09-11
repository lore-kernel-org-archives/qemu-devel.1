Received: from eggs.gnu.org ([2001:4830:134:3::10]:54342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1drOSv-0001yo-2T
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 09:09:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1drOSp-0002RS-AJ
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 09:09:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35636)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1drOSp-0002QT-0a
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 09:09:23 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8BD9Ctt103015
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 09:09:21 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cwq82gwgp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 09:09:19 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Mon, 11 Sep 2017 14:08:54 +0100
References: <20170908152446.14606-1-pasic@linux.vnet.ibm.com>
	<20170908152446.14606-4-pasic@linux.vnet.ibm.com>
	<20170911114841.408b5988.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon, 11 Sep 2017 15:08:52 +0200
MIME-Version: 1.0
In-Reply-To: <20170911114841.408b5988.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <90381836-c1ee-2d0b-86a5-117c2a86a74f@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 3/4] s390x/css: remove dubious error
 handling branch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org



On 09/11/2017 11:48 AM, Cornelia Huck wrote:
> On Fri,  8 Sep 2017 17:24:45 +0200
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
> s/dubious/unused/
> 

Nod.

>> The case in question actually never happens. Let us get rid of the dead
>> code.
> 
> I had tried to be complete in my initial implementation. With the
> current implementation, it can never happen, yes. We can easily
> resurrect it from git history should we need it in the future.
> 

I've tried to understand the branch but I failed. Weather the subchannel
is busy or not should be already decided, and if the device is busy
that is probably supposed to be indicated via device status (word 2 bit 3).

So I wrote dubious because I could not figure it out. But unused
is certainly nicer.

I think shall the need emerge the preferred way of handling would
be to use the custom handling (-EIO) branch.


>>
>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>> ---
>>  hw/s390x/css.c | 7 -------
>>  1 file changed, 7 deletions(-)
>>
>> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
>> index a44d87ab3e..a9cdd54efc 100644
>> --- a/hw/s390x/css.c
>> +++ b/hw/s390x/css.c
>> @@ -980,13 +980,6 @@ static void sch_handle_start_func_virtual(SubchDev *sch)
>>                      SCSW_STCTL_ALERT | SCSW_STCTL_STATUS_PEND;
>>              s->cpa = sch->channel_prog + 8;
>>              break;
>> -        case -EBUSY:
>> -            /* subchannel busy, generate deferred cc 1 */
>> -            s->flags &= ~SCSW_FLAGS_MASK_CC;
>> -            s->flags |= (1 << 8);
>> -            s->ctrl &= ~SCSW_CTRL_MASK_STCTL;
>> -            s->ctrl |= SCSW_STCTL_ALERT | SCSW_STCTL_STATUS_PEND;
>> -            break;
>>          case -EINPROGRESS:
>>              /* channel program has been suspended */
>>              s->ctrl &= ~SCSW_ACTL_START_PEND;
> 
> Thanks, queued.
> 

Thanks!
