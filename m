Received: from eggs.gnu.org ([2001:4830:134:3::10]:54994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZ2jM-00080x-8u
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 17:50:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZ2jJ-0003Ub-1L
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 17:50:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eZ2jI-0003Tb-OE
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 17:50:48 -0500
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-4-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3cd3f254-c72a-82ee-765b-f85690dad45a@redhat.com>
Date: Tue, 9 Jan 2018 16:50:39 -0600
MIME-Version: 1.0
In-Reply-To: <20171219084557.9801-4-peterx@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="zFDLMljf8jJStRfv7FgegYYZszSen3Mxa"
Subject: Re: [Qemu-devel] [RFC v6 03/27] qobject: introduce
 qobject_get_try_str()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zFDLMljf8jJStRfv7FgegYYZszSen3Mxa
From: Eric Blake <eblake@redhat.com>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <shajnocz@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>,
 Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com,
 Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <3cd3f254-c72a-82ee-765b-f85690dad45a@redhat.com>
Subject: Re: [RFC v6 03/27] qobject: introduce qobject_get_try_str()
References: <20171219084557.9801-1-peterx@redhat.com>
 <20171219084557.9801-4-peterx@redhat.com>
In-Reply-To: <20171219084557.9801-4-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/19/2017 02:45 AM, Peter Xu wrote:
> A quick way to fetch string from qobject when it's a QString.
>=20
> Reviewed-by: Fam Zheng <famz@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/qapi/qmp/qstring.h |  1 +
>  qobject/qstring.c          | 11 +++++++++++
>  2 files changed, 12 insertions(+)
>=20
> diff --git a/include/qapi/qmp/qstring.h b/include/qapi/qmp/qstring.h
> index a145c8ca00..6517d8e377 100644
> --- a/include/qapi/qmp/qstring.h
> +++ b/include/qapi/qmp/qstring.h
> @@ -28,6 +28,7 @@ QString *qstring_from_substr(const char *str, int sta=
rt, int end);
>  size_t qstring_get_length(const QString *qstring);
>  const char *qstring_get_str(const QString *qstring);
>  const char *qstring_get_try_str(const QString *qstring);
> +const char *qobject_get_try_str(const QObject *qstring);

The naming is consistent, so I won't reject the patch, but 'try_get_str'
reads better than 'get_try_str'.  Of course, fixing the code base to
read well AND be consistent is a much bigger task, and I'm not asking
you to tackle it.


> =20
> +/**
> + * qobject_get_try_str(): Return a pointer of the backstore string

The word "backstore" doesn't appear anywhere in qemu.git, and flags as a
typo.  I'd prefer:

Return a pointer to the corresponding string

or maybe "backing string"

> + *
> + * NOTE: the string will only be returned if the object is valid, and
> + * its type is QString, otherwise NULL is returned.
> + */
> +const char *qobject_get_try_str(const QObject *qstring)
> +{
> +    return qstring_get_try_str(qobject_to_qstring(qstring));
> +}
> +
>  /**
>   * qstring_is_equal(): Test whether the two QStrings are equal
>   */
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--zFDLMljf8jJStRfv7FgegYYZszSen3Mxa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpVRz8ACgkQp6FrSiUn
Q2ogTAf/YAk+vKX7F28wqZlaTNH5lPo9lMtQI5+azXHkmAy/b2TtPWreMJoxbWa5
3e7VBkxyKPRESx9t3/mPiWwEyZ58qmMVUbkgA45+jmmezW9ucV7Usgu2wfo3LiiW
E6zpExVO3jImlS3/HN7NPPejT5Q+3css5OEKa4XjJthpfiB//VdzYV2igL1OZ04w
oBfsPjmxav5tENpIShLINoQbFvzPeJc9HTZsqr+5EmW7Nk1+dZP68s6y99B1yqW+
kUCZFC8ujjZa9NyfOkSEX03gjwGWyEHGTJVRMd4tS70rMVtFANBVTGBknDLxdBcc
8d+kL/CDkWulALgeHZd6LbwHPp14RQ==
=UVng
-----END PGP SIGNATURE-----

--zFDLMljf8jJStRfv7FgegYYZszSen3Mxa--
