Received: from eggs.gnu.org ([2001:4830:134:3::10]:54398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dXIE0-0005I5-Ik
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 22:27:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dXIDv-0003ek-Kv
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 22:27:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36600)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1dXIDv-0003eK-Eu
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 22:26:55 -0400
Date: Mon, 17 Jul 2017 20:26:53 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170717202653.46b12372@w520.home>
In-Reply-To: <20170718014926.44781-3-bjsdjshi@linux.vnet.ibm.com>
References: <20170718014926.44781-1-bjsdjshi@linux.vnet.ibm.com>
	<20170718014926.44781-3-bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] vfio/ccw: fix initialization of the
 Object DeviceState pointer in the common base-device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, cohuck@redhat.com, borntraeger@de.ibm.com

On Tue, 18 Jul 2017 03:49:26 +0200
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> Commit 7da624e2 ("vfio: Test realized when using VFIOGroup.device_list
> iterator") introduced a pointer to the Object DeviceState in the VFIO
> common base-device and skiped non-realized devices as we iterate
> VFIOGroup.device_list. While it missed to initialize the pointer for
> the vfio-ccw case. Let's fix it.
> 
> Fixes: 7da624e2 ("vfio: Test realized when using VFIOGroup.device_list
>                   iterator")

Sorry for that.

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>

> Cc: Alex Williamson <alex.williamson@redhat.com>
> Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> ---
>  hw/vfio/ccw.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 8d97b53e77..a8baadf57a 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -338,6 +338,7 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
>      vcdev->vdev.type = VFIO_DEVICE_TYPE_CCW;
>      vcdev->vdev.name = g_strdup_printf("%x.%x.%04x", cdev->hostid.cssid,
>                                         cdev->hostid.ssid, cdev->hostid.devid);
> +    vcdev->vdev.dev = dev;
>      QLIST_FOREACH(vbasedev, &group->device_list, next) {
>          if (strcmp(vbasedev->name, vcdev->vdev.name) == 0) {
>              error_setg(&err, "vfio: subchannel %s has already been attached",
