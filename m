Received: from eggs.gnu.org ([2001:4830:134:3::10]:39733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dNJom-0004Kg-S1
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:07:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dNJoh-0006mS-SG
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:07:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dNJoh-0006mD-Hz
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:07:39 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AA06F7F6AE
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 14:07:38 +0000 (UTC)
Date: Tue, 20 Jun 2017 11:07:34 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170620140734.GA5016@thinpad.lan.raisama.net>
References: <1497876588-947-1-git-send-email-peterx@redhat.com>
	<1497876588-947-7-git-send-email-peterx@redhat.com>
	<20170619161403.GU5016@thinpad.lan.raisama.net>
	<20170620135503.GB3662@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170620135503.GB3662@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [PATCH v3 06/13] kvm: let kvm use
 AccelState.global_props
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Tue, Jun 20, 2017 at 09:55:03PM +0800, Peter Xu wrote:
> On Mon, Jun 19, 2017 at 01:14:03PM -0300, Eduardo Habkost wrote:
> > On Mon, Jun 19, 2017 at 08:49:41PM +0800, Peter Xu wrote:
> > > Let KVM be the first user of the new AccelState.global_props field.
> > > Basically kvm accel only contains accel props for TYPE_X86_CPUs but not
> > > anything else yet.
> > > 
> > > There will be a change on how these global properties are applied for
> > > TYPE_X86_CPU devices. The general workflow of the global property stuff
> > > for TYPE_X86_CPU devices can be simplied as following (this is a example
> > > routine of KVM that contains both old/new workflow, similar thing apply
> > > to TCG, but even simpler):
> > > 
> > >    - HW_COMPAT/type_init() magic played before even entering main() [1]
> > 
> > What do you mean by this?  HW_COMPAT_* is used only in
> > MachineClass::compat_props[4], and type_init() magic is triggered
> > by module_call_init(MODULE_INIT_QOM) in main().
> 
> Sorry. It should be the thing you mentioned.
> 
> > 
> > >    - main() in vl.c
> > >      - configure_accelerator()
> > >        - AccelClass.init_machine() [2]
> > >          - kvm_init() (for KVM accel)
> > >      - register global properties
> > >        - accel_register_compat_props(): register accel compat props [3]
> > >        - machine_register_compat_props(): register machine compat
> > >          props (here we'll apply all the HW_COMPAT magic into
> > >          global_props) [4]
> > >      - machine init()
> > >        - cpu init() [5]
> > >        - ...
> > > 
> > > Before this patch, the code setup TYPE_X86_CPU properties at [4] by
> > > keeping the kvm_default_props list and apply them directly to the device
> > > using x86_cpu_apply_props().
> > > 
> > > After this patch, the code setup the same properties in the sequence of
> > > [1]->[2]->[3][4]->[5]:
> > > 
> > >   - At [1] we setup machine global properties.  Note: there will be
> > >     properties that with value==NULL but it's okay - when it was applied
> > >     to global list, it'll be used to remove an entry at step [4], it
> > >     works just like the old kvm_default_props, but we just unified it to
> > >     a single place, which is the global_props list.
> > > 
> > >   - At [2] we setup accel global properties.
> > 
> > Why isn't AccelClass::global_props set up at class_init(), just
> > like we do on MachineClass::compat_props?
> 
> (explained in other thread: there is a property we only need to
>  register when split irqchip is used)
> 
> > 
> > > 
> > >   - At [3]/[4] we move machine/accel properties into global property
> > >     list. One thing to mention is that, we do [3] before [4], since we
> > >     have some cross-relation properties, e.g., property that is required
> > >     when both PC=2.1 && ACCEL=kvm happen. For now, all this kind of
> > >     properties are still in machine compat properties.
> > > 
> > >   - At [5] when TYPE_X86_CPU creates, it applies the global property from
> > >     the global property list, which is now a merged list of three: accel
> > >     property list, machine property list, and user specified "-global"
> > >     properties.
> > 
> > On which category above would the x86_cpu_change_kvm_default()
> > calls in pc_piix.c would be?  We would need to ensure they
> > override the globals registered by the accel code, but they must
> > not override the user-provided global properties (including
> > -global and -cpu options).
> 
> Oh I didn't realize this difference. x86_cpu_change_kvm_default() is
> called in [5]. It indeed breaks this rule.
> 
> > 
> > This is where things get tricky and fragile: the translation from
> > -cpu to global properties is done very late inside machine init
> > today, but we should be able to do that much earlier, once we
> > refactor the -cpu parsing code.
> > 
> > Hence my suggestion is to not touch x86_cpu_change_kvm_default()
> > and just move the other properties (everything in
> > kvm_default_props except svm, x2apic, and kvm-pv-eoi) to a static
> > AccelClass::global_props field.
> 
> Yes it's fragile and complicated.
> 
> How about this:
> 
> I introduce AccelClass::global_props, only use it in Xen but nowhere
> else? After all, what I really want to do is just let migration codes
> start to use "-global" properties and compatibility fields. And if
> there is still no good idea to ideally solve this x86 cpu property
> issue, I would prefer to keep it (it'll also be simpler for me).

Sounds good to me.

> 
> Another thing worries me a bit is that I may make things more
> confusing if I separate this list into two (then we'll have part of
> the properties in accel code, and the rest ones still in cpu.c).
> 
> (then I can also avoid using hard code in accel.c/kvm.c as well, which
>  is something I really want to stop from doing. Maybe there can be
>  some better idea, but I cannot really figure it out now...)
> 
> I'll just hold here to see whether you like above idea before moving
> on to further comments.  Thanks,


Agreed.

When I suggested using accel-provided global properties to
replace kvm_default_props, I forgot x86_cpu_change_kvm_default()
existed, and it makes things much more complex.

I really really want to make the existing x2apic/svm/kvm-pv-eoi
compat stuff be based on static lists of properties.  If we make
them dynamically built at runtime, we still can't introspect them
and it won't be worth the extra complexity.

I believe we can still find a solution to represent the
x2apic/svm/kvm-pv-eoi rules using static lists, but this
shouldn't block the migration work you are doing.

-- 
Eduardo
