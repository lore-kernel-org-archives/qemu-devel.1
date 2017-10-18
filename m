Received: from eggs.gnu.org ([2001:4830:134:3::10]:57503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e4kgh-0003ws-Ln
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 05:30:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e4kgd-0005Ko-Io
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 05:30:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47304)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1e4kgd-0005K0-9t
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 05:30:51 -0400
References: <20171017140453.51099-1-pasic@linux.vnet.ibm.com>
	<20171017140453.51099-4-pasic@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0a29771b-da12-76eb-ead8-34d1a8d24ce7@redhat.com>
Date: Wed, 18 Oct 2017 11:30:47 +0200
MIME-Version: 1.0
In-Reply-To: <20171017140453.51099-4-pasic@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/7] s390x: improve error handling for
 SSCH and RSCH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On 17.10.2017 16:04, Halil Pasic wrote:
> Simplify the error handling of the SSCH and RSCH handler avoiding
> arbitrary and cryptic error codes being used to tell how the instructio=
n
> is supposed to end.  Let the code detecting the condition tell how it's
> to be handled in a less ambiguous way.  It's best to handle SSCH and RS=
CH
> in one go as the emulation of the two shares a lot of code.
>=20
> For passthrough this change isn't pure refactoring, but changes the way
> kernel reported EFAULT is handled. After clarifying the kernel interfac=
e
> we decided that EFAULT shall be mapped to unit exception.  Same goes fo=
r
> unexpected error codes and absence of required ORB flags.
>=20
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
>  hw/s390x/css.c              | 84 +++++++++++++------------------------=
--------
>  hw/s390x/s390-ccw.c         | 11 +++---
>  hw/vfio/ccw.c               | 28 +++++++++++----
>  include/hw/s390x/css.h      | 23 +++++++++----
>  include/hw/s390x/s390-ccw.h |  2 +-
>  target/s390x/ioinst.c       | 53 ++++------------------------
>  6 files changed, 75 insertions(+), 126 deletions(-)
>=20
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index aa233d5f8a..ff5a05c34b 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -1181,12 +1181,11 @@ static void sch_handle_start_func_virtual(Subch=
Dev *sch)
> =20
>  }
> =20
> -static int sch_handle_start_func_passthrough(SubchDev *sch)
> +static IOInstEnding sch_handle_start_func_passthrough(SubchDev *sch)
>  {
> =20
>      PMCW *p =3D &sch->curr_status.pmcw;
>      SCSW *s =3D &sch->curr_status.scsw;
> -    int ret;
> =20
>      ORB *orb =3D &sch->orb;
>      if (!(s->ctrl & SCSW_ACTL_SUSP)) {
> @@ -1200,31 +1199,12 @@ static int sch_handle_start_func_passthrough(Su=
bchDev *sch)
>       */
>      if (!(orb->ctrl0 & ORB_CTRL0_MASK_PFCH) ||
>          !(orb->ctrl0 & ORB_CTRL0_MASK_C64)) {
> -        return -EINVAL;
> +        warn_report("vfio-ccw requires PFCH and C64 flags set...");

Not sure, but should this maybe rather be a
"qemu_log_mask(LOG_GUEST_ERROR, ...)" instead?
Anyway, as Cornelia already mentioned it: Please drop the trailing dots.

> +        sch_gen_unit_exception(sch);
> +        css_inject_io_interrupt(sch);
> +        return IOINST_CC_EXPECTED;
>      }
[...]
> @@ -1844,27 +1816,23 @@ void css_do_schm(uint8_t mbk, int update, int d=
ct, uint64_t mbo)
>      }
>  }
> =20
> -int css_do_rsch(SubchDev *sch)
> +IOInstEnding css_do_rsch(SubchDev *sch)
>  {
>      SCSW *s =3D &sch->curr_status.scsw;
>      PMCW *p =3D &sch->curr_status.pmcw;
> -    int ret;
> =20
>      if (~(p->flags) & (PMCW_FLAGS_MASK_DNV | PMCW_FLAGS_MASK_ENA)) {
> -        ret =3D -ENODEV;
> -        goto out;
> +        return IOINST_CC_NOT_OPERATIONAL;
>      }
> =20
>      if (s->ctrl & SCSW_STCTL_STATUS_PEND) {
> -        ret =3D -EINPROGRESS;
> -        goto out;
> +        return IOINST_CC_STATUS_PRESENT;
>      }
> =20
>      if (((s->ctrl & SCSW_CTRL_MASK_FCTL) !=3D SCSW_FCTL_START_FUNC) ||
>          (s->ctrl & SCSW_ACTL_RESUME_PEND) ||
>          (!(s->ctrl & SCSW_ACTL_SUSP))) {
> -        ret =3D -EINVAL;
> -        goto out;
> +        return IOINST_CC_BUSY;

Why is EINVAL now mapped to IOINST_CC_BUSY? Shouldn't that be
IOINST_CC_STATUS_PRESENT instead?

>      }
[...]
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 76323c6bde..1cc2e5d873 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -47,9 +47,9 @@ struct VFIODeviceOps vfio_ccw_ops =3D {
>      .vfio_compute_needs_reset =3D vfio_ccw_compute_needs_reset,
>  };
> =20
> -static int vfio_ccw_handle_request(ORB *orb, SCSW *scsw, void *data)
> +static IOInstEnding vfio_ccw_handle_request(SubchDev *sch)
>  {
> -    S390CCWDevice *cdev =3D data;
> +    S390CCWDevice *cdev =3D sch->driver_data;
>      VFIOCCWDevice *vcdev =3D DO_UPCAST(VFIOCCWDevice, cdev, cdev);
>      struct ccw_io_region *region =3D vcdev->io_region;
>      int ret;
> @@ -60,8 +60,8 @@ static int vfio_ccw_handle_request(ORB *orb, SCSW *sc=
sw, void *data)
> =20
>      memset(region, 0, sizeof(*region));
> =20
> -    memcpy(region->orb_area, orb, sizeof(ORB));
> -    memcpy(region->scsw_area, scsw, sizeof(SCSW));
> +    memcpy(region->orb_area, &sch->orb, sizeof(ORB));
> +    memcpy(region->scsw_area, &sch->curr_status.scsw, sizeof(SCSW));
> =20
>  again:
>      ret =3D pwrite(vcdev->vdev.fd, region,
> @@ -71,10 +71,24 @@ again:
>              goto again;
>          }
>          error_report("vfio-ccw: wirte I/O region failed with errno=3D%=
d", errno);
> -        return -errno;
> +        ret =3D -errno;
> +    } else {
> +        ret =3D region->ret_code;
> +    }
> +    switch (-ret) {
> +    case 0:
> +        return IOINST_CC_EXPECTED;
> +    case EBUSY:
> +        return IOINST_CC_BUSY;
> +    case ENODEV:
> +    case EACCES:
> +        return IOINST_CC_NOT_OPERATIONAL;
> +    case EFAULT:
> +    default:
> +        sch_gen_unit_exception(sch);
> +        css_inject_io_interrupt(sch);
> +        return IOINST_CC_EXPECTED;

Do we feel really confident that it is OK to do the setcc() in case of
an exception here later? ... otherwise it might be necessery to
introduce something like IOINST_EXCEPTION to the enum to signal the
ioinst_handle_xxx() callers that they should not do the setcc() anymore..=
.

 Thomas
