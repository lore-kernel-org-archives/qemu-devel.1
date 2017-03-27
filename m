Received: from eggs.gnu.org ([2001:4830:134:3::10]:37631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1csZGH-0007Pe-Bo
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 14:21:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1csZGE-0001t5-TQ
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 14:21:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1csZGE-0001pu-GM
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 14:20:58 -0400
Date: Mon, 27 Mar 2017 21:20:56 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170327211728-mutt-send-email-mst@kernel.org>
References: <149063674781.4447.14258971700726134711.stgit@bahia.lan>
	<149063676337.4447.2095575576822297032.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <149063676337.4447.2095575576822297032.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 1/5] virtio: Error object based
 virtio_error()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>

On Mon, Mar 27, 2017 at 07:46:03PM +0200, Greg Kurz wrote:
> This introduces an Error object based implementation of virtio_error(). It
> allows to implement virtio_error() wrappers in device-specific code.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/virtio/virtio.c         |   21 ++++++++++++++++-----
>  include/hw/virtio/virtio.h |    1 +
>  2 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 03592c542a55..4036f4816038 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -2443,6 +2443,16 @@ void virtio_device_set_child_bus_name(VirtIODevice *vdev, char *bus_name)
>      vdev->bus_name = g_strdup(bus_name);
>  }
>  
> +static void virtio_device_set_broken(VirtIODevice *vdev)
> +{
> +    vdev->broken = true;
> +
> +    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> +        virtio_set_status(vdev, vdev->status | VIRTIO_CONFIG_S_NEEDS_RESET);
> +        virtio_notify_config(vdev);
> +    }
> +}
> +
>  void GCC_FMT_ATTR(2, 3) virtio_error(VirtIODevice *vdev, const char *fmt, ...)
>  {
>      va_list ap;

It's worth pondering whether we can set this for versions < 1.0 too.


> @@ -2451,12 +2461,13 @@ void GCC_FMT_ATTR(2, 3) virtio_error(VirtIODevice *vdev, const char *fmt, ...)
>      error_vreport(fmt, ap);
>      va_end(ap);
>  
> -    vdev->broken = true;
> +    virtio_device_set_broken(vdev);
> +}
>  
> -    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> -        virtio_set_status(vdev, vdev->status | VIRTIO_CONFIG_S_NEEDS_RESET);
> -        virtio_notify_config(vdev);
> -    }
> +void virtio_error_err(VirtIODevice *vdev, Error *err)
> +{
> +    error_report_err(err);
> +    virtio_device_set_broken(vdev);
>  }
>  
>  static void virtio_memory_listener_commit(MemoryListener *listener)

Should this skip error report if device is already broken?
Otherwise we'll get a ton of errors in the log.

Also, whether to stop the device, or the VM, or just warn,
seems like a policy decision. Why not set it on command line
like we do for other storage?

> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 15efcf205711..5b13c5f67b63 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -150,6 +150,7 @@ void virtio_init(VirtIODevice *vdev, const char *name,
>  void virtio_cleanup(VirtIODevice *vdev);
>  
>  void virtio_error(VirtIODevice *vdev, const char *fmt, ...) GCC_FMT_ATTR(2, 3);
> +void virtio_error_err(VirtIODevice *vdev, Error *err);
>  
>  /* Set the child bus name. */
>  void virtio_device_set_child_bus_name(VirtIODevice *vdev, char *bus_name);
