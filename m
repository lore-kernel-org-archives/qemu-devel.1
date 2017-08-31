Received: from eggs.gnu.org ([2001:4830:134:3::10]:32778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dnMCP-0007ZV-ER
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 05:55:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dnMCL-0006KS-VG
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 05:55:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34730)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dnMCL-0006Jr-KE
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 05:55:41 -0400
Date: Thu, 31 Aug 2017 11:55:35 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170831115535.1e4201d3.cohuck@redhat.com>
In-Reply-To: <20170830163609.50260-5-pasic@linux.vnet.ibm.com>
References: <20170830163609.50260-1-pasic@linux.vnet.ibm.com>
	<20170830163609.50260-5-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/9] s390x: refactor error handling for
 SSCH and RSCH
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

On Wed, 30 Aug 2017 18:36:04 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> Simplify the error handling of the SSCH and RSCH handler avoiding
> arbitrary and cryptic error codes being mapped to what a subchannel is
> supposed to do.  Let the code detecting the condition tell how it's to be
> handled in a less ambiguous way.  It's best to handle SSCH and RSCH in
> one go as the emulation of the two shares a lot of code.

So determining the return code at the point in time where we can
instead of trying to map to return codes and back again makes quite a
bit of sense, but I'll have to look at the rest of this. For one thing,
would a better split to introduce the cc-reporting infrastructure first
and then convert the different I/O functions?

> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Acked-by: Pierre Morel<pmorel@linux.vnet.ibm.com>
> 
> ---
> Notes:
> Funny, we had a different swich-case for SSCH and RSCH. For
> virtual it did not matter, but for passtrough it could. In practice
> -EINVAL from the kernel would have been mapped to cc 2 in case of
> RSCH and to cc 1 in case of SSHC which is absurd. Same goes for
> -EBUSY from kernel which is correctly mapped to cc 2 in case of
> SSCH, but for RSCH it gets mapped to cc 1 which is also absurd.
> ---
>  hw/s390x/css.c              | 86 ++++++++++++++-------------------------------
>  hw/s390x/s390-ccw.c         |  8 ++---
>  hw/vfio/ccw.c               | 32 +++++++++++++----
>  include/hw/s390x/css.h      | 30 ++++++++++++----
>  include/hw/s390x/s390-ccw.h |  2 +-
>  target/s390x/ioinst.c       | 61 +++++++++-----------------------
>  6 files changed, 97 insertions(+), 122 deletions(-)
> 
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index bc47bf5b20..1102642c10 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -1015,12 +1015,11 @@ static void sch_handle_start_func_virtual(SubchDev *sch)
>  
>  }
>  
> -static int sch_handle_start_func_passthrough(SubchDev *sch)
> +static void sch_handle_start_func_passthrough(SubchDev *sch)
>  {
>  
>      PMCW *p = &sch->curr_status.pmcw;
>      SCSW *s = &sch->curr_status.scsw;
> -    int ret;
>  
>      ORB *orb = &sch->orb;
>      if (!(s->ctrl & SCSW_ACTL_SUSP)) {
> @@ -1034,28 +1033,10 @@ static int sch_handle_start_func_passthrough(SubchDev *sch)
>       */
>      if (!(orb->ctrl0 & ORB_CTRL0_MASK_PFCH) ||
>          !(orb->ctrl0 & ORB_CTRL0_MASK_C64)) {
> -        return -ENODEV;
> +        sch->iret.cc = 3;

Same as already commented: I don't think cc 3 is a good match.

>      }
>  
> -    ret = s390_ccw_cmd_request(orb, s, sch->driver_data);
> -    switch (ret) {
> -    /* Currently we don't update control block and just return the cc code. */
> -    case 0:
> -        break;
> -    case -EBUSY:
> -        break;
> -    case -ENODEV:
> -        break;
> -    case -EFAULT:
> -         break;
> -    case -EACCES:
> -        /* Let's reflect an inaccessible host device by cc 3. */
> -    default:
> -        /* Let's make all other return codes map to cc 3.  */
> -        ret = -ENODEV;
> -    };
> -
> -    return ret;
> +    s390_ccw_cmd_request(sch);

As you change the handling anyway: Don't change this logic in prior
patches?

>  }
>  
>  /*
> @@ -1064,7 +1045,7 @@ static int sch_handle_start_func_passthrough(SubchDev *sch)
>   * read/writes) asynchronous later on if we start supporting more than
>   * our current very simple devices.
>   */
> -int do_subchannel_work_virtual(SubchDev *sch)
> +void do_subchannel_work_virtual(SubchDev *sch)
>  {
>  
>      SCSW *s = &sch->curr_status.scsw;
> @@ -1078,41 +1059,35 @@ int do_subchannel_work_virtual(SubchDev *sch)
>          sch_handle_start_func_virtual(sch);
>      } else {
>          /* Cannot happen. */
> -        return -ENODEV;
> +        sch->iret.cc = 3;

See comment for the last patch.

>      }
>      css_inject_io_interrupt(sch);
> -    return 0;
>  }
>  
> -int do_subchannel_work_passthrough(SubchDev *sch)
> +void do_subchannel_work_passthrough(SubchDev *sch)
>  {
> -    int ret;
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
>      } else if (s->ctrl & SCSW_FCTL_START_FUNC) {
> -        ret = sch_handle_start_func_passthrough(sch);
> +        sch_handle_start_func_passthrough(sch);
>      } else {
>          /* Cannot happen. */
> -        return -ENODEV;
> +        sch->iret.cc = 3;

ftcl == 0 should have been rejected already by the function handlers
here as well, shouldn't it?

>      }
> -
> -    return ret;
>  }
>  
> -static int do_subchannel_work(SubchDev *sch)
> +static void do_subchannel_work(SubchDev *sch)
>  {
>      if (sch->do_subchannel_work) {
> -        return sch->do_subchannel_work(sch);
> +        sch->do_subchannel_work(sch);
>      } else {
> -        return -ENODEV;
> +        sch->iret.cc = 3;

See my comment for a prior patch.

>      }
>  }
>  

