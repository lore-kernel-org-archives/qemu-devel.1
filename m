Received: from eggs.gnu.org ([2001:4830:134:3::10]:55994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dNJ5Q-00032b-Tg
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 09:20:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dNJ5J-0006zB-6x
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 09:20:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dNJ5J-0006ys-0U
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 09:20:45 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 17BF3C0567B3
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 13:20:43 +0000 (UTC)
Date: Tue, 20 Jun 2017 21:20:36 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170620132036.GA3662@pxdev.xzpeter.org>
References: <1497876588-947-1-git-send-email-peterx@redhat.com>
	<1497876588-947-5-git-send-email-peterx@redhat.com>
	<20170619161739.GV5016@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170619161739.GV5016@thinpad.lan.raisama.net>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Mon, Jun 19, 2017 at 01:17:39PM -0300, Eduardo Habkost wrote:
> On Mon, Jun 19, 2017 at 08:49:39PM +0800, Peter Xu wrote:
> > Introduce this new field for the accelerator instances so that each
> > specific accelerator in the future can register its own global
> > properties to be used further by the system.  It works just like how the
> > old machine compatible properties do, but only tailored for
> > accelerators.
> > 
> > Use the newly exported register_compat_prop() to pass the accelerator
> > global properties to the global_props list.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> As noted on other patches, I believe this should be
> AccelClass::global_props (initialized statically in class_init)
> instead of AccelState::global_props (built at runtime).
> Otherwise, I don't see the benefit of the new field.

The reason is that there is property that can only be defined after
user specified all the parameters (when kvm irqchip is enabled). See:

static void kvm_register_accel_props(KVMState *kvm)
{
    AccelState *accel = ACCEL(kvm);
    AccelPropValue *entry;

    for (entry = x86_kvm_default_props; entry->prop; entry++) {
        accel_register_x86_cpu_props(accel, entry->prop, entry->value);
    }

    if (!kvm_irqchip_in_kernel()) {
        accel_register_x86_cpu_props(accel, "x2apic", "off");
    }
}

So the list is not really static when class init.  Thanks,

-- 
Peter Xu
