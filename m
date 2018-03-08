Received: from eggs.gnu.org ([2001:4830:134:3::10]:54636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1etw1B-0003Yc-TN
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 08:55:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1etw18-0000Ce-0d
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 08:55:37 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48766 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1etw17-0000CD-RK
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 08:55:33 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 264054075168
	for <qemu-devel@nongnu.org>; Thu,  8 Mar 2018 13:55:29 +0000 (UTC)
Date: Thu, 8 Mar 2018 21:55:22 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180308135521.GH32252@xz-mi>
References: <20180306053320.15401-1-peterx@redhat.com>
	<20180306053320.15401-10-peterx@redhat.com>
	<20180307123650.GD20201@redhat.com> <20180308034409.GA32252@xz-mi>
	<20180308101359.GE4718@redhat.com> <20180308114213.GE32252@xz-mi>
	<20180308133143.GP4718@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180308133143.GP4718@redhat.com>
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
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Thu, Mar 08, 2018 at 01:31:43PM +0000, Daniel P. Berrang=C3=A9 wrote:
> On Thu, Mar 08, 2018 at 07:42:13PM +0800, Peter Xu wrote:
> > On Thu, Mar 08, 2018 at 10:13:59AM +0000, Daniel P. Berrang=C3=A9 wro=
te:
> > > On Thu, Mar 08, 2018 at 11:44:09AM +0800, Peter Xu wrote:
> > > > On Wed, Mar 07, 2018 at 12:36:50PM +0000, Daniel P. Berrang=C3=A9=
 wrote:
> > > >=20
> > > > [...]
> > > >=20
> > > > > > diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> > > > > > index bd40864f87..997c70dd7d 100644
> > > > > > --- a/chardev/char-socket.c
> > > > > > +++ b/chardev/char-socket.c
> > > > > > @@ -31,6 +31,7 @@
> > > > > >  #include "qemu/option.h"
> > > > > >  #include "qapi/error.h"
> > > > > >  #include "qapi/clone-visitor.h"
> > > > > > +#include "sysemu/sysemu.h"
> > > > > > =20
> > > > > >  #include "chardev/char-io.h"
> > > > > > =20
> > > > > > @@ -722,6 +723,11 @@ static void tcp_chr_tls_init(Chardev *ch=
r)
> > > > > >      Error *err =3D NULL;
> > > > > >      gchar *name;
> > > > > > =20
> > > > > > +    if (!machine_init_done) {
> > > > > > +        /* This will be postponed to machine_done notifier *=
/
> > > > > > +        return;
> > > > > > +    }
> > > > > > +
> > > > > >      if (s->is_listen) {
> > > > > >          tioc =3D qio_channel_tls_new_server(
> > > > > >              s->ioc, s->tls_creds,
> > > > > > @@ -1145,6 +1151,10 @@ static int tcp_chr_machine_done_hook(C=
hardev *chr)
> > > > > >          tcp_chr_connect_async(chr);
> > > > > >      }
> > > > > > =20
> > > > > > +    if (s->tls_creds) {
> > > > > > +        tcp_chr_tls_init(chr);
> > > > > > +    }
> > > > >=20
> > > > > This looks questionable - AFAICT, there's no guarantee we have =
any
> > > > > client connection active when the machine dnoe hook runs. Only =
if
> > > > > the chardev is set in client mode, and reconnect_time is *not* =
set,
> > > > > but this seems to be run unconditionally.
> > > >=20
> > > > You are right.  Thanks for spotting that.
> > > >=20
> > > > Then how about this?  It's a bit ugly, but I think it should be s=
afe:
> > >=20
> > > Is it perhaps not possible to just check if  's->ioc' is non-NULL
> > > in the tcp_chr_machine_done_hook for your original patch ?
> >=20
> > In tcp_chr_new_client() I see that s->ioc will be set no matter what,
> > and that function can even be called without TLS enabled I think.
> > Does that mean only check against s->ioc would not be enough?
>=20
> I mean like this:
>=20
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index a1966aae51..19e3193817 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -723,6 +723,11 @@ static void tcp_chr_tls_init(Chardev *chr)
>      Error *err =3D NULL;
>      gchar *name;
> =20
> +    if (!machine_init_done) {
> +        /* This will be postponed to machine_done notifier */
> +        return;
> +    }
> +
>      if (s->is_listen) {
>          tioc =3D qio_channel_tls_new_server(
>              s->ioc, s->tls_creds,
> @@ -1146,6 +1151,10 @@ static int tcp_chr_machine_done_hook(Chardev *ch=
r)
>          tcp_chr_connect_async(chr);
>      }
> =20
> +    if (s->ioc && s->tls_creds) {
> +        tcp_chr_tls_init(chr);
> +    }
> +
>      return 0;
>  }
> =20
>=20
>=20
> s->ioc will only be !=3D NULL, if some codepath in qemu_chr_parse_socke=
t

I guess here you mean qmp_chardev_open_socket().

> ended up calling tcp_chr_new_client(). If that happened we will have
> skipped setup of TLS, so calling tcp_chr_tls_init() based on
> s->ioc && s->tls_creds feels right to me.

Yes, it looks right to me too. :)

I'll post a complete patch soon with your authorship.

Thanks!

--=20
Peter Xu
