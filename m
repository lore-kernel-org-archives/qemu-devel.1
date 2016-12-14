Received: from eggs.gnu.org ([2001:4830:134:3::10]:59658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cHCyp-00024r-1J
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:04:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cHCyk-00078g-1H
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 12:04:35 -0500
Date: Wed, 14 Dec 2016 15:04:27 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20161214170427.GK3808@thinpad.lan.raisama.net>
References: <1481575745-26120-1-git-send-email-ehabkost@redhat.com>
	<20161214164214.54254668@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161214164214.54254668@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH for-2.8.1 v2] machine: Convert abstract
 typename on compat_props to subclass names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Wed, Dec 14, 2016 at 04:42:14PM +0100, Greg Kurz wrote:
> On Mon, 12 Dec 2016 18:49:05 -0200
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > Original problem description by Greg Kurz:
> > 
> > > Since commit "9a4c0e220d8a hw/virtio-pci: fix virtio
> > > behaviour", passing -device virtio-blk-pci.disable-modern=off
> > > has no effect on 2.6 machine types because the internal
> > > virtio-pci.disable-modern=on compat property always prevail.  
> > 
> > The same bug also affects other abstract type names mentioned on
> > compat_props by machine-types: apic-common, i386-cpu, pci-device,
> > powerpc64-cpu, s390-skeys, spapr-pci-host-bridge, usb-device,
> > virtio-pci, x86_64-cpu.
> > 
> > The right fix for this problem is to make sure compat_props and
> > -global options are always applied in the order they are
> > registered, instead of reordering them based on the type
> > hierarchy. But changing the ordering rules of -global is risky
> > and might break existing configurations, so we shouldn't do that
> > on a stable branch.
> > 
> > This is a temporary hack that will work around the bug when
> > registering compat_props properties: if we find an abstract class
> > on compat_props, register properties for all its non-abstract
> > subtypes instead. This will make sure -global won't be overridden
> > by compat_props, while keeping the existing ordering rules on
> > -global options.
> > 
> > Note that there's one case that won't be fixed by this hack:
> > "-global spapr-pci-vfio-host-bridge.<option>=<value>" won't be
> > able to override compat_props, because spapr-pci-host-bridge is
> > not an abstract class.
> > 
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> 
> This patch had 3 r-b. Is there any good reason to hold
> it up to 2.8.1 ?

Applying it today would mean delaying the 2.8.0 release, and the
bug is not serious enough to justify that.

-- 
Eduardo
