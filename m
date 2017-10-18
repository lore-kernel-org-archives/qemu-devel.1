Received: from eggs.gnu.org ([2001:4830:134:3::10]:40096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e4lB0-00053O-3T
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 06:02:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e4lAv-00048X-6D
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 06:02:14 -0400
References: <20171017140453.51099-1-pasic@linux.vnet.ibm.com>
	<20171017140453.51099-4-pasic@linux.vnet.ibm.com>
	<0a29771b-da12-76eb-ead8-34d1a8d24ce7@redhat.com>
	<1afce88d-ce14-f311-aa4f-b5fc4f69357a@redhat.com>
	<20171018115807.46be9ff4.cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e61cc4c1-07f8-16e8-72a9-31f460f0e80d@redhat.com>
Date: Wed, 18 Oct 2017 12:02:05 +0200
MIME-Version: 1.0
In-Reply-To: <20171018115807.46be9ff4.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/7] s390x: improve error handling for
 SSCH and RSCH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

On 18.10.2017 11:58, Cornelia Huck wrote:
> On Wed, 18 Oct 2017 11:52:03 +0200
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> On 18.10.2017 11:30, Thomas Huth wrote:
>>> On 17.10.2017 16:04, Halil Pasic wrote:  
>>>> Simplify the error handling of the SSCH and RSCH handler avoiding
>>>> arbitrary and cryptic error codes being used to tell how the instruction
>>>> is supposed to end.  Let the code detecting the condition tell how it's
>>>> to be handled in a less ambiguous way.  It's best to handle SSCH and RSCH
>>>> in one go as the emulation of the two shares a lot of code.
>>>>
>>>> For passthrough this change isn't pure refactoring, but changes the way
>>>> kernel reported EFAULT is handled. After clarifying the kernel interface
>>>> we decided that EFAULT shall be mapped to unit exception.  Same goes for
>>>> unexpected error codes and absence of required ORB flags.
>>>>
>>>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>  
>> [...]
>>>> @@ -71,10 +71,24 @@ again:
>>>>              goto again;
>>>>          }
>>>>          error_report("vfio-ccw: wirte I/O region failed with errno=%d", errno);
>>>> -        return -errno;
>>>> +        ret = -errno;
>>>> +    } else {
>>>> +        ret = region->ret_code;
>>>> +    }
>>>> +    switch (-ret) {
>>>> +    case 0:
>>>> +        return IOINST_CC_EXPECTED;
>>>> +    case EBUSY:
>>>> +        return IOINST_CC_BUSY;
>>>> +    case ENODEV:
>>>> +    case EACCES:
>>>> +        return IOINST_CC_NOT_OPERATIONAL;
>>>> +    case EFAULT:
>>>> +    default:
>>>> +        sch_gen_unit_exception(sch);
>>>> +        css_inject_io_interrupt(sch);
>>>> +        return IOINST_CC_EXPECTED;  
>>>
>>> Do we feel really confident that it is OK to do the setcc() in case of
>>> an exception here later? ... otherwise it might be necessery to
>>> introduce something like IOINST_EXCEPTION to the enum to signal the
>>> ioinst_handle_xxx() callers that they should not do the setcc() anymore...  
>>
>> ... or maybe rather at least return IOINST_CC_STATUS_PRESENT instead?
>> IOINST_CC_EXPECTED sounds somewhat wrong to me here.
> 
> But the ssch did conclude as expected :)
> 
> Keep in mind that QEMU performs the start function synchronously (i.e.,
> before the condition code is set). On real hardware, you get a cc 0 for
> the ssch if the subchannel is basically in a status that's ok for
> triggering the start function. A unit exception is a possible result of
> the start function (and therefore generating an I/O interrupt, which
> you only get if ssch set cc 0.)

OK, I'm not that familiar with the I/O sub-system. If you say that it is
ok, then simply ignore my comment, please :-)

 Thomas
