Received: from eggs.gnu.org ([2001:4830:134:3::10]:50420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drWcn-0003dN-QZ
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 17:52:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drWcj-0000AU-9h
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 17:52:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52700)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1drWci-00009u-W7
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 17:52:09 -0400
References: <20170804012551.2714-1-eblake@redhat.com>
	<20170804012551.2714-6-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6f449d3a-bff7-f3bd-23e2-7b56258ee8c9@redhat.com>
Date: Mon, 11 Sep 2017 16:52:06 -0500
MIME-Version: 1.0
In-Reply-To: <20170804012551.2714-6-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QWwKd5DHMhNqvEmkXa6oDc6daMGb8GsEM"
Subject: Re: [Qemu-devel] [PATCH v4 05/22] qobject: Simplify
 qobject_from_jsonv()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, Michael Roth <mdroth@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QWwKd5DHMhNqvEmkXa6oDc6daMGb8GsEM
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <6f449d3a-bff7-f3bd-23e2-7b56258ee8c9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 05/22] qobject: Simplify
 qobject_from_jsonv()
References: <20170804012551.2714-1-eblake@redhat.com>
 <20170804012551.2714-6-eblake@redhat.com>
In-Reply-To: <20170804012551.2714-6-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/03/2017 08:25 PM, Eric Blake wrote:
> qobject_from_jsonv() was unusual in that it took a va_list*, instead
> of the more typical va_list; this was so that callers could pass
> NULL to avoid % interpolation.  While this works under the hood, it
> is awkward for callers, so move the magic into qjson.c rather than
> in the public interface, and finally improve the documentation of
> qobject_from_jsonf().
>=20

> +/*
> + * va_list form of qobject_from_jsonf().
> + *
> + * IMPORTANT: This function aborts on error, thus it must not
> + * be used with untrusted arguments.
> + */
> +QObject *qobject_from_jsonv(const char *string, va_list ap)
> +{

Given your comments on vararg naming elsewhere in the series, I'm also
thinking this is a good chance to fix this to be named
qobject_from_vjsonf() (making it obvious it is the va_list form of
formatted json, and similar to printf/vprintf or my
qtest_startf/qtest_vstartf in my v7 preliminary cleanup series).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--QWwKd5DHMhNqvEmkXa6oDc6daMGb8GsEM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm3BYYACgkQp6FrSiUn
Q2olIgf+JcsaYL8zlf4KovPybidvgf4qQzO9CcudHF4na36QWkKs4y5CCIh4muW6
xBA7r5hw790Nr2Tvsax4JDzJ+lQ6hJw28Clg05fAhrsEbumuc0LXlGaOUWR9jdYD
FDVU3tfy67Pvn9umiFRZYTjmDhnhZkth/xjrqweU/lAWzaPyOj8Vj6KcYnYzHBtq
ICcssYZfirGY1CWLaA2ayRAscnTSPqozwx98AVv7ffPqpbopDOAba3q9z/wOGC6y
41qvEaNM/VFs1waNvWI2hnAxUIzl09P653/uv0WBlHknNCm5m5iZg5S26ZNEP/eL
p5dnNlNU1teyLmyaTimsFSlk8GoJ5A==
=c01Q
-----END PGP SIGNATURE-----

--QWwKd5DHMhNqvEmkXa6oDc6daMGb8GsEM--
