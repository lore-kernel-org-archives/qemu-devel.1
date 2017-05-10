Received: from eggs.gnu.org ([2001:4830:134:3::10]:49008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d8OuP-0005uO-Q5
	for qemu-devel@nongnu.org; Wed, 10 May 2017 06:31:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d8OuK-0007DI-TQ
	for qemu-devel@nongnu.org; Wed, 10 May 2017 06:31:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58378)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d8OuK-0007D4-Kk
	for qemu-devel@nongnu.org; Wed, 10 May 2017 06:31:48 -0400
Date: Wed, 10 May 2017 11:31:41 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170510103141.GC4230@work-vm>
References: <20170505173507.74077-1-pasic@linux.vnet.ibm.com>
	<20170505173507.74077-7-pasic@linux.vnet.ibm.com>
	<20170508165501.GH2120@work-vm>
	<52177e87-8d46-e1f6-49cf-397f296dd366@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52177e87-8d46-e1f6-49cf-397f296dd366@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 06/10] virtio-ccw: use vmstate way for
 config migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

* Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
> 
> 
> On 05/08/2017 06:55 PM, Dr. David Alan Gilbert wrote:
> > * Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
> >> Let us use the freshly introduced vmstate migration helpers instead of
> >> saving/loading the config manually.
> >>
> >> To achieve this we need to hack the config_vector which is a common
> >> VirtIO state in the middle of the VirtioCcwDevice state representation.
> >> This somewhat ugly but we have no choice because the stream format needs
> >> to be preserved.
> >>
> >> Still no changes in behavior, but the dead code we added previously is
> >> finally awakening to life.
> >>
> >> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> >> ---
> >> ---
> >>  hw/s390x/virtio-ccw.c | 116 +++++++++++++++++++-------------------------------
> >>  1 file changed, 44 insertions(+), 72 deletions(-)
> >>
> >> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> >> index c2badfe..8ab655c 100644
> >> --- a/hw/s390x/virtio-ccw.c
> >> +++ b/hw/s390x/virtio-ccw.c
> >> @@ -57,6 +57,32 @@ static int virtio_ccw_dev_post_load(void *opaque, int version_id)
> >>      return 0;
> >>  }
> >>  
> >> +static int get_config_vector(QEMUFile *f, void *pv, size_t size,
> >> +                             VMStateField *field)
> >> +{
> >> +    VirtioCcwDevice *dev = pv;
> >> +    VirtIODevice *vdev = virtio_bus_get_device(&dev->bus);
> >> +
> >> +    qemu_get_be16s(f, &vdev->config_vector);
> >> +    return 0;
> >> +}
> >> +
> >> +static int put_config_vector(QEMUFile *f, void *pv, size_t size,
> >> +                             VMStateField *field, QJSON *vmdesc)
> >> +{
> >> +    VirtioCcwDevice *dev = pv;
> >> +    VirtIODevice *vdev = virtio_bus_get_device(&dev->bus);
> >> +
> >> +    qemu_put_be16(f, vdev->config_vector);
> >> +    return 0;
> >> +}
> > Again that should be doable using WITH_TMP.
> > (I do wonder if we need a macro for cases where it's just a casting
> > operation to another type).
> > 
> 
> Yeah this one can be done with WITH_TMP. Below is the patch on top of
> this patch set. It's a bit more verbose (+6 lines) but it looks a bit
> nicer and probably also safer in (terms of symmetric read and write).
> 
> If you think its the way to go I will squash it into this patch for
> the next version.

Yes, I prefer that to using qemu_put/qemu_get - I'm trying to avoid
all new uses of those except where we can't avoid them.

