Received: from eggs.gnu.org ([2001:4830:134:3::10]:46836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e4TUc-0007tC-Dc
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 11:09:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e4TUY-0005r2-9w
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 11:09:18 -0400
Date: Tue, 17 Oct 2017 17:09:09 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171017170909.0816a4c7.cohuck@redhat.com>
In-Reply-To: <20171017140453.51099-6-pasic@linux.vnet.ibm.com>
References: <20171017140453.51099-1-pasic@linux.vnet.ibm.com>
	<20171017140453.51099-6-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 5/7] s390x: refactor error handling for
 CSCH handler
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

On Tue, 17 Oct 2017 16:04:51 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> Simplify the error handling of the cSCH.  Let the code detecting the

s/cSCH/CSCH/

> condition tell (in a less ambiguous way) how it's to be handled. No
> changes in behavior.
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
>  hw/s390x/css.c         | 12 +++---------
>  include/hw/s390x/css.h |  2 +-
>  target/s390x/ioinst.c  | 14 ++++----------
>  3 files changed, 8 insertions(+), 20 deletions(-)

Looks sane (quoting the whole mail for the benefit of the qemu-s390x list).

> 
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index 1b3be7729d..9935d48b72 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -1435,26 +1435,20 @@ IOInstEnding css_do_xsch(SubchDev *sch)
>      return IOINST_CC_EXPECTED;
>  }
>  
> -int css_do_csch(SubchDev *sch)
> +IOInstEnding css_do_csch(SubchDev *sch)
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
>      /* Trigger the clear function. */
>      s->ctrl &= ~(SCSW_CTRL_MASK_FCTL | SCSW_CTRL_MASK_ACTL);
>      s->ctrl |= SCSW_FCTL_CLEAR_FUNC | SCSW_ACTL_CLEAR_PEND;
>  
> -    do_subchannel_work(sch);
> -    ret = 0;
> -
> -out:
> -    return ret;
> +    return do_subchannel_work(sch);
>  }
>  
>  int css_do_hsch(SubchDev *sch)
> diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
> index 3c319c9096..f38c59c9b7 100644
> --- a/include/hw/s390x/css.h
> +++ b/include/hw/s390x/css.h
> @@ -241,7 +241,7 @@ int css_do_stsch(SubchDev *sch, SCHIB *schib);
>  bool css_schid_final(int m, uint8_t cssid, uint8_t ssid, uint16_t schid);
>  int css_do_msch(SubchDev *sch, const SCHIB *schib);
>  IOInstEnding css_do_xsch(SubchDev *sch);
> -int css_do_csch(SubchDev *sch);
> +IOInstEnding css_do_csch(SubchDev *sch);
>  int css_do_hsch(SubchDev *sch);
>  IOInstEnding css_do_ssch(SubchDev *sch, ORB *orb);
>  int css_do_tsch_get_irb(SubchDev *sch, IRB *irb, int *irb_len);
> diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
> index 4ad07e9181..fd659e77a5 100644
> --- a/target/s390x/ioinst.c
> +++ b/target/s390x/ioinst.c
> @@ -60,8 +60,6 @@ void ioinst_handle_csch(S390CPU *cpu, uint64_t reg1)
>  {
>      int cssid, ssid, schid, m;
>      SubchDev *sch;
> -    int ret = -ENODEV;
> -    int cc;
>  
>      if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid)) {
>          program_interrupt(&cpu->env, PGM_OPERAND, 4);
> @@ -69,15 +67,11 @@ void ioinst_handle_csch(S390CPU *cpu, uint64_t reg1)
>      }
>      trace_ioinst_sch_id("csch", cssid, ssid, schid);
>      sch = css_find_subch(m, cssid, ssid, schid);
> -    if (sch && css_subch_visible(sch)) {
> -        ret = css_do_csch(sch);
> -    }
> -    if (ret == -ENODEV) {
> -        cc = 3;
> -    } else {
> -        cc = 0;
> +    if (!sch || !css_subch_visible(sch)) {
> +        setcc(cpu, 3);
> +        return;
>      }
> -    setcc(cpu, cc);
> +    setcc(cpu, css_do_csch(sch));
>  }
>  
>  void ioinst_handle_hsch(S390CPU *cpu, uint64_t reg1)
