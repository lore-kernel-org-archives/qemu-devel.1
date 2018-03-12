Received: from eggs.gnu.org ([2001:4830:134:3::10]:60664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1evQ18-0003OO-Of
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:09:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1evQ17-0007jP-Ql
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:09:42 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:35589)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1evQ17-0007iU-Jd
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 12:09:41 -0400
Received: by mail-wr0-x244.google.com with SMTP id n12so5125126wra.2
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 09:09:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180308195811.24894-23-dgilbert@redhat.com>
References: <20180308195811.24894-1-dgilbert@redhat.com>
	<20180308195811.24894-23-dgilbert@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 12 Mar 2018 17:09:39 +0100
Message-ID: <CAJ+F1CK1=wmUves0g=4Kg6JAE0WjUARfM3uZZox4cAMkAve7Cg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 22/29] vhost+postcopy: Call wakeups
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

On Thu, Mar 8, 2018 at 8:58 PM, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Cause the vhost-user client to be woken up whenever:
>   a) We place a page in postcopy mode
>   b) We get a fault and the page has already been received
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  migration/postcopy-ram.c | 14 ++++++++++----
>  migration/trace-events   |  1 +
>  2 files changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 585db9467a..36db900e8f 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -558,7 +558,11 @@ int postcopy_request_shared_page(struct PostCopyFD *=
pcfd, RAMBlock *rb,
>
>      trace_postcopy_request_shared_page(pcfd->idstr, qemu_ram_get_idstr(r=
b),
>                                         rb_offset);
> -    /* TODO: Check bitmap to see if we already have the page */
> +    if (ramblock_recv_bitmap_test_byte_offset(rb, aligned_rbo)) {
> +        trace_postcopy_request_shared_page_present(pcfd->idstr,
> +                                        qemu_ram_get_idstr(rb), rb_offse=
t);
> +        return postcopy_wake_shared(pcfd, client_addr, rb);
> +    }
>      if (rb !=3D mis->last_rb) {
>          mis->last_rb =3D rb;
>          migrate_send_rp_req_pages(mis, qemu_ram_get_idstr(rb),
> @@ -866,7 +870,8 @@ int postcopy_place_page(MigrationIncomingState *mis, =
void *host, void *from,
>      }
>
>      trace_postcopy_place_page(host);
> -    return 0;
> +    return postcopy_notify_shared_wake(rb,
> +                                       qemu_ram_block_host_offset(rb, ho=
st));
>  }
>
>  /*
> @@ -890,6 +895,9 @@ int postcopy_place_page_zero(MigrationIncomingState *=
mis, void *host,
>
>              return -e;
>          }
> +        return postcopy_notify_shared_wake(rb,
> +                                           qemu_ram_block_host_offset(rb=
,
> +                                                                      ho=
st));
>      } else {
>          /* The kernel can't use UFFDIO_ZEROPAGE for hugepages */
>          if (!mis->postcopy_tmp_zero_page) {
> @@ -909,8 +917,6 @@ int postcopy_place_page_zero(MigrationIncomingState *=
mis, void *host,
>          return postcopy_place_page(mis, host, mis->postcopy_tmp_zero_pag=
e,
>                                     rb);
>      }
> -
> -    return 0;
>  }
>
>  /*
> diff --git a/migration/trace-events b/migration/trace-events
> index b0acaaa8a0..1e353a317f 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -199,6 +199,7 @@ postcopy_ram_incoming_cleanup_entry(void) ""
>  postcopy_ram_incoming_cleanup_exit(void) ""
>  postcopy_ram_incoming_cleanup_join(void) ""
>  postcopy_request_shared_page(const char *sharer, const char *rb, uint64_=
t rb_offset) "for %s in %s offset 0x%"PRIx64
> +postcopy_request_shared_page_present(const char *sharer, const char *rb,=
 uint64_t rb_offset) "%s already %s offset 0x%"PRIx64
>  postcopy_wake_shared(uint64_t client_addr, const char *rb) "at 0x%"PRIx6=
4" in %s"
>
>  save_xbzrle_page_skipping(void) ""
> --
> 2.14.3
>
>



--=20
Marc-Andr=C3=A9 Lureau
