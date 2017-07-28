Received: from eggs.gnu.org ([2001:4830:134:3::10]:43305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1db4Rl-0002Wm-GO
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:32:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1db4Rh-0000K4-Uo
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:32:49 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:36804)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1db4Rh-0000JT-Ni
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 08:32:45 -0400
Received: by mail-wm0-x243.google.com with SMTP id 184so27254373wmo.3
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 05:32:45 -0700 (PDT)
Date: Fri, 28 Jul 2017 13:32:42 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170728123242.GM12364@stefanha-x1.localdomain>
References: <20170725211523.3998-1-eblake@redhat.com>
	<20170725211523.3998-6-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lbQeYSs6J2ITmUo7"
Content-Disposition: inline
In-Reply-To: <20170725211523.3998-6-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 05/12] tests: Clean up string
 interpolation into QMP input (simple cases)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, stefanha@redhat.com


--lbQeYSs6J2ITmUo7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2017 at 04:15:16PM -0500, Eric Blake wrote:
> From: Markus Armbruster <armbru@redhat.com>
>=20
> When you build QMP input manually like this
>=20
>     cmd =3D g_strdup_printf("{ 'execute': 'migrate',"
>                           "'arguments': { 'uri': '%s' } }",
>                           uri);
>     rsp =3D qmp(cmd);
>     g_free(cmd);
>=20
> you're responsible for escaping the interpolated values for JSON.  Not
> done here, and therefore works only for sufficiently nice @uri.  For
> instance, if @uri contained a single "'", qobject_from_jsonv() would
> fail, qmp_fd_sendv() would misinterpret the failure as empty input and
> do nothing, and the test would hang waiting for a response that never
> comes.
>=20
> Leaving interpolation into JSON to qmp() is more robust:
>=20
>     rsp =3D qmp("{ 'execute': 'migrate', 'arguments': { 'uri': %s } }", u=
ri);
>=20
> It's also more concise.
>=20
> Clean up the simple cases where we interpolate exactly a JSON value.
>=20
> Bonus: gets rid of non-literal format strings.  A step towards
> compile-time format string checking without triggering
> -Wformat-nonliteral.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Message-Id: <1500645206-13559-5-git-send-email-armbru@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/libqos/libqos.c   |  16 +----
>  tests/libqos/pci-pc.c   |   9 +--
>  tests/postcopy-test.c   |   8 +--
>  tests/test-qga.c        | 160 +++++++++++++++++++++---------------------=
------
>  tests/vhost-user-test.c |   6 +-
>  5 files changed, 77 insertions(+), 122 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--lbQeYSs6J2ITmUo7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZey7qAAoJEJykq7OBq3PI5u0H/jT60iEfHe2LzwLSkAejspVU
A1X9VAMfizmwr294rLDP/NZs/okLzbcQwZoOwYb+ZR7mQgwuasCYXNolymTtxguv
FOvlus/4nOqQ7VrIZkO68wfRPfh7EOgQ7X8vNmW9kFWEsxYMuXjDS950vXkiM9ug
Rk6Ejydpb5bf6aMsV+r2GY77cEszaPyOhqQW+gPPimuO+qGfDKDiXIHEelE3ldWQ
+CKkv79BocJ2QBwcxXfPPnM0CgRcSqt36Kid7rjw1cFscoGsgVNS72sKRUSVd1Tx
iTno9uhuDh6/tF8OIo1983FqDypuH3vgTE4osF3O17cotlyFOVKH8q9NqPUc2MU=
=NBBd
-----END PGP SIGNATURE-----

--lbQeYSs6J2ITmUo7--
