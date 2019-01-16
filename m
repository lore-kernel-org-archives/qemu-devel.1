Received: from eggs.gnu.org ([209.51.188.92]:44383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gjhXg-0004cu-Sk
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 04:31:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gjhXb-0002Wc-Pw
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 04:31:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gjhXa-0002KA-Vo
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 04:31:19 -0500
Date: Wed, 16 Jan 2019 09:31:06 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190116093106.GC20275@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190115145256.9593-1-berrange@redhat.com>
	<20190115145256.9593-5-berrange@redhat.com>
	<8dc5ad30-f15c-e2a0-b0bc-9af7a07854dd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8dc5ad30-f15c-e2a0-b0bc-9af7a07854dd@redhat.com>
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
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, Yongji Xie <elohimes@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Tue, Jan 15, 2019 at 01:33:25PM -0600, Eric Blake wrote:
> [adding Markus in relation to a QemuOpts observation]
>=20
> On 1/15/19 8:52 AM, Daniel P. Berrang=C3=A9 wrote:
> > Now that all validation is separated off into a separate method,
> > we can directly populate the ChardevSocket struct from the
> > QemuOpts values, avoiding many local variables.
> >=20
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> >  chardev/char-socket.c | 40 ++++++++++++++++++----------------------
> >  1 file changed, 18 insertions(+), 22 deletions(-)
> >=20
>=20
> > @@ -1216,26 +1208,30 @@ static void qemu_chr_parse_socket(QemuOpts *o=
pts, ChardevBackend *backend,
> >      sock =3D backend->u.socket.data =3D g_new0(ChardevSocket, 1);
> >      qemu_chr_parse_common(opts, qapi_ChardevSocket_base(sock));
> > =20
> > -    sock->has_nodelay =3D true;
> > -    sock->nodelay =3D do_nodelay;
> > +    sock->has_nodelay =3D qemu_opt_get(opts, "delay");
> > +    sock->nodelay =3D !qemu_opt_get_bool(opts, "delay", true);
>=20
> Unrelated to this patch, but my recent proposal to make QemuOpts be a
> bit more typesafe:
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg02042.html
>=20
> does not like users calling qemu_opt_get() of an option that has an
> integer default (as opposed to a string default), even if the only
> reason the caller was doing it was to learn if the option is present.  =
I
> wonder if we should introduce
>=20
> bool qemu_opt_has(QemuOpts *opts, const char *name)
>=20
> and then replace existing callers which merely call qemu_opt_get() to
> learn whether an optional option was present/defaulted but without
> caring about its string value.  I also wonder if Coccinelle can be
> employed to determine which callers fit that bill (that is, detect when
> a const char * result is ignored or solely used in a bool context, vs.
> when it is actually used as a string parameter to another function
> and/or saved in a const char * variable).

Yes, if you're going to enforce type safety on qemu_opt_get, then
then we definitely need to have  qemu_opt_has()  function to check
for existance, as this is needed in other places too.


>=20
> Now, on to actual review,
>=20
> > +    /*
> > +     * We have different default to QMP for 'server', hence
> > +     * we can't just check for existance of 'server'
>=20
> s/existance/existence/
>=20
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
>=20
> but then again, you were copy-pasting an existing typo.

Both typos were from this series


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
