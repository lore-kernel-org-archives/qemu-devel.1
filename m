Received: from eggs.gnu.org ([2001:4830:134:3::10]:42863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e5dM6-0003bT-8z
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 15:53:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e5dM1-0003G8-DY
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 15:53:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47936)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e5dM1-0003G2-7P
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 15:53:13 -0400
Date: Fri, 20 Oct 2017 17:53:09 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171020195309.GV2942@localhost.localdomain>
References: <1508170976-96869-1-git-send-email-imammedo@redhat.com>
	<20171016163636.GI11975@redhat.com>
	<20171017092702.5b82103b@nial.brq.redhat.com>
	<20171017150759.GB31897@redhat.com>
	<20171017180635.6a900616@nial.brq.redhat.com>
	<20171018153010.GL9719@redhat.com>
	<20171018202240.GD2942@localhost.localdomain>
	<20171019114954.GC13245@umbus>
	<58846850-bbe2-e1c4-2235-58b3f6709ba6@redhat.com>
	<20171020012130.GG13245@umbus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171020012130.GG13245@umbus>
Subject: Re: [Qemu-devel] [RFC 0/6] enable numa configuration before
 machine_init() from HMP/QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Igor Mammedov <imammedo@redhat.com>, peter.maydell@linaro.org, pkrempa@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com

On Fri, Oct 20, 2017 at 12:21:30PM +1100, David Gibson wrote:
> On Thu, Oct 19, 2017 at 02:23:04PM +0200, Paolo Bonzini wrote:
> > On 19/10/2017 13:49, David Gibson wrote:
> > > Note that describing socket/core/thread tuples as arch independent (or
> > > even machine independent) is.. debatable.  I mean it's flexible enough
> > > that most platforms can be fit to that scheme without too much
> > > straining.  But, there's no arch independent way of defining what each
> > > level means in terms of its properties.
> > > 
> > > So, for example, on spapr - being paravirt - there's no real
> > > distinction between cores and sockets, how you divide them up is
> > > completely arbitrary.
> > 
> > Same on x86, actually.
> > 
> > It's _common_ that cores on the same socket share L3 cache and that a
> > socket spans an integer number of NUMA nodes, but it doesn't have to be
> > that way.
> > 
> > QEMU currently enforces the former (if it tells the guest at all that
> > there is an L3 cache), but not the latter.
> 
> Ok.  Correct me if I'm wrong, but doesn't ACPI describe the NUMA
> architecture in terms of this thread/core/socket heirarchy?  That's
> not true for PAPR, where the NUMA topology is described in an
> independent set of (potentially arbitrarily nested) nodes.

On PC, ACPI NUMA information only refer to CPU APIC IDs, which
identify individual CPU threads; it doesn't care about CPU
socket/core/thread topology.  If I'm not mistaken, the
socket/core/thread topology is not represented in ACPI at all.

Some guest OSes, however, may get very confused if they see an
unexpected NUMA/CPU topology.  IIRC, it was possible to make old
Linux kernel versions panic by generating a weird topology.

-- 
Eduardo
