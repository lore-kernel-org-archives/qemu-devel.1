Received: from eggs.gnu.org ([2001:4830:134:3::10]:54061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bala24@linux.vnet.ibm.com>) id 1fDWPp-0006xG-F9
	for qemu-devel@nongnu.org; Tue, 01 May 2018 10:38:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bala24@linux.vnet.ibm.com>) id 1fDWPk-000377-5r
	for qemu-devel@nongnu.org; Tue, 01 May 2018 10:38:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43066)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bala24@linux.vnet.ibm.com>)
	id 1fDWPj-000365-St
	for qemu-devel@nongnu.org; Tue, 01 May 2018 10:37:56 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w41Ebpdh130507
	for <qemu-devel@nongnu.org>; Tue, 1 May 2018 10:37:51 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hpsme1m67-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 01 May 2018 10:37:51 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bala24@linux.vnet.ibm.com>;
	Tue, 1 May 2018 15:37:49 +0100
Date: Tue, 1 May 2018 20:07:37 +0530
From: Balamuruhan S <bala24@linux.vnet.ibm.com>
References: <20180425071040.25542-1-bala24@linux.vnet.ibm.com>
	<20180425071040.25542-2-bala24@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425071040.25542-2-bala24@linux.vnet.ibm.com>
Message-Id: <20180501143737.GA25113@9.122.211.20>
Subject: Re: [Qemu-devel] [PATCH v3 1/1] migration: calculate
 expected_downtime with ram_bytes_remaining()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com, quintela@redhat.com, david@gibson.dropbear.id.au
Cc: qemu-devel@nongnu.org

Hi,

Dave, David and Juan if you guys are okay with the patch, please
help to merge it.

Thanks,
Bala

On Wed, Apr 25, 2018 at 12:40:40PM +0530, Balamuruhan S wrote:
> expected_downtime value is not accurate with dirty_pages_rate * page_size,
> using ram_bytes_remaining would yeild it correct. It will initially be a
> gross over-estimate, but for for non-converging migrations it should
> approach a reasonable estimate later on.
> 
> currently bandwidth and expected_downtime value are calculated in
> migration_update_counters() during each iteration from
> migration_thread(), where as remaining ram is calculated in
> qmp_query_migrate() when we actually call "info migrate". Due to this
> there is some difference in expected_downtime value being calculated.
> 
> with this patch bandwidth, expected_downtime and remaining ram are
> calculated in migration_update_counters(), retrieve the same value during
> "info migrate". By this approach we get almost close enough value.
> 
> Reported-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> Signed-off-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
> ---
>  migration/migration.c | 11 ++++++++---
>  migration/migration.h |  1 +
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 52a5092add..5d721ee481 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -614,7 +614,7 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
>      }
> 
>      if (s->state != MIGRATION_STATUS_COMPLETED) {
> -        info->ram->remaining = ram_bytes_remaining();
> +        info->ram->remaining = s->ram_bytes_remaining;
>          info->ram->dirty_pages_rate = ram_counters.dirty_pages_rate;
>      }
>  }
> @@ -2227,6 +2227,7 @@ static void migration_update_counters(MigrationState *s,
>      transferred = qemu_ftell(s->to_dst_file) - s->iteration_initial_bytes;
>      time_spent = current_time - s->iteration_start_time;
>      bandwidth = (double)transferred / time_spent;
> +    s->ram_bytes_remaining = ram_bytes_remaining();
>      s->threshold_size = bandwidth * s->parameters.downtime_limit;
> 
>      s->mbps = (((double) transferred * 8.0) /
> @@ -2237,8 +2238,12 @@ static void migration_update_counters(MigrationState *s,
>       * recalculate. 10000 is a small enough number for our purposes
>       */
>      if (ram_counters.dirty_pages_rate && transferred > 10000) {
> -        s->expected_downtime = ram_counters.dirty_pages_rate *
> -            qemu_target_page_size() / bandwidth;
> +        /*
> +         * It will initially be a gross over-estimate, but for for
> +         * non-converging migrations it should approach a reasonable estimate
> +         * later on
> +         */
> +        s->expected_downtime = s->ram_bytes_remaining / bandwidth;
>      }
> 
>      qemu_file_reset_rate_limit(s->to_dst_file);
> diff --git a/migration/migration.h b/migration/migration.h
> index 8d2f320c48..8584f8e22e 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -128,6 +128,7 @@ struct MigrationState
>      int64_t downtime_start;
>      int64_t downtime;
>      int64_t expected_downtime;
> +    int64_t ram_bytes_remaining;
>      bool enabled_capabilities[MIGRATION_CAPABILITY__MAX];
>      int64_t setup_time;
>      /*
> -- 
> 2.14.3
> 
> 
