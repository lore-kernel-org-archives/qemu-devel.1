Received: from eggs.gnu.org ([2001:4830:134:3::10]:35500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dvLmN-0007oK-Rc
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 07:05:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dvLmJ-00089r-Kv
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 07:05:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49890)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dvLmJ-00089M-AE
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 07:05:51 -0400
Date: Fri, 22 Sep 2017 12:05:42 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170922110542.GD2620@work-vm>
References: <1504081950-2528-1-git-send-email-peterx@redhat.com>
	<1504081950-2528-21-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1504081950-2528-21-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 20/33] migration: new message
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
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

* Peter Xu (peterx@redhat.com) wrote:
> Introducing new return path message MIG_RP_MSG_RECV_BITMAP to send
> received bitmap of ramblock back to source.
> 
> This is the reply message of MIG_CMD_RECV_BITMAP, it contains not only
> the header (including the ramblock name), and it was appended with the
> whole ramblock received bitmap on the destination side.
> 
> When the source receives such a reply message (MIG_RP_MSG_RECV_BITMAP),
> it parses it, convert it to the dirty bitmap by inverting the bits.
> 
> One thing to mention is that, when we send the recv bitmap, we are doing
> these things in extra:
> 
> - converting the bitmap to little endian, to support when hosts are
>   using different endianess on src/dst.
> 
> - do proper alignment for 8 bytes, to support when hosts are using
>   different word size (32/64 bits) on src/dst.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.c  |  68 ++++++++++++++++++++++++
>  migration/migration.h  |   2 +
>  migration/ram.c        | 141 +++++++++++++++++++++++++++++++++++++++++++++++++
>  migration/ram.h        |   3 ++
>  migration/savevm.c     |   2 +-
>  migration/trace-events |   2 +
>  6 files changed, 217 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 1370c70..625f19a 100644
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
> @@ -449,6 +450,45 @@ void migrate_send_rp_pong(MigrationIncomingState *mis,
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
> +    if (mis->state != MIGRATION_STATUS_POSTCOPY_RECOVER) {
> +        error_report("%s: MSG_RP_RECV_BITMAP only used for recovery",
> +                     __func__);
> +        return;
> +    }
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
> +    qemu_mutex_lock(&mis->rp_mutex);
> +    res = ramblock_recv_bitmap_send(mis->to_src_file, block_name);
> +    qemu_mutex_unlock(&mis->rp_mutex);
> +
> +    trace_migrate_send_rp_recv_bitmap(block_name, res);
> +}
> +
>  MigrationCapabilityStatusList *qmp_query_migrate_capabilities(Error **errp)
>  {
>      MigrationCapabilityStatusList *head = NULL;
> @@ -1572,6 +1612,7 @@ static struct rp_cmd_args {
>      [MIG_RP_MSG_PONG]           = { .len =  4, .name = "PONG" },
>      [MIG_RP_MSG_REQ_PAGES]      = { .len = 12, .name = "REQ_PAGES" },
>      [MIG_RP_MSG_REQ_PAGES_ID]   = { .len = -1, .name = "REQ_PAGES_ID" },
> +    [MIG_RP_MSG_RECV_BITMAP]    = { .len = -1, .name = "RECV_BITMAP" },
>      [MIG_RP_MSG_MAX]            = { .len = -1, .name = "MAX" },
>  };
>  
> @@ -1616,6 +1657,19 @@ static bool postcopy_pause_return_path_thread(MigrationState *s)
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
> @@ -1721,6 +1775,20 @@ retry:
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
> index b78b9bd..4051379 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -202,5 +202,7 @@ void migrate_send_rp_pong(MigrationIncomingState *mis,
>                            uint32_t value);
>  int migrate_send_rp_req_pages(MigrationIncomingState *mis, const char* rbname,
>                                ram_addr_t start, size_t len);
> +void migrate_send_rp_recv_bitmap(MigrationIncomingState *mis,
> +                                 char *block_name);
>  
>  #endif
> diff --git a/migration/ram.c b/migration/ram.c
> index 7e20097..5d938e3 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -182,6 +182,70 @@ void ramblock_recv_bitmap_clear(RAMBlock *rb, void *host_addr)
>      clear_bit(ramblock_recv_bitmap_offset(host_addr, rb), rb->receivedmap);
>  }
>  
> +#define  RAMBLOCK_RECV_BITMAP_ENDING  (0x0123456789abcdefULL)
> +
> +/*
> + * Format: bitmap_size (8 bytes) + whole_bitmap (N bytes).
> + *
> + * Returns >0 if success with sent bytes, or <0 if error.
> + */
> +int64_t ramblock_recv_bitmap_send(QEMUFile *file,
> +                                  const char *block_name)
> +{
> +    RAMBlock *block = qemu_ram_block_by_name(block_name);
> +    unsigned long *le_bitmap, nbits;
> +    uint64_t size;
> +
> +    if (!block) {
> +        error_report("%s: invalid block name: %s", __func__, block_name);
> +        return -1;
> +    }
> +
> +    nbits = block->used_length >> TARGET_PAGE_BITS;
> +
> +    /*
> +     * Make sure the tmp bitmap buffer is big enough, e.g., on 32bit
> +     * machines we may need 4 more bytes for padding (see below
> +     * comment). So extend it a bit before hand.
> +     */
> +    le_bitmap = bitmap_new(nbits + BITS_PER_LONG);

I do worry what will happen on really huge RAMBlocks; the worst case is
that this temporary bitmap is a few GB.

> +    /*
> +     * Always use little endian when sending the bitmap. This is
> +     * required that when source and destination VMs are not using the
> +     * same endianess. (Note: big endian won't work.)
> +     */
> +    bitmap_to_le(le_bitmap, block->receivedmap, nbits);
> +
> +    /* Size of the bitmap, in bytes */
> +    size = nbits / 8;
> +
> +    /*
> +     * size is always aligned to 8 bytes for 64bit machines, but it
> +     * may not be true for 32bit machines. We need this padding to
> +     * make sure the migration can survive even between 32bit and
> +     * 64bit machines.
> +     */
> +    size = ROUND_UP(size, 8);
> +
> +    qemu_put_be64(file, size);
> +    qemu_put_buffer(file, (const uint8_t *)le_bitmap, size);
> +    /*
> +     * Mark as an end, in case the middle part is screwed up due to
> +     * some "misterious" reason.
> +     */
> +    qemu_put_be64(file, RAMBLOCK_RECV_BITMAP_ENDING);
> +    qemu_fflush(file);
> +
> +    free(le_bitmap);
> +
> +    if (qemu_file_get_error(file)) {
> +        return qemu_file_get_error(file);
> +    }
> +
> +    return size + sizeof(size);
> +}
> +
>  /*
>   * An outstanding page request, on the source, having been received
>   * and queued
> @@ -2706,6 +2770,83 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
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
> +    int ret = -EINVAL;
> +    QEMUFile *file = s->rp_state.from_dst_file;
> +    unsigned long *le_bitmap, nbits = block->used_length >> TARGET_PAGE_BITS;
> +    uint64_t local_size = nbits / 8;
> +    uint64_t size, end_mark;
> +
> +    if (s->state != MIGRATION_STATUS_POSTCOPY_RECOVER) {
> +        error_report("%s: incorrect state %s", __func__,
> +                     MigrationStatus_lookup[s->state]);
> +        return -EINVAL;
> +    }
> +
> +    /*
> +     * Note: see comments in ramblock_recv_bitmap_send() on why we
> +     * need the endianess convertion, and the paddings.
> +     */
> +    local_size = ROUND_UP(local_size, 8);
> +
> +    /* Add addings */
> +    le_bitmap = bitmap_new(nbits + BITS_PER_LONG);
> +
> +    size = qemu_get_be64(file);
> +
> +    /* The size of the bitmap should match with our ramblock */
> +    if (size != local_size) {
> +        error_report("%s: ramblock '%s' bitmap size mismatch "
> +                     "(0x%lx != 0x%lx)", __func__, block->idstr,
> +                     size, local_size);

You need to use PRIx64 formatters there - %lx isn't portable.

> +        ret = -EINVAL;
> +        goto out;
> +    }
> +
> +    size = qemu_get_buffer(file, (uint8_t *)le_bitmap, local_size);
> +    end_mark = qemu_get_be64(file);
> +
> +    ret = qemu_file_get_error(file);
> +    if (ret || size != local_size) {
> +        error_report("%s: read bitmap failed for ramblock '%s': %d",
> +                     __func__, block->idstr, ret);

You might like to include size/local_size in the error.

> +        ret = -EIO;
> +        goto out;
> +    }
> +
> +    if (end_mark != RAMBLOCK_RECV_BITMAP_ENDING) {
> +        error_report("%s: ramblock '%s' end mark incorrect: 0x%"PRIu64,
> +                     __func__, block->idstr, end_mark);
> +        ret = -EINVAL;
> +        goto out;
> +    }
> +
> +    /*
> +     * Endianess convertion. We are during postcopy (though paused).
                        >>s

Dave

> +     * The dirty bitmap won't change. We can directly modify it.
> +     */
> +    bitmap_from_le(block->bmap, le_bitmap, nbits);
> +
> +    /*
> +     * What we received is "received bitmap". Revert it as the initial
> +     * dirty bitmap for this ramblock.
> +     */
> +    bitmap_complement(block->bmap, block->bmap, nbits);
> +
> +    trace_ram_dirty_bitmap_reload(block->idstr);
> +
> +    ret = 0;
> +out:
> +    free(le_bitmap);
> +    return ret;
> +}
> +
>  static SaveVMHandlers savevm_ram_handlers = {
>      .save_setup = ram_save_setup,
>      .save_live_iterate = ram_save_iterate,
> diff --git a/migration/ram.h b/migration/ram.h
> index 4db9922..bd4b8ba 100644
> --- a/migration/ram.h
> +++ b/migration/ram.h
> @@ -57,5 +57,8 @@ int ramblock_recv_bitmap_test(RAMBlock *rb, void *host_addr);
>  void ramblock_recv_bitmap_set(RAMBlock *rb, void *host_addr);
>  void ramblock_recv_bitmap_set_range(RAMBlock *rb, void *host_addr, size_t nr);
>  void ramblock_recv_bitmap_clear(RAMBlock *rb, void *host_addr);
> +int64_t ramblock_recv_bitmap_send(QEMUFile *file,
> +                                  const char *block_name);
> +int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *rb);
>  
>  #endif
> diff --git a/migration/savevm.c b/migration/savevm.c
> index f532ca0..7f77a31 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1766,7 +1766,7 @@ static int loadvm_handle_recv_bitmap(MigrationIncomingState *mis,
>          return -EINVAL;
>      }
>  
> -    /* TODO: send the bitmap back to source */
> +    migrate_send_rp_recv_bitmap(mis, block_name);
>  
>      trace_loadvm_handle_recv_bitmap(block_name);
>  
> diff --git a/migration/trace-events b/migration/trace-events
> index c5f7e41..9960cd8 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -78,6 +78,7 @@ ram_load_postcopy_loop(uint64_t addr, int flags) "@%" PRIx64 " %x"
>  ram_postcopy_send_discard_bitmap(void) ""
>  ram_save_page(const char *rbname, uint64_t offset, void *host) "%s: offset: 0x%" PRIx64 " host: %p"
>  ram_save_queue_pages(const char *rbname, size_t start, size_t len) "%s: start: 0x%zx len: 0x%zx"
> +ram_dirty_bitmap_reload(char *str) "%s"
>  
>  # migration/migration.c
>  await_return_path_close_on_source_close(void) ""
> @@ -89,6 +90,7 @@ migrate_fd_cancel(void) ""
>  migrate_handle_rp_req_pages(const char *rbname, size_t start, size_t len) "in %s at 0x%zx len 0x%zx"
>  migrate_pending(uint64_t size, uint64_t max, uint64_t post, uint64_t nonpost) "pending size %" PRIu64 " max %" PRIu64 " (post=%" PRIu64 " nonpost=%" PRIu64 ")"
>  migrate_send_rp_message(int msg_type, uint16_t len) "%d: len %d"
> +migrate_send_rp_recv_bitmap(char *name, int64_t size) "block '%s' size 0x%"PRIi64
>  migration_completion_file_err(void) ""
>  migration_completion_postcopy_end(void) ""
>  migration_completion_postcopy_end_after_complete(void) ""
> -- 
> 2.7.4
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
