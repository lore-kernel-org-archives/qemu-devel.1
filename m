Received: from eggs.gnu.org ([2001:4830:134:3::10]:57926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYqoA-0004gA-VM
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 06:39:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYqo7-0001m2-R9
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 06:39:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52650 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fYqo7-0001l6-Li
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 06:39:15 -0400
Date: Fri, 29 Jun 2018 11:39:10 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180629103910.GE27016@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <153026817452.402489.13386335348113684056.stgit@bahia.lan>
	<8730183a-3e16-931e-c990-24a5e169b2d9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8730183a-3e16-931e-c990-24a5e169b2d9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] accel: forbid early use of
 kvm_enabled() and friends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>

On Fri, Jun 29, 2018 at 12:35:09PM +0200, Paolo Bonzini wrote:
> On 29/06/2018 12:29, Greg Kurz wrote:
> > It is unsafe to rely on *_enabled() helpers before the accelerator has
> > been initialized, ie, accel_init_machine() has succeeded, because they
> > always return false. But it is still possible to end up calling them
> > indirectly by inadvertance, and cause QEMU to misbehave.
> > 
> > This patch causes QEMU to abort if we try to check for an accelerator
> > before it has been set up. This will help to catch bugs earlier.
> > 
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> > 
> > This patch was motivated by an regression we're currently fixing in
> > spapr because of an early use of kvm_enabled(). David suggested to
> > post this patch separately:
> > 
> > https://lists.nongnu.org/archive/html/qemu-ppc/2018-06/msg01136.html
> > 
> > v2: - dropped change in qom/cpu.c (useless header inclusion)
> >     - only #include "sysemu/kvm.h" if we actually need it
> >     - added David's R-b from v1 because changes in v2 are minor
> 
> This adds a function call on possibly hot paths.  Can you make it inline?
> 
> Also asserting current_machine != NULL is not necessary, since you're
> immediately dereferencing it.

Is there a practical way to simply initialize the accelerators earlier
in startup sequence, so we just remove or at least reduce, the liklihood
of accessing it too early ?

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
