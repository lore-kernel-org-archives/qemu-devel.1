Received: from eggs.gnu.org ([2001:4830:134:3::10]:55570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fhxCD-00015z-V2
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 09:17:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fhxC8-0000W8-Sn
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 09:17:45 -0400
Date: Tue, 24 Jul 2018 15:17:32 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180724151732.608d7183.cohuck@redhat.com>
In-Reply-To: <1532421839-24512-1-git-send-email-thuth@redhat.com>
References: <1532421839-24512-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2] hw/s390x/virtio-ccw: Consolidate
 calls to virtio_ccw_unrealize()
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

On Tue, 24 Jul 2018 10:43:59 +0200
Thomas Huth <thuth@redhat.com> wrote:

> Currently, every virtio-ccw device explicitely sets its unrealize
> function to virtio_ccw_unrealize() in its class_init function.
> We can simplify this by using a common unrealize function, just like
> it is already done for the realize functions.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/s390x/virtio-ccw.c | 22 +++++++---------------
>  1 file changed, 7 insertions(+), 15 deletions(-)
> 
> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> index 7ddb378..f3ad7aa 100644
> --- a/hw/s390x/virtio-ccw.c
> +++ b/hw/s390x/virtio-ccw.c
> @@ -750,8 +750,9 @@ out_err:
>      g_free(sch);
>  }
>  
> -static void virtio_ccw_unrealize(VirtioCcwDevice *dev, Error **errp)
> +static void virtio_ccw_device_unrealize(VirtioCcwDevice *dev, Error **errp)
>  {
> +    VirtIOCCWDeviceClass *dc = VIRTIO_CCW_DEVICE_GET_CLASS(dev);
>      CcwDevice *ccw_dev = CCW_DEVICE(dev);
>      SubchDev *sch = ccw_dev->sch;
>  
> @@ -764,6 +765,10 @@ static void virtio_ccw_unrealize(VirtioCcwDevice *dev, Error **errp)
>          release_indicator(&dev->routes.adapter, dev->indicators);
>          dev->indicators = NULL;
>      }
> +
> +    if (dc->unrealize) {
> +        dc->unrealize(dev, errp);
> +    }
>  }
>  

Hm... if any device type should have the need to do something in the
unrealize path, it would probably want to do it before the common
unrealize handling, I think. For example, it might want a valid sch.
