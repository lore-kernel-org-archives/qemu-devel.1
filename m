Received: from eggs.gnu.org ([2001:4830:134:3::10]:34078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1duxyh-00028z-V6
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 05:41:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1duxyb-0007zl-Ug
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 05:41:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51410
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1duxyb-0007yr-NB
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 05:40:57 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8L9Ya2C145124
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 05:40:57 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2d4aemt5mg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 05:40:56 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Thu, 21 Sep 2017 10:40:53 +0100
References: <20170919182745.90280-1-pasic@linux.vnet.ibm.com>
	<20170919182745.90280-3-pasic@linux.vnet.ibm.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Thu, 21 Sep 2017 11:40:49 +0200
MIME-Version: 1.0
In-Reply-To: <20170919182745.90280-3-pasic@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <f5833eee-3896-1d5a-b7a5-6b3f5b1165d2@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/5] s390x/css: use ccw data stream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On 19/09/2017 20:27, Halil Pasic wrote:
> Replace direct access which implicitly assumes no IDA
> or MIDA with the new ccw data stream interface which should
> cope with these transparently in the future.
>=20
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> Reviewed-by: Pierre Morel<pmorel@linux.vnet.ibm.com>
> ---
>   hw/s390x/css.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index e8d2016563..6b0cd8861b 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -890,6 +890,7 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr =
ccw_addr,
>       }
>=20
>       /* Look at the command. */
> +    ccw_dstream_init(&sch->cds, &ccw, &(sch->orb));
>       switch (ccw.cmd_code) {
>       case CCW_CMD_NOOP:
>           /* Nothing to do. */
> @@ -903,8 +904,8 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr =
ccw_addr,
>               }
>           }
>           len =3D MIN(ccw.count, sizeof(sch->sense_data));
> -        cpu_physical_memory_write(ccw.cda, sch->sense_data, len);
> -        sch->curr_status.scsw.count =3D ccw.count - len;
> +        ccw_dstream_write_buf(&sch->cds, sch->sense_data, len);

Well, I oversaw this when I reviewed:
I think you should test the return value of ccw_dstream_write_buf here.

> +        sch->curr_status.scsw.count =3D ccw_dstream_residual_count(&sc=
h->cds);
>           memset(sch->sense_data, 0, sizeof(sch->sense_data));
>           ret =3D 0;
>           break;
> @@ -930,8 +931,8 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr =
ccw_addr,
>           } else {
>               sense_id.reserved =3D 0;
>           }
> -        cpu_physical_memory_write(ccw.cda, &sense_id, len);
> -        sch->curr_status.scsw.count =3D ccw.count - len;
> +        ccw_dstream_write_buf(&sch->cds, &sense_id, len);

and here

> +        sch->curr_status.scsw.count =3D ccw_dstream_residual_count(&sc=
h->cds);
>           ret =3D 0;
>           break;
>       }
>=20


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
