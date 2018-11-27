Received: from eggs.gnu.org ([2001:4830:134:3::10]:44642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gRb1Y-0005I1-38
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 05:55:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gRb1U-0003TO-0Q
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 05:55:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1gRb1S-0003RB-QG
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 05:55:19 -0500
Date: Tue, 27 Nov 2018 11:54:29 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181127115429.27366f75.cohuck@redhat.com>
In-Reply-To: <20181127024959.7060-3-ehabkost@redhat.com>
References: <20181127024959.7060-1-ehabkost@redhat.com>
	<20181127024959.7060-3-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 v3 2/2] virtio: Provide
 version-specific variants of virtio PCI devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Andrea Bolognani <abologna@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, libvir-list@redhat.com, Wainer dos Santos Moschetta <wainersm@redhat.com>, Markus Armbruster <armbru@redhat.com>, Laine Stump <laine@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Amit Shah <amit@kernel.org>, Cleber Rosa <crosa@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Max Reitz <mreitz@redhat.com>, Jason Wang <jasowang@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Caio Carrara <ccarrara@redhat.com>

On Tue, 27 Nov 2018 00:49:59 -0200
Eduardo Habkost <ehabkost@redhat.com> wrote:

> Many of the current virtio-*-pci device types actually represent
> 3 different types of devices:
> * virtio 1.0 non-transitional devices
> * virtio 1.0 transitional devices
> * virtio 0.9 ("legacy device" in virtio 1.0 terminology)
> 
> That would be just an annoyance if it didn't break our device/bus
> compatibility QMP interfaces.  With these multi-purpose device
> types, there's no way to tell management software that
> transitional devices and legacy devices require a Conventional
> PCI bus.
> 
> The multi-purpose device types would also prevent us from telling
> management software what's the PCI vendor/device ID for them,
> because their PCI IDs change at runtime depending on the bus
> where they were plugged.
> 
> This patch adds separate device types for each of those virtio
> device flavors:
> 
> - virtio-*-pci: the existing multi-purpose device types
>   - Configurable using `disable-legacy` and `disable-modern`
>     properties
>   - Legacy driver support is automatically enabled/disabled
>     depending on the bus where it is plugged
>   - Supports Conventional PCI and PCI Express buses
>     (but Conventional PCI is incompatible with
>     disable-legacy=off)
>   - Changes PCI vendor/device IDs at runtime
> - virtio-*-pci-transitional: virtio-1.0 device supporting legacy drivers
>   - Supports Conventional PCI buses only, because
>     it has a PIO BAR
> - virtio-*-pci-non-transitional: modern-only
>   - Supports both Conventional PCI and PCI Express buses
> 
> The existing TYPE_* macros for these types will point to an
> abstract base type, so existing casts in the code will keep
> working for all variants.
> 
> A simple test script (tests/acceptance/virtio_version.py) is
> included, to check if the new device types are equivalent to
> using the `disable-legacy` and `disable-modern` options.
> 
> Acked-by: Andrea Bolognani <abologna@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Changes v2 -> v3:
> * Split into two separate patches (type registration helper
>   and introduction of new types)
> * Include full type names as literals in the code instead
>   of generating type names automatically
> 
> Changes v1 -> v2:
> * Removed *-0.9 devices.  Nobody will want to use them, if
>   transitional devices work with legacy drivers
>   (Gerd Hoffmann, Michael S. Tsirkin)
> * Drop virtio version from name: rename -1.0-transitional to
>   -transitional (Michael S. Tsirkin)
> * Renamed -1.0 to -non-transitional
> * Don't add any extra variants to modern-only device types
>   (they don't need it)
> * Fix typo on TYPE_VIRTIO_INPUT_HOST_PCI (crash reported by
>   Cornelia Huck)
> * No need to change cast macros for modern-only devices
> * Rename virtio_register_types() to virtio_pci_types_register()
> ---
>  hw/virtio/virtio-pci.h             |  24 ++--
>  hw/virtio/virtio-pci.c             |  60 ++++++++--
>  tests/acceptance/virtio_version.py | 177 +++++++++++++++++++++++++++++
>  3 files changed, 237 insertions(+), 24 deletions(-)
>  create mode 100644 tests/acceptance/virtio_version.py
> 

(...)

> diff --git a/tests/acceptance/virtio_version.py b/tests/acceptance/virtio_version.py
> new file mode 100644
> index 0000000000..a8d0b20b75
> --- /dev/null
> +++ b/tests/acceptance/virtio_version.py
> @@ -0,0 +1,177 @@
> +"""
> +Check compatibility of virtio device types
> +"""
> +# Copyright (c) 2018 Red Hat, Inc.
> +#
> +# Author:
> +#  Eduardo Habkost <ehabkost@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +import sys
> +import os
> +
> +sys.path.append(os.path.join(os.path.dirname(__file__), "..", "..", "scripts"))
> +from qemu import QEMUMachine
> +from avocado_qemu import Test
> +
> +# Virtio Device IDs:
> +VIRTIO_NET = 1
> +VIRTIO_BLOCK = 2
> +VIRTIO_CONSOLE = 3
> +VIRTIO_RNG = 4
> +VIRTIO_BALLOON = 5
> +VIRTIO_RPMSG = 7
> +VIRTIO_SCSI = 8
> +VIRTIO_9P = 9
> +VIRTIO_RPROC_SERIAL = 11
> +VIRTIO_CAIF = 12
> +VIRTIO_GPU = 16
> +VIRTIO_INPUT = 18
> +VIRTIO_VSOCK = 19
> +VIRTIO_CRYPTO = 20

We may want to include additional device types when they are added; but
I expect them to be modern-only, so I don't think we'd miss problems if
they aren't covered here.

(...)

Review of the test case was more superficial; but have a

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
