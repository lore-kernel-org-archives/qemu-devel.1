Received: from eggs.gnu.org ([2001:4830:134:3::10]:57151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ciiBu-00062k-CV
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 08:51:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ciiBr-0005wC-9f
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 08:51:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ciiBr-0005vq-47
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 08:51:43 -0500
Date: Tue, 28 Feb 2017 13:51:39 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170228135139.GF2720@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170228120754.7947-1-berrange@redhat.com>
	<CAJ+F1CJ2WiJy9+atWvJ7cb0C_gzq1_N8zKo6t-KQArVJDuQ6zA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1CJ2WiJy9+atWvJ7cb0C_gzq1_N8zKo6t-KQArVJDuQ6zA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] io: fully parse & validate HTTP headers
 for websocket protocol handshake
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, "Denis V. Lunev" <den@openvz.org>, Anton Nefedov <anton.nefedov@virtuozzo.com>

On Tue, Feb 28, 2017 at 01:48:23PM +0000, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Tue, Feb 28, 2017 at 4:11 PM Daniel P. Berrange <berrange@redhat.com=
>
> wrote:
>=20
> > The current websockets protocol handshake code is very relaxed, just
> > doing crude string searching across the HTTP header data. This causes
> > it to both reject valid connections and fail to reject invalid
> > connections. For example, according to the RFC 6455 it:
> >
> >  - MUST reject any method other than "GET"
> >  - MUST reject any HTTP version less than "HTTP/1.1"
> >  - MUST reject Connection header without "Upgrade" listed
> >  - MUST reject Upgrade header which is not 'websocket'
> >  - MUST reject missing Host header
> >  - MUST treat HTTP header names as case insensitive
> >
> > To do all this validation correctly requires that we fully parse the
> > HTTP headers, populating a data structure containing the header
> > fields.
> >
> > After this change, we also reject any path other than '/'
>=20
>=20
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  io/channel-websock.c | 236
> > ++++++++++++++++++++++++++++++++++++++++++---------
> >  1 file changed, 194 insertions(+), 42 deletions(-)
> >
>=20
> Looks good, but tests would be welcome, do you have plans for it?

It is a todo item but I've not had time to work on it. All the other
I/O channel implementations share a generall purpose test framework,
but I couldn't wire up websockets to that because we only have an
impl of the server side, not the client. So doing testing for this
will be a bit more involved, but it is certainly something we need
coverage for.

Regards,
Daniel
--=20
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange=
/ :|
|: http://libvirt.org              -o-             http://virt-manager.or=
g :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr=
/ :|
