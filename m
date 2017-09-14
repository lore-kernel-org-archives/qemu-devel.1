Received: from eggs.gnu.org ([2001:4830:134:3::10]:37135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dsYeI-00065p-F3
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 14:14:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dsYeE-0007KA-Fl
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 14:14:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dsYeE-0007JC-AA
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 14:13:58 -0400
References: <20170904154316.4148-1-david@redhat.com>
	<20170904154316.4148-12-david@redhat.com>
	<2c620927-0406-2fc1-895c-09ffc2e44a4e@linux.vnet.ibm.com>
	<6b3e9c2b-4cb7-fdf8-5f9b-ff7ebbf52d1e@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <24e458ff-39c8-7407-62ad-46568e150c5d@redhat.com>
Date: Thu, 14 Sep 2017 20:13:49 +0200
MIME-Version: 1.0
In-Reply-To: <6b3e9c2b-4cb7-fdf8-5f9b-ff7ebbf52d1e@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 11/19] s390x: allow only 1 CPU with TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, cohuck@redhat.com, Alexander Graf <agraf@suse.de>, borntraeger@de.ibm.com, Aurelien Jarno <aurelien@aurel32.net>

On 06.09.2017 23:20, Richard Henderson wrote:
> On 09/06/2017 11:16 AM, Matthew Rosato wrote:
>> On 09/04/2017 11:43 AM, David Hildenbrand wrote:
>>> Specifying more than 1 CPU (e.g. -smp 5) leads to SIGP errors (the
>>> guest tries to bring these CPUs up but fails), because we don't support
>>> multiple CPUs on s390x under TCG.
>>>
>>> Let's bail out if more than 1 is specified, so we don't raise people's
>>> hope. Make it a define, so we can easily bump it up later.
>>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>
>> Makes sense.  Ran the described environment without this patch (errors)
>> and again with this patch (graceful exit w/ message).
>>
>> Tested-by: Matthew Rosato <mjrosato@linux.vnet.ibm.com>
> 
> Can someone review
> 
>   http://patchwork.ozlabs.org/patch/760010/
> 
> which does at least start to add the SIGP support.

FWIW, I started factoring out today KVM SIGP code to make it usable by TCG.

I also started adding the missing SIGP instructions the kernel handles
for KVM. I dropped the old TCG SIGP handling code and completely reuse
the new SIGP code. I already got boot/reboot/shutdown  properly running
(implementing STOP and RESTART interrupts like KVM has).

But its still quite hacky and there are is a bunch of stuff to clean up,
especially:
- external interrupt handling (the queue approach we have right now is
  no good for external calls and emergency signals)
- floating interrupt support (io interrupts always going to CPU 0 is a
  hack)

I think I can at least implement SIGP properly and fix the external call
stuff. floating interrupts might require more thought.

Aurelien, please tell me if you are currently still working on this, so
we can coordinate.

Thanks!

> 
> Once tcg can bring up 2 cpus, I see no reason it couldn't bring up N.  I don't
> see the point of the define.
> 
> 
> r~
> 


-- 

Thanks,

David
