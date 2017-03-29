Received: from eggs.gnu.org ([2001:4830:134:3::10]:34897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ctHYZ-0003nO-RL
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 13:38:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ctHYW-0008KG-Nb
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 13:38:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52675)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ctHYW-0008Jq-FK
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 13:38:48 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7774E90224
	for <qemu-devel@nongnu.org>; Wed, 29 Mar 2017 17:38:47 +0000 (UTC)
Date: Wed, 29 Mar 2017 18:38:44 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170329173843.GF2501@work-vm>
References: <20170323204544.12015-1-quintela@redhat.com>
	<20170323204544.12015-27-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170323204544.12015-27-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 26/51] ram: Move bytes_transferred into
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
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/ram.c | 35 +++++++++++++++++------------------
>  1 file changed, 17 insertions(+), 18 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 090084b..872ea23 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -197,6 +197,8 @@ struct RAMState {
>      uint64_t xbzrle_overflows;
>      /* number of dirty bits in the bitmap */
>      uint64_t migration_dirty_pages;
> +    /* total number of bytes transferred */
> +    uint64_t bytes_transferred;
>      /* protects modification of the bitmap */
>      QemuMutex bitmap_mutex;
>      /* Ram Bitmap protected by RCU */
> @@ -246,6 +248,11 @@ static ram_addr_t ram_save_remaining(void)
>      return ram_state.migration_dirty_pages;
>  }
>  
> +uint64_t ram_bytes_transferred(void)
> +{
> +    return ram_state.bytes_transferred;
> +}
> +
>  /* used by the search for pages to send */
>  struct PageSearchStatus {
>      /* Current block being searched */
> @@ -870,9 +877,7 @@ static int do_compress_ram_page(QEMUFile *f, RAMBlock *block,
>      return bytes_sent;
>  }
>  
> -static uint64_t bytes_transferred;
> -
> -static void flush_compressed_data(QEMUFile *f)
> +static void flush_compressed_data(RAMState *rs, QEMUFile *f)
>  {
>      int idx, len, thread_count;
>  
> @@ -893,7 +898,7 @@ static void flush_compressed_data(QEMUFile *f)
>          qemu_mutex_lock(&comp_param[idx].mutex);
>          if (!comp_param[idx].quit) {
>              len = qemu_put_qemu_file(f, comp_param[idx].file);
> -            bytes_transferred += len;
> +            rs->bytes_transferred += len;
>          }
>          qemu_mutex_unlock(&comp_param[idx].mutex);
>      }
> @@ -989,7 +994,7 @@ static int ram_save_compressed_page(RAMState *rs, MigrationState *ms,
>           * is used to avoid resending the block name.
>           */
>          if (block != rs->last_sent_block) {
> -            flush_compressed_data(f);
> +            flush_compressed_data(rs, f);
>              pages = save_zero_page(rs, f, block, offset, p, bytes_transferred);
>              if (pages == -1) {
>                  /* Make sure the first page is sent out before other pages */
> @@ -1065,7 +1070,7 @@ static bool find_dirty_block(RAMState *rs, QEMUFile *f, PageSearchStatus *pss,
>                  /* If xbzrle is on, stop using the data compression at this
>                   * point. In theory, xbzrle can do better than compression.
>                   */
> -                flush_compressed_data(f);
> +                flush_compressed_data(rs, f);
>                  compression_switch = false;
>              }
>          }
> @@ -1448,7 +1453,7 @@ void acct_update_position(QEMUFile *f, size_t size, bool zero)
>          rs->zero_pages += pages;
>      } else {
>          rs->norm_pages += pages;
> -        bytes_transferred += size;
> +        rs->bytes_transferred += size;
>          qemu_update_position(f, size);
>      }
>  }
> @@ -1458,11 +1463,6 @@ uint64_t ram_bytes_remaining(void)
>      return ram_save_remaining() * TARGET_PAGE_SIZE;
>  }
>  
> -uint64_t ram_bytes_transferred(void)
> -{
> -    return bytes_transferred;
> -}
> -
>  uint64_t ram_bytes_total(void)
>  {
>      RAMBlock *block;
> @@ -2025,7 +2025,6 @@ static int ram_state_init(RAMState *rs)
>  
>      qemu_mutex_lock_ramlist();
>      rcu_read_lock();
> -    bytes_transferred = 0;
>      ram_state_reset(rs);
>  
>      rs->ram_bitmap = g_new0(struct RAMBitmap, 1);
> @@ -2137,7 +2136,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
>      while ((ret = qemu_file_rate_limit(f)) == 0) {
>          int pages;
>  
> -        pages = ram_find_and_save_block(rs, f, false, &bytes_transferred);
> +        pages = ram_find_and_save_block(rs, f, false, &rs->bytes_transferred);
>          /* no more pages to sent */
>          if (pages == 0) {
>              done = 1;
> @@ -2159,7 +2158,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
>          }
>          i++;
>      }
> -    flush_compressed_data(f);
> +    flush_compressed_data(rs, f);
>      rcu_read_unlock();
>  
>      /*
> @@ -2169,7 +2168,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
>      ram_control_after_iterate(f, RAM_CONTROL_ROUND);
>  
>      qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
> -    bytes_transferred += 8;
> +    rs->bytes_transferred += 8;
>  
>      ret = qemu_file_get_error(f);
>      if (ret < 0) {
> @@ -2208,14 +2207,14 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
>          int pages;
>  
>          pages = ram_find_and_save_block(rs, f, !migration_in_colo_state(),
> -                                        &bytes_transferred);
> +                                        &rs->bytes_transferred);
>          /* no more blocks to sent */
>          if (pages == 0) {
>              break;
>          }
>      }
>  
> -    flush_compressed_data(f);
> +    flush_compressed_data(rs, f);
>      ram_control_after_iterate(f, RAM_CONTROL_FINISH);
>  
>      rcu_read_unlock();
> -- 
> 2.9.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
