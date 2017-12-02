Received: from eggs.gnu.org ([2001:4830:134:3::10]:43694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1eL8yi-0000Yy-5W
	for qemu-devel@nongnu.org; Sat, 02 Dec 2017 09:41:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1eL8yg-0000mV-OM
	for qemu-devel@nongnu.org; Sat, 02 Dec 2017 09:41:16 -0500
Message-ID: <1512225658.2224.66.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sat, 02 Dec 2017 08:40:58 -0600
In-Reply-To: <20171130050049.GD3023@umbus.fritz.box>
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-16-clg@kaod.org>
	<20171130050049.GD3023@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 15/25] spapr: notify the CPU when the XIVE
 interrupt priority is more privileged
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

On Thu, 2017-11-30 at 16:00 +1100, David Gibson wrote:
> 
> >  static uint64_t spapr_xive_icp_accept(sPAPRXiveICP *icp)
> >  {
> > -    return 0;
> > +    uint8_t nsr = icp->tima_os[TM_NSR];
> > +
> > +    qemu_irq_lower(icp->output);
> > +
> > +    if (icp->tima_os[TM_NSR] & TM_QW1_NSR_EO) {
> > +        uint8_t cppr = icp->tima_os[TM_PIPR];
> > +
> > +        icp->tima_os[TM_CPPR] = cppr;
> > +
> > +        /* Reset the pending buffer bit */
> > +        icp->tima_os[TM_IPB] &= ~priority_to_ipb(cppr);
> 
> What if multiple irqs of the same priority were queued?

It's the job of the OS to handle that case by consuming from the queue
until it's empty. There is an MMIO the guest can use if it wants to
that can set the IPB bits back to 1 for a given priority. Otherwise in
Linux we just have a SW way to force a replay.

> > +        icp->tima_os[TM_PIPR] = ipb_to_pipr(icp->tima_os[TM_IPB]);
> > +
> > +        /* Drop Exception bit for OS */
> > +        icp->tima_os[TM_NSR] &= ~TM_QW1_NSR_EO;
> > +    }
> > +
> > +    return (nsr << 8) | icp->tima_os[TM_CPPR];
> > +}
> > +
> > +static void spapr_xive_icp_notify(sPAPRXiveICP *icp)
> > +{
> > +    if (icp->tima_os[TM_PIPR] < icp->tima_os[TM_CPPR]) {
> > +        icp->tima_os[TM_NSR] |= TM_QW1_NSR_EO;
> > +        qemu_irq_raise(icp->output);
> > +    }
> >  }
> >  
> >  static void spapr_xive_icp_set_cppr(sPAPRXiveICP *icp, uint8_t cppr)
> > @@ -51,6 +105,9 @@ static void spapr_xive_icp_set_cppr(sPAPRXiveICP *icp, uint8_t cppr)
> >      }
> >  
> >      icp->tima_os[TM_CPPR] = cppr;
> > +
> > +    /* CPPR has changed, inform the ICP which might raise an exception */
> > +    spapr_xive_icp_notify(icp);
> >  }
> >  
> >  /*
> > @@ -224,6 +281,8 @@ static void spapr_xive_irq(sPAPRXive *xive, int lisn)
> >      XiveEQ *eq;
> >      uint32_t eq_idx;
> >      uint8_t priority;
> > +    uint32_t server;
> > +    sPAPRXiveICP *icp;
> >  
> >      ive = spapr_xive_get_ive(xive, lisn);
> >      if (!ive || !(ive->w & IVE_VALID)) {
> > @@ -253,6 +312,13 @@ static void spapr_xive_irq(sPAPRXive *xive, int lisn)
> >          qemu_log_mask(LOG_UNIMP, "XIVE: !UCOND_NOTIFY not implemented\n");
> >      }
> >  
> > +    server = GETFIELD(EQ_W6_NVT_INDEX, eq->w6);
> > +    icp = spapr_xive_icp_get(xive, server);
> > +    if (!icp) {
> > +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No ICP for server %d\n", server);
> > +        return;
> > +    }
> > +
> >      if (GETFIELD(EQ_W6_FORMAT_BIT, eq->w6) == 0) {
> >          priority = GETFIELD(EQ_W7_F0_PRIORITY, eq->w7);
> >  
> > @@ -260,9 +326,18 @@ static void spapr_xive_irq(sPAPRXive *xive, int lisn)
> >          if (priority == 0xff) {
> >              g_assert_not_reached();
> >          }
> > +
> > +        /* Update the IPB (Interrupt Pending Buffer) with the priority
> > +         * of the new notification and inform the ICP, which will
> > +         * decide to raise the exception, or not, depending the CPPR.
> > +         */
> > +        icp->tima_os[TM_IPB] |= priority_to_ipb(priority);
> > +        icp->tima_os[TM_PIPR] = ipb_to_pipr(icp->tima_os[TM_IPB]);
> >      } else {
> >          qemu_log_mask(LOG_UNIMP, "XIVE: w7 format1 not implemented\n");
> >      }
> > +
> > +    spapr_xive_icp_notify(icp);
> >  }
> >  
> >  /*
> 
> 
