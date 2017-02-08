Received: from eggs.gnu.org ([2001:4830:134:3::10]:59344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cbQNk-0003h3-MN
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 06:25:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cbQNh-00041R-IS
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 06:25:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53276)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cbQNh-00041J-4B
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 06:25:49 -0500
Date: Wed, 8 Feb 2017 11:25:43 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170208112542.GC2341@work-vm>
References: <1486118198-8965-1-git-send-email-ashijeetacharya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1486118198-8965-1-git-send-email-ashijeetacharya@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2] migrate: Introduce zero RAM checks to
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
Cc: thuth@redhat.com, quintela@redhat.com, amit.shah@redhat.com, berrange@redhat.com, pbonzini@redhat.com, groug@kaod.org, qemu-devel@nongnu.org

* Ashijeet Acharya (ashijeetacharya@gmail.com) wrote:
> Migration of a "none" machine with no RAM crashes abruptly as
> bitmap_new() fails and thus aborts. Instead place zero RAM checks at
> appropriate places to skip migration of RAM in this case and complete
> migration successfully for devices only.
> 
> Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>

Yes it seems to work, but there is a small bug,
if we look at:

static void ram_migration_cleanup(void *opaque)
{
    /* caller have hold iothread lock or is in a bh, so there is
     * no writing race against this migration_bitmap
     */
    struct BitmapRcu *bitmap = migration_bitmap_rcu;
    atomic_rcu_set(&migration_bitmap_rcu, NULL);
    if (bitmap) {
        memory_global_dirty_log_stop();
        call_rcu(bitmap, migration_bitmap_free, rcu);
    }


we see it doesn't cause memory_global_dirty_log_stop
if migration_bitmap_rcu is NULL; so we end up
still calling dirty_log_start in ram_save_init but
never call stop.

I suggest you change it to:

    migration_bitmap_rcu = g_new0(struct BitmapRcu, 1);
    if (ram_bytes_total()) {
        ram_bitmap_pages = last_ram_offset() >> TARGET_PAGE_BITS;
        migration_bitmap_rcu->bmap = bitmap_new(ram_bitmap_pages);
        bitmap_set(migration_bitmap_rcu->bmap, 0, ram_bitmap_pages);

The cleanup routine still causes the dirty_log_stop() then.

Dave

> ---
> Changes in v2:
> - try to migrate successfully by skipping RAM (Paolo, Greg)
> - drop the idea of erroring out and failing nicely
>  migration/ram.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index ef8fadf..2f19566 100644
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
> -    migration_bitmap_rcu = g_new0(struct BitmapRcu, 1);
> -    migration_bitmap_rcu->bmap = bitmap_new(ram_bitmap_pages);
> -    bitmap_set(migration_bitmap_rcu->bmap, 0, ram_bitmap_pages);
> +    /* Skip setting bitmap if there is no RAM */
> +    if (ram_bytes_total()) {
> +        ram_bitmap_pages = last_ram_offset() >> TARGET_PAGE_BITS;
> +        migration_bitmap_rcu = g_new0(struct BitmapRcu, 1);
> +        migration_bitmap_rcu->bmap = bitmap_new(ram_bitmap_pages);
> +        bitmap_set(migration_bitmap_rcu->bmap, 0, ram_bitmap_pages);
>  
> -    if (migrate_postcopy_ram()) {
> -        migration_bitmap_rcu->unsentmap = bitmap_new(ram_bitmap_pages);
> -        bitmap_set(migration_bitmap_rcu->unsentmap, 0, ram_bitmap_pages);
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
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
