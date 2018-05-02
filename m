Received: from eggs.gnu.org ([2001:4830:134:3::10]:43413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fDwyn-0005kq-Tj
	for qemu-devel@nongnu.org; Wed, 02 May 2018 14:59:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fDwyl-0004ae-Cx
	for qemu-devel@nongnu.org; Wed, 02 May 2018 14:59:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33246 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fDwyl-0004aU-8U
	for qemu-devel@nongnu.org; Wed, 02 May 2018 14:59:51 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C1A834023112
	for <qemu-devel@nongnu.org>; Wed,  2 May 2018 18:59:50 +0000 (UTC)
Date: Wed, 2 May 2018 19:59:43 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180502185943.GO2679@work-vm>
References: <20180425112723.1111-1-quintela@redhat.com>
	<20180425112723.1111-14-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425112723.1111-14-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v12 13/21] migration: Calculate transferred
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
> ---
>  migration/migration.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 9b510a809a..75d30661e9 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2246,12 +2246,19 @@ static void migration_update_counters(MigrationState *s,
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
> +            + qemu_ftell(s->to_dst_file);

OK, can I just confirm, the 'multifd packets' go over the main fd, and
just the pags are going over the other fd's?  In which case this is
right; but if the headers are going over the other fd's as well then
this is wrong.

Dave

> +    } else {
> +        now = qemu_ftell(s->to_dst_file);
> +    }
> +    transferred = now - s->iteration_initial_bytes;
>      time_spent = current_time - s->iteration_start_time;
>      bandwidth = (double)transferred / time_spent;
>      s->threshold_size = bandwidth * s->parameters.downtime_limit;
> @@ -2271,7 +2278,7 @@ static void migration_update_counters(MigrationState *s,
>      qemu_file_reset_rate_limit(s->to_dst_file);
>  
>      s->iteration_start_time = current_time;
> -    s->iteration_initial_bytes = qemu_ftell(s->to_dst_file);
> +    s->iteration_initial_bytes = now;
>  
>      trace_migrate_transferred(transferred, time_spent,
>                                bandwidth, s->threshold_size);
> -- 
> 2.17.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
