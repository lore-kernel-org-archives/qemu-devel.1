Received: from eggs.gnu.org ([2001:4830:134:3::10]:36178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fNCVh-0004BE-KS
	for qemu-devel@nongnu.org; Mon, 28 May 2018 03:24:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fNCVe-0005Y2-Bo
	for qemu-devel@nongnu.org; Mon, 28 May 2018 03:24:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37084 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fNCVe-0005Xi-6y
	for qemu-devel@nongnu.org; Mon, 28 May 2018 03:24:02 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180517192325.8335-2-danielhb@linux.ibm.com>
	<87wow1gxi8.fsf@dusky.pond.sub.org>
	<20180521181435.GN25013@localhost.localdomain>
	<ab91cf9f-95c3-59dc-36cb-641a3db1171b@linux.ibm.com>
	<20180521202616.GT25013@localhost.localdomain>
	<874liyivcs.fsf@dusky.pond.sub.org>
	<20180523122749.GC8988@localhost.localdomain>
	<87d0xmcqrl.fsf@dusky.pond.sub.org>
	<20180524185727.GI8988@localhost.localdomain>
	<87y3g8w8kc.fsf@dusky.pond.sub.org>
	<20180525203044.GO8988@localhost.localdomain>
Date: Mon, 28 May 2018 09:23:54 +0200
In-Reply-To: <20180525203044.GO8988@localhost.localdomain> (Eduardo Habkost's
	message of "Fri, 25 May 2018 17:30:44 -0300")
Message-ID: <87efhwp7jp.fsf@dusky.pond.sub.org>
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
Cc: Stefano Stabellini <sstabellini@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, libvir-list@redhat.com, Daniel Henrique Barboza <danielhb@linux.ibm.com>, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, Anthony Perard <anthony.perard@citrix.com>, Igor Mammedov <imammedo@redhat.com>, dgilbert@redhat.com

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Fri, May 25, 2018 at 08:30:59AM +0200, Markus Armbruster wrote:
>> Eduardo Habkost <ehabkost@redhat.com> writes:
>> > On Wed, May 23, 2018 at 05:53:34PM +0200, Markus Armbruster wrote:
> [...]
>> >> >> Worse, a machine type property that is static for all machine types now
>> >> >> could conceivably become dynamic when we add a machine type
>> >> >> configuration knob.
>> >> >> 
>> >> >
>> >> > This isn't the first time a machine capability that seems static
>> >> > actually depends on other configuration arguments.  We will
>> >> > probably need to address this eventually.
>> >> 
>> >> Then the best time to address it is now, provided we can :)
>> >
>> > I'm not sure this is the best time.  If libvirt only needs the
>> > runtime value and don't need any info at query-machines time, I
>> > think support for this on query-machines will be left unused and
>> > they will only use the query-current-machine value.
>> >
>> > Just giving libvirt the runtime data it wants
>> > (query-current-machine) seems way better than requiring libvirt
>> > to interpret a set of rules and independently calculate something
>> > QEMU already knows.
>> 
>> I wouldn't mind adding a query-current-machine to report dynamic machine
>> capabilities if that helps QMP clients.  query-machines could continue
>> to report static machine capabilities then.
>> 
>> However, we do need a plan on how to distribute machine capabilities
>> between query-machines and query-current-machine, in particular how to
>> handle changing staticness.
>
> Handling dynamic data that becomes static is easy: we can keep it
> on both.

The duplication is less than elegant, but backward-compatibility
generally is.

