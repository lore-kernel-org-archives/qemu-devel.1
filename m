Received: from eggs.gnu.org ([2001:4830:134:3::10]:51741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dNeS8-0002As-Py
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:09:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dNeS3-000378-Kb
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:09:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dNeS3-00036m-Cl
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 08:09:39 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 53CDF80C1D
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 12:09:38 +0000 (UTC)
Date: Wed, 21 Jun 2017 09:09:35 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170621120935.GB3928@thinpad.lan.raisama.net>
References: <1497876588-947-1-git-send-email-peterx@redhat.com>
	<1497876588-947-7-git-send-email-peterx@redhat.com>
	<20170619161403.GU5016@thinpad.lan.raisama.net>
	<20170620135503.GB3662@pxdev.xzpeter.org>
	<20170620140734.GA5016@thinpad.lan.raisama.net>
	<20170621030054.GC3662@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170621030054.GC3662@pxdev.xzpeter.org>
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

On Wed, Jun 21, 2017 at 11:00:54AM +0800, Peter Xu wrote:
> On Tue, Jun 20, 2017 at 11:07:34AM -0300, Eduardo Habkost wrote:
> > On Tue, Jun 20, 2017 at 09:55:03PM +0800, Peter Xu wrote:
> > > On Mon, Jun 19, 2017 at 01:14:03PM -0300, Eduardo Habkost wrote:
[...]
> > 
> > > 
> > > Another thing worries me a bit is that I may make things more
> > > confusing if I separate this list into two (then we'll have part of
> > > the properties in accel code, and the rest ones still in cpu.c).
> > > 
> > > (then I can also avoid using hard code in accel.c/kvm.c as well, which
> > >  is something I really want to stop from doing. Maybe there can be
> > >  some better idea, but I cannot really figure it out now...)
> > > 
> > > I'll just hold here to see whether you like above idea before moving
> > > on to further comments.  Thanks,
> > 
> > 
> > Agreed.
> > 
> > When I suggested using accel-provided global properties to
> > replace kvm_default_props, I forgot x86_cpu_change_kvm_default()
> > existed, and it makes things much more complex.
> > 
> > I really really want to make the existing x2apic/svm/kvm-pv-eoi
> > compat stuff be based on static lists of properties.  If we make
> > them dynamically built at runtime, we still can't introspect them
> > and it won't be worth the extra complexity.
> > 
> > I believe we can still find a solution to represent the
> > x2apic/svm/kvm-pv-eoi rules using static lists, but this
> > shouldn't block the migration work you are doing.
> 
> One thing I think of is:
> 
> Let MachineClass::compat_props be MachCompatProp (rather than
> GlobalProperty), then define it as:
> 
> struct MachCompatProp {
>     GlobalProperty prop;
>     bool (*prop_valid)();
> };
> 
> (We may pass MigrationState *ms into prop_valid(), but for current
>  requirements we may not need that, since what we need is basically
>  tcg_enabled(), kvm_enabled(), or kvm_irqchip_is_split() checks)
> 
> Then this property will only be delivered to the global_props list
> only if its prop_valid() check pass.  Thanks,

The problem with a ->prop_valid() hook is that it's code, not
data.  It means we can't represent it in the reply of a QMP
introspection command, or allow equivalent behavior to be
reproduced using command-line options.

Device-specific rules like this can be solved by a boolean compat
property implemented by the device itself.  e.g.: a "auto-x2apic"
property in the x86 CPU code.

-- 
Eduardo
