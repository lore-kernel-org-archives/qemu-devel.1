Received: from eggs.gnu.org ([2001:4830:134:3::10]:46178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1drL5m-0005Dv-Tm
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 05:33:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1drL5i-0004He-Uv
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 05:33:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1drL5i-0004HH-M1
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 05:33:18 -0400
Date: Mon, 11 Sep 2017 11:33:14 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170911113314.45ef089e.cohuck@redhat.com>
In-Reply-To: <20170908152446.14606-2-pasic@linux.vnet.ibm.com>
References: <20170908152446.14606-1-pasic@linux.vnet.ibm.com>
	<20170908152446.14606-2-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/4] s390x/css: drop data-check in
 interpretation
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

On Fri,  8 Sep 2017 17:24:43 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> The architecture says that channel-data check is indicating that
> an uncorrected storage (memory) error has been detected in regard
> to the data residing in main storage (memory) that is currently
> used for an I/O operation. The described detection is done using
> the CBC technology.
> 
> The ccw interpretation code is however generating a channel-data check
> effectively when the (device specific) ccw_cb returns -EFAULT.  In case
> of virtio-ccw devices this happens when mapping memory fails, or when a
> NULL pointer is encountered. So this behavior is not architecture
> conform.
> 
> Furthermore the best fit for these situations (null pointer, mapping a
> piece of guest memory fails) from architectural perspective the condition
> described as the channel subsystem refers to a location that is not
> available, which when encountered shall result in a channel-program
> check.
> 
> To fix this, all we have to do is to get rid of the switch case matching
> -EFAULT: the default is generating a channel-program check.
> 
> ---
> 
> Was posted as stand alone patch. See:
> http://patchwork.ozlabs.org/patch/810995/
> 
> If you are going to, *please review there*.

Countered. *Please review here*

(It makes it easier for me.)

> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>

Your s-o-b should go before the triple-dash delimiter. I can fix that
up.

> ---
>  hw/s390x/css.c | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index 901dc6a0f3..09f6ba0310 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -980,15 +980,6 @@ static void sch_handle_start_func_virtual(SubchDev *sch)
>                      SCSW_STCTL_ALERT | SCSW_STCTL_STATUS_PEND;
>              s->cpa = sch->channel_prog + 8;
>              break;
> -        case -EFAULT:
> -            /* memory problem, generate channel data check */
> -            s->ctrl &= ~SCSW_ACTL_START_PEND;
> -            s->cstat = SCSW_CSTAT_DATA_CHECK;
> -            s->ctrl &= ~SCSW_CTRL_MASK_STCTL;
> -            s->ctrl |= SCSW_STCTL_PRIMARY | SCSW_STCTL_SECONDARY |
> -                    SCSW_STCTL_ALERT | SCSW_STCTL_STATUS_PEND;
> -            s->cpa = sch->channel_prog + 8;
> -            break;
>          case -EBUSY:
>              /* subchannel busy, generate deferred cc 1 */
>              s->flags &= ~SCSW_FLAGS_MASK_CC;

Looks reasonable. Queued.
