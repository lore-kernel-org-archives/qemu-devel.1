Received: from eggs.gnu.org ([2001:4830:134:3::10]:52956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mtosatti@redhat.com>) id 1fTujh-0004ni-CO
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:50:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mtosatti@redhat.com>) id 1fTujc-00007H-GV
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:50:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44060)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mtosatti@redhat.com>) id 1fTujc-000067-6o
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:50:12 -0400
Date: Fri, 15 Jun 2018 15:32:27 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
Message-ID: <20180615183224.GA6108@amt.cnet>
References: <20180612184616.90838-1-mst@redhat.com>
	<20180613223449.GA18339@amt.cnet>
	<20180614022834-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180614022834-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] kvm: x86 CPU power management
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org

On Thu, Jun 14, 2018 at 02:37:28AM +0300, Michael S. Tsirkin wrote:
> On Wed, Jun 13, 2018 at 07:34:53PM -0300, Marcelo Tosatti wrote:
> > On Tue, Jun 12, 2018 at 09:47:11PM +0300, Michael S. Tsirkin wrote:
> > > This adds ability to expose host CPU power management capabilities to
> > > guests. For intel guests, this is sufficient for guest to enable
> > > low power CPU power management. For AMD guests it isn't sufficient,
> > > deeper C-states are entered using System-IO.
> > > 
> > > mwait based power management is tied closely to specifics of CPUID,
> > > making migration challenging. At this point only the non-migrateable
> > > -cpu host is supported.
> > > 
> > > With this patch applied, VM latency is within the noise of
> > > baremetal for some benchmarks.
> > > 
> > > perf bench sched pipe results:
> > > Before:
> > >     6.452 sec
> > > After:
> > >     4.382 sec
> > > Baremetal:
> > >     4.136 sec
> > > 
> > > Michael S. Tsirkin (2):
> > >   kvm: support -realtime cpu-pm=on|off
> > >   i386/cpu: make -cpu host support monitor/mwait
> > > 
> > >  include/sysemu/sysemu.h |  1 +
> > >  target/i386/cpu.h       |  9 +++++++++
> > >  target/i386/cpu.c       | 19 ++++++++++++++-----
> > >  target/i386/kvm.c       | 30 ++++++++++++++++++++++++++++++
> > >  vl.c                    |  6 ++++++
> > >  qemu-options.hx         |  9 +++++++--
> > >  6 files changed, 67 insertions(+), 7 deletions(-)
> > > 
> > > -- 
> > > MST
> > 
> > Hi Michael,
> > 
> > 1) Command line option interface
> > 
> > Why is this not an optional cpu feature such as the other features? 
> > 
> > 
> > -cpu CPU,+mwait  
> > 
> > rather than a separate, architecture independent "-realtime cpu-pm=on|off" 
> > command line option?
> 
> Because it's not just a guest flag. With guest pm on, one guest
> can severely affect the latency of others on the same host CPU.

How so ?

> > 2) Migration
> > 
> > Isnt it sufficient to check that both CPUID leafs are the same, 
> > to allow migration ?
> 
> Not at the moment since linux guests use mwait hints and latency values
> from a table in intel_idle.  If the host and guest models do not match,
> mwait will get a wrong hint.
> 
> It will not do the right thing then!
> 
> You want exactly the same host CPU for it to work.
> 
> This isn't different from how -host cpu works generally.

Ok, makes sense.

> > 1. Check that the processor supports MONITOR and MWAIT. If
> > CPUID.01H:ECX.MONITOR[bit 3] = 1, MONITOR and MWAIT are available at
> > ring 0.
> > 
> > 2. Query the smallest and largest line size that MONITOR uses.
> > Use CPUID.05H:EAX.smallest[bits 15:0];EBX.largest[bits15:0]. 
> > 
