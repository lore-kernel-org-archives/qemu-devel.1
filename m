Received: from eggs.gnu.org ([2001:4830:134:3::10]:37200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dShot-0007Pc-CR
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 06:46:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dShoo-00038D-O1
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 06:46:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47376)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dShoo-00036C-ET
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 06:46:02 -0400
Date: Wed, 5 Jul 2017 11:45:56 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170705104555.GA2284@work-vm>
References: <1499182263-19139-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1499182263-19139-6-git-send-email-pradeep.jagadeesh@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1499182263-19139-6-git-send-email-pradeep.jagadeesh@huawei.com>
Subject: Re: [Qemu-devel] [PATCH v7 5/6] fsdev: hmp interface for throttling
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
> This patch introduces hmp interfaces for the fsdev
> devices.
> 
> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>

Yes I think that's better;

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  hmp-commands-info.hx | 18 +++++++++++++++
>  hmp-commands.hx      | 19 ++++++++++++++++
>  hmp.c                | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  hmp.h                |  4 ++++
>  4 files changed, 103 insertions(+)
> 
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index ae16901..5e4ea51 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -84,6 +84,24 @@ STEXI
>  Show block device statistics.
>  ETEXI
>  
> +#if defined(CONFIG_VIRTFS)
> +
> +    {
> +        .name       = "fsdev_iothrottle",
> +        .args_type  = "",
> +        .params     = "",
> +        .help       = "show fsdev iothrottle information",
> +        .cmd        = hmp_info_fsdev_iothrottle,
> +    },
> +
> +#endif
> +
> +STEXI
> +@item info fsdev_iothrottle
> +@findex fsdev_iothrottle
> +Show fsdev device throttle info.
> +ETEXI
> +
>      {
>          .name       = "block-jobs",
>          .args_type  = "",
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index e763606..b7eb9a6 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -1662,6 +1662,25 @@ STEXI
>  Change I/O throttle limits for a block drive to @var{bps} @var{bps_rd} @var{bps_wr} @var{iops} @var{iops_rd} @var{iops_wr}
>  ETEXI
>  
> +#if defined(CONFIG_VIRTFS)
> +
> +    {
> +        .name       = "fsdev_set_io_throttle",
> +        .args_type  = "device:B,bps:l,bps_rd:l,bps_wr:l,iops:l,iops_rd:l,iops_wr:l",
> +        .params     = "device bps bps_rd bps_wr iops iops_rd iops_wr",
> +        .help       = "change I/O throttle limits for a fs devices",
> +        .cmd        = hmp_fsdev_set_io_throttle,
> +    },
> +
> +#endif
> +
> +STEXI
> +@item fsdev_set_io_throttle @var{device} @var{bps} @var{bps_rd} @var{bps_wr} @var{iops} @var{iops_rd} @var{iops_wr}
> +@findex fsdev_set_io_throttle
> +Change I/O throttle limits for a fs devices to @var{bps} @var{bps_rd} @var{bps_wr} @var{iops} @var{iops_rd} @var{iops_wr}
> +ETEXI
> +
> +
>      {
>          .name       = "set_password",
>          .args_type  = "protocol:s,password:s,connected:s?",
> diff --git a/hmp.c b/hmp.c
> index 3f76073..97014d4 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -1774,6 +1774,68 @@ void hmp_block_set_io_throttle(Monitor *mon, const QDict *qdict)
>      hmp_handle_error(mon, &err);
>  }
>  
> +#ifdef CONFIG_VIRTFS
> +
> +void hmp_fsdev_set_io_throttle(Monitor *mon, const QDict *qdict)
> +{
> +    Error *err = NULL;
> +    IOThrottle throttle = {
> +        .has_id = true,
> +        .id = (char *) qdict_get_str(qdict, "device"),
> +    };
> +
> +    hmp_initialize_io_throttle(&throttle, qdict);
> +    qmp_fsdev_set_io_throttle(&throttle, &err);
> +    hmp_handle_error(mon, &err);
> +}
> +
> +static void print_fsdev_throttle_config(Monitor *mon, IOThrottle *fscfg,
> +                                       Error *err)
> +{
> +    monitor_printf(mon, "%s", fscfg->id);
> +    monitor_printf(mon, "    I/O throttling:"
> +                   " bps=%" PRId64
> +                   " bps_rd=%" PRId64  " bps_wr=%" PRId64
> +                   " bps_max=%" PRId64
> +                   " bps_rd_max=%" PRId64
> +                   " bps_wr_max=%" PRId64
> +                   " iops=%" PRId64 " iops_rd=%" PRId64
> +                   " iops_wr=%" PRId64
> +                   " iops_max=%" PRId64
> +                   " iops_rd_max=%" PRId64
> +                   " iops_wr_max=%" PRId64
> +                   " iops_size=%" PRId64
> +                   "\n",
> +                   fscfg->bps,
> +                   fscfg->bps_rd,
> +                   fscfg->bps_wr,
> +                   fscfg->bps_max,
> +                   fscfg->bps_rd_max,
> +                   fscfg->bps_wr_max,
> +                   fscfg->iops,
> +                   fscfg->iops_rd,
> +                   fscfg->iops_wr,
> +                   fscfg->iops_max,
> +                   fscfg->iops_rd_max,
> +                   fscfg->iops_wr_max,
> +                   fscfg->iops_size);
> +   hmp_handle_error(mon, &err);
> +}
> +
> +void hmp_info_fsdev_iothrottle(Monitor *mon, const QDict *qdict)
> +{
> +    Error *err = NULL;
> +    IOThrottleList *fsdev_list, *info;
> +    fsdev_list = qmp_query_fsdev_io_throttle(&err);
> +
> +    for (info = fsdev_list; info; info = info->next) {
> +        print_fsdev_throttle_config(mon, info->value, err);
> +    }
> +    qapi_free_IOThrottleList(fsdev_list);
> +}
> +
> +#endif
> +
>  void hmp_block_stream(Monitor *mon, const QDict *qdict)
>  {
>      Error *error = NULL;
> diff --git a/hmp.h b/hmp.h
> index d8b94ce..dbf024d 100644
> --- a/hmp.h
> +++ b/hmp.h
> @@ -81,6 +81,10 @@ void hmp_set_password(Monitor *mon, const QDict *qdict);
>  void hmp_expire_password(Monitor *mon, const QDict *qdict);
>  void hmp_eject(Monitor *mon, const QDict *qdict);
>  void hmp_change(Monitor *mon, const QDict *qdict);
> +#ifdef CONFIG_VIRTFS
> +void hmp_fsdev_set_io_throttle(Monitor *mon, const QDict *qdict);
> +void hmp_info_fsdev_iothrottle(Monitor *mon, const QDict *qdict);
> +#endif
>  void hmp_block_set_io_throttle(Monitor *mon, const QDict *qdict);
>  void hmp_block_stream(Monitor *mon, const QDict *qdict);
>  void hmp_block_job_set_speed(Monitor *mon, const QDict *qdict);
> -- 
> 1.8.3.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
