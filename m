Received: from eggs.gnu.org ([2001:4830:134:3::10]:54504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1duYh4-000360-6P
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 02:41:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1duYgz-0003zA-58
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 02:41:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38920
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1duYgy-0003y3-Vm
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 02:41:05 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8K6dYux019938
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 02:41:04 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d3brrqpvs-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 02:41:03 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Wed, 20 Sep 2017 02:41:03 -0400
Date: Wed, 20 Sep 2017 14:40:58 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170913115029.47626-1-pasic@linux.vnet.ibm.com>
	<20170913115029.47626-5-pasic@linux.vnet.ibm.com>
	<20170919055005.GE5274@bjsdjshi@linux.vnet.ibm.com>
	<20170919114859.3e2d895b.cohuck@redhat.com>
	<fbb3522e-4086-359a-fca7-05371b76dac7@linux.vnet.ibm.com>
	<20170919125717.1ae0cd38.cohuck@redhat.com>
	<9872cee8-3503-8d52-c68f-d9c61143201c@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9872cee8-3503-8d52-c68f-d9c61143201c@linux.vnet.ibm.com>
Message-Id: <20170920064058.GE11080@bjsdjshi@linux.vnet.ibm.com>
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
Cc: Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

* Halil Pasic <pasic@linux.vnet.ibm.com> [2017-09-19 14:04:03 +0200]:

I have no problem with the rest parts of the discussion in this thread.

> 
> 
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
My fault... This is the address of an IDAW, not the content (data
address) in an IDAW. So what Halil pointed out is the right direction to
go I think.

I will review in the thread of the new version (v3).

> 
> Not exactly. The more significant bits part of the check
> depend on the ccw format. This needs to be done for both
> idaw formats. I would need to introduce a new flag, or
> access the SubchDev to do this properly.
> 
> Architecturally we also need to check the data addresses
> from which we read so we have nothing bigger than 
> (1 << 31) - 1 if we are working with format-1 idaws.
Right. This is what I actually wanted to say.

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
> 
> How shall we proceed?
> 
> Halil
> 
> >>>>  
> >>>>> +            return -EINVAL; /* channel program check */
> >>>>> +
> >>>>> +        }
> >>>>> +        ret = address_space_rw(&address_space_memory, idaw_addr,
> >>>>> +                               MEMTXATTRS_UNSPECIFIED, (void *) &idaw.fmt1,
> >>>>> +                               sizeof(idaw.fmt1), false);
> >>>>> +        cds->cda = be64_to_cpu(idaw.fmt1);>>>>> +    }
> >>>>> +    ++(cds->at_idaw);
> >>>>> +    if (ret != MEMTX_OK) {
> >>>>> +        /* assume inaccessible address */
> >>>>> +        return -EINVAL; /* channel program check */
> >>>>> +
> >>>>> +    }
> >>>>> +    return 0;
> >>>>> +}

-- 
Dong Jia Shi
