Received: from eggs.gnu.org ([209.51.188.92]:57687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1hBKDR-0004Q4-12
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 10:16:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1hBKDP-0007k7-SR
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 10:16:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59612)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1hBKDP-0007eb-DQ
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 10:16:39 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x32EGGX5000693
	for <qemu-devel@nongnu.org>; Tue, 2 Apr 2019 10:16:37 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rm9bjr0mh-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 10:16:37 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Tue, 2 Apr 2019 15:16:35 +0100
References: <20190329111104.17223-1-berrange@redhat.com>
	<20190329111104.17223-12-berrange@redhat.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Tue, 2 Apr 2019 10:16:30 -0400
MIME-Version: 1.0
In-Reply-To: <20190329111104.17223-12-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <597baf23-80fb-b79b-e4f2-edd912a7e939@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 11/14] hw/vfio/ccw: avoid taking address
 members in packed structs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, Eric Farman <farman@linux.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, Alex Williamson <alex.williamson@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>



On 03/29/2019 07:11 AM, Daniel P. Berrang=C3=A9 wrote:
> The GCC 9 compiler complains about many places in s390 code
> that take the address of members of the 'struct SCHIB' which
> is marked packed:
>=20
> hw/vfio/ccw.c: In function =E2=80=98vfio_ccw_io_notifier_handler=E2=80=99=
:
> hw/vfio/ccw.c:133:15: warning: taking address of packed member of =E2=80=
=98struct SCHIB=E2=80=99 may result in an unaligned pointer value \
> [-Waddress-of-packed-member]
>    133 |     SCSW *s =3D &sch->curr_status.scsw;
>        |               ^~~~~~~~~~~~~~~~~~~~~~
> hw/vfio/ccw.c:134:15: warning: taking address of packed member of =E2=80=
=98struct SCHIB=E2=80=99 may result in an unaligned pointer value \
> [-Waddress-of-packed-member]
>    134 |     PMCW *p =3D &sch->curr_status.pmcw;
>        |               ^~~~~~~~~~~~~~~~~~~~~~
>=20
> ...snip many more...
>=20
> Almost all of these are just done for convenience to avoid
> typing out long variable/field names when referencing struct
> members. We can get most of this convenience by taking the
> address of the 'struct SCHIB' instead, avoiding triggering
> the compiler warnings.
>=20
> In a couple of places we copy via a local variable which is
> a technique already applied elsewhere in s390 code for this
> problem.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>   hw/vfio/ccw.c | 42 ++++++++++++++++++++++--------------------
>   1 file changed, 22 insertions(+), 20 deletions(-)
>=20
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 9246729a75..c44d13cc50 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -130,8 +130,8 @@ static void vfio_ccw_io_notifier_handler(void *opaq=
ue)
>       S390CCWDevice *cdev =3D S390_CCW_DEVICE(vcdev);
>       CcwDevice *ccw_dev =3D CCW_DEVICE(cdev);
>       SubchDev *sch =3D ccw_dev->sch;
> -    SCSW *s =3D &sch->curr_status.scsw;
> -    PMCW *p =3D &sch->curr_status.pmcw;
> +    SCHIB *schib =3D &sch->curr_status;
> +    SCSW s;
>       IRB irb;
>       int size;
>  =20
> @@ -145,33 +145,33 @@ static void vfio_ccw_io_notifier_handler(void *op=
aque)
>           switch (errno) {
>           case ENODEV:
>               /* Generate a deferred cc 3 condition. */
> -            s->flags |=3D SCSW_FLAGS_MASK_CC;
> -            s->ctrl &=3D ~SCSW_CTRL_MASK_STCTL;
> -            s->ctrl |=3D (SCSW_STCTL_ALERT | SCSW_STCTL_STATUS_PEND);
> +            schib->scsw.flags |=3D SCSW_FLAGS_MASK_CC;
> +            schib->scsw.ctrl &=3D ~SCSW_CTRL_MASK_STCTL;
> +            schib->scsw.ctrl |=3D (SCSW_STCTL_ALERT | SCSW_STCTL_STATU=
S_PEND);
>               goto read_err;
>           case EFAULT:
>               /* Memory problem, generate channel data check. */
> -            s->ctrl &=3D ~SCSW_ACTL_START_PEND;
> -            s->cstat =3D SCSW_CSTAT_DATA_CHECK;
> -            s->ctrl &=3D ~SCSW_CTRL_MASK_STCTL;
> -            s->ctrl |=3D SCSW_STCTL_PRIMARY | SCSW_STCTL_SECONDARY |
> +            schib->scsw.ctrl &=3D ~SCSW_ACTL_START_PEND;
> +            schib->scsw.cstat =3D SCSW_CSTAT_DATA_CHECK;
> +            schib->scsw.ctrl &=3D ~SCSW_CTRL_MASK_STCTL;
> +            schib->scsw.ctrl |=3D SCSW_STCTL_PRIMARY | SCSW_STCTL_SECO=
NDARY |
>                          SCSW_STCTL_ALERT | SCSW_STCTL_STATUS_PEND;
>               goto read_err;
>           default:
>               /* Error, generate channel program check. */
> -            s->ctrl &=3D ~SCSW_ACTL_START_PEND;
> -            s->cstat =3D SCSW_CSTAT_PROG_CHECK;
> -            s->ctrl &=3D ~SCSW_CTRL_MASK_STCTL;
> -            s->ctrl |=3D SCSW_STCTL_PRIMARY | SCSW_STCTL_SECONDARY |
> +            schib->scsw.ctrl &=3D ~SCSW_ACTL_START_PEND;
> +            schib->scsw.cstat =3D SCSW_CSTAT_PROG_CHECK;
> +            schib->scsw.ctrl &=3D ~SCSW_CTRL_MASK_STCTL;
> +            schib->scsw.ctrl |=3D SCSW_STCTL_PRIMARY | SCSW_STCTL_SECO=
NDARY |
>                          SCSW_STCTL_ALERT | SCSW_STCTL_STATUS_PEND;
>               goto read_err;
>           }
>       } else if (size !=3D vcdev->io_region_size) {
>           /* Information transfer error, generate channel-control check=
. */
> -        s->ctrl &=3D ~SCSW_ACTL_START_PEND;
> -        s->cstat =3D SCSW_CSTAT_CHN_CTRL_CHK;
> -        s->ctrl &=3D ~SCSW_CTRL_MASK_STCTL;
> -        s->ctrl |=3D SCSW_STCTL_PRIMARY | SCSW_STCTL_SECONDARY |
> +        schib->scsw.ctrl &=3D ~SCSW_ACTL_START_PEND;
> +        schib->scsw.cstat =3D SCSW_CSTAT_CHN_CTRL_CHK;
> +        schib->scsw.ctrl &=3D ~SCSW_CTRL_MASK_STCTL;
> +        schib->scsw.ctrl |=3D SCSW_STCTL_PRIMARY | SCSW_STCTL_SECONDAR=
Y |
>                      SCSW_STCTL_ALERT | SCSW_STCTL_STATUS_PEND;
>           goto read_err;
>       }
> @@ -179,11 +179,13 @@ static void vfio_ccw_io_notifier_handler(void *op=
aque)
>       memcpy(&irb, region->irb_area, sizeof(IRB));
>  =20
>       /* Update control block via irb. */
> -    copy_scsw_to_guest(s, &irb.scsw);
> +    s =3D schib->scsw;
> +    copy_scsw_to_guest(&s, &irb.scsw);
> +    schib->scsw =3D s;
>  =20
>       /* If a uint check is pending, copy sense data. */
> -    if ((s->dstat & SCSW_DSTAT_UNIT_CHECK) &&
> -        (p->chars & PMCW_CHARS_MASK_CSENSE)) {
> +    if ((schib->scsw.dstat & SCSW_DSTAT_UNIT_CHECK) &&
> +        (schib->pmcw.chars & PMCW_CHARS_MASK_CSENSE)) {
>           memcpy(sch->sense_data, irb.ecw, sizeof(irb.ecw));
>       }
>  =20
>=20

Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
