Received: from eggs.gnu.org ([2001:4830:134:3::10]:49237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1ctGmz-0007gO-GR
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 12:49:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1ctGmy-0007U5-Gg
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 12:49:41 -0400
Date: Wed, 29 Mar 2017 12:49:31 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <1585753855.16940591.1490806170998.JavaMail.zimbra@redhat.com>
In-Reply-To: <1947286013.16940443.1490806123696.JavaMail.zimbra@redhat.com>
References: <1490805920-17029-1-git-send-email-armbru@redhat.com>
	<1490805920-17029-3-git-send-email-armbru@redhat.com>
	<1947286013.16940443.1490806123696.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [for-2.9 2/8] char: Fix socket with "type":
 "vsock" address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mitake hitoshi <mitake.hitoshi@lab.ntt.co.jp>, namei unix <namei.unix@gmail.com>, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, pbonzini@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>



----- Original Message -----
>=20
> Hi
>=20
> ----- Original Message -----
> > Watch this:
> >=20
> >     $ qemu-system-x86_64 -nodefaults -S -display none -qmp stdio
> >     {"QMP": {"version": {"qemu": {"micro": 91, "minor": 8, "major": 2},
> >     "package": " (v2.8.0-1195-gf84141e-dirty)"}, "capabilities": []}}
> >     { "execute": "qmp_capabilities" }
> >     {"return": {}}
> >     { "execute": "chardev-add", "arguments": { "id": "chr0", "backend":=
 {
> >     "type": "socket", "data": { "addr": { "type": "vsock", "data": { "c=
id":
> >     "CID", "port": "P" }}}}}}
> >     Aborted (core dumped)
> >=20
> > Crashes because SocketAddress_to_str() is blissfully unaware of
> > SOCKET_ADDRESS_KIND_VSOCK.  Fix that.  Pick the output format to match
> > socket_parse(), just like the existing formats.
> >=20
> > Cc: Stefan Hajnoczi <stefanha@redhat.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
>=20
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> > ---
> >  chardev/char-socket.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >=20
> > diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> > index 6344b07..36ab0d6 100644
> > --- a/chardev/char-socket.c
> > +++ b/chardev/char-socket.c
> > @@ -357,6 +357,10 @@ static char *SocketAddress_to_str(const char *pref=
ix,
> > SocketAddress *addr,
> >          return g_strdup_printf("%sfd:%s%s", prefix, addr->u.fd.data->s=
tr,
> >                                 is_listen ? ",server" : "");
> >          break;
> > +    case SOCKET_ADDRESS_KIND_VSOCK:
> > +        return g_strdup_printf("%svsock:%s:%s", prefix,
> > +                               addr->u.vsock.data->cid,
> > +                               addr->u.vsock.data->port);
> >      default:
> >          abort();
>=20
> ooch.. may I suggest we don't abort() here? g_return_val_if_fail() perhap=
s a
> more judicious choice?

-> g_return_if_reached()

>=20
