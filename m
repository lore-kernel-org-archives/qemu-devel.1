Received: from eggs.gnu.org ([2001:4830:134:3::10]:54350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cWKHC-0001EL-Mg
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 04:54:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cWKH7-0005GW-Hj
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 04:54:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cWKH7-0005FC-8g
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 04:53:57 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3B9918553C
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 09:53:57 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170106182823.1960-3-dgilbert@redhat.com> (David Alan Gilbert's
	message of "Fri, 6 Jan 2017 18:28:10 +0000")
References: <20170106182823.1960-1-dgilbert@redhat.com>
	<20170106182823.1960-3-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 25 Jan 2017 10:53:50 +0100
Message-ID: <87wpdj79e9.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 02/15] postcopy: Transmit ram size summary
 word
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com, aarcange@redhat.com

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Replace the host page-size in the 'advise' command by a pagesize
> summary bitmap; if the VM is just using normal RAM then
> this will be exactly the same as before, however if they're using
> huge pages they'll be different, and thus:
>    a) Migration from/to old qemu's that don't understand huge pages
>       will fail early.
>    b) Migrations with different size RAMBlocks will also fail early.
>
> The previous block size check during RAM block transmission will also
> catch these cases, but this catches a good summary and should be
> clearer on a version mismatch.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  include/migration/migration.h |  1 +
>  migration/ram.c               | 17 +++++++++++++++++
>  migration/savevm.c            | 32 +++++++++++++++++++++-----------
>  3 files changed, 39 insertions(+), 11 deletions(-)


Hi

Why it is not enough with the previous patch where we compare than blocks
have the same page size in both ends?

I assume that issuing an madvise for block with the correct page_size
would be enough, no?

Or I am missing something obvious?

Thanks, JUan.

>
> diff --git a/include/migration/migration.h b/include/migration/migration.h
> index c309d23..0188bcf 100644
> --- a/include/migration/migration.h
> +++ b/include/migration/migration.h
> @@ -355,6 +355,7 @@ void global_state_store_running(void);
>  void flush_page_queue(MigrationState *ms);
>  int ram_save_queue_pages(MigrationState *ms, const char *rbname,
>                           ram_addr_t start, ram_addr_t len);
> +uint64_t ram_pagesize_summary(void);
>  
>  PostcopyState postcopy_state_get(void);
>  /* Set the state and return the old state */
> diff --git a/migration/ram.c b/migration/ram.c
> index 39998f5..40fe888 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -608,6 +608,23 @@ static void migration_bitmap_sync_init(void)
>      iterations_prev = 0;
>  }
>  
> +/* Returns a summary bitmap of the page sizes of all RAMBlocks;
> + * for VMs with just normal pages this is equivalent to the
> + * host page size.  If it's got some huge pages then it's the OR
> + * of all the different page sizes.
> + */
> +uint64_t ram_pagesize_summary(void)
> +{
> +    RAMBlock *block;
> +    uint64_t summary = 0;
> +
> +    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
> +        summary |= block->page_size;
> +    }
> +
> +    return summary;
> +}
> +
>  static void migration_bitmap_sync(void)
>  {
>      RAMBlock *block;
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 0363372..aaae044 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -828,7 +828,7 @@ int qemu_savevm_send_packaged(QEMUFile *f, const uint8_t *buf, size_t len)
>  void qemu_savevm_send_postcopy_advise(QEMUFile *f)
>  {
>      uint64_t tmp[2];
> -    tmp[0] = cpu_to_be64(getpagesize());
> +    tmp[0] = cpu_to_be64(ram_pagesize_summary());
>      tmp[1] = cpu_to_be64(1ul << qemu_target_page_bits());
>  
>      trace_qemu_savevm_send_postcopy_advise();
> @@ -1305,7 +1305,7 @@ static int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
>  static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis)
>  {
>      PostcopyState ps = postcopy_state_set(POSTCOPY_INCOMING_ADVISE);
> -    uint64_t remote_hps, remote_tps;
> +    uint64_t remote_pagesize_summary, local_pagesize_summary, remote_tps;
>  
>      trace_loadvm_postcopy_handle_advise();
>      if (ps != POSTCOPY_INCOMING_NONE) {
> @@ -1317,17 +1317,27 @@ static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis)
>          return -1;
>      }
>  
> -    remote_hps = qemu_get_be64(mis->from_src_file);
> -    if (remote_hps != getpagesize())  {
> +    remote_pagesize_summary = qemu_get_be64(mis->from_src_file);
> +    local_pagesize_summary = ram_pagesize_summary();
> +
> +    if (remote_pagesize_summary != local_pagesize_summary)  {
>          /*
> -         * Some combinations of mismatch are probably possible but it gets
> -         * a bit more complicated.  In particular we need to place whole
> -         * host pages on the dest at once, and we need to ensure that we
> -         * handle dirtying to make sure we never end up sending part of
> -         * a hostpage on it's own.
> +         * This detects two potential causes of mismatch:
> +         *   a) A mismatch in host page sizes
> +         *      Some combinations of mismatch are probably possible but it gets
> +         *      a bit more complicated.  In particular we need to place whole
> +         *      host pages on the dest at once, and we need to ensure that we
> +         *      handle dirtying to make sure we never end up sending part of
> +         *      a hostpage on it's own.
> +         *   b) The use of different huge page sizes on source/destination
> +         *      a more fine grain test is performed during RAM block migration
> +         *      but this test here causes a nice early clear failure, and
> +         *      also fails when passed to an older qemu that doesn't
> +         *      do huge pages.
>           */
> -        error_report("Postcopy needs matching host page sizes (s=%d d=%d)",
> -                     (int)remote_hps, getpagesize());
> +        error_report("Postcopy needs matching RAM page sizes (s=%" PRIx64
> +                                                             " d=%" PRIx64 ")",
> +                     remote_pagesize_summary, local_pagesize_summary);
>          return -1;
>      }
