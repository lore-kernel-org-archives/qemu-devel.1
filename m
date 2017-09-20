Received: from eggs.gnu.org ([2001:4830:134:3::10]:48138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dufMi-0004Xu-Pr
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:48:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dufMf-0002QE-NW
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:48:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54276)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dufMf-0002PM-CB
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:48:33 -0400
Date: Wed, 20 Sep 2017 13:18:44 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170920131844.066e53d7.cohuck@redhat.com>
In-Reply-To: <009428a2-fb31-ecc9-d477-4cdea226f2d8@linux.vnet.ibm.com>
References: <20170919182745.90280-1-pasic@linux.vnet.ibm.com>
	<20170919182745.90280-6-pasic@linux.vnet.ibm.com>
	<20170920074238.GH11080@bjsdjshi@linux.vnet.ibm.com>
	<20170920103312.50b8b69b.cohuck@redhat.com>
	<009428a2-fb31-ecc9-d477-4cdea226f2d8@linux.vnet.ibm.com>
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

On Wed, 20 Sep 2017 13:13:01 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> On 09/20/2017 10:33 AM, Cornelia Huck wrote:
> > On Wed, 20 Sep 2017 15:42:38 +0800
> > Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
> >   
> >> * Halil Pasic <pasic@linux.vnet.ibm.com> [2017-09-19 20:27:45 +0200]:

> >>> +                               MEMTXATTRS_UNSPECIFIED, (void *) &idaw.fmt2,
> >>> +                               sizeof(idaw.fmt2), false);
> >>> +        cds->cda = be64_to_cpu(idaw.fmt2);
> >>> +    } else {
> >>> +        idaw_addr = cds->cda_orig + sizeof(idaw.fmt1) * cds->at_idaw;
> >>> +        if (idaw_addr & 0x03 && cds_ccw_addrs_ok(idaw_addr, 0, ccw_fmt1)) {
> >>> +            return -EINVAL; /* channel program check */
> >>> +        }
> >>> +        ret = address_space_rw(&address_space_memory, idaw_addr,
> >>> +                               MEMTXATTRS_UNSPECIFIED, (void *) &idaw.fmt1,
> >>> +                               sizeof(idaw.fmt1), false);
> >>> +        cds->cda = be64_to_cpu(idaw.fmt1);    
> >> Still need to check bit 0x80000000 here I think.  
> > 
> > Yes, I think this is 'must be zero' for format-1 idaws, and not covered
> > by the ccw-format specific checks above. (Although the PoP can be a bit
> > confusing with many similar terms...)
> >  
> 
> It's taken care of in ccw_dstream_rw_ida before the actual
> access happens. Code looks like this:
> +        if (!idaw_fmt2 && (cds->cda + iter_len) >= (1ULL << 31)) {
> +                ret = -EINVAL; /* channel program check */
> +                goto err;
> +        }
> 
> The idea was to have it similar to the non-indirect case.

<looks at patch again>

Ah, I was simply looking for the wrong pattern. Looks correct.


> >>> +static int ccw_dstream_rw_ida(CcwDataStream *cds, void *buff, int len,
> >>> +                              CcwDataStreamOp op)
> >>> +{
> >>> +    uint64_t bsz = ccw_ida_block_size(cds->flags);
> >>> +    int ret = 0;
> >>> +    uint16_t cont_left, iter_len;
> >>> +    const bool idaw_fmt2 = cds->flags & CDS_F_C64;
> >>> +    bool ccw_fmt1 = cds->flags & CDS_F_FMT;    
> >> Use 'const bool' either? Although I doubt the value of using const here.
> >> ;)  
> > 
> > Both being the same is still a good idea.
> >   
> 
> Yeah. For which one should I go (with const or without)?

For the one you prefer :) (I'm not sure if the const adds value here.)
