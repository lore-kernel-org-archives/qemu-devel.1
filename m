Received: from eggs.gnu.org ([2001:4830:134:3::10]:33305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ea3nS-0006WM-Ey
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 13:11:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ea3nP-0001cM-PF
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 13:11:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48146)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ea3nP-0001ag-I8
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 13:11:15 -0500
References: <2465248.BadtJazF69@wirbelwind> <3481129.GfW4dsff78@wirbelwind>
	<15b90f94-f01a-2755-d2c2-ea74ab213576@redhat.com>
	<13538328.oP85yjFLDs@wirbelwind>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c2e77a8e-077d-1d7e-b19c-e6f9c683d6aa@redhat.com>
Date: Fri, 12 Jan 2018 19:11:10 +0100
MIME-Version: 1.0
In-Reply-To: <13538328.oP85yjFLDs@wirbelwind>
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

On 12/01/2018 19:03, Steven Seeger wrote:
>> That's probably because the CPU runs in the background while the timers
>> run.  So QEMU_CLOCK_VIRTUAL is _not_ latched while the timers run.
>> Would that explain it?
> 
> Yes that would explain it. QEMU_CLOCK_VIRTUAL should increase with number of 
> executed instructions, but it seems as I said above that this is still 
> factoring time in somewhere. Even though time is a factor (the host must be 
> able to wake up determinstically to handle the next timer deadline in the 
> guest) surely the concept of QEMU_CLOCK_VIRTUAL as tied to number of executed 
> instructions could remain stable.

I think this is the issue:

     I/O thread                    vCPU thread
 -----------------------------------------------------------------------
                                   executes 1,000,000,000-th instruction
                                   wakes up I/O thread
     finds 1st timer
     runs 1st timer
                                   executes 1,000 instructions
----------- QEMU_CLOCK_VIRTUAL now is 1,000,001,000 --------------------
     1st timer finishes
                                   executes 10,000 instructions
----------- QEMU_CLOCK_VIRTUAL now is 1,000,011,000 --------------------
     runs 2nd timer

> I can obtain "sort-of" decent results by using QEMU_CLOCK_VIRTUAL_RT for my tx 
> char timer in serial.c which allows fast bootup and approximately determinstic 
> virtual time later on in execution, but I still have issues with the number of 
> cpu instructions executed varying between timer responses.

QEMU_CLOCK_VIRTUAL_RT is for internal use (by -icount sleep, -icount
shift=auto, etc.).  You almost certainly don't need it.

Paolo

> With an interrupt every 1 second, and an interrupt every 10 ms, I would expect 
> the vxWorks guest to respond to these interrupts with a rather accurate delay 
> between them at the time the 10ms and 1 second interrupt occur at "the same 
> time."
