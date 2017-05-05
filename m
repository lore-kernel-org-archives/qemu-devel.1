Received: from eggs.gnu.org ([2001:4830:134:3::10]:42018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d6byJ-0000nr-GK
	for qemu-devel@nongnu.org; Fri, 05 May 2017 08:04:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1d6byG-0008Ez-Bj
	for qemu-devel@nongnu.org; Fri, 05 May 2017 08:04:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55132
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1d6byG-0008En-5r
	for qemu-devel@nongnu.org; Fri, 05 May 2017 08:04:28 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v45C4INc120750
	for <qemu-devel@nongnu.org>; Fri, 5 May 2017 08:04:27 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2a8qancupb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 08:04:26 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Fri, 5 May 2017 13:04:24 +0100
Date: Fri, 5 May 2017 14:04:20 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20170505020352.8984-5-bjsdjshi@linux.vnet.ibm.com>
References: <20170505020352.8984-1-bjsdjshi@linux.vnet.ibm.com>
	<20170505020352.8984-5-bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170505140420.097febf7.cornelia.huck@de.ibm.com>
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
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, eric.auger@redhat.com, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>

On Fri,  5 May 2017 04:03:43 +0200
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> From: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
> 
> The S390 virtual css support already has a mechanism to build virtual
> Sub-Channel Information Block and provide virtual subchannels to the

"to build a virtual subchannel information block (schib) and provide..."

> guest. However, to pass-through subchannels to a guest, we need to
> introduce a new mechanism to build its schib according to the real
> device information. Thus we realize a new css_sch_build_schib function
> to extract the path_masks, chpids, chpid type from sysfs. To reuse
> the existing code, we refactor css_add_virtual_chpid to css_add_chpid.
> 
> Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> Signed-off-by: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
> Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> ---
>  hw/s390x/css.c         | 153 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  include/hw/s390x/css.h |  36 ++++++------
>  2 files changed, 169 insertions(+), 20 deletions(-)
> 

> +/*
> + * We currently retrieve the real device information from sysfs to build the
> + * guest subchannel information block without considering the migration feature.
> + * If migrate, it won't be sure to use the real device information directly,
> + * this point will be handled in the future.

Let's make the second sentence: "We need to revisit this problem when
we want to add migration support."

> + */
> +int css_sch_build_schib(SubchDev *sch, CssDevId *dev_id)
> +{
> +    CssImage *css = channel_subsys.css[sch->cssid];
> +    PMCW *p = &sch->curr_status.pmcw;
> +    SCSW *s = &sch->curr_status.scsw;
> +    uint32_t type;
> +    int i, ret;
> +
> +    /* We are dealing with I/O subchannels only. */

Let's move this comment directly before setting dnv; it's a bit
confusing here.

> +    assert(css != NULL);
> +    memset(p, 0, sizeof(PMCW));
> +    p->flags |= PMCW_FLAGS_MASK_DNV;
> +    p->devno = sch->devno;
> +
> +    /* Grab path mask from sysfs. */
> +    ret = css_sch_get_path_masks(sch, dev_id);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    /* Grab chpids from sysfs. */
> +    ret = css_sch_get_chpids(sch, dev_id);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +   /* Build chpid type. */
> +    for (i = 0; i < ARRAY_SIZE(p->chpid); i++) {
> +        if (p->chpid[i] && !css->chpids[p->chpid[i]].in_use) {
> +            ret = css_sch_get_chpid_type(p->chpid[i], &type, dev_id);
> +            if (ret) {
> +                return ret;
> +            }
> +            css_add_chpid(sch->cssid, p->chpid[i], type, false);
> +        }
> +    }
> +
> +    memset(s, 0, sizeof(SCSW));
> +    sch->curr_status.mba = 0;
> +    for (i = 0; i < ARRAY_SIZE(sch->curr_status.mda); i++) {
> +        sch->curr_status.mda[i] = 0;
> +    }
> +
> +    return 0;
> +}
> diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
> index f1f0d7f..868c6c7 100644
> --- a/include/hw/s390x/css.h
> +++ b/include/hw/s390x/css.h
> @@ -94,6 +94,24 @@ struct SubchDev {
>      void *driver_data;
>  };
> 
> +/*
> + * Identify a device within the channel subsystem.
> + * Note that this can be used to identify either the subchannel or
> + * the attached I/O device, as there's always one I/O device per
> + * subchannel.
> + */
> +typedef struct CssDevId {
> +    uint8_t cssid;
> +    uint8_t ssid;
> +    uint16_t devid;
> +    bool valid;
> +} CssDevId;
> +
> +extern PropertyInfo css_devid_propinfo;
> +
> +#define DEFINE_PROP_CSS_DEV_ID(_n, _s, _f) \
> +    DEFINE_PROP(_n, _s, _f, css_devid_propinfo, CssDevId)
> +
>  typedef struct IndAddr {
>      hwaddr addr;
>      uint64_t map;
> @@ -115,6 +133,7 @@ bool css_devno_used(uint8_t cssid, uint8_t ssid, uint16_t devno);
>  void css_subch_assign(uint8_t cssid, uint8_t ssid, uint16_t schid,
>                        uint16_t devno, SubchDev *sch);
>  void css_sch_build_virtual_schib(SubchDev *sch, uint8_t chpid, uint8_t type);
> +int css_sch_build_schib(SubchDev *sch, CssDevId *dev_id);
>  uint16_t css_build_subchannel_id(SubchDev *sch);
>  void css_reset(void);
>  void css_reset_sch(SubchDev *sch);
> @@ -162,23 +181,6 @@ int css_do_rsch(SubchDev *sch);
>  int css_do_rchp(uint8_t cssid, uint8_t chpid);
>  bool css_present(uint8_t cssid);
>  #endif
> -/*
> - * Identify a device within the channel subsystem.
> - * Note that this can be used to identify either the subchannel or
> - * the attached I/O device, as there's always one I/O device per
> - * subchannel.
> - */
> -typedef struct CssDevId {
> -    uint8_t cssid;
> -    uint8_t ssid;
> -    uint16_t devid;
> -    bool valid;
> -} CssDevId;
> -
> -extern PropertyInfo css_devid_propinfo;
> -
> -#define DEFINE_PROP_CSS_DEV_ID(_n, _s, _f) \
> -    DEFINE_PROP(_n, _s, _f, css_devid_propinfo, CssDevId)

It's a bit unfortunate that you need to move this whole code block. Oh
well.

> 
>  extern PropertyInfo css_devid_ro_propinfo;
> 
