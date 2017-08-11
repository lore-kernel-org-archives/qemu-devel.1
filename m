Received: from eggs.gnu.org ([2001:4830:134:3::10]:53539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dgFBm-0002xX-3i
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 15:01:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dgFBh-0001iO-7b
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 15:01:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dgFBg-0001h7-Vl
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 15:01:37 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D4908EA3C8
	for <qemu-devel@nongnu.org>; Fri, 11 Aug 2017 19:01:31 +0000 (UTC)
Date: Fri, 11 Aug 2017 20:01:25 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170811190125.GG2076@work-vm>
References: <20170808162629.32493-1-quintela@redhat.com>
	<20170808162629.32493-18-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170808162629.32493-18-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 17/19] migration: Rename initial_bytes
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
> Now it is called qemu_file_bytes that reflects better what it does,
> and we create qemu_file_bytes_now to not have to call qemu_ftell() twice.

Yes OK, although you could lose the 'qemu_' off the start; it's local
anyway.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/migration.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index b78dffc..974ff92 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2044,13 +2044,13 @@ static void *migration_thread(void *opaque)
>      /* Used by the bandwidth calcs, updated later */
>      int64_t initial_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>      int64_t setup_start = qemu_clock_get_ms(QEMU_CLOCK_HOST);
> -    int64_t initial_bytes = 0;
>      /*
>       * The final stage happens when the remaining data is smaller than
>       * this threshold; it's calculated from the requested downtime and
>       * measured bandwidth
>       */
>      int64_t threshold_size = 0;
> +    int64_t qemu_file_bytes = 0;
>      int64_t start_time = initial_time;
>      int64_t end_time;
>      bool old_vm_running = false;
> @@ -2138,8 +2138,9 @@ static void *migration_thread(void *opaque)
>          }
>          current_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>          if (current_time >= initial_time + BUFFER_DELAY) {
> -            uint64_t transferred_bytes = qemu_ftell(s->to_dst_file) -
> -                                         initial_bytes;
> +            uint64_t qemu_file_bytes_now = qemu_ftell(s->to_dst_file);
> +            uint64_t transferred_bytes =
> +                qemu_file_bytes_now - qemu_file_bytes;
>              uint64_t time_spent = current_time - initial_time;
>              double bandwidth = (double)transferred_bytes / time_spent;
>              threshold_size = bandwidth * s->parameters.downtime_limit;
> @@ -2158,7 +2159,7 @@ static void *migration_thread(void *opaque)
>  
>              qemu_file_reset_rate_limit(s->to_dst_file);
>              initial_time = current_time;
> -            initial_bytes = qemu_ftell(s->to_dst_file);
> +            qemu_file_bytes = qemu_file_bytes_now;
>          }
>          if (qemu_file_rate_limit(s->to_dst_file)) {
>              /* usleep expects microseconds */
> -- 
> 2.9.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
