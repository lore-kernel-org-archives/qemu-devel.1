Received: from eggs.gnu.org ([2001:4830:134:3::10]:50741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1etmTu-0005A8-Vl
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 22:44:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1etmTr-0000II-Sk
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 22:44:39 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43250 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1etmTr-0000IC-NC
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 22:44:35 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 134F24001851
	for <qemu-devel@nongnu.org>; Thu,  8 Mar 2018 03:44:25 +0000 (UTC)
Date: Thu, 8 Mar 2018 11:44:09 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180308034409.GA32252@xz-mi>
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
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Wed, Mar 07, 2018 at 12:36:50PM +0000, Daniel P. Berrang=C3=A9 wrote:

[...]

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

You are right.  Thanks for spotting that.

Then how about this?  It's a bit ugly, but I think it should be safe:

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index bd40864f87..b4686fd23f 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -31,6 +31,7 @@
 #include "qemu/option.h"
 #include "qapi/error.h"
 #include "qapi/clone-visitor.h"
+#include "sysemu/sysemu.h"

 #include "chardev/char-io.h"

@@ -51,6 +52,11 @@ typedef struct {
     QIONetListener *listener;
     GSource *hup_source;
     QCryptoTLSCreds *tls_creds;
+    /*
+     * This should only be used once - when we want to setup TLS for
+     * the session but we need to wait until machine init done.
+     */
+    bool tls_need_postponed_init;
     int connected;
     int max_size;
     int do_telnetopt;
@@ -791,7 +797,15 @@ static int tcp_chr_new_client(Chardev *chr, QIOChann=
elSocket *sioc)
     }

     if (s->tls_creds) {
-        tcp_chr_tls_init(chr);
+        if (machine_init_done) {
+            tcp_chr_tls_init(chr);
+        } else {
+            /*
+             * Postpone to machine init done since we need the correct
+             * context to setup the TLS handshake.
+             */
+            s->tls_need_postponed_init =3D true;
+        }
     } else {
         if (s->do_telnetopt) {
             tcp_chr_telnet_init(chr);
@@ -1145,6 +1159,11 @@ static int tcp_chr_machine_done_hook(Chardev *chr)
         tcp_chr_connect_async(chr);
     }

+    if (s->tls_need_postponed_init) {
+        assert(s->tls_creds);
+        tcp_chr_tls_init(chr);
+    }
+
     return 0;
 }

Thanks,

--=20
Peter Xu
