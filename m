Received: from eggs.gnu.org ([2001:4830:134:3::10]:33872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dctQ8-0006w8-Oz
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 09:10:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dctQ4-0008Fp-2Z
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 09:10:40 -0400
Date: Wed, 2 Aug 2017 10:10:21 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170802131021.GF3108@localhost.localdomain>
References: <20170801230155.21083-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170801230155.21083-1-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] virtio: Mark virtio-device as
 non-user-creatable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org

On Tue, Aug 01, 2017 at 08:01:55PM -0300, Eduardo Habkost wrote:
> TYPE_VIRTIO_DEVICE devices are already not usable with -device
> and device_add, but they are reported as user-creatable on
> "-device help" and through monitor interfaces.
> 
> Mark them as not user-creatable to avoid confusing users, and to
> allow automated testing (e.g. scripts/device-crash-test) to skip
> them.
> 
> Before this patch, device-crash-test will try to test
> virtio-device devices with all machine-types:
> 
>   $ time ./scripts/device-crash-test -D virtio-device -v ./x86_64-softmmu/qemu-system-x86_64
>   [...]
>   INFO: Total: 1088 test cases
>   INFO: Skipped 408 test cases
> 
>   real    0m49.775s
> 
> After this patch, the script won't try to test virtio-device
> devices:
> 
>   $ time ./scripts/device-crash-test -D virtio-device -v ./x86_64-softmmu/qemu-system-x86_64
>   INFO: Total: 0 test cases
> 
>   real    0m0.092s
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  hw/virtio/virtio.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 464947f..c4bdb94 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -2653,6 +2653,17 @@ static void virtio_device_class_init(ObjectClass *klass, void *data)
>      dc->unrealize = virtio_device_unrealize;
>      dc->bus_type = TYPE_VIRTIO_BUS;
>      dc->props = virtio_properties;
> +    /*
> +     * Reason:
> +     * - TYPE_VIRTIO_DEVICE devices are not visible to guests
> +     *   unless they are created and controlled by transport-specific
> +     *   devices (virtio-pci, virtio-mmio, and virtio-ccw).
> +     * - A TYPE_VIRTIO_BUS bus is never available for plugging
> +     *   using -device/device_add, as virtio-bus buses are
> +     *   created on the fly and immediately populated by the
> +     *   transport-specific devices' realize methods.
> +     */

Oops, I just found out that this is not true on virtio-mmio:
unused virtio-mmio-bus buses are available for plugging when
virtio-mmio devices are created.

So at least on arm, there are virtio-bus buses where
virtio-device devices can be plugged by users, and this patch is
incorrect.

> +    dc->user_creatable = false;
>      vdc->start_ioeventfd = virtio_device_start_ioeventfd_impl;
>      vdc->stop_ioeventfd = virtio_device_stop_ioeventfd_impl;
>  
> -- 
> 2.9.4
> 

-- 
Eduardo
