Received: from eggs.gnu.org ([2001:4830:134:3::10]:47000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1f9SNz-0003ti-Hp
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 05:31:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1f9SNu-0001IO-IG
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 05:31:19 -0400
Message-ID: <1524216670.3017.11.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Fri, 20 Apr 2018 11:31:10 +0200
In-Reply-To: <20180420023542.GD2434@umbus.fritz.box>
References: <20180419062917.31486-1-david@gibson.dropbear.id.au>
	<1524151804.3017.9.camel@redhat.com>
	<20180420023542.GD2434@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC for-2.13 0/7] spapr: Clean up pagesize
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: groug@kaod.org, aik@ozlabs.ru, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org

On Fri, 2018-04-20 at 12:35 +1000, David Gibson wrote:
> On Thu, Apr 19, 2018 at 05:30:04PM +0200, Andrea Bolognani wrote:
> > On Thu, 2018-04-19 at 16:29 +1000, David Gibson wrote:
> > > This means that in order to use hugepages in a PAPR guest it's
> > > necessary to add a "cap-hpt-mps=24" machine parameter as well as
> > > setting the mem-path correctly.  This is a bit more work on the user
> > > and/or management side, but results in consistent behaviour so I think
> > > it's worth it.
> > 
> > libvirt guests already need to explicitly opt-in to hugepages, so
> > adding this new option automagically based on that shouldn't be too
> > difficult.
> 
> Right.  We have to be a bit careful with automagic though, because
> treating hugepage as a boolean is one of the problems that this
> parameter is there to address.
> 
> If libvirt were to set the parameter based on the pagesize of the
> hugepage mount, then it might not be consistent across a migration
> (e.g. p8 to p9).  Now the new code would at least catch that and
> safely fail the migration, but that might be confusing to users.

Good point.

I'll have to look into it to be sure, but I think it should be
possible for libvirt to convert a generic

  <memoryBacking>
    <hugepages/>
  </memoryBacking>

to a more specific

  <memoryBacking>
    <hugepages>
      <page size="16384" unit="KiB"/>
    </hugepages>
  </memoryBacking>

by figuring out the page size for the default hugepage mount,
which actually sounds like a good idea regardless. Of course users
user would still be able to provide the page size themselves in the
first place.

Is the 16 MiB page size available for both POWER8 and POWER9?

> > A couple of questions:
> > 
> >   * I see the option accepts values 12, 16, 24 and 34, with 16
> >     being the default.
> 
> In fact it should accept any value >= 12, though the ones that you
> list are the interesting ones.

Well, I copied them from the QEMU help text, and I kinda assumed
that you wouldn't just list completely random values there O:-)

> This does mean, for example, that if
> it was just set to the hugepage size on a p9, 21 (2MiB) things should
> work correctly (in practice it would act identically to setting it to
> 16).

Wouldn't that lead to different behavior depending on whether you
start the guest on a POWER9 or POWER8 machine? The former would be
able to use 2 MiB hugepages, while the latter would be stuck using
regular 64 KiB pages. Migration of such a guest from POWER9 to
POWER8 wouldn't work because the hugepage allocation couldn't be
fulfilled, but the other way around would probably work and lead to
different page sizes being available inside the guest after a power
cycle, no?

> > I guess 34 corresponds to 1 GiB hugepages?
> 
> No, 16GiB hugepages, which is the "colossal page" size on HPT POWER
> machines.  It's a simple shift, (1 << 34) == 16 GiB, 1GiB pages would
> be 30 (but wouldn't let the guest do any more than 24 ~ 16 MiB in
> practice).

Isn't 1 GiB hugepages support at least being worked on[1]?

> >     Also, in what scenario would 12 be used?
> 
> So RHEL, at least, generally configures ppc64 kernels to use 64kiB
> pages, but 4kiB pages are still supported upstream (not sure if there
> are any distros that still use that mode).  If your host uses 4kiB
> pages you wouldn't be able to start a (KVM HV) guest without setting
> this to 12 (or using a 64kiB hugepage mount).

Mh, that's annoying, as needing to support 4 KiB pages would most
likely mean we'd have to turn this into a stand-alone configuration
knob rather than deriving it entirely from existing ones, which I'd
prefer as it's clearly much more user-friendly.

I'll check out what other distros are doing: if all the major ones
are defaulting to 64 KiB pages these days, it might be reasonable
to do the same and pretend smaller page sizes don't exist at all in
order to avoid the pain of having to tweak yet another knob, even
if that means leaving people compiling their own custom kernels
with 4 KiB page size in the dust.

> >   * The name of the property suggests this setting is only relevant
> >     for HPT guests. libvirt doesn't really have the notion of HPT
> >     and RPT, and I'm not really itching to introduce it. Can we
> >     safely use this option for all guests, even RPT ones?
> 
> Yes.  The "hpt" in the main is meant to imply that its restriction
> only applies when the guest is in HPT mode, but it can be safely set
> in any mode.  In RPT mode guest and host pagesizes are independent of
> each other, so we don't have to deal with this mess.

Good :)


[1] https://patchwork.kernel.org/patch/9729991/
-- 
Andrea Bolognani / Red Hat / Virtualization
