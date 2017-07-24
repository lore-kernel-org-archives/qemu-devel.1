Received: from eggs.gnu.org ([2001:4830:134:3::10]:60113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1dZZAn-0005ck-BO
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 04:57:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1dZZAj-0002Hu-Fy
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 04:57:05 -0400
Message-ID: <1500886589.10674.73.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 24 Jul 2017 18:56:29 +1000
In-Reply-To: <20170724042956.GD17228@umbus.fritz.box>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-8-git-send-email-clg@kaod.org>
	<20170724042956.GD17228@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 07/26] ppc/xive: add MMIO handlers to
 the XIVE interrupt source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Mon, 2017-07-24 at 14:29 +1000, David Gibson wrote:
> > +    case XIVE_ESB_SET_PQ_00:
> > +    case XIVE_ESB_SET_PQ_01:
> > +    case XIVE_ESB_SET_PQ_10:
> > +    case XIVE_ESB_SET_PQ_11:
> > +        ret = xive_pq_get(x, lisn);
> > +        xive_pq_set(x, lisn, (offset >> 8) & 0x3);
> 
> Again I'd prefer xive_pq_set() return the old value itself, for more
> obvious atomicity.

Agreed.  That will also help with StoreEOI (store to 0x400 of the EOI
page) which does an EOI then re-sends an interrupt if the old value was
11 (while the load EOI doesn't resend).

Cheers,
Ben.
