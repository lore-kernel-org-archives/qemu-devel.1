Received: from eggs.gnu.org ([2001:4830:134:3::10]:38563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e4Uaa-0002hB-NS
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 12:19:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e4UaX-0003Uh-OI
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 12:19:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44152
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1e4UaX-0003UH-Ir
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 12:19:29 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9HGIdOt089935
	for <qemu-devel@nongnu.org>; Tue, 17 Oct 2017 12:19:26 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dnjcpaakd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 17 Oct 2017 12:19:26 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 17 Oct 2017 17:19:24 +0100
References: <20171017140453.51099-1-pasic@linux.vnet.ibm.com>
	<20171017171315.7afc5a59.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 17 Oct 2017 18:19:20 +0200
MIME-Version: 1.0
In-Reply-To: <20171017171315.7afc5a59.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <4ac6acdd-ccbf-3ff7-b6ec-5bdbc5456665@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/7] improve error handling for IO instr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-s390x@nongnu.org, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org



On 10/17/2017 05:13 PM, Cornelia Huck wrote:
> On Tue, 17 Oct 2017 16:04:46 +0200
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
>> Abstract
>> =======
>>
>> The basic idea is: tell how to handle an unusual condition where it's
>> identified, instead of mapping it to an errno (more or less arbitrarily),
>> then possibly mapping these errnos around, to finally (mentally) map the
>> errno back to the condition and take appropriate action.
>>
>> According to Dong Jia the patch-set also has a functional value: for ccw
>> pass-through, he is planing to pass-through the instruction completion
>> information (cc or interruption condition) from the kernel, and this
>> patch set can pretty much be seen as a preparation for that.
>>
>> Changelog
>> =========
>>
>> Patch 1 should be already applied to Conny's tree. I've included it
>> nevertheless so guys working on top of current master have everything in
>> place.
>>
>> v2 -> v3:
>> * somewhat uwillingly traded the type safe struct to a somewhat
>>   type safe enum (because considered ugly) (Thomas, Conny)
>> * dropped 'template approach' patch which intended to further
>>   consolidate IO inst. handlers having lot's of logic and code in
>>   common (Conny)
>> * added warning if vfio-ccw ORB does not have the flags required
>>   by the vfio-ccw implementation as suggested (Dong Jia)
>> * got rid of some unintentional changes (Dong Jia)
>> * reworded some stuff (comments, commit messages) (Dong Jia)
>>
>> v1 -> v2:
>> * use assert if do_subchannel_work without any functions being
>>   accepted 
>> * generate unit-exception if ccw-vfio can't handle an otherwise
>>   good channel program (due to extra limitations) 
>> * keep using return values opposed to recording into SubchDev
>> * split out 'add infrastructure' from 'refactor first handler'
>> * reworded some commit messanges and comments
>> * rebased on top of current master
>> * dropped r-b's and acks because of the magnitude of the
>>   changes
>>
>> Testing
>> =======
>>
>> Nothing happened since v2 except for a quick smoke test. Dong Jia gave v2
>> a spin with a focus on vfio-ccw. @Dong Jia I would appreciate some proper
>> testing, especially regarding the changes in vfio-ccw (patch #3).
> 
> Looks sane to me (if needed, I can fix up the minor things I found).
> 
> In addition to some testing, I'd appreciate some review from others as
> well.
> 

Of course, I'm fine with the fixes (won't answer individually). I think
both Dong Jia and Pierre have already put enough work in this to be credited
with a tag, so I really hope they will get around to review this. I would
be especially happy with an Tested-by: Dong Jia since this series is quite
under-tested, and the changes in vfio-ccw aren't just minor.

Of course I could come up with a test setup myself, but I hope Dong Jia
already has one, and he is certainly more involved with vfio-ccw.

Regards,
Halil

>>
>> Halil Pasic (7):
>>   s390x/css: be more consistent if broken beyond repair
>>   s390x/css: IO instr handler ending control
>>   s390x: improve error handling for SSCH and RSCH
>>   s390x: refactor error handling for XSCH handler
>>   s390x: refactor error handling for CSCH handler
>>   s390x: refactor error handling for HSCH handler
>>   s390x: refactor error handling for MSCH handler
>>
>>  hw/s390x/css.c              | 163 ++++++++++++--------------------------------
>>  hw/s390x/s390-ccw.c         |  11 ++-
>>  hw/vfio/ccw.c               |  28 ++++++--
>>  include/hw/s390x/css.h      |  47 ++++++++++---
>>  include/hw/s390x/s390-ccw.h |   2 +-
>>  target/s390x/ioinst.c       | 136 +++++++-----------------------------
>>  6 files changed, 132 insertions(+), 255 deletions(-)
>>
> 
> 
