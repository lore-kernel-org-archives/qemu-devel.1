Received: from eggs.gnu.org ([2001:4830:134:3::10]:33554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ds4Qz-0007c5-CO
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:58:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ds4Qv-0005pw-EA
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:58:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ds4Qv-0005pT-55
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:58:13 -0400
Date: Wed, 13 Sep 2017 11:58:08 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170913115808.4a8d263b.cohuck@redhat.com>
In-Reply-To: <b4351b30-455a-7247-30f2-9a2b2c21ae17@linux.vnet.ibm.com>
References: <20170905111645.18068-1-pasic@linux.vnet.ibm.com>
	<20170905111645.18068-5-pasic@linux.vnet.ibm.com>
	<20170906151028.545f208e.cohuck@redhat.com>
	<b4351b30-455a-7247-30f2-9a2b2c21ae17@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/5] s390x/css: support ccw IDA
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

On Mon, 11 Sep 2017 20:08:16 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> On 09/06/2017 03:10 PM, Cornelia Huck wrote:
> > On Tue,  5 Sep 2017 13:16:44 +0200
> > Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> >   
> >> Let's add indirect data addressing support for our virtual channel
> >> subsystem. This implementation does no prefetching, but steps
> >> trough the idal as we go.
> >>
> >> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> >> ---
> >>  hw/s390x/css.c | 110 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> >>  1 file changed, 109 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> >> index c1bc9944e6..9d8f9fd7ea 100644
> >> --- a/hw/s390x/css.c
> >> +++ b/hw/s390x/css.c
> >> @@ -819,6 +819,114 @@ incr:
> >>      return 0;
> >>  }
> >>  
> >> +/* retuns values between 1 and bs, where bs is a power of 2 */  
> > 
> > 'bs' is 'block size'?  
> 
> Yes.

The first thing that popped up in my head was something else, that's
why I asked :) Maybe bsz would be better.

In any case, s/retuns/returns/

> 
> >   
> >> +static inline uint16_t ida_continuous_left(hwaddr cda, uint64_t bs)
> >> +{
> >> +    return bs - (cda & (bs - 1));
> >> +}

> >> +static int ccw_dstream_rw_ida(CcwDataStream *cds, void *buff, int len,
> >> +                              CcwDataStreamOp op)
> >> +{
> >> +    uint64_t bs = ccw_ida_block_size(cds->flags);
> >> +    int ret = 0;
> >> +    uint16_t cont_left, iter_len;
> >> +
> >> +    ret = cds_check_len(cds, len);
> >> +    if (ret <= 0) {
> >> +        return ret;
> >> +    }
> >> +    if (!cds->at_idaw) {
> >> +        /* read first idaw */
> >> +        ret = ida_read_next_idaw(cds);
> >> +        if (ret) {
> >> +            goto err;
> >> +        }
> >> +        cont_left = ida_continuous_left(cds->cda, bs);
> >> +    } else {
> >> +        cont_left = ida_continuous_left(cds->cda, bs);
> >> +        if (cont_left == bs) {
> >> +            ret = ida_read_next_idaw(cds);
> >> +            if (ret) {
> >> +                goto err;
> >> +            }
> >> +            if (cds->cda & (bs - 1)) {
> >> +                ret = -EINVAL; /* chanel program check */
> >> +                goto err;
> >> +            }
> >> +        }
> >> +    }
> >> +do_iter_len:
> >> +    iter_len = MIN(len, cont_left);
> >> +    if (op == CDS_OP_A) {
> >> +        goto incr;
> >> +    }
> >> +    ret = address_space_rw(&address_space_memory, cds->cda,
> >> +                           MEMTXATTRS_UNSPECIFIED, buff, iter_len, op);
> >> +    if (ret != MEMTX_OK) {
> >> +        /* assume inaccessible address */
> >> +        ret = -EINVAL; /* chanel program check */
> >> +        goto err;
> >> +    }
> >> +incr:
> >> +    cds->at_byte += iter_len;
> >> +    cds->cda += iter_len;
> >> +    len -= iter_len;
> >> +    if (len) {
> >> +        ret = ida_read_next_idaw(cds);
> >> +        if (ret) {
> >> +            goto err;
> >> +        }
> >> +        cont_left = bs;
> >> +        goto do_iter_len;
> >> +    }
> >> +    return ret;
> >> +err:
> >> +    cds->flags |= CDS_F_STREAM_BROKEN;
> >> +    return ret;
> >> +}  
> > 
> > I'm not so happy about the many gotos (excepting the err ones). Any
> > chance to get around these?
> >   
> Certainly possible:
> 
> static int ccw_dstream_rw_ida(CcwDataStream *cds, void *buff, int len,          
>                               CcwDataStreamOp op)                               
> {                                                                               
>     uint64_t bs = ccw_ida_block_size(cds->flags);                               
>     int ret = 0;                                                                
>     uint16_t cont_left, iter_len;                                               
>                                                                                 
>     ret = cds_check_len(cds, len);                                              
>     if (ret <= 0) {                                                             
>         return ret;                                                             
>     }                                                                           
>     if (!cds->at_idaw) {                                                        
>         /* read first idaw */                                                   
>         ret = ida_read_next_idaw(cds);                                          
>         if (ret) {                                                              
>             goto err;                                                           
>         }                                                                       
>         cont_left = ida_continuous_left(cds->cda, bs);                          
>     } else {                                                                    
>         cont_left = ida_continuous_left(cds->cda, bs);                          
>         if (cont_left == bs) {                                                  
>             ret = ida_read_next_idaw(cds);                                      
>             if (ret) {                                                          
>                 goto err;                                                       
>             }                                                                   
>             if (cds->cda & (bs - 1)) {                                          
>                 ret = -EINVAL; /* channel program check */                      
>                 goto err;                                                       
>             }                                                                   
>         }                                                                       
>     }                                                                           
>     do {                                                                        
>         iter_len = MIN(len, cont_left);                                         
>         if (op != CDS_OP_A) {                                                   
>             ret = address_space_rw(&address_space_memory, cds->cda,             
>                                    MEMTXATTRS_UNSPECIFIED, buff, iter_len, op); 
>             if (ret != MEMTX_OK) {                                              
>                 /* assume inaccessible address */                               
>                 ret = -EINVAL; /* channel program check */                      
>                 goto err;                                                       
>             }                                                                   
>         }                                                                       
>         cds->at_byte += iter_len;                                               
>         cds->cda += iter_len;                                                   
>         len -= iter_len;                                                        
>         if (!len) {                                                             
>             break;                                                              
>         }                                                                       
>         ret = ida_read_next_idaw(cds);                                          
>         if (ret) {                                                              
>             goto err;                                                           
>         }                                                                       
>         cont_left = bs;                                                         
>     } while (true);                                                             
>     return ret;                                                                 
> err:                                                                            
>     cds->flags |= CDS_F_STREAM_BROKEN;                                          
>     return ret;                                                                 
> }
> 
> My idea was decrease indentation level and at the same time make
> labels tell us something about the purpose of code pieces. Which
> one do you prefer?

I do not really like either much :( Any chance to make this better via
some kind of helper functions?
