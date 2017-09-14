Received: from eggs.gnu.org ([2001:4830:134:3::10]:33128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dsQ8M-0004J3-MA
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 05:08:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dsQ8H-00019F-Jr
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 05:08:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dsQ8H-00017t-Al
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 05:08:25 -0400
Date: Thu, 14 Sep 2017 11:08:20 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170914110820.0de92331.cohuck@redhat.com>
In-Reply-To: <20170913115029.47626-2-pasic@linux.vnet.ibm.com>
References: <20170913115029.47626-1-pasic@linux.vnet.ibm.com>
	<20170913115029.47626-2-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/4] s390x/css: introduce css data stream
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

On Wed, 13 Sep 2017 13:50:26 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> This is a preparation for introducing handling for indirect data
> addressing and modified indirect data addressing (CCW). Here we introduce
> an interface which should make the addressing scheme transparent for the
> client code. Here we implement only the basic scheme (no IDA or MIDA).
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
>  hw/s390x/css.c         | 55 +++++++++++++++++++++++++++++++++++++++++
>  include/hw/s390x/css.h | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 122 insertions(+)
> 

> +void ccw_dstream_init(CcwDataStream *cds, CCW1 const *ccw, ORB const *orb)
> +{
> +    /*
> +     * We don't support MIDA (an optional facility) yet and we
> +     * catch this earlier. Just for expressing the precondition.
> +     */
> +    g_assert(!(orb->ctrl1 & ORB_CTRL1_MASK_MIDAW));
> +    cds->flags = (orb->ctrl0 & ORB_CTRL0_MASK_I2K ? CDS_F_I2K : 0) |
> +                 (orb->ctrl0 & ORB_CTRL0_MASK_C64 ? CDS_F_C64 : 0) |
> +                 (ccw->flags & CCW_FLAG_IDA ? CDS_F_IDA : 0);
> +    cds->count = ccw->count;
> +    cds->cda_orig = ccw->cda;
> +    ccw_dstream_rewind(cds);
> +    if (!(cds->flags & CDS_F_IDA)) {
> +        cds->op_handler = ccw_dstream_rw_noflags;
> +    } else {
> +        assert(false);

g_assert_not_reached() might have been better; but as this is removed
anyway in patch 4, it does not matter.

> +    }
> +}
>  
>  static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
>                               bool suspend_allowed)
> diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
> index 0653d3c9be..79acaf99b7 100644
> --- a/include/hw/s390x/css.h
> +++ b/include/hw/s390x/css.h
> @@ -75,6 +75,29 @@ typedef struct CMBE {
>      uint32_t reserved[7];
>  } QEMU_PACKED CMBE;
>  
> +typedef enum CcwDataStreamOp {
> +    CDS_OP_R = 0,
> +    CDS_OP_W = 1,
> +    CDS_OP_A = 2
> +} CcwDataStreamOp;
> +
> +/** normal usage is via SuchchDev.cds instead of instantiating */

/* instead of /**? Can change while applying.

> +typedef struct CcwDataStream {
> +#define CDS_F_IDA   0x01
> +#define CDS_F_MIDA  0x02
> +#define CDS_F_I2K   0x04
> +#define CDS_F_C64   0x08
> +#define CDS_F_STREAM_BROKEN  0x80
> +    uint8_t flags;
> +    uint8_t at_idaw;
> +    uint16_t at_byte;
> +    uint16_t count;
> +    uint32_t cda_orig;
> +    int (*op_handler)(struct CcwDataStream *cds, void *buff, int len,
> +                      CcwDataStreamOp op);
> +    hwaddr cda;
> +} CcwDataStream;
> +
>  typedef struct SubchDev SubchDev;
>  struct SubchDev {
>      /* channel-subsystem related things: */
