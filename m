Received: from eggs.gnu.org ([2001:4830:134:3::10]:60501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e08GI-0001yd-Tw
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 11:40:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e08GG-0006vs-Ap
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 11:40:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55490)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e08GG-0006v1-1U
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 11:40:32 -0400
Date: Thu, 5 Oct 2017 16:40:23 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171005154023.GJ12106@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171005152856.6166-1-berrange@redhat.com>
	<CAJ+F1C+t+1Zf8CTsWMddS6WP4jFXDUqex_wa9kJtZW-VkzgEvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1C+t+1Zf8CTsWMddS6WP4jFXDUqex_wa9kJtZW-VkzgEvg@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] char: don't skip client cleanup if
 'connected' flag is unset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On Thu, Oct 05, 2017 at 05:35:39PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Thu, Oct 5, 2017 at 5:28 PM, Daniel P. Berrange <berrange@redhat.com=
> wrote:
> > The tcp_chr_free_connection & tcp_chr_disconnect methods both
> > skip all of their cleanup work unless the 's->connected' flag
> > is set.  This flag is set when the incoming client connection
> > is ready to use. Crucially this is *after* the TLS handshake
> > has been completed. So if the TLS handshake fails and we try
> > to cleanup the failed client, all the cleanup is skipped as
> > 's->connected' is still false.
> >
> > The only important thing that should be skipped in this case
> > is sending of the CHR_EVENT_CLOSED, because we never got as
> > far as sending the corresponding CHR_EVENT_OPENED. Every other
> > bit of cleanup can be robust against being called even when
> > s->connected is false.
> >
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  chardev/char-socket.c | 31 +++++++++++++++++--------------
> >  1 file changed, 17 insertions(+), 14 deletions(-)
> >
> > diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> > index e65148fe97..a34d4d72c2 100644
> > --- a/chardev/char-socket.c
> > +++ b/chardev/char-socket.c
> > @@ -332,10 +332,6 @@ static void tcp_chr_free_connection(Chardev *chr=
)
> >      SocketChardev *s =3D SOCKET_CHARDEV(chr);
> >      int i;
> >
> > -    if (!s->connected) {
> > -        return;
> > -    }
> > -
> >      if (s->read_msgfds_num) {
> >          for (i =3D 0; i < s->read_msgfds_num; i++) {
> >              close(s->read_msgfds[i]);
> > @@ -347,10 +343,14 @@ static void tcp_chr_free_connection(Chardev *ch=
r)
> >
> >      tcp_set_msgfds(chr, NULL, 0);
> >      remove_fd_in_watch(chr);
> > -    object_unref(OBJECT(s->sioc));
> > -    s->sioc =3D NULL;
> > -    object_unref(OBJECT(s->ioc));
> > -    s->ioc =3D NULL;
> > +    if (s->sioc) {
> > +        object_unref(OBJECT(s->sioc));
> > +        s->sioc =3D NULL;
> > +    }
> > +    if (s->ioc) {
> > +        object_unref(OBJECT(s->ioc));
> > +        s->ioc =3D NULL;
> > +    }
>=20
> object_unref() and OBJECT() are null-safe.
>=20
> >      g_free(chr->filename);
> >      chr->filename =3D NULL;
> >      s->connected =3D 0;
> > @@ -394,22 +394,25 @@ static void update_disconnected_filename(Socket=
Chardev *s)
> >                                           s->is_listen, s->is_telnet)=
;
> >  }
> >
> > +/* NB may be called even if tcp_chr_connect has not been
> > + * reached, due to TLS or telnet initialization failure,
> > + * so can *not* assume s->connected =3D=3D true
> > + */
> >  static void tcp_chr_disconnect(Chardev *chr)
> >  {
> >      SocketChardev *s =3D SOCKET_CHARDEV(chr);
> > -
> > -    if (!s->connected) {
> > -        return;
> > -    }
> > +    bool emitClose =3D s->connected;
>=20
> ewh, which code style do you pick today? :)

Which bit don't you like ?  The 'bool' or the camelCase, or both ?


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
