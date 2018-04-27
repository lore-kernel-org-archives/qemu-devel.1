Received: from eggs.gnu.org ([2001:4830:134:3::10]:42019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1fBymq-0001xw-QM
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 04:31:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1fBymn-0000ug-KW
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 04:31:24 -0400
Message-ID: <1524817870.23669.25.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Fri, 27 Apr 2018 10:31:10 +0200
In-Reply-To: <20180427021422.GL8800@umbus.fritz.box>
References: <20180419062917.31486-1-david@gibson.dropbear.id.au>
	<1524151804.3017.9.camel@redhat.com>
	<20180420023542.GD2434@umbus.fritz.box>
	<1524216670.3017.11.camel@redhat.com>
	<20180420102117.GQ2434@umbus.fritz.box>
	<1524672566.23669.15.camel@redhat.com>
	<20180426005555.GA8800@umbus.fritz.box>
	<1524732340.23669.21.camel@redhat.com>
	<20180427021422.GL8800@umbus.fritz.box>
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

On Fri, 2018-04-27 at 12:14 +1000, David Gibson wrote:
> On Thu, Apr 26, 2018 at 10:45:40AM +0200, Andrea Bolognani wrote:
> > Unfortunately, that pretty much seals the deal on libvirt *not* being
> > able to infer the value from other guest settings :(
> > 
> > The only reasonable candidate would be the size of host pages used for
> > backing guest memory; however
> 
> Right.
> 
> >   * TCG, RPT and KVM PR guests can't infer anything from it, as they
> >     are not tied to it. Having different behaviors for TCG and KVM
> >     would be easy, but differentiating between HPT KVM HV guest and
> >     all other kinds is something we can't do at the moment, and that
> >     in the past have actively resisted doing;
> 
> Yeah, I certainly wouldn't recommend that.  It's basically what we're
> doing in qemu now, and I want to change, because it's a bad idea.
> 
> It still would be possible to key off the host side hugepage size, but
> apply the limit to all VMs - in a sense crippling TCG guests to give
> them matching behaviour to KVM guests.

As you yourself mention later...

> >   * the user might want to limit things further, eg. preventing an
> >     HPT KVM HV guest backed by 16 MiB pages or an HPT TCG guest from
> >     using hugepages.
> 
> Right.. note that with the draft qemu patches a TCG guest will be
> prevented from using hugepages *by default* (the default value of the
> capability is 16).  You have to explicitly change it to allow
> hugepages to be used in a TCG guest (but you don't have to supply
> hugepage backing).

... this will already happen. That's okay[1], we can't really
avoid it if we want to ensure consistent behavior between KVM and
TCG.

> > With the second use case in mind: would it make sense, or even be
> > possible, to make it so the capability works for RPT guests too?
> 
> Possible, maybe.. I think there's another property where RPT pagesizes
> are advertised.  But I think it's a bad idea.  In order to have the
> normal HPT case work consistently we need to set the default cap value
> to 16 (64kiB page max).  If that applied to RPT guests as well, we'd
> be unnecessarily crippling nearly all RPT guests.
> 
> > Thinking even further, what about other architectures? Is this
> > something they might want to do too? The scenario I have in mind is
> > guests backed by regular pages being prevented from using hugepages
> > with the rationale that they wouldn't have the same performance
> > characteristics as if they were backed by hugepages; on the opposite
> > side of the spectrum, you might want to ensure the pages used to
> > back guest memory are as big as the biggest page you plan to use in
> > the guest, in order to guarantee the performance characteristics
> > fully match expectations.
> 
> Hm, well, you'd have to ask other arch people if they see a use for
> that.  It doesn't look very useful to me.  I don't think libvirt can
> or should ensure identical performance characteristics for a guest
> across all possible migrations.  But for HPT guests, it's not a matter
> of performance characteristics: if it tries to use a large page size
> and KVM doesn't have large enough backing pages, the guest will
> quickly just freeze on a page fault that can never be satisfied.

I realize only HPT guests *need* this, but I was trying to figure
out whether giving the host administrator more control over the
guest page size could be a useful feature in other cases as well,
as it sounds to me like it's more generally applicable

Users already need to opt-in to using hugepages in the host; asking
to opt-in to guest hugepages support as well doesn't seem too
outlandish to me.

Even if the specific flags required vary between architectures, we
could expose this in a unified fashion in libvirt. However, if this
is not something people would consider useful, we can just have a
pSeries-specific setting instead.


[1] That's of course assuming you have made sure the restriction
    only applies to the 2.13 machine type forward, and existing
    guests are not affected by the change.
-- 
Andrea Bolognani / Red Hat / Virtualization
