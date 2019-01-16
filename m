Received: from eggs.gnu.org ([209.51.188.92]:49538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gjhZr-0005kg-Ru
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 04:33:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gjhZq-0002mY-Gd
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 04:33:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gjhZq-0002Hb-5N
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 04:33:38 -0500
Date: Wed, 16 Jan 2019 09:33:11 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190116093311.GD20275@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190115145256.9593-1-berrange@redhat.com>
	<20190115145256.9593-5-berrange@redhat.com>
	<CAMxuvazF37LX1a-KRmSy+==Rg8jOJ-57kYvORASkoP04qbjTjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMxuvazF37LX1a-KRmSy+==Rg8jOJ-57kYvORASkoP04qbjTjQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/12] chardev: remove many local variables
 in qemu_chr_parse_socket
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, Yongji Xie <elohimes@gmail.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Jan 15, 2019 at 11:18:21PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Tue, Jan 15, 2019 at 6:53 PM Daniel P. Berrang=C3=A9 <berrange@redha=
t.com> wrote:
> >
> > Now that all validation is separated off into a separate method,
> > we can directly populate the ChardevSocket struct from the
> > QemuOpts values, avoiding many local variables.
> >
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> >  chardev/char-socket.c | 40 ++++++++++++++++++----------------------
> >  1 file changed, 18 insertions(+), 22 deletions(-)
> >
> > diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> > index 233f16f72d..ba86284ea9 100644
> > --- a/chardev/char-socket.c
> > +++ b/chardev/char-socket.c
> > @@ -1186,18 +1186,10 @@ error:
> >  static void qemu_chr_parse_socket(QemuOpts *opts, ChardevBackend *ba=
ckend,
> >                                    Error **errp)
> >  {
> > -    bool is_listen      =3D qemu_opt_get_bool(opts, "server", false)=
;
> > -    bool is_waitconnect =3D is_listen && qemu_opt_get_bool(opts, "wa=
it", true);
> > -    bool is_telnet      =3D qemu_opt_get_bool(opts, "telnet", false)=
;
> > -    bool is_tn3270      =3D qemu_opt_get_bool(opts, "tn3270", false)=
;
> > -    bool is_websock     =3D qemu_opt_get_bool(opts, "websocket", fal=
se);
> > -    bool do_nodelay     =3D !qemu_opt_get_bool(opts, "delay", true);
> > -    int64_t reconnect   =3D qemu_opt_get_number(opts, "reconnect", 0=
);
> >      const char *path =3D qemu_opt_get(opts, "path");
> >      const char *host =3D qemu_opt_get(opts, "host");
> >      const char *port =3D qemu_opt_get(opts, "port");
> >      const char *fd =3D qemu_opt_get(opts, "fd");
> > -    const char *tls_creds =3D qemu_opt_get(opts, "tls-creds");
> >      SocketAddressLegacy *addr;
> >      ChardevSocket *sock;
> >
> > @@ -1216,26 +1208,30 @@ static void qemu_chr_parse_socket(QemuOpts *o=
pts, ChardevBackend *backend,
> >      sock =3D backend->u.socket.data =3D g_new0(ChardevSocket, 1);
> >      qemu_chr_parse_common(opts, qapi_ChardevSocket_base(sock));
> >
> > -    sock->has_nodelay =3D true;
> > -    sock->nodelay =3D do_nodelay;
> > +    sock->has_nodelay =3D qemu_opt_get(opts, "delay");
> > +    sock->nodelay =3D !qemu_opt_get_bool(opts, "delay", true);
> > +    /*
> > +     * We have different default to QMP for 'server', hence
> > +     * we can't just check for existance of 'server'
> > +     */
> >      sock->has_server =3D true;
> > -    sock->server =3D is_listen;
> > -    sock->has_telnet =3D true;
> > -    sock->telnet =3D is_telnet;
> > -    sock->has_tn3270 =3D true;
> > -    sock->tn3270 =3D is_tn3270;
> > -    sock->has_websocket =3D true;
> > -    sock->websocket =3D is_websock;
> > +    sock->server =3D qemu_opt_get_bool(opts, "server", false);
> > +    sock->has_telnet =3D qemu_opt_get(opts, "telnet");
> > +    sock->telnet =3D qemu_opt_get_bool(opts, "telnet", false);
> > +    sock->has_tn3270 =3D qemu_opt_get(opts, "tn3270");
> > +    sock->tn3270 =3D qemu_opt_get_bool(opts, "tn3270", false);
> > +    sock->has_websocket =3D qemu_opt_get(opts, "websocket");
> > +    sock->websocket =3D qemu_opt_get_bool(opts, "websocket", false);
> >      /*
> >       * We have different default to QMP for 'wait' when 'server'
> >       * is set, hence we can't just check for existance of 'wait'
> >       */
> > -    sock->has_wait =3D qemu_opt_find(opts, "wait") || is_listen;
> > -    sock->wait =3D is_waitconnect;
> > +    sock->has_wait =3D qemu_opt_find(opts, "wait") || sock->server;
> > +    sock->wait =3D qemu_opt_get_bool(opts, "wait", true);
>=20
> That changes slightly the behaviour, since wait was not parsed before
> when !is_listen.
>
> Since we are "correcting" (breaking?) things anyway in previous patches=
 too:

Yes, in the !is_listen case, the previous patch will see has_wait =3D=3D =
true
and raise an error.  So this patch is not a change in behaviour wrt the
previous patch, but the series as a whole is a change in behaviour due to
reporting errors for bad "wait" usage in clients.


> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> >      sock->has_reconnect =3D qemu_opt_find(opts, "reconnect");
> > -    sock->reconnect =3D reconnect;
> > -    sock->has_tls_creds =3D tls_creds;
> > -    sock->tls_creds =3D g_strdup(tls_creds);
> > +    sock->reconnect =3D qemu_opt_get_number(opts, "reconnect", 0);
> > +    sock->has_tls_creds =3D qemu_opt_get(opts, "tls-creds");
> > +    sock->tls_creds =3D g_strdup(qemu_opt_get(opts, "tls-creds"));
> >
> >      addr =3D g_new0(SocketAddressLegacy, 1);
> >      if (path) {

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
