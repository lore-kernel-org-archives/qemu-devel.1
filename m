Received: from eggs.gnu.org ([2001:4830:134:3::10]:56033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duHZK-0000xr-Da
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:24:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duHZG-0001JN-ED
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:24:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57652)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1duHZG-0001Is-4z
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:23:58 -0400
Date: Tue, 19 Sep 2017 14:23:51 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170919142351.1e3b66d8.cohuck@redhat.com>
In-Reply-To: <9872cee8-3503-8d52-c68f-d9c61143201c@linux.vnet.ibm.com>
References: <20170913115029.47626-1-pasic@linux.vnet.ibm.com>
	<20170913115029.47626-5-pasic@linux.vnet.ibm.com>
	<20170919055005.GE5274@bjsdjshi@linux.vnet.ibm.com>
	<20170919114859.3e2d895b.cohuck@redhat.com>
	<fbb3522e-4086-359a-fca7-05371b76dac7@linux.vnet.ibm.com>
	<20170919125717.1ae0cd38.cohuck@redhat.com>
	<9872cee8-3503-8d52-c68f-d9c61143201c@linux.vnet.ibm.com>
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

On Tue, 19 Sep 2017 14:04:03 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> On 09/19/2017 12:57 PM, Cornelia Huck wrote:
> >>>>> +static inline int ida_read_next_idaw(CcwDataStream *cds)
> >>>>> +{
> >>>>> +    union {uint64_t fmt2; uint32_t fmt1; } idaw;      
> >>>>                                            ^
> >>>> Nit.
> >>>>    
> >> Maybe checkpatch wanted it this way. My memories are blurry.  
> > 
> > I'd just leave it like that, tbh.
> >   
> >>>>> +    bool is_fmt2 = cds->flags & CDS_F_C64;
> >>>>> +    int ret;
> >>>>> +    hwaddr idaw_addr;
> >>>>> +
> >>>>> +    if (is_fmt2) {
> >>>>> +        idaw_addr = cds->cda_orig + sizeof(idaw.fmt2) * cds->at_idaw;
> >>>>> +        if (idaw_addr & 0x07) {
> >>>>> +            return -EINVAL; /* channel program check */
> >>>>> +        }
> >>>>> +        ret = address_space_rw(&address_space_memory, idaw_addr,
> >>>>> +                               MEMTXATTRS_UNSPECIFIED, (void *) &idaw.fmt2,
> >>>>> +                               sizeof(idaw.fmt2), false);
> >>>>> +        cds->cda = be64_to_cpu(idaw.fmt2);  
> 
> 
> >>>>> +    } else {
> >>>>> +        idaw_addr = cds->cda_orig + sizeof(idaw.fmt1) * cds->at_idaw;
> >>>>> +        if (idaw_addr & 0x03) {      
> >>>> ?:
> >>>> (idaw_addr & 0x80000003)    
> >>> Yes.
> >>>     
> >> I will double check this. Does not seem unreasonable but
> >> double-checking is better.  
> > Please let me know. I think the architecture says that the bit must be
> > zero, and that we may (...) generate a channel program check.
> >   
> 
> Not exactly. The more significant bits part of the check
> depend on the ccw format. This needs to be done for both
> idaw formats. I would need to introduce a new flag, or
> access the SubchDev to do this properly.
> 
> Architecturally we also need to check the data addresses
> from which we read so we have nothing bigger than 
> (1 << 31) - 1 if we are working with format-1 idaws.
> 
> I also think we did not take proper care of proper
> maximum data address checks prior CwwDataStream which also
> depend on the ccw format (in absence of IDAW or MIDAW).
> 
> The ccw format dependent maximum address checks are (1 << 24) - 1
> and (1 << 31) - 1 respectively for format-0 and format-1 (on
> the first indirection level that is for non-IDA for the data,
> and for (M)IDA for the (M)IDAWs).
> 
> Reference:
> PoP pages 16-25 and 16-26 "Invalid IDAW or MIDAW Addre" and
> "Invalid Data Address".

Sigh, when are things ever easy :(

I'll need some time to review this. But more urgently, I need a break.

> 
> How shall we proceed?

Given the discussion about this patch in particular, I'll probably
dequeue it and send it with the next batch of patches. We can also
include the other improvements, then. Not sure whether I should just
dequeue this one or the whole series (I really want to get the rest of
the patches out...)

More after the break :)
