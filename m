Received: from eggs.gnu.org ([2001:4830:134:3::10]:38256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fagaK-0005Gt-6j
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 08:08:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fagaG-0004uu-UH
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 08:08:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52344 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fagaG-0004uj-O8
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 08:08:32 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 689B087929
	for <qemu-devel@nongnu.org>; Wed,  4 Jul 2018 12:08:32 +0000 (UTC)
Date: Wed, 4 Jul 2018 13:08:26 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180704120826.GD32267@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180704111118.7241-1-berrange@redhat.com>
	<f56b799f-7f30-391f-c2d8-15f95524758c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f56b799f-7f30-391f-c2d8-15f95524758c@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Wed, Jul 04, 2018 at 01:53:03PM +0200, Paolo Bonzini wrote:
> On 04/07/2018 13:11, Daniel P. Berrang=C3=A9 wrote:
> > The vhostuser network backend requires the chardev it is using to hav=
e
> > the FD passing feature. It checks this upfront when initializing the
> > network backend and reports an error if not set.
> >=20
> > The socket chardev has to set the FD_PASS feature during early
> > initialization to satisfy the vhostuser backend, and at this point
> > the socket has not been initialized. It is thus unable to do a live
> > check on the socket to see if it supports FD passing (aka is a UNIX
> > socket). As a result it has to blindly set FD_PASS feature based
> > solely on info in the SocketAddress struct, such as address type.
> >=20
> > Unfortunately libvirt wishes to use FD passing to provide the UNIX
> > domain socket listener, and as a result the FD_PASS feature is no
> > longer set, which breaks vhostuser's checks, despite the fact that
> > FD passing will in fact work later.
> >=20
> > This unconditionally sets FD_PASS feature for any socket address
> > which has type=3D=3Dfd. Thus will be wrong if the passed in FD was no=
t
> > a UNIX socket, but if an attempt is later made to use FD passing
> > we'll still get an error reported by the QIOChannelSocket class.
> > So the effective of setting the chardev FD_PASS feature early
> > is merely to delay error reporting.
>=20
> Could you query with getsockopt or getsockname in tcp_chr_connect?

That potentially executes asynchronously in the backend and vhostuser
checks it when it first resolves the chardev ID. IOW the point where
vhostuser checks, all we have is the SocketAddress struct - in some
case we might be lucky & have connected, but we can't assume it :-(

Previously vhostuser poked directly in the QemuOpts for the chardev
which I changed to this feature based approach in

  commit 0a73336d96397c80881219d080518fac6f1ecacb
  Author: Daniel P. Berrange <berrange@redhat.com>
  Date:   Fri Oct 7 13:18:34 2016 +0100

    net: don't poke at chardev internal QemuOpts

This whole mess is merely so that vhostuser can print out an error
message if you point it to a chardev that isn't a UNIX socket. If
anything I'm half inclined to just delete that upfront error check
entirely.=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
