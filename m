Received: from eggs.gnu.org ([2001:4830:134:3::10]:49106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cinJN-0004Vp-Re
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:19:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cinJJ-0003KV-SM
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 14:19:49 -0500
References: <1488194450-28056-1-git-send-email-armbru@redhat.com>
	<1488194450-28056-13-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f2beae5b-482d-7151-cb7a-1f103e031f3b@redhat.com>
Date: Tue, 28 Feb 2017 13:19:38 -0600
MIME-Version: 1.0
In-Reply-To: <1488194450-28056-13-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8LMrfpq81wmeISbb0fu5wi32SifiDmrFj"
Subject: Re: [Qemu-devel] [PATCH 12/24] qobject: Propagate parse errors
 through qobject_from_json()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com, "mdroth@linux.vnet.ibm.commdroth"@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8LMrfpq81wmeISbb0fu5wi32SifiDmrFj
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, pkrempa@redhat.com,
 "mdroth@linux.vnet.ibm.commdroth"@linux.vnet.ibm.com
Message-ID: <f2beae5b-482d-7151-cb7a-1f103e031f3b@redhat.com>
Subject: Re: [PATCH 12/24] qobject: Propagate parse errors through
 qobject_from_json()
References: <1488194450-28056-1-git-send-email-armbru@redhat.com>
 <1488194450-28056-13-git-send-email-armbru@redhat.com>
In-Reply-To: <1488194450-28056-13-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/27/2017 05:20 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block.c                            |  2 +-
>  include/qapi/qmp/qjson.h           |  5 +--
>  monitor.c                          |  2 +-
>  qobject/qjson.c                    |  4 +--
>  tests/check-qjson.c                | 62 +++++++++++++++++++-----------=
--------
>  tests/test-visitor-serialization.c |  2 +-
>  6 files changed, 39 insertions(+), 38 deletions(-)
>=20

As with 8/24, this would be a good place for the commit message to
mention that this patch adds the parameter and mechanically adjusts
callers with minimal semantic changes, but that later patches will take
advantage of the parameter.

> +++ b/include/qapi/qmp/qjson.h
> @@ -17,8 +17,9 @@
>  #include "qapi/qmp/qobject.h"
>  #include "qapi/qmp/qstring.h"
> =20
> -QObject *qobject_from_json(const char *string);
> -QObject *qobject_from_jsonf(const char *string, ...) GCC_FMT_ATTR(1, 2=
);
> +QObject *qobject_from_json(const char *string, Error **errp);

The real change here, vs.

> +QObject *qobject_from_jsonf(const char *string, ...)
> +    GCC_FMT_ATTR(1, 2);

formatting.  Should the formatting be hoisted earlier in the series,
when you first touch qobject_from_jsonv?

>  QObject *qobject_from_jsonv(const char *string, va_list *ap, Error **e=
rrp)
>      GCC_FMT_ATTR(1, 0);

This makes qobject_from_jsonf() and qobject_from_jsonv() asymmetric
(only one of the two can report errors); and looks a bit weird to have a
va_list not as the last argument (as it is, a 'va_list *' argument is
already weird).  If symmetry is important, we can put errp prior to the
=2E../ap argument (then both forms have an errp pointer).  But I don't
think it matters in the context of this series.  If you DO change it,
though, then 8/24 would be the place to tweak it.

At one point, I posted a series that removed all uses of
qobject_from_json[fv] (leaving just qobject_from_json); at the time,
there was not a strong opinion on whether the series was worthwhile, but
if we want it, I'm fine rebasing on top of this.  (One argument in favor
of my series would be getting rid of the weird 'va_list *' argument).

> +++ b/qobject/qjson.c
> @@ -50,9 +50,9 @@ QObject *qobject_from_jsonv(const char *string, va_li=
st *ap, Error **errp)
>      return state.result;
>  }
> =20
> -QObject *qobject_from_json(const char *string)
> +QObject *qobject_from_json(const char *string, Error **errp)
>  {
> -    return qobject_from_jsonv(string, NULL, NULL);
> +    return qobject_from_jsonv(string, NULL, errp);

Of course, if you rebase the series to rearrange where errp appears in
relation to va_list, then be sure this changes to match (the compiler
may or may not flag it, if va_list looks too much like void*).

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--8LMrfpq81wmeISbb0fu5wi32SifiDmrFj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtc1KAAoJEKeha0olJ0NqF+QH/jom5PL0ZC0N6Fq3qG0En3cr
8P2vErnADxCPcXPBO6eGJzj0Ws06uRqHBO9QnW4AklphpzYaK7j/FhpJLeM20E7a
AtQjUV1YPsQJGyeBNODI64xmKzznWCCUA4AMjs5bQ7jzcidGGcsQJ5/DjTtra2hb
PaX4eKvFgvPobCd49OpfzuK/vI224cSEu7tXxMIUX/7KTIJvOzGgmyj17LB7LBGN
+dr0MJIam8Km8gmFWxHRq3yzvjXX0FrsPQB3WDlf2y0XYgoJr8aetV9TseeR7/SI
h8KEdOuHaS8oGyFRU8OKId/LiubcURBqmGIyLjTy5Gd9o/idpcesUOT6jLrrKQk=
=GuDi
-----END PGP SIGNATURE-----

--8LMrfpq81wmeISbb0fu5wi32SifiDmrFj--
