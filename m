Received: from eggs.gnu.org ([2001:4830:134:3::10]:56959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHBB9-0005b2-Q9
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 10:09:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHBB4-0003Lr-OT
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 10:09:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35994)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHBB4-0003LZ-G3
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 10:09:06 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBEF7wvx108031
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 10:09:04 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27b29dqcjd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 10:09:04 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 08:09:03 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20161214125237.20850-1-maxime.coquelin@redhat.com>
References: <20161214125237.20850-1-maxime.coquelin@redhat.com>
Date: Wed, 14 Dec 2016 09:08:52 -0600
Message-Id: <20161214150852.5009.51009@loki>
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
To: Maxime Coquelin <maxime.coquelin@redhat.com>, stefanha@redhat.com, qemu-devel@nongnu.org, mst@redhat.com, cornelia.huck@de.ibm.com, marcel@redhat.com
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Quoting Maxime Coquelin (2016-12-14 06:52:37)
> This patch fixes a cross-version migration regression introduced
> by commit d1b4259f ("virtio-bus: Plug devices after features are
> negotiated").
> =

> The problem is encountered when host's vhost backend does not support
> VIRTIO_F_VERSION_1, and migration is initiated from a v2.7 or prior
> machine with virtio-pci modern capabilities enabled to a v2.8 machine.
> =

> In this case, modern capabilities get exposed to the guest by the source,
> whereas the target will detect version 1 is not supported so will only
> expose legacy capabilities.
> =

> The problem is fixed by introducing a new "x-modern-broken" property,
> which is set in v2.7 and prior compatibility modes. Doing this, v2.7
> machine keeps its broken behaviour (enabling modern while version is
> not supported), and newer machines will behave correctly.
> =

> Reported-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> Suggested-by: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
> Cc: Marcel Apfelbaum <marcel@redhat.com>
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Tested-by: Michael Roth <mdroth@linux.vnet.ibm.com>

I can confirm this fixes the original issue I reported. I also did a
number of sanity runs with 2.7/2.8/pc-i440fx-2.{6,7,8} using various
combinations of disable-modern=3Dtrue/false on hosts with/without virtio-1,
and some tests with pseries machines as well, and everything seems to
work.

Thanks for the quick fix!

> ---
> =

> I'm not sure about the property name, let me know if you have better idea=
s.
> I didn't tested migration yet, but I wanted to share the patch while I te=
st it.
> I tested booting v2.8 and v2.7 machines with !VERSION_1 and get expected =
result:
>  - v2.8: Virtio-pci probe succeed
>  - v2.7: Virtio-pci probe fails
> =

> Thanks,
> Maxime
> =

>  hw/virtio/virtio-pci.c | 4 +++-
>  hw/virtio/virtio-pci.h | 1 +
>  include/hw/compat.h    | 4 ++++
>  3 files changed, 8 insertions(+), 1 deletion(-)
> =

> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 521ba0b..93f6b54 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -1580,7 +1580,8 @@ static void virtio_pci_device_plugged(DeviceState *=
d, Error **errp)
>       * Virtio capabilities present without
>       * VIRTIO_F_VERSION_1 confuses guests
>       */
> -    if (!virtio_has_feature(vdev->host_features, VIRTIO_F_VERSION_1)) {
> +    if (!proxy->modern_broken &&
> +            !virtio_has_feature(vdev->host_features, VIRTIO_F_VERSION_1)=
) {
>          virtio_pci_disable_modern(proxy);
> =

>          if (!legacy) {
> @@ -1852,6 +1853,7 @@ static Property virtio_pci_properties[] =3D {
>                      VIRTIO_PCI_FLAG_DISABLE_PCIE_BIT, false),
>      DEFINE_PROP_BIT("page-per-vq", VirtIOPCIProxy, flags,
>                      VIRTIO_PCI_FLAG_PAGE_PER_VQ_BIT, false),
> +    DEFINE_PROP_BOOL("x-modern-broken", VirtIOPCIProxy, modern_broken, f=
alse),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =

> diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
> index b2a996f..1dca223 100644
> --- a/hw/virtio/virtio-pci.h
> +++ b/hw/virtio/virtio-pci.h
> @@ -153,6 +153,7 @@ struct VirtIOPCIProxy {
>      int config_cap;
>      uint32_t flags;
>      bool disable_modern;
> +    bool modern_broken;
>      OnOffAuto disable_legacy;
>      uint32_t class_code;
>      uint32_t nvectors;
> diff --git a/include/hw/compat.h b/include/hw/compat.h
> index 0f06e11..fe11723 100644
> --- a/include/hw/compat.h
> +++ b/include/hw/compat.h
> @@ -18,6 +18,10 @@
>          .driver   =3D "intel-iommu",\
>          .property =3D "x-buggy-eim",\
>          .value    =3D "true",\
> +    },{\
> +        .driver   =3D "virtio-pci",\
> +        .property =3D "x-modern-broken",\
> +        .value    =3D "on",\
>      },
> =

>  #define HW_COMPAT_2_6 \
> -- =

> 2.9.3
>=20
