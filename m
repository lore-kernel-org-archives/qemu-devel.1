Received: from eggs.gnu.org ([2001:4830:134:3::10]:60485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dNJPd-0007sq-EX
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 09:41:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dNJPX-0005Xj-HN
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 09:41:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dNJPX-0005XN-BB
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 09:41:39 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 42BE17EBDD
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 13:41:37 +0000 (UTC)
Date: Tue, 20 Jun 2017 10:41:33 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170620134133.GZ5016@thinpad.lan.raisama.net>
References: <1497876588-947-1-git-send-email-peterx@redhat.com>
	<1497876588-947-5-git-send-email-peterx@redhat.com>
	<20170619161739.GV5016@thinpad.lan.raisama.net>
	<20170620132036.GA3662@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170620132036.GA3662@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [PATCH v3 04/13] accel: introduce
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

On Tue, Jun 20, 2017 at 09:20:36PM +0800, Peter Xu wrote:
> On Mon, Jun 19, 2017 at 01:17:39PM -0300, Eduardo Habkost wrote:
> > On Mon, Jun 19, 2017 at 08:49:39PM +0800, Peter Xu wrote:
> > > Introduce this new field for the accelerator instances so that each
> > > specific accelerator in the future can register its own global
> > > properties to be used further by the system.  It works just like how the
> > > old machine compatible properties do, but only tailored for
> > > accelerators.
> > > 
> > > Use the newly exported register_compat_prop() to pass the accelerator
> > > global properties to the global_props list.
> > > 
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > 
> > As noted on other patches, I believe this should be
> > AccelClass::global_props (initialized statically in class_init)
> > instead of AccelState::global_props (built at runtime).
> > Otherwise, I don't see the benefit of the new field.
> 
> The reason is that there is property that can only be defined after
> user specified all the parameters (when kvm irqchip is enabled). See:
> 
> static void kvm_register_accel_props(KVMState *kvm)
> {
>     AccelState *accel = ACCEL(kvm);
>     AccelPropValue *entry;
> 
>     for (entry = x86_kvm_default_props; entry->prop; entry++) {
>         accel_register_x86_cpu_props(accel, entry->prop, entry->value);
>     }
> 
>     if (!kvm_irqchip_in_kernel()) {
>         accel_register_x86_cpu_props(accel, "x2apic", "off");
>     }
> }
> 
> So the list is not really static when class init.  Thanks,

I suggest leaving x2apic for later, and address the ones that are
static first.  I'm not sure a dynamic list on AccelState is the
right solution for x2apic.  I still wish to find a way to
represent the x2apic/svm/kvm-pv-eoi rules using static data.

-- 
Eduardo
