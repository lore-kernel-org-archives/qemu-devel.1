Received: from eggs.gnu.org ([2001:4830:134:3::10]:59295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1dVBPF-0001GU-6R
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 02:45:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1dVBPE-0004UW-4h
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 02:45:53 -0400
Message-ID: <1499841917.20288.2.camel@gmail.com>
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Wed, 12 Jul 2017 16:45:17 +1000
In-Reply-To: <20170703092007.GW13989@umbus.fritz.box>
References: <20170629045940.11242-1-sjitindarsingh@gmail.com>
	<20170630040317.GA13989@umbus.fritz.box>
	<1499051918.2398.1.camel@gmail.com>
	<20170703092007.GW13989@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] target/ppc: Only set PCR in kvm if
 actually in a compat mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, agraf@suse.de, qemu-devel@nongnu.org

On Mon, 2017-07-03 at 19:20 +1000, David Gibson wrote:
> On Mon, Jul 03, 2017 at 01:18:38PM +1000, Suraj Jitindar Singh wrote:
> > On Fri, 2017-06-30 at 14:03 +1000, David Gibson wrote:
> > > On Thu, Jun 29, 2017 at 02:59:39PM +1000, Suraj Jitindar Singh
> > > wrote:
> > > > The Processor Compatibility Register (PCR) I used to set the
> > > > compatibility mode of the processor using the SET_ONE_REG ioctl
> > > > on
> > > > KVM_REG_PPC_ARCH_COMPAT. Previously this was only called when a
> > > > compat
> > > > mode was actually in use, however a recent patch made it
> > > > unconditional.
> > > > Calling this in KVM_PR fails as there is no handler for that
> > > > call
> > > > and it
> > > > is thus impossible to start a machine with KVM_PR.
> > > > 
> > > > Change ppc_set_compat() so that the ioctl is only actually
> > > > called
> > > > if a
> > > > compat mode is in use. This means that a KVM_PR guest can boot.
> > > > Additionally the current behaviour for KVM_HV is preserved
> > > > where a
> > > > compat
> > > > mode of 0 set pcr and arch_compat in the vcore struct to zero,
> > > > both
> > > > of
> > > > which are initialised to zero anyway.
> > > > 
> > > > Fixes: 37f516defa2e ("pseries: Reset CPU compatibility mode")
> > > > 
> > > > Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> > > 
> > > This doesn't seem quite right.  With this change, how would we
> > > ever
> > > turn compatibility mode _off_ (which could happen on reset if
> > > nothing
> > 
> > Oh yeah, didn't really think about that.
> > 
> > > else).  Really we should add this pseudo-register to KVM PR,
> > > although
> > > I'm fine with also having a qemu workaround to let it work with
> > > older
> > > PR versions.
> > 
> > How do you feel about having a check and only calling the ioctl if
> > the
> > KVM in use is HV?
> 
> Don't really like it.  For one thing, we want to avoid explicitly
> checking for KVM PR - we should check specific capabilities instead.
> For another, it means on PR we're silently ignoring the compatibility
> mode which isn't really right.
> 
> I think the right approach here is to only call the ioctl() if the
> compatibility mode has actually changed.  That should make it work in
> the cases the original patch did, which is.. actually very few, given
> the new CAS logic.

I think this is the right approach. There is no point calling the ioctl
if nothing changed. Additionally this fixes KVM_PR in the interim
assuming no max-cpu-compat is specified on the command line.

> 
> Really the right fix is to implement the set compat mode ioctl() in
> KVM PR.

This would be the ideal fix however I suggest the implementation of
that would be to simply ignore it- given the main use case of KVM_PR is
nested and that means we can't actually set the PCR since it's
hypervisor privileged.

> 


Suraj
