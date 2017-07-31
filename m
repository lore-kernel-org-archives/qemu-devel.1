Received: from eggs.gnu.org ([2001:4830:134:3::10]:46637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dcCOr-0007lB-Vz
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 11:14:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dcCOn-0001gK-PQ
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 11:14:29 -0400
References: <20170729164104.29537-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ce1a6f7a-749c-7ede-9e4b-d072644b9da4@redhat.com>
Date: Mon, 31 Jul 2017 10:14:16 -0500
MIME-Version: 1.0
In-Reply-To: <20170729164104.29537-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dVcPdK6hL9pQmpPjUvCtIh91Gwe4mcF4H"
Subject: Re: [Qemu-devel] [PATCH v4 0/3] qemu-img check: format allocation
 info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dVcPdK6hL9pQmpPjUvCtIh91Gwe4mcF4H
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
Message-ID: <ce1a6f7a-749c-7ede-9e4b-d072644b9da4@redhat.com>
Subject: Re: [PATCH v4 0/3] qemu-img check: format allocation info
References: <20170729164104.29537-1-vsementsov@virtuozzo.com>
In-Reply-To: <20170729164104.29537-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/29/2017 11:41 AM, Vladimir Sementsov-Ogievskiy wrote:
> Hi all.
>=20
> See 01 patch for the doc.
>=20
> Question to discuss.
> If I understand correctly get_block_status flags allocated, zero, and d=
ata
> actually provide 5 possible combinations, which I combine into three.

There are actually 8 possible bit combinations, but you are right that
some of them are in practice impossible (since the allocated bit can
only be set in cases where the underlying driver set the data or zero bit=
).

>=20
> allocated data zero
> 1         1    1    \__ data

This one is interesting - it means we know the contents read as zero,
but that it occupies space on the disk instead of being a hole;
reporting it as zero may make it easier to punch a hole.

> 1         1    0    /

Yes, definitely data, and no clue if it can be turned into a hole.

> 1         0    1    \__ zero
> 0         0    1    /

Yes, definitely zero.  (The former happens when a format layer directly
reports that the current layer reads as zero; the latter is possible
when a format layer doesn't have an allocation, but where we know
unallocated clusters read as zero, perhaps because there is no backing
file to further fall back to).

> 0         0    0    ___ discarded

Could also mean hasn't been touched yet (discarded sort of implies that
it has been touched at some point in the past)

The other bit patterns:

  0         1    0    - not possible: if a driver sets data, then the
block layer sets allocated

  0         1    1    - ditto
  1         0    0    - not possible: nothing sets the allocated bit in
isolation

>=20
> This division looks not bad, but it is not the only one possible.
> Separating data is really useful - it shows leaked clusters..
> So the question is, don't we want to adjust the division?
> I'm ok with the current one.
>=20
--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--dVcPdK6hL9pQmpPjUvCtIh91Gwe4mcF4H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll/SUgACgkQp6FrSiUn
Q2oTSwf/Qqgqa83t6s7JYVCx6DQvcywT8kSaouUOwv1PaBkIN9bssZfUARIMqeoB
CpxCxw9EZTR/q97ZfHFxbCpN973QSh6odQjmFetRAyuQ5Bv4/Vejh7EeHd5tEmEg
z1jvAR+f113FqIbKZsli0NJ62JUW8zc11GMBYnO1xKXvVAifpiWcd817mTtvcnsC
+m77iqr2h6Ylw8gCFFB8vqEHFU6wlqsHXXk9QuNZTp1HhYZPq9c57pZtdKbAMLhk
HUB2Gz6KrQtWsRBBd450xwxbWIKPJzSUpq15swCHRn75BWbl1MXrszrvHuJnkQFi
VM/BLFPbBLCpg4cmid+vGRTtCVcwnw==
=p3IR
-----END PGP SIGNATURE-----

--dVcPdK6hL9pQmpPjUvCtIh91Gwe4mcF4H--
