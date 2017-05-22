Received: from eggs.gnu.org ([2001:4830:134:3::10]:34295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCpl9-00075c-CB
	for qemu-devel@nongnu.org; Mon, 22 May 2017 12:00:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCpl6-0004ED-9E
	for qemu-devel@nongnu.org; Mon, 22 May 2017 12:00:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dCpl5-0004E2-Vm
	for qemu-devel@nongnu.org; Mon, 22 May 2017 12:00:36 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A25ACC059729
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 16:00:34 +0000 (UTC)
References: <20170519180342.19618-1-berrange@redhat.com>
	<20170519180342.19618-6-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b8303243-384c-88a5-b372-c6e3e429e628@redhat.com>
Date: Mon, 22 May 2017 11:00:26 -0500
MIME-Version: 1.0
In-Reply-To: <20170519180342.19618-6-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="17RBL5xkVDDIiJ6hxsNPJhU64WXSRtbxX"
Subject: Re: [Qemu-devel] [PATCH v2 5/5] tests: add functional test
 validating ipv4/ipv6 address flag handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--17RBL5xkVDDIiJ6hxsNPJhU64WXSRtbxX
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <b8303243-384c-88a5-b372-c6e3e429e628@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 5/5] tests: add functional test validating
 ipv4/ipv6 address flag handling
References: <20170519180342.19618-1-berrange@redhat.com>
 <20170519180342.19618-6-berrange@redhat.com>
In-Reply-To: <20170519180342.19618-6-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/19/2017 01:03 PM, Daniel P. Berrange wrote:
> The semantics around handling ipv4=3Don|off & ipv6=3Don|off are quite
> subtle to understand in combination with the various hostname addresses=

> and backend types. Introduce a massive test matrix that launches QEMU
> and validates the ability to connect a client on each protocol as
> appropriate.
>=20
> The test requires that the host has ability to bind to both :: and
> 0.0.0.0, on port 9000. If either protocol is not available, or if
> something is already listening on that port the test will skip.
>=20
> Although it isn't using the QTest APIs, it expects the
> QTEST_QEMU_BINARY env variable to be set.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  tests/.gitignore           |   1 +

Nice - that often gets forgotten.

>  tests/Makefile.include     |   4 +
>  tests/test-sockets-proto.c | 855 +++++++++++++++++++++++++++++++++++++=
++++++++
>  3 files changed, 860 insertions(+)
>  create mode 100644 tests/test-sockets-proto.c

'make check' passed for me with your patches (on a system with both IPv4
and IPv6 support), so:

Tested-by: Eric Blake <eblake@redhat.com>

I did not try what happens on an IPv4-only system, presumably the test
still behaves sanely there (where sanely may mean skipping rather than
completing?).

