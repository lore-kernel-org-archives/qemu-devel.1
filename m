Received: from eggs.gnu.org ([2001:4830:134:3::10]:44913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f7ze9-0002tC-Cf
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 04:37:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f7ze5-0001oo-AC
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 04:37:57 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:44341)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1f7ze5-0001oD-3O
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 04:37:53 -0400
Received: by mail-pl0-x243.google.com with SMTP id s13-v6so2375660plq.11
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 01:37:52 -0700 (PDT)
Date: Mon, 16 Apr 2018 16:37:48 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180416083748.GD28904@stefanha-x1.localdomain>
References: <20180412061108.10875-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="11Y7aswkeuHtSBEs"
Content-Disposition: inline
In-Reply-To: <20180412061108.10875-1-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] monitor: let cur_mon be per-thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


--11Y7aswkeuHtSBEs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 12, 2018 at 02:11:08PM +0800, Peter Xu wrote:
> In the future the monitor iothread may be accessing the cur_mon as
> well (via monitor_qmp_dispatch_one()).  Before we introduce a real
> Out-Of-Band command, let's convert the cur_mon variable to be a
> per-thread variable to make sure there won't be a race between threads.
>
> Note that thread variables are not initialized to a valid value when new
> thread is created.  However for our case we don't need to set it up,
> since the cur_mon variable is only used in such a pattern:
>=20
>   old_mon =3D cur_mon;
>   cur_mon =3D xxx;
>   (do something, read cur_mon if necessary in the stack)
>   cur_mon =3D old_mon;
>=20
> It plays a role as stack variable, so no need to be initialized at all.
> We only need to make sure the variable won't be changed unexpectedly by
> other threads.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
> v3:
> - fix code style warning from patchew
> v2:
> - drop qemu-thread changes
> ---
>  include/monitor/monitor.h | 2 +-
>  monitor.c                 | 2 +-
>  stubs/monitor.c           | 2 +-
>  tests/test-util-sockets.c | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)

The Monitor object is not fully thread-safe, so although the correct
cur_mon is now accessible, code may still be unsafe.  For example,
monitor_get_fd(cur_mon, ...) is not thread-safe and must not be used by
OOB commands.

Future OOB commands need to know which monitor.h APIs are safe to call,
otherwise bugs are likely.  Please send a follow up patch to address
this (e.g. doc comments, locking where needed, etc).

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--11Y7aswkeuHtSBEs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa1GDcAAoJEJykq7OBq3PIfPAIAJxGO/0oioO8PDzQWJLXpeGj
7VJkzVrGivp7M7082aEAHNDa0Z7NEKQn8DVvY4zodu8yBwsT8DohkBSyzjsSLYuR
CLsq+8JvSyHzcdr/qlE1CC4j54qPybQF1z/qECl+yFDSf8do+gqbSj5OIXhDtAfk
kGUOuRU2IjFnZ9mWODzOJD+LkDlRsJuEd/gVJeZSM7YQgW/MEmad0XtDx0lPQzrI
qcbSKDMTZmBMk4ZFIqlgtYfqp/uiBB/qmSQLwFRoGYS0DdbBhQVxzRqgxoTnmaWG
aFPxaae5I2vDLPmVwFjKZ0RS3tRSZ+6bd8bl0TGSOnr30dNxsKt5rk8LtUI+rb0=
=bRig
-----END PGP SIGNATURE-----

--11Y7aswkeuHtSBEs--
