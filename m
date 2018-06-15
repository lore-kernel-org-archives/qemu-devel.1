Received: from eggs.gnu.org ([2001:4830:134:3::10]:52862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fTlXZ-0003S1-Hz
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 06:01:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fTlXT-0001Ux-Tj
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 06:01:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46764 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fTlXT-0001Tx-Oh
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 06:01:03 -0400
Date: Fri, 15 Jun 2018 11:00:58 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180615100058.GB2615@work-vm>
References: <20180612085009.17594-1-bala24@linux.vnet.ibm.com>
	<20180612085009.17594-2-bala24@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612085009.17594-2-bala24@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 1/1] migration: calculate
 expected_downtime with ram_bytes_remaining()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Balamuruhan S <bala24@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, david@gibson.dropbear.id.au, lvivier@redhat.com

* Balamuruhan S (bala24@linux.vnet.ibm.com) wrote:
> expected_downtime value is not accurate with dirty_pages_rate * page_size,
> using ram_bytes_remaining() would yeild it resonable.
> 
> consider to read the remaining ram just after having updated the dirty
> pages count later migration_bitmap_sync_range() in migration_bitmap_sync()
> and reuse the `remaining` field in ram_counters to hold ram_bytes_remaining()
> for calculating expected_downtime.
> 
> Reported-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> Signed-off-by: Balamuruhan S <bala24@linux.vnet.ibm.com>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  migration/migration.c | 3 +--
>  migration/ram.c       | 1 +
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index ea9a6cbb87..cb14dadb26 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2739,8 +2739,7 @@ static void migration_update_counters(MigrationState *s,
>       * recalculate. 10000 is a small enough number for our purposes
>       */
>      if (ram_counters.dirty_pages_rate && transferred > 10000) {
> -        s->expected_downtime = ram_counters.dirty_pages_rate *
> -            qemu_target_page_size() / bandwidth;
> +        s->expected_downtime = ram_counters.remaining / bandwidth;
>      }
>  
>      qemu_file_reset_rate_limit(s->to_dst_file);
> diff --git a/migration/ram.c b/migration/ram.c
> index a500015a2f..a94a2b829e 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1159,6 +1159,7 @@ static void migration_bitmap_sync(RAMState *rs)
>      RAMBLOCK_FOREACH_MIGRATABLE(block) {
>          migration_bitmap_sync_range(rs, block, 0, block->used_length);
>      }
> +    ram_counters.remaining = ram_bytes_remaining();
>      rcu_read_unlock();
>      qemu_mutex_unlock(&rs->bitmap_mutex);

OK, that's interesting.
One thing to note is that migration_bitmap_sync isn't just called when
we've run out of dirty pages and need to see if there are any fresh
ones.
In the case where we hit the bandwidth limit, then we call it whenever
we go back through ram_save_pending even though the current 
remaining isn't 0 yet (it's got to be below the threshold for us to
resync) - so you may over estimate a bit?

Anyway, I  think it's worth a go;


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> -- 
> 2.14.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
