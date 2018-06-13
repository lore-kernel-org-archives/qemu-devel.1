Received: from eggs.gnu.org ([2001:4830:134:3::10]:38464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fTAZc-0007ZC-IX
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 14:32:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fTAZX-0000KH-IN
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 14:32:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fTAZX-0000It-B7
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 14:32:43 -0400
Date: Wed, 13 Jun 2018 15:32:39 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180613183239.GH7451@localhost.localdomain>
References: <20180608205830.308627-1-mst@redhat.com>
	<20180612145605.50f64965@redhat.com>
	<20180612155708-mutt-send-email-mst@kernel.org>
	<20180612155803.4ca0d137@redhat.com>
	<20180612144922.GJ7451@localhost.localdomain>
	<20180613105543.32e58e99@redhat.com>
	<20180613211921-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180613211921-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [RFC untested PATCH] i386/cpu: make -cpu host
 support monitor/mwait
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Wed, Jun 13, 2018 at 09:22:10PM +0300, Michael S. Tsirkin wrote:
> On Wed, Jun 13, 2018 at 10:55:43AM +0200, Igor Mammedov wrote:
> > On Tue, 12 Jun 2018 11:49:22 -0300
> > Eduardo Habkost <ehabkost@redhat.com> wrote:
> > 
> > > On Tue, Jun 12, 2018 at 03:58:03PM +0200, Igor Mammedov wrote:
> > > [...]
> > > > > > > +    if (xcc->host_cpuid_required && enable_cpu_pm) {
> > > > > > > +        host_cpuid(5, 0, &cpu->mwait.eax, &cpu->mwait.ebx,
> > > > > > > +                   &cpu->mwait.ecx, &cpu->mwait.edx);
> > > > > > > +    }    
> > [...]
> > > > > > also max_x86_cpu_initfn() might be better place for filling it up.  
> > > 
> > > Why?
> > I've missed 'enable_cpu_pm' which is probably a property,
> > so yep it can't go into initfn.
> > 
> > However if we not going to migrate this state or use outside of
> > cpu_x86_cpuid(), I don't see why we should add it to X86CPU state
> > and keep around.
> > We can query it on demand from cpu_x86_cpuid() like we do for
> > PMU leaf.
> 
> We can do it but the annoying thing is that it spreads
> the info around as we also need to set CPUID_EXT_MONITOR.
> 
> This way we set all the info in one place on realize.

I agree.  It also makes it easier to make the flags configurable
in the future.

We may eventually move the host-cache-info code to realizefn in
the future, too (if we want to make it work with VCPU topologies
that don't match the host exactly).

-- 
Eduardo
