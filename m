Received: from eggs.gnu.org ([2001:4830:134:3::10]:41816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fLSs7-00040T-Pw
	for qemu-devel@nongnu.org; Wed, 23 May 2018 08:28:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fLSs2-000495-RT
	for qemu-devel@nongnu.org; Wed, 23 May 2018 08:28:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fLSs2-00048Y-HW
	for qemu-devel@nongnu.org; Wed, 23 May 2018 08:27:58 -0400
Date: Wed, 23 May 2018 09:27:49 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180523122749.GC8988@localhost.localdomain>
References: <20180517192325.8335-1-danielhb@linux.ibm.com>
	<20180517192325.8335-2-danielhb@linux.ibm.com>
	<87wow1gxi8.fsf@dusky.pond.sub.org>
	<20180521181435.GN25013@localhost.localdomain>
	<ab91cf9f-95c3-59dc-36cb-641a3db1171b@linux.ibm.com>
	<20180521202616.GT25013@localhost.localdomain>
	<874liyivcs.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874liyivcs.fsf@dusky.pond.sub.org>
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
Cc: Daniel Henrique Barboza <danielhb@linux.ibm.com>, Stefano Stabellini <sstabellini@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, libvir-list@redhat.com, mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org, Anthony Perard <anthony.perard@citrix.com>, Igor Mammedov <imammedo@redhat.com>, dgilbert@redhat.com

On Wed, May 23, 2018 at 11:17:55AM +0200, Markus Armbruster wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
> > On Mon, May 21, 2018 at 04:46:36PM -0300, Daniel Henrique Barboza wrote:
[...]
> >> Since no objection was made back then, this logic was put into query-target
> >> starting
> >> in v2. Still, I don't have any favorites though: query-target looks ok,
> >> query-machine
> >> looks ok and a new API looks ok too. It's all about what makes (more) sense
> >> in the
> >> management level, I think.
> >
> > I understand the original objection from Eric: having to add a
> > new command for every runtime flag we want to expose to the user
> > looks wrong to me.
> 
> Agreed.
> 
> > However, extending query-machines and query-target looks wrong
> > too, however.  query-target looks wrong because this not a
> > property of the target.  query-machines is wrong because this is
> > not a static property of the machine-type, but of the running
> > machine instance.
> 
> Of the two, query-machines looks less wrong.
> 
> Arguably, -no-acpi should not exist.  It's an ad hoc flag that sneakily
> splits a few machine types into two variants, with and without ACPI.
> It's silently ignored for other machine types, even APCI-capable ones.
> 
> If the machine type variants with and without ACPI were separate types,
> wakeup-suspend-support would be a static property of the machine type.
> 
> However, "separate types" probably doesn't scale: I'm afraid we'd end up
> with an undesirable number of machine types.  Avoiding that is exactly
> why we have machine types with configurable options.  I suspect that's
> how ACPI should be configured (if at all).
> 
> So, should we make -no-acpi sugar for a machine type parameter?  And
> then deprecate -no-acpi for good measure?

I think we should.


> 
> > Can we have a new query command that could be an obvious
> > container for simple machine capabilities that are not static?  A
> > name like "query-machine" would be generic enough for that, I
> > guess.
> 
> Having command names differ only in a single letter is awkward, but
> let's focus on things other than naming now, and use
> query-current-machine like a working title.
> 
> query-machines is wrong because wakeup-suspend-support isn't static for
> some machine types.
> 
> query-current-machine is also kind of wrong because
> wakeup-suspend-support *is* static for most machine types.
> 

The most appropriate solution depends a lot on how/when
management software needs to query this.

If they only need to query it at runtime for a running VM,
there's no reason for us to go of our way and add complexity just
to make it look like static data in query-machines.

On the other hand, if they really need to query it before
configuring/starting a VM, it won't be useful at all to make it
available only at runtime.

Daniel, when/how exactly software would need to query the new
flag?


> Worse, a machine type property that is static for all machine types now
> could conceivably become dynamic when we add a machine type
> configuration knob.
> 

This isn't the first time a machine capability that seems static
actually depends on other configuration arguments.  We will
probably need to address this eventually.


> Would a way to tie the property to the configuration knob help?
> Something like wakeup-suspend-support taking values true (supported),
> false (not supported), and "acpi" (supported if machine type
> configuration knob "acpi" is switched on).
> 

I would prefer a more generic mechanism.  Maybe make
'query-machines' accept a 'machine-options' argument?

-- 
Eduardo
