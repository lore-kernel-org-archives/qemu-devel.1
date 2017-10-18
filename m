Received: from eggs.gnu.org ([2001:4830:134:3::10]:60645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e4m69-00031o-75
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 07:01:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e4m63-0003Xj-EA
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 07:01:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55936
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1e4m63-0003X8-8B
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 07:01:11 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9IAxXpr123039
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 07:01:08 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dp4uk40vs-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 07:01:07 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 18 Oct 2017 12:01:06 +0100
References: <20171017140453.51099-1-pasic@linux.vnet.ibm.com>
	<20171017140453.51099-8-pasic@linux.vnet.ibm.com>
	<9f2bd0fe-1b01-2fce-a6a6-694c4242eb7d@redhat.com>
	<20171018120223.60291cd8.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 18 Oct 2017 13:01:03 +0200
MIME-Version: 1.0
In-Reply-To: <20171018120223.60291cd8.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <067c9d26-b39b-645b-a58e-4f1a96d7258b@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 7/7] s390x: refactor error handling for
 MSCH handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org



On 10/18/2017 12:02 PM, Cornelia Huck wrote:
> On Wed, 18 Oct 2017 12:00:05 +0200
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> On 17.10.2017 16:04, Halil Pasic wrote:
>>> Simplify the error handling of the MSCH.  Let the code detecting the
>>> condition tell (in a less ambiguous way) how it's to be handled. No
>>> changes in behavior.  
>>
>> ok, so you claim no changes in behavior ...
>>
>>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>>> ---
>>>  hw/s390x/css.c         | 18 +++++-------------
>>>  include/hw/s390x/css.h |  2 +-
>>>  target/s390x/ioinst.c  | 23 ++++-------------------
>>>  3 files changed, 10 insertions(+), 33 deletions(-)
>>>
>>> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
>>> index b9e0329825..30fc236946 100644
>>> --- a/hw/s390x/css.c
>>> +++ b/hw/s390x/css.c
>>> @@ -1347,28 +1347,24 @@ static void copy_schib_from_guest(SCHIB *dest, const SCHIB *src)
>>>      }
>>>  }
>>>  
>>> -int css_do_msch(SubchDev *sch, const SCHIB *orig_schib)
>>> +IOInstEnding css_do_msch(SubchDev *sch, const SCHIB *orig_schib)
>>>  {
>>>      SCSW *s = &sch->curr_status.scsw;
>>>      PMCW *p = &sch->curr_status.pmcw;
>>>      uint16_t oldflags;
>>> -    int ret;
>>>      SCHIB schib;
>>>  
>>>      if (!(sch->curr_status.pmcw.flags & PMCW_FLAGS_MASK_DNV)) {
>>> -        ret = 0;
>>> -        goto out;
>>> +        return IOINST_CC_EXPECTED;
>>>      }
>>>  
>>>      if (s->ctrl & SCSW_STCTL_STATUS_PEND) {
>>> -        ret = -EINPROGRESS;
>>> -        goto out;
>>> +        return IOINST_CC_STATUS_PRESENT;
>>>      }
>>>  
>>>      if (s->ctrl &
>>>          (SCSW_FCTL_START_FUNC|SCSW_FCTL_HALT_FUNC|SCSW_FCTL_CLEAR_FUNC)) {
>>> -        ret = -EBUSY;
>>> -        goto out;
>>> +        return IOINST_CC_STATUS_PRESENT;
>>>      }  
>>
>> ... but here you change -EBUSY (which got mapped to CC=2) to
>> CC_STATUS_PRESENT which means CC=1. So that's a change in behavior. i.e.
>> this is either a bug, or you should update the patch description with a
>> justification for this change in behavior.
> 
> Indeed, that's a bug. We still want cc 2.
> 

Agree, it is a bug. It was OK in v1 but was already buggy in
v2.

Conny can you fix this up as well please?

Thanks in advance!

Halil
