Received: from eggs.gnu.org ([2001:4830:134:3::10]:48897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1drLGj-0007Y9-VG
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 05:44:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1drLGg-00048U-QH
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 05:44:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38194)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1drLGg-00048E-JO
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 05:44:38 -0400
Date: Mon, 11 Sep 2017 11:44:34 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170911114434.78d8050b.cohuck@redhat.com>
In-Reply-To: <20170908152446.14606-3-pasic@linux.vnet.ibm.com>
References: <20170908152446.14606-1-pasic@linux.vnet.ibm.com>
	<20170908152446.14606-3-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/4] s390x/css: fix NULL handling for CCW
 addresses
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

On Fri,  8 Sep 2017 17:24:44 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> Back then in the time of df1fe5bb49 ("s390: Virtual channel subsystem
> support.", 2013-01-24) -EIO used to map to a channel-program check (via
> the default label of the switch statement).  Then 2dc95b4cac
> ("s390x/3270: 3270 data stream handling", 2016-04-01) came along
> and that changed dramatically.
> 
> Let us roll back this undesired side effect, and go back to
> channel-program check.
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Fixes: 2dc95b4cac "s390x/3270: 3270 data stream handling"
> ---
> 
> I'm not sure 0 as CCW address  it's strictly illegal. Yes 0 is an
> unlikely address for a CCW but I would appreciate a PoP reference
> clarifying this...

0 is not an address we can fetch from, I think that is enough to
trigger a channel-program check.

> 
> Another reason to not use Unix/POSIX error codes like this.
> ---
>  hw/s390x/css.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index 09f6ba0310..a44d87ab3e 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -793,7 +793,7 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
>      CCW1 ccw;
>  
>      if (!ccw_addr) {
> -        return -EIO;
> +        return -EINVAL; /* channel-program check */
>      }
>      /* Check doubleword aligned and 31 or 24 (fmt 0) bit addressable. */
>      if (ccw_addr & (sch->ccw_fmt_1 ? 0x80000007 : 0xff000007)) {

Thanks, queued.
