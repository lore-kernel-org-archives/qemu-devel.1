Received: from eggs.gnu.org ([2001:4830:134:3::10]:51688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ercHH-0000SG-9V
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 23:26:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ercHC-0007bt-CZ
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 23:26:39 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54852 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ercHC-0007bD-7E
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 23:26:34 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 308734075168
	for <qemu-devel@nongnu.org>; Fri,  2 Mar 2018 04:26:23 +0000 (UTC)
Date: Fri, 2 Mar 2018 12:26:09 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180302042609.GA27381@xz-mi>
References: <20180301084438.13594-1-peterx@redhat.com>
	<20180301084438.13594-8-peterx@redhat.com>
	<20180301154331.GN14643@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180301154331.GN14643@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 07/15] qio/chardev: update net listener
 gcontext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Thu, Mar 01, 2018 at 03:43:31PM +0000, Daniel P. Berrang=C3=A9 wrote:
> On Thu, Mar 01, 2018 at 04:44:30PM +0800, Peter Xu wrote:
> > TCP chardevs can be using QIO network listeners working in the
> > background when in listening mode.  However the network listeners are
> > always running in main context.  This can race with chardevs that are
> > running in non-main contexts.
> >=20
> > To solve this, we need to re-setup the net listeners in
> > tcp_chr_update_read_handler() with the newly cached gcontext.
> >=20
> > Since at it, generalize a tcp_chr_net_listener_setup() helper functio=
n
> > and clean up the old code a bit.
> >=20
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  chardev/char-socket.c | 32 ++++++++++++++++++++++++++------
> >  1 file changed, 26 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> > index 43a2cc2c1c..5cd20cc932 100644
> > --- a/chardev/char-socket.c
> > +++ b/chardev/char-socket.c
> > @@ -410,6 +410,19 @@ static void update_disconnected_filename(SocketC=
hardev *s)
> >                                           s->is_listen, s->is_telnet)=
;
> >  }
> > =20
> > +/* Set enable=3Dtrue to start net listeners, false to stop them. */
> > +static void tcp_chr_net_listener_setup(SocketChardev *s, bool enable=
)
> > +{
> > +    Chardev *chr =3D CHARDEV(s);
> > +
> > +    /* Net listeners' context will follow the Chardev's. */
> > +    qio_net_listener_set_client_func_full(s->listener,
> > +                                          enable ? tcp_chr_accept : =
NULL,
> > +                                          enable ? chr : NULL,
> > +                                          NULL,
> > +                                          chr->gcontext);
>=20
> I don't think this helper method is really a benefit. In fact I think
> it makes understanding the code harder, because when you see
> tcp_chr_net_listener_setup(s, true), you've no idea what 'true' means
> without going to finding the impl of tcp_chr_net_listener_setup().
>=20
> Just leave the direct calls to qio_net_listener_set_client_func_full
> as they are IMHO.

Frankly speaking I was a bit confused when I started to read
chardev/qio codes with so many hooks, e.g., when I saw:

     qio_net_listener_set_client_func(s->listener, tcp_chr_accept,
                                      chr, NULL);

I totally have no idea on what happened.  I need to go deeper into the
net listener code to know that, hmm, it's setting up something to
accept connections!

If I can have something like:

    tcp_chr_net_listener_setup(s, true);

It may be easier for me to understand that there's something either
registered for the listening ports, and I don't need to care about
which function will be called when accept happened.  Basically it
"hides" some logic inside, that's IMHO where functions/macros help.

(Here the naming of function is discussible for sure, along with how
 to define the parameters)

I think it may be a flavor issue.  In that case, I'm always fine with
either way. I assume the previous cleanup patch 5 is similarly a
flavor issue too, so I'll follow your final judgement on what you
would prefer.

Thanks,

--=20
Peter Xu
