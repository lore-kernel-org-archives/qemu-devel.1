Received: from eggs.gnu.org ([2001:4830:134:3::10]:40074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <steven.seeger@flightsystems.net>) id 1ea23C-0004DA-N7
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 11:19:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <steven.seeger@flightsystems.net>) id 1ea239-0000G2-Gj
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 11:19:26 -0500
Received: from p3plsmtpa11-03.prod.phx3.secureserver.net
	([68.178.252.104]:57730)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <steven.seeger@flightsystems.net>)
	id 1ea239-0000DA-B8
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 11:19:23 -0500
From: Steven Seeger <steven.seeger@flightsystems.net>
Reply-To: steven.seeger@flightsystems.net
Date: Fri, 12 Jan 2018 11:19:19 -0500
Message-ID: <2465248.BadtJazF69@wirbelwind>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: [Qemu-devel] ppc icount questions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi guys. I'm the poster on the qemu-discuss list about some technical icount 
questions and was told to come over here to qemu-devel.

My scenario: x86-64 host running qemu/ppc-softmmu with an unmodfied ppc750 cpu 
and a custom board target with chipset I implemented.

I am trying to use icount to get virtual time to increase based on CPU 
instructions executed and not host time. So, if I have a register in a device 
model that is implemented with sleep(1); I would expect virtual time to think 
only a single instruction (or small group of instructions) passed with the 
register access even though real time has stalled a whole second.

When using icount shift=auto, I see behavior where my UART character TX 
interrupt (I had to add a character tx timer to serial.c because WindRiver's 
UART code stops at 11 characters and waits for an interrupt that never comes 
in qemu's impossibly-fast UART) fires every 40ms of virtual time instead of 
every 87 microseconds of virtual time. After the bootup characters fly by, 
more interrupts are turned on and the behavior changes. (I tend to see a 
character come every 120-155 microseconds of virtual time.) 

With icount sleep=off, I see the UART interrupts happen must faster on bootup, 
but their timing is still imprecise.

My goal is to have QEMU respond deterministically to timer events and also 
execute instructions wtih time increasing as a proportion of those executed 
instructions.

A good example of this would be that say I have an interrupt that occurs every 
second. If I were to print out the virtual time that interrupt occurs in the 
device model, I should see a time of:

1.000000
2.000000
3.000000
4.000000

etc

Instead, I see:

1.000000
2.000013
3.000074
4.000022

When the timer function is called in the device model, I arm the timer again 
with qemu_get_clock_ns(QEMU_CLOCK_VIRTUAL + 1000000000ULL) and expect this 
time to be exaclty 1 second of virtual time later.

Either the virtual time is increasing without instructions executing or the 
granularity of when the timer is serviced relative to virtual time is not 
exact. I think the latter is happening. Is this because a tcg codeblock must 
execute completely and this causes increases in virtual time based on the 
number of instructions in that block, and the number of instructions varies?

I looked at Aaron Larson's post at > http://lists.nongnu.org/archive/html/
qemu-discuss/2017-01/msg00022.html and this did not work for me. In fact, I 
never see warp_start be anything other than -1 during the length of time I 
tested it.

Thanks for your help or any feedback.

Steven
