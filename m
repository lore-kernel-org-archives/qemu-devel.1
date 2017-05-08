Received: from eggs.gnu.org ([2001:4830:134:3::10]:55152)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1d7Z1i-00018D-9X
	for qemu-devel@nongnu.org; Sun, 07 May 2017 23:07:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1d7Z1e-0000Ng-5U
	for qemu-devel@nongnu.org; Sun, 07 May 2017 23:07:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49615)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1d7Z1d-0000Na-Sd
	for qemu-devel@nongnu.org; Sun, 07 May 2017 23:07:54 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v482mxh8137265
	for <qemu-devel@nongnu.org>; Sun, 7 May 2017 23:07:50 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2aaakaay78-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 07 May 2017 23:07:50 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Sun, 7 May 2017 23:07:49 -0400
Date: Mon, 8 May 2017 11:07:43 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170505020352.8984-1-bjsdjshi@linux.vnet.ibm.com>
	<20170505020352.8984-5-bjsdjshi@linux.vnet.ibm.com>
	<20170505140420.097febf7.cornelia.huck@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170505140420.097febf7.cornelia.huck@de.ibm.com>
Message-Id: <20170508030743.GB15974@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v7 04/13] s390x/css: realize
 css_sch_build_schib
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, eric.auger@redhat.com, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>

* Cornelia Huck <cornelia.huck@de.ibm.com> [2017-05-05 14:04:20 +0200]:

> On Fri,  5 May 2017 04:03:43 +0200
> Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
> 
> > From: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
> > 
> > The S390 virtual css support already has a mechanism to build virtual
> > Sub-Channel Information Block and provide virtual subchannels to the
> 
> "to build a virtual subchannel information block (schib) and provide..."
> 
Ok.

> > guest. However, to pass-through subchannels to a guest, we need to
> > introduce a new mechanism to build its schib according to the real
> > device information. Thus we realize a new css_sch_build_schib function
> > to extract the path_masks, chpids, chpid type from sysfs. To reuse
> > the existing code, we refactor css_add_virtual_chpid to css_add_chpid.
> > 
> > Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> > Signed-off-by: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
> > Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> > ---
> >  hw/s390x/css.c         | 153 ++++++++++++++++++++++++++++++++++++++++++++++++-
> >  include/hw/s390x/css.h |  36 ++++++------
> >  2 files changed, 169 insertions(+), 20 deletions(-)
> > 
> 
> > +/*
> > + * We currently retrieve the real device information from sysfs to build the
> > + * guest subchannel information block without considering the migration feature.
> > + * If migrate, it won't be sure to use the real device information directly,
> > + * this point will be handled in the future.
> 
> Let's make the second sentence: "We need to revisit this problem when
> we want to add migration support."
> 
Ok.

> > + */
> > +int css_sch_build_schib(SubchDev *sch, CssDevId *dev_id)
> > +{
> > +    CssImage *css = channel_subsys.css[sch->cssid];
> > +    PMCW *p = &sch->curr_status.pmcw;
> > +    SCSW *s = &sch->curr_status.scsw;
> > +    uint32_t type;
> > +    int i, ret;
> > +
> > +    /* We are dealing with I/O subchannels only. */
> 
> Let's move this comment directly before setting dnv; it's a bit
> confusing here.
> 
Ok. I will move it to ...

> > +    assert(css != NULL);
> > +    memset(p, 0, sizeof(PMCW));
> > +    p->flags |= PMCW_FLAGS_MASK_DNV;
... here.

> > +    p->devno = sch->devno;
> > +
> > +    /* Grab path mask from sysfs. */
> > +    ret = css_sch_get_path_masks(sch, dev_id);
> > +    if (ret) {
> > +        return ret;
> > +    }
> > +
> > +    /* Grab chpids from sysfs. */
> > +    ret = css_sch_get_chpids(sch, dev_id);
> > +    if (ret) {
> > +        return ret;
> > +    }
> > +
> > +   /* Build chpid type. */
> > +    for (i = 0; i < ARRAY_SIZE(p->chpid); i++) {
> > +        if (p->chpid[i] && !css->chpids[p->chpid[i]].in_use) {
> > +            ret = css_sch_get_chpid_type(p->chpid[i], &type, dev_id);
> > +            if (ret) {
> > +                return ret;
> > +            }
> > +            css_add_chpid(sch->cssid, p->chpid[i], type, false);
> > +        }
> > +    }
> > +
> > +    memset(s, 0, sizeof(SCSW));
> > +    sch->curr_status.mba = 0;
> > +    for (i = 0; i < ARRAY_SIZE(sch->curr_status.mda); i++) {
> > +        sch->curr_status.mda[i] = 0;
> > +    }
> > +
> > +    return 0;
> > +}
[...]

-- 
Dong Jia Shi
