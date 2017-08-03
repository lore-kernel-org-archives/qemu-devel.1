Received: from eggs.gnu.org ([2001:4830:134:3::10]:47743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ddDiB-0003sE-8j
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 06:50:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ddDi8-0004Ck-HI
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 06:50:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52110)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ddDi8-0004B3-80
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 06:50:36 -0400
Date: Thu, 3 Aug 2017 11:50:22 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170803105021.GD2076@work-vm>
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
	<1501229198-30588-23-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1501229198-30588-23-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC 22/29] migration: new message
 MIG_RP_MSG_RECV_BITMAP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

* Peter Xu (peterx@redhat.com) wrote:
> Introducing new return path message MIG_RP_MSG_RECV_BITMAP to send
> received bitmap of ramblock back to source.
> 
> This is the reply message of MIG_CMD_RECV_BITMAP, it contains not only
> the header (including the ramblock name), and it was appended with the
> whole ramblock received bitmap on the destination side.
> 
> When the source receives such a reply message (MIG_RP_MSG_RECV_BITMAP),
> it parses it, convert it to the dirty bitmap by reverting the bits.

Inverting not reverting?

> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.c  | 62 ++++++++++++++++++++++++++++++++++++++++++
>  migration/migration.h  |  2 ++
>  migration/ram.c        | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  migration/ram.h        |  2 ++
>  migration/savevm.c     |  2 +-
>  migration/trace-events |  2 ++
>  6 files changed, 143 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index e498fa4..c2b85ac 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -92,6 +92,7 @@ enum mig_rp_message_type {
>  
>      MIG_RP_MSG_REQ_PAGES_ID, /* data (start: be64, len: be32, id: string) */
>      MIG_RP_MSG_REQ_PAGES,    /* data (start: be64, len: be32) */
> +    MIG_RP_MSG_RECV_BITMAP,  /* send recved_bitmap back to source */
>  
>      MIG_RP_MSG_MAX
>  };
> @@ -450,6 +451,39 @@ void migrate_send_rp_pong(MigrationIncomingState *mis,
>      migrate_send_rp_message(mis, MIG_RP_MSG_PONG, sizeof(buf), &buf);
>  }
>  
> +void migrate_send_rp_recv_bitmap(MigrationIncomingState *mis,
> +                                 char *block_name)
> +{
> +    char buf[512];
> +    int len;
> +    int64_t res;
> +
> +    /*
> +     * First, we send the header part. It contains only the len of
> +     * idstr, and the idstr itself.
> +     */
> +    len = strlen(block_name);
> +    buf[0] = len;
> +    memcpy(buf + 1, block_name, len);
> +
> +    migrate_send_rp_message(mis, MIG_RP_MSG_RECV_BITMAP, len + 1, buf);
> +
> +    /*
> +     * Next, we dump the received bitmap to the stream.
> +     *
> +     * TODO: currently we are safe since we are the only one that is
> +     * using the to_src_file handle (fault thread is still paused),
> +     * and it's ok even not taking the mutex. However the best way is
> +     * to take the lock before sending the message header, and release
> +     * the lock after sending the bitmap.
> +     */

Should we be checking the state?

> +    qemu_mutex_lock(&mis->rp_mutex);
> +    res = ramblock_recv_bitmap_send(mis->to_src_file, block_name);
> +    qemu_mutex_unlock(&mis->rp_mutex);
> +
> +    trace_migrate_send_rp_recv_bitmap(block_name, res);

OK, that's a little unusual - I don't think we've got anywhere else
where the data for the rp_ message isn't in the call to
migrate_send_rp_message.
(Another way to structure it would be to make each message send a chunk
of bitmap; but lets stick with this structure for now)

Can you add, either here or in ramblock_recv_bitmap_send an 'end marker'
on the bitmap data; just a (non-0) known value byte that would help us
check if we had a mess where things got misaligned.

> +}
> +
>  MigrationCapabilityStatusList *qmp_query_migrate_capabilities(Error **errp)
>  {
>      MigrationCapabilityStatusList *head = NULL;
> @@ -1560,6 +1594,7 @@ static struct rp_cmd_args {
>      [MIG_RP_MSG_PONG]           = { .len =  4, .name = "PONG" },
>      [MIG_RP_MSG_REQ_PAGES]      = { .len = 12, .name = "REQ_PAGES" },
>      [MIG_RP_MSG_REQ_PAGES_ID]   = { .len = -1, .name = "REQ_PAGES_ID" },
> +    [MIG_RP_MSG_RECV_BITMAP]    = { .len = -1, .name = "RECV_BITMAP" },
>      [MIG_RP_MSG_MAX]            = { .len = -1, .name = "MAX" },
>  };
>  
> @@ -1604,6 +1639,19 @@ static bool postcopy_pause_return_path_thread(MigrationState *s)
>      return true;
>  }
>  
> +static int migrate_handle_rp_recv_bitmap(MigrationState *s, char *block_name)
> +{
> +    RAMBlock *block = qemu_ram_block_by_name(block_name);
> +
> +    if (!block) {
> +        error_report("%s: invalid block name '%s'", __func__, block_name);
> +        return -EINVAL;
> +    }
> +
> +    /* Fetch the received bitmap and refresh the dirty bitmap */
> +    return ram_dirty_bitmap_reload(s, block);
> +}
> +
>  /*
>   * Handles messages sent on the return path towards the source VM
>   *
> @@ -1709,6 +1757,20 @@ retry:
>              migrate_handle_rp_req_pages(ms, (char *)&buf[13], start, len);
>              break;
>  
> +        case MIG_RP_MSG_RECV_BITMAP:
> +            if (header_len < 1) {
> +                error_report("%s: missing block name", __func__);
> +                mark_source_rp_bad(ms);
> +                goto out;
> +            }
> +            /* Format: len (1B) + idstr (<255B). This ends the idstr. */
> +            buf[buf[0] + 1] = '\0';
> +            if (migrate_handle_rp_recv_bitmap(ms, (char *)(buf + 1))) {
> +                mark_source_rp_bad(ms);
> +                goto out;
> +            }
> +            break;
> +
>          default:
>              break;
>          }
> diff --git a/migration/migration.h b/migration/migration.h
> index 574fedd..4d38308 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -204,5 +204,7 @@ void migrate_send_rp_pong(MigrationIncomingState *mis,
>                            uint32_t value);
>  int migrate_send_rp_req_pages(MigrationIncomingState *mis, const char* rbname,
>                                ram_addr_t start, size_t len);
> +void migrate_send_rp_recv_bitmap(MigrationIncomingState *mis,
> +                                 char *block_name);
>  
>  #endif
> diff --git a/migration/ram.c b/migration/ram.c
> index 7f4cb0f..d543483 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -182,6 +182,32 @@ void ramblock_recv_bitmap_clear(void *host_addr, RAMBlock *rb)
>  }
>  
>  /*
> + * Format: bitmap_size (8 bytes) + whole_bitmap (N bytes).
> + *
> + * Returns >0 if success with sent bytes, or <0 if error.
> + */
> +int64_t ramblock_recv_bitmap_send(QEMUFile *file, char *block_name)
> +{
> +    RAMBlock *block = qemu_ram_block_by_name(block_name);
> +    uint64_t size;
> +
> +    /* We should have made sure that the block exists */
> +    assert(block);

Best not to make it assert; just make it fail - the block name is
coming off the wire anyway.
(Also can we make it a const char *block_name)

> +    /* Size of the bitmap, in bytes */
> +    size = (block->max_length >> TARGET_PAGE_BITS) / 8;
> +    qemu_put_be64(file, size);
> +    qemu_put_buffer(file, (const uint8_t *)block->receivedmap, size);

Do we need to be careful about endianness and length of long here?
The migration stream can (theoretically) migrate between hosts of
different endianness, e.g. a Power LE and Power BE host it can also
migrate between a 32bit and 64bit host where the 'long' used in our
bitmap is a different length.
I think that means you have to save it as a series of long's;
and also just make sure 'size' is a multiple of 'long' - otherwise
you lose the last few bytes, which on a big endian system would
be a problem.

Also, should we be using 'max_length' or 'used_length' - ram_save_setup
stores the used_length.  I don't think we should be accessing outside
the used_length?  That might also make the thing about 'size' being
rounded to a 'long' more interesting; maybe need to check you don't use
the bits outside the used_length.

> +    qemu_fflush(file);
> +
> +    if (qemu_file_get_error(file)) {
> +        return qemu_file_get_error(file);
> +    }
> +
> +    return sizeof(size) + size;

I think since size is always sent as a 64bit that's  size + 8.

> +}
> +
> +/*
>   * An outstanding page request, on the source, having been received
>   * and queued
>   */
> @@ -2705,6 +2731,54 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
>      return ret;
>  }
>  
> +/*
> + * Read the received bitmap, revert it as the initial dirty bitmap.
> + * This is only used when the postcopy migration is paused but wants
> + * to resume from a middle point.
> + */
> +int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block)
> +{
> +    QEMUFile *file = s->rp_state.from_dst_file;
> +    uint64_t local_size = (block->max_length >> TARGET_PAGE_BITS) / 8;
> +    uint64_t size;
> +
> +    if (s->state != MIGRATION_STATUS_POSTCOPY_RECOVER) {
> +        error_report("%s: incorrect state %s", __func__,
> +                     MigrationStatus_lookup[s->state]);
> +        return -EINVAL;
> +    }
> +
> +    size = qemu_get_be64(file);
> +
> +    /* The size of the bitmap should match with our ramblock */
> +    if (size != local_size) {
> +        error_report("%s: ramblock '%s' bitmap size mismatch "
> +                     "(0x%lx != 0x%lx)", __func__, block->idstr,
> +                     size, local_size);
> +        return -EINVAL;
> +    }

Coming back to the used_length thing above;  again I think the rule
is that the used_length has to match not the max_length.

> +    /*
> +     * We are still during migration (though paused). The dirty bitmap
> +     * won't change.  We can directly modify it.
> +     */
> +    size = qemu_get_buffer(file, (uint8_t *)block->bmap, local_size);
> +
> +    if (qemu_file_get_error(file)) {
> +        return qemu_file_get_error(file);
> +    }
> +
> +    /*
> +     * What we received is "received bitmap". Revert it as the initial
> +     * dirty bitmap for this ramblock.
> +     */
> +    bitmap_invert(block->bmap, block->max_length >> TARGET_PAGE_BITS);
> +
> +    trace_ram_dirty_bitmap_reload(block->idstr);
> +
> +    return 0;
> +}
> +
>  static SaveVMHandlers savevm_ram_handlers = {
>      .save_setup = ram_save_setup,
>      .save_live_iterate = ram_save_iterate,
> diff --git a/migration/ram.h b/migration/ram.h
> index 84e8623..86eb973 100644
> --- a/migration/ram.h
> +++ b/migration/ram.h
> @@ -58,5 +58,7 @@ void ramblock_recv_bitmap_set(void *host_addr, RAMBlock *rb);
>  void ramblock_recv_bitmap_set_range(RAMBlock *rb, void *host_addr,
>                                      size_t len);
>  void ramblock_recv_bitmap_clear(void *host_addr, RAMBlock *rb);
> +int64_t ramblock_recv_bitmap_send(QEMUFile *file, char *block_name);
> +int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *rb);
>  
>  #endif
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 0ab13c0..def9213 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1755,7 +1755,7 @@ static int loadvm_handle_recv_bitmap(MigrationIncomingState *mis,
>          return -EINVAL;
>      }
>  
> -    /* TODO: send the bitmap back to source */
> +    migrate_send_rp_recv_bitmap(mis, block_name);
>  
>      return 0;
>  }
> diff --git a/migration/trace-events b/migration/trace-events
> index ca7b43f..ed69551 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -77,6 +77,7 @@ ram_load_postcopy_loop(uint64_t addr, int flags) "@%" PRIx64 " %x"
>  ram_postcopy_send_discard_bitmap(void) ""
>  ram_save_page(const char *rbname, uint64_t offset, void *host) "%s: offset: %" PRIx64 " host: %p"
>  ram_save_queue_pages(const char *rbname, size_t start, size_t len) "%s: start: %zx len: %zx"
> +ram_dirty_bitmap_reload(char *str) "%s"
>  
>  # migration/migration.c
>  await_return_path_close_on_source_close(void) ""
> @@ -88,6 +89,7 @@ migrate_fd_cancel(void) ""
>  migrate_handle_rp_req_pages(const char *rbname, size_t start, size_t len) "in %s at %zx len %zx"
>  migrate_pending(uint64_t size, uint64_t max, uint64_t post, uint64_t nonpost) "pending size %" PRIu64 " max %" PRIu64 " (post=%" PRIu64 " nonpost=%" PRIu64 ")"
>  migrate_send_rp_message(int msg_type, uint16_t len) "%d: len %d"
> +migrate_send_rp_recv_bitmap(char *name, int64_t size) "block '%s' size 0x%"PRIi64
>  migration_completion_file_err(void) ""
>  migration_completion_postcopy_end(void) ""
>  migration_completion_postcopy_end_after_complete(void) ""
> -- 
> 2.7.4

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
