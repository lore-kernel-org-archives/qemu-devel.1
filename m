Received: from eggs.gnu.org ([2001:4830:134:3::10]:40785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fICQi-0007P7-Rb
	for qemu-devel@nongnu.org; Mon, 14 May 2018 08:18:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fICQf-0002L9-MQ
	for qemu-devel@nongnu.org; Mon, 14 May 2018 08:18:16 -0400
Date: Mon, 14 May 2018 14:18:08 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180514141808.78efe5c0.cohuck@redhat.com>
In-Reply-To: <20180510000712.6472-2-pasic@linux.ibm.com>
References: <20180510000712.6472-1-pasic@linux.ibm.com>
	<20180510000712.6472-2-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] vfio-ccw: add force unlimited prefetch
 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Dong Jia Shi <bjsdjshi@linux.ibm.com>, "Jason J. Herne" <jjherne@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>

On Thu, 10 May 2018 02:07:11 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> There is at least one control program (guest) that although it does not

I'd drop 'control program' here as well, as it probably confuses more
than helps.

> rely on the guarantees provided by ORB 1 word 9 bit (aka unlimited
> prefetch, aka P bit) not being set, fails to tell this to the machine.
> 
> Usually this ain't a big deal, as the story is usually about performance
> optimizations only. But vfio-ccw can not provide the guarantees required
> if the bit is not set.

Isn't that also about channel program rewriting? Or am I mixing things
up?

> 
> Since it is impossible to implement support for P bit not set (at
> impossible least without transitioning to lower level protocols) in
> vfio-ccw let's provide a manual override.

Hm... so the basic idea seems to be "we don't support !PFCH, but we
know that the guest will not rely on the guarantees, so we provide the
host admin with a way to override the setting"?

> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> Suggested-by: Dong Jia Shi <bjsdjshi@linux.ibm.com>
> Acked-by: Jason J. Herne <jjherne@linux.ibm.com>
> Tested-by: Jason J. Herne <jjherne@linux.ibm.com>
> ---
>  hw/s390x/css.c |  3 +--
>  hw/vfio/ccw.c  | 13 +++++++++++++
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index 301bf1772f..32f1b2820d 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -1196,8 +1196,7 @@ static IOInstEnding sch_handle_start_func_passthrough(SubchDev *sch)
>       * Only support prefetch enable mode.
>       * Only support 64bit addressing idal.
>       */
> -    if (!(orb->ctrl0 & ORB_CTRL0_MASK_PFCH) ||
> -        !(orb->ctrl0 & ORB_CTRL0_MASK_C64)) {
> +    if (!(orb->ctrl0 & ORB_CTRL0_MASK_C64)) {
>          warn_report("vfio-ccw requires PFCH and C64 flags set");

Adapt this warning?

>          sch_gen_unit_exception(sch);
>          css_inject_io_interrupt(sch);
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index e67392c5f9..32cf606a71 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -32,6 +32,8 @@ typedef struct VFIOCCWDevice {
>      uint64_t io_region_offset;
>      struct ccw_io_region *io_region;
>      EventNotifier io_notifier;
> +    /* force unlimited prefetch */
> +    bool f_upfch;

force_unlimited_prefetch? You only use it that often :)

>  } VFIOCCWDevice;
>  
>  static void vfio_ccw_compute_needs_reset(VFIODevice *vdev)
> @@ -52,8 +54,18 @@ static IOInstEnding vfio_ccw_handle_request(SubchDev *sch)
>      S390CCWDevice *cdev = sch->driver_data;
>      VFIOCCWDevice *vcdev = DO_UPCAST(VFIOCCWDevice, cdev, cdev);
>      struct ccw_io_region *region = vcdev->io_region;
> +    bool upfch = sch->orb.ctrl0 & ORB_CTRL0_MASK_PFCH;

Frankly, I'd drop that variable...

>      int ret;
>  
> +    if (!upfch && !vcdev->f_upfch) {
> +        warn_report("vfio-ccw requires PFCH flag set");
> +        sch_gen_unit_exception(sch);
> +        css_inject_io_interrupt(sch);
> +        return IOINST_CC_EXPECTED;
> +    } else if (!upfch) {
> +        sch->orb.ctrl0 |= ORB_CTRL0_MASK_PFCH;
> +    }

and do

if (!(sch->orb.ctrl0 & ORB_CTR0_MASK_PFCH)) {
  if (!vcdev->f_upfch) {
    ...error...
  } else {
    ...set bit...
  }
}

Avoids discussions around variable naming, as well :)

> +
>      QEMU_BUILD_BUG_ON(sizeof(region->orb_area) != sizeof(ORB));
>      QEMU_BUILD_BUG_ON(sizeof(region->scsw_area) != sizeof(SCSW));
>      QEMU_BUILD_BUG_ON(sizeof(region->irb_area) != sizeof(IRB));
> @@ -429,6 +441,7 @@ static void vfio_ccw_unrealize(DeviceState *dev, Error **errp)
>  
>  static Property vfio_ccw_properties[] = {
>      DEFINE_PROP_STRING("sysfsdev", VFIOCCWDevice, vdev.sysfsdev),
> +    DEFINE_PROP_BOOL("f-upfch", VFIOCCWDevice, f_upfch, false),

Any particular reason you want to control this on a device-by-device
level?

>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
