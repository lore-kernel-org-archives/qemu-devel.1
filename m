Received: from eggs.gnu.org ([2001:4830:134:3::10]:58398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1dhZ4o-0005eh-Gv
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 06:27:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1dhZ4l-0007uO-Rb
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 06:27:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59391)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farman@linux.vnet.ibm.com>)
	id 1dhZ4l-0007u4-JK
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 06:27:55 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7FANvRg069438
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 06:27:54 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cbucv2p7v-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 06:27:53 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farman@linux.vnet.ibm.com>;
	Tue, 15 Aug 2017 04:27:53 -0600
References: <20170814204450.24118-1-farman@linux.vnet.ibm.com>
	<f637c206-266c-d76f-852e-4800422838bb@redhat.com>
	<20170815090302.3f315027.cohuck@redhat.com>
	<222ec8ee-0e1e-ca24-142e-505867bfee27@redhat.com>
	<86e21c68-93ee-0311-643d-dde2c8589eea@redhat.com>
From: Eric Farman <farman@linux.vnet.ibm.com>
Date: Tue, 15 Aug 2017 06:27:48 -0400
MIME-Version: 1.0
In-Reply-To: <86e21c68-93ee-0311-643d-dde2c8589eea@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <4c48cf30-0f40-80c0-66c6-ae546b251c4e@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 0/1] Fix "make clean" for s390
 target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: borntraeger@de.ibm.com, agraf@suse.de, qemu-devel@nongnu.org



On 08/15/2017 04:26 AM, Thomas Huth wrote:
> On 15.08.2017 10:01, Thomas Huth wrote:
>> On 15.08.2017 09:03, Cornelia Huck wrote:
>>> On Tue, 15 Aug 2017 07:02:10 +0200
>>> Thomas Huth <thuth@redhat.com> wrote:
>>>
>>>> On 14.08.2017 22:44, Eric Farman wrote:
>>>>> How often does one really do a "make clean" ?  Rather infrequently,
>>>>> as I only stumbled on this today.
>>>>>
>>>>> Perhaps I have missed the RM variable somewhere, as I see similar syntax
>>>>> in some of the tests/tcg/ Makefiles, but I don't see it being set here.
>>>>> My configure statement isn't terribly interesting, just enabling debug
>>>>> for an s390x target, and as such there's no RM variable in its output.
>>>>> I'll trust that Thomas will chime in with where it should have been.
>>>>> In the meantime, this does the trick for me.
>>>>
>>>> RM is one of the variables that should be pre-initialized by Make, and
>>>> AFAIK should be used to increase portability (well, it's likely not
>>>> important for QEMU since we require a posix-shell like built environment
>>>> anyway).
>>>>
>>>> According to the info page of Make, chapter "10.3 Variables Used by
>>>> Implicit Rules":
>>>>
>>>> `RM'
>>>>       Command to remove a file; default `rm -f'.
>>>>
>>>> I've also checked it again and "make clean" works fine here (using GNU
>>>> Make 3.82). Which version of Make (and Linux distro) are you using?

Not that it matters now, but make 4.1 on F24

>>>
>>> Interesting. It fails for me with GNU Make 3.82 on my RHEL guest as
>>> well.
>>>
>>>> Anyway, maybe I also simply missed something, so I'm certainly also fine
>>>> with the patch to revert it to "rm -f".
>>>
>>> Given that other bios makefiles use rm -f as well, let's just change
>>> back until we figure out what's wrong.
>>
>> I just discovered that it fails for me as well when I do "make clean"
>> from the top directory. So far I was only doing "make clean" after doing
>> a "cd pc-bios/s390-ccw" first, and that works fine. Weird. Something
>> seems to unset the RM variable in our build system, but I fail to find
>> the spot where this happens...
> 
> Ok, just found it: It's this line in rules.mak:
> 
> MAKEFLAGS += -rR
> 
> The parameter -R disables the built-in variables, so RM can indeed not
> work here. Sorry, I wasn't aware of that setting yet, so your patch is
> indeed the right fix here (or we should maybe define RM in rules.mak, too).

Excellent find, Thomas!  I was not aware of that either.  Thanks to both 
you and Cornelia for this.

  - Eric
