Received: from eggs.gnu.org ([2001:4830:134:3::10]:53038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f5Riv-00005Y-Dg
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 04:00:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f5Rip-0003Xz-Gs
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 04:00:21 -0400
Date: Mon, 9 Apr 2018 10:00:01 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180409100001.2ef30abb.cohuck@redhat.com>
In-Reply-To: <152311222681.203086.8874800175539040298.stgit@bahia>
References: <152311221072.203086.16767398863033055271.stgit@bahia>
	<152311222681.203086.8874800175539040298.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] vfio-ccw: fix memory leaks in
 vfio_ccw_realize()
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

On Sat, 07 Apr 2018 16:43:46 +0200
Greg Kurz <groug@kaod.org> wrote:

> If the subchannel is already attached or if vfio_get_device() fails, the
> code jumps to the 'out_device_err' label and doesn't free the string it
> has just allocated.
> 
> The code should be reworked so that vcdev->vdev.name only gets set when
> the device has been attached, and freed when it is about to be detached.
> This could be achieved  with the addition of a vfio_ccw_get_device()
> function that would be the counterpart of vfio_put_device(). But this is
> a more elaborate cleanup that should be done in a follow-up. For now,
> let's just add calls to g_free() on the buggy error paths.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/vfio/ccw.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 4e5855741a64..fe34b507699f 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -357,11 +357,13 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
>          if (strcmp(vbasedev->name, vcdev->vdev.name) == 0) {
>              error_setg(&err, "vfio: subchannel %s has already been attached",
>                         vcdev->vdev.name);
> +            g_free(vcdev->vdev.name);
>              goto out_device_err;
>          }
>      }
>  
>      if (vfio_get_device(group, cdev->mdevid, &vcdev->vdev, &err)) {
> +        g_free(vcdev->vdev.name);
>          goto out_device_err;
>      }
>  
> 

Thanks, applied to s390-fixes.
