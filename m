Received: from eggs.gnu.org ([2001:4830:134:3::10]:38837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fqXLz-0005Ea-Kj
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 01:31:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fqXLw-0006tU-Fx
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 01:31:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39478 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fqXLw-0006rx-9i
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 01:31:16 -0400
Date: Fri, 17 Aug 2018 13:31:08 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180817053108.GI2708@xz-mi>
References: <20180306053320.15401-1-peterx@redhat.com>
	<20180306053320.15401-8-peterx@redhat.com>
	<CAJ+F1CKL3yunvzx3_uNeCjecoCdM2Cm+LwGBgSxfxChS=d_D6g@mail.gmail.com>
	<CAJ+F1CL3iC7UND=N53VUGJCKimLPSDwBY0zWigWeO1ijqdgjpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1CL3iC7UND=N53VUGJCKimLPSDwBY0zWigWeO1ijqdgjpA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 7/9] chardev: tcp: postpone async
 connection setup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Thu, Aug 16, 2018 at 08:27:40PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> Hi
> On Thu, Aug 16, 2018 at 7:49 PM Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@gmail.com> wrote:
> >
> > Hi
> > On Tue, Mar 6, 2018 at 6:41 AM Peter Xu <peterx@redhat.com> wrote:
> > >
> > > This patch allows the socket chardev async connection be setup with
> > > non-default gcontext.  We do it by postponing the setup to machine =
done,
> > > since until then we can know which context we should run the async
> > > operation on.
> > >
> > > Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >  chardev/char-socket.c | 17 ++++++++++++++---
> > >  1 file changed, 14 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> > > index 1ce5adad9a..165612845a 100644
> > > --- a/chardev/char-socket.c
> > > +++ b/chardev/char-socket.c
> > > @@ -1004,9 +1004,8 @@ static void qmp_chardev_open_socket(Chardev *=
chr,
> > >          s->reconnect_time =3D reconnect;
> > >      }
> > >
> > > -    if (s->reconnect_time) {
> > > -        tcp_chr_connect_async(chr);
> > > -    } else {
> > > +    /* If reconnect_time is set, will do that in chr_machine_done.=
 */
> > > +    if (!s->reconnect_time) {
> > >          if (s->is_listen) {
> > >              char *name;
> > >              s->listener =3D qio_net_listener_new();
> > > @@ -1138,6 +1137,17 @@ char_socket_get_connected(Object *obj, Error=
 **errp)
> > >      return s->connected;
> > >  }
> > >
> > > +static int tcp_chr_machine_done_hook(Chardev *chr)
> > > +{
> > > +    SocketChardev *s =3D SOCKET_CHARDEV(chr);
> > > +
> > > +    if (s->reconnect_time) {
> > > +        tcp_chr_connect_async(chr);
> > > +    }
> > > +
> > > +    return 0;
> > > +}
> >
> > This patch broke /vhost-user/reconnect test, since it is using
> > reconnect chardev sockets under a test program, where no machine done
> > hook exist.
> >
>=20
> What about chardev created after machine done?

Hmm, so binding that with machine done might be problematic...

I'm thinking whether we can do that in ->chr_update_read_handler()
instead.

Btw, is there a short answer on why we disabled the reconnection test
in vhost-user-test?  Could I just verify the problem using:

QTEST_VHOST_USER_FIXME=3D1 QTEST_QEMU_BINARY=3Dx86_64-softmmu/qemu-system=
-x86_64 ./tests/vhost-user-test

?  Or any easy way to reproduce/verify the problem?

Regards,

--=20
Peter Xu
