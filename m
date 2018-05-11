Received: from eggs.gnu.org ([2001:4830:134:3::10]:40927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1fH4kV-0005cy-JW
	for qemu-devel@nongnu.org; Fri, 11 May 2018 05:54:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1fH4kS-0001rK-HH
	for qemu-devel@nongnu.org; Fri, 11 May 2018 05:54:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49306
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1fH4kS-0001qm-Ch
	for qemu-devel@nongnu.org; Fri, 11 May 2018 05:54:00 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4B9oRTs028110
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 05:53:59 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2hw8c79e93-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 05:53:59 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Fri, 11 May 2018 10:53:57 +0100
Reply-To: pmorel@linux.ibm.com
References: <20180509154910.23578-1-cohuck@redhat.com>
	<20180509154910.23578-2-cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Fri, 11 May 2018 11:53:52 +0200
MIME-Version: 1.0
In-Reply-To: <20180509154910.23578-2-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <d2030a0c-6ab6-a470-f7d7-0926a7ff2b28@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 1/2] vfio-ccw: forward halt/clear to
 device if supported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On 09/05/2018 17:49, Cornelia Huck wrote:
> The initial version of vfio-ccw did not support forwarding of the
> halt or clear functions to the device, and we had to emulate them
> instead.
>
> For versions of the vfio-ccw kernel implementation that indeed do
> support halt/clear (by indicating them in the fctl of the scsw in
> the io_region), we can simply start making use of it. If the kernel
> does not support handling halt/clear, fall back to emulation.
>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   hw/s390x/css.c         | 32 ++++++++++++++++++++++++++++----
>   hw/vfio/ccw.c          | 11 +++++++++--
>   include/hw/s390x/css.h | 10 +++++++---
>   3 files changed, 44 insertions(+), 9 deletions(-)
>
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index 301bf1772f..b6727d0607 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -1180,6 +1180,16 @@ static void sch_handle_start_func_virtual(SubchD=
ev *sch)
>  =20
>   }
>  =20
> +static IOInstEnding sch_handle_clear_func_passthrough(SubchDev *sch)
> +{
> +    return s390_ccw_cmd_request(sch);
> +}
> +
> +static IOInstEnding sch_handle_halt_func_passthrough(SubchDev *sch)
> +{
> +    return s390_ccw_cmd_request(sch);
> +}
> +
>   static IOInstEnding sch_handle_start_func_passthrough(SubchDev *sch)
>   {
>  =20
> @@ -1233,13 +1243,27 @@ IOInstEnding do_subchannel_work_virtual(SubchDe=
v *sch)
>   IOInstEnding do_subchannel_work_passthrough(SubchDev *sch)
>   {
>       SCSW *s =3D &sch->curr_status.scsw;
> +    static bool no_halt_clear;
>  =20
> +    /* if the kernel does not support halt/clear, fall back to emulati=
on */
>       if (s->ctrl & SCSW_FCTL_CLEAR_FUNC) {
> -        /* TODO: Clear handling */
> -        sch_handle_clear_func(sch);
> +        if (no_halt_clear) {
> +            sch_handle_clear_func(sch);
> +        } else {
> +            if (sch_handle_clear_func_passthrough(sch) =3D=3D IOINST_O=
PNOTSUPP) {
> +                no_halt_clear =3D true;
> +                sch_handle_halt_func(sch);
> +            }
> +        }
>       } else if (s->ctrl & SCSW_FCTL_HALT_FUNC) {
> -        /* TODO: Halt handling */
> -        sch_handle_halt_func(sch);
> +        if (no_halt_clear) {
> +            sch_handle_halt_func(sch);
> +        } else {
> +            if (sch_handle_halt_func_passthrough(sch) =3D=3D IOINST_OP=
NOTSUPP) {
> +                no_halt_clear =3D true;
> +                sch_handle_halt_func(sch);
> +            }
> +        }
>       } else if (s->ctrl & SCSW_FCTL_START_FUNC) {
>           return sch_handle_start_func_passthrough(sch);
>       }
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index e67392c5f9..247901ae41 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -60,6 +60,7 @@ static IOInstEnding vfio_ccw_handle_request(SubchDev =
*sch)
>  =20
>       memset(region, 0, sizeof(*region));
>  =20
> +    /* orb is only valid for ssch, but does not hurt for other functio=
ns */
>       memcpy(region->orb_area, &sch->orb, sizeof(ORB));
>       memcpy(region->scsw_area, &sch->curr_status.scsw, sizeof(SCSW));
>  =20
> @@ -70,8 +71,12 @@ again:
>           if (errno =3D=3D EAGAIN) {
>               goto again;
>           }
> -        error_report("vfio-ccw: wirte I/O region failed with errno=3D%=
d", errno);
> -        ret =3D -errno;
> +        /* handle not supported operations like halt/clear on older ke=
rnels */
> +        if (ret !=3D -EOPNOTSUPP) {
> +            error_report("vfio-ccw: write I/O region failed with errno=
=3D%d",
> +                         errno);
> +            ret =3D -errno;
> +        }
>       } else {
>           ret =3D region->ret_code;
>       }
> @@ -83,6 +88,8 @@ again:
>       case -ENODEV:
>       case -EACCES:
>           return IOINST_CC_NOT_OPERATIONAL;
> +    case -EOPNOTSUPP:
> +        return IOINST_OPNOTSUPP;
>       case -EFAULT:
>       default:
>           sch_gen_unit_exception(sch);
> diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
> index 35facb47d2..e33f26882b 100644
> --- a/include/hw/s390x/css.h
> +++ b/include/hw/s390x/css.h
> @@ -100,9 +100,11 @@ typedef struct CcwDataStream {
>   } CcwDataStream;
>  =20
>   /*
> - * IO instructions conclude according to this. Currently we have only
> - * cc codes. Valid values are 0, 1, 2, 3 and the generic semantic for
> + * IO instructions conclude according to this. One class of values are
> + * cc codes: Valid values are 0, 1, 2, 3 and the generic semantic for
>    * IO instructions is described briefly. For more details consult the=
 PoP.
> + * Additionally, other endings may occur due to internal processing er=
rors
> + * like lack of support for an operation.
>    */
>   typedef enum IOInstEnding {
>       /* produced expected result */
> @@ -112,7 +114,9 @@ typedef enum IOInstEnding {
>       /* inst. ineffective because busy with previously initiated funct=
ion */
>       IOINST_CC_BUSY =3D 2,
>       /* inst. ineffective because not operational */
> -    IOINST_CC_NOT_OPERATIONAL =3D 3
> +    IOINST_CC_NOT_OPERATIONAL =3D 3,
> +    /* internal: operation not supported */
> +    IOINST_OPNOTSUPP =3D 4
>   } IOInstEnding;
>  =20
>   typedef struct SubchDev SubchDev;


Couldn't we introduce ABI versioning ?


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
