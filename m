Received: from eggs.gnu.org ([2001:4830:134:3::10]:54024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fLQCs-0001uo-Ju
	for qemu-devel@nongnu.org; Wed, 23 May 2018 05:37:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fLQCn-0006v9-Ld
	for qemu-devel@nongnu.org; Wed, 23 May 2018 05:37:18 -0400
Date: Wed, 23 May 2018 11:37:08 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180523113708.50b21a77.cohuck@redhat.com>
In-Reply-To: <20180522221655.78979-2-pasic@linux.ibm.com>
References: <20180522221655.78979-1-pasic@linux.ibm.com>
	<20180522221655.78979-2-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] vfio-ccw: add force unlimited
 prefetch property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.ibm.com>, "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On Wed, 23 May 2018 00:16:54 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> There is at least one guest (OS) such that although it does not rely on
> the guarantees provided by ORB 1 word 9 bit (aka unlimited prefetch, aka
> P bit) not being set, it fails to tell this to the machine.
> 
> Usually this ain't a big deal, as the original purpose of the P bit is to
> allow for performance optimizations. vfio-ccw however can not provide the
> guarantees required if the bit is not set.
> 
> It is impossible to implement support for P bit not set (at impossible
> least without transitioning to lower level protocols) for vfio-ccw. 

"It is not possible to implement support for the P bit not set without
transitioning to lower level protocols for vfio-ccw."

?

> So
> let's give the user the opportunity to force the P bit to set, if the

s/to set/to be set/

> user knows this is safe.  For self modifying channel programs forcing the
> P bit is not safe. If P bit is forced for a self modifying channel

s/P bit/the P bit/

> program things are expected to break in strange ways.
> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> Suggested-by: Dong Jia Shi <bjsdjshi@linux.ibm.com>
> Acked-by: Jason J. Herne <jjherne@linux.ibm.com>
> Tested-by: Jason J. Herne <jjherne@linux.ibm.com>
> 
> ---
> v1 -> v2:
> * reworded commit message
> * re-factored the code (Connie)
> * added warning when the P bit is forced the first time (Connie)
> 
> ---
>  hw/s390x/css.c |  3 +--
>  hw/vfio/ccw.c  | 25 +++++++++++++++++++++++++
>  2 files changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index 56c3fa8c89..39ae5bbf7e 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -1204,8 +1204,7 @@ static IOInstEnding sch_handle_start_func_passthrough(SubchDev *sch)
>       * Only support prefetch enable mode.
>       * Only support 64bit addressing idal.
>       */
> -    if (!(orb->ctrl0 & ORB_CTRL0_MASK_PFCH) ||
> -        !(orb->ctrl0 & ORB_CTRL0_MASK_C64)) {
> +    if (!(orb->ctrl0 & ORB_CTRL0_MASK_C64)) {
>          warn_report("vfio-ccw requires PFCH and C64 flags set");
>          sch_gen_unit_exception(sch);
>          css_inject_io_interrupt(sch);
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index e67392c5f9..62de4c9710 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -32,8 +32,20 @@ typedef struct VFIOCCWDevice {
>      uint64_t io_region_offset;
>      struct ccw_io_region *io_region;
>      EventNotifier io_notifier;
> +    bool force_orb_pfch;
> +    bool warned_force_orb_pfch;
>  } VFIOCCWDevice;
>  
> +#define WARN_ONCE(warned, fmt...) \
> +({\
> +if (!(warned)) {\
> +    warn_report((fmt));\
> +} \
> +warned = true;\
> +})

I think introducing a macro for the single user is overkill here.

We might contemplate a generic "print this error once, controlled by
this flag" functionality, if there are more users.

> +
> +
> +
>  static void vfio_ccw_compute_needs_reset(VFIODevice *vdev)
>  {
>      vdev->needs_reset = false;
> @@ -54,6 +66,18 @@ static IOInstEnding vfio_ccw_handle_request(SubchDev *sch)
>      struct ccw_io_region *region = vcdev->io_region;
>      int ret;
>  
> +    if (!(sch->orb.ctrl0 & ORB_CTRL0_MASK_PFCH)) {
> +        if (!(vcdev->force_orb_pfch)) {
> +            warn_report("vfio-ccw requires PFCH flag set");
> +            sch_gen_unit_exception(sch);
> +            css_inject_io_interrupt(sch);
> +            return IOINST_CC_EXPECTED;
> +        } else {
> +            sch->orb.ctrl0 |= ORB_CTRL0_MASK_PFCH;
> +            WARN_ONCE(vcdev->warned_force_orb_pfch, "PFCH flag forced");

This message should probably mention vfio-ccw as well as the subchannel
id?

> +        }
> +    }
> +
>      QEMU_BUILD_BUG_ON(sizeof(region->orb_area) != sizeof(ORB));
>      QEMU_BUILD_BUG_ON(sizeof(region->scsw_area) != sizeof(SCSW));
>      QEMU_BUILD_BUG_ON(sizeof(region->irb_area) != sizeof(IRB));
> @@ -429,6 +453,7 @@ static void vfio_ccw_unrealize(DeviceState *dev, Error **errp)
>  
>  static Property vfio_ccw_properties[] = {
>      DEFINE_PROP_STRING("sysfsdev", VFIOCCWDevice, vdev.sysfsdev),
> +    DEFINE_PROP_BOOL("force-orb-pfch", VFIOCCWDevice, force_orb_pfch, false),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  

Otherwise, the changes look good.
