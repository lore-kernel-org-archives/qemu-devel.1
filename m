Received: from eggs.gnu.org ([2001:4830:134:3::10]:60932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cP7pm-00088V-Ak
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 08:11:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cP7pj-0005Fx-3N
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 08:11:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cP7pi-0005Fq-RO
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 08:11:55 -0500
Date: Thu, 5 Jan 2017 11:11:51 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170105131151.GS3315@thinpad.lan.raisama.net>
References: <20170104115656.GB14961@amt.cnet>
	<20170104133916.GG3315@thinpad.lan.raisama.net>
	<20170104195917.GM3315@thinpad.lan.raisama.net>
	<20170104222623.GA21789@amt.cnet>
	<20170105013631.GO3315@thinpad.lan.raisama.net>
	<20170105104830.GB6299@amt.cnet>
	<20170105121950.GP3315@thinpad.lan.raisama.net>
	<20170105123351.GF3292@redhat.com>
	<20170105124857.GQ3315@thinpad.lan.raisama.net>
	<20170105130032.GJ3292@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170105130032.GJ3292@redhat.com>
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, libvir-list@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, Haozhong Zhang <haozhong.zhang@intel.com>

On Thu, Jan 05, 2017 at 01:00:32PM +0000, Daniel P. Berrange wrote:
> On Thu, Jan 05, 2017 at 10:48:57AM -0200, Eduardo Habkost wrote:
> > On Thu, Jan 05, 2017 at 12:33:51PM +0000, Daniel P. Berrange wrote:
> > > On Thu, Jan 05, 2017 at 10:19:50AM -0200, Eduardo Habkost wrote:
> > > > On Thu, Jan 05, 2017 at 08:48:32AM -0200, Marcelo Tosatti wrote:
> > > > > On Wed, Jan 04, 2017 at 11:36:31PM -0200, Eduardo Habkost wrote:
> > [...]
> > > > > > Scenario 2:
> > > > > > 
> > > > > > Host A has TSC scaling, host B doesn't have TSC scaling. We want
> > > > > > to be able to start the VM on host A, and migrate to B. In this
> > > > > > case, the only possible solution is to use B's frequency when
> > > > > > starting the VM. The QEMU process doesn't have enough information
> > > > > > to make that decision.
> > > > > 
> > > > > That is a good point. But again, its a special case and 
> > > > > should be supported by -cpu xxx,tsc-frequency=zzzz.
> > > > > 
> > > > > However, for the vast majority of 99.999% cases, the issue
> > > > > can be handled entirely in QEMU, without libvirt involvement,
> > > > > and without adding extra steps to the management software.
> > > > 
> > > > I agree it should cover most cases. The only problem here is that
> > > > it can break migration in unexpected ways.
> > > > 
> > > > Then my point is: assuming that libvirt will prefer to require
> > > > explicit TSC frequency configuration to enable invtsc migration
> > > > (instead of getting unpredictable migration compatibility), is
> > > > the added complexity to migration code worth the effort, if
> > > > choosing an explicit frequency is safer and more predictable? I
> > > > believe this is where we disagree.
> > > 
> > > I believe that if libvirt detects that QEMU supports the 'tsc-frequency'
> > > option, then libvirt should set it by default in the XML, if not already
> > > set by the mgmt app. That way, libvirt can validate TSC freq comapt
> > > for migration before it even launches QEMU in the target host.
> > 
> > If you do this unconditionally, you have another problem: if
> > tsc-frequency is set explicitly, migration is only possible if
> > TSC frequency of the destination matches[1], or if TSC scaling is
> > supported by the destination. It's a good idea to set a TSC
> > frequency only if invtsc is enabled explicitly in the config.
> 
> If we don't set tsc-frequency and the TSC frequency doesn't
> match, does that mean the guest migration succeed, but suddenly
> sees different TSC frequency ?

If TSC scaling is unavailable, yes. If the destination host
supports TSC scaling, we automatically keep the original TSC
frequency on migration.

> 
> I guess we we allowed that historically we can't break that
> now, so setting it only if invtsc is set seems reasonable.

I don't think we really had a choice, KVM would be much less
useful if we didn't allow migration between hosts with different
frequencies.

> 
> > 
> > [1] Currently the frequency needs to match exactly. That's a
> > separate issue: we should probably add a knob to allow a slight
> > variation in TSC frequency (e.g. <1% difference).
> 
> Regards,
> Daniel
> -- 
> |: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
> |: http://libvirt.org              -o-             http://virt-manager.org :|
> |: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|

-- 
Eduardo
