Received: from eggs.gnu.org ([2001:4830:134:3::10]:52169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cQFjB-000644-Dr
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 10:49:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cQFj7-0001T5-GY
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 10:49:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cQFj7-0001Qm-7z
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 10:49:45 -0500
Date: Sun, 8 Jan 2017 13:49:39 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170108154939.GW3315@thinpad.lan.raisama.net>
References: <1482866480-26208-1-git-send-email-ehabkost@redhat.com>
	<1482866480-26208-5-git-send-email-ehabkost@redhat.com>
	<20170104115656.GB14961@amt.cnet>
	<20170104133916.GG3315@thinpad.lan.raisama.net>
	<20170104195917.GM3315@thinpad.lan.raisama.net>
	<20170104222623.GA21789@amt.cnet>
	<20170105013631.GO3315@thinpad.lan.raisama.net>
	<20170105104830.GB6299@amt.cnet>
	<20170105121950.GP3315@thinpad.lan.raisama.net>
	<20170106103126.GA1575@amt.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170106103126.GA1575@amt.cnet>
Subject: [Qemu-devel] How to make dest host abort migration safely (was Re:
 [PATCH 4/4] kvm: Allow migration with invtsc)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Haozhong Zhang <haozhong.zhang@intel.com>, libvir-list@redhat.com, Juan Quintela <quintela@redhat.com>, Amit Shah <amit.shah@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Fri, Jan 06, 2017 at 08:31:27AM -0200, Marcelo Tosatti wrote:
> On Thu, Jan 05, 2017 at 10:19:50AM -0200, Eduardo Habkost wrote:
> > On Thu, Jan 05, 2017 at 08:48:32AM -0200, Marcelo Tosatti wrote:
> > > On Wed, Jan 04, 2017 at 11:36:31PM -0200, Eduardo Habkost wrote:
> > > > On Wed, Jan 04, 2017 at 08:26:27PM -0200, Marcelo Tosatti wrote:
> > > > > On Wed, Jan 04, 2017 at 05:59:17PM -0200, Eduardo Habkost wrote:
> > > > > > On Wed, Jan 04, 2017 at 11:39:16AM -0200, Eduardo Habkost wrote:
> > > > > > > On Wed, Jan 04, 2017 at 09:56:56AM -0200, Marcelo Tosatti wrote:
> > > > > > > > On Tue, Dec 27, 2016 at 05:21:20PM -0200, Eduardo Habkost wrote:
[...]
> > > > > Can't this be fixed in QEMU? Just check that destination host supports
> > > > > TSC scaling before migration (or that KVM_GET_TSC_KHZ return value
> > > > > matches on source and destination).
> > > > > 
> > > > 
> > > > This solves only one use case: where you want to expose the
> > > > starting host TSC frequency to the guest. It doesn't cover any
> > > > scenario where the TSC frequency of the starting host isn't the
> > > > best one. (See the two scenarios I described above)
> > > 
> > > True.
> > > 
> > > > You seem to have a specific use case in mind. If you describe it,
> > > > we could decide if it's worth the extra migration code complexity
> > > > to deal with invtsc migration without explicit tsc-frequency. By
> > > > now, I am not convinced yet.
> > > 
> > > I don't have any specific use case in mind. I'm just trying to
> > > avoid moving complexity to libvirt which in my experience is a
> > > the best thing to do.
> > 
> > I think both our proposals make things harder for libvirt in
> > different ways. I just want to make the complexity explicit for
> > libvirt, instead of giving them the illusion of safety (making
> > migration break in ways libvirt can't detect).
> > 
> > Anyway, your points are still valid and it would be still useful
> > to do what you propose. I will give it a try on a new version of
> > patch 4/4 that can abort migration earlier. But note that I
> > expect some pushback from other maintainers because of the
> > complexity of the code. If that happens, be aware that I won't be
> > able to justify the added complexity because I would still think
> > it's not worth it.

I tried to move the destination TSC-scaling check to post_load,
and the bad news is that post_load is also too late to abort
migration (destination aborts, but source shows migration as
completed).

I'm CCing Juan, Amit and David to see if they have any
suggestion.

Summarizing the problem for them: on some cases we want to allow
migration only if the destination host has a matching TSC
frequency or if TSC scaling is supported by the destination host.
I don't know what's the best way to implement that check. We
could either:

* Send TSC frequency/scaling info from the the source host, and
  make the source host abort migration. Is there a good mechanism
  for that?
* Make the destination host abort migration. I don't know if
  there's a safe mechanism for that.



While we figure that out, I will submit v2 without patches 3/4
and 4/4, because patch 2/2 (allowing migration if tsc-freq is
explicitly set) is simple and useful. After that, we can add:

* The mechanism to query the host TSC frequency (see below)
* The mechanism you asked for, to allow migration without
  explicit TSC frequency if we know the destination host supports
  TSC scaling or has a matching TSC frequency (more complex, and
  maybe unnecessary if we implement the previous item)


> > 
> > > 
> > > > Maybe your use case just needs a explicit "invtsc-migration=on"
> > > > command-line flag without a mechanism to abort migration on
> > > > mismatch? I can't tell.
> > > 
> > > Again, there is no special case.
> > > 
> > > > Note that even if we follow your suggestion and implement an
> > > > alternative version of patch 4/4 to cover your use case, I will
> > > > strongly recommend libvirt developers to support configuring TSC
> > > > frequency if they want to support invtsc + migration without
> > > > surprising/unpredictable restrictions on migratability.
> > > 
> > > Well, alright. If you make the TSC frequency of the host
> > > available to mgmt software as you describe, and write the steps mgmt
> > > software should take, i'm good.
> > 
> > I plan to. The problem is that the mechanism to query the host
> > frequency may be unavailable in the first version.
> 
> Well just export KVM_GET_TSC_KHZ in a QMP command right? Its pretty
> easy.

I plan to expose it as part of query-cpu-model-expansion (work in
progress, right now) when querying the "host" CPU model.

> 
> Let me know if you need any help coding or testing.

Thanks!

-- 
Eduardo