>> wakeup-suspend-support is static for most machine types, but dynamic for
>> some.  Where should it go?
>
> I think it obviously should go on query-current-machine.  Maybe
> it can be added to query-machines in the future if it's deemed
> useful.
>
>> It needs to go into query-current-machine when its dynamic with the
>> current machine.  It may go there just to keep things regular even if
>> its static with the current machine.
>> 
>> Does it go into query-machines, too?  If not, clients lose the ability
>> to examine all machines efficiently.  Even if this isn't an issue for
>> wakeup-suspend-support: are we sure this can't be an issue for any
>> future capabilities?
>
> I don't think this will be an issue for wakup-suspend-support,
> but this is already an issue for existing capabilities.  See
> below[1].
>
>
>> 
>> If it goes into query-machines, what should its value be for the machine
>> types where it's dynamic?  Should it be absent, perhaps, letting clients
>> know they have to consult query-current-machine to find the value?
>> 
>> What if a capability previously thought static becomes dynamic?  We can
>> add it to query-current-machine just fine, but removing it from
>> query-machines would be a compatibility break.  Making it optional,
>> too.  Should all new members of MachineInfo be optional, just in case?
>> 
>
> The above are questions we must ponder if we are considering
> extending query-machines.  We have been avoiding them for a few
> years, by simply not extending query-machines very often and
> letting libvirt hardcode machine-type info.  :(
>
>
>> These are design questions we need to ponder *now*.  Picking a solution
>> that satisfies current needs while ignoring future needs has bitten us
>> in the posterior time and again.  We're not going to successfully
>> predict *all* future needs, but not even trying should be easy to beat.
>> 
>> That's what I meant by "the best time to address it is now".
>> 
>
> I agree.  I just think there are countless other use cases that
> require extending query-machines today.  I'd prefer to use one of
> them as a starting point for this design exercise, instead of
> wakeup-suspend-support.

Analyzing all the use cases we know makes sense.

> [1] Doing a:
>   $ git grep 'STR.*machine, "'
> on libvirt source is enough to find some code demonstrating where
> query-machines is already lacking today:
>
> src/libxl/libxl_capabilities.c:583:    if (STREQ(machine, "xenpv"))
> src/libxl/libxl_capabilities.c:729:    if (STREQ(domCaps->machine, "xenfv"))
> src/libxl/libxl_driver.c:6379:        if (STRNEQ(machine, "xenpv") && STRNEQ(machine, "xenfv")) {
> src/qemu/qemu_capabilities.c:2435:            STREQ(def->os.machine, "ppce500"))
> src/qemu/qemu_capabilities.c:2439:            STREQ(def->os.machine, "prep"))
> src/qemu/qemu_capabilities.c:2443:            STREQ(def->os.machine, "bamboo"))
> src/qemu/qemu_capabilities.c:2446:        if (STREQ(def->os.machine, "mpc8544ds"))
> src/qemu/qemu_capabilities.c:5376:        STREQ(def->os.machine, "isapc");
> src/qemu/qemu_command.c:3829:    if (STRPREFIX(def->os.machine, "s390-virtio") &&
> src/qemu/qemu_domain.c:2798:        if (STREQ(def->os.machine, "isapc")) {
> src/qemu/qemu_domain.c:5009:        if (STREQ(def->os.machine, "versatilepb"))
> src/qemu/qemu_domain.c:8222:    return (STRPREFIX(machine, "pc-q35") ||
> src/qemu/qemu_domain.c:8223:            STREQ(machine, "q35"));
> src/qemu/qemu_domain.c:8237:    return (STREQ(machine, "pc") ||
> src/qemu/qemu_domain.c:8238:            STRPREFIX(machine, "pc-0.") ||
> src/qemu/qemu_domain.c:8239:            STRPREFIX(machine, "pc-1.") ||
> src/qemu/qemu_domain.c:8240:            STRPREFIX(machine, "pc-i440") ||
> src/qemu/qemu_domain.c:8241:            STRPREFIX(machine, "rhel"));
> src/qemu/qemu_domain.c:8285:    const char *p = STRSKIP(machine, "pc-q35-");
> src/qemu/qemu_domain.c:8310:    return STRPREFIX(machine, "s390-ccw");
> src/qemu/qemu_domain.c:8329:    if (STRNEQ(machine, "virt") &&
> src/qemu/qemu_domain.c:8330:        !STRPREFIX(machine, "virt-"))
> src/qemu/qemu_domain.c:8351:    if (STRNEQ(machine, "pseries") &&
> src/qemu/qemu_domain.c:8352:        !STRPREFIX(machine, "pseries-"))
> src/qemu/qemu_domain.c:8564:        STREQ(machine, "malta") ||
> src/qemu/qemu_domain.c:8565:        STREQ(machine, "sun4u") ||
> src/qemu/qemu_domain.c:8566:        STREQ(machine, "g3beige");
> src/qemu/qemu_domain_address.c:467:    if (!(STRPREFIX(def->os.machine, "vexpress-") ||
> src/qemu/qemu_domain_address.c:2145:    if (STREQ(def->os.machine, "versatilepb"))
> src/util/virarch.c:170:    } else if (STREQ(ut.machine, "amd64")) {

How can we get from this grep to a list of static or dynamic machine
type capabilties?
