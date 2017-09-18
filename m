Received: from eggs.gnu.org ([2001:4830:134:3::10]:40307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dtxeo-0005YZ-0a
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 11:08:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dtxel-0005ls-Al
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 11:08:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59594)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dtxel-0005iw-1k
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 11:08:19 -0400
References: <20170911211320.25385-1-eblake@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e4a8ad66-0f41-2e67-444a-a677106e3561@redhat.com>
Date: Mon, 18 Sep 2017 17:08:13 +0200
MIME-Version: 1.0
In-Reply-To: <20170911211320.25385-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] osdep.h: Prohibit disabling assert() in
 supported builds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, armbru@redhat.com, thuth@redhat.com, f4bug@amsat.org, peter.maydell@linaro.org

On 11/09/2017 23:13, Eric Blake wrote:
> We already have several files that knowingly require assert()
> to work, sometimes because refactoring the code for proper
> error handling has not been tackled yet; there are probably
> other files that have a similar situation but with no comments
> documenting the same.  In fact, we have places in migration
> that handle untrusted input with assertions, where disabling
> the assertions risks a worse security hole than the current
> behavior of losing the guest to SIGABRT when migration fails
> because of the assertion.  Promote our current per-file
> safety-valve to instead be project-wide, and expand it to also
> cover glib's g_assert().
>=20
> Note that we do NOT want to encourage 'assert(side-effects);'
> (that is a bad practice that prevents copy-and-paste of code to
> other projects that CAN disable assertions; plus it costs
> unnecessary reviewer mental cycles to remember whether a project
> special-cases the crippling of asserts); and we would LIKE to
> fix migration to not rely on asserts (but that takes a big code
> audit).  But in the meantime, we DO want to send a message
> that anyone that disables assertions has to tweak code in order
> to compile, making it obvious that they are taking on additional
> risk that we are not going to support.  At the same time, leave
> comments mentioning NDEBUG in files that we know still need to
> be scrubbed, so there is at least something to grep for.
>=20
> It would be possible to come up with some other mechanism for
> doing runtime checking by default, but which does not abort
> the program on failure, while leaving side effects in place
> (unlike how crippling assert() avoids even the side effects),
> perhaps under the name q_verify(); but it was not deemed worth
> the effort (developers should not have to learn a replacement
> when the standard C macro works just fine, and it would be a lot
> of churn for little gain).  The patch specifically uses #error
> rather than #warn so that a user is forced to tweak the header
> to acknowledge the issue, even when not using a -Werror
> compilation.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>=20
> ---
> v2: promote from RFC, leave NDEBUG mentioned in comments, beef up
> commit message
>=20
> I'm not sure if this would fit best as a top-level patch applied
> directly by Peter, or if it would fit through qemu-trivial, or if
> it belongs to Paolo's misc queue.  But consensus seemed to be that
> we are okay with having it.
>=20
> ---
>  include/qemu/osdep.h | 16 ++++++++++++++++
>  hw/scsi/mptsas.c     |  6 ++----
>  hw/virtio/virtio.c   |  6 ++----
>  3 files changed, 20 insertions(+), 8 deletions(-)
>=20
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 6855b94bbf..99666383b2 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -107,6 +107,22 @@ extern int daemon(int, int);
>  #include "glib-compat.h"
>  #include "qemu/typedefs.h"
>=20
> +/*
> + * We have a lot of unaudited code that may fail in strange ways, or
> + * even be a security risk during migration, if you disable assertions
> + * at compile-time.  You may comment out these safety checks if you
> + * absolutely want to disable assertion overhead, but it is not
> + * supported upstream so the risk is all yours.  Meanwhile, please
> + * submit patches to remove any side-effects inside an assertion, or
> + * fixing error handling that should use Error instead of assert.
> + */
> +#ifdef NDEBUG
> +#error building with NDEBUG is not supported
> +#endif
> +#ifdef G_DISABLE_ASSERT
> +#error building with G_DISABLE_ASSERT is not supported
> +#endif
> +
>  #ifndef O_LARGEFILE
>  #define O_LARGEFILE 0
>  #endif
> diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
> index 765ab53c34..9962286bd6 100644
> --- a/hw/scsi/mptsas.c
> +++ b/hw/scsi/mptsas.c
> @@ -1236,11 +1236,9 @@ static void *mptsas_load_request(QEMUFile *f, SC=
SIRequest *sreq)
>      n =3D qemu_get_be32(f);
>      /* TODO: add a way for SCSIBusInfo's load_request to fail,
>       * and fail migration instead of asserting here.
> -     * When we do, we might be able to re-enable NDEBUG below.
> +     * This is just one thing (there are probably more) that must be
> +     * fixed before we can allow NDEBUG compilation.
>       */
> -#ifdef NDEBUG
> -#error building with NDEBUG is not supported
> -#endif
>      assert(n >=3D 0);
>=20
>      pci_dma_sglist_init(&req->qsg, pci, n);
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 464947f76d..3129d25c00 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -1025,11 +1025,9 @@ void *qemu_get_virtqueue_element(VirtIODevice *v=
dev, QEMUFile *f, size_t sz)
>=20
>      /* TODO: teach all callers that this can fail, and return failure =
instead
>       * of asserting here.
> -     * When we do, we might be able to re-enable NDEBUG below.
> +     * This is just one thing (there are probably more) that must be
> +     * fixed before we can allow NDEBUG compilation.
>       */
> -#ifdef NDEBUG
> -#error building with NDEBUG is not supported
> -#endif
>      assert(ARRAY_SIZE(data.in_addr) >=3D data.in_num);
>      assert(ARRAY_SIZE(data.out_addr) >=3D data.out_num);
>=20


Queued, thanks.

Paolo
