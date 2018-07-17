Received: from eggs.gnu.org ([2001:4830:134:3::10]:42327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ffPlV-0003H0-Fj
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 09:11:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ffPlS-0008Go-A2
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 09:11:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51122 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ffPlS-0008GW-2m
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 09:11:38 -0400
Date: Tue, 17 Jul 2018 14:11:34 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180717131134.GR18603@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180717125239.22517-1-marcandre.lureau@redhat.com>
	<20180717125239.22517-4-marcandre.lureau@redhat.com>
	<20180717130130.GQ18603@redhat.com>
	<CAJ+F1CKXhSmbushwJR1xwy0C5eGoN27ONH_+mEg1BopJOO-F5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1CKXhSmbushwJR1xwy0C5eGoN27ONH_+mEg1BopJOO-F5Q@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] char-socket: delay setting fd-pass
 feature until connected
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>

On Tue, Jul 17, 2018 at 03:07:01PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Tue, Jul 17, 2018 at 3:01 PM, Daniel P. Berrang=C3=A9 <berrange@redh=
at.com> wrote:
> > On Tue, Jul 17, 2018 at 02:52:39PM +0200, Marc-Andr=C3=A9 Lureau wrot=
e:
> >> Wait for QIO channel connection completion, and check the feature se=
t
> >> by QIO. This fixes setting fd-pass chardev feature on
> >> SOCKET_ADDRESS_FD where fd has AF_UNIX.
> >>
> >> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >> ---
> >>  chardev/char-socket.c | 8 ++++----
> >>  1 file changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> >> index 6daa8d003a..7387e632d4 100644
> >> --- a/chardev/char-socket.c
> >> +++ b/chardev/char-socket.c
> >> @@ -789,6 +789,9 @@ static int tcp_chr_new_client(Chardev *chr, QIOC=
hannelSocket *sioc)
> >>
> >>      qio_channel_set_blocking(s->ioc, false, NULL);
> >>
> >> +    if (qio_channel_has_feature(s->ioc, QIO_CHANNEL_FEATURE_FD_PASS=
)) {
> >> +        qemu_chr_set_feature(chr, QEMU_CHAR_FEATURE_FD_PASS);
> >> +    }
> >
> > I really don't like this approach as it has unpleasant async/race pro=
ne
> > semantics or the external users of the chardev.
> >
> > With the current approach they know that once the chardev is created,
> > the features have been initialized.
> >
> > With this approach, the features are only initialized once the client
> > connection has been completed, or once the server has started listeni=
ng,
> > which may or may not be the case once the chardev constructor complet=
es.
>=20
> Ok, what about augmenting the feature set then?:
>=20
> keep the current qemu_chr_set_feature() in contructor for
> ADDRESS_TYPE_UNIX, and add the feature in new_client() for
> ADDRESS_TYPE_FD?

IMHO that makes the behaviour even more non-deterministic for callers.

How about we just delete the entire feature concept from chardevs and rem=
ove
the check from the vhostuser network backend too.

We have lots of users of chardevs in QEMU and vhostuser is the only one
that has tried to do this sanity check for the "correct" chardev backend.
The other users just assume the user / mgmt app will configure a suitable
chardev backend.  The vhostuser sanity checks have just caused more probl=
ems
then they've solved.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
