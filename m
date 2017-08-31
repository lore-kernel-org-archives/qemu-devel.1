Received: from eggs.gnu.org ([2001:4830:134:3::10]:54015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dnLdq-0004Bo-3Q
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 05:20:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dnLdm-0008Pj-Q3
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 05:20:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dnLdm-0008PQ-HA
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 05:19:58 -0400
Date: Thu, 31 Aug 2017 11:19:53 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170831111953.242ddc28.cohuck@redhat.com>
In-Reply-To: <20170830163609.50260-3-pasic@linux.vnet.ibm.com>
References: <20170830163609.50260-1-pasic@linux.vnet.ibm.com>
	<20170830163609.50260-3-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/9] s390x: fix invalid use of cc 1 for SSCH
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

On Wed, 30 Aug 2017 18:36:02 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> According to the POP a start subchannel instruction (SSCH) returning with
> cc 1 implies that the subchannel was status pending when SSCH executed.
> 
> Due to a somewhat confusing error handling, where error codes are mapped
> to cc value, sane looking error codes result in non AR compliant
> behavior.
> 
> Let's fix this! Instead of cc 1 we use cc 3 which means device not
> operational, and is much closer to the truth in the given cases.
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Acked-by: Pierre Morel<pmorel@linux.vnet.ibm.com>
> ---
> 
> This patch turned out quite controversial. We did not reach a consensus
> during the internal review.
> 
> The most of the discussion revolved around the ORB flag which
> architecturally must be supported, but are currently not supported by
> vfio-ccw (not yet, or can't be). The idea showing the most promise for
> consensus was to handle this via device status (along the lines better a
> strange acting device than a non-conform machine) but since it's a
> radical change we decided to first discuss upstream and then do whatever
> needs to be done.
> ---
>  hw/s390x/css.c      | 15 ++++++---------
>  hw/s390x/s390-ccw.c |  2 +-
>  2 files changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index a50fb0727e..0822538cde 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -1034,7 +1034,7 @@ static int sch_handle_start_func_passthrough(SubchDev *sch)
>       */
>      if (!(orb->ctrl0 & ORB_CTRL0_MASK_PFCH) ||
>          !(orb->ctrl0 & ORB_CTRL0_MASK_C64)) {
> -        return -EINVAL;
> +        return -ENODEV;

This feels wrong. If we don't support this yet, doing something like a
channel-program check or an operand exception feels closer to the
architecture than indicating a gone device.

>      }
>  
>      ret = s390_ccw_cmd_request(orb, s, sch->driver_data);
> @@ -1046,16 +1046,13 @@ static int sch_handle_start_func_passthrough(SubchDev *sch)
>          break;
>      case -ENODEV:
>          break;
> +    case -EFAULT:
> +         break;
>      case -EACCES:
>          /* Let's reflect an inaccessible host device by cc 3. */
> -        ret = -ENODEV;
> -        break;
>      default:
> -       /*
> -        * All other return codes will trigger a program check,
> -        * or set cc to 1.
> -        */
> -       break;
> +        /* Let's make all other return codes map to cc 3.  */
> +        ret = -ENODEV;

Why? This feels wrong. For those cases where we want to signal an error
but cc 1 is conceptually wrong, either an operand exception (for very
few cases) or a channel-program check feels more in line with the
architecture.

That's a general problem with doing stuff in the hypervisor: We have
sets of internal problems that obviously don't show up in the
architecture, and we can either handle them internally or use what the
architecture offers for problem signaling. z/VM has probably faced the
same problems :)

>      };
>  
>      return ret;
> @@ -1115,7 +1112,7 @@ static int do_subchannel_work(SubchDev *sch)
>      if (sch->do_subchannel_work) {
>          return sch->do_subchannel_work(sch);
>      } else {
> -        return -EINVAL;
> +        return -ENODEV;

This rather seems like a job for an assert? If we don't have a function
for the 'asynchronous' handling of the various functions assigned for a
subchannel, that looks like an internal error.

>      }
>  }
>  
> diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
> index 8614dda6f8..2b0741741c 100644
> --- a/hw/s390x/s390-ccw.c
> +++ b/hw/s390x/s390-ccw.c
> @@ -25,7 +25,7 @@ int s390_ccw_cmd_request(ORB *orb, SCSW *scsw, void *data)
>      if (cdc->handle_request) {
>          return cdc->handle_request(orb, scsw, data);
>      } else {
> -        return -ENOSYS;
> +        return -ENODEV;

If we get here, it means that we called a request handler (which is
only done for the passthrough variety) without having assigned a
request handler beforehand. This also looks like an internal error to
me...

>      }
>  }
>  
