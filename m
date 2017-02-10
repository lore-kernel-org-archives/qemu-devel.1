Received: from eggs.gnu.org ([2001:4830:134:3::10]:56109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ccCw5-0006b8-Jx
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 10:16:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ccCw2-0005hX-ER
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 10:16:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ccCw2-0005hH-8f
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 10:16:30 -0500
Date: Fri, 10 Feb 2017 15:16:25 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170210151624.GE13357@work-vm>
References: <1486564125-31366-1-git-send-email-ashijeetacharya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1486564125-31366-1-git-send-email-ashijeetacharya@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3] migrate: Introduce zero RAM checks to
 skip RAM migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ashijeet Acharya <ashijeetacharya@gmail.com>
Cc: thuth@redhat.com, quintela@redhat.com, berrange@redhat.com, pbonzini@redhat.com, groug@kaod.org, qemu-devel@nongnu.org

* Ashijeet Acharya (ashijeetacharya@gmail.com) wrote:
> Migration of a "none" machine with no RAM crashes abruptly as
> bitmap_new() fails and thus aborts. Instead place zero RAM checks at
> appropriate places to skip migration of RAM in this case and complete
> migration successfully for devices only.
> 
> Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>

Queued.

> ---
> Changes in v3:
> - handle migration cleanup appropriately (Dave)
> Changes in v2:
> - try to migrate successfully by skipping RAM (Paolo, Greg)
> - drop the idea of erroring out and failing nicely
> ---
>  migration/ram.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index ef8fadf..faff5ab 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1325,6 +1325,11 @@ static int ram_find_and_save_block(QEMUFile *f, bool last_stage,
>      ram_addr_t dirty_ram_abs; /* Address of the start of the dirty page in
>                                   ram_addr_t space */
>  
> +    /* No dirty page as there is zero RAM */
> +    if (!ram_bytes_total()) {
> +        return pages;
> +    }
> +
>      pss.block = last_seen_block;
>      pss.offset = last_offset;
>      pss.complete_round = false;
> @@ -1912,14 +1917,17 @@ static int ram_save_init_globals(void)
>      bytes_transferred = 0;
>      reset_ram_globals();
>  
> -    ram_bitmap_pages = last_ram_offset() >> TARGET_PAGE_BITS;
>      migration_bitmap_rcu = g_new0(struct BitmapRcu, 1);
> -    migration_bitmap_rcu->bmap = bitmap_new(ram_bitmap_pages);
> -    bitmap_set(migration_bitmap_rcu->bmap, 0, ram_bitmap_pages);
> -
> -    if (migrate_postcopy_ram()) {
> -        migration_bitmap_rcu->unsentmap = bitmap_new(ram_bitmap_pages);
> -        bitmap_set(migration_bitmap_rcu->unsentmap, 0, ram_bitmap_pages);
> +    /* Skip setting bitmap if there is no RAM */
> +    if (ram_bytes_total()) {
> +        ram_bitmap_pages = last_ram_offset() >> TARGET_PAGE_BITS;
> +        migration_bitmap_rcu->bmap = bitmap_new(ram_bitmap_pages);
> +        bitmap_set(migration_bitmap_rcu->bmap, 0, ram_bitmap_pages);
> +
> +        if (migrate_postcopy_ram()) {
> +            migration_bitmap_rcu->unsentmap = bitmap_new(ram_bitmap_pages);
> +            bitmap_set(migration_bitmap_rcu->unsentmap, 0, ram_bitmap_pages);
> +        }
>      }
>  
>      /*
> -- 
> 2.6.2
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
