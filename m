Received: from eggs.gnu.org ([2001:4830:134:3::10]:35749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1duJ1i-0007cJ-LQ
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:57:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1duJ1e-0002wF-LI
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:57:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57392)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1duJ1e-0002vp-Cz
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:57:22 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8JDtuHP141012
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 09:57:21 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d30001eck-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 09:57:20 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Tue, 19 Sep 2017 14:57:18 +0100
References: <20170913115029.47626-1-pasic@linux.vnet.ibm.com>
	<20170913115029.47626-3-pasic@linux.vnet.ibm.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Tue, 19 Sep 2017 15:57:16 +0200
MIME-Version: 1.0
In-Reply-To: <20170913115029.47626-3-pasic@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <0a029ec8-ff4c-e56d-4ef1-750fc8c49e19@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/4] s390x/css: use ccw data stream
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

On 13/09/2017 13:50, Halil Pasic wrote:
> Replace direct access which implicitly assumes no IDA
> or MIDA with the new ccw data stream interface which should
> cope with these transparently in the future.
>=20
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
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
> +        sch->curr_status.scsw.count =3D ccw_dstream_residual_count(&sc=
h->cds);
>           ret =3D 0;
>           break;
>       }
>=20

Reviewed-by: Pierre Morel<pmorel@linux.vnet.ibm.com>

--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
