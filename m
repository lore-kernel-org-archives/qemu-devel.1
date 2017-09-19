Received: from eggs.gnu.org ([2001:4830:134:3::10]:33453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duPRn-0004o9-4b
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 16:48:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1duPRj-0000YB-TG
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 16:48:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55972)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1duPRj-0000XI-Jv
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 16:48:43 -0400
References: <1505375436-28439-1-git-send-email-peterx@redhat.com>
	<1505375436-28439-3-git-send-email-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f9ef8d51-0fac-efa0-a358-8c3a3e92e894@redhat.com>
Date: Tue, 19 Sep 2017 15:48:35 -0500
MIME-Version: 1.0
In-Reply-To: <1505375436-28439-3-git-send-email-peterx@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bew4aSDvhoVNcNHFNrLWcStCGRTkmGbLt"
Subject: Re: [Qemu-devel] [RFC 02/15] qobject: allow NULL for
 qstring_get_str()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bew4aSDvhoVNcNHFNrLWcStCGRTkmGbLt
From: Eric Blake <eblake@redhat.com>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>,
 Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <f9ef8d51-0fac-efa0-a358-8c3a3e92e894@redhat.com>
Subject: Re: [RFC 02/15] qobject: allow NULL for qstring_get_str()
References: <1505375436-28439-1-git-send-email-peterx@redhat.com>
 <1505375436-28439-3-git-send-email-peterx@redhat.com>
In-Reply-To: <1505375436-28439-3-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/14/2017 02:50 AM, Peter Xu wrote:
> Then I can get NULL rather than crash when calling things like:
>=20
>   qstring_get_str(qobject_to_qstring(object));
>=20
> when key does not exist.

Right now, qdict_get_str() is documented as:

 * This function assumes that 'key' exists and it stores a
 * QString object.

Your code changes that, by making it now return NULL instead of crashing
on what used to be usage in violation of the contract; compared to
qdict_get_try_str() which gracefully returns NULL, but which could use
your new semantics for doing so in fewer lines of code.

I'm not necessarily opposed to the change, but I worry that it has
subtle ramifications that we haven't thought about, as well as
consistency with the rest of the QObject APIs.  It may be better to just
introduce qstring_get_try_str(), which gracefully handles NULL input,
and leave the existing function alone; and if you do introduce a new
helper, it may be worth converting existing clients (perhaps with help
from Coccinelle) to take advantage of the helper.

> +++ b/qobject/qstring.c
> @@ -125,7 +125,7 @@ QString *qobject_to_qstring(const QObject *obj)
>   */
>  const char *qstring_get_str(const QString *qstring)
>  {
> -    return qstring->string;
> +    return qstring ? qstring->string : NULL;
>  }
> =20
>  /**
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--bew4aSDvhoVNcNHFNrLWcStCGRTkmGbLt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnBgqMACgkQp6FrSiUn
Q2p2swf7BR59ZKEPA9szXg5kWSQHqMdcEC5M0d/wyd1oEK4TY4l2AK08xgbcbIDD
IXX3GxGVUL3fhvVsXqaAKaP1+mSnV6yiFfL1VhJ0dDUjpSoScAOit8jzwyJ2vgiR
aA6OZh0az3px4dKWsSS6IujBJXwkiFDECnUDx/f0ncWdVGzWOh5hzgRZB6rBzZ7E
WCwW52TxOqhBdCeT086UxYfzu+drIIaiLGqf04JRztmOXx7SiNkPP+YWBND6lGUx
POL4wutv92Vys81JsygGnKo4kx9O04ZtFQ/TezxLP8zwiJPnqlPwVPA49oBMEa23
5EHdT82y+fQUNuqDbO6oQ33ISSIR9g==
=ZpF4
-----END PGP SIGNATURE-----

--bew4aSDvhoVNcNHFNrLWcStCGRTkmGbLt--
