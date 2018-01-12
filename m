Received: from eggs.gnu.org ([2001:4830:134:3::10]:58425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <steven.seeger@flightsystems.net>) id 1ea3gT-0004IK-U2
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 13:04:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <steven.seeger@flightsystems.net>) id 1ea3gQ-0001hX-M3
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 13:04:05 -0500
Received: from p3plsmtpa09-02.prod.phx3.secureserver.net
	([173.201.193.231]:46210)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <steven.seeger@flightsystems.net>)
	id 1ea3gQ-0001fo-GH
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 13:04:02 -0500
From: Steven Seeger <steven.seeger@flightsystems.net>
Reply-To: steven.seeger@flightsystems.net
Date: Fri, 12 Jan 2018 13:03:59 -0500
Message-ID: <13538328.oP85yjFLDs@wirbelwind>
In-Reply-To: <15b90f94-f01a-2755-d2c2-ea74ab213576@redhat.com>
References: <2465248.BadtJazF69@wirbelwind> <3481129.GfW4dsff78@wirbelwind>
	<15b90f94-f01a-2755-d2c2-ea74ab213576@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Subject: Re: [Qemu-devel] ppc icount questions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

On Friday, January 12, 2018 12:19:22 PM EST Paolo Bonzini wrote:
> 
> Correct.  I mentioned it because you also had "-icount sleep=off" in
> your previous message.

Yes I have tried both. With sleep=off, I get the faster interrupt response 
(better granularity) but with sleep=on, it is poor. Again, a timer that should 
fire every 87us fires every 0.040000 seconds (always this precision) while 
guest is booting up and loading applications (very little guest idle time)

> Note that in general you'll have different paces when the CPU is idle
> and when it is not (because it's unlikely that emulation speed is
> exactly 10^9/2^shift; "-icount shift=auto" achieves what you want but
> loses more in determinism).  This won't be visible if the guest is
> mostly idle though.

It seems to me that if the TCG keeps track of number of instructions, we 
should be able to tie this to virtual timer increase. However it seems this is 
not the case. There's still some processing of a notion of "time" even when 
icount is used. We can be deterministic but only to some granularity and I 
can't seem to figure out where that is set.

> That's probably because the CPU runs in the background while the timers
> run.  So QEMU_CLOCK_VIRTUAL is _not_ latched while the timers run.
> Would that explain it?

Yes that would explain it. QEMU_CLOCK_VIRTUAL should increase with number of 
executed instructions, but it seems as I said above that this is still 
factoring time in somewhere. Even though time is a factor (the host must be 
able to wake up determinstically to handle the next timer deadline in the 
guest) surely the concept of QEMU_CLOCK_VIRTUAL as tied to number of executed 
instructions could remain stable.

Perhaps this is the case and I am doing something wrong somewhere.

I can obtain "sort-of" decent results by using QEMU_CLOCK_VIRTUAL_RT for my tx 
char timer in serial.c which allows fast bootup and approximately determinstic 
virtual time later on in execution, but I still have issues with the number of 
cpu instructions executed varying between timer responses.

With an interrupt every 1 second, and an interrupt every 10 ms, I would expect 
the vxWorks guest to respond to these interrupts with a rather accurate delay 
between them at the time the 10ms and 1 second interrupt occur at "the same 
time."

Steven
