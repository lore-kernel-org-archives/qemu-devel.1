Received: from eggs.gnu.org ([2001:4830:134:3::10]:48617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dwJiY-0004UY-J5
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 23:05:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dwJiV-0002hG-Dc
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 23:05:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49006
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1dwJiV-0002f7-7n
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 23:05:55 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8P345rw033775
	for <qemu-devel@nongnu.org>; Sun, 24 Sep 2017 23:05:51 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2d6bk7v9f9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 24 Sep 2017 23:05:51 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Sun, 24 Sep 2017 23:05:50 -0400
Date: Mon, 25 Sep 2017 11:05:44 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170921180841.24490-1-pasic@linux.vnet.ibm.com>
	<20170921180841.24490-5-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170921180841.24490-5-pasic@linux.vnet.ibm.com>
Message-Id: <20170925030544.GO11080@bjsdjshi@linux.vnet.ibm.com>
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
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

* Halil Pasic <pasic@linux.vnet.ibm.com> [2017-09-21 20:08:40 +0200]:

> The architecture mandates the addresses to be accessed on the first
> indirection level (that is, the data addresses without IDA, and the
> (M)IDAW addresses with (M)IDA) to be checked against an CCW format
> dependent limit maximum address.  If a violation is detected, the storage
> access is not to be performed and a channel program check needs to be
> generated. As of today, we fail to do this check.
> 
> Let us stick even closer to the architecture specification.
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
>  hw/s390x/css.c         | 10 ++++++++++
>  include/hw/s390x/css.h |  1 +
>  2 files changed, 11 insertions(+)
> 
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index e0d989829f..cd5580ebb8 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -795,6 +795,11 @@ static inline int cds_check_len(CcwDataStream *cds, int len)
>      return cds->flags & CDS_F_STREAM_BROKEN ? -EINVAL : len;
>  }
> 
> +static inline bool cds_ccw_addrs_ok(hwaddr addr, int len, bool ccw_fmt1)
> +{
> +    return (addr + len) < (ccw_fmt1 ? (1UL << 31) : (1UL << 24));
> +}
> +
>  static int ccw_dstream_rw_noflags(CcwDataStream *cds, void *buff, int len,
>                                    CcwDataStreamOp op)
>  {
> @@ -804,6 +809,9 @@ static int ccw_dstream_rw_noflags(CcwDataStream *cds, void *buff, int len,
>      if (ret <= 0) {
>          return ret;
>      }
> +    if (!cds_ccw_addrs_ok(cds->cda, len, cds->flags & CDS_F_FMT)) {
> +        return -EINVAL; /* channel program check */
> +    }
>      if (op == CDS_OP_A) {
>          goto incr;
>      }
> @@ -828,7 +836,9 @@ void ccw_dstream_init(CcwDataStream *cds, CCW1 const *ccw, ORB const *orb)
>      g_assert(!(orb->ctrl1 & ORB_CTRL1_MASK_MIDAW));
>      cds->flags = (orb->ctrl0 & ORB_CTRL0_MASK_I2K ? CDS_F_I2K : 0) |
>                   (orb->ctrl0 & ORB_CTRL0_MASK_C64 ? CDS_F_C64 : 0) |
> +                 (orb->ctrl0 & ORB_CTRL0_MASK_FMT ? CDS_F_FMT : 0) |
>                   (ccw->flags & CCW_FLAG_IDA ? CDS_F_IDA : 0);
> +
>      cds->count = ccw->count;
>      cds->cda_orig = ccw->cda;
>      ccw_dstream_rewind(cds);
> diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
> index 078356e94c..69b374730e 100644
> --- a/include/hw/s390x/css.h
> +++ b/include/hw/s390x/css.h
> @@ -87,6 +87,7 @@ typedef struct CcwDataStream {
>  #define CDS_F_MIDA  0x02
>  #define CDS_F_I2K   0x04
>  #define CDS_F_C64   0x08
> +#define CDS_F_FMT   0x10 /* CCW format-1 */
>  #define CDS_F_STREAM_BROKEN  0x80
>      uint8_t flags;
>      uint8_t at_idaw;
> -- 
> 2.13.5
> 

Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>

-- 
Dong Jia Shi
