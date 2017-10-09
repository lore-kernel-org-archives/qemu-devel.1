Received: from eggs.gnu.org ([2001:4830:134:3::10]:37142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1e1Spa-0004Ya-Jo
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 03:50:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1e1SpW-000845-Lp
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 03:50:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35244
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1e1SpW-0007fl-FS
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 03:50:26 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v997mxUW053753
	for <qemu-devel@nongnu.org>; Mon, 9 Oct 2017 03:49:40 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dg2tpvx9y-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 03:49:40 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Mon, 9 Oct 2017 01:49:39 -0600
Date: Mon, 9 Oct 2017 15:49:34 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20171004154144.88995-1-pasic@linux.vnet.ibm.com>
	<20171004154144.88995-2-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171004154144.88995-2-pasic@linux.vnet.ibm.com>
Message-Id: <20171009074934.GA5350@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/8] s390x/css: be more consistent if
 broken beyond repair
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

* Halil Pasic <pasic@linux.vnet.ibm.com> [2017-10-04 17:41:37 +0200]:

> Calling do_subchannel_work with no function control flags set in SCSW is
> a programming error. Currently the handle this differently in
?:
s/the/we/

> do_subchannel_work_virtual and do_subchannel_work_passthrough. Let's be
> consistent and guard with a common assert against this programming error.
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
>  hw/s390x/css.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index c59be1aad1..4f47dbc8b0 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -1067,9 +1067,6 @@ int do_subchannel_work_virtual(SubchDev *sch)
>      } else if (s->ctrl & SCSW_FCTL_START_FUNC) {
>          /* Triggered by both ssch and rsch. */
>          sch_handle_start_func_virtual(sch);
> -    } else {
> -        /* Cannot happen. */
> -        return 0;
>      }
>      css_inject_io_interrupt(sch);
>      return 0;
> @@ -1077,22 +1074,17 @@ int do_subchannel_work_virtual(SubchDev *sch)
> 
>  int do_subchannel_work_passthrough(SubchDev *sch)
>  {
> -    int ret;
> +    int ret = 0;
>      SCSW *s = &sch->curr_status.scsw;
> 
>      if (s->ctrl & SCSW_FCTL_CLEAR_FUNC) {
>          /* TODO: Clear handling */
>          sch_handle_clear_func(sch);
> -        ret = 0;
>      } else if (s->ctrl & SCSW_FCTL_HALT_FUNC) {
>          /* TODO: Halt handling */
>          sch_handle_halt_func(sch);
> -        ret = 0;
A bit surprise to see these. I'm fine with these changes though.

>      } else if (s->ctrl & SCSW_FCTL_START_FUNC) {
>          ret = sch_handle_start_func_passthrough(sch);
> -    } else {
> -        /* Cannot happen. */
> -        return -ENODEV;
>      }
> 
>      return ret;
> @@ -1100,11 +1092,11 @@ int do_subchannel_work_passthrough(SubchDev *sch)
> 
>  static int do_subchannel_work(SubchDev *sch)
>  {
> -    if (sch->do_subchannel_work) {
> -        return sch->do_subchannel_work(sch);
> -    } else {
> +    if (!sch->do_subchannel_work) {
>          return -EINVAL;
>      }
> +    g_assert(sch->curr_status.scsw.ctrl & SCSW_CTRL_MASK_FCTL);
> +    return sch->do_subchannel_work(sch);
>  }
> 
>  static void copy_pmcw_to_guest(PMCW *dest, const PMCW *src)

With the fix of the message:
Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>

-- 
Dong Jia Shi
