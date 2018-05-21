Received: from eggs.gnu.org ([2001:4830:134:3::10]:52744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fKrO2-0003Zp-29
	for qemu-devel@nongnu.org; Mon, 21 May 2018 16:26:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fKrNx-00020B-33
	for qemu-devel@nongnu.org; Mon, 21 May 2018 16:26:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44380)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fKrNw-0001zn-RG
	for qemu-devel@nongnu.org; Mon, 21 May 2018 16:26:25 -0400
Date: Mon, 21 May 2018 17:26:16 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180521202616.GT25013@localhost.localdomain>
References: <20180517192325.8335-1-danielhb@linux.ibm.com>
	<20180517192325.8335-2-danielhb@linux.ibm.com>
	<87wow1gxi8.fsf@dusky.pond.sub.org>
	<20180521181435.GN25013@localhost.localdomain>
	<ab91cf9f-95c3-59dc-36cb-641a3db1171b@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab91cf9f-95c3-59dc-36cb-641a3db1171b@linux.ibm.com>
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
To: Daniel Henrique Barboza <danielhb@linux.ibm.com>
Cc: Markus Armbruster <armbru@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, libvir-list@redhat.com, mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org, Anthony Perard <anthony.perard@citrix.com>, Igor Mammedov <imammedo@redhat.com>, dgilbert@redhat.com, Eric Blake <eblake@redhat.com>

On Mon, May 21, 2018 at 04:46:36PM -0300, Daniel Henrique Barboza wrote:
> 
> 
> On 05/21/2018 03:14 PM, Eduardo Habkost wrote:
> > > Issue#2: the flag isn't a property of the target.  Due to -no-acpi, it's
> > > not even a property of the machine type.  If it was, query-machines
> > > would be the natural owner of the flag.
> > > 
> > > Perhaps query-machines is still the proper owner.  The value of
> > > wakeup-suspend-support would have to depend on -no-acpi for the machine
> > > types that honor it.  Not ideal; I'd prefer MachineInfo to be static.
> > > Tolerable?  I guess that's also a libvirt question.
> > It depends when libvirt is going to query it.  Is it OK to only
> > query it after the VM is already up and running?  If it is, then
> > we can simply expose it as a read-only property of the machine
> > object.
> > 
> > Or, if we don't want to rely on qom-get as a stable API, we can
> > add a new query command (query-machine? query-power-management?)
> > 
> In the first version this logic was included in a new query command called
> "query-wakeup-from-suspend-support":
> 
> https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg00889.html
> 
> In that review it was suggested that this logic could be a flag in either
> query-target
> or query-machines API. Before sending the v2 I sent the following comment:
> 
> "After investigating, I think that it's simpler to hook the wakeup support
> info into
> TargetInfo than MachineInfo, given that the detection I'm using for this new
> property
> is based on the current runtime state. Hooking into MachineInfo would
> require to
> change the MachineClass to add a new property, then setting it up for the
> machines
> that have the wakeup support (only x86 so far). Definitely doable, but if we
> don't
> have any favorites between MachineInfo and TargetInfo I'd rather pick the
> simpler
> route.
> 
> So, if no one objects, I'll rework this series by putting the logic inside
> query-target
> instead of a new API."

Apologies for not noticing this series months ago.  :(


> 
> Since no objection was made back then, this logic was put into query-target
> starting
> in v2. Still, I don't have any favorites though: query-target looks ok,
> query-machine
> looks ok and a new API looks ok too. It's all about what makes (more) sense
> in the
> management level, I think.

I understand the original objection from Eric: having to add a
new command for every runtime flag we want to expose to the user
looks wrong to me.

However, extending query-machines and query-target looks wrong
too, however.  query-target looks wrong because this not a
property of the target.  query-machines is wrong because this is
not a static property of the machine-type, but of the running
machine instance.

Can we have a new query command that could be an obvious
container for simple machine capabilities that are not static?  A
name like "query-machine" would be generic enough for that, I
guess.

Markus, Eric, what do you think?

-- 
Eduardo
