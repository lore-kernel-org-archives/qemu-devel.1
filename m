Received: from eggs.gnu.org ([2001:4830:134:3::10]:48131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1evOzt-0006FM-7P
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 11:04:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1evOzn-00048T-5y
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 11:04:21 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:35170)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1evOzm-00047k-Sc
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 11:04:15 -0400
Received: by mail-wr0-x244.google.com with SMTP id n12so4891580wra.2
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 08:04:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180308195811.24894-18-dgilbert@redhat.com>
References: <20180308195811.24894-1-dgilbert@redhat.com>
	<20180308195811.24894-18-dgilbert@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 12 Mar 2018 16:04:13 +0100
Message-ID: <CAJ+F1CKtPE6R_jNk+C48jHwjwfriH=ujFwzCpeE5yooH+k9WCA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 17/29] vhost+postcopy: Send requests to
 source for shared pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

Hi

On Thu, Mar 8, 2018 at 8:57 PM, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Send requests back to the source for shared page requests.
>

Well, you could update the commit message to say that it introduces a
callback to be used in the following patches, as well as saving RB of
last request.

For now that patch does no functional change :)

> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  migration/migration.h    |  2 ++
>  migration/postcopy-ram.c | 32 +++++++++++++++++++++++++++++---
>  migration/postcopy-ram.h |  3 +++
>  migration/trace-events   |  2 ++
>  4 files changed, 36 insertions(+), 3 deletions(-)
>
> diff --git a/migration/migration.h b/migration/migration.h
> index d02a759331..83dc36b57a 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -49,6 +49,8 @@ struct MigrationIncomingState {
>      int       userfault_event_fd;
>      QEMUFile *to_src_file;
>      QemuMutex rp_mutex;    /* We send replies from multiple threads */
> +    /* RAMBlock of last request sent to source */
> +    RAMBlock *last_rb;
>      void     *postcopy_tmp_page;
>      void     *postcopy_tmp_zero_page;
>      /* PostCopyFD's for external userfaultfds & handlers of shared memor=
y */
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 4ab1b7d36d..83780576ca 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -525,6 +525,32 @@ static int ram_block_enable_notify(const char *block=
_name, void *host_addr,
>      return 0;
>  }
>
> +/*
> + * Callback from shared fault handlers to ask for a page,
> + * the page must be specified by a RAMBlock and an offset in that rb
> + * Note: Only for use by shared fault handlers (in fault thread)
> + */
> +int postcopy_request_shared_page(struct PostCopyFD *pcfd, RAMBlock *rb,
> +                                 uint64_t client_addr, uint64_t rb_offse=
t)
> +{
> +    size_t pagesize =3D qemu_ram_pagesize(rb);
> +    uint64_t aligned_rbo =3D rb_offset & ~(pagesize - 1);
> +    MigrationIncomingState *mis =3D migration_incoming_get_current();
> +
> +    trace_postcopy_request_shared_page(pcfd->idstr, qemu_ram_get_idstr(r=
b),
> +                                       rb_offset);
> +    /* TODO: Check bitmap to see if we already have the page */
> +    if (rb !=3D mis->last_rb) {
> +        mis->last_rb =3D rb;
> +        migrate_send_rp_req_pages(mis, qemu_ram_get_idstr(rb),
> +                                  aligned_rbo, pagesize);
> +    } else {
> +        /* Save some space */
> +        migrate_send_rp_req_pages(mis, NULL, aligned_rbo, pagesize);
> +    }
> +    return 0;
> +}
> +
>  /*
>   * Handle faults detected by the USERFAULT markings
>   */
> @@ -535,9 +561,9 @@ static void *postcopy_ram_fault_thread(void *opaque)
>      int ret;
>      size_t index;
>      RAMBlock *rb =3D NULL;
> -    RAMBlock *last_rb =3D NULL; /* last RAMBlock we sent part of */
>
>      trace_postcopy_ram_fault_thread_entry();
> +    mis->last_rb =3D NULL; /* last RAMBlock we sent part of */
>      qemu_sem_post(&mis->fault_thread_sem);
>
>      struct pollfd *pfd;
> @@ -636,8 +662,8 @@ static void *postcopy_ram_fault_thread(void *opaque)
>               * Send the request to the source - we want to request one
>               * of our host page sizes (which is >=3D TPS)
>               */
> -            if (rb !=3D last_rb) {
> -                last_rb =3D rb;
> +            if (rb !=3D mis->last_rb) {
> +                mis->last_rb =3D rb;
>                  migrate_send_rp_req_pages(mis, qemu_ram_get_idstr(rb),
>                                           rb_offset, qemu_ram_pagesize(rb=
));
>              } else {
> diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
> index c8ced3470b..d7afab07d7 100644
> --- a/migration/postcopy-ram.h
> +++ b/migration/postcopy-ram.h
> @@ -164,5 +164,8 @@ struct PostCopyFD {
>   */
>  void postcopy_register_shared_ufd(struct PostCopyFD *pcfd);
>  void postcopy_unregister_shared_ufd(struct PostCopyFD *pcfd);
> +/* Callback from shared fault handlers to ask for a page */
> +int postcopy_request_shared_page(struct PostCopyFD *pcfd, RAMBlock *rb,
> +                                 uint64_t client_addr, uint64_t offset);
>
>  #endif
> diff --git a/migration/trace-events b/migration/trace-events
> index 1e617ad7a6..7c910b5479 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -198,6 +198,8 @@ postcopy_ram_incoming_cleanup_closeuf(void) ""
>  postcopy_ram_incoming_cleanup_entry(void) ""
>  postcopy_ram_incoming_cleanup_exit(void) ""
>  postcopy_ram_incoming_cleanup_join(void) ""
> +postcopy_request_shared_page(const char *sharer, const char *rb, uint64_=
t rb_offset) "for %s in %s offset 0x%"PRIx64
> +
>  save_xbzrle_page_skipping(void) ""
>  save_xbzrle_page_overflow(void) ""
>  ram_save_iterate_big_wait(uint64_t milliconds, int iterations) "big wait=
: %" PRIu64 " milliseconds, %d iterations"
> --
> 2.14.3
>
>



--=20
Marc-Andr=C3=A9 Lureau
