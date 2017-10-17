Received: from eggs.gnu.org ([2001:4830:134:3::10]:47703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e4TWq-0001MY-DR
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 11:11:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e4TWk-00078o-Ed
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 11:11:36 -0400
Date: Tue, 17 Oct 2017 17:11:26 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171017171126.7570bca1.cohuck@redhat.com>
In-Reply-To: <20171017140453.51099-8-pasic@linux.vnet.ibm.com>
References: <20171017140453.51099-1-pasic@linux.vnet.ibm.com>
	<20171017140453.51099-8-pasic@linux.vnet.ibm.com>
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
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

On Tue, 17 Oct 2017 16:04:53 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> Simplify the error handling of the MSCH.  Let the code detecting the
> condition tell (in a less ambiguous way) how it's to be handled. No
> changes in behavior.
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
>  hw/s390x/css.c         | 18 +++++-------------
>  include/hw/s390x/css.h |  2 +-
>  target/s390x/ioinst.c  | 23 ++++-------------------
>  3 files changed, 10 insertions(+), 33 deletions(-)

Looks sane (quoting the whole mail for the benefit of the qemu-s390x list).

> 
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index b9e0329825..30fc236946 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -1347,28 +1347,24 @@ static void copy_schib_from_guest(SCHIB *dest, const SCHIB *src)
>      }
>  }
>  
> -int css_do_msch(SubchDev *sch, const SCHIB *orig_schib)
> +IOInstEnding css_do_msch(SubchDev *sch, const SCHIB *orig_schib)
>  {
>      SCSW *s = &sch->curr_status.scsw;
>      PMCW *p = &sch->curr_status.pmcw;
>      uint16_t oldflags;
> -    int ret;
>      SCHIB schib;
>  
>      if (!(sch->curr_status.pmcw.flags & PMCW_FLAGS_MASK_DNV)) {
> -        ret = 0;
> -        goto out;
> +        return IOINST_CC_EXPECTED;
>      }
>  
>      if (s->ctrl & SCSW_STCTL_STATUS_PEND) {
> -        ret = -EINPROGRESS;
> -        goto out;
> +        return IOINST_CC_STATUS_PRESENT;
>      }
>  
>      if (s->ctrl &
>          (SCSW_FCTL_START_FUNC|SCSW_FCTL_HALT_FUNC|SCSW_FCTL_CLEAR_FUNC)) {
> -        ret = -EBUSY;
> -        goto out;
> +        return IOINST_CC_STATUS_PRESENT;
>      }
>  
>      copy_schib_from_guest(&schib, orig_schib);
> @@ -1395,11 +1391,7 @@ int css_do_msch(SubchDev *sch, const SCHIB *orig_schib)
>          && (p->flags & PMCW_FLAGS_MASK_ENA) == 0) {
>          sch->disable_cb(sch);
>      }
> -
> -    ret = 0;
> -
> -out:
> -    return ret;
> +    return IOINST_CC_EXPECTED;
>  }
>  
>  IOInstEnding css_do_xsch(SubchDev *sch)
> diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
> index 0c1efbae39..a74f6cc274 100644
> --- a/include/hw/s390x/css.h
> +++ b/include/hw/s390x/css.h
> @@ -239,7 +239,7 @@ bool css_subch_visible(SubchDev *sch);
>  void css_conditional_io_interrupt(SubchDev *sch);
>  int css_do_stsch(SubchDev *sch, SCHIB *schib);
>  bool css_schid_final(int m, uint8_t cssid, uint8_t ssid, uint16_t schid);
> -int css_do_msch(SubchDev *sch, const SCHIB *schib);
> +IOInstEnding css_do_msch(SubchDev *sch, const SCHIB *schib);
>  IOInstEnding css_do_xsch(SubchDev *sch);
>  IOInstEnding css_do_csch(SubchDev *sch);
>  IOInstEnding css_do_hsch(SubchDev *sch);
> diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
> index 8e4dacafd8..23962fbebc 100644
> --- a/target/s390x/ioinst.c
> +++ b/target/s390x/ioinst.c
> @@ -111,8 +111,6 @@ void ioinst_handle_msch(S390CPU *cpu, uint64_t reg1, uint32_t ipb)
>      SubchDev *sch;
>      SCHIB schib;
>      uint64_t addr;
> -    int ret = -ENODEV;
> -    int cc;
>      CPUS390XState *env = &cpu->env;
>      uint8_t ar;
>  
> @@ -131,24 +129,11 @@ void ioinst_handle_msch(S390CPU *cpu, uint64_t reg1, uint32_t ipb)
>      }
>      trace_ioinst_sch_id("msch", cssid, ssid, schid);
>      sch = css_find_subch(m, cssid, ssid, schid);
> -    if (sch && css_subch_visible(sch)) {
> -        ret = css_do_msch(sch, &schib);
> -    }
> -    switch (ret) {
> -    case -ENODEV:
> -        cc = 3;
> -        break;
> -    case -EBUSY:
> -        cc = 2;
> -        break;
> -    case 0:
> -        cc = 0;
> -        break;
> -    default:
> -        cc = 1;
> -        break;
> +    if (!sch || !css_subch_visible(sch)) {
> +        setcc(cpu, 3);
> +        return;
>      }
> -    setcc(cpu, cc);
> +    setcc(cpu, css_do_msch(sch, &schib));
>  }
>  
>  static void copy_orb_from_guest(ORB *dest, const ORB *src)
