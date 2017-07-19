Received: from eggs.gnu.org ([2001:4830:134:3::10]:59995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXoTb-000458-E9
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 08:53:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXoTa-0003OO-AV
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 08:53:15 -0400
References: <1500453887-20819-1-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <92d9f1c3-13d3-1d53-709a-30b38e5aac9c@redhat.com>
Date: Wed, 19 Jul 2017 07:45:06 -0500
MIME-Version: 1.0
In-Reply-To: <1500453887-20819-1-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Wu5HElm17cRfUijhRuju9cLisNkwSVmVd"
Subject: Re: [Qemu-devel] [PATCH for-2.10] block: Skip implicit nodes in
 query-block/blockstats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, armbru@redhat.com, pkrempa@redhat.com, nsoffer@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Wu5HElm17cRfUijhRuju9cLisNkwSVmVd
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, armbru@redhat.com, pkrempa@redhat.com,
 nsoffer@redhat.com, qemu-devel@nongnu.org
Message-ID: <92d9f1c3-13d3-1d53-709a-30b38e5aac9c@redhat.com>
Subject: Re: [PATCH for-2.10] block: Skip implicit nodes in
 query-block/blockstats
References: <1500453887-20819-1-git-send-email-kwolf@redhat.com>
In-Reply-To: <1500453887-20819-1-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/19/2017 03:44 AM, Kevin Wolf wrote:
> Commits 0db832f and 6cdbceb introduced the automatic insertion of filte=
r
> nodes above the top layer of mirror and commit block jobs. The
> assumption made there was that since libvirt doesn't do node-level
> management of the block layer yet, it shouldn't be affected by added
> nodes.

Those both landed in 2.9.  So this is a regression we're trying to fix.

>=20
> This is true as far as commands issued by libvirt are concerned. It onl=
y
> uses BlockBackend names to address nodes, so any operations it performs=

> still operate on the root of the tree as intended.
>=20
> However, the assumption breaks down when you consider query commands,
> which return data for the wrong node now. These commands also return
> information on some child nodes (bs->file and/or bs->backing), which
> libvirt does make use of, and which refer to the wrong nodes, too.
>=20
> One of the consequences is that oVirt gets wrong information about the
> image size and stops the VM in response as long as a mirror or commit
> job is running:
>=20
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1470634
>=20
> This patch fixes the problem by hiding the implict nodes created
> automatically by the mirror and commit block jobs in the output of
> query-block and BlockBackend-based query-blockstats as long as the user=

> doesn't indicate that they are aware of those nodes by providing a node=

> name for them in the QMP command to start the block job.

The approach makes sense to me.  I see from the rest of this thread that
you'll need a v2 to get the implementation of the approach correct, but
I think you're on the right track.

>=20
> The node-based commands query-named-block-nodes and query-blockstats
> with query-nodes=3Dtrue still show all nodes, including implicit ones.
> This ensures that users that are capable of node-level management can
> still access the full information; users that only know BlockBackends
> won't use these commands.
>=20
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Wu5HElm17cRfUijhRuju9cLisNkwSVmVd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllvVFIACgkQp6FrSiUn
Q2qNQAf9Hi4FE8Aa1SuGcju+vbkiANhK/4YgdF+r8ATwLo3pFT6XiApx0ReRRbay
w8CVV3pz8OgEXSYZyOYvzAWBFCrqQQTld8loqEmp6HwJoPddVE48jNQeIWcZtidX
csQ0UxmSvhHW1vGcMZvVbhbPId6ja3yhuI2c9p5mN9QcQnsniLf/wjiePjjBli45
/Lj19x5xI0Oi3iU5Oh9St+dd0O8yjLoX3ipvgFijgwp2/SLPgBxFRn5xRLCSBszu
1jyU6D84CzqBiZ2Q7QUD7Zr8Bof9FJoIkMFHhVVDerRjNvO2XWilcz1xaCunxicH
qgy2l8QI1kvXEUocymRLMO1RBi6KGg==
=loC1
-----END PGP SIGNATURE-----

--Wu5HElm17cRfUijhRuju9cLisNkwSVmVd--
