Received: from eggs.gnu.org ([2001:4830:134:3::10]:59930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1duxr8-0007xE-QJ
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 05:33:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1duxr3-0003wV-T4
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 05:33:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52488
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1duxr3-0003uU-NV
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 05:33:09 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8L9UU9h133255
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 05:33:08 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2d4aemstnp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 05:33:08 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Thu, 21 Sep 2017 10:33:06 +0100
References: <20170905111645.18068-1-pasic@linux.vnet.ibm.com>
	<20170905111645.18068-3-pasic@linux.vnet.ibm.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Thu, 21 Sep 2017 11:33:03 +0200
MIME-Version: 1.0
In-Reply-To: <20170905111645.18068-3-pasic@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <2bb5705f-eba3-2630-2e57-99242b9abd2a@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/5] s390x/css: use ccw data stream
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

On 05/09/2017 13:16, Halil Pasic wrote:
> Replace direct access which implicitly assumes no IDA
> or MIDA with the new ccw data stream interface which should
> cope with these transparently in the future.
>=20
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
>   hw/s390x/css.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index 87d913f81c..c1bc9944e6 100644
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
> @@ -903,7 +904,7 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr =
ccw_addr,
>               }
>           }
>           len =3D MIN(ccw.count, sizeof(sch->sense_data));
> -        cpu_physical_memory_write(ccw.cda, sch->sense_data, len);
> +        ccw_dstream_write_buf(&sch->cds, sch->sense_data, len);

Don't you need to check the return value ?

>           sch->curr_status.scsw.count =3D ccw.count - len;
>           memset(sch->sense_data, 0, sizeof(sch->sense_data));
>           ret =3D 0;
> @@ -930,7 +931,7 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr =
ccw_addr,
>           } else {
>               sense_id.reserved =3D 0;
>           }
> -        cpu_physical_memory_write(ccw.cda, &sense_id, len);
> +        ccw_dstream_write_buf(&sch->cds, &sense_id, len);

here too ?

>           sch->curr_status.scsw.count =3D ccw.count - len;
>           ret =3D 0;
>           break;
>=20


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
