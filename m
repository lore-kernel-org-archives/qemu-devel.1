Received: from eggs.gnu.org ([2001:4830:134:3::10]:57524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPx0F-0002sm-TD
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 16:22:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPx0C-0006aV-Ph
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 16:22:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dPx0C-0006aD-GC
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 16:22:24 -0400
References: <20170613165313.20954-1-ehabkost@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <68640db9-3a9d-6542-3d1b-da62a1f11d9d@redhat.com>
Date: Tue, 27 Jun 2017 15:22:21 -0500
MIME-Version: 1.0
In-Reply-To: <20170613165313.20954-1-ehabkost@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BawM4IdiTM2Gt71XCsFKVIFOlFoRctdRf"
Subject: Re: [Qemu-devel] [RFC 00/15] Error API: Flag errors in *errp even
 if errors are being ignored
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BawM4IdiTM2Gt71XCsFKVIFOlFoRctdRf
From: Eric Blake <eblake@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <68640db9-3a9d-6542-3d1b-da62a1f11d9d@redhat.com>
Subject: Re: [Qemu-devel] [RFC 00/15] Error API: Flag errors in *errp even if
 errors are being ignored
References: <20170613165313.20954-1-ehabkost@redhat.com>
In-Reply-To: <20170613165313.20954-1-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/13/2017 11:52 AM, Eduardo Habkost wrote:

> The Proposal
> ------------
>=20
> I'm proposing replacing NULL errp with a special macro:
> IGNORE_ERRORS.  The macro will trigger special behavior in the
> error API that will make it not save any error information in the
> error pointer, but still keep track of boolean error state in
> *errp.
>=20
> This will allow us to simplify the documented method to propagate error=
s
> from:
>=20
>     Error *err =3D NULL;
>     foo(arg, &err);
>     if (err) {
>         handle the error...
>         error_propagate(errp, err);
>     }
>=20
> to:
>=20
>     foo(arg, errp);
>     if (ERR_IS_SET(errp)) {
>         handle the error...
>     }

Seems kind of neat to me!


>=20
> This way, we can make ERR_IS_SET work even if errp was
> IGNORE_ERRORS.  The ERR_IS_* macros are reimplemented as:
>=20
>   #define ERR_IS_SET(e) (*(e) && *(e) !=3D &ignored_error_unset)
>   #define ERR_IS_IGNORED(e) (!(e) || *(e) =3D=3D &ignored_error_unset |=
| *(e) =3D=3D &ignored_error_set)

Where the initial NULL checks go away if you get your way with a final
patch.

>=20
> Ensuring errp is never NULL
> ---------------------------
>=20
> The last patch on this series changes the (Error **errp)
> parameters in functions to (Error *errp[static 1]), just to help
> validate the existing code, as clang warns about NULL arguments
> on that case.  I don't think we should apply that patch, though,
> because the "[static 1]" syntax confuses Coccinelle.

Have you filed a bug report to the Coccinelle folks?  But yeah, it is
rather arcane C99 syntax that you don't see much of in common code.

> (Probably the easiest solution for that is to add assert(errp)
> lines to the ERR_IS_*() macros.)

Or even having the macros use a forced dereference through errp->xxx may
at least be enough for Coverity to catch things.

> Git branch
> ----------
>=20
> This series depend on a few extra cleanups that I didn't submit
> to qemu-devel yet.  A git branch including this series is
> available at:
>=20
>   git://github.com/ehabkost/qemu-hacks.git work/err-api-rework-ignore-p=
tr-v1
>=20
> Eduardo Habkost (15):
>   tests: Test cases for error API
>   error: New IGNORE_ERRORS macro
>   Add qapi/error.h includes on files that will need it
>   [coccinelle] Use IGNORE_ERRORS instead of NULL as errp argument
>   qapi: Use IGNORE_ERRORS instead of NULL on generated code
>   test-qapi-util: Use IGNORE_ERRORS instead of NULL
>   Manual changes to use IGNORE_ERRORS instead of NULL
>   error: New ERR_IS_* macros for checking Error** values
>   [coccinelle] Use ERR_IS_* macros
>   test-qapi-util: Use ERR_IS_* macros
>   Manual changes to use ERR_IS_* macros
>   error: Make IGNORED_ERRORS not a NULL pointer
>   rdma: Simplify var declaration to avoid confusing Coccinelle
>   [coccinelle] Eliminate unnecessary local_err/error_propagate() usage
>   [test only] Use 'Error *err[static 1]' instead of 'Error **errp' to
>     catch NULL errp arguments

I have not reviewed the series yet, but the idea looks promising.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--BawM4IdiTM2Gt71XCsFKVIFOlFoRctdRf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZUr59AAoJEKeha0olJ0NqoEEH/0joYfToHmv+alXa5C4p7tXs
jjiq463r3uLza506PXKO4Qc8aygSEQEfjXlv6L2GIkt9d5hVahSp4JepZFtIFpMc
/QZY0acxIEZYWm4XgIjfv+qybjV0LXx4oX5sEYgYRCDdsX1/OLXpnCYA54gbEA/e
cz2PLXWCWkshWKY+k1RiLoFKdYeaBk9L+UqpogcWIMbHihdXhhmG2CaODZPG7cDo
gAmF9rwY82RYEuAS6SFAX+r7+aJ4yKCLEz0iHaLmFoIp/h23vfgEBym2ZlPxQKQW
kfz9Vp+usaJaJYvhnsia+cyeQ0kOaqjnTK9XEASUiJcT1YeOubQRS+oZMS3aQfc=
=fMYg
-----END PGP SIGNATURE-----

--BawM4IdiTM2Gt71XCsFKVIFOlFoRctdRf--
