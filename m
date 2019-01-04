Received: from eggs.gnu.org ([208.118.235.92]:47858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gfLvC-0008Vr-GK
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 04:37:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gfLv8-00073N-Hy
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 04:37:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35054)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1gfLv8-0006us-CQ
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 04:37:38 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CC811C07EFE1
	for <qemu-devel@nongnu.org>; Fri,  4 Jan 2019 09:37:13 +0000 (UTC)
Date: Fri, 4 Jan 2019 10:37:08 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190104103708.4d91b342.cohuck@redhat.com>
In-Reply-To: <20190103232012-mutt-send-email-mst@kernel.org>
References: <20190104032226.21428-1-ehabkost@redhat.com>
	<20190103232012-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] compat: Use explicit type names on
 HW_COMPAT_2_6
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Thu, 3 Jan 2019 23:23:45 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Fri, Jan 04, 2019 at 01:22:26AM -0200, Eduardo Habkost wrote:
> > The virtio-pci entries in HW_COMPAT_2_6 had an implicit
> > assumption: that all virtio-pci subclasses support the
> > disable-legacy and disable-modern options.
> > 
> > That assumption was broken by commit f6e501a28ef9 ("virtio:
> > Provide version-specific variants of virtio PCI devices").  This
> > caused QEMU to crash if using the new -non-transitional or
> > -transitional device types:
> > 
> >   $ qemu-system-x86_64 -machine pc-i440fx-2.6 \
> >     -device virtio-net-pci-non-transitional
> >   Unexpected error in object_property_find() at qom/object.c:1092:
> >   qemu-system-x86_64: -device virtio-net-pci-non-transitional: can't apply \
> >   global virtio-pci.disable-modern=on: Property '.disable-modern' not found
> >   Aborted (core dumped)
> > 
> > Replace the virtio-pci.disable-legacy=off and
> > virtio-pci.disable-modern=on entries on HW_COMPAT_2_6 with
> > explicit entries for each generic virtio device type.
> > 
> > The full list of generic virtio device types was extracted by
> > just grepping for ".generic_name".  Note that we don't need to
> > worry about listing new virtio-pci devices in HW_COMPAT_2_6 in
> > the future, because new devices won't require QEMU 2.6
> > compatibility.  
> 
> I fully expect that e.g. packed ring support will need
> to affect all virtio devices too. And it's likely
> that we'll have some new virtio-pci transport features too.

Yes, but as this post-dates the introduction of the version-specific
devices, it will all go into the base class and therefore not be
problematic.

> 
> > This makes the compat entries annoyingly verbose, but is simpler
> > than the alternative of making the virtio-pci type inheritance
> > rules even more complex.  
> 
> God forbid we forgot something, the only way to notice is to
> run a cross version migration with an old qemu.
> I think we need to come up with something less verbose and fragile.

I'd rather prefer to do this change now, so that we don't need to drag
around some complicated infrastructure forever.

As Eduardo said, we don't need to care about new devices, so this
grep-based approach sounds like it would catch everything.

> 
> 
> > Reported-by: Thomas Huth <thuth@redhat.com>
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> > ---
> >  include/hw/compat.h | 140 +++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 138 insertions(+), 2 deletions(-)
