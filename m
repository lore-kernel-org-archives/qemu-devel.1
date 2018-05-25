Received: from eggs.gnu.org ([2001:4830:134:3::10]:54410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fM9DE-00051w-Fx
	for qemu-devel@nongnu.org; Fri, 25 May 2018 05:40:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fM9DB-0002lP-82
	for qemu-devel@nongnu.org; Fri, 25 May 2018 05:40:40 -0400
Date: Fri, 25 May 2018 11:40:33 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180525114033.3c514091.cohuck@redhat.com>
In-Reply-To: <20180524175828.3143-2-pasic@linux.ibm.com>
References: <20180524175828.3143-1-pasic@linux.ibm.com>
	<20180524175828.3143-2-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/2] vfio-ccw: add force unlimited
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

On Thu, 24 May 2018 19:58:27 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> There is at least one guest (OS) such that although it does not rely on
> the guarantees provided by ORB 1 word 9 bit (aka unlimited prefetch, aka
> P bit) not being set, it fails to tell this to the machine.
> 
> Usually this ain't a big deal, as the original purpose of the P bit is to
> allow for performance optimizations. vfio-ccw however can not provide the
> guarantees required if the bit is not set.
> 
> It is not possible to implement support for the P bit not set without
> transitioning to lower level protocols for vfio-ccw.  So let's give the
> user the opportunity to force setting the P bit, if the user knows this
> is safe.  For self modifying channel programs forcing the P bit is not
> safe.  If the P bit is forced for a self modifying channel program things
> are expected to break in strange ways.
> 
> Let's also avoid warning multiple about P bit not set in the ORB in case
> P bit is not told to be forced, and designate the affected vfio-ccw
> device.
> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> Suggested-by: Dong Jia Shi <bjsdjshi@linux.ibm.com>
> Acked-by: Jason J. Herne <jjherne@linux.ibm.com>
> Tested-by: Jason J. Herne <jjherne@linux.ibm.com>

> +static inline void warn_once(bool *warned, const char *fmt, ...)
> +{
> +    va_list ap;
> +
> +    if (!warned || *warned) {
> +        return;
> +    }
> +    *warned = true;
> +    va_start(ap, fmt);
> +    warn_vreport(fmt, ap);
> +    va_end(ap);
> +}
> +
> +static inline void warn_once_pfch(VFIOCCWDevice *vcdev, SubchDev *sch,
> +                                  const char *msg)
> +{
> +    warn_once(&vcdev->warned_orb_pfch, "vfio-ccw (devno %x.%x.%04x): %s",
> +              sch->cssid, sch->ssid, sch->devno, msg);
> +}
> +

While I still think we want warn_once() in common error handling code,
this looks reasonable enough. We can still move it later.

>  static void vfio_ccw_compute_needs_reset(VFIODevice *vdev)
>  {
>      vdev->needs_reset = false;
> @@ -54,6 +76,18 @@ static IOInstEnding vfio_ccw_handle_request(SubchDev *sch)
>      struct ccw_io_region *region = vcdev->io_region;
>      int ret;
>  
> +    if (!(sch->orb.ctrl0 & ORB_CTRL0_MASK_PFCH)) {
> +        if (!(vcdev->force_orb_pfch)) {
> +            warn_once_pfch(vcdev, sch, "requires PFCH flag set");
> +            sch_gen_unit_exception(sch);
> +            css_inject_io_interrupt(sch);
> +            return IOINST_CC_EXPECTED;
> +        } else {
> +            sch->orb.ctrl0 |= ORB_CTRL0_MASK_PFCH;
> +            warn_once_pfch(vcdev, sch, "PFCH flag forced");
> +        }
> +    }
> +

Looks good to me. I plan to queue this (and the other patch) to
s390-next, but (as always) further tags are still welcome :)
