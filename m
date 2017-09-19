Received: from eggs.gnu.org ([2001:4830:134:3::10]:39364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1du8Xe-0003ru-E1
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 22:45:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1du8Xb-00075H-3p
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 22:45:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37790
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1du8Xa-000758-Ts
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 22:45:39 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8J2hx5V104584
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 22:45:37 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d2n7332dq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 22:45:36 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Mon, 18 Sep 2017 22:45:36 -0400
Date: Tue, 19 Sep 2017 10:45:31 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170913115029.47626-1-pasic@linux.vnet.ibm.com>
	<20170913115029.47626-3-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170913115029.47626-3-pasic@linux.vnet.ibm.com>
Message-Id: <20170919024531.GC5274@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/4] s390x/css: use ccw data stream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

* Halil Pasic <pasic@linux.vnet.ibm.com> [2017-09-13 13:50:27 +0200]:

> Replace direct access which implicitly assumes no IDA
> or MIDA with the new ccw data stream interface which should
> cope with these transparently in the future.
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
>  hw/s390x/css.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index e8d2016563..6b0cd8861b 100644
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
> @@ -903,8 +904,8 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
>              }
>          }
>          len = MIN(ccw.count, sizeof(sch->sense_data));
> -        cpu_physical_memory_write(ccw.cda, sch->sense_data, len);
> -        sch->curr_status.scsw.count = ccw.count - len;
> +        ccw_dstream_write_buf(&sch->cds, sch->sense_data, len);
> +        sch->curr_status.scsw.count = ccw_dstream_residual_count(&sch->cds);
>          memset(sch->sense_data, 0, sizeof(sch->sense_data));
>          ret = 0;
>          break;
> @@ -930,8 +931,8 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
>          } else {
>              sense_id.reserved = 0;
>          }
> -        cpu_physical_memory_write(ccw.cda, &sense_id, len);
> -        sch->curr_status.scsw.count = ccw.count - len;
> +        ccw_dstream_write_buf(&sch->cds, &sense_id, len);
> +        sch->curr_status.scsw.count = ccw_dstream_residual_count(&sch->cds);
>          ret = 0;
>          break;
>      }
> -- 
> 2.13.5
> 

Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>

-- 
Dong Jia Shi
