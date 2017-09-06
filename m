Received: from eggs.gnu.org ([2001:4830:134:3::10]:46713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dpZVz-0004vj-Ha
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 08:33:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dpZVt-0004Wl-MJ
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 08:33:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dpZVt-0004WT-G5
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 08:33:01 -0400
Date: Wed, 6 Sep 2017 14:32:57 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170906143257.05f302c7.cohuck@redhat.com>
In-Reply-To: <20170905111645.18068-3-pasic@linux.vnet.ibm.com>
References: <20170905111645.18068-1-pasic@linux.vnet.ibm.com>
	<20170905111645.18068-3-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/5] s390x/css: use ccw data stream
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

On Tue,  5 Sep 2017 13:16:42 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> Replace direct access which implicitly assumes no IDA
> or MIDA with the new ccw data stream interface which should
> cope with these transparently in the future.
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
>  hw/s390x/css.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index 87d913f81c..c1bc9944e6 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -890,6 +890,7 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
>      }
>  
>      /* Look at the command. */
> +    ccw_dstream_init(&sch->cds, &ccw, &(sch->orb));
>      switch (ccw.cmd_code) {
>      case CCW_CMD_NOOP:
>          /* Nothing to do. */
> @@ -903,7 +904,7 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
>              }
>          }
>          len = MIN(ccw.count, sizeof(sch->sense_data));
> -        cpu_physical_memory_write(ccw.cda, sch->sense_data, len);
> +        ccw_dstream_write_buf(&sch->cds, sch->sense_data, len);
>          sch->curr_status.scsw.count = ccw.count - len;

ccw_dstream_residual_count()?

>          memset(sch->sense_data, 0, sizeof(sch->sense_data));
>          ret = 0;
> @@ -930,7 +931,7 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
>          } else {
>              sense_id.reserved = 0;
>          }
> -        cpu_physical_memory_write(ccw.cda, &sense_id, len);
> +        ccw_dstream_write_buf(&sch->cds, &sense_id, len);
>          sch->curr_status.scsw.count = ccw.count - len;

dito

>          ret = 0;
>          break;
