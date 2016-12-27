Received: from eggs.gnu.org ([2001:4830:134:3::10]:40883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cLu7C-0005ew-67
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:56:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cLu79-00067D-5N
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:56:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cLu78-00065w-T1
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:56:35 -0500
References: <20161214150840.10899-1-alex@alex.org.uk>
	<71d6f278-be19-eaeb-7277-c3e6e4512e67@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ec385492-c0a5-63cb-97b5-8105823e6add@redhat.com>
Date: Tue, 27 Dec 2016 09:56:29 -0600
MIME-Version: 1.0
In-Reply-To: <71d6f278-be19-eaeb-7277-c3e6e4512e67@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VljICIKDuNMpdPfj1JbIxpbOvqEIPVTUX"
Subject: Re: [Qemu-devel] [PATCH] Further tidy-up on block status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Alex Bligh <alex@alex.org.uk>, Wouter Verheist <w@uter.be>, nbd-general@lists.sourceforge.net
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Pavel Borzenkov <pborzenkov@virtuozzo.com>, stefanha@redhat.com, "Denis V . Lunev" <den@openvz.org>, Markus Pargmann <mpa@pengutronix.de>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VljICIKDuNMpdPfj1JbIxpbOvqEIPVTUX
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alex Bligh <alex@alex.org.uk>, Wouter Verheist <w@uter.be>,
 nbd-general@lists.sourceforge.net
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Pavel Borzenkov <pborzenkov@virtuozzo.com>, stefanha@redhat.com,
 "Denis V . Lunev" <den@openvz.org>, Markus Pargmann <mpa@pengutronix.de>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Message-ID: <ec385492-c0a5-63cb-97b5-8105823e6add@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] Further tidy-up on block status
References: <20161214150840.10899-1-alex@alex.org.uk>
 <71d6f278-be19-eaeb-7277-c3e6e4512e67@virtuozzo.com>
In-Reply-To: <71d6f278-be19-eaeb-7277-c3e6e4512e67@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/27/2016 08:09 AM, Vladimir Sementsov-Ogievskiy wrote:
> A bit out of topic, but...
>=20
>> structured replies via `NBD_OPT_STRUCTURED_REPLY`.  Conversely, if
>> structured replies are negotiated, the server MUST use a
>> structured reply for any response with a payload, and MUST NOT use
>> a simple reply for `NBD_CMD_READ` (even for the case of an early
>> `EINVAL` due to bad flags), but MAY use either a simple reply or a
>> structured reply to all other requests.
>=20
> What was the reason for it? Why not to negotiate forced structured read=

> separately?

Because the whole reason we (want to) introduce structured replies IS to
fix the inability to do a partial read or an efficient read of zeroes.
The fact that structured reads make other extensions possible is icing
on the cake, but if you are going to implement structured replies at
all, you might as well make reads do it (since reads are mandatory,
while all other commands that utilize structured replies are optional).

> Actually, this spec forces any server, which wants to
> implement structured reply implement structured read too. But what if i=
t
> don't want to? If it only wants to implement BLOCK_STATUS?

We intentionally do not want to permit such a server. Any server that
wants to implement BLOCK_STATUS must also implement structured reads.

>=20
> So, what about changing it, to allow BLOCK_STATUS (or other future
> structured replies) without structured read? Structured read is good
> only for sparse formats,

Not true - it is also good for error recovery even on non-sparse
exports.  The existing read command is flawed in that it cannot be
implemented with partial read support - once the server has started
sending data, it MUST finish sending the number of bytes requested by
the client, which means the server MUST either buffer the read up front
(to ensure no read error is possible once the data sending is started),
or MUST disconnect if a read error is detected partway through.  With
structured reads, you can implement much more efficient servers that
start sending the reply right away without buffering, but which can
still error out on a read error partway through.

> when BLOCK_STATUS is more global. I understand,
> that servers may implement simple (and useless) one-chunk structured
> read, but I think that it is better to fix the spec, to not provoke
> servers use such workaround.

To date, we don't know of ANY servers that implement structured replies
at all, whether for structured reads or for BLOCK_STATUS.  I'm working
on qemu patches to make qemu implement both, and it will serve as an
example of how easy or hard it is to implement things.  But I see NO
reason to weaken the spec to allow structured BLOCK_STATUS without
structured reads.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--VljICIKDuNMpdPfj1JbIxpbOvqEIPVTUX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYYo8tAAoJEKeha0olJ0NqeUgIAKqZAfZCsZUxXjiEajb9dxzb
JM7I2y6yBMf/8oxvJYVXvZ56vtW1KBcRWlLertbKQSNYW2D2ZP9/xggVXrCokVhj
RAGq+hnHZEx8aalTPUS7CszkrHLWiNEJGt1gWKVWT8BBRyrPSNsTk0S8331zdr0r
XenynN69cswQJcblaM7YTnMCXz9ba4Njm0jhlZCwkLxM1dyH6aXDMJgTD6uj1l8w
u81qBXJfjF8ms5uvOCMnQ1lJrhtS/9Xx3lOHVtuYkLH1GUsuqiJ7LGs47FvjQ10x
udL70DtMO/3nDrPgfKAPK1xURPjupqRsWqLzoI77Ng+VbcZ3SJ9cpY+S6BGBsME=
=zMTV
-----END PGP SIGNATURE-----

--VljICIKDuNMpdPfj1JbIxpbOvqEIPVTUX--
