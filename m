Received: from eggs.gnu.org ([2001:4830:134:3::10]:47359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e4TVs-0000Ur-CQ
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 11:10:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e4TVo-0006ku-9N
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 11:10:36 -0400
Date: Tue, 17 Oct 2017 17:10:27 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171017171027.2c4abaf0.cohuck@redhat.com>
In-Reply-To: <20171017140453.51099-7-pasic@linux.vnet.ibm.com>
References: <20171017140453.51099-1-pasic@linux.vnet.ibm.com>
	<20171017140453.51099-7-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 6/7] s390x: refactor error handling for
 HSCH handler
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

On Tue, 17 Oct 2017 16:04:52 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> Simplify the error handling of the HSCH.  Let the code detecting the
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
> index 9935d48b72..b9e0329825 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -1451,28 +1451,24 @@ IOInstEnding css_do_csch(SubchDev *sch)
>      return do_subchannel_work(sch);
>  }
>  
> -int css_do_hsch(SubchDev *sch)
> +IOInstEnding css_do_hsch(SubchDev *sch)
>  {
>      SCSW *s = &sch->curr_status.scsw;
>      PMCW *p = &sch->curr_status.pmcw;
> -    int ret;
>  
>      if (~(p->flags) & (PMCW_FLAGS_MASK_DNV | PMCW_FLAGS_MASK_ENA)) {
> -        ret = -ENODEV;
> -        goto out;
> +        return IOINST_CC_NOT_OPERATIONAL;
>      }
>  
>      if (((s->ctrl & SCSW_CTRL_MASK_STCTL) == SCSW_STCTL_STATUS_PEND) ||
>          (s->ctrl & (SCSW_STCTL_PRIMARY |
>                      SCSW_STCTL_SECONDARY |
>                      SCSW_STCTL_ALERT))) {
> -        ret = -EINPROGRESS;
> -        goto out;
> +        return IOINST_CC_STATUS_PRESENT;
>      }
>  
>      if (s->ctrl & (SCSW_FCTL_HALT_FUNC | SCSW_FCTL_CLEAR_FUNC)) {
> -        ret = -EBUSY;
> -        goto out;
> +        return IOINST_CC_BUSY;
>      }
>  
>      /* Trigger the halt function. */
> @@ -1485,11 +1481,7 @@ int css_do_hsch(SubchDev *sch)
>      }
>      s->ctrl |= SCSW_ACTL_HALT_PEND;
>  
> -    do_subchannel_work(sch);
> -    ret = 0;
> -
> -out:
> -    return ret;
> +    return do_subchannel_work(sch);
>  }
>  
>  static void css_update_chnmon(SubchDev *sch)
> diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
> index f38c59c9b7..0c1efbae39 100644
> --- a/include/hw/s390x/css.h
> +++ b/include/hw/s390x/css.h
> @@ -242,7 +242,7 @@ bool css_schid_final(int m, uint8_t cssid, uint8_t ssid, uint16_t schid);
>  int css_do_msch(SubchDev *sch, const SCHIB *schib);
>  IOInstEnding css_do_xsch(SubchDev *sch);
>  IOInstEnding css_do_csch(SubchDev *sch);
> -int css_do_hsch(SubchDev *sch);
> +IOInstEnding css_do_hsch(SubchDev *sch);
>  IOInstEnding css_do_ssch(SubchDev *sch, ORB *orb);
>  int css_do_tsch_get_irb(SubchDev *sch, IRB *irb, int *irb_len);
>  void css_do_tsch_update_subch(SubchDev *sch);
> diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
> index fd659e77a5..8e4dacafd8 100644
> --- a/target/s390x/ioinst.c
> +++ b/target/s390x/ioinst.c
> @@ -78,8 +78,6 @@ void ioinst_handle_hsch(S390CPU *cpu, uint64_t reg1)
>  {
>      int cssid, ssid, schid, m;
>      SubchDev *sch;
> -    int ret = -ENODEV;
> -    int cc;
>  
>      if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
>          program_interrupt(&cpu->env, PGM_OPERAND, 4);
> @@ -87,24 +85,11 @@ void ioinst_handle_hsch(S390CPU *cpu, uint64_t reg1)
>      }
>      trace_ioinst_sch_id("hsch", cssid, ssid, schid);
>      sch = css_find_subch(m, cssid, ssid, schid);
> -    if (sch && css_subch_visible(sch)) {
> -        ret = css_do_hsch(sch);
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
> +    setcc(cpu, css_do_hsch(sch));
>  }
>  
>  static int ioinst_schib_valid(SCHIB *schib)
