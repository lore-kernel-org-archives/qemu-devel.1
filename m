Received: from eggs.gnu.org ([2001:4830:134:3::10]:43278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fLvQf-0007vV-Qz
	for qemu-devel@nongnu.org; Thu, 24 May 2018 14:57:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fLvQb-0003W5-LW
	for qemu-devel@nongnu.org; Thu, 24 May 2018 14:57:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50246)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fLvQb-0003VN-Dr
	for qemu-devel@nongnu.org; Thu, 24 May 2018 14:57:33 -0400
Date: Thu, 24 May 2018 15:57:27 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180524185727.GI8988@localhost.localdomain>
References: <20180517192325.8335-1-danielhb@linux.ibm.com>
	<20180517192325.8335-2-danielhb@linux.ibm.com>
	<87wow1gxi8.fsf@dusky.pond.sub.org>
	<20180521181435.GN25013@localhost.localdomain>
	<ab91cf9f-95c3-59dc-36cb-641a3db1171b@linux.ibm.com>
	<20180521202616.GT25013@localhost.localdomain>
	<874liyivcs.fsf@dusky.pond.sub.org>
	<20180523122749.GC8988@localhost.localdomain>
	<87d0xmcqrl.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d0xmcqrl.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v7 1/3] qmp: adding
 'wakeup-suspend-support' in query-target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, libvir-list@redhat.com, Daniel Henrique Barboza <danielhb@linux.ibm.com>, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, Anthony Perard <anthony.perard@citrix.com>, Igor Mammedov <imammedo@redhat.com>, dgilbert@redhat.com

On Wed, May 23, 2018 at 05:53:34PM +0200, Markus Armbruster wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
> 
> > On Wed, May 23, 2018 at 11:17:55AM +0200, Markus Armbruster wrote:
> >> Eduardo Habkost <ehabkost@redhat.com> writes:
> >> > On Mon, May 21, 2018 at 04:46:36PM -0300, Daniel Henrique Barboza wrote:
> > [...]
> >> >> Since no objection was made back then, this logic was put into query-target
> >> >> starting
> >> >> in v2. Still, I don't have any favorites though: query-target looks ok,
> >> >> query-machine
> >> >> looks ok and a new API looks ok too. It's all about what makes (more) sense
> >> >> in the
> >> >> management level, I think.
> >> >
> >> > I understand the original objection from Eric: having to add a
> >> > new command for every runtime flag we want to expose to the user
> >> > looks wrong to me.
> >> 
> >> Agreed.
> >> 
> >> > However, extending query-machines and query-target looks wrong
> >> > too, however.  query-target looks wrong because this not a
> >> > property of the target.  query-machines is wrong because this is
> >> > not a static property of the machine-type, but of the running
> >> > machine instance.
> >> 
> >> Of the two, query-machines looks less wrong.
> >> 
> >> Arguably, -no-acpi should not exist.  It's an ad hoc flag that sneakily
> >> splits a few machine types into two variants, with and without ACPI.
> >> It's silently ignored for other machine types, even APCI-capable ones.
> >> 
> >> If the machine type variants with and without ACPI were separate types,
> >> wakeup-suspend-support would be a static property of the machine type.
> >> 
> >> However, "separate types" probably doesn't scale: I'm afraid we'd end up
> >> with an undesirable number of machine types.  Avoiding that is exactly
> >> why we have machine types with configurable options.  I suspect that's
> >> how ACPI should be configured (if at all).
> >> 
> >> So, should we make -no-acpi sugar for a machine type parameter?  And
> >> then deprecate -no-acpi for good measure?
> >
> > I think we should.
> 
> Would you like to take care of it?

Adding to my TODO-list, I hope I will be able to do it before the
next release.

> 
[...]
> >
> > This isn't the first time a machine capability that seems static
> > actually depends on other configuration arguments.  We will
> > probably need to address this eventually.
> 
> Then the best time to address it is now, provided we can :)

I'm not sure this is the best time.  If libvirt only needs the
runtime value and don't need any info at query-machines time, I
think support for this on query-machines will be left unused and
they will only use the query-current-machine value.

Just giving libvirt the runtime data it wants
(query-current-machine) seems way better than requiring libvirt
to interpret a set of rules and independently calculate something
QEMU already knows.

> 
> >> Would a way to tie the property to the configuration knob help?
> >> Something like wakeup-suspend-support taking values true (supported),
> >> false (not supported), and "acpi" (supported if machine type
> >> configuration knob "acpi" is switched on).
> >> 
> >
> > I would prefer a more generic mechanism.  Maybe make
> > 'query-machines' accept a 'machine-options' argument?
> 
> This can support arbitrary configuration dependencies, unlike my
> proposal.  However, I fear combinatorial explosion would make querying
> anything but "default configuration" and "current configuration"
> impractical, and "default configuration" would be basically useless, as
> you can't predict how arguments will affect the value query-machines.
> 
> Whether this is an issue depends on how management software wants to use
> query-machines.
> 
> Whether the ability to support arbitrary configuration dependencies is a
> useful feature or an invitation to stupid stunts is another open
> question :)
> 
> Here's a synthesis of the two proposals: have query-machines spell out
> which of its results are determinate, and which configuration bits need
> to be supplied to resolve the indeterminate ones.  For machine type
> "pc-q35-*", wakeup-suspend-support would always yield true, but for
> "pc-i440fx-*" it would return true when passed an acpi: true argument,
> false when passed an acpi: false argument, and an encoding of
> "indeterminate, you need to pass an acpi argument to learn more" when
> passed no acpi argument.

I like this proposal for other query-machines fields (like bus
information), but I think doing this for wakeup-suspend-support
is overkill, based on Daniel's description of its intended usage.


> 
> I'm not saying this synthesis makes sense, I'm just exploring the design
> space.
> 
> We need input from libvirt guys.

I have the impression we need real use cases so they can evaluate
the proposal.  wakeup-suspend-support doesn't seem like a use
case that really needs support on query-machines (because we
can simply provide the data at runtime).

-- 
Eduardo
