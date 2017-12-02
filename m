Received: from eggs.gnu.org ([2001:4830:134:3::10]:39946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1eL8rV-0005tZ-Rs
	for qemu-devel@nongnu.org; Sat, 02 Dec 2017 09:33:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1eL8rQ-0001S6-Vw
	for qemu-devel@nongnu.org; Sat, 02 Dec 2017 09:33:49 -0500
Message-ID: <1512225215.2224.59.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sat, 02 Dec 2017 08:33:35 -0600
In-Reply-To: <20171130042857.GA3023@umbus.fritz.box>
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-11-clg@kaod.org>
	<20171128063827.GP11775@umbus.fritz.box>
	<e9b1f002-671b-7ba5-2b5b-34715d63585c@kaod.org>
	<20171129045941.GH3023@umbus.fritz.box>
	<512a0e63-43c1-bf8c-3060-66ab52bc054f@kaod.org>
	<c620afca-f6df-b3ed-8317-c805ec66b31b@kaod.org>
	<20171130042857.GA3023@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 10/25] spapr: add MMIO handlers for the
 XIVE interrupt sources
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: "list@suse.de:PowerPC" <qemu-ppc@nongnu.org>, qemu-devel@nongnu.org

On Thu, 2017-11-30 at 15:28 +1100, David Gibson wrote:
> 
> How does this work at the hardware level?  Presumbly the actual
> hardware components don't communicate with the XIVE to request edge or
> level.  So how does it know?  Specific ranges for LSIs?  If that we
> should probably do the same.

So the source controller and the IVE are separate. The source
controller sends an internal MMIO to the IVE for "translating" the
event into a queue etc...

The IVE only see "events" which are effectively state transitions of
the P bit of the source.

The LSI vs MSI difference is thus entirely a property of the source
HW.

All the XIVE "Generic" built-in sources (the ones you can trigger with
an MMIO, which we use in KVM for all the IPIs and virtual interrupts)
are MSIs.

You find 2 kind of blocks of LSIs in the chip, the one PSI block which
has a handful or two of LSI sources for random "stuff" (LPC
interrupt(s), i2c interrupts etc..) and the LSI blocks which are in
each PHB.

So the PHB has basically two different bits of logic, one for LSIs and
one for MSIs. Their HW state machine is different.

In fact in the PHB and the PSI, I think, there's even an MMIO backdoor
register that allows you to see the "state" of the LSI (asserted).

Cheers,
Ben.
