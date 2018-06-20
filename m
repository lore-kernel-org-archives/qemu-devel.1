Received: from eggs.gnu.org ([2001:4830:134:3::10]:52477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fVZsi-00049C-EC
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 05:58:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fVZse-0003jC-Fw
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 05:58:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48412 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fVZse-0003it-9W
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 05:58:24 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C891F4023826
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 09:58:23 +0000 (UTC)
Date: Wed, 20 Jun 2018 10:58:19 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180620095818.GF2549@work-vm>
References: <20180620081524.5751-1-quintela@redhat.com>
	<20180620081524.5751-5-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620081524.5751-5-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v14 04/12] migration: Calculate transferred
 ram correctly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> On multifd we send data from more places that main channel.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> --
> Add placeholder for packets size
> ---
>  migration/migration.c | 12 ++++++++++--
>  migration/ram.c       |  7 +++++++
>  migration/ram.h       |  1 +
>  3 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index e1eaa97df4..224629533b 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2728,12 +2728,20 @@ static void migration_update_counters(MigrationState *s,
>  {
>      uint64_t transferred, time_spent;
>      double bandwidth;
> +    uint64_t now;
>  
>      if (current_time < s->iteration_start_time + BUFFER_DELAY) {
>          return;
>      }
>  
> -    transferred = qemu_ftell(s->to_dst_file) - s->iteration_initial_bytes;
> +    if (migrate_use_multifd()) {
> +        now = ram_counters.normal * qemu_target_page_size()
> +            + multifd_packets_size()
> +            + qemu_ftell(s->to_dst_file);
> +    } else {
> +        now = qemu_ftell(s->to_dst_file);
> +    }
> +    transferred = now - s->iteration_initial_bytes;
>      time_spent = current_time - s->iteration_start_time;
>      bandwidth = (double)transferred / time_spent;
>      s->threshold_size = bandwidth * s->parameters.downtime_limit;
> @@ -2752,7 +2760,7 @@ static void migration_update_counters(MigrationState *s,
>      qemu_file_reset_rate_limit(s->to_dst_file);
>  
>      s->iteration_start_time = current_time;
> -    s->iteration_initial_bytes = qemu_ftell(s->to_dst_file);
> +    s->iteration_initial_bytes = now;
>  
>      trace_migrate_transferred(transferred, time_spent,
>                                bandwidth, s->threshold_size);
> diff --git a/migration/ram.c b/migration/ram.c
> index d146689d3a..d7f8b0d989 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -952,6 +952,13 @@ int multifd_save_setup(void)
>      return 0;
>  }
>  
> +/* Size in bytes of the page headers */
> +int multifd_packets_size(void)
> +{
> +    /* We are not yet sending any data through channels */
> +    return 0;
> +}
> +
>  struct {
>      MultiFDRecvParams *params;
>      /* number of created threads */
> diff --git a/migration/ram.h b/migration/ram.h
> index d386f4d641..e1decb7418 100644
> --- a/migration/ram.h
> +++ b/migration/ram.h
> @@ -47,6 +47,7 @@ int multifd_load_setup(void);
>  int multifd_load_cleanup(Error **errp);
>  bool multifd_recv_all_channels_created(void);
>  void multifd_recv_new_channel(QIOChannel *ioc);
> +int multifd_packets_size(void);
>  
>  uint64_t ram_pagesize_summary(void);
>  int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len);
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
