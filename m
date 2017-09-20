Received: from eggs.gnu.org ([2001:4830:134:3::10]:55359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dufjB-0000Oo-2N
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:11:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dufj7-000475-22
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:11:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dufj6-00046h-Rf
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:11:44 -0400
Date: Wed, 20 Sep 2017 13:43:58 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170920134358.568404ac.cohuck@redhat.com>
In-Reply-To: <1f526c43-6967-e30c-25c7-3b079e0598d3@linux.vnet.ibm.com>
References: <20170919182745.90280-1-pasic@linux.vnet.ibm.com>
	<20170919182745.90280-5-pasic@linux.vnet.ibm.com>
	<20170920100640.79900c9f.cohuck@redhat.com>
	<1f526c43-6967-e30c-25c7-3b079e0598d3@linux.vnet.ibm.com>
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

On Wed, 20 Sep 2017 13:34:21 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> On 09/20/2017 10:06 AM, Cornelia Huck wrote:
> > On Tue, 19 Sep 2017 20:27:44 +0200
> > Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> >   
> >> The architecture mandates the addresses to be  accessed on the first
> >> indirection level (that is, the data addresses without IDA, and the
> >> (M)IDAW addresses with (M)IDA) to be checked against an CCW format
> >> dependent limit maximum address.  If a violation is detected, the storage
> >> access is not to be performed and a channel program check needs to be
> >> generated. As of today, we fail to do this check.
> >>
> >> Let us stick even closer to the architecture specification.
> >>
> >> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> >> ---
> >>  hw/s390x/css.c         | 10 ++++++++++
> >>  include/hw/s390x/css.h |  1 +
> >>  2 files changed, 11 insertions(+)
> >>
> >> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> >> index 6b0cd8861b..2d37a9ddde 100644
> >> --- a/hw/s390x/css.c
> >> +++ b/hw/s390x/css.c
> >> @@ -795,6 +795,11 @@ static inline int cds_check_len(CcwDataStream *cds, int len)
> >>      return cds->flags & CDS_F_STREAM_BROKEN ? -EINVAL : len;
> >>  }
> >>  
> >> +static inline bool cds_ccw_addrs_ok(hwaddr addr, int len, bool ccw_fmt1)  
> > 
> > cds_cda_limit_ok?
> >   
> 
> I use cda to point to the 2 level in case of IDA. This is about
> level 1 (addressed by the ccw directly). That's why I used ccw_addrs
> but if you think cds_cda_limit_ok is better I can live with that.

I don't care that much, tbh.

> 
> We could also think about renaming cds->cda. Btw what does cda stand
> for (channel data address is my guess)?

Yes, cda should stand for 'channel data address'. Its usage in cds->cda
is probably the source of this minor confusion.

But, as said, I don't really care that much; so unless one of the other
folks has a strong opinion, feel free to leave as-is.
