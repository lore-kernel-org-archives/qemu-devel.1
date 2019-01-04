Received: from eggs.gnu.org ([208.118.235.92]:47615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gfS4d-00083e-KN
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 11:11:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gfS4Y-0006BE-9g
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 11:11:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gfS4Y-00069k-1e
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 11:11:46 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 751094D2CD
	for <qemu-devel@nongnu.org>; Fri,  4 Jan 2019 16:11:44 +0000 (UTC)
Date: Fri, 4 Jan 2019 14:11:36 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190104161136.GF4157@habkost.net>
References: <20190104032226.21428-1-ehabkost@redhat.com>
	<20190104104919.594a6498.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190104104919.594a6498.cohuck@redhat.com>
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
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Fri, Jan 04, 2019 at 10:49:19AM +0100, Cornelia Huck wrote:
> On Fri,  4 Jan 2019 01:22:26 -0200
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
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
> Some of these will not be relevant for 2.6 compat, but better safe than
> sorry :)

Yes.  My first version was based on grepping the v2.6.0 tree, but
then I decided to be safer and grep for ".generic_name" on
qemu.git master.  Just in case somebody is using a v2.7+ device
type with 2.6 machine-types.

> 
> > 
> > This makes the compat entries annoyingly verbose, but is simpler
> > than the alternative of making the virtio-pci type inheritance
> > rules even more complex.
> 
> Maybe also write out explicitly:
> 
> Fixes: f6e501a28ef9 ("virtio: Provide version-specific variants of virtio PCI devices")

Yes, I forgot to do it.  Thanks no noting!

> 
> > 
> > Reported-by: Thomas Huth <thuth@redhat.com>
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> > ---
> >  include/hw/compat.h | 140 +++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 138 insertions(+), 2 deletions(-)
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>

-- 
Eduardo
