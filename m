Received: from eggs.gnu.org ([2001:4830:134:3::10]:51900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fhcVR-0004HD-RM
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 11:12:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fhcVO-0000qO-MP
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 11:12:13 -0400
Date: Mon, 23 Jul 2018 17:12:06 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180723171206.476d69ef.cohuck@redhat.com>
In-Reply-To: <1532356951-18210-1-git-send-email-thuth@redhat.com>
References: <1532356951-18210-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH] hw/s390x/virtio-ccw: Consolidate calls
 to virtio_ccw_unrealize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org

On Mon, 23 Jul 2018 16:42:31 +0200
Thomas Huth <thuth@redhat.com> wrote:

> Currently, every virtio-ccw device explicitely sets its unrealize
> function to virtio_ccw_unrealize() in its class_init function.
> We can simplify this by using this unrealize function in the common
> virtio_ccw_busdev_unrealize() function if no other device unrealize
> function has been set.

Sounds sensible to consolidate that.

> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/s390x/virtio-ccw.c | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)
> 

> @@ -1705,7 +1695,11 @@ static void virtio_ccw_busdev_unrealize(DeviceState *dev, Error **errp)
>      VirtioCcwDevice *_dev = (VirtioCcwDevice *)dev;
>      VirtIOCCWDeviceClass *_info = VIRTIO_CCW_DEVICE_GET_CLASS(dev);
>  
> -    _info->unrealize(_dev, errp);
> +    if (_info->unrealize) {
> +        _info->unrealize(_dev, errp);
> +    } else {
> +        virtio_ccw_unrealize(_dev, errp);
> +    }

However, I think it is better to call virtio_ccw_unrealize()
unconditionally here (as we want to make sure it is always invoked) and
call ->unrealize from there if set. That also mirrors what we do for
realize.

>  }
>  
>  static void virtio_ccw_busdev_unplug(HotplugHandler *hotplug_dev,
