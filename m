Received: from eggs.gnu.org ([2001:4830:134:3::10]:33019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dnJyD-0004k5-Ix
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 03:32:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dnJyA-0000bv-Bz
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 03:32:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39548)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dnJyA-0000bh-2q
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 03:32:54 -0400
References: <20170830163609.50260-1-pasic@linux.vnet.ibm.com>
	<20170830163609.50260-2-pasic@linux.vnet.ibm.com>
	<b5d3ac95-3811-c39a-c4d7-bb85dc4580e8@redhat.com>
	<20170831083859.11694707.cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c8bbd500-c5b6-dd66-1e84-feb80978ee34@redhat.com>
Date: Thu, 31 Aug 2017 09:32:49 +0200
MIME-Version: 1.0
In-Reply-To: <20170831083859.11694707.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/9] s390x/css: fix cc handling for XSCH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On 31.08.2017 08:38, Cornelia Huck wrote:
> On Thu, 31 Aug 2017 07:51:17 +0200
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> On 30.08.2017 18:36, Halil Pasic wrote:
>>> The function ioinst_handle_xsch is presenting cc 2 when it's supposed to
>>> present cc 1 and the other way around, because css_do_xsch has the error
>>> codes mixed up. Fixing the error codes also fixes the priority.
>>>
>>> Let us fix this.  
>>
>> (Nit: In case you respin, I'd suggest to remove the last sentence. You
>> already used "fix" two times in the previous one)
> 
> I can also remove it on applying, if Halil agrees (I have not yet
> reviewed it, though).
> 
>>
>>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>>> Reported-by: Pierre Morel<pmorel@linux.vnet.ibm.com>  
>>
>> Space missing -------------^
> 
> And I can also add that space on applying :)
> 
>>
>>> ---
>>>  hw/s390x/css.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
>>> index 1880b1a0ff..a50fb0727e 100644
>>> --- a/hw/s390x/css.c
>>> +++ b/hw/s390x/css.c
>>> @@ -1281,12 +1281,12 @@ int css_do_xsch(SubchDev *sch)
>>>          (!(s->ctrl &
>>>             (SCSW_ACTL_RESUME_PEND | SCSW_ACTL_START_PEND | SCSW_ACTL_SUSP))) ||
>>>          (s->ctrl & SCSW_ACTL_SUBCH_ACTIVE)) {
>>> -        ret = -EINPROGRESS;
>>> +        ret = -EBUSY;
>>>          goto out;
>>>      }
>>>  
>>>      if (s->ctrl & SCSW_CTRL_MASK_STCTL) {
>>> -        ret = -EBUSY;
>>> +        ret = -EINPROGRESS;
>>>          goto out;
>>>      }  
>>
>> Using both, EBUSY and EINPROGRESS as error codes sounds very confusing
>> to me here ... what's the difference between busy and in-progress? So
>> while you're at it, maybe you could replace the code for CC 2 ("CANCEL
>> SUBCHANNEL not applicable") with a different error code?
> 
> IIRC, I used these two as they matched my idea of what happens best
> (there's a difference between "subchannel is busy" and "the I/O is
> already in progress, too late to cancel"). "xsch not applicable" is
> very hard to translate to an Unix error code :/

OK, the codes make more sense with your description ==> Maybe simply add
a proper comment for each of the return codes?

 Thomas
