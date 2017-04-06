Received: from eggs.gnu.org ([2001:4830:134:3::10]:33667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cw6Nh-0004VS-MW
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 08:19:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cw6Ne-0000ml-EX
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 08:19:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44850)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cw6Ne-0000m4-5V
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 08:19:14 -0400
References: <20170406111646.12624-1-cornelia.huck@de.ibm.com>
	<20170406111646.12624-6-cornelia.huck@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5e9b4ef5-f737-bc26-433d-f111e44e294a@redhat.com>
Date: Thu, 6 Apr 2017 14:19:10 +0200
MIME-Version: 1.0
In-Reply-To: <20170406111646.12624-6-cornelia.huck@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.10 05/10] s390x/css: provide
 introspection for virtual subchannel and device busid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, agraf@suse.de

On 06.04.2017 13:16, Cornelia Huck wrote:
> From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> 
> Expose the busids of the virtual I/O subchannel and the virtual CCW
> device to ease debugging. This is needed because:
> 1. subchannel id are assigned dynamically, and cannot be set from
>    outside.
> 2. device busid could possibly be auto generated.
> 
> An example of using HMP to retrieve the property values of a
> virtio-balloon-ccw device looks like:
> 
> [root@localhost ~]# lscss -d 0.0.0004
> Device   Subchan.  DevType CU Type Use  PIM PAM POM  CHPIDs
> ----------------------------------------------------------------------
> 0.0.0004 0.0.0003  0000/00 3832/05 yes  80  80  ff   00000000 00000000
> 
> (qemu) info qtree
> ... ...
>       dev: virtio-balloon-ccw, id "balloon0"
>         devno = "<unset>"
>         ioeventfd = true
>         max_revision = 2 (0x2)
>         dev_id = "fe.0.0004"
>         subch_id = "fe.0.0003"
> ... ...
> 
> After migration, if we have the same device that shows up on a
> different subchannel, we must re-fill the subch_id of the ccw
> device with the new schid, or the subch_id will have an old wrong
> schid value. So this also re-fills the subch_id after migration.
> 
> While we are at it, also neaten the related error handling a bit.
> 
> Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> ---
>  hw/s390x/ccw-device.c | 39 +++++++++++++++++++++++++++++++++++++++
>  hw/s390x/ccw-device.h |  7 +++++++
>  hw/s390x/virtio-ccw.c | 28 ++++++++++++++++++++++------
>  3 files changed, 68 insertions(+), 6 deletions(-)
[...]
>  static inline CcwDevice *to_ccw_dev_fast(DeviceState *d)
> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> index 00b3bde4e9..4e59e34d74 100644
> --- a/hw/s390x/virtio-ccw.c
> +++ b/hw/s390x/virtio-ccw.c
> @@ -680,6 +680,7 @@ static void virtio_ccw_device_realize(VirtioCcwDevice *dev, Error **errp)
>  {
>      VirtIOCCWDeviceClass *k = VIRTIO_CCW_DEVICE_GET_CLASS(dev);
>      CcwDevice *ccw_dev = CCW_DEVICE(dev);
> +    CCWDeviceClass *ck = CCW_DEVICE_GET_CLASS(ccw_dev);
>      SubchDev *sch = css_create_virtual_sch(ccw_dev->bus_id, errp);
>      Error *err = NULL;
>  
> @@ -689,8 +690,7 @@ static void virtio_ccw_device_realize(VirtioCcwDevice *dev, Error **errp)
>      if (!virtio_ccw_rev_max(dev) && dev->force_revision_1) {
>          error_setg(&err, "Invalid value of property max_rev "
>                     "(is %d expected >= 1)", virtio_ccw_rev_max(dev));
> -        error_propagate(errp, err);
> -        return;
> +        goto out_err;
>      }
>  
>      sch->driver_data = dev;
> @@ -713,13 +713,24 @@ static void virtio_ccw_device_realize(VirtioCcwDevice *dev, Error **errp)
>  
>      if (k->realize) {
>          k->realize(dev, &err);
> +        if (err) {
> +            goto out_err;
> +        }
>      }
> +
> +    ck->realize(ccw_dev, &err);
>      if (err) {
> -        error_propagate(errp, err);
> -        css_subch_assign(sch->cssid, sch->ssid, sch->schid, sch->devno, NULL);
> -        ccw_dev->sch = NULL;
> -        g_free(sch);
> +        goto out_err;
>      }
> +
> +    return;
> +
> +out_err:
> +    error_propagate(errp, err);
> +    css_subch_assign(sch->cssid, sch->ssid, sch->schid, sch->devno, NULL);
> +    ccw_dev->sch = NULL;
> +    g_free(sch);
> +    return;
>  }

Cosmetic nit: Remove the unnecessary "return;" statement right before
the closing curly bracket.

 Thomas
