Received: from eggs.gnu.org ([2001:4830:134:3::10]:34108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXqOQ-0003QP-F0
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 10:56:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXqOP-0001ml-DH
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 10:56:02 -0400
References: <1500472685-25246-1-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2e750f9b-8a7f-44be-a673-8046aa73f914@redhat.com>
Date: Wed, 19 Jul 2017 09:55:51 -0500
MIME-Version: 1.0
In-Reply-To: <1500472685-25246-1-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XusaFO3eLtaSL4CsJBujPgPPX55JdhQLx"
Subject: Re: [Qemu-devel] [PATCH for-2.10 v2] block: Skip implicit nodes in
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
--XusaFO3eLtaSL4CsJBujPgPPX55JdhQLx
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, armbru@redhat.com, pkrempa@redhat.com,
 nsoffer@redhat.com, el13635@mail.ntua.gr, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Message-ID: <2e750f9b-8a7f-44be-a673-8046aa73f914@redhat.com>
Subject: Re: [PATCH for-2.10 v2] block: Skip implicit nodes in
 query-block/blockstats
References: <1500472685-25246-1-git-send-email-kwolf@redhat.com>
In-Reply-To: <1500472685-25246-1-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/19/2017 08:58 AM, Kevin Wolf wrote:
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

I'm a bit worried about this statement.  Libvirt controls the
BLOCK_WRITE_THRESHOLD event via block-set-write-threshold, which
requires the use of a node name (for a qcow2-backed-by-block-device, you
want the threshold to be tied to the block-device protocol BDS, not the
qcow2 format BDS).  We need to test that this patch does not break
write-threshold computation (ie. that libvirt is still able to use the
query commands to learn WHICH node name to pass to
block-set-write-threshold).

Or put another way, there are two types of implicit nodes names: the
implicit node names for protocol BDS (libvirt cares about those), and
the implicit node names for block job temporary BDS (libvirt does not
care about those).  If this patch is touching ONLY the block job
implicit node names, we may be okay - but that's something we want to
test with libvirt before accepting this patch.  Peter, are you in a
position to test it faster than me?

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

Current libvirt is using both of those commands, mainly in support of
computing the generated node name to pass to block-set-write-threshold.
So the fact that these are not filtered may still be enough for libvirt
to get everything it needs.

>=20
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>=20
> v2:
> - Skip implicit nodes not only on the top level, but also during the re=
cursive
>   calls [Peter]
> - Spelling fix in the commit message [Manos]
>=20
At any rate, the code looks okay to me, so now it's just a matter of
testing that the patch doesn't break libvirt's other uses, while fixing
the incorrect allocation reporting while a job is active.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--XusaFO3eLtaSL4CsJBujPgPPX55JdhQLx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllvcvcACgkQp6FrSiUn
Q2qRPAgAlFRLLaD+hrQTM2tkuA9+SyCt5nkmXP5GYWZ67O4tPa68inSQGrTVhb1p
g46T5isqHny7uwP2Gk2b5kzOwU5pDB4KQeD6xmJ2qRdcL6lEuKJQ12WZ73scT3r5
tCE/fidR1NT6eID+VwqoXMW79YaE1e6jIoxknUoNylyz3EFvahcNGMkElBcKucWL
JMEMoh3Fr5ukzvlNu/osQlMrzyoKBcQ+Bet5+oF6YDPZJwI38cmMbDVGfxjxbxMX
rOsjXWlfVyp1BtLKU2pe9+saO2a3F4ohZ8usOZTuH3TEUikl8V8i0YrLwvSAoV7x
5FZ+sz+RVjDAjHw+eLojgRAp+lLEBQ==
=gcg/
-----END PGP SIGNATURE-----

--XusaFO3eLtaSL4CsJBujPgPPX55JdhQLx--
