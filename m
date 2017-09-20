Received: from eggs.gnu.org ([2001:4830:134:3::10]:57284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duexn-0007u3-Rg
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:24:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duewj-0007Lu-NX
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:22:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34682)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1duewi-0007K5-SN
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:21:45 -0400
Date: Wed, 20 Sep 2017 10:33:12 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170920103312.50b8b69b.cohuck@redhat.com>
In-Reply-To: <20170920074238.GH11080@bjsdjshi@linux.vnet.ibm.com>
References: <20170919182745.90280-1-pasic@linux.vnet.ibm.com>
	<20170919182745.90280-6-pasic@linux.vnet.ibm.com>
	<20170920074238.GH11080@bjsdjshi@linux.vnet.ibm.com>
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
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Wed, 20 Sep 2017 15:42:38 +0800
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> * Halil Pasic <pasic@linux.vnet.ibm.com> [2017-09-19 20:27:45 +0200]:
> 
> > Let's add indirect data addressing support for our virtual channel
> > subsystem. This implementation does not bother with any kind of
> > prefetching. We simply step through the IDAL on demand.
> > 
> > Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >  hw/s390x/css.c | 117 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 116 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> > index 2d37a9ddde..a3ce6d89b6 100644
> > --- a/hw/s390x/css.c
> > +++ b/hw/s390x/css.c
> > @@ -827,6 +827,121 @@ incr:
> >      return 0;
> >  }
> > 
> > +/* returns values between 1 and bsz, where bsz is a power of 2 */
> > +static inline uint16_t ida_continuous_left(hwaddr cda, uint64_t bsz)
> > +{
> > +    return bsz - (cda & (bsz - 1));
> > +}
> > +
> > +static inline uint64_t ccw_ida_block_size(uint8_t flags)
> > +{
> > +    if ((flags & CDS_F_C64) && !(flags & CDS_F_I2K)) {
> > +        return 1ULL << 12;
> > +    }
> > +    return 1ULL << 11;
> > +}
> > +
> > +static inline int ida_read_next_idaw(CcwDataStream *cds, bool ccw_fmt1,
> > +                                     bool idaw_fmt_2)
> > +{
> > +    union {uint64_t fmt2; uint32_t fmt1; } idaw;
> > +    int ret;
> > +    hwaddr idaw_addr;
> > +
> > +    if (idaw_fmt_2) {
> > +        idaw_addr = cds->cda_orig + sizeof(idaw.fmt2) * cds->at_idaw;
> > +        if (idaw_addr & 0x07 && cds_ccw_addrs_ok(idaw_addr, 0, ccw_fmt1)) {
> > +            return -EINVAL; /* channel program check */
> > +        }
> > +        ret = address_space_rw(&address_space_memory, idaw_addr,  
> Ahh, just got one question here:
> Do we need to considerate endianess for idaw_addr?

That is taken care of below.

And the previous version worked on my laptop via tcg ;)

> 
> > +                               MEMTXATTRS_UNSPECIFIED, (void *) &idaw.fmt2,
> > +                               sizeof(idaw.fmt2), false);
> > +        cds->cda = be64_to_cpu(idaw.fmt2);
> > +    } else {
> > +        idaw_addr = cds->cda_orig + sizeof(idaw.fmt1) * cds->at_idaw;
> > +        if (idaw_addr & 0x03 && cds_ccw_addrs_ok(idaw_addr, 0, ccw_fmt1)) {
> > +            return -EINVAL; /* channel program check */
> > +        }
> > +        ret = address_space_rw(&address_space_memory, idaw_addr,
> > +                               MEMTXATTRS_UNSPECIFIED, (void *) &idaw.fmt1,
> > +                               sizeof(idaw.fmt1), false);
> > +        cds->cda = be64_to_cpu(idaw.fmt1);  
> Still need to check bit 0x80000000 here I think.

Yes, I think this is 'must be zero' for format-1 idaws, and not covered
by the ccw-format specific checks above. (Although the PoP can be a bit
confusing with many similar terms...)

> 
> > +    }
> > +    ++(cds->at_idaw);
> > +    if (ret != MEMTX_OK) {
> > +        /* assume inaccessible address */
> > +        return -EINVAL; /* channel program check */
> > +  
> Extra line.
> 
> > +    }
> > +    return 0;
> > +}
> > +
> > +static int ccw_dstream_rw_ida(CcwDataStream *cds, void *buff, int len,
> > +                              CcwDataStreamOp op)
> > +{
> > +    uint64_t bsz = ccw_ida_block_size(cds->flags);
> > +    int ret = 0;
> > +    uint16_t cont_left, iter_len;
> > +    const bool idaw_fmt2 = cds->flags & CDS_F_C64;
> > +    bool ccw_fmt1 = cds->flags & CDS_F_FMT;  
> Use 'const bool' either? Although I doubt the value of using const here.
> ;)

Both being the same is still a good idea.

> 
> > +
> > +    ret = cds_check_len(cds, len);
> > +    if (ret <= 0) {
> > +        return ret;
> > +    }  
> 
> [...]
> 
