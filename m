Received: from eggs.gnu.org ([2001:4830:134:3::10]:54889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eYavV-0000FH-2o
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:09:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eYavQ-0001kM-T3
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:09:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52438)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eYavQ-0001jx-KM
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:09:28 -0500
Date: Mon, 8 Jan 2018 17:09:16 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180108170916.GH11758@stefanha-x1.localdomain>
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-17-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MGu/vTNewDGZ7tmp"
Content-Disposition: inline
In-Reply-To: <20171219084557.9801-17-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v6 16/27] monitor: separate QMP parser and
 dispatcher
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--MGu/vTNewDGZ7tmp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2017 at 04:45:46PM +0800, Peter Xu wrote:
> Originally QMP goes throw these steps:

s/throw/through/

>=20
>   JSON Parser --> QMP Dispatcher --> Respond
>       /|\    (2)                (3)     |
>    (1) |                               \|/ (4)
>        +---------  main thread  --------+
>=20
> This patch does this:
>=20
>   JSON Parser     QMP Dispatcher --> Respond
>       /|\ |           /|\       (4)     |
>        |  | (2)        | (3)            |  (5)
>    (1) |  +----->      |               \|/
>        +---------  main thread  <-------+
>=20
> So the parsing job and the dispatching job is isolated now.  It gives us
> a chance in following up patches to totally move the parser outside.
>=20
> The isloation is done using one QEMUBH. Only one dispatcher QEMUBH is

s/isloation/isolation/

> @@ -3897,30 +3920,39 @@ static void monitor_qmp_respond(Monitor *mon, QOb=
ject *rsp,
>      qobject_decref(rsp);
>  }
> =20
> -static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
> +struct QMPRequest {
> +    /* Owner of the request */
> +    Monitor *mon;
> +    /* "id" field of the request */
> +    QObject *id;
> +    /* Request object to be handled */
> +    QObject *req;
> +    /*
> +     * Whether we need to resume the monitor afterward.  This flag is
> +     * used to emulate the old QMP server behavior that only one
> +     * command is executed for each time.

s/only one command is executed for each time/the current command must
complete before the next one executes/

> +     */
> +    bool need_resume;

This isn't really a per-request decision so a QMPRequest field is not
necessary.  If "oob" is enabled then we dispatch commands without
waiting.  If "oob" is disabled then we complete the current command
before dispatching the next one.

If you want to keep this, I don't mind, but the field isn't necessary.

> @@ -4150,6 +4292,15 @@ static void monitor_iothread_init(void)
>  {
>      mon_global.mon_iothread =3D iothread_create("mon_iothread",
>                                                &error_abort);
> +
> +    /*
> +     * This MUST be on main loop thread since we have commands that
> +     * have assumption to be run on main loop thread (Yeah, we'd
> +     * better remove this assumption in the future).

"we'd better ..." usually means that it will be necessary.  It is
stronger than "it would be nice to ...".  I'm not sure which one you
mean here.

There doesn't seem to be any immediate need or plan to run regular
commands outside the main loop.  I'm not aware of active work to do
that.  So what is this comment trying to say?

--MGu/vTNewDGZ7tmp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaU6W8AAoJEJykq7OBq3PI4eYH/3rZrik/QwUUY3UJVXS8RrFI
8AatZQijSJaXlI9ghF+uNWhUhTNgJZil9ye5JUHatUa8Za9W3iJq5OR+yY7v07Rt
GlUNY8u2F78F8fusPhHZ9cX7k0JPq6JYsPniBkeDTah1sCB54rhUnj3jRA3me37z
CMWIQ17pF5n1LbI3FU2hqReqfkZtfyUzt3w/B3JrRY8mrTNCEs8U0HE0VrKKOSce
jQEbFJwCWy7X17+qr68T2KvOFY7tpB0eEGkMQnx/WWW3sOR10qrRoEDdpfLRpXV0
zWvNY4HokMkpSxTb6dN+PLdNhVTRGWAedhi/Ba5UPGWkTQHBPVmwvHCI509dkKk=
=HXBo
-----END PGP SIGNATURE-----

--MGu/vTNewDGZ7tmp--
