Received: from eggs.gnu.org ([2001:4830:134:3::10]:51392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fM6Fo-0007vy-2Y
	for qemu-devel@nongnu.org; Fri, 25 May 2018 02:31:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fM6Fh-0000yx-Kw
	for qemu-devel@nongnu.org; Fri, 25 May 2018 02:31:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56476 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fM6Fh-0000y6-G7
	for qemu-devel@nongnu.org; Fri, 25 May 2018 02:31:01 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180517192325.8335-1-danielhb@linux.ibm.com>
	<20180517192325.8335-2-danielhb@linux.ibm.com>
	<87wow1gxi8.fsf@dusky.pond.sub.org>
	<20180521181435.GN25013@localhost.localdomain>
	<ab91cf9f-95c3-59dc-36cb-641a3db1171b@linux.ibm.com>
	<20180521202616.GT25013@localhost.localdomain>
	<874liyivcs.fsf@dusky.pond.sub.org>
	<20180523122749.GC8988@localhost.localdomain>
	<87d0xmcqrl.fsf@dusky.pond.sub.org>
	<20180524185727.GI8988@localhost.localdomain>
Date: Fri, 25 May 2018 08:30:59 +0200
In-Reply-To: <20180524185727.GI8988@localhost.localdomain> (Eduardo Habkost's
	message of "Thu, 24 May 2018 15:57:27 -0300")
Message-ID: <87y3g8w8kc.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, libvir-list@redhat.com, Daniel Henrique Barboza <danielhb@linux.ibm.com>, mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org, Anthony Perard <anthony.perard@citrix.com>, Igor Mammedov <imammedo@redhat.com>, dgilbert@redhat.com

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Wed, May 23, 2018 at 05:53:34PM +0200, Markus Armbruster wrote:
>> Eduardo Habkost <ehabkost@redhat.com> writes:
>> 
>> > On Wed, May 23, 2018 at 11:17:55AM +0200, Markus Armbruster wrote:
>> >> Eduardo Habkost <ehabkost@redhat.com> writes:
>> >> > On Mon, May 21, 2018 at 04:46:36PM -0300, Daniel Henrique Barboza wrote:
>> > [...]
>> >> >> Since no objection was made back then, this logic was put into query-target
>> >> >> starting
>> >> >> in v2. Still, I don't have any favorites though: query-target looks ok,
>> >> >> query-machine
>> >> >> looks ok and a new API looks ok too. It's all about what makes (more) sense
>> >> >> in the
>> >> >> management level, I think.
>> >> >
>> >> > I understand the original objection from Eric: having to add a
>> >> > new command for every runtime flag we want to expose to the user
>> >> > looks wrong to me.
>> >> 
>> >> Agreed.
>> >> 
>> >> > However, extending query-machines and query-target looks wrong
>> >> > too, however.  query-target looks wrong because this not a
>> >> > property of the target.  query-machines is wrong because this is
>> >> > not a static property of the machine-type, but of the running
>> >> > machine instance.
>> >> 
>> >> Of the two, query-machines looks less wrong.
>> >> 
>> >> Arguably, -no-acpi should not exist.  It's an ad hoc flag that sneakily
>> >> splits a few machine types into two variants, with and without ACPI.
>> >> It's silently ignored for other machine types, even APCI-capable ones.
>> >> 
>> >> If the machine type variants with and without ACPI were separate types,
>> >> wakeup-suspend-support would be a static property of the machine type.
>> >> 
>> >> However, "separate types" probably doesn't scale: I'm afraid we'd end up
>> >> with an undesirable number of machine types.  Avoiding that is exactly
>> >> why we have machine types with configurable options.  I suspect that's
>> >> how ACPI should be configured (if at all).
>> >> 
>> >> So, should we make -no-acpi sugar for a machine type parameter?  And
>> >> then deprecate -no-acpi for good measure?
>> >
>> > I think we should.
>> 
>> Would you like to take care of it?
>
> Adding to my TODO-list, I hope I will be able to do it before the
> next release.

Thanks!

>> >> > Can we have a new query command that could be an obvious
>> >> > container for simple machine capabilities that are not static?  A
>> >> > name like "query-machine" would be generic enough for that, I
>> >> > guess.
>> >> 
>> >> Having command names differ only in a single letter is awkward, but
>> >> let's focus on things other than naming now, and use
>> >> query-current-machine like a working title.
>> >> 
>> >> query-machines is wrong because wakeup-suspend-support isn't static for
>> >> some machine types.
>> >> 
>> >> query-current-machine is also kind of wrong because
>> >> wakeup-suspend-support *is* static for most machine types.
>> >
>> > The most appropriate solution depends a lot on how/when
>> > management software needs to query this.
>> 
>> Right.
>> 
>> > If they only need to query it at runtime for a running VM,
>> > there's no reason for us to go of our way and add complexity just
>> > to make it look like static data in query-machines.
>> >
>> > On the other hand, if they really need to query it before
>> > configuring/starting a VM, it won't be useful at all to make it
>> > available only at runtime.
>> >
>> > Daniel, when/how exactly software would need to query the new
>> > flag?
>> >
>> >
>> >> Worse, a machine type property that is static for all machine types now
>> >> could conceivably become dynamic when we add a machine type
>> >> configuration knob.
>> >> 
>> >
>> > This isn't the first time a machine capability that seems static
>> > actually depends on other configuration arguments.  We will
>> > probably need to address this eventually.
>> 
>> Then the best time to address it is now, provided we can :)
>
> I'm not sure this is the best time.  If libvirt only needs the
> runtime value and don't need any info at query-machines time, I
> think support for this on query-machines will be left unused and
> they will only use the query-current-machine value.
>
> Just giving libvirt the runtime data it wants
> (query-current-machine) seems way better than requiring libvirt
> to interpret a set of rules and independently calculate something
> QEMU already knows.

I wouldn't mind adding a query-current-machine to report dynamic machine
capabilities if that helps QMP clients.  query-machines could continue
to report static machine capabilities then.

However, we do need a plan on how to distribute machine capabilities
between query-machines and query-current-machine, in particular how to
handle changing staticness.

wakeup-suspend-support is static for most machine types, but dynamic for
some.  Where should it go?

It needs to go into query-current-machine when its dynamic with the
current machine.  It may go there just to keep things regular even if
its static with the current machine.

Does it go into query-machines, too?  If not, clients lose the ability
to examine all machines efficiently.  Even if this isn't an issue for
wakeup-suspend-support: are we sure this can't be an issue for any
future capabilities?

If it goes into query-machines, what should its value be for the machine
types where it's dynamic?  Should it be absent, perhaps, letting clients
know they have to consult query-current-machine to find the value?

What if a capability previously thought static becomes dynamic?  We can
add it to query-current-machine just fine, but removing it from
query-machines would be a compatibility break.  Making it optional,
too.  Should all new members of MachineInfo be optional, just in case?

These are design questions we need to ponder *now*.  Picking a solution
that satisfies current needs while ignoring future needs has bitten us
in the posterior time and again.  We're not going to successfully
predict *all* future needs, but not even trying should be easy to beat.

That's what I meant by "the best time to address it is now".

[...]
