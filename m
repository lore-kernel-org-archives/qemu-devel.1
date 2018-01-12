Received: from eggs.gnu.org ([2001:4830:134:3::10]:38379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ea2zJ-0001FX-7m
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 12:19:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ea2zG-0002cc-1W
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 12:19:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46438)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ea2zF-0002c6-Rr
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 12:19:25 -0500
References: <2465248.BadtJazF69@wirbelwind>
	<2177d773-9d69-f432-9353-4553e098cf1f@redhat.com>
	<3481129.GfW4dsff78@wirbelwind>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <15b90f94-f01a-2755-d2c2-ea74ab213576@redhat.com>
Date: Fri, 12 Jan 2018 18:19:22 +0100
MIME-Version: 1.0
In-Reply-To: <3481129.GfW4dsff78@wirbelwind>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] ppc icount questions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: steven.seeger@flightsystems.net
Cc: qemu-devel@nongnu.org

On 12/01/2018 18:12, Steven Seeger wrote:
> On Friday, January 12, 2018 11:52:57 AM EST Paolo Bonzini wrote:
>> What is the guest doing in the meanwhile?
> 
> The guest is running vxWorks with several threads. The CPU does idle at times. 
> 
>> virtual time increases only when instructions are executed, or when the
>> CPUs are idle (in the latter case, behavior depends on "-icount sleep":
>> if on, it increases at the same pace as real time, if off, it jumps
>> immediately to the next deadline).
> 
> If we jump to the next available deadline, won't that run faster than 
> realtime?

Correct.  I mentioned it because you also had "-icount sleep=off" in
your previous message.

> The preferred goal here is to run realtime (sleep as appropriate) 
> but slow down if the guest or model world requires too many host resources. 
> But, the desire would be to maintain proportionality between number of 
> instructions executed and increase in virtual time. 

Note that in general you'll have different paces when the CPU is idle
and when it is not (because it's unlikely that emulation speed is
exactly 10^9/2^shift; "-icount shift=auto" achieves what you want but
loses more in determinism).  This won't be visible if the guest is
mostly idle though.

> One of the things happening in the guest code is there is a once-per-second 
> interrupt and a once-per-10ms interrupt that the software expects to see in-
> phase with each other. If not, then errors occur. I am seeing errors when I do 
> more work in the device model. However, even with this extra work disabled I 
> still do not see the timer granularity I expect.

That's probably because the CPU runs in the background while the timers
run.  So QEMU_CLOCK_VIRTUAL is _not_ latched while the timers run.
Would that explain it?

Paolo
