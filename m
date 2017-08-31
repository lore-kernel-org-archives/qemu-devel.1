Received: from eggs.gnu.org ([2001:4830:134:3::10]:36404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dnKFM-0003S6-Bj
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 03:50:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dnKFJ-0008Ms-5u
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 03:50:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41060)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dnKFI-0008Lt-P8
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 03:50:37 -0400
References: <20170830163609.50260-1-pasic@linux.vnet.ibm.com>
	<20170830163609.50260-3-pasic@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c319f072-2a00-992a-0dcb-ad68e6aee0a0@redhat.com>
Date: Thu, 31 Aug 2017 09:50:32 +0200
MIME-Version: 1.0
In-Reply-To: <20170830163609.50260-3-pasic@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On 30.08.2017 18:36, Halil Pasic wrote:
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

I don't really like ENODEV in this case (since the device is apparently
there)... but well, since you're later change it again to set cc=3
directly, I guess the temporary ENODEV is ok.

>      }
>  
>      ret = s390_ccw_cmd_request(orb, s, sch->driver_data);
> @@ -1046,16 +1046,13 @@ static int sch_handle_start_func_passthrough(SubchDev *sch)
>          break;
>      case -ENODEV:
>          break;
> +    case -EFAULT:
> +         break;

I think you should mention this in the patch description. Why is EFAULT
suddenly handled here?

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
>      };
>  
>      return ret;
> @@ -1115,7 +1112,7 @@ static int do_subchannel_work(SubchDev *sch)
>      if (sch->do_subchannel_work) {
>          return sch->do_subchannel_work(sch);
>      } else {
> -        return -EINVAL;
> +        return -ENODEV;
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
>      }
>  }

 Thomas
