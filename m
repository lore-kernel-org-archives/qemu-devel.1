Received: from eggs.gnu.org ([2001:4830:134:3::10]:58360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eDBpc-0002Xb-6q
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 11:07:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eDBpa-00032u-Ph
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 11:07:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57286)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eDBpa-00031d-Fm
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 11:06:58 -0500
References: <37193dd7-a0fc-bfa6-3870-ecbcfefac4e5@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bf31a83e-7cd6-4f26-595b-3b1a2def883f@redhat.com>
Date: Fri, 10 Nov 2017 10:06:55 -0600
MIME-Version: 1.0
In-Reply-To: <37193dd7-a0fc-bfa6-3870-ecbcfefac4e5@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DggS9k27kjQN7veAGRb9kCEh7uXoox6U5"
Subject: Re: [Qemu-devel] NBD BLOCK_STATUS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Wouter Verhelst <w@uter.be>, Alex Bligh <alex@alex.org.uk>, nbd list <nbd@other.debian.org>, qemu-devel <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DggS9k27kjQN7veAGRb9kCEh7uXoox6U5
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Wouter Verhelst <w@uter.be>, Alex Bligh <alex@alex.org.uk>,
 nbd list <nbd@other.debian.org>, qemu-devel <qemu-devel@nongnu.org>
Message-ID: <bf31a83e-7cd6-4f26-595b-3b1a2def883f@redhat.com>
Subject: Re: NBD BLOCK_STATUS
References: <37193dd7-a0fc-bfa6-3870-ecbcfefac4e5@virtuozzo.com>
In-Reply-To: <37193dd7-a0fc-bfa6-3870-ecbcfefac4e5@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/09/2017 06:42 AM, Vladimir Sementsov-Ogievskiy wrote:
> Hi!
>=20
> Interesting fact: list/set_meta_context options are per-export,
> so, in the server we should keep context selection per client per expor=
t.
>=20
> And it is possible for client to set contexts for one export and than
> proceed
> to transmission phase with another one.

However, we also documented in the spec that

+    A client MUST NOT send `NBD_CMD_BLOCK_STATUS` unless
+    within the negotiation phase it sent `NBD_OPT_SET_META_CONTEXT`
+    at least once, and the final time it was sent, it referred
+    to the export name that was ultimately selected, the server
+    responded without an error, and returned at least one metadata
+    context.

My take on this is if the client calls:

NBD_OPT_SET_META_CONTEXT (export name "foo")
NBD_OPT_GO (export name "bar")

then the server has no contexts to remember, and the client must not
call NBD_CMD_BLOCK_STATUS.  That is, a server is free to track only a
SINGLE list of context ids (namely, the context ids it replied in the
last response to NBD_OPT_SET_META_CONTEXT), and then toss that list on
any further NBD_OPT_SET_META_CONTEXT  or if NBD_OPT_EXPORT_NAME/GO does
not select the same export name, rather than having to track multiple
separate per-export lists while waiting for the client to pick which
export to finally go with.

>=20
> This is not really touched in spec, for example
> "Change the set of active metadata contexts. Issuing this command
> replaces all previously-set metadata contexts"
>=20
> looks like lacking "for specified export" suffix. May be there are othe=
r
> places.

No, it is intentional that it replaces ALL previous contexts (not just
the per-export context), because of the argument that the only context
that matters as a client is the one you use with NBD_OPT_GO, and if you
choose GO with a different export than your last SET_META_CONTEXT, then
you shouldn't be calling NBD_CMD_BLOCK_STATUS.


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--DggS9k27kjQN7veAGRb9kCEh7uXoox6U5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloFzp8ACgkQp6FrSiUn
Q2ptjwf/cURgDg1m34UafDFHUe9tE1q+6Q2nSU7CsRY/43NkYtgnIBjJJno9ASuQ
q7tf1ttvluMPCSPkIJ8yCpdolM1hpJgll6RI9gBTmx7xOGjKB/1bi8RS9dN4pAAU
K7YfuYm90TSkmVMtFEehYpcP04QZ292enrtjdjwzRepIfBPRLcWAFwX49nV41BNz
qeFfiMJMWYxHh1a3WJ3yxLedccNHRt54lZQA0jVk4oSWqJmfJKnpkFwMcQ8IBB5U
Q8VrOc2Pqi+ZtIjA7xwXLVqvdj6lvVFFq6mBL198Xef0EC9XdmnA+K7JGP1hqcR0
NCWVAbYnXom550f/RFk1GxaHzSad4g==
=HQXH
-----END PGP SIGNATURE-----

--DggS9k27kjQN7veAGRb9kCEh7uXoox6U5--
