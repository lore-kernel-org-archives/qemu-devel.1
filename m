Received: from eggs.gnu.org ([2001:4830:134:3::10]:36918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1duq0R-0005VN-98
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 21:10:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1duq0M-0002so-78
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 21:10:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42340
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1duq0M-0002ja-0V
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 21:10:14 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8L18ZGL038095
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 21:10:13 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d4351s8te-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 21:10:12 -0400
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Wed, 20 Sep 2017 19:10:11 -0600
Date: Thu, 21 Sep 2017 09:10:07 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170919182745.90280-1-pasic@linux.vnet.ibm.com>
	<20170919182745.90280-6-pasic@linux.vnet.ibm.com>
	<20170920074238.GH11080@bjsdjshi@linux.vnet.ibm.com>
	<20170920103312.50b8b69b.cohuck@redhat.com>
	<009428a2-fb31-ecc9-d477-4cdea226f2d8@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <009428a2-fb31-ecc9-d477-4cdea226f2d8@linux.vnet.ibm.com>
Message-Id: <20170921011007.GM11080@bjsdjshi@linux.vnet.ibm.com>
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
Cc: Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

* Halil Pasic <pasic@linux.vnet.ibm.com> [2017-09-20 13:13:01 +0200]:

> 
> 
> On 09/20/2017 10:33 AM, Cornelia Huck wrote:
> > On Wed, 20 Sep 2017 15:42:38 +0800
> > Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
> > 
> >> * Halil Pasic <pasic@linux.vnet.ibm.com> [2017-09-19 20:27:45 +0200]:
> >>
> >>> Let's add indirect data addressing support for our virtual channel
> >>> subsystem. This implementation does not bother with any kind of
> >>> prefetching. We simply step through the IDAL on demand.
> >>>
> >>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> >>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> >>> ---
> >>>  hw/s390x/css.c | 117 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
> >>>  1 file changed, 116 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> >>> index 2d37a9ddde..a3ce6d89b6 100644
> >>> --- a/hw/s390x/css.c
> >>> +++ b/hw/s390x/css.c
> >>> @@ -827,6 +827,121 @@ incr:
> >>>      return 0;
> >>>  }
> >>>
> >>> +/* returns values between 1 and bsz, where bsz is a power of 2 */
> >>> +static inline uint16_t ida_continuous_left(hwaddr cda, uint64_t bsz)
> >>> +{
> >>> +    return bsz - (cda & (bsz - 1));
> >>> +}
> >>> +
> >>> +static inline uint64_t ccw_ida_block_size(uint8_t flags)
> >>> +{
> >>> +    if ((flags & CDS_F_C64) && !(flags & CDS_F_I2K)) {
> >>> +        return 1ULL << 12;
> >>> +    }
> >>> +    return 1ULL << 11;
> >>> +}
> >>> +
> >>> +static inline int ida_read_next_idaw(CcwDataStream *cds, bool ccw_fmt1,
> >>> +                                     bool idaw_fmt_2)
> >>> +{
> >>> +    union {uint64_t fmt2; uint32_t fmt1; } idaw;
> >>> +    int ret;
> >>> +    hwaddr idaw_addr;
> >>> +
> >>> +    if (idaw_fmt_2) {
> >>> +        idaw_addr = cds->cda_orig + sizeof(idaw.fmt2) * cds->at_idaw;
> >>> +        if (idaw_addr & 0x07 && cds_ccw_addrs_ok(idaw_addr, 0, ccw_fmt1)) {
> >>> +            return -EINVAL; /* channel program check */
> >>> +        }
> >>> +        ret = address_space_rw(&address_space_memory, idaw_addr,  
> >> Ahh, just got one question here:
> >> Do we need to considerate endianess for idaw_addr?
> > 
> > That is taken care of below.
> > 
> > And the previous version worked on my laptop via tcg ;)
> 
> Nod.

My fault!

I was thinking of the idaw_addr itself, not the content of it. Now I
realized that, since we already converted (cds->cda_orig) in
copy_ccw_from_guest(), there is no need to convert (idaw_addr +
idaw_size * idaw_index) anymore.

Please ingnore my noise. ;P

> 
> > 
> >>
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

[...]

-- 
Dong Jia Shi