> +++ b/tests/test-sockets-proto.c
> @@ -0,0 +1,855 @@
> +/*
> + * QTest for IPv4/IPv6 protocol setup
> + *
> + * Copyright (c) 2017 Red Hat, Inc. and/or its affiliates

Interesting choice of attribution line.


> +/*
> + * This is the giant matrix of combinations we need to consider.
> + * There are 3 axes we deal with
> + *
> + * Axis 1: Protocol flags:
> + *
> + *  ipv4=3Dunset, ipv6=3Dunset  -> v4 & v6 clients ([1]
> + *  ipv4=3Dunset, ipv6=3Doff    -> v4 clients only
> + *  ipv4=3Dunset, ipv6=3Don     -> v6 clients only
> + *  ipv4=3Doff, ipv6=3Dunset    -> v6 clients only
> + *  ipv4=3Doff, ipv6=3Doff      -> error - can't disable both [2]
> + *  ipv4=3Doff, ipv6=3Don       -> v6 clients only
> + *  ipv4=3Don, ipv6=3Dunset     -> v4 clients only
> + *  ipv4=3Don, ipv6=3Doff       -> v4 clients only
> + *  ipv4=3Don, ipv6=3Don        -> v4 & v6 clients [3]
> + *
> + * Depending on the listening address, some of those combinations
> + * may result in errors. eg ipv4=3Doff,ipv6=3Don combined with 0.0.0.0=

> + * is nonsensical.
> + *
> + * [1] Some backends only support a single socket listener, so
> + *     will actually only allow v4 clients
> + * [2] QEMU should fail to startup in this case
> + * [3] If hostname is "" or "::", then we get a single listener
> + *     on IPv6 and thus can also accept v4 clients. For all other
> + *     hostnames, have same problem as [1].

Makes sense.

> + *
> + * Axis 2: Listening address:
> + *
> + *  ""        - resolves to 0.0.0.0 and ::, in that order
> + *  "0.0.0.0" - v4 clients only
> + *  "::"      - Mostly v6 clients only. Some scenarios should
> + *              permit v4 clients too.

Correct.

> + *
> + * Axis 3: Backend type:
> + *
> + *  Migration - restricted to a single listener. Also relies
> + *              on buggy inet_parse() which can't accept
> + *              =3Doff/=3Don parameters to ipv4/ipv6 flags
> + *  Chardevs  - restricted to a single listener.
> + *  VNC       - supports multiple listeners. Also supports
> + *              socket ranges, so has extra set of tests
> + *              in the matrix

And explains the size of the test.  Thankfully it doesn't seem to add
too much noticeable additional time to 'make check'.

> + *
> + */
> +static QSocketsData test_data[] =3D {
> +    /* Migrate with "" address */
> +    /* XXX all settings with =3Doff are disabled due to inet_parse() b=
ug */
> +    /* XXX multilistener bug - should be .ipv6 =3D 1 */

Nice that you've pointed out spots for further improvements, and where
we EXPECT the test to change once we improve the code.


> +static pid_t run_qemu(const char *args)
> +{
> +    const char *pidfile =3D "test-sockets-proto.pid";
> +    char *pidstr;
> +    pid_t child;
> +    int status;
> +    pid_t ret;
> +    const char *binary =3D getenv("QTEST_QEMU_BINARY");
> +    long pid;
> +    if (binary =3D=3D NULL) {
> +        g_printerr("Missing QTEST_QEMU_BINARY env variable");
> +    }
> +    g_assert(binary !=3D NULL);

Should we do:

if (!binary) {
  message;
  exit(1);
}

instead of relying on g_assert() to do the exit?

> +    /* Now test IPv6 */
> +    child =3D run_qemu(data->args);
> +
> +    /*
> +     * The child should always succeed, because its the
> +     * same config as the succesful run we just did above

s/succesful/successful/

> +
> +int main(int argc, char **argv)
> +{
> +    int ret;
> +    gsize i;
> +
> +    if (check_protocol_support() < 0) {
> +        return 0; /* Skip test if we can't bind */

We don't have a magic number for skipped tests?  Many projects use exit
status 77 (rather than 0) to delineate a test that did not fail, but
whose skip results cannot be used as conclusive evidence of passing.  At
any rate, you've answered my question earlier - you do behave sanely if
you cannot test both IPv4 and IPv6 on a given host.

Typo is worth fixing, but minor enough that I'm comfortable giving:
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--17RBL5xkVDDIiJ6hxsNPJhU64WXSRtbxX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZIwsaAAoJEKeha0olJ0NqUDoIAIaB9nHcqhwM73iBiLKmqiKM
INdYIAJfZmTLe2VqTkn641f3rr/2y4XHavOQ7A0PRNd5SP/6Wixc1czJaYrFE6Wp
LnYI7CptPvaogQcQdy1Ex+EBx705JKH2V03Bl6EG2g/SgGyg8zv53HXjb7PT0Yci
PhC1zwmXkmIAO+4mzWTMo9jXxiwKPXcV60ABcA6TMAFEgn6bgVEKATa9yZps2Av5
5ROYqGZC2Bs2jm0Fxlcyf6E/iFgKwjbGOsrGvg5MetEqW6aJO+bA3jBWIC37uZIF
E5Qaumck0bVHMDUoW2cM/CVeYMaLa47cNG55F5GZtTxU6KeXjHNVv96PU0EcPJ4=
=fmjc
-----END PGP SIGNATURE-----

--17RBL5xkVDDIiJ6hxsNPJhU64WXSRtbxX--
