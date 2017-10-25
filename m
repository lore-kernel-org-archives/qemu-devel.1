Received: from eggs.gnu.org ([2001:4830:134:3::10]:33964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e7FdT-0005uc-GG
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 02:57:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e7FdO-0006rG-MC
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 02:57:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56330)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e7FdO-0006qQ-Cs
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 02:57:50 -0400
Date: Wed, 25 Oct 2017 08:57:43 +0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171025065743.GA7706@localhost.localdomain>
References: <20171017092702.5b82103b@nial.brq.redhat.com>
	<20171017150759.GB31897@redhat.com>
	<20171017180635.6a900616@nial.brq.redhat.com>
	<20171018153010.GL9719@redhat.com>
	<20171018202240.GD2942@localhost.localdomain>
	<20171019114954.GC13245@umbus>
	<58846850-bbe2-e1c4-2235-58b3f6709ba6@redhat.com>
	<20171020012130.GG13245@umbus>
	<20171020195309.GV2942@localhost.localdomain>
	<20171023104541.4963fcc4@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171023104541.4963fcc4@nial.brq.redhat.com>
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
To: Igor Mammedov <imammedo@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, peter.maydell@linaro.org, pkrempa@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com

On Mon, Oct 23, 2017 at 10:45:41AM +0200, Igor Mammedov wrote:
> On Fri, 20 Oct 2017 17:53:09 -0200
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > On Fri, Oct 20, 2017 at 12:21:30PM +1100, David Gibson wrote:
> > > On Thu, Oct 19, 2017 at 02:23:04PM +0200, Paolo Bonzini wrote:  
> > > > On 19/10/2017 13:49, David Gibson wrote:  
> > > > > Note that describing socket/core/thread tuples as arch independent (or
> > > > > even machine independent) is.. debatable.  I mean it's flexible enough
> > > > > that most platforms can be fit to that scheme without too much
> > > > > straining.  But, there's no arch independent way of defining what each
> > > > > level means in terms of its properties.
> > > > > 
> > > > > So, for example, on spapr - being paravirt - there's no real
> > > > > distinction between cores and sockets, how you divide them up is
> > > > > completely arbitrary.  
> > > > 
> > > > Same on x86, actually.
> > > > 
> > > > It's _common_ that cores on the same socket share L3 cache and that a
> > > > socket spans an integer number of NUMA nodes, but it doesn't have to be
> > > > that way.
> > > > 
> > > > QEMU currently enforces the former (if it tells the guest at all that
> > > > there is an L3 cache), but not the latter.  
> > > 
> > > Ok.  Correct me if I'm wrong, but doesn't ACPI describe the NUMA
> > > architecture in terms of this thread/core/socket heirarchy?  That's
> > > not true for PAPR, where the NUMA topology is described in an
> > > independent set of (potentially arbitrarily nested) nodes.  
> > 
> > On PC, ACPI NUMA information only refer to CPU APIC IDs, which
> > identify individual CPU threads; it doesn't care about CPU
> > socket/core/thread topology.  If I'm not mistaken, the
> > socket/core/thread topology is not represented in ACPI at all.
> ACPI does node mapping per logical cpu (thread) in SRAT table,
> so virtually we are able to describe insane configurations.
> That however doesn't mean that we should go outside of
> what real hw does and confuse guest which may have certain
> expectations.

Agreed.

> 
> Currently for x86 expectations are that cpus are mapped to numa
> nodes either by whole cores or whole sockets (AMD and Intel cpus
> respectively). In future it might change.
> 
> 
> > Some guest OSes, however, may get very confused if they see an
> > unexpected NUMA/CPU topology.  IIRC, it was possible to make old
> > Linux kernel versions panic by generating a weird topology.
> 
> There where bugs that where fixed on QEMU or guest kernel side
> when unexpected mapping were present. While we can 'fix' guest
> expectation in linux kernel it might be not possible for other
> OSes one more reason we shouldn't allow blind assignment by mgmt.

One problem with blocking arbitrary assignment is the possibility
of breaking existing VM configurations.  We could enforce the new
rules only on newer machine-types, although this means an
existing VM configuration may stop being runnable after updating
the machine-type.

-- 
Eduardo
