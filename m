Received: from eggs.gnu.org ([2001:4830:134:3::10]:43522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1dxTwP-0004U1-21
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 04:13:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1dxTwL-0004ei-2w
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 04:13:05 -0400
Message-ID: <1506586359.25626.11.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 28 Sep 2017 10:12:39 +0200
In-Reply-To: <20170920063416.GM5520@umbus.fritz.box>
References: <20170911171235.29331-1-clg@kaod.org>
	<20170911171235.29331-12-clg@kaod.org> <20170919074556.GO27153@umbus>
	<2d91c586-ff31-ceb8-bee6-6d4531d1b5c0@kaod.org>
	<20170920063416.GM5520@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 11/21] ppc/xive: push the EQ data in
 OS event queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>

On Wed, 2017-09-20 at 16:34 +1000, David Gibson wrote:
> > >> +    if (GETFIELD(EQ_W6_FORMAT_BIT, eq->w6) == 0) {
> > >> +        priority = GETFIELD(EQ_W7_F0_PRIORITY, eq->w7);
> > >>  
> > >> +        /* The EQ is masked. Can this happen ?  */
> > >> +        if (priority == 0xff) {
> > >> +            return;
> > > 
> > > How does the 8-bit priority field here interact with the 3-bit
> > > priority which selects which EQ to use?
> > 
> > priority OxFF is a special case kept for masking, see the hcall 
> > h_int_set_source_config. It should never reach the EQ lookup 
> > routines. So may be an assert would be better here.
> 
> Ok, if this situation can't be guest triggered, only by a bug in the
> rest of the XIVE code, then an assert() is better.

Note: this doesn't match HW. However there's a mask bit in the EAS.

The problem when masking that way of course is that you lose triggers,
ie P gets set, the interrupt lost, and nobody will clear P.

Cheers,
Ben.
