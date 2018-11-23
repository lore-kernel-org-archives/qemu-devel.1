Received: from eggs.gnu.org ([2001:4830:134:3::10]:34002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gQCCy-0002bK-3L
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:13:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gQCCu-000749-6C
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:13:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51890
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1gQCCu-00073T-0c
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 09:13:20 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wANEAdxE054457
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 09:13:19 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2nxh24npyj-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 09:13:18 -0500
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Fri, 23 Nov 2018 14:13:17 -0000
Reply-To: pmorel@linux.ibm.com
References: <20181122165457.4517-1-cohuck@redhat.com>
	<20181122165457.4517-3-cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Fri, 23 Nov 2018 15:13:12 +0100
MIME-Version: 1.0
In-Reply-To: <20181122165457.4517-3-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <8fbbe0b6-6924-ad61-1d94-26517765f346@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] vfio-ccw: support async command
 subregion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

On 22/11/2018 17:54, Cornelia Huck wrote:
> A vfio-ccw device may provide an async command subregion for
> issuing halt/clear subchannel requests. If it is present, use
> it for sending halt/clear request to the device; if not, fall
> back to emulation (as done today).
>=20
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   hw/s390x/css.c              |  27 +++++++--
>   hw/vfio/ccw.c               | 109 +++++++++++++++++++++++++++++++++++=
-
>   include/hw/s390x/s390-ccw.h |   3 +
>   3 files changed, 133 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index 04ec5cc970..0897c041c5 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -22,6 +22,7 @@
>   #include "trace.h"
>   #include "hw/s390x/s390_flic.h"
>   #include "hw/s390x/s390-virtio-ccw.h"
> +#include "hw/s390x/s390-ccw.h"
>  =20
>   typedef struct CrwContainer {
>       CRW crw;
> @@ -1194,6 +1195,26 @@ static void sch_handle_start_func_virtual(SubchD=
ev *sch)
>  =20
>   }
>  =20
> +static void sch_handle_halt_func_passthrough(SubchDev *sch)
> +{
> +    int ret;
> +
> +    ret =3D vfio_ccw_handle_halt(sch);
> +    if (ret =3D=3D -ENOSYS) {
> +        sch_handle_halt_func(sch);
> +    }
> +}
> +
> +static void sch_handle_clear_func_passthrough(SubchDev *sch)
> +{
> +    int ret;
> +
> +    ret =3D vfio_ccw_handle_clear(sch);
> +    if (ret =3D=3D -ENOSYS) {
> +        sch_handle_clear_func(sch);
> +    }
> +}
> +
>   static IOInstEnding sch_handle_start_func_passthrough(SubchDev *sch)
>   {
>  =20
> @@ -1237,11 +1258,9 @@ IOInstEnding do_subchannel_work_passthrough(Subc=
hDev *sch)
>       SCSW *s =3D &sch->curr_status.scsw;
>  =20
>       if (s->ctrl & SCSW_FCTL_CLEAR_FUNC) {
> -        /* TODO: Clear handling */
> -        sch_handle_clear_func(sch);
> +        sch_handle_clear_func_passthrough(sch);
>       } else if (s->ctrl & SCSW_FCTL_HALT_FUNC) {
> -        /* TODO: Halt handling */
> -        sch_handle_halt_func(sch);
> +        sch_handle_halt_func_passthrough(sch);
>       } else if (s->ctrl & SCSW_FCTL_START_FUNC) {
>           return sch_handle_start_func_passthrough(sch);
>       }
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 9246729a75..dd0fecf168 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -2,9 +2,12 @@
>    * vfio based subchannel assignment support
>    *
>    * Copyright 2017 IBM Corp.
> + * Copyright 2018 Red Hat, Inc.
> + *
>    * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
>    *            Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
>    *            Pierre Morel <pmorel@linux.vnet.ibm.com>
> + *            Cornelia Huck <cohuck@redhat.com>
>    *
>    * This work is licensed under the terms of the GNU GPL, version 2 or=
 (at
>    * your option) any later version. See the COPYING file in the top-le=
vel
> @@ -32,6 +35,9 @@ typedef struct VFIOCCWDevice {
>       uint64_t io_region_size;
>       uint64_t io_region_offset;
>       struct ccw_io_region *io_region;
> +    uint64_t async_cmd_region_size;
> +    uint64_t async_cmd_region_offset;
> +    struct ccw_cmd_region *async_cmd_region;
>       EventNotifier io_notifier;
>       bool force_orb_pfch;
>       bool warned_orb_pfch;
> @@ -114,6 +120,87 @@ again:
>       }
>   }
>  =20
> +int vfio_ccw_handle_clear(SubchDev *sch)
> +{
> +    S390CCWDevice *cdev =3D sch->driver_data;
> +    VFIOCCWDevice *vcdev =3D DO_UPCAST(VFIOCCWDevice, cdev, cdev);
> +    struct ccw_cmd_region *region =3D vcdev->async_cmd_region;
> +    int ret;
> +
> +    if (!vcdev->async_cmd_region) {
> +        /* Async command region not available, fall back to emulation =
*/
> +        return -ENOSYS;
> +    }
> +
> +    memset(region, 0, sizeof(*region));
> +    region->command =3D VFIO_CCW_ASYNC_CMD_CSCH;
> +
> +again:
> +    ret =3D pwrite(vcdev->vdev.fd, region,
> +                 vcdev->async_cmd_region_size, vcdev->async_cmd_region=
_offset);
> +    if (ret !=3D vcdev->async_cmd_region_size) {
> +        if (errno =3D=3D EAGAIN) {


Where do the EAGAIN come from?


> +            goto again;
> +        }
> +        error_report("vfio-ccw: wirte I/O region failed with errno=3D%=
d", errno);
> +        ret =3D -errno;
> +    } else {
> +        ret =3D region->ret_code;
> +    }
> +    switch (ret) {
> +    case 0:
> +    case -ENODEV:
> +    case -EACCES:

should never happen?

> +        return 0;
> +    case -EFAULT:
> +    default:
> +        sch_gen_unit_exception(sch);
> +        css_inject_io_interrupt(sch);
> +        return 0;
> +    }
> +}
> +

otherwise LGTM

--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
