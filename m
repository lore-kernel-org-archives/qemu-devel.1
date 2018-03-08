Received: from eggs.gnu.org ([2001:4830:134:3::10]:42665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etveN-0007H4-0f
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 08:32:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1etveH-00051g-4y
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 08:32:03 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48276 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1etveG-00051O-Va
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 08:31:57 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C6C954023BB3
	for <qemu-devel@nongnu.org>; Thu,  8 Mar 2018 13:31:53 +0000 (UTC)
Date: Thu, 8 Mar 2018 13:31:43 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180308133143.GP4718@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180306053320.15401-1-peterx@redhat.com>
	<20180306053320.15401-10-peterx@redhat.com>
	<20180307123650.GD20201@redhat.com> <20180308034409.GA32252@xz-mi>
	<20180308101359.GE4718@redhat.com> <20180308114213.GE32252@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180308114213.GE32252@xz-mi>
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
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Thu, Mar 08, 2018 at 07:42:13PM +0800, Peter Xu wrote:
> On Thu, Mar 08, 2018 at 10:13:59AM +0000, Daniel P. Berrang=C3=A9 wrote=
:
> > On Thu, Mar 08, 2018 at 11:44:09AM +0800, Peter Xu wrote:
> > > On Wed, Mar 07, 2018 at 12:36:50PM +0000, Daniel P. Berrang=C3=A9 w=
rote:
> > >=20
> > > [...]
> > >=20
> > > > > diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> > > > > index bd40864f87..997c70dd7d 100644
> > > > > --- a/chardev/char-socket.c
> > > > > +++ b/chardev/char-socket.c
> > > > > @@ -31,6 +31,7 @@
> > > > >  #include "qemu/option.h"
> > > > >  #include "qapi/error.h"
> > > > >  #include "qapi/clone-visitor.h"
> > > > > +#include "sysemu/sysemu.h"
> > > > > =20
> > > > >  #include "chardev/char-io.h"
> > > > > =20
> > > > > @@ -722,6 +723,11 @@ static void tcp_chr_tls_init(Chardev *chr)
> > > > >      Error *err =3D NULL;
> > > > >      gchar *name;
> > > > > =20
> > > > > +    if (!machine_init_done) {
> > > > > +        /* This will be postponed to machine_done notifier */
> > > > > +        return;
> > > > > +    }
> > > > > +
> > > > >      if (s->is_listen) {
> > > > >          tioc =3D qio_channel_tls_new_server(
> > > > >              s->ioc, s->tls_creds,
> > > > > @@ -1145,6 +1151,10 @@ static int tcp_chr_machine_done_hook(Cha=
rdev *chr)
> > > > >          tcp_chr_connect_async(chr);
> > > > >      }
> > > > > =20
> > > > > +    if (s->tls_creds) {
> > > > > +        tcp_chr_tls_init(chr);
> > > > > +    }
> > > >=20
> > > > This looks questionable - AFAICT, there's no guarantee we have an=
y
> > > > client connection active when the machine dnoe hook runs. Only if
> > > > the chardev is set in client mode, and reconnect_time is *not* se=
t,
> > > > but this seems to be run unconditionally.
> > >=20
> > > You are right.  Thanks for spotting that.
> > >=20
> > > Then how about this?  It's a bit ugly, but I think it should be saf=
e:
> >=20
> > Is it perhaps not possible to just check if  's->ioc' is non-NULL
> > in the tcp_chr_machine_done_hook for your original patch ?
>=20
> In tcp_chr_new_client() I see that s->ioc will be set no matter what,
> and that function can even be called without TLS enabled I think.
> Does that mean only check against s->ioc would not be enough?

I mean like this:

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index a1966aae51..19e3193817 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -723,6 +723,11 @@ static void tcp_chr_tls_init(Chardev *chr)
     Error *err =3D NULL;
     gchar *name;
=20
+    if (!machine_init_done) {
+        /* This will be postponed to machine_done notifier */
+        return;
+    }
+
     if (s->is_listen) {
         tioc =3D qio_channel_tls_new_server(
             s->ioc, s->tls_creds,
@@ -1146,6 +1151,10 @@ static int tcp_chr_machine_done_hook(Chardev *chr)
         tcp_chr_connect_async(chr);
     }
=20
+    if (s->ioc && s->tls_creds) {
+        tcp_chr_tls_init(chr);
+    }
+
     return 0;
 }
=20


s->ioc will only be !=3D NULL, if some codepath in qemu_chr_parse_socket
ended up calling tcp_chr_new_client(). If that happened we will have
skipped setup of TLS, so calling tcp_chr_tls_init() based on
s->ioc && s->tls_creds feels right to me.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
