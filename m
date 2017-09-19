Received: from eggs.gnu.org ([2001:4830:134:3::10]:33912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duGDX-0001jD-G8
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:57:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duGDS-0005lH-Kx
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:57:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49304)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1duGDS-0005kn-CZ
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:57:22 -0400
Date: Tue, 19 Sep 2017 12:57:17 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170919125717.1ae0cd38.cohuck@redhat.com>
In-Reply-To: <fbb3522e-4086-359a-fca7-05371b76dac7@linux.vnet.ibm.com>
References: <20170913115029.47626-1-pasic@linux.vnet.ibm.com>
	<20170913115029.47626-5-pasic@linux.vnet.ibm.com>
	<20170919055005.GE5274@bjsdjshi@linux.vnet.ibm.com>
	<20170919114859.3e2d895b.cohuck@redhat.com>
	<fbb3522e-4086-359a-fca7-05371b76dac7@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 4/4] s390x/css: support ccw IDA
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

On Tue, 19 Sep 2017 12:36:33 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> On 09/19/2017 11:48 AM, Cornelia Huck wrote:
> > On Tue, 19 Sep 2017 13:50:05 +0800
> > Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
> >   
> >> * Halil Pasic <pasic@linux.vnet.ibm.com> [2017-09-13 13:50:29 +0200]:
> >>  
> >>> Let's add indirect data addressing support for our virtual channel
> >>> subsystem. This implementation does no bother with any kind of
> >>> prefetching. We simply step trough the IDAL on demand.
> >>>
> >>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> >>> ---
> >>>  hw/s390x/css.c | 109 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> >>>  1 file changed, 108 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> >>> index 6b0cd8861b..e34b2af4eb 100644
> >>> --- a/hw/s390x/css.c
> >>> +++ b/hw/s390x/css.c
> >>> @@ -819,6 +819,113 @@ incr:
> >>>      return 0;
> >>>  }
> >>>
> >>> +/* returns values between 1 and bsz, where bs is a power of 2 */
> >>> +static inline uint16_t ida_continuous_left(hwaddr cda, uint64_t bsz)
> >>> +{
> >>> +    return bsz - (cda & (bsz - 1));
> >>> +}
> >>> +
> >>> +static inline uint64_t ccw_ida_block_size(uint8_t flags)
> >>> +{
> >>> +    return 1ULL << (((flags ^ CDS_F_C64) & (CDS_F_C64 | CDS_F_I2K)) ? 11 : 12);    
> >> If CDS_F_C64 is set, (flags ^ CDS_F_C64) will be 0, so (1ULL << 11) will
> >> be the result regardless the I2K flag? The logic seems wrong.  
> 
> No. If CDS_F_C64 is set then the outcome depends on the fact if
> CDS_F_I2K is set or not.
> (flags & CDS_F_IK) => ((flags ^ CDS_F_C64) & CDS_F_IK)
> "(flags ^ CDS_F_C64) will be 0" is wrong. flags ^ CDS_F_C64
> just flips the CDS_F_C64.
> 
> OTOH if the CDS_F_C64 was not set we have the corresponding
> bit set in flags ^ CDS_F_C64 so then the  CDS_F_I2K bit does
> not matter: we have 1ULL << 11.
> 
> In my reading the logic is good.

So I'll just leave it...

> 
> > 
> > I've stared at that condition now for a bit, but all it managed was to
> > get me more confused... probably just need a break.
> >   
> >>
> >> I2K is meaningful only when C64 is 1, otherwise it is ignored. The logic
> >> here should be:
> >> if ((flags & CDS_F_C64) && !(flags & CDS_F_I2K)) {
> >>     return 1ULL << 12;
> >> }
> >>     return 1ULL << 11;  
> > 
> > But I do think your version is more readable...
> >   
> 
> I won't argue with this.

...and we could change that in a patch on top to avoid future confusion.

> 
> >>  
> >>> +}
> >>> +
> >>> +static inline int ida_read_next_idaw(CcwDataStream *cds)
> >>> +{
> >>> +    union {uint64_t fmt2; uint32_t fmt1; } idaw;    
> >>                                            ^
> >> Nit.
> >>  
> 
> Maybe checkpatch wanted it this way. My memories are blurry.


I'd just leave it like that, tbh.

> 
> >>> +    bool is_fmt2 = cds->flags & CDS_F_C64;
> >>> +    int ret;
> >>> +    hwaddr idaw_addr;
> >>> +
> >>> +    if (is_fmt2) {
> >>> +        idaw_addr = cds->cda_orig + sizeof(idaw.fmt2) * cds->at_idaw;
> >>> +        if (idaw_addr & 0x07) {
> >>> +            return -EINVAL; /* channel program check */
> >>> +        }
> >>> +        ret = address_space_rw(&address_space_memory, idaw_addr,
> >>> +                               MEMTXATTRS_UNSPECIFIED, (void *) &idaw.fmt2,
> >>> +                               sizeof(idaw.fmt2), false);
> >>> +        cds->cda = be64_to_cpu(idaw.fmt2);
> >>> +    } else {
> >>> +        idaw_addr = cds->cda_orig + sizeof(idaw.fmt1) * cds->at_idaw;
> >>> +        if (idaw_addr & 0x03) {    
> >> ?:
> >> (idaw_addr & 0x80000003)  
> > 
> > Yes.
> >   
> 
> I will double check this. Does not seem unreasonable but
> double-checking is better.

Please let me know. I think the architecture says that the bit must be
zero, and that we may (...) generate a channel program check.

> 
> >>  
> >>> +            return -EINVAL; /* channel program check */
> >>> +
> >>> +        }
> >>> +        ret = address_space_rw(&address_space_memory, idaw_addr,
> >>> +                               MEMTXATTRS_UNSPECIFIED, (void *) &idaw.fmt1,
> >>> +                               sizeof(idaw.fmt1), false);
> >>> +        cds->cda = be64_to_cpu(idaw.fmt1);
> >>> +    }
> >>> +    ++(cds->at_idaw);
> >>> +    if (ret != MEMTX_OK) {
> >>> +        /* assume inaccessible address */
> >>> +        return -EINVAL; /* channel program check */
> >>> +
> >>> +    }
> >>> +    return 0;
> >>> +}
> >>> +
> >>> +static int ccw_dstream_rw_ida(CcwDataStream *cds, void *buff, int len,
> >>> +                              CcwDataStreamOp op)
> >>> +{
> >>> +    uint64_t bsz = ccw_ida_block_size(cds->flags);
> >>> +    int ret = 0;
> >>> +    uint16_t cont_left, iter_len;
> >>> +
> >>> +    ret = cds_check_len(cds, len);
> >>> +    if (ret <= 0) {
> >>> +        return ret;
> >>> +    }
> >>> +    if (!cds->at_idaw) {
> >>> +        /* read first idaw */
> >>> +        ret = ida_read_next_idaw(cds);
> >>> +        if (ret) {
> >>> +            goto err;
> >>> +        }
> >>> +        cont_left = ida_continuous_left(cds->cda, bsz);
> >>> +    } else {
> >>> +        cont_left = ida_continuous_left(cds->cda, bsz);
> >>> +        if (cont_left == bsz) {
> >>> +            ret = ida_read_next_idaw(cds);
> >>> +            if (ret) {
> >>> +                goto err;
> >>> +            }
> >>> +            if (cds->cda & (bsz - 1)) {    
> >> Could move this check into ida_read_next_idaw?  
> > 
> > I'd like to avoid further code movement...
> >   
> 
> The first idaw is special. I don't think moving is possible.

So, the code is correct and I'll just leave it like that.

> 
> >>  
> >>> +                ret = -EINVAL; /* channel program check */
> >>> +                goto err;
> >>> +            }
> >>> +        }
> >>> +    }
> >>> +    do {
> >>> +        iter_len = MIN(len, cont_left);
> >>> +        if (op != CDS_OP_A) {
> >>> +            ret = address_space_rw(&address_space_memory, cds->cda,
> >>> +                                   MEMTXATTRS_UNSPECIFIED, buff, iter_len, op);    
> >> Ahh, now I recall that explictly defining CDS_OP_R to 0 and CDS_OP_W to
> >> 1 in 'struct CcwDataStreamOp' do have a meaning. Does it make sense to
> >> make it more obvious by adding some comment there?  
> > 
> > Would you have a good text for that?
> >   
> 
> I'm fine with clarifications.

Let's do it as a patch on top.

> 
> >>  
> >>> +            if (ret != MEMTX_OK) {
> >>> +                /* assume inaccessible address */
> >>> +                ret = -EINVAL; /* channel program check */
> >>> +                goto err;
> >>> +            }
> >>> +        }
> >>> +        cds->at_byte += iter_len;
> >>> +        cds->cda += iter_len;
> >>> +        len -= iter_len;
> >>> +        if (!len) {
> >>> +            break;
> >>> +        }
> >>> +        ret = ida_read_next_idaw(cds);
> >>> +        if (ret) {
> >>> +            goto err;
> >>> +        }
> >>> +        cont_left = bsz;
> >>> +    } while (true);
> >>> +    return ret;
> >>> +err:
> >>> +    cds->flags |= CDS_F_STREAM_BROKEN;
> >>> +    return ret;
> >>> +}
> >>> +
> >>>  void ccw_dstream_init(CcwDataStream *cds, CCW1 const *ccw, ORB const *orb)
> >>>  {
> >>>      /*
> >>> @@ -835,7 +942,7 @@ void ccw_dstream_init(CcwDataStream *cds, CCW1 const *ccw, ORB const *orb)
> >>>      if (!(cds->flags & CDS_F_IDA)) {
> >>>          cds->op_handler = ccw_dstream_rw_noflags;
> >>>      } else {
> >>> -        assert(false);
> >>> +        cds->op_handler = ccw_dstream_rw_ida;
> >>>      }
> >>>  }
> >>>
> >>> -- 
> >>> 2.13.5
> >>>     
> >>
> >> Generally, the logic looks fine to me.
> >>  
> > 
> > It did pass Halil's test; but that can only test fmt-2 + 4k blocks, as
> > this is what the kernel infrastructure provides.  
> 
> Nod.
> 
> > 
> > Halil, do you have some more comments?
> >   
> 
> Just a question. Do I have to respin?

I don't think so. If you could confirm the check for format-1, I'll
just fixup that one and get the queued patches out of the door.

We can do more changes on top; it's not like I don't have more patches
waiting...
