Received: from eggs.gnu.org ([2001:4830:134:3::10]:57748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dua77-0002OL-2Y
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 04:12:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dua74-0001b7-BI
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 04:12:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43428)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dua74-0001Xo-27
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 04:12:06 -0400
Date: Wed, 20 Sep 2017 10:11:59 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170920101159.0aaff3d6.cohuck@redhat.com>
In-Reply-To: <20170919182745.90280-6-pasic@linux.vnet.ibm.com>
References: <20170919182745.90280-1-pasic@linux.vnet.ibm.com>
	<20170919182745.90280-6-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 5/5] s390x/css: support ccw IDA
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

On Tue, 19 Sep 2017 20:27:45 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> Let's add indirect data addressing support for our virtual channel
> subsystem. This implementation does not bother with any kind of
> prefetching. We simply step through the IDAL on demand.
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

My s-o-b is a bit preliminary ;)

> ---
>  hw/s390x/css.c | 117 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 116 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index 2d37a9ddde..a3ce6d89b6 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -827,6 +827,121 @@ incr:
>      return 0;
>  }
>  
> +/* returns values between 1 and bsz, where bsz is a power of 2 */
> +static inline uint16_t ida_continuous_left(hwaddr cda, uint64_t bsz)
> +{
> +    return bsz - (cda & (bsz - 1));
> +}
> +
> +static inline uint64_t ccw_ida_block_size(uint8_t flags)
> +{
> +    if ((flags & CDS_F_C64) && !(flags & CDS_F_I2K)) {
> +        return 1ULL << 12;
> +    }
> +    return 1ULL << 11;
> +}
> +
> +static inline int ida_read_next_idaw(CcwDataStream *cds, bool ccw_fmt1,
> +                                     bool idaw_fmt_2)
> +{
> +    union {uint64_t fmt2; uint32_t fmt1; } idaw;
> +    int ret;
> +    hwaddr idaw_addr;
> +
> +    if (idaw_fmt_2) {
> +        idaw_addr = cds->cda_orig + sizeof(idaw.fmt2) * cds->at_idaw;
> +        if (idaw_addr & 0x07 && cds_ccw_addrs_ok(idaw_addr, 0, ccw_fmt1)) {

So, what is supposed to happen if the idaw_addr is not aligned
correctly _and_ is violating the limits?

> +            return -EINVAL; /* channel program check */
> +        }
> +        ret = address_space_rw(&address_space_memory, idaw_addr,
> +                               MEMTXATTRS_UNSPECIFIED, (void *) &idaw.fmt2,
> +                               sizeof(idaw.fmt2), false);
> +        cds->cda = be64_to_cpu(idaw.fmt2);
> +    } else {
> +        idaw_addr = cds->cda_orig + sizeof(idaw.fmt1) * cds->at_idaw;
> +        if (idaw_addr & 0x03 && cds_ccw_addrs_ok(idaw_addr, 0, ccw_fmt1)) {
> +            return -EINVAL; /* channel program check */
> +        }
> +        ret = address_space_rw(&address_space_memory, idaw_addr,
> +                               MEMTXATTRS_UNSPECIFIED, (void *) &idaw.fmt1,
> +                               sizeof(idaw.fmt1), false);
> +        cds->cda = be64_to_cpu(idaw.fmt1);
> +    }
> +    ++(cds->at_idaw);
> +    if (ret != MEMTX_OK) {
> +        /* assume inaccessible address */
> +        return -EINVAL; /* channel program check */
> +
> +    }
> +    return 0;
> +}
