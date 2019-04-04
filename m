Received: from eggs.gnu.org ([209.51.188.92]:54449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1hC48K-0007i2-Id
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 11:18:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1hC48I-0008S3-M6
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 11:18:28 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:48252
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1hC48I-0008Qb-83
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 11:18:26 -0400
References: <20180827222322.26009-1-marcandre.lureau@redhat.com>
	<20180827222322.26009-4-marcandre.lureau@redhat.com>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <08893010-9018-65df-bbcc-56796bba5062@adacore.com>
Date: Thu, 4 Apr 2019 17:18:22 +0200
MIME-Version: 1.0
In-Reply-To: <20180827222322.26009-4-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/9] chardev: use a child source for qio
 input source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com

Hi guys,

We have some random delays with gdbstub since this commit under Windows.
Basically while debugging the next command can sometimes take more than 5
seconds while it usually tooks 30ms before. It is not target dependent I =
see
that happening with sparc, ppc, riscv, etc.. but only on Windows host.

Does that ring a bell?

Cheers,
Fred

Le 8/28/18 =C3=A0 12:23 AM, Marc-Andr=C3=A9 Lureau a =C3=A9crit=C2=A0:
> GLib child source were added with version 2.28. We can use them now
> that we bumped our requirement to 2.40.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   chardev/char-io.c | 48 +++++-----------------------------------------=
-
>   1 file changed, 5 insertions(+), 43 deletions(-)
>=20
> diff --git a/chardev/char-io.c b/chardev/char-io.c
> index f81052481a..8ced184160 100644
> --- a/chardev/char-io.c
> +++ b/chardev/char-io.c
> @@ -33,7 +33,6 @@ typedef struct IOWatchPoll {
>       IOCanReadHandler *fd_can_read;
>       GSourceFunc fd_read;
>       void *opaque;
> -    GMainContext *context;
>   } IOWatchPoll;
>  =20
>   static IOWatchPoll *io_watch_poll_from_source(GSource *source)
> @@ -55,47 +54,24 @@ static gboolean io_watch_poll_prepare(GSource *sour=
ce,
>           iwp->src =3D qio_channel_create_watch(
>               iwp->ioc, G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL);
>           g_source_set_callback(iwp->src, iwp->fd_read, iwp->opaque, NU=
LL);
> -        g_source_attach(iwp->src, iwp->context);
> -    } else {
> -        g_source_destroy(iwp->src);
> +        g_source_add_child_source(source, iwp->src);
>           g_source_unref(iwp->src);
> +    } else {
> +        g_source_remove_child_source(source, iwp->src);
>           iwp->src =3D NULL;
>       }
>       return FALSE;
>   }
>  =20
> -static gboolean io_watch_poll_check(GSource *source)
> -{
> -    return FALSE;
> -}
> -
>   static gboolean io_watch_poll_dispatch(GSource *source, GSourceFunc c=
allback,
>                                          gpointer user_data)
>   {
> -    abort();
> -}
> -
> -static void io_watch_poll_finalize(GSource *source)
> -{
> -    /* Due to a glib bug, removing the last reference to a source
> -     * inside a finalize callback causes recursive locking (and a
> -     * deadlock).  This is not a problem inside other callbacks,
> -     * including dispatch callbacks, so we call io_remove_watch_poll
> -     * to remove this source.  At this point, iwp->src must
> -     * be NULL, or we would leak it.
> -     *
> -     * This would be solved much more elegantly by child sources,
> -     * but we support older glib versions that do not have them.
> -     */
> -    IOWatchPoll *iwp =3D io_watch_poll_from_source(source);
> -    assert(iwp->src =3D=3D NULL);
> +    return G_SOURCE_CONTINUE;
>   }
>  =20
>   static GSourceFuncs io_watch_poll_funcs =3D {
>       .prepare =3D io_watch_poll_prepare,
> -    .check =3D io_watch_poll_check,
>       .dispatch =3D io_watch_poll_dispatch,
> -    .finalize =3D io_watch_poll_finalize,
>   };
>  =20
>   GSource *io_add_watch_poll(Chardev *chr,
> @@ -115,7 +91,6 @@ GSource *io_add_watch_poll(Chardev *chr,
>       iwp->ioc =3D ioc;
>       iwp->fd_read =3D (GSourceFunc) fd_read;
>       iwp->src =3D NULL;
> -    iwp->context =3D context;
>  =20
>       name =3D g_strdup_printf("chardev-iowatch-%s", chr->label);
>       g_source_set_name((GSource *)iwp, name);
> @@ -126,23 +101,10 @@ GSource *io_add_watch_poll(Chardev *chr,
>       return (GSource *)iwp;
>   }
>  =20
> -static void io_remove_watch_poll(GSource *source)
> -{
> -    IOWatchPoll *iwp;
> -
> -    iwp =3D io_watch_poll_from_source(source);
> -    if (iwp->src) {
> -        g_source_destroy(iwp->src);
> -        g_source_unref(iwp->src);
> -        iwp->src =3D NULL;
> -    }
> -    g_source_destroy(&iwp->parent);
> -}
> -
>   void remove_fd_in_watch(Chardev *chr)
>   {
>       if (chr->gsource) {
> -        io_remove_watch_poll(chr->gsource);
> +        g_source_destroy(chr->gsource);
>           chr->gsource =3D NULL;
>       }
>   }
>=20
