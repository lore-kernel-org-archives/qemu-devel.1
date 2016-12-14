Received: from eggs.gnu.org ([2001:4830:134:3::10]:34256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cH9Uk-0004gF-E9
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 08:21:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cH9Uf-0001Ia-GT
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 08:21:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50983)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cH9Uf-0001IL-6y
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 08:21:13 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBEDEGXx132943
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 08:21:11 -0500
Received: from e06smtp06.uk.ibm.com (e06smtp06.uk.ibm.com [195.75.94.102])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27b1vksptr-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 08:21:11 -0500
Received: from localhost
	by e06smtp06.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Wed, 14 Dec 2016 13:21:09 -0000
Date: Wed, 14 Dec 2016 14:21:01 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20161214151332-mutt-send-email-mst@kernel.org>
References: <20161214125237.20850-1-maxime.coquelin@redhat.com>
	<20161214141210.22d12962.cornelia.huck@de.ibm.com>
	<20161214151332-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20161214142101.50010eb4.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] virtio-pci: Fix cross-version migration
 with older machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, mdroth@linux.vnet.ibm.com, stefanha@redhat.com, qemu-devel@nongnu.org, marcel@redhat.com, "Dr . David
	Alan Gilbert" <dgilbert@redhat.com>

On Wed, 14 Dec 2016 15:16:13 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Dec 14, 2016 at 02:12:10PM +0100, Cornelia Huck wrote:
> > On Wed, 14 Dec 2016 13:52:37 +0100
> > Maxime Coquelin <maxime.coquelin@redhat.com> wrote:
> > 
> > > This patch fixes a cross-version migration regression introduced
> > > by commit d1b4259f ("virtio-bus: Plug devices after features are
> > > negotiated").
> > > 
> > > The problem is encountered when host's vhost backend does not support
> > > VIRTIO_F_VERSION_1, and migration is initiated from a v2.7 or prior
> > > machine with virtio-pci modern capabilities enabled to a v2.8 machine.
> > 
> > Wait, machine versions or qemu versions?
> > 
> > > 
> > > In this case, modern capabilities get exposed to the guest by the source,
> > > whereas the target will detect version 1 is not supported so will only
> > > expose legacy capabilities.
> > > 
> > > The problem is fixed by introducing a new "x-modern-broken" property,
> > > which is set in v2.7 and prior compatibility modes. Doing this, v2.7
> > > machine keeps its broken behaviour (enabling modern while version is
> > > not supported), and newer machines will behave correctly.
> > > 
> > > Reported-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> > > Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > Cc: Michael S. Tsirkin <mst@redhat.com>
> > > Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
> > > Cc: Marcel Apfelbaum <marcel@redhat.com>
> > > Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> > > ---
> > > 
> > > I'm not sure about the property name, let me know if you have better ideas.
> > > I didn't tested migration yet, but I wanted to share the patch while I test it.
> > > I tested booting v2.8 and v2.7 machines with !VERSION_1 and get expected result:
> > >  - v2.8: Virtio-pci probe succeed
> > >  - v2.7: Virtio-pci probe fails
> > > 
> > > Thanks,
> > > Maxime
> > > 
> > >  hw/virtio/virtio-pci.c | 4 +++-
> > >  hw/virtio/virtio-pci.h | 1 +
> > >  include/hw/compat.h    | 4 ++++
> > >  3 files changed, 8 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > > index 521ba0b..93f6b54 100644
> > > --- a/hw/virtio/virtio-pci.c
> > > +++ b/hw/virtio/virtio-pci.c
> > > @@ -1580,7 +1580,8 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
> > >       * Virtio capabilities present without
> > >       * VIRTIO_F_VERSION_1 confuses guests
> > >       */
> > > -    if (!virtio_has_feature(vdev->host_features, VIRTIO_F_VERSION_1)) {
> > > +    if (!proxy->modern_broken &&
> > 
> > What you are de facto doing here is ignoring the features supported by
> > the backend. Call this ->ignore_backend_features or so?
> > 
> > > +            !virtio_has_feature(vdev->host_features, VIRTIO_F_VERSION_1)) {
> > >          virtio_pci_disable_modern(proxy);
> > > 
> > >          if (!legacy) {
> > > @@ -1852,6 +1853,7 @@ static Property virtio_pci_properties[] = {
> > >                      VIRTIO_PCI_FLAG_DISABLE_PCIE_BIT, false),
> > >      DEFINE_PROP_BIT("page-per-vq", VirtIOPCIProxy, flags,
> > >                      VIRTIO_PCI_FLAG_PAGE_PER_VQ_BIT, false),
> > > +    DEFINE_PROP_BOOL("x-modern-broken", VirtIOPCIProxy, modern_broken, false),
> > 
> > What about "x-ignore-backend-features"?
> 
> It's just the capability that ignores that backend is legacy.
> 
> x-cap-ignore-backend-legacy
> 
> ?

Sounds good. And has the benefit that nobody will be tempted to set
that manually :)
