Received: from eggs.gnu.org ([2001:4830:134:3::10]:38681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dv1x9-0002IH-GR
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:55:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dv1x4-0001ua-Pf
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:55:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47218)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dv1x4-0001u3-Bu
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 09:55:38 -0400
References: <cecb7a50-6913-0d88-59b4-805463aba790@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cd46a9e9-4e9d-9ac8-53ed-34ba1b6f4dc0@redhat.com>
Date: Thu, 21 Sep 2017 08:55:34 -0500
MIME-Version: 1.0
In-Reply-To: <cecb7a50-6913-0d88-59b4-805463aba790@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2QK6ft9qFaODBWWTPvBB7vFKnKvOS9gj6"
Subject: Re: [Qemu-devel] nbd structured reply
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Wouter Verhelst <w@uter.be>, Alex Bligh <alex@alex.org.uk>
Cc: qemu-devel <qemu-devel@nongnu.org>, nbd@other.debian.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2QK6ft9qFaODBWWTPvBB7vFKnKvOS9gj6
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Wouter Verhelst <w@uter.be>, Alex Bligh <alex@alex.org.uk>
Cc: qemu-devel <qemu-devel@nongnu.org>, nbd@other.debian.org
Message-ID: <cd46a9e9-4e9d-9ac8-53ed-34ba1b6f4dc0@redhat.com>
Subject: Re: nbd structured reply
References: <cecb7a50-6913-0d88-59b4-805463aba790@virtuozzo.com>
In-Reply-To: <cecb7a50-6913-0d88-59b4-805463aba790@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

[updating CC to point to the correct new NBD list]

On 09/21/2017 07:18 AM, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
>=20
> I'm about this:
>=20
> "A server SHOULD try to minimize the number of chunks sent in a reply,
> but MUST NOT mark a chunk as final if there is still a possibility of
> detecting an error before transmission of that chunk completes"
>=20
> What do we mean by "possibility"? Formally, such possibility exists
> always, so, we'll never mark a chunk as final.

Here's what is envisioned.  It is fairly easy to write a server that
receives an NBD_CMD_READ, issues the header reply, and only then
dispatches the I/O to collect the data from the file system to send
after the header.  But if you encounter EIO (or other problem) while
reading from the file system, you're stuck if you've already sent the
header.  In this scenario, if you mark the header being as final, you
are unable to report the EIO (it is one of the flaws with non-structured
reads that makes the spec say that if you detect an error after sending
the header, you have no choice but to terminate the connection).

An alternative server implementation would buffer the header, perform
the I/O to collect data from the file system, and only when it is all
present in memory, it finally sends the reply to the client.  In this
scenario, since you wait until all data is buffered, you know up front
whether an error occurred while collecting the I/O, and can therefore
send the data as the final packet right away (whether error or success).
 However, it potentially requires more memory to buffer requests like
this, compared to the server that sends information piecemeal as soon as
it obtains data.

The intent is not to detect errors in sending the data over the wire,
but in detecting errors in reading the data from the underlying storage
(or however else the data to be read is being collected).  A chunk must
not be marked final unless you can guarantee that there will be no
further errors in collecting data for the reply.

If you have suggestions for improving the NBD spec wording, feel free to
propose a doc patch.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--2QK6ft9qFaODBWWTPvBB7vFKnKvOS9gj6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnDxNYACgkQp6FrSiUn
Q2ppmwgAiEdVmporfWDePoXHN7eTIHGo0pjku30CQlegmBdGRv1JFXweREECKmb5
yLSAxrnua8xlz2k0lLpBfCAKk7ew9f05xxZmyCTL6F2PJgq00oEhuTz/OobM3tRQ
fAk1GQU1tpAFuw+ZoAHPVSCXPHPBS02pxfOVuWGfsbzf4BET454xAMEOMLC5YkTp
BsI/reaWXIgvdbYNsIjR3UNEpCzNCAyiQ5EEahkXsISd0pq2t7mxj12fSJ8Lc5p0
VxWtZGd7cuvJiWdJP7hfssw3k8JymLFUljqe++rWotElhYfvHvITgXmNl+4ZtReK
dufhUKXPV3EvbN/OgAOr2HOu+KlLdQ==
=VQzb
-----END PGP SIGNATURE-----

--2QK6ft9qFaODBWWTPvBB7vFKnKvOS9gj6--
