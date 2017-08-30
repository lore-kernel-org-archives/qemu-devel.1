Received: from eggs.gnu.org ([2001:4830:134:3::10]:52209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dmzTF-0002kp-Vj
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 05:39:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dmzTC-0006bF-O8
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 05:39:38 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:54388)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1dmzTC-0006WD-C7
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 05:39:34 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1504016587-39779-6-git-send-email-pradeep.jagadeesh@huawei.com>
References: <1504016587-39779-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1504016587-39779-6-git-send-email-pradeep.jagadeesh@huawei.com>
Date: Wed, 30 Aug 2017 11:38:43 +0200
Message-ID: <w51inh58kf0.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v8 5/6] fsdev: hmp interface for throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, eric blake <eblake@redhat.com>, greg kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

On Tue 29 Aug 2017 04:23:06 PM CEST, Pradeep Jagadeesh wrote:

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

I don't think what you're doing with the Error here is right:

   - You store the error returned by qmp_query_fsdev_io_throttle().
   - You report the error for _every_ fsdev in the list. That doesn't
     make much sense.
   - Furthermore, if there's an error then fsdev_list should be empty,
     so you're not reporting anything (and you're leaking the error).
   - Even if the list was not empty, hmp_handle_error() frees the error
     after reporting it. Therefore the second item in the list would
     try to report an error that has already been freed.

Berto
