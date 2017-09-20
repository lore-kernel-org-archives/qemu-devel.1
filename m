Received: from eggs.gnu.org ([2001:4830:134:3::10]:52321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dua20-0000hQ-5a
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 04:06:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dua1u-0002DH-FC
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 04:06:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55860)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dua1u-0002BR-9Q
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 04:06:46 -0400
Date: Wed, 20 Sep 2017 10:06:40 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170920100640.79900c9f.cohuck@redhat.com>
In-Reply-To: <20170919182745.90280-5-pasic@linux.vnet.ibm.com>
References: <20170919182745.90280-1-pasic@linux.vnet.ibm.com>
	<20170919182745.90280-5-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 4/5] 390x/css: introduce maximum data
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
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Tue, 19 Sep 2017 20:27:44 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> The architecture mandates the addresses to be  accessed on the first
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
> index 6b0cd8861b..2d37a9ddde 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -795,6 +795,11 @@ static inline int cds_check_len(CcwDataStream *cds, int len)
>      return cds->flags & CDS_F_STREAM_BROKEN ? -EINVAL : len;
>  }
>  
> +static inline bool cds_ccw_addrs_ok(hwaddr addr, int len, bool ccw_fmt1)

cds_cda_limit_ok?

> +{
> +    return (addr + len) < (ccw_fmt1 ? (1UL << 31) : (1UL << 24));
> +}
> +
>  static int ccw_dstream_rw_noflags(CcwDataStream *cds, void *buff, int len,
>                                    CcwDataStreamOp op)
>  {

Looks good.
