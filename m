Received: from eggs.gnu.org ([2001:4830:134:3::10]:58006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f5Sg6-0002zH-1P
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 05:01:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f5Sg2-0003wV-2K
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 05:01:30 -0400
Date: Mon, 9 Apr 2018 11:01:12 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180409110112.3c6324e7.cohuck@redhat.com>
In-Reply-To: <152311224179.203086.10603697792860546407.stgit@bahia>
References: <152311221072.203086.16767398863033055271.stgit@bahia>
	<152311224179.203086.10603697792860546407.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] vfio-ccw: introduce
 vfio_ccw_get_device()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, qemu-s390x@nongnu.org, qemu-stable@nongnu.org

On Sat, 07 Apr 2018 16:44:01 +0200
Greg Kurz <groug@kaod.org> wrote:

> A recent patch fixed leaks of the dynamically allocated vcdev->vdev.name
> field in vfio_ccw_realize(), but we now have three freeing sites for it.
> This is unfortunate and seems to indicate something is wrong with its
> life cycle.
> 
> The root issue is that vcdev->vdev.name is set before vfio_get_device()
> is called, which theoretically prevents to call vfio_put_device() to
> do the freeing. Well actually, we could call it anyway  because
> vfio_put_base_device() is a nop if the device isn't attached, but this
> would be confusing.
> 
> This patch hence moves all the logic of attaching the device, including
> the "already attached" check, to a separate vfio_ccw_get_device() function,
> counterpart of vfio_put_device(). While here, vfio_put_device() is renamed
> to vfio_ccw_put_device() for consistency.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/vfio/ccw.c |   56 ++++++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 36 insertions(+), 20 deletions(-)
> 
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index fe34b507699f..49ae986d288d 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -292,12 +292,44 @@ static void vfio_ccw_put_region(VFIOCCWDevice *vcdev)
>      g_free(vcdev->io_region);
>  }
>  
> -static void vfio_put_device(VFIOCCWDevice *vcdev)
> +static void vfio_ccw_put_device(VFIOCCWDevice *vcdev)
>  {
>      g_free(vcdev->vdev.name);
>      vfio_put_base_device(&vcdev->vdev);
>  }
>  
> +static int vfio_ccw_get_device(VFIOGroup *group, VFIOCCWDevice *vcdev,
> +                               Error **errp)

Make this one void, as you already pass an error object?

> +{
> +    char *name = g_strdup_printf("%x.%x.%04x", vcdev->cdev.hostid.cssid,
> +                                 vcdev->cdev.hostid.ssid,
> +                                 vcdev->cdev.hostid.devid);
> +    VFIODevice *vbasedev;
> +
> +    QLIST_FOREACH(vbasedev, &group->device_list, next) {
> +        if (strcmp(vbasedev->name, name) == 0) {
> +            error_setg(errp, "vfio: subchannel %s has already been attached",
> +                       name);
> +            goto out_err;
> +        }
> +    }
> +
> +    if (vfio_get_device(group, vcdev->cdev.mdevid, &vcdev->vdev, errp)) {
> +        goto out_err;
> +    }
> +
> +    vcdev->vdev.ops = &vfio_ccw_ops;
> +    vcdev->vdev.type = VFIO_DEVICE_TYPE_CCW;
> +    vcdev->vdev.name = name;
> +    vcdev->vdev.dev = &vcdev->cdev.parent_obj.parent_obj;
> +
> +    return 0;
> +
> +out_err:
> +    g_free(name);
> +    return -1;

That -1 return code looks artificial, so I really think this should be
void :) The only caller already defines a local error object anyway, so
it can just check for err.

> +}
> +
>  static VFIOGroup *vfio_ccw_get_group(S390CCWDevice *cdev, Error **errp)
>  {
>      char *tmp, group_path[PATH_MAX];
