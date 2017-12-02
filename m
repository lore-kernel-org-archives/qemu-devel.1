Received: from eggs.gnu.org ([2001:4830:134:3::10]:36199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1eL8iF-0000um-Bo
	for qemu-devel@nongnu.org; Sat, 02 Dec 2017 09:24:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1eL8iA-0000rv-Dj
	for qemu-devel@nongnu.org; Sat, 02 Dec 2017 09:24:15 -0500
Message-ID: <1512224624.2224.51.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sat, 02 Dec 2017 08:23:44 -0600
In-Reply-To: <20171128063827.GP11775@umbus.fritz.box>
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-11-clg@kaod.org>
	<20171128063827.GP11775@umbus.fritz.box>
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Tue, 2017-11-28 at 17:38 +1100, David Gibson wrote:
> Hrm.  I don't love that you're dealing with clearing that LSI bit
> here, but setting it at a different level.
> 
> The state machines are doing my head in a bit, is there any way
> you could derive the STATUS_SENT bit from the PQ bits?

Yeah it should be...

So you should normally need only one extra bit of state for LSI which
is whether it's asserted or not and no extra bit of state for MSIs.

P is basically "sent". Q is whether another event has been queued up
(and is only meaningful for MSIs though the 01 combination will mask
LSIs too).

The state logic should be for MSIs on event:

	- if PQ=01 ignore (masked)
	- if P=1, set Q and finish
	- set P=1 and forward event to IVE

For EOI (load and store):

	- if PQ=01 ignore
	- P=Q, Q=0
	- (storeEOI only) if new P=1, forward event to IVE
 
For LSIs, and "event" is whenever the state is asserted, and Q is
meaningless, so basically on every change of state or ESB:

	- if PQ=01 ignore (masked)
	- if P=1 finish
	- set P=1 and forward event to IVE

For EOI (load and store):

	- if PQ=01 ignore
	- clear P
	- re-evaluate as above if asserted

Cheers,
Ben.