(There's still the separate question of whether reworking a virtio
device migration to be unlike the other virtio devices is right,
but that's separate to whether we should avoid qemu_get/put)

Dave

> -----------------------------8<-----------------------------------------
> 
> 
> From e92135590ab95cc565b37913de77a9ed17012933 Mon Sep 17 00:00:00 2001
> From: Halil Pasic <pasic@linux.vnet.ibm.com>
> Date: Tue, 9 May 2017 16:01:50 +0200
> Subject: [PATCH 1/2] virtio-ccw: replace info with VMSTATE_WITH_TMP
> 
> Convert s VMSatateInfo based solution manipulating the migration stream
> directly to VMSTATE_WITH_TMP witch keeps IO and transformation logic
> separate. 
> 
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
>  hw/s390x/virtio-ccw.c | 40 +++++++++++++++++++++++-----------------
>  1 file changed, 23 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> index c611b6f..6ebc78a 100644
> --- a/hw/s390x/virtio-ccw.c
> +++ b/hw/s390x/virtio-ccw.c
> @@ -57,30 +57,38 @@ static int virtio_ccw_dev_post_load(void *opaque, int version_id)
>      return 0;
>  }
>  
> -static int get_config_vector(QEMUFile *f, void *pv, size_t size,
> -                             VMStateField *field)
> +typedef struct VirtioCcwDeviceTmp {
> +    VirtioCcwDevice *parent;
> +    uint16_t config_vector;
> +} VirtioCcwDeviceTmp;
> +
> +static void virtio_ccw_dev_tmp_pre_save(void *opaque)
>  {
> -    VirtioCcwDevice *dev = pv;
> +    VirtioCcwDeviceTmp *tmp = opaque;
> +    VirtioCcwDevice *dev = tmp->parent;
>      VirtIODevice *vdev = virtio_bus_get_device(&dev->bus);
>  
> -    qemu_get_be16s(f, &vdev->config_vector);
> -    return 0;
> +    tmp->config_vector = vdev->config_vector;
>  }
>  
> -static int put_config_vector(QEMUFile *f, void *pv, size_t size,
> -                             VMStateField *field, QJSON *vmdesc)
> +static int virtio_ccw_dev_tmp_post_load(void *opaque, int version_id)
>  {
> -    VirtioCcwDevice *dev = pv;
> +    VirtioCcwDeviceTmp *tmp = opaque;
> +    VirtioCcwDevice *dev = tmp->parent;
>      VirtIODevice *vdev = virtio_bus_get_device(&dev->bus);
>  
> -    qemu_put_be16(f, vdev->config_vector);
> +    vdev->config_vector = tmp->config_vector;
>      return 0;
>  }
>  
> -const VMStateInfo vmstate_info_config_vector = {
> -    .name = "config_vector",
> -    .get = get_config_vector,
> -    .put = put_config_vector,
> +const VMStateDescription vmstate_virtio_ccw_dev_tmp = {
> +    .name = "s390_virtio_ccw_dev_tmp",
> +    .pre_save = virtio_ccw_dev_tmp_pre_save,
> +    .post_load = virtio_ccw_dev_tmp_post_load,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT16(config_vector, VirtioCcwDeviceTmp),
> +        VMSTATE_END_OF_LIST()
> +    }
>  };
>  
>  const VMStateDescription vmstate_virtio_ccw_dev = {
> @@ -93,14 +101,12 @@ const VMStateDescription vmstate_virtio_ccw_dev = {
>          VMSTATE_PTR_TO_IND_ADDR(indicators, VirtioCcwDevice),
>          VMSTATE_PTR_TO_IND_ADDR(indicators2, VirtioCcwDevice),
>          VMSTATE_PTR_TO_IND_ADDR(summary_indicator, VirtioCcwDevice),
> -        {
>          /*
>           * Ugly hack because VirtIODevice does not migrate itself.
>           * This also makes legacy via vmstate_save_state possible.
>           */
> -            .name         = "virtio/config_vector",
> -            .info         = &vmstate_info_config_vector,
> -        },
> +        VMSTATE_WITH_TMP(VirtioCcwDevice, VirtioCcwDeviceTmp,
> +                         vmstate_virtio_ccw_dev_tmp),
>          VMSTATE_STRUCT(routes, VirtioCcwDevice, 1, vmstate_adapter_routes, \
>                         AdapterRoutes),
>          VMSTATE_UINT8(thinint_isc, VirtioCcwDevice),
> -- 
> 2.10.2
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
