Received: from eggs.gnu.org ([2001:4830:134:3::10]:34808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1e280A-0004D9-MJ
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 23:48:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1e2807-00077q-B2
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 23:48:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33928)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1e2807-00077a-28
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 23:48:07 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9B3hkPQ004081
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 23:48:02 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dh7ck2a6k-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 23:48:02 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Tue, 10 Oct 2017 21:48:01 -0600
Date: Wed, 11 Oct 2017 11:47:56 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20171004154144.88995-1-pasic@linux.vnet.ibm.com>
	<20171004154144.88995-4-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171004154144.88995-4-pasic@linux.vnet.ibm.com>
Message-Id: <20171011034756.GC4754@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/8] s390x: improve error handling for
 SSCH and RSCH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

* Halil Pasic <pasic@linux.vnet.ibm.com> [2017-10-04 17:41:39 +0200]:

> Simplify the error handling of the SSCH and RSCH handler avoiding
> arbitrary and cryptic error codes being used to tell how the instruction
> is supposed to end.  Let the code detecting the condition tell how it's
> to be handled in a less ambiguous way.  It's best to handle SSCH and RSCH
> in one go as the emulation of the two shares a lot of code.
> 
> For passthrough this change isn't pure refactoring, but changes the
> way kernel reported EFAULT is handled. After clarifying the kernel
> interface we decided that EFAULT shall be mapped to unit exception.
> Same goes for unexpected error codes.
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
> 
> AFAIR we decided in the previous round to rather do transformation
> and fixing in one patch than touch stuff twice. Hence this patch
> ain't pure transformation any more.
> ---
>  hw/s390x/css.c              | 83 +++++++++++++--------------------------------
>  hw/s390x/s390-ccw.c         | 11 +++---
>  hw/vfio/ccw.c               | 30 ++++++++++++----
>  include/hw/s390x/css.h      | 24 +++++++++----
>  include/hw/s390x/s390-ccw.h |  2 +-
>  target/s390x/ioinst.c       | 53 ++++-------------------------
>  6 files changed, 77 insertions(+), 126 deletions(-)
> 
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index 4f47dbc8b0..b2978c3bae 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -1003,12 +1003,11 @@ static void sch_handle_start_func_virtual(SubchDev *sch)
> 
>  }
> 
> -static int sch_handle_start_func_passthrough(SubchDev *sch)
> +static IOInstEnding sch_handle_start_func_passthrough(SubchDev *sch)
>  {
> 
>      PMCW *p = &sch->curr_status.pmcw;
>      SCSW *s = &sch->curr_status.scsw;
> -    int ret;
> 
>      ORB *orb = &sch->orb;
>      if (!(s->ctrl & SCSW_ACTL_SUSP)) {
> @@ -1022,31 +1021,11 @@ static int sch_handle_start_func_passthrough(SubchDev *sch)
>       */
>      if (!(orb->ctrl0 & ORB_CTRL0_MASK_PFCH) ||
>          !(orb->ctrl0 & ORB_CTRL0_MASK_C64)) {
> -        return -EINVAL;
> +        sch_gen_unit_exception(sch);
> +        css_inject_io_interrupt(sch);
> +        return (IOInstEnding){.cc = 0};
This behavior change is not mentioned in the commit message. Right?

[...]

> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index a8baadf57a..dbb5b201de 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -23,6 +23,7 @@
>  #include "hw/s390x/s390-ccw.h"
>  #include "hw/s390x/ccw-device.h"
>  #include "qemu/error-report.h"
> +#include "cpu.h"
We need this because?

> 
>  #define TYPE_VFIO_CCW "vfio-ccw"
>  typedef struct VFIOCCWDevice {
> @@ -47,9 +48,9 @@ struct VFIODeviceOps vfio_ccw_ops = {
>      .vfio_compute_needs_reset = vfio_ccw_compute_needs_reset,
>  };
> 
> -static int vfio_ccw_handle_request(ORB *orb, SCSW *scsw, void *data)
> +static IOInstEnding vfio_ccw_handle_request(SubchDev *sch)
>  {
> -    S390CCWDevice *cdev = data;
> +    S390CCWDevice *cdev = sch->driver_data;
>      VFIOCCWDevice *vcdev = DO_UPCAST(VFIOCCWDevice, cdev, cdev);
>      struct ccw_io_region *region = vcdev->io_region;
>      int ret;
> @@ -60,8 +61,8 @@ static int vfio_ccw_handle_request(ORB *orb, SCSW *scsw, void *data)
> 
>      memset(region, 0, sizeof(*region));
> 
> -    memcpy(region->orb_area, orb, sizeof(ORB));
> -    memcpy(region->scsw_area, scsw, sizeof(SCSW));
> +    memcpy(region->orb_area, &sch->orb, sizeof(ORB));
> +    memcpy(region->scsw_area, &sch->curr_status.scsw, sizeof(SCSW));
> 
>  again:
>      ret = pwrite(vcdev->vdev.fd, region,
> @@ -71,10 +72,25 @@ again:
>              goto again;
>          }
>          error_report("vfio-ccw: wirte I/O region failed with errno=%d", errno);
> -        return -errno;
> +        ret = -errno;
> +    } else {
> +        ret = region->ret_code;
> +    }
> +    switch (-ret) {
> +    /* Currently we don't update control block and just return the cc code. */
This is not true anymore? At least for the EFAULT case.

> +    case 0:
> +        return (IOInstEnding){.cc = 0};
> +    case EBUSY:
> +        return (IOInstEnding){.cc = 2};
> +    case ENODEV:
> +    case EACCES:
> +        return (IOInstEnding){.cc = 3};
> +    case EFAULT:
> +    default:
> +        sch_gen_unit_exception(sch);
> +        css_inject_io_interrupt(sch);
> +        return (IOInstEnding){.cc = 0};
>      }
> -
> -    return region->ret_code;
>  }
> 
>  static void vfio_ccw_reset(DeviceState *dev)
> diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
> index 66916b6546..2116c6b3c7 100644
> --- a/include/hw/s390x/css.h
> +++ b/include/hw/s390x/css.h
[...]

> @@ -197,13 +208,14 @@ SubchDev *css_find_subch(uint8_t m, uint8_t cssid, uint8_t ssid,
>                           uint16_t schid);
>  bool css_subch_visible(SubchDev *sch);
>  void css_conditional_io_interrupt(SubchDev *sch);
> +
Extra change.

>  int css_do_stsch(SubchDev *sch, SCHIB *schib);
>  bool css_schid_final(int m, uint8_t cssid, uint8_t ssid, uint16_t schid);
>  int css_do_msch(SubchDev *sch, const SCHIB *schib);
[...]

-- 
Dong Jia Shi
