Received: from eggs.gnu.org ([208.118.235.92]:59390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gezSZ-0004jj-KQ
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 04:38:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gezST-0006Xn-Pf
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 04:38:36 -0500
References: <20181205195704.17605-1-ehabkost@redhat.com>
	<20181205195704.17605-3-ehabkost@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a28d196a-e2fe-a013-a6e2-99ac260f6279@redhat.com>
Date: Thu, 3 Jan 2019 10:38:18 +0100
MIME-Version: 1.0
In-Reply-To: <20181205195704.17605-3-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 v4 2/2] virtio: Provide
 version-specific variants of virtio PCI devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Amit Shah <amit@kernel.org>, qemu-s390x@nongnu.org, Markus Armbruster <armbru@redhat.com>, Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Andrea Bolognani <abologna@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Max Reitz <mreitz@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Laine Stump <laine@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>

On 2018-12-05 20:57, Eduardo Habkost wrote:
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
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

 Hi Eduardo,

with these new devices, I can trigger an abort on s390x:

$ qemu-system-s390x -M s390-ccw-virtio-2.5 -monitor stdio -no-shutdown
QEMU 3.1.50 monitor - type 'help' for more information
(qemu) device_add vhost-scsi-pci-non-transitional
qemu-system-s390x: hw/core/qdev-properties.c:1236:
qdev_prop_set_globals: Assertion `prop->user_provided' failed.
Aborted (core dumped)

Any ideas how to fix that?

 Thomas
