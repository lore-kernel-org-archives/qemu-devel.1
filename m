Received: from eggs.gnu.org ([2001:4830:134:3::10]:43421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1duZso-0006jU-Q3
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 03:57:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1duZsl-0003Ry-Ht
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 03:57:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1duZsl-0003NS-9E
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 03:57:19 -0400
Date: Wed, 20 Sep 2017 08:57:03 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170920075703.GA4053@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1505375436-28439-1-git-send-email-peterx@redhat.com>
	<1505375436-28439-2-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1505375436-28439-2-git-send-email-peterx@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 01/15] char-io: fix possible race on
 IOWatchPoll
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Thu, Sep 14, 2017 at 03:50:22PM +0800, Peter Xu wrote:
> This is not a problem if we are only having one single loop thread like
> before.  However, after per-monitor thread is introduced, this is not
> true any more, and the race can happen.
>=20
> The race can be triggered with "make check -j8" sometimes:
>=20
>   qemu-system-x86_64: /root/git/qemu/chardev/char-io.c:91:
>   io_watch_poll_finalize: Assertion `iwp->src =3D=3D NULL' failed.
>=20
> This patch keeps the reference for the watch object when creating in
> io_add_watch_poll(), so that the object will never be released in the
> context main loop, especially when the context loop is running in
> another standalone thread.  Meanwhile, when we want to remove the watch
> object, we always first detach the watch object from its owner context,
> then we continue with the cleanup.
>=20
> Without this patch, calling io_remove_watch_poll() in main loop thread
> is not thread-safe, since the other per-monitor thread may be modifying
> the watch object at the same time.

This doesn't feel right to me. Why is the main loop thread doing anything
at all with the Chardev, if there is a per-monitor thread ? The Chardev
code isn't thread safe so it isn't safe to have two separate threads
accessing the same Chardev. IOW, if we want a per-monitor thread, then
we must make sure the main thread never touches that monitor's chardev
at all.  While your patch here might have avoided the assertion you
mention above, I fear this is just papering over a fundamental problem
that still exists, that can only be solved by not letting the mainloop
touch the chardev at all.

>=20
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  chardev/char-io.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>=20
> diff --git a/chardev/char-io.c b/chardev/char-io.c
> index f810524..3828c20 100644
> --- a/chardev/char-io.c
> +++ b/chardev/char-io.c
> @@ -122,7 +122,6 @@ GSource *io_add_watch_poll(Chardev *chr,
>      g_free(name);
> =20
>      g_source_attach(&iwp->parent, context);
> -    g_source_unref(&iwp->parent);
>      return (GSource *)iwp;
>  }
> =20
> @@ -131,12 +130,24 @@ static void io_remove_watch_poll(GSource *source)
>      IOWatchPoll *iwp;
> =20
>      iwp =3D io_watch_poll_from_source(source);
> +
> +    /*
> +     * Here the order of destruction really matters.  We need to first
> +     * detach the IOWatchPoll object from the context (which may still
> +     * be running in another loop thread), only after that could we
> +     * continue to operate on iwp->src, or there may be race condition
> +     * between current thread and the context loop thread.
> +     *
> +     * Let's blame the glib bug mentioned in commit 2b3167 (again) for
> +     * this extra complexity.
> +     */
> +    g_source_destroy(&iwp->parent);
>      if (iwp->src) {
>          g_source_destroy(iwp->src);
>          g_source_unref(iwp->src);
>          iwp->src =3D NULL;
>      }
> -    g_source_destroy(&iwp->parent);
> +    g_source_unref(&iwp->parent);
>  }
> =20
>  void remove_fd_in_watch(Chardev *chr)
> --=20
> 2.7.4
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
