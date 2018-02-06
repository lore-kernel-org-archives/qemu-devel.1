Received: from eggs.gnu.org ([2001:4830:134:3::10]:54959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eizK1-0007g9-MV
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 04:13:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eizJx-0002gp-Lx
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 04:13:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:26978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eizJx-0002gS-F6
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 04:13:45 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A30BD78232
	for <qemu-devel@nongnu.org>; Tue,  6 Feb 2018 09:13:44 +0000 (UTC)
Date: Tue, 6 Feb 2018 09:13:37 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180206091337.GA20001@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180205152455.12088-1-berrange@redhat.com>
	<20180205152455.12088-8-berrange@redhat.com>
	<d9a1c2af-e5f8-1d46-d5c5-ecb2ce20981a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d9a1c2af-e5f8-1d46-d5c5-ecb2ce20981a@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 7/9] sockets: allow SocketAddress 'fd'
 to reference numeric file descriptors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Mon, Feb 05, 2018 at 01:42:50PM -0600, Eric Blake wrote:
> On 02/05/2018 09:24 AM, Daniel P. Berrang=C3=A9 wrote:
> > From: "Daniel P. Berrange" <berrange@redhat.com>
> >=20
> > The SocketAddress 'fd' kind accepts the name of a file descriptor pas=
sed
> > to the monitor with the 'getfd' command. This makes it impossible to =
use
> > the 'fd' kind in cases where a monitor is not available. This can app=
ly in
> > handling command line argv at startup, or simply if internal code wan=
ts to
> > use SocketAddress and pass a numeric FD it has acquired from elsewher=
e.
> >=20
> > Fortunately the 'getfd' command mandated that the FD names must not s=
tart
> > with a leading digit. We can thus safely extend semantics of the
> > SocketAddress 'fd' kind, to allow a purely numeric name to reference =
an
> > file descriptor that QEMU already has open. There will be restriction=
s on
> > when each kind can be used.
> >=20
> > In codepaths where we are handling a monitor command (ie cur_mon !=3D=
 NULL),
> > we will only support use of named file descriptors as before. Use of =
FD
> > numbers is still not permitted for monitor commands.
> >=20
> > In codepaths where we are not handling a monitor command (ie cur_mon =
=3D=3D
> > NULL), we will not support named file descriptors. Instead we can ref=
erence
> > FD numers explicitly. This allows the app spawning QEMU to intentiona=
lly
> > "leak" a pre-opened socket to QEMU and reference that in a SocketAddr=
ess
> > definition, or for code inside QEMU to pass pre-opened FDs around.
> >=20
> > Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >   qapi/sockets.json         |   7 +++
> >   tests/test-util-sockets.c | 112 +++++++++++++++++++++++++++++++++++=
++++++++---
> >   util/qemu-sockets.c       |  16 +++++--
> >   3 files changed, 126 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/qapi/sockets.json b/qapi/sockets.json
> > index ac022c6ad0..fc81d8d5e8 100644
> > --- a/qapi/sockets.json
> > +++ b/qapi/sockets.json
> > @@ -123,6 +123,13 @@
> >   #
> >   # @unix:  Unix domain socket
> >   #
> > +# @vsock: VMCI address
> > +#
> > +# @fd: decimal is for file descriptor number, otherwise a file descr=
iptor name.
> > +#      Named file descriptors are permitted in monitor commands, in =
combination
> > +#      with the 'getfd' command. Decimal file descriptors are permit=
ted at
> > +#      startup or other contexts where no monitor context is active.
> > +#
> >   # Since: 2.9
>=20
> There doesn't seem to be any way to introspect if we support decimal fd=
s
> from the command line; is that going to be a problem?

Libvirt needs to know when it can use it, so any suggestions ?


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
