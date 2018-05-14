Received: from eggs.gnu.org ([2001:4830:134:3::10]:41200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fICSN-0000UV-Bh
	for qemu-devel@nongnu.org; Mon, 14 May 2018 08:20:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fICSK-0002vC-8Q
	for qemu-devel@nongnu.org; Mon, 14 May 2018 08:19:59 -0400
Date: Mon, 14 May 2018 14:19:51 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180514141951.2b349975.cohuck@redhat.com>
In-Reply-To: <20180510000712.6472-3-pasic@linux.ibm.com>
References: <20180510000712.6472-1-pasic@linux.ibm.com>
	<20180510000712.6472-3-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] vfio-ccw: remove orb.c64 (64 bit data
 addresses) check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Dong Jia Shi <bjsdjshi@linux.ibm.com>, "Jason J. Herne" <jjherne@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>

On Thu, 10 May 2018 02:07:12 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> The vfio-ccw module does the check too, and there is actually no
> technical obstacle for supporting fmt 1 idaws. Let us be ready for the
> beautiful day when fmt 1 idaws become supported by the vfio-ccw kernel
> module. QEMU does not have to do a thing for that, except not insisting
> on this check.

Yes, it makes sense to defer failing this to the kernel module.

> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> Acked-by: Jason J. Herne <jjherne@linux.ibm.com>
> Tested-by: Jason J. Herne <jjherne@linux.ibm.com>
> ---
>  hw/s390x/css.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index 32f1b2820d..1554b4c2f5 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -1191,17 +1191,6 @@ static IOInstEnding sch_handle_start_func_passthrough(SubchDev *sch)
>          assert(orb != NULL);
>          p->intparm = orb->intparm;
>      }
> -
> -    /*
> -     * Only support prefetch enable mode.
> -     * Only support 64bit addressing idal.
> -     */
> -    if (!(orb->ctrl0 & ORB_CTRL0_MASK_C64)) {
> -        warn_report("vfio-ccw requires PFCH and C64 flags set");

Ah, here you remove the message I complained about in the last patch :)

> -        sch_gen_unit_exception(sch);
> -        css_inject_io_interrupt(sch);
> -        return IOINST_CC_EXPECTED;
> -    }
>      return s390_ccw_cmd_request(sch);
>  }
>  
