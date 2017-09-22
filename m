Received: from eggs.gnu.org ([2001:4830:134:3::10]:57816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1dvNBJ-0003AK-Mq
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:35:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1dvNBE-0007eN-Hj
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:35:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57718
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1dvNBE-0007ds-8M
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:35:40 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8MCXwaU060246
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 08:35:37 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2d50ac1kuq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 08:35:36 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Fri, 22 Sep 2017 13:35:35 +0100
References: <20170921180841.24490-1-pasic@linux.vnet.ibm.com>
	<20170921180841.24490-5-pasic@linux.vnet.ibm.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Fri, 22 Sep 2017 14:35:31 +0200
MIME-Version: 1.0
In-Reply-To: <20170921180841.24490-5-pasic@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <18fb9f1a-886f-f73b-4931-6186fdc8e3eb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 4/5] 390x/css: introduce maximum data
 address checking
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

On 21/09/2017 20:08, Halil Pasic wrote:
> The architecture mandates the addresses to be accessed on the first
> indirection level (that is, the data addresses without IDA, and the
> (M)IDAW addresses with (M)IDA) to be checked against an CCW format
> dependent limit maximum address.  If a violation is detected, the stora=
ge
> access is not to be performed and a channel program check needs to be
> generated. As of today, we fail to do this check.
>=20
> Let us stick even closer to the architecture specification.
>=20
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
>   hw/s390x/css.c         | 10 ++++++++++
>   include/hw/s390x/css.h |  1 +
>   2 files changed, 11 insertions(+)
>=20
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index e0d989829f..cd5580ebb8 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -795,6 +795,11 @@ static inline int cds_check_len(CcwDataStream *cds=
, int len)
>       return cds->flags & CDS_F_STREAM_BROKEN ? -EINVAL : len;
>   }
>=20
> +static inline bool cds_ccw_addrs_ok(hwaddr addr, int len, bool ccw_fmt=
1)
> +{
> +    return (addr + len) < (ccw_fmt1 ? (1UL << 31) : (1UL << 24));
> +}
> +
>   static int ccw_dstream_rw_noflags(CcwDataStream *cds, void *buff, int=
 len,
>                                     CcwDataStreamOp op)
>   {
> @@ -804,6 +809,9 @@ static int ccw_dstream_rw_noflags(CcwDataStream *cd=
s, void *buff, int len,
>       if (ret <=3D 0) {
>           return ret;
>       }
> +    if (!cds_ccw_addrs_ok(cds->cda, len, cds->flags & CDS_F_FMT)) {
> +        return -EINVAL; /* channel program check */
> +    }
>       if (op =3D=3D CDS_OP_A) {
>           goto incr;
>       }
> @@ -828,7 +836,9 @@ void ccw_dstream_init(CcwDataStream *cds, CCW1 cons=
t *ccw, ORB const *orb)
>       g_assert(!(orb->ctrl1 & ORB_CTRL1_MASK_MIDAW));
>       cds->flags =3D (orb->ctrl0 & ORB_CTRL0_MASK_I2K ? CDS_F_I2K : 0) =
|
>                    (orb->ctrl0 & ORB_CTRL0_MASK_C64 ? CDS_F_C64 : 0) |
> +                 (orb->ctrl0 & ORB_CTRL0_MASK_FMT ? CDS_F_FMT : 0) |
>                    (ccw->flags & CCW_FLAG_IDA ? CDS_F_IDA : 0);
> +
>       cds->count =3D ccw->count;
>       cds->cda_orig =3D ccw->cda;
>       ccw_dstream_rewind(cds);
> diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
> index 078356e94c..69b374730e 100644
> --- a/include/hw/s390x/css.h
> +++ b/include/hw/s390x/css.h
> @@ -87,6 +87,7 @@ typedef struct CcwDataStream {
>   #define CDS_F_MIDA  0x02
>   #define CDS_F_I2K   0x04
>   #define CDS_F_C64   0x08
> +#define CDS_F_FMT   0x10 /* CCW format-1 */
>   #define CDS_F_STREAM_BROKEN  0x80
>       uint8_t flags;
>       uint8_t at_idaw;
>=20

LGTM

Reviewed-by: Pierre Morel<pmorel@linux.vnet.ibm.com>

--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
