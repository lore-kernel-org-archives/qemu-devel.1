Received: from eggs.gnu.org ([2001:4830:134:3::10]:35621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egZJ8-0001Sd-Ha
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 12:03:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egZIh-0005t6-Dw
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 12:02:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:1358)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1egZIh-0005ri-4w
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 12:02:27 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2C1283D943
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 17:02:26 +0000 (UTC)
References: <20180130102202.28519-1-armbru@redhat.com>
	<20180130102202.28519-9-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6bffa91e-e573-3777-c7a9-86b72d548247@redhat.com>
Date: Tue, 30 Jan 2018 11:02:24 -0600
MIME-Version: 1.0
In-Reply-To: <20180130102202.28519-9-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="55pOar9kRzq7xuVpv1dFSGEQHaJrSDeci"
Subject: Re: [Qemu-devel] [PATCH 08/18] qdict qlist: Make most helper macros
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--55pOar9kRzq7xuVpv1dFSGEQHaJrSDeci
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <6bffa91e-e573-3777-c7a9-86b72d548247@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 08/18] qdict qlist: Make most helper macros
 functions
References: <20180130102202.28519-1-armbru@redhat.com>
 <20180130102202.28519-9-armbru@redhat.com>
In-Reply-To: <20180130102202.28519-9-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/30/2018 04:21 AM, Markus Armbruster wrote:
> The macro expansions of qdict_put_TYPE() and qlist_append_TYPE() need
> qbool.h, qnull.h, qnum.h and qstring.h to compile.  We include qnull.h
> and qnum.h in the headers, but not qbool.h and qstring.h.  Works,
> because we include those wherever the macros get used.
>=20
> Open-coding these helpers is of dubious value.  Turn them into
> functions and drop the includes from the headers.
>=20
> This cleanup makes the number of objects depending on qapi/qmp/qnum.h
> from 4548 (out of 4739) to 46 in my "build everything" tree.  For
> qapi/qmp/qnull.h, the number drops from 4549 to 21.

Impressive!


> +++ b/qobject/qdict.c
> @@ -14,6 +14,7 @@
>  #include "qapi/qmp/qnum.h"
>  #include "qapi/qmp/qdict.h"
>  #include "qapi/qmp/qbool.h"
> +#include "qapi/qmp/qnull.h"
>  #include "qapi/qmp/qstring.h"
>  #include "qapi/qmp/qobject.h"
>  #include "qapi/error.h"
> @@ -143,6 +144,26 @@ void qdict_put_obj(QDict *qdict, const char *key, =
QObject *value)
>      }
>  }
> =20
> +void qdict_put_int(QDict *qdict, const char *key, int64_t value)
> +{
> +    qdict_put(qdict, key, qnum_from_int(value));
> +}

If I'm not mistaken (although I didn't actually test), this triggers a
false positive in scripts/coccinelle/qobject.cocci, no?  Is there a
convenient way to tell coccinelle that a rewrite pattern applies
everywhere except for where the pattern itself is implemented?  But even
if not, we can always use manual inspection when rerunning Coccinelle to
make sure we don't turn these into infinite loops.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--55pOar9kRzq7xuVpv1dFSGEQHaJrSDeci
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpwpSAACgkQp6FrSiUn
Q2pNVwf/SVdyTDMJ5hOyL6zkTWMol456/QLSXoiRPb+GGxFdN8JSO1o0R6VJmqAa
6ViU7uTkD0JeSflxFNeEyE2CHUmAu0Pv59U5p1b3vF3LdXzsyCM0aWJ4LUl1ty+u
dQtBhf8AAGUvPbsErhnTtp85SsWmvA7KtXvXpWdfRWA+inc17Zx0ckkvVVm+8Moe
FSBOgyBnLvkOax1TiJeokw2zQ/8M9Jmid080xh5lo/cXplnfPpqPZY1tWGwrdOpS
+T2kcLR5FsokOWOqOdlGIMZFLnIjonlvHXvqs5xuBJADKrGfAvCk7M5odOuYGsxE
aMsTX4I3k6ZbgWMa/urgZ117CxbJZg==
=H2lr
-----END PGP SIGNATURE-----

--55pOar9kRzq7xuVpv1dFSGEQHaJrSDeci--
