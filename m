Received: from eggs.gnu.org ([2001:4830:134:3::10]:54006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cP7F5-0005ny-QX
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 07:34:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cP7F2-0004uy-NL
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 07:34:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35998)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cP7F2-0004ua-F3
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 07:34:00 -0500
Date: Thu, 5 Jan 2017 12:33:51 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170105123351.GF3292@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1482866480-26208-1-git-send-email-ehabkost@redhat.com>
	<1482866480-26208-5-git-send-email-ehabkost@redhat.com>
	<20170104115656.GB14961@amt.cnet>
	<20170104133916.GG3315@thinpad.lan.raisama.net>
	<20170104195917.GM3315@thinpad.lan.raisama.net>
	<20170104222623.GA21789@amt.cnet>
	<20170105013631.GO3315@thinpad.lan.raisama.net>
	<20170105104830.GB6299@amt.cnet>
	<20170105121950.GP3315@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170105121950.GP3315@thinpad.lan.raisama.net>
Subject: Re: [Qemu-devel] [libvirt] TSC frequency configuration & invtsc
 migration (was Re: [PATCH 4/4] kvm: Allow migration with invtsc)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, libvir-list@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, Haozhong Zhang <haozhong.zhang@intel.com>

On Thu, Jan 05, 2017 at 10:19:50AM -0200, Eduardo Habkost wrote:
> On Thu, Jan 05, 2017 at 08:48:32AM -0200, Marcelo Tosatti wrote:
> > On Wed, Jan 04, 2017 at 11:36:31PM -0200, Eduardo Habkost wrote:
> > > I am considering two possible scenarios below. You probably have
> > > another scenario in mind, so it would be useful if you could
> > > describe it so we can consider possible solutions.
> > > 
> > > 
> > > Scenario 1:
> > > 
> > > You have two hosts: A and B, both with TSC scaling. They have
> > > different frequencies. The VM can be started on either one of
> > > them, and can be migrated to either one depending on the policy
> > > of management software.
> > > 
> > > Maybe B is a backup host, the VM is expected to run most times on
> > > host A, and we want to use the TSC frequency from host A every
> > > time. Maybe it's the opposite and we want to use the frequency of
> > > B. Maybe we want to use the lowest frequency of both, maybe the
> > > highest one. We (QEMU developers) can recommend policy to libvirt
> > > developers, but a given QEMU process doesn't have information to
> > > decide what's best.
> > 
> > I can't see any practical scenario here, you will always want
> > to start with TSC frequency of the host where the VM was started.
> > 
> > If i am mistaken, please describe a practical case.
> > 
> > (If a practical scenario comes up, and there is a use-case
> > for setting the TSC frequency on startup, lets say 
> > a Windows VM which fails to boot if the TSC frequency
> > is too high, then it should be supported... But the
> > only known scenario to me, applying to 99.999% of cases, 
> > is to expose the TSC frequency where the guest booted at).
> 
> I don't have any specific case: my point is that I can't tell
> what's the best frequency if I don't know where the hosts are
> expected to be migrated to.
> 
> You claim that using the starting host frequency is the best
> option on the vast majority of cases. Maybe it's true, and it
> would be a good default. The only problem is that this default
> affects migratability:

Yep, this is the same scenario as CPU model choice. While
using "host" model may be a reasonable default if all the
hosts in your cluster use identical CPUs. If you have a
mix of CPUs though, and you care about migration, you'll
want to determine a common denominator instead. The same
applies to TSC frequency choice.

So from that POV, the libvirt capabilities XML for a host
needs to have a way to report the supported TSC frequency
for the host. The mgmt app can then figure out what explicit
TSC freq to set for guests that need to be migratable to
maximise runnability across the hosts.

> > > Scenario 2:
> > > 
> > > Host A has TSC scaling, host B doesn't have TSC scaling. We want
> > > to be able to start the VM on host A, and migrate to B. In this
> > > case, the only possible solution is to use B's frequency when
> > > starting the VM. The QEMU process doesn't have enough information
> > > to make that decision.
> > 
> > That is a good point. But again, its a special case and 
> > should be supported by -cpu xxx,tsc-frequency=zzzz.
> > 
> > However, for the vast majority of 99.999% cases, the issue
> > can be handled entirely in QEMU, without libvirt involvement,
> > and without adding extra steps to the management software.
> 
> I agree it should cover most cases. The only problem here is that
> it can break migration in unexpected ways.
> 
> Then my point is: assuming that libvirt will prefer to require
> explicit TSC frequency configuration to enable invtsc migration
> (instead of getting unpredictable migration compatibility), is
> the added complexity to migration code worth the effort, if
> choosing an explicit frequency is safer and more predictable? I
> believe this is where we disagree.

I believe that if libvirt detects that QEMU supports the 'tsc-frequency'
option, then libvirt should set it by default in the XML, if not already
set by the mgmt app. That way, libvirt can validate TSC freq comapt
for migration before it even launches QEMU in the target host.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
