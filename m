Received: from eggs.gnu.org ([2001:4830:134:3::10]:39827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e1ZqQ-0000BR-1N
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:19:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e1ZqK-00059D-6Q
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:19:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44340
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1e1ZqK-00058w-0X
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:19:44 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v99FJdo7108649
	for <qemu-devel@nongnu.org>; Mon, 9 Oct 2017 11:19:40 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dgbncr02u-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 11:19:40 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Mon, 9 Oct 2017 16:19:38 +0100
References: <20171004154144.88995-1-pasic@linux.vnet.ibm.com>
	<20171004154144.88995-3-pasic@linux.vnet.ibm.com>
	<d6d2d73d-65c9-7ae1-fd37-cb8e304781e7@redhat.com>
	<7f454872-fae3-35b0-eff4-227b2aa0f77d@linux.vnet.ibm.com>
	<20171009130945.3c58e6cb.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon, 9 Oct 2017 17:19:35 +0200
MIME-Version: 1.0
In-Reply-To: <20171009130945.3c58e6cb.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <dade9f2f-ba8b-a97e-3e74-b268fe153dd0@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/8] s390x/css: IO instr handler ending
 control
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org



On 10/09/2017 01:09 PM, Cornelia Huck wrote:
> On Mon, 9 Oct 2017 12:54:03 +0200
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
>> On 10/09/2017 10:20 AM, Thomas Huth wrote:
>>> On 04.10.2017 17:41, Halil Pasic wrote:  
> 
>>>> +/* IO instructions conclude according this */
>>>> +typedef struct IOInstEnding {
>>>> +        /*
>>>> +         * General semantic of cc codes of IO instructions is (brief):
>>>> +         * 0 -- produced expected result
>>>> +         * 1 --  status conditions were present or produced alternate result
>>>> +         * 2 -- ineffective, because busy with previously initiated function
>>>> +         * 3 -- ineffective, not operational
>>>> +         */
>>>> +        int cc;
>>>> +} IOInstEnding;  
>>>
>>> Why do you need a struct for this? Do you plan to extend it later? If
>>> so, I think you should mention that in the patch description. If not,
>>> please use a named enum or a "typedef unsigned int IOInstEnding" instead.
>>>
>>>  Thomas  
>>
>> We may, we may not. In the previous version we also had to support
>> do end a certain instruction with an addressing exception, but this
>> is going away in patch #3. Honestly I don't expect this being extended.
>>
>> I have other reasons for the struct. Type safety and clear semantics,
>> and frankly at least for s390 and linux I don't see any downsides given
>> what is written in the "zSeries ELF Application Binary Interface Supplement".
>> Can you please explain to me what is the problem with using this struct, and
>> what is the benefit switching to a unsigned int?
> 
> Honestly, I fail to see the benefit of using a struct here... it's just


Type safety. For instance had I forgotten let's say a return -ENODEV
somewhere, my version would not compile. On the contrary with an enum (like
Thomas has proposed) it compiles just fine with my setup -- I did not try
what would happen if we call setcc(cpu, -ENODEV)

> a condition code, and while adding a comment what the various codes

Right, but it's a different _type_ of condition code (than the POSIX errno
codes for instance) so that's why it's modeled as a different type.

> mean for I/O instructions is a good idea, I think having to use a
> IOInstEnding struct just renders the code less readable.

It's probably a matter of taste. I find, for example
return (IOInstEnding){.cc = 1}
in this case more readable than
return -ENOSYS
because from the first one I know we have detected a condition
which we want to handle by setting cc 1 for the instruction. The
later requires me figuring out in the context of which instruction
handler am I called, go trough the whole call chain looking for
possible re-mappings (like for -EACCES) and finally examining the
switch statement of the instruction handler carefully.

Could you please tell me what exactly is difficult to read for
you (form what I've proposed).

Regards,
Halil


> 
> [I haven't had time to look at the rest of the patches yet.]
> 
