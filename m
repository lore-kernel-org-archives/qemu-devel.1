Received: from eggs.gnu.org ([2001:4830:134:3::10]:43468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1evPfA-000519-SG
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 11:48:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1evPe6-0001Ky-HE
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 11:47:00 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:39360)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1evPe2-0001G4-Qa
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 11:45:52 -0400
Received: by mail-wr0-x241.google.com with SMTP id r66so8582672wrb.6
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 08:45:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180308195811.24894-21-dgilbert@redhat.com>
References: <20180308195811.24894-1-dgilbert@redhat.com>
	<20180308195811.24894-21-dgilbert@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 12 Mar 2018 16:45:48 +0100
Message-ID: <CAJ+F1CKZL2Bm6n+HzX3Af-rL3QeQJHTsLnRoTfRt7d0WxY830g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 20/29] postcopy:
 postcopy_notify_shared_wake
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
> Add a hook to allow a client userfaultfd to be 'woken'
> when a page arrives, and a walker that calls that
> hook for relevant clients given a RAMBlock and offset.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  migration/postcopy-ram.c | 16 ++++++++++++++++
>  migration/postcopy-ram.h | 10 ++++++++++
>  2 files changed, 26 insertions(+)
>
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index d3e7f10c5a..585db9467a 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -827,6 +827,22 @@ static int qemu_ufd_copy_ioctl(int userfault_fd, voi=
d *host_addr,
>      return ret;
>  }
>
> +int postcopy_notify_shared_wake(RAMBlock *rb, uint64_t offset)
> +{
> +    int i;
> +    MigrationIncomingState *mis =3D migration_incoming_get_current();
> +    GArray *pcrfds =3D mis->postcopy_remote_fds;
> +
> +    for (i =3D 0; i < pcrfds->len; i++) {
> +        struct PostCopyFD *cur =3D &g_array_index(pcrfds, struct PostCop=
yFD, i);
> +        int ret =3D cur->waker(cur, rb, offset);
> +        if (ret) {
> +            return ret;
> +        }
> +    }
> +    return 0;
> +}
> +
>  /*
>   * Place a host page (from) at (host) atomically
>   * returns 0 on success
> diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
> index f02fa36127..fef7448e4b 100644
> --- a/migration/postcopy-ram.h
> +++ b/migration/postcopy-ram.h
> @@ -148,6 +148,10 @@ struct PostCopyFD;
>
>  /* ufd is a pointer to the struct uffd_msg *TODO: more Portable! */
>  typedef int (*pcfdhandler)(struct PostCopyFD *pcfd, void *ufd);
> +/* Notification to wake, either on place or on reception of
> + * a fault on something that's already arrived (race)
> + */
> +typedef int (*pcfdwake)(struct PostCopyFD *pcfd, RAMBlock *rb, uint64_t =
offset);
>
>  struct PostCopyFD {
>      int fd;
> @@ -155,6 +159,8 @@ struct PostCopyFD {
>      void *data;
>      /* Handler to be called whenever we get a poll event */
>      pcfdhandler handler;
> +    /* Notification to wake shared client */
> +    pcfdwake waker;
>      /* A string to use in error messages */
>      const char *idstr;
>  };
> @@ -164,6 +170,10 @@ struct PostCopyFD {
>   */
>  void postcopy_register_shared_ufd(struct PostCopyFD *pcfd);
>  void postcopy_unregister_shared_ufd(struct PostCopyFD *pcfd);
> +/* Call each of the shared 'waker's registerd telling them of
> + * availability of a block.
> + */
> +int postcopy_notify_shared_wake(RAMBlock *rb, uint64_t offset);
>  /* Notify a client ufd that a page is available
>   * Note: The 'client_address' is in the address space of the client
>   * program not QEMU
> --
> 2.14.3
>
>



--=20
Marc-Andr=C3=A9 Lureau
