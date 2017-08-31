Received: from eggs.gnu.org ([2001:4830:134:3::10]:53388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dnLap-0002B7-GV
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 05:16:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dnLam-0007Wo-7y
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 05:16:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59194)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dnLam-0007WX-0n
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 05:16:52 -0400
References: <20170830163609.50260-1-pasic@linux.vnet.ibm.com>
	<20170830163609.50260-2-pasic@linux.vnet.ibm.com>
	<b5d3ac95-3811-c39a-c4d7-bb85dc4580e8@redhat.com>
	<4e253d22-8b62-aaf8-f0ff-609853caf22c@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4ee35bcf-9acd-facb-1d06-d585ca8f3ec9@redhat.com>
Date: Thu, 31 Aug 2017 11:16:46 +0200
MIME-Version: 1.0
In-Reply-To: <4e253d22-8b62-aaf8-f0ff-609853caf22c@linux.vnet.ibm.com>
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
To: Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On 31.08.2017 11:09, Halil Pasic wrote:
> 
> 
> On 08/31/2017 07:51 AM, Thomas Huth wrote:
>> On 30.08.2017 18:36, Halil Pasic wrote:
>>> The function ioinst_handle_xsch is presenting cc 2 when it's supposed to
>>> present cc 1 and the other way around, because css_do_xsch has the error
>>> codes mixed up. Fixing the error codes also fixes the priority.
>>>
>>> Let us fix this.
>>
>> (Nit: In case you respin, I'd suggest to remove the last sentence. You
>> already used "fix" two times in the previous one)
>>
>>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>>> Reported-by: Pierre Morel<pmorel@linux.vnet.ibm.com>
>>
>> Space missing -------------^
>>
> 
> copy-paste :(
> 
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
>>
>>  Thomas
>>
> 
> Well, the idea of the series is to get rid of these artificial error codes,
> so your concern of using EBUSY and EINPROGRESS will be dealt with in patch
> 5.
> 
> The idea was to first do the fixes and then do the transformation without
> changing behavior.

Yeah, I realized that when I started to look at the later patches ... so
please ignore my comment, it should be OK the way you're doing it.

 Thomas
