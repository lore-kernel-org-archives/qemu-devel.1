Received: from eggs.gnu.org ([2001:4830:134:3::10]:42218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ctHvj-0001mm-PG
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 14:02:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ctHvg-0002pd-LB
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 14:02:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ctHvg-0002pT-DS
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 14:02:44 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2E9BE80492
	for <qemu-devel@nongnu.org>; Wed, 29 Mar 2017 18:02:43 +0000 (UTC)
Date: Wed, 29 Mar 2017 19:02:39 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170329180239.GG2501@work-vm>
References: <20170323204544.12015-1-quintela@redhat.com>
	<20170323204544.12015-38-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170323204544.12015-38-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 37/51] ram: Move compression_switch to
 RAMState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org

* Juan Quintela (quintela@redhat.com) wrote:
> Rename it to preffer_xbzrle that is a more descriptive name.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/ram.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 6a39704..591cf89 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -217,6 +217,9 @@ struct RAMState {
>      uint64_t dirty_pages_rate;
>      /* Count of requests incoming from destination */
>      uint64_t postcopy_requests;
> +    /* Should we move to xbzrle after the 1st round
> +       of compression */
> +    bool preffer_xbzrle;

That's 'prefer' - however, do we need it at all?
How about just replacing it by:
   !ram_bulk_stage && migrate_use_xbzrle()

would that work?

Dave

>      /* protects modification of the bitmap */
>      QemuMutex bitmap_mutex;
>      /* Ram Bitmap protected by RCU */
> @@ -335,7 +338,6 @@ static QemuCond comp_done_cond;
>  /* The empty QEMUFileOps will be used by file in CompressParam */
>  static const QEMUFileOps empty_ops = { };
>  
> -static bool compression_switch;
>  static DecompressParam *decomp_param;
>  static QemuThread *decompress_threads;
>  static QemuMutex decomp_done_lock;
> @@ -419,7 +421,6 @@ void migrate_compress_threads_create(void)
>      if (!migrate_use_compression()) {
>          return;
>      }
> -    compression_switch = true;
>      thread_count = migrate_compress_threads();
>      compress_threads = g_new0(QemuThread, thread_count);
>      comp_param = g_new0(CompressParam, thread_count);
> @@ -1091,7 +1092,7 @@ static bool find_dirty_block(RAMState *rs, PageSearchStatus *pss,
>                   * point. In theory, xbzrle can do better than compression.
>                   */
>                  flush_compressed_data(rs);
> -                compression_switch = false;
> +                rs->preffer_xbzrle = true;
>              }
>          }
>          /* Didn't find anything this time, but try again on the new block */
> @@ -1323,7 +1324,7 @@ static int ram_save_target_page(RAMState *rs, MigrationState *ms,
>      /* Check the pages is dirty and if it is send it */
>      if (migration_bitmap_clear_dirty(rs, dirty_ram_abs)) {
>          unsigned long *unsentmap;
> -        if (compression_switch && migrate_use_compression()) {
> +        if (!rs->preffer_xbzrle && migrate_use_compression()) {
>              res = ram_save_compressed_page(rs, ms, pss, last_stage);
>          } else {
>              res = ram_save_page(rs, ms, pss, last_stage);
> -- 
> 2.9.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
