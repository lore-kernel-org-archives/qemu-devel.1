Received: from eggs.gnu.org ([2001:4830:134:3::10]:42787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1eL8x5-0007dO-OA
	for qemu-devel@nongnu.org; Sat, 02 Dec 2017 09:39:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1eL8x1-0007BX-Nu
	for qemu-devel@nongnu.org; Sat, 02 Dec 2017 09:39:35 -0500
Message-ID: <1512225554.2224.65.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sat, 02 Dec 2017 08:39:14 -0600
In-Reply-To: <20171130043836.GB3023@umbus.fritz.box>
References: <20171123132955.1261-14-clg@kaod.org>
	<20171130043836.GB3023@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 13/25] spapr: introduce the XIVE Event
 Queues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Thu, 2017-11-30 at 15:38 +1100, David Gibson wrote:
> On Thu, Nov 23, 2017 at 02:29:43PM +0100, C=C3=A9dric Le Goater wrote:
> > The Event Queue Descriptor (EQD) table, also known as Event Notificat=
ion
> > Descriptor (END), is one of the internal tables the XIVE interrupt
> > controller uses to redirect exception from event sources to CPU
> > threads.
> >=20
> > The EQD specifies on which Event Queue the event data should be poste=
d
> > when an exception occurs (later on pulled by the OS) and which server
> > (VPD in XIVE terminology) to notify. The Event Queue is a much more
> > complex structure but we start with a simple model for the sPAPR
> > machine.
>=20
> Just to clarify my understanding a server / VPD in XIVE would
> typically correspond to a cpu - either real or virtual, yes?

The IVEs and EQs are managed by the virtualization controller. The VPs
(aka ENDs) are managed by the presentation controller. There's a VP per
real and virtual CPU.

You can think of the XIVE as having 3 main component types:


 - Source controller(s). There are some in the PHBs, one generic in the
XIVE itself, and one in the PSI bridge. Those contain the PQ bits and
thus the trigger & coalescing logic. They effectively shoot an MMIO to
the virtualization controller on events.

 - Virtualization controller (one per chip). This receives the above
MMIOs from the sources, manages the IVEs to get the target queue and
remap the number, and manages the queues. When a queue is enabled for
notification (or escalation) and such an event occurs, an MMIO goes to
the corresponding presentation controller.

 - Presentation controller (one per chip). This receives the above
notifications and sets as a result the IPB bits for one of the 8
priorities. Basically this guy tracks a single pending bit per priority
for each VP indicating whether there's something in the queue for that
priority and delivers interrupts to the core accordingly.


Now this is a simplified view. The PC supports groups but we don't
handle that yet, there are escalation interrupts, there are
redistribution mechanisms etc... but for now you get the basic idea.

Cheers,
Ben.
