Received: from eggs.gnu.org ([2001:4830:134:3::10]:50568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ffUko-0000EU-TB
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 14:31:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ffUkl-0002Iw-Lq
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 14:31:18 -0400
Date: Tue, 17 Jul 2018 19:31:10 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180717183109.GF2383@work-vm>
References: <152949925592.606785.4717120428688653960.stgit@bahia.lan>
	<20180621011809.GD32328@umbus.fritz.box>
	<20180621152321.3ab81d51@bahia.lan>
	<20180717105006.GA2272@umbus.fritz.box>
	<153184694309.16660.1687761920219675996@sif>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153184694309.16660.1687761920219675996@sif>
Subject: Re: [Qemu-devel] [PATCH v2 for-2.11.2] spapr: make pseries-2.11 the
 default machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, Thomas Huth <thuth@redhat.com>, qemu-stable@nongnu.org, qemu-devel@nongnu.org

* Michael Roth (mdroth@linux.vnet.ibm.com) wrote:
> Quoting David Gibson (2018-07-17 05:50:06)
> > On Thu, Jun 21, 2018 at 03:23:21PM +0200, Greg Kurz wrote:
> > > On Thu, 21 Jun 2018 11:18:09 +1000
> > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > 
> > > > On Wed, Jun 20, 2018 at 02:54:15PM +0200, Greg Kurz wrote:
> > > > > The spapr capability framework was introduced in QEMU 2.12. It allows
> > > > > to have an explicit control on how host features are exposed to the
> > > > > guest. This is especially needed to handle migration between hetero-
> > > > > geneous hosts (eg, POWER8 to POWER9). It is also used to expose fixes/
> > > > > workarounds against speculative execution vulnerabilities to guests.
> > > > > The framework was hence backported to QEMU 2.11.1, especially these
> > > > > commits:
> > > > > 
> > > > > 0fac4aa93074 spapr: Add pseries-2.12 machine type
> > > > > 9070f408f491 spapr: Treat Hardware Transactional Memory (HTM) as an
> > > > >  optional capability
> > > > > 
> > > > > 0fac4aa93074 has the confusing effect of making pseries-2.12 the default
> > > > > machine type for QEMU 2.11.1, instead of the expected pseries-2.11. This
> > > > > patch changes the default machine back to pseries-2.11.
> > > > > 
> > > > > Unfortunately, 9070f408f491 enforces the HTM capability for pseries-2.11
> > > > > to be enabled by default, ie, when not passing cap-htm on the command
> > > > > line. This breaks several 'make check' testcases that run qemu-system-ppc64
> > > > > with TCG.
> > > > > 
> > > > > The only sane way to fix this is to adapt the impacted testcases so that
> > > > > they all pass cap-htm=off in this case. This patch does that as well.
> > > > > 
> > > > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > > > ---
> > > > > v2: - have the testcases to pass cap-htm=off instead of violating the
> > > > >       capabilities logic.
> > > > > 
> > > > > Upstream doesn't need anything like that since newer pseries machine types
> > > > > start with HTM disabled by default. This is really a oneshot fix for 2.11.2,
> > > > > and I've tried to make it as small as possible.
> > > > > 
> > > > > This is a full replacement of the previous version. It is based on Mike's
> > > > > staging tree for 2.11:  
> > > > 
> > > > Thanks for fixing this up
> > > > 
> > > > Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> > > > 
> > > > Btw, 2.11.z should probably have the 2.12 machine type removed
> > > > entirely, as well as (obviously) not being the default.  Not within
> > > > scope for this patch, though.
> > > > 
> > > 
> > > Well... it is indeed weird but I don't think it hurts. Also, people
> > > may have started using pseries-2.12 with QEMU 2.11.1 (I seem to
> > > remember Mike told me about something like this the other day)...
> > 
> > I came back to thinking about this and realized this is a terrible
> > idea.  The problem is that because of the way we define the latest
> > machine type, then backwards compat props for the earlier ones, it's
> > very likely that the "pseries-2.12" in 2.11 won't be the same as
> > pseries-2.12 in 2.12, simply because 2.11 won't have the necessary
> > features to implement pseries-2.12 as in 2.12.
> 
> What I saw was likely a holdover from early Ubuntu 18.04 p9 testing
> before HTM emulation had made it's way into their kernel. In that
> particular case Ubuntu doesn't support it at all now, but it remains
> the only option for anyone else who happens to find themselves in
> that situation and doesn't have a libvirt/Openstack with appropriate
> machine capabilities.
> 
> Given that it was at least possible to run that config (however
> broken) with QEMU 2.11.0, it seemed fair to leave some sort of
> "out". But really it just seems like we don't have much to gain
> by removing it at this point.

It may confuse people trying to migrate from 2.11.1 to 2.12

Dave

> I agree in general though and probably would've handled this
> differently if I'd thought through it a bit more.
> 
> > 
> > 
> > -- 
> > David Gibson                    | I'll have my music baroque, and my code
> > david AT gibson.dropbear.id.au  | minimalist, thank you.  NOT _the_ _other_
> >                                 | _way_ _around_!
> > http://www.ozlabs.org/~dgibson
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