(...)

> diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
> index 5c5fe6b202..d093181a9e 100644
> --- a/include/hw/s390x/css.h
> +++ b/include/hw/s390x/css.h
> @@ -94,13 +94,31 @@ struct SubchDev {
>      /* transport-provided data: */
>      int (*ccw_cb) (SubchDev *, CCW1);
>      void (*disable_cb)(SubchDev *);
> -    int (*do_subchannel_work) (SubchDev *);
> +    void (*do_subchannel_work) (SubchDev *);
>      SenseId id;
>      void *driver_data;
> +    /* io instructions conclude according to iret */
> +    struct {
> +        /*
> +         * General semantic of cc codes of IO instructions is (brief):
> +         * 0 -- produced expected result
> +         * 1 -- produced alternate result
> +         * 2 -- ineffective, because busy with previously initiated function
> +         * 3 -- ineffective, not operational

I'm not sure you can summarize this that way in all cases.

Also, what does "ineffective" mean? If I get a cc 1 for, say, ssch, I
don't expect something either as the subchannel was already status
pending.

> +         */
> +        uint32_t cc:4;
> +        bool pgm_chk:1;

This looks weird?

> +        uint32_t irq_code;
> +    } iret;
>  };
>  
>  extern const VMStateDescription vmstate_subch_dev;

(...)

> @@ -238,33 +236,17 @@ void ioinst_handle_ssch(S390CPU *cpu, uint64_t reg1, uint32_t ipb)
>      }
>      trace_ioinst_sch_id("ssch", cssid, ssid, schid);
>      sch = css_find_subch(m, cssid, ssid, schid);
> -    if (sch && css_subch_visible(sch)) {
> -        ret = css_do_ssch(sch, &orb);
> +    if (!sch || !css_subch_visible(sch)) {
> +        setcc(cpu, 3);
> +        return;
>      }
> -    switch (ret) {
> -    case -ENODEV:
> -        cc = 3;
> -        break;
> -    case -EBUSY:
> -        cc = 2;
> -        break;
> -    case -EFAULT:
> -        /*
> -         * TODO:
> -         * I'm wondering whether there is something better
> -         * to do for us here (like setting some device or
> -         * subchannel status).
> -         */

You removed the TODO :(

There still might be a better way to reflect this...

> -        program_interrupt(env, PGM_ADDRESSING, 4);
> +    css_subch_clear_iret(sch);
> +    css_do_ssch(sch, &orb);
> +    if (sch->iret.pgm_chk) {
> +        program_interrupt(env, sch->iret.irq_code, 4);
>          return;
> -    case 0:
> -        cc = 0;
> -        break;
> -    default:
> -        cc = 1;
> -        break;
>      }
> -    setcc(cpu, cc);
> +    setcc(cpu, sch->iret.cc);
>  }
>  
>  void ioinst_handle_stcrw(S390CPU *cpu, uint32_t ipb)
