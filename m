Received: from eggs.gnu.org ([2001:4830:134:3::10]:34951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fj1yP-0000Ep-B4
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 08:35:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fj1yO-00009Z-CS
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 08:35:57 -0400
References: <20180504042044.10318-1-mdroth@linux.vnet.ibm.com>
	<20180726050746.GC12001@umbus.fritz.box>
	<153260823426.10934.15915467115866182748@sif>
	<20180727011042.GC3694@umbus.fritz.box>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <f4cd1b1c-27d1-def8-f1f8-ead902f304f7@ilande.co.uk>
Date: Fri, 27 Jul 2018 13:35:37 +0100
MIME-Version: 1.0
In-Reply-To: <20180727011042.GC3694@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/ppc: only save guest timebase once
 after stopping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org

On 27/07/18 02:10, David Gibson wrote:

> Right, I agree.  Migrating shouldn't advance the time if we've already
> explicitly stopped.  But it's not really clear how to accomplish that
> :/.

This topic is obviously of interest to me because it relates to various 
discussions in the past relating to migrating guest timebases under TCG, 
so below is my current understanding of what we are trying to achieve.

Using the following assumptions:

   i) Sending host and receiving host have the same TB freq
  ii) Sending host and receiving host have synchronised clocks

If we ignore any RTC issues for the moment (can we assume that the guest 
will resync itself via NTP or similar on restart?) then it is possible 
to model 2 separate scenarios:


1) Guest is stopped

In this case there is no timebase compensation required on the receiving 
host. When restarted the guest will see the same timebase as at the 
point in time in which it was stopped.

Sender:
   When guest is stopped:
     guestTB = sendHostTB + sendHostTBDiff

Receiver:
   When guest moves to running state:
     recvTBDiff = guestTB - recvHostTB


2) Guest is running

In this case the duration of the migration itself must be considered 
when the guest starts executing on the receiver. Since the guest is 
running the resulting guestTB is compensated for the time spent during 
the migration phase itself.

Sender:
   guestTB = sendHostTB + sendHostTBDiff
   sendhostCLK = qemu_clock_get_ns(QEMU_CLOCK_REALTIME)

Receiver:
   When guest moves to running state:
     recvhostCLK = qemu_clock_get_ns(QEMU_CLOCK_REALTIME)
     migrationTime = recvhostCLK - sendhostCLK
     migrationTBDiff = migrationTime / recvHostTBFreq
     recvTBDiff = guestTB + migrationTBDiff - recvHostTB


The VM running state should already be in the migration stream which 
enables the receiving host to determine between scenarios 1 and 2, and 
in fact they are equivalent if migrationTime is considered to be 0 in 
scenario 1.

There is also the issue as to whether to allow migration between hosts 
with different timebases; it should be possible to calculate the correct 
recvTBDiff if sendTBFreq were included in the migration stream, but 
could the guest OS detect this and change its behaviour accordingly?

Perhaps a solution here is to always have a separate field representing 
the guestTB the last time the VM was stopped (stoppedGuestTB?) set via a 
VM state change handler and include it in the migration stream?

The receiver knows whether the incoming guest is running or not, and so 
can choose whether to use stoppedGuestTB (set at the last VM stop) or 
guestTB (set during timebase_save) for its timebase calculations when 
resuming the guest as required?



ATB,

Mark.
