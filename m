Received: from eggs.gnu.org ([2001:4830:134:3::10]:54545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ff6tz-0000Fq-N9
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 13:03:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ff6tw-0005tM-JM
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 13:03:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48940 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ff6tw-0005sy-D8
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 13:03:08 -0400
Date: Mon, 16 Jul 2018 18:03:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180716170303.GC5616@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180704111118.7241-1-berrange@redhat.com>
	<f56b799f-7f30-391f-c2d8-15f95524758c@redhat.com>
	<20180704120826.GD32267@redhat.com>
	<CAJ+F1CK+eywam7LSvOCW2YcHO9S4GL5n7+9yta9_t3j+9hN-cQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1CK+eywam7LSvOCW2YcHO9S4GL5n7+9yta9_t3j+9hN-cQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] chardev: unconditionally set FD_PASS
 feature for socket type=fd
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

On Mon, Jul 16, 2018 at 06:57:48PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Wed, Jul 4, 2018 at 2:08 PM, Daniel P. Berrang=C3=A9 <berrange@redha=
t.com> wrote:
> > On Wed, Jul 04, 2018 at 01:53:03PM +0200, Paolo Bonzini wrote:
> >> On 04/07/2018 13:11, Daniel P. Berrang=C3=A9 wrote:
> >> > The vhostuser network backend requires the chardev it is using to =
have
> >> > the FD passing feature. It checks this upfront when initializing t=
he
> >> > network backend and reports an error if not set.
> >> >
> >> > The socket chardev has to set the FD_PASS feature during early
> >> > initialization to satisfy the vhostuser backend, and at this point
> >> > the socket has not been initialized. It is thus unable to do a liv=
e
> >> > check on the socket to see if it supports FD passing (aka is a UNI=
X
> >> > socket). As a result it has to blindly set FD_PASS feature based
> >> > solely on info in the SocketAddress struct, such as address type.
> >> >
> >> > Unfortunately libvirt wishes to use FD passing to provide the UNIX
> >> > domain socket listener, and as a result the FD_PASS feature is no
> >> > longer set, which breaks vhostuser's checks, despite the fact that
> >> > FD passing will in fact work later.
> >> >
> >> > This unconditionally sets FD_PASS feature for any socket address
> >> > which has type=3D=3Dfd. Thus will be wrong if the passed in FD was=
 not
> >> > a UNIX socket, but if an attempt is later made to use FD passing
> >> > we'll still get an error reported by the QIOChannelSocket class.
> >> > So the effective of setting the chardev FD_PASS feature early
> >> > is merely to delay error reporting.
> >>
> >> Could you query with getsockopt or getsockname in tcp_chr_connect?
> >
> > That potentially executes asynchronously in the backend and vhostuser
> > checks it when it first resolves the chardev ID. IOW the point where
> > vhostuser checks, all we have is the SocketAddress struct - in some
> > case we might be lucky & have connected, but we can't assume it :-(
>=20
> In which case is it executed asynchronously?
>=20
> Chardev creation is happening before vhost-user net,
> qemu_chardev_new() and qemu_char_open() calls
> qio_channel_socket_connect_sync().

The qmp_chardev_open_socket() method is not guaranteed to complete
synchronously. If the "reconnect" property is set everything happens
asynchronously, so we're not able to set the feature flag by the time
qemu_char_open() returns.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
