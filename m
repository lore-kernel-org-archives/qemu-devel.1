Received: from eggs.gnu.org ([209.51.188.92]:56359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1hBK8G-00012h-Ki
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 10:11:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1hBK8F-00052U-L2
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 10:11:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56444)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1hBK8F-0004yX-9i
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 10:11:19 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x32E5c0I010164
	for <qemu-devel@nongnu.org>; Tue, 2 Apr 2019 10:11:17 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rm92t923h-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 10:11:16 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Tue, 2 Apr 2019 15:11:14 +0100
References: <20190329111104.17223-1-berrange@redhat.com>
	<20190329111104.17223-14-berrange@redhat.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Tue, 2 Apr 2019 10:11:08 -0400
MIME-Version: 1.0
In-Reply-To: <20190329111104.17223-14-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <80307b7b-3ca2-d91f-3411-0825d02f1edd@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 13/14] hw/s390x/ipl: avoid taking address
 of fields in packed struct
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
> Compiling with GCC 9 complains
>=20
> hw/s390x/ipl.c: In function =E2=80=98s390_ipl_set_boot_menu=E2=80=99:
> hw/s390x/ipl.c:256:25: warning: taking address of packed member of =E2=80=
=98struct QemuIplParameters=E2=80=99 may result in an unaligned pointer v=
alue [-Waddress-of-packed-member]
>    256 |     uint32_t *timeout =3D &ipl->qipl.boot_menu_timeout;
>        |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> This local variable is only present to save a little bit of
> typing when setting the field later. Get rid of this to avoid
> the warning about unaligned accesses.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>   hw/s390x/ipl.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 896888bf8f..51b272e190 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -252,8 +252,6 @@ static void s390_ipl_set_boot_menu(S390IPLState *ip=
l)
>   {
>       QemuOptsList *plist =3D qemu_find_opts("boot-opts");
>       QemuOpts *opts =3D QTAILQ_FIRST(&plist->head);
> -    uint8_t *flags =3D &ipl->qipl.qipl_flags;
> -    uint32_t *timeout =3D &ipl->qipl.boot_menu_timeout;
>       const char *tmp;
>       unsigned long splash_time =3D 0;
>  =20
> @@ -269,7 +267,7 @@ static void s390_ipl_set_boot_menu(S390IPLState *ip=
l)
>       case S390_IPL_TYPE_CCW:
>           /* In the absence of -boot menu, use zipl parameters */
>           if (!qemu_opt_get(opts, "menu")) {
> -            *flags |=3D QIPL_FLAG_BM_OPTS_ZIPL;
> +            ipl->qipl.qipl_flags |=3D QIPL_FLAG_BM_OPTS_ZIPL;
>               return;
>           }
>           break;
> @@ -286,23 +284,23 @@ static void s390_ipl_set_boot_menu(S390IPLState *=
ipl)
>           return;
>       }
>  =20
> -    *flags |=3D QIPL_FLAG_BM_OPTS_CMD;
> +    ipl->qipl.qipl_flags |=3D QIPL_FLAG_BM_OPTS_CMD;
>  =20
>       tmp =3D qemu_opt_get(opts, "splash-time");
>  =20
>       if (tmp && qemu_strtoul(tmp, NULL, 10, &splash_time)) {
>           error_report("splash-time is invalid, forcing it to 0");
> -        *timeout =3D 0;
> +        ipl->qipl.boot_menu_timeout =3D 0;
>           return;
>       }
>  =20
>       if (splash_time > 0xffffffff) {
>           error_report("splash-time is too large, forcing it to max val=
ue");
> -        *timeout =3D 0xffffffff;
> +        ipl->qipl.boot_menu_timeout =3D 0xffffffff;
>           return;
>       }
>  =20
> -    *timeout =3D cpu_to_be32(splash_time);
> +    ipl->qipl.boot_menu_timeout =3D cpu_to_be32(splash_time);
>   }
>  =20
>   static CcwDevice *s390_get_ccw_device(DeviceState *dev_st)
>=20

Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
