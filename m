Received: from eggs.gnu.org ([2001:4830:134:3::10]:56122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d3SiZ-00005H-Qq
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 15:35:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d3SiW-0005cX-Oj
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 15:35:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49054)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d3SiW-0005bv-G8
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 15:35:12 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170426183721.7482-2-dgilbert@redhat.com> (David Alan Gilbert's
	message of "Wed, 26 Apr 2017 19:37:20 +0100")
References: <20170426183721.7482-1-dgilbert@redhat.com>
	<20170426183721.7482-2-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 26 Apr 2017 21:35:06 +0200
Message-ID: <87o9vjj72t.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/2] Postcopy: Force allocation of all-zero
 precopy pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, lvivier@redhat.com, peterx@redhat.com

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> When an all-zero page is received during the precopy
> phase of a postcopy-enabled migration we must force
> allocation otherwise accesses to the page will still
> get blocked by userfault.
>
> Symptom:
>   a) If the page is accessed by a device during device-load
>     then we get a deadlock as the source finishes sending
>     all its pages but the destination device-load is still
>     paused and so doesn't clean up.
>
>   b) If the page is accessed later, then the thread will stay
>     paused until the end of migration rather than carrying on
>     running, until we release userfault at the end.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  include/migration/migration.h |  3 ++-
>  migration/ram.c               | 12 ++++++++----
>  migration/rdma.c              |  2 +-
>  3 files changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/include/migration/migration.h b/include/migration/migration.h
> index ba1a16cbc1..b47904033c 100644
> --- a/include/migration/migration.h
> +++ b/include/migration/migration.h
> @@ -265,7 +265,8 @@ uint64_t xbzrle_mig_pages_overflow(void);
>  uint64_t xbzrle_mig_pages_cache_miss(void);
>  double xbzrle_mig_cache_miss_rate(void);
>  
> -void ram_handle_compressed(void *host, uint8_t ch, uint64_t size);
> +void ram_handle_compressed(void *host, uint8_t ch, uint64_t size,
> +                           bool always_write);
>  void ram_debug_dump_bitmap(unsigned long *todump, bool expected);
>  /* For outgoing discard bitmap */
>  int ram_postcopy_send_discard_bitmap(MigrationState *ms);
> diff --git a/migration/ram.c b/migration/ram.c
> index f48664ec62..b4ed41c725 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2274,10 +2274,12 @@ static inline void *host_from_ram_block_offset(RAMBlock *block,
>   * @host: host address for the zero page
>   * @ch: what the page is filled from.  We only support zero
>   * @size: size of the zero page
> + * @always_write: Always perform the memset even if it's zero
>   */
> -void ram_handle_compressed(void *host, uint8_t ch, uint64_t size)
> +void ram_handle_compressed(void *host, uint8_t ch, uint64_t size,
> +                           bool always_write)
>  {
> -    if (ch != 0 || !is_zero_range(host, size)) {
> +    if (ch != 0 || always_write || !is_zero_range(host, size)) {
>          memset(host, ch, size);
>      }
>  }
> @@ -2514,7 +2516,8 @@ static int ram_load_postcopy(QEMUFile *f)
>          switch (flags & ~RAM_SAVE_FLAG_CONTINUE) {
>          case RAM_SAVE_FLAG_COMPRESS:
>              ch = qemu_get_byte(f);
> -            memset(page_buffer, ch, TARGET_PAGE_SIZE);
> +            ram_handle_compressed(page_buffer, ch, TARGET_PAGE_SIZE,
> +                                  true);

This is weird, if we are in postcopy, we were already doing the memset
unconditionally, so .... weird as it can be.

I agree with Andrea that if the is_zero_range() don't assure that the
page is there, it is really strange.

Can you look at utils/bufferiszero() and see what that function is doing
in power?  File is a mess of ifdefs to optimize for intel as far as I
can see.

Later, Juan.


>              if (ch) {
>                  all_zero = false;
>              }
> @@ -2664,7 +2667,8 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
>  
>          case RAM_SAVE_FLAG_COMPRESS:
>              ch = qemu_get_byte(f);
> -            ram_handle_compressed(host, ch, TARGET_PAGE_SIZE);
> +            ram_handle_compressed(host, ch, TARGET_PAGE_SIZE,
> +                                  postcopy_advised);
>              break;
>  
>          case RAM_SAVE_FLAG_PAGE:
> diff --git a/migration/rdma.c b/migration/rdma.c
> index fe0a4b5a83..07a9bd75d8 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -3164,7 +3164,7 @@ static int qemu_rdma_registration_handle(QEMUFile *f, void *opaque)
>              host_addr = block->local_host_addr +
>                              (comp->offset - block->offset);
>  
> -            ram_handle_compressed(host_addr, comp->value, comp->length);
> +            ram_handle_compressed(host_addr, comp->value, comp->length, false);
>              break;
>  
>          case RDMA_CONTROL_REGISTER_FINISHED:
