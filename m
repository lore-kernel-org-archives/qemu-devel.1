Received: from eggs.gnu.org ([2001:4830:134:3::10]:56718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHCqp-0005Yn-Ej
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 11:56:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHCqm-0004XM-8i
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 11:56:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53564
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHCqm-0004XG-2i
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 11:56:16 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBEGmh3i113664
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 11:56:15 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27b9vmgqt4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 11:56:15 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 11:56:14 -0500
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20161214165341.5009.38941@loki>
References: <20161214125237.20850-1-maxime.coquelin@redhat.com>
	<20161214150852.5009.51009@loki>
	<20161214171501-mutt-send-email-mst@kernel.org>
	<20161214160215.5009.32685@loki> <20161214165341.5009.38941@loki>
Date: Wed, 14 Dec 2016 10:56:04 -0600
Message-Id: <20161214165604.5009.53902@loki>
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
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, marcel@redhat.com, Maxime Coquelin <maxime.coquelin@redhat.com>, stefanha@redhat.com, cornelia.huck@de.ibm.com

Quoting Michael Roth (2016-12-14 10:53:41)
> Quoting Michael Roth (2016-12-14 10:02:15)
> > Quoting Michael S. Tsirkin (2016-12-14 09:15:38)
> > > On Wed, Dec 14, 2016 at 09:08:52AM -0600, Michael Roth wrote:
> > > > Quoting Maxime Coquelin (2016-12-14 06:52:37)
> > > > > This patch fixes a cross-version migration regression introduced
> > > > > by commit d1b4259f ("virtio-bus: Plug devices after features are
> > > > > negotiated").
> > > > > =

> > > > > The problem is encountered when host's vhost backend does not sup=
port
> > > > > VIRTIO_F_VERSION_1, and migration is initiated from a v2.7 or pri=
or
> > > > > machine with virtio-pci modern capabilities enabled to a v2.8 mac=
hine.
> > > > > =

> > > > > In this case, modern capabilities get exposed to the guest by the=
 source,
> > > > > whereas the target will detect version 1 is not supported so will=
 only
> > > > > expose legacy capabilities.
> > > > > =

> > > > > The problem is fixed by introducing a new "x-modern-broken" prope=
rty,
> > > > > which is set in v2.7 and prior compatibility modes. Doing this, v=
2.7
> > > > > machine keeps its broken behaviour (enabling modern while version=
 is
> > > > > not supported), and newer machines will behave correctly.
> > > > > =

> > > > > Reported-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> > > > > Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > > > Cc: Michael S. Tsirkin <mst@redhat.com>
> > > > > Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
> > > > > Cc: Marcel Apfelbaum <marcel@redhat.com>
> > > > > Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > > > Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> > > > =

> > > > Tested-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> > > > =

> > > > I can confirm this fixes the original issue I reported. I also did a
> > > > number of sanity runs with 2.7/2.8/pc-i440fx-2.{6,7,8} using various
> > > > combinations of disable-modern=3Dtrue/false on hosts with/without v=
irtio-1,
> > > > and some tests with pseries machines as well, and everything seems =
to
> > > > work.
> > > > =

> > > > Thanks for the quick fix!
> > > =

> > > FYI what I think does not work is a recent kernel on 2.7
> > > machine type and host without virtio 1.
> > > But this is not new.
> > =

> > To clarify I was only testing migration compatibility, I assume virtio
> > on 2.7 machines is still broken for the configuration you mentioned.
> > =

> > The migration tests I ran on the virtio-1 host do cover networking over
> > a virtio-net device before/after migration with reboots before/after
> > migration as well though, and the guest in those cases had a 4.8 kernel,
> > so I think the sanity checks I mentioned also apply for confirming
> > virtio-net probe is succeeding in the guest.
> > =

> > The non-virtio-1 runs are being done on my local machine and the tests
> > in that case are a bit more basic and don't involve actively testing
> > networking. I'll try some manual tests to check this. I guess the main
> > things to confirm on that front are that after the patch virtio probing:
> > =

> >   pc-i440fx-2.6, defaults -> succeeds
> >   pc-i440fx-2.6, disable-modern=3Dtrue -> succeeds
> >   pc-i440fx-2.6, disable-modern=3Dfalse -> fails
> > =

> >   pc-i440fx-2.7, defaults -> fails
> >   pc-i440fx-2.7, disable-modern=3Dtrue -> succeeds
> >   pc-i440fx-2.7, disable-modern=3Dfalse -> fails
> > =

> >   pc-i440fx-2.8, defaults -> succeeds
> >   pc-i440fx-2.8, disable-modern=3Dtrue -> succeeds
> >   pc-i440fx-2.8, disable-modern=3Dfalse -> succeeds
> =

> I wasn't able to test disable-modern with pc-i440fx-2.6 due to the issue
> being fixes by proposed patch "machine: Convert abstract typename on
> compat_props to subclass names", but I think the rest of the cases align
> with expectations:
> =

> 2.6, defaults: succeeds
> =

> 2.7, defaults: fails
> 2.7, disable-modern=3Dtrue: succeeds
> 2.7, disable-modern=3Dfalse: fails
> =

> 2.8, defaults: succeeds
> 2.7, disable-modern=3Dtrue: succeeds
> 2.7, disable-modern=3Dfalse: succeeds

Typo on the latter 2, these were for pc-i440fx-2.8 as well.

> =

> > =

> > > =

> > > > > ---
> > > > > =

> > > > > I'm not sure about the property name, let me know if you have bet=
ter ideas.
> > > > > I didn't tested migration yet, but I wanted to share the patch wh=
ile I test it.
> > > > > I tested booting v2.8 and v2.7 machines with !VERSION_1 and get e=
xpected result:
> > > > >  - v2.8: Virtio-pci probe succeed
> > > > >  - v2.7: Virtio-pci probe fails
> > > > > =

> > > > > Thanks,
> > > > > Maxime
> > > > > =

> > > > >  hw/virtio/virtio-pci.c | 4 +++-
> > > > >  hw/virtio/virtio-pci.h | 1 +
> > > > >  include/hw/compat.h    | 4 ++++
> > > > >  3 files changed, 8 insertions(+), 1 deletion(-)
> > > > > =

> > > > > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > > > > index 521ba0b..93f6b54 100644
> > > > > --- a/hw/virtio/virtio-pci.c
> > > > > +++ b/hw/virtio/virtio-pci.c
> > > > > @@ -1580,7 +1580,8 @@ static void virtio_pci_device_plugged(Devic=
eState *d, Error **errp)
> > > > >       * Virtio capabilities present without
> > > > >       * VIRTIO_F_VERSION_1 confuses guests
> > > > >       */
> > > > > -    if (!virtio_has_feature(vdev->host_features, VIRTIO_F_VERSIO=
N_1)) {
> > > > > +    if (!proxy->modern_broken &&
> > > > > +            !virtio_has_feature(vdev->host_features, VIRTIO_F_VE=
RSION_1)) {
> > > > >          virtio_pci_disable_modern(proxy);
> > > > > =

> > > > >          if (!legacy) {
> > > > > @@ -1852,6 +1853,7 @@ static Property virtio_pci_properties[] =3D=
 {
> > > > >                      VIRTIO_PCI_FLAG_DISABLE_PCIE_BIT, false),
> > > > >      DEFINE_PROP_BIT("page-per-vq", VirtIOPCIProxy, flags,
> > > > >                      VIRTIO_PCI_FLAG_PAGE_PER_VQ_BIT, false),
> > > > > +    DEFINE_PROP_BOOL("x-modern-broken", VirtIOPCIProxy, modern_b=
roken, false),
> > > > >      DEFINE_PROP_END_OF_LIST(),
> > > > >  };
> > > > > =

> > > > > diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
> > > > > index b2a996f..1dca223 100644
> > > > > --- a/hw/virtio/virtio-pci.h
> > > > > +++ b/hw/virtio/virtio-pci.h
> > > > > @@ -153,6 +153,7 @@ struct VirtIOPCIProxy {
> > > > >      int config_cap;
> > > > >      uint32_t flags;
> > > > >      bool disable_modern;
> > > > > +    bool modern_broken;
> > > > >      OnOffAuto disable_legacy;
> > > > >      uint32_t class_code;
> > > > >      uint32_t nvectors;
> > > > > diff --git a/include/hw/compat.h b/include/hw/compat.h
> > > > > index 0f06e11..fe11723 100644
> > > > > --- a/include/hw/compat.h
> > > > > +++ b/include/hw/compat.h
> > > > > @@ -18,6 +18,10 @@
> > > > >          .driver   =3D "intel-iommu",\
> > > > >          .property =3D "x-buggy-eim",\
> > > > >          .value    =3D "true",\
> > > > > +    },{\
> > > > > +        .driver   =3D "virtio-pci",\
> > > > > +        .property =3D "x-modern-broken",\
> > > > > +        .value    =3D "on",\
> > > > >      },
> > > > > =

> > > > >  #define HW_COMPAT_2_6 \
> > > > > -- =

> > > > > 2.9.3
> > > > > =

> > > =

> > =

> >=20
