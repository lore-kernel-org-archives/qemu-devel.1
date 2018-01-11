Received: from eggs.gnu.org ([2001:4830:134:3::10]:60723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZlwV-0005hD-ON
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 18:07:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZlwS-0007N7-JR
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 18:07:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eZlwS-0007KR-9y
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 18:07:24 -0500
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-12-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f545e9b6-621b-e2e6-505b-f520625c173d@redhat.com>
Date: Thu, 11 Jan 2018 17:07:11 -0600
MIME-Version: 1.0
In-Reply-To: <20171219084557.9801-12-peterx@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WhKXMPn2RDMJJLI0oUTHDt1kC1U5QUJj9"
Subject: Re: [Qemu-devel] [RFC v6 11/27] qmp: introduce QMPCapability
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
--WhKXMPn2RDMJJLI0oUTHDt1kC1U5QUJj9
From: Eric Blake <eblake@redhat.com>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <shajnocz@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>,
 Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com,
 Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <f545e9b6-621b-e2e6-505b-f520625c173d@redhat.com>
Subject: Re: [RFC v6 11/27] qmp: introduce QMPCapability
References: <20171219084557.9801-1-peterx@redhat.com>
 <20171219084557.9801-12-peterx@redhat.com>
In-Reply-To: <20171219084557.9801-12-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/19/2017 02:45 AM, Peter Xu wrote:
> There was no QMP capabilities defined.  Define the first "oob" as

s/was/were/

> capability to allow out-of-band messages.
>=20
> Also, touch up qmp-test.c to test the new bits.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  monitor.c        | 10 ++++++++--
>  qapi-schema.json | 13 +++++++++++++
>  tests/qmp-test.c | 10 +++++++++-
>  3 files changed, 30 insertions(+), 3 deletions(-)

I'm assuming later patches will document this?

I'm somewhat a fan of documentation alongside or before implementation,
as getting the general overview right and then checking that the code
matches is a bit nicer than random coding then documenting what we ended
up with.  But I don't know if reordering patches in your series is
necessary, as long as the end product is properly documented.

> +++ b/qapi-schema.json
> @@ -118,6 +118,19 @@
>  ##
>  { 'command': 'qmp_capabilities' }

The client can't request a particular feature alongside the command?  Or
is that in later patches?  With just this patch, the enum QMPCapability
is not introspected, because it is not referenced by any command
(although introspection is a bit moot, since the client will learn what
the host advertises from the initial handshake before the client can
even request introspection).

> =20
> +##
> +# @QMPCapability:
> +#
> +# QMP supported capabilities to be broadcasted to the clients.

'broadcast' is one of those weird verbs that doesn't change spelling
when constructing its past tense (there is no 'broadcasted').  However,
I think this description is a bit nicer (and avoids the problematic word
altogether):

Enumeration of capabilities to be advertised during initial client
connection, used for agreeing on particular QMP extension behaviors.

> +#
> +# @oob:   QMP ability to support Out-Of-Band requests.

Rather terse (it doesn't say what Out-Of-Band requests are); even a
pointer to the QMP spec (where OOB is more fully documented) might be
nice (of course, that means we need a patch to docs/interop/qmp-spec.txt
somewhere in the series, especially since this patch renders 2.2.1 in
that document obsolete...)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--WhKXMPn2RDMJJLI0oUTHDt1kC1U5QUJj9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpX7h8ACgkQp6FrSiUn
Q2oK3gf/dUuM5aTyj1KXhXppWO5+wS1NNUhuyP0AFbR2y5RhAY4Sf/im4pOT9hkS
hKHjYMr0TswtB8LWbVYF1BsaK0qCqYLoiRWD/V/1pEhT7Ibqu4j3HTbk4IimBUdC
C6zSBxD15tyMatiTpb8tcyxorut2m2gRxcICzBdC9G5YviXQREeiVlUSux6X+ukk
m82UyjiZY7+TaQS4fVtRdsxSkcIzTvl5ZXI21FT0lcAMXwH5oF8tZVLbfmnE5Y5f
DWwXGOX7oT9jLHeqjSrNF5jLSAEo+uvKxNaBlYv+IDZ9UEbSjR9piIJ7jq7WikKy
OAK+bP2D+Er5QduuZmbaL68isrqE1A==
=/Vkb
-----END PGP SIGNATURE-----

--WhKXMPn2RDMJJLI0oUTHDt1kC1U5QUJj9--
