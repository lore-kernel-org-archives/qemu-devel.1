Received: from eggs.gnu.org ([2001:4830:134:3::10]:35094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYDWh-0006Lz-Dv
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:38:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYDWe-00023d-6c
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:38:07 -0400
References: <1500556314-32102-1-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f03a930c-7352-6e6a-d306-47a0f31c0ee6@redhat.com>
Date: Thu, 20 Jul 2017 10:37:50 -0500
MIME-Version: 1.0
In-Reply-To: <1500556314-32102-1-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FkeMxWesNrxKoxJlT9QjfsT5nEauwcoQe"
Subject: Re: [Qemu-devel] [PATCH for-2.10 v3] block: Skip implicit nodes in
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
Cc: mreitz@redhat.com, armbru@redhat.com, pkrempa@redhat.com, nsoffer@redhat.com, el13635@mail.ntua.gr, qemu-devel@nongnu.org, qemu-stable@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FkeMxWesNrxKoxJlT9QjfsT5nEauwcoQe
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, armbru@redhat.com, pkrempa@redhat.com,
 nsoffer@redhat.com, el13635@mail.ntua.gr, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Message-ID: <f03a930c-7352-6e6a-d306-47a0f31c0ee6@redhat.com>
Subject: Re: [PATCH for-2.10 v3] block: Skip implicit nodes in
 query-block/blockstats
References: <1500556314-32102-1-git-send-email-kwolf@redhat.com>
In-Reply-To: <1500556314-32102-1-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/20/2017 08:11 AM, Kevin Wolf wrote:
> Commits 0db832f and 6cdbceb introduced the automatic insertion of filte=
r
> nodes above the top layer of mirror and commit block jobs. The
> assumption made there was that since libvirt doesn't do node-level
> management of the block layer yet, it shouldn't be affected by added
> nodes.
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
> This patch fixes the problem by hiding the implicit nodes created
> automatically by the mirror and commit block jobs in the output of
> query-block and BlockBackend-based query-blockstats as long as the user=

> doesn't indicate that they are aware of those nodes by providing a node=

> name for them in the QMP command to start the block job.
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

I ran libvirt against qemu with this patch applied, and tested that I
was able to use the block threshold events through libvirt both on a
domain with no jobs, and then again after I created a mirror job after
setting the threshold (for some reason, libvirt didn't like me setting a
threshold after starting the mirror - but that's a pre-existing
limitation in libvirt).  At any rate, the thresholds behaved the way I
expected, so it looks like libvirt is okay with the change in output.
That, plus your testsuite additions (qemu-iotests passed for me), means
you can add:

Tested-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--FkeMxWesNrxKoxJlT9QjfsT5nEauwcoQe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllwzk4ACgkQp6FrSiUn
Q2prKQf9GB34DsMKSCm6Ip4aSh0fu6DcGTvTXvW4oz2AGVSszXZvgQaA77bNQEoj
R4Me1Oxaw09omktptnS2RRlXYBG40YjYpO0LoWcMADjSlhjffX9ndRKdyLAr+sLD
1F/hA3xr62Xb04LfO6/9lGo1B7rFjlAAtv4fm1u9B2s4ASFJBer2Ax7NsxuxqhXa
SpSDDyt5ERyubAWl4FtSmZW8qn512MA8jiBJxIrYIC+6ZluBNTNwVusf7XteV9wR
PZQsJN31LFzn0LgepXz3gKLwuo3HqsZCGT0xUKLgPRxhJy/P1s6kcq14p7Ccca6t
+lRO+TUW5OZolRaUaE/TP4ZJ5daJSg==
=MnfI
-----END PGP SIGNATURE-----

--FkeMxWesNrxKoxJlT9QjfsT5nEauwcoQe--
