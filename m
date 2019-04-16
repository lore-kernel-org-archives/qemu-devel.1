Received: from eggs.gnu.org ([209.51.188.92]:44522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hGQMA-0008R2-0q
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 11:50:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hGQM8-0001jg-SM
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 11:50:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hGQM8-0001iZ-Gf
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 11:50:44 -0400
References: <20190416153850.5186-1-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5ee06a0b-90bc-602d-5ee3-3bb3f80f2f6c@redhat.com>
Date: Tue, 16 Apr 2019 10:50:41 -0500
MIME-Version: 1.0
In-Reply-To: <20190416153850.5186-1-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SVCks8YEUtf3ixGkq0K3oBRqsTLfSU9Ud"
Subject: Re: [Qemu-devel] [PATCH] error: Fix error_report_err(),
 warn_report_err() hint printing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SVCks8YEUtf3ixGkq0K3oBRqsTLfSU9Ud
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com
Message-ID: <5ee06a0b-90bc-602d-5ee3-3bb3f80f2f6c@redhat.com>
Subject: Re: [PATCH] error: Fix error_report_err(), warn_report_err() hint
 printing
References: <20190416153850.5186-1-armbru@redhat.com>
In-Reply-To: <20190416153850.5186-1-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/16/19 10:38 AM, Markus Armbruster wrote:
> Before the from qerror_report() to error_setg(), hints looked like

s/the from/the change from/

> this:
>=20
>     qerror_report(QERR_MACRO, ... arguments ...);
>     error_printf_unless_qmp(... hint ...);
>=20
> error_printf_unless_qmp() made perfect sense: it printed exactly when
> qerror_report() did.
>=20
> After the conversion to error_setg():

Commit id?

>=20
>     error_setg(errp, QERR_MACRO, ... arguments ...);
>     error_printf_unless_qmp(... hint ...);
>=20
> The "unless QMP part" still made some sense; in QMP context, the
> caller generally uses the error as QMP response instead of printing
> it.
>=20
> However, everything else is wrong.  If the caller handles the error,
> the hint gets printed anyway (unless QMP).  If the caller reports the
> error, the hint gets printed *before* the report (unless QMP) or not
> at all (if QMP).
>=20
> Commit 50b7b000c91 fixed this by making hints a member of Error.  It

Belongs to 2.5.0.

> kept printing hints with error_printf_unless_qmp():
>=20
>      void error_report_err(Error *err)
>      {
> 	 error_report("%s", error_get_pretty(err));
>     +    if (err->hint) {
>     +        error_printf_unless_qmp("%s\n", err->hint->str);
>     +    }
> 	 error_free(err);
>      }
>=20
> This is wrong.  We should (and now can) print the hint exactly when we
> print the error.
>=20
> The mistake has since been copied to warn_report_err().

Commit id?

>=20
> Fix both to use error_printf().
>=20
> Reported-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Cc: Eric Blake <eblake@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  util/error.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20

Probably too late for 4.0-rc4. Then again, it regressed in 2.5, so
having yet one more release with the lame output doesn't hurt.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--SVCks8YEUtf3ixGkq0K3oBRqsTLfSU9Ud
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAly1+dEACgkQp6FrSiUn
Q2pdfggAmt/iG0db8ks1Y5U/XLGgx9dKwX56yRpCBU+pf2rCFHFpePp//08Sg+9a
goMs4eyi30h1SjEMqWQlZX3C/aPDgG73t6CvJyT5tAUOA5ZzqLz8q93YUj6Qsqfd
g/E3CmxfEbkdHqloPNb6dUWyPRf0DncAcK1y5Z6EDP31ELesZKgqGfzmTrkrvoTy
zbrbtHGWyod6LNbdGE7P0Z7Hku+5GPOEm/+KOs6Q8BDJB7jMQGqcZA6QUTs+LmoD
WRCAx4XwdGvBAf5fngOUqI67Ot5tCBtpa0qMcw9TxPW2f5HFHfKhGUiLZHg0D86a
rfIoO3jVB0nqi8NZJZPCddVw0nptGA==
=aoyA
-----END PGP SIGNATURE-----

--SVCks8YEUtf3ixGkq0K3oBRqsTLfSU9Ud--
