Received: from eggs.gnu.org ([2001:4830:134:3::10]:55435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duxaT-0001sI-5a
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 05:16:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duxaP-0007pm-Ve
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 05:16:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46312)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1duxaP-0007pC-PS
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 05:15:57 -0400
Date: Thu, 21 Sep 2017 11:15:52 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170921111552.41167e80.cohuck@redhat.com>
In-Reply-To: <20170920172314.102710-2-pasic@linux.vnet.ibm.com>
References: <20170920172314.102710-1-pasic@linux.vnet.ibm.com>
	<20170920172314.102710-2-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] s390x/3270: IDA support for 3270 via
 CcwDataStream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Wed, 20 Sep 2017 19:23:13 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> Let us convert the 3270 code so it uses the recently introduced
> CcwDataStream abstraction instead of blindly assuming direct data access.
> 
> This patch does not change behavior beyond introducing IDA support: for
> direct data access CCWs everything stays as-is. (If there are bugs, they
> are also preserved).
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> ---
>  hw/char/terminal3270.c      | 18 +++++++++++-------
>  hw/s390x/3270-ccw.c         |  4 ++--
>  include/hw/s390x/3270-ccw.h |  5 ++---
>  3 files changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/char/terminal3270.c b/hw/char/terminal3270.c
> index 28f599111d..c976a63cc2 100644
> --- a/hw/char/terminal3270.c
> +++ b/hw/char/terminal3270.c
> @@ -182,14 +182,18 @@ static void terminal_init(EmulatedCcw3270Device *dev, Error **errp)
>                               terminal_read, chr_event, NULL, t, NULL, true);
>  }
>  
> -static int read_payload_3270(EmulatedCcw3270Device *dev, uint32_t cda,
> -                             uint16_t count)
> +static inline CcwDataStream *get_cds(Terminal3270 *t)
> +{
> +    return &(CCW_DEVICE(&t->cdev)->sch->cds);
> +}
> +
> +static int read_payload_3270(EmulatedCcw3270Device *dev)
>  {
>      Terminal3270 *t = TERMINAL_3270(dev);
>      int len;
>  
> -    len = MIN(count, t->in_len);
> -    cpu_physical_memory_write(cda, t->inv, len);
> +    len = MIN(ccw_dstream_avail(get_cds(t)), t->in_len);
> +    ccw_dstream_write_buf(get_cds(t), t->inv, len);

CCW_DEVICE() as called by get_cds() goes through qom, which implies a
bit of overhead. Not sure if it makes sense to cache it in this
function so you don't go through it multiple times. (Dito for the other
callback.)

>      t->in_len -= len;
>  
>      return len;

Looks good.
