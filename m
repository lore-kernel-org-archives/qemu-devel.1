Received: from eggs.gnu.org ([2001:4830:134:3::10]:42235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1evPeG-0004HR-Bf
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 11:47:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1evPd9-0008SK-Lt
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 11:46:01 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:50339)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1evPd9-0008Qc-6q
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 11:44:55 -0400
Received: by mail-wm0-x242.google.com with SMTP id w128so17608317wmw.0
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 08:44:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180216131625.9639-20-dgilbert@redhat.com>
References: <20180216131625.9639-1-dgilbert@redhat.com>
	<20180216131625.9639-20-dgilbert@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 12 Mar 2018 16:44:52 +0100
Message-ID: <CAJ+F1CJr-HJ2CDCNkYSRvUZebyqJVX=KUMj0V1iXQ-==h6CeYQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 19/29] postcopy: wake shared
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Maxime Coquelin <maxime.coquelin@redhat.com>, Peter Xu <peterx@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, Juan Quintela <quintela@redhat.com>

Hi

On Fri, Feb 16, 2018 at 2:16 PM, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Send a 'wake' request on a userfaultfd for a shared process.
> The address in the clients address space is specified together
> with the RAMBlock it was resolved to.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  migration/postcopy-ram.c | 26 ++++++++++++++++++++++++++
>  migration/postcopy-ram.h |  6 ++++++
>  migration/trace-events   |  1 +
>  3 files changed, 33 insertions(+)
>
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 277ff749a0..67deae7e1c 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -534,6 +534,25 @@ static int ram_block_enable_notify(const char *block=
_name, void *host_addr,
>      return 0;
>  }
>
> +int postcopy_wake_shared(struct PostCopyFD *pcfd,
> +                         uint64_t client_addr,
> +                         RAMBlock *rb)
> +{
> +    size_t pagesize =3D qemu_ram_pagesize(rb);
> +    struct uffdio_range range;
> +    int ret;
> +    trace_postcopy_wake_shared(client_addr, qemu_ram_get_idstr(rb));
> +    range.start =3D client_addr & ~(pagesize - 1);
> +    range.len =3D pagesize;
> +    ret =3D ioctl(pcfd->fd, UFFDIO_WAKE, &range);
> +    if (ret) {
> +        error_report("%s: Failed to wake: %zx in %s (%s)",
> +                     __func__, (size_t)client_addr, qemu_ram_get_idstr(r=
b),
> +                     strerror(errno));
> +    }
> +    return ret;
> +}
> +
>  /*
>   * Callback from shared fault handlers to ask for a page,
>   * the page must be specified by a RAMBlock and an offset in that rb
> @@ -951,6 +970,13 @@ void *postcopy_get_tmp_page(MigrationIncomingState *=
mis)
>      return NULL;
>  }
>
> +int postcopy_wake_shared(struct PostCopyFD *pcfd,
> +                         uint64_t client_addr,
> +                         RAMBlock *rb)
> +{
> +    assert(0);
> +    return -1;
> +}
>  #endif
>
>  /* ---------------------------------------------------------------------=
---- */
> diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
> index 4c63f20df4..2e3dd844d5 100644
> --- a/migration/postcopy-ram.h
> +++ b/migration/postcopy-ram.h
> @@ -162,6 +162,12 @@ struct PostCopyFD {
>   */
>  void postcopy_register_shared_ufd(struct PostCopyFD *pcfd);
>  void postcopy_unregister_shared_ufd(struct PostCopyFD *pcfd);
> +/* Notify a client ufd that a page is available
> + * Note: The 'client_address' is in the address space of the client
> + * program not QEMU
> + */

Any reason not to follow the classic function declaration / API
documentation style:
/**
 * func:
 * @arg: blah
 *
 * Lorem ipsum...
 */

(future documentation tooling will hopefully parse it etc)

> +int postcopy_wake_shared(struct PostCopyFD *pcfd, uint64_t client_addr,
> +                         RAMBlock *rb);
>  /* Callback from shared fault handlers to ask for a page */
>  int postcopy_request_shared_page(struct PostCopyFD *pcfd, RAMBlock *rb,
>                                   uint64_t client_addr, uint64_t offset);
> diff --git a/migration/trace-events b/migration/trace-events
> index 7c910b5479..b0acaaa8a0 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -199,6 +199,7 @@ postcopy_ram_incoming_cleanup_entry(void) ""
>  postcopy_ram_incoming_cleanup_exit(void) ""
>  postcopy_ram_incoming_cleanup_join(void) ""
>  postcopy_request_shared_page(const char *sharer, const char *rb, uint64_=
t rb_offset) "for %s in %s offset 0x%"PRIx64
> +postcopy_wake_shared(uint64_t client_addr, const char *rb) "at 0x%"PRIx6=
4" in %s"
>
>  save_xbzrle_page_skipping(void) ""
>  save_xbzrle_page_overflow(void) ""
> --
> 2.14.3
>
>



--=20
Marc-Andr=C3=A9 Lureau
