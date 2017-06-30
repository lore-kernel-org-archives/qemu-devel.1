Received: from eggs.gnu.org ([2001:4830:134:3::10]:40301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQs17-00068p-1L
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 05:15:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dQs13-0001vy-SC
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 05:15:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59380)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dQs13-0001uw-LT
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 05:15:05 -0400
Date: Fri, 30 Jun 2017 10:14:59 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170630091458.GA2132@work-vm>
References: <1498749056-38565-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1498749056-38565-5-git-send-email-pradeep.jagadeesh@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1498749056-38565-5-git-send-email-pradeep.jagadeesh@huawei.com>
Subject: Re: [Qemu-devel] [PATCH v6 4/6] hmp: create a throttle
 initialization function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>
Cc: eric blake <eblake@redhat.com>, greg kurz <groug@kaod.org>, Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, alberto garcia <berto@igalia.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

* Pradeep Jagadeesh (pradeepkiruvale@gmail.com) wrote:
> This patch creates a throttle initialization function to maximize the
> code reusability. The same code is also used by fsdev.
> 
> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>

Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  hmp.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/hmp.c b/hmp.c
> index 8c72c58..220d301 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -1749,20 +1749,29 @@ void hmp_change(Monitor *mon, const QDict *qdict)
>      hmp_handle_error(mon, &err);
>  }
>  
> +static void hmp_initialize_io_throttle(IOThrottle *iot, const QDict *qdict)
> +{
> +    iot->has_id = true;
> +    iot->id = (char *) qdict_get_str(qdict, "id");
> +    iot->bps = qdict_get_int(qdict, "bps");
> +    iot->bps_rd = qdict_get_int(qdict, "bps_rd");
> +    iot->bps_wr = qdict_get_int(qdict, "bps_wr");
> +    iot->iops = qdict_get_int(qdict, "iops");
> +    iot->iops_rd = qdict_get_int(qdict, "iops_rd");
> +    iot->iops_wr = qdict_get_int(qdict, "iops_wr");
> +}
> +
>  void hmp_block_set_io_throttle(Monitor *mon, const QDict *qdict)
>  {
>      Error *err = NULL;
> +    IOThrottle *iothrottle;
>      BlockIOThrottle throttle = {
>          .has_device = true,
>          .device = (char *) qdict_get_str(qdict, "device"),
> -        .bps = qdict_get_int(qdict, "bps"),
> -        .bps_rd = qdict_get_int(qdict, "bps_rd"),
> -        .bps_wr = qdict_get_int(qdict, "bps_wr"),
> -        .iops = qdict_get_int(qdict, "iops"),
> -        .iops_rd = qdict_get_int(qdict, "iops_rd"),
> -        .iops_wr = qdict_get_int(qdict, "iops_wr"),
>      };
>  
> +    iothrottle = qapi_BlockIOThrottle_base(&throttle);
> +    hmp_initialize_io_throttle(iothrottle, qdict);
>      qmp_block_set_io_throttle(&throttle, &err);
>      hmp_handle_error(mon, &err);
>  }
> -- 
> 1.8.3.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
