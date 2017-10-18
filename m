Received: from eggs.gnu.org ([2001:4830:134:3::10]:40149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e4lBI-00059d-2D
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 06:02:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e4lBE-0004Lt-25
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 06:02:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50284)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e4lBD-0004LQ-S0
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 06:02:27 -0400
Date: Wed, 18 Oct 2017 12:02:23 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171018120223.60291cd8.cohuck@redhat.com>
In-Reply-To: <9f2bd0fe-1b01-2fce-a6a6-694c4242eb7d@redhat.com>
References: <20171017140453.51099-1-pasic@linux.vnet.ibm.com>
	<20171017140453.51099-8-pasic@linux.vnet.ibm.com>
	<9f2bd0fe-1b01-2fce-a6a6-694c4242eb7d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 7/7] s390x: refactor error handling for
 MSCH handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Wed, 18 Oct 2017 12:00:05 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 17.10.2017 16:04, Halil Pasic wrote:
> > Simplify the error handling of the MSCH.  Let the code detecting the
> > condition tell (in a less ambiguous way) how it's to be handled. No
> > changes in behavior.  
> 
> ok, so you claim no changes in behavior ...
> 
> > Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> > ---
> >  hw/s390x/css.c         | 18 +++++-------------
> >  include/hw/s390x/css.h |  2 +-
> >  target/s390x/ioinst.c  | 23 ++++-------------------
> >  3 files changed, 10 insertions(+), 33 deletions(-)
> > 
> > diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> > index b9e0329825..30fc236946 100644
> > --- a/hw/s390x/css.c
> > +++ b/hw/s390x/css.c
> > @@ -1347,28 +1347,24 @@ static void copy_schib_from_guest(SCHIB *dest, const SCHIB *src)
> >      }
> >  }
> >  
> > -int css_do_msch(SubchDev *sch, const SCHIB *orig_schib)
> > +IOInstEnding css_do_msch(SubchDev *sch, const SCHIB *orig_schib)
> >  {
> >      SCSW *s = &sch->curr_status.scsw;
> >      PMCW *p = &sch->curr_status.pmcw;
> >      uint16_t oldflags;
> > -    int ret;
> >      SCHIB schib;
> >  
> >      if (!(sch->curr_status.pmcw.flags & PMCW_FLAGS_MASK_DNV)) {
> > -        ret = 0;
> > -        goto out;
> > +        return IOINST_CC_EXPECTED;
> >      }
> >  
> >      if (s->ctrl & SCSW_STCTL_STATUS_PEND) {
> > -        ret = -EINPROGRESS;
> > -        goto out;
> > +        return IOINST_CC_STATUS_PRESENT;
> >      }
> >  
> >      if (s->ctrl &
> >          (SCSW_FCTL_START_FUNC|SCSW_FCTL_HALT_FUNC|SCSW_FCTL_CLEAR_FUNC)) {
> > -        ret = -EBUSY;
> > -        goto out;
> > +        return IOINST_CC_STATUS_PRESENT;
> >      }  
> 
> ... but here you change -EBUSY (which got mapped to CC=2) to
> CC_STATUS_PRESENT which means CC=1. So that's a change in behavior. i.e.
> this is either a bug, or you should update the patch description with a
> justification for this change in behavior.

Indeed, that's a bug. We still want cc 2.
