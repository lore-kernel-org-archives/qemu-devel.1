Received: from eggs.gnu.org ([2001:4830:134:3::10]:52414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etYNN-0006cS-LA
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:40:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etYNJ-0004JE-KW
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:40:57 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47840 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1etYNJ-0004J8-EU
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 07:40:53 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D986E87ABA
	for <qemu-devel@nongnu.org>; Wed,  7 Mar 2018 12:40:49 +0000 (UTC)
Date: Wed, 7 Mar 2018 12:40:38 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180307124038.GE20201@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180306053320.15401-1-peterx@redhat.com>
	<20180306053320.15401-10-peterx@redhat.com>
	<20180307123650.GD20201@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180307123650.GD20201@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 9/9] chardev: tcp: postpone TLS work
 until machine done
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Wed, Mar 07, 2018 at 12:36:50PM +0000, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Mar 06, 2018 at 01:33:20PM +0800, Peter Xu wrote:
> > TLS handshake may create background GSource tasks, while we won't kno=
w
> > the correct GMainContext until the whole chardev (including frontend)
> > inited.  Let's postpone the initial TLS handshake until machine done.
> >=20
> > For dynamically created tcp chardev, we don't postpone that by checki=
ng
> > the init_machine_done variable.
>=20
> Not sure I see the need for this one - we've already postponed the
> acceptance of a client in the patch 7.

Opps, meant to remove this comment, in favour of the later comment - igno=
re
this bit.

>=20
> >=20
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  chardev/char-socket.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >=20
> > diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> > index bd40864f87..997c70dd7d 100644
> > --- a/chardev/char-socket.c
> > +++ b/chardev/char-socket.c
> > @@ -31,6 +31,7 @@
> >  #include "qemu/option.h"
> >  #include "qapi/error.h"
> >  #include "qapi/clone-visitor.h"
> > +#include "sysemu/sysemu.h"
> > =20
> >  #include "chardev/char-io.h"
> > =20
> > @@ -722,6 +723,11 @@ static void tcp_chr_tls_init(Chardev *chr)
> >      Error *err =3D NULL;
> >      gchar *name;
> > =20
> > +    if (!machine_init_done) {
> > +        /* This will be postponed to machine_done notifier */
> > +        return;
> > +    }
> > +
> >      if (s->is_listen) {
> >          tioc =3D qio_channel_tls_new_server(
> >              s->ioc, s->tls_creds,
> > @@ -1145,6 +1151,10 @@ static int tcp_chr_machine_done_hook(Chardev *=
chr)
> >          tcp_chr_connect_async(chr);
> >      }
> > =20
> > +    if (s->tls_creds) {
> > +        tcp_chr_tls_init(chr);
> > +    }
>=20
> This looks questionable - AFAICT, there's no guarantee we have any
> client connection active when the machine dnoe hook runs. Only if
> the chardev is set in client mode, and reconnect_time is *not* set,
> but this seems to be run unconditionally.
>=20
>=20
> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
