Received: from eggs.gnu.org ([2001:4830:134:3::10]:59107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cl294-0001mo-5J
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 18:34:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cl292-0003zU-UM
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 18:34:26 -0500
References: <20170214192525.18624-1-eblake@redhat.com>
	<20170214192525.18624-2-eblake@redhat.com>
	<20170215122517.GB4935@noname.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <43feafa5-db00-50f5-0d93-919678fe3547@redhat.com>
Date: Mon, 6 Mar 2017 17:34:17 -0600
MIME-Version: 1.0
In-Reply-To: <20170215122517.GB4935@noname.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JbWkJ9eUTHpiFRIJbPQaBcpbv6fImEMUx"
Subject: Re: [Qemu-devel] [PATCH v5 1/7] qcow2: Assert that cluster
 operations are aligned
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JbWkJ9eUTHpiFRIJbPQaBcpbv6fImEMUx
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com
Message-ID: <43feafa5-db00-50f5-0d93-919678fe3547@redhat.com>
Subject: Re: [PATCH v5 1/7] qcow2: Assert that cluster operations are aligned
References: <20170214192525.18624-1-eblake@redhat.com>
 <20170214192525.18624-2-eblake@redhat.com>
 <20170215122517.GB4935@noname.redhat.com>
In-Reply-To: <20170215122517.GB4935@noname.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/15/2017 06:25 AM, Kevin Wolf wrote:
> Am 14.02.2017 um 20:25 hat Eric Blake geschrieben:
>> qcow2_discard_clusters() is set up to silently ignore sub-cluster
>> head or tail on unaligned requests.  However, it is easy to audit
>> the various callers: qcow2_snapshot_create() has always passed
>> aligned data since the call was introduced in 1ebf561;
>> qcow2_co_pdiscard() has passed aligned clusters since commit
>> ecdbead taught the block layer the preferred discard alignment (the
>> block layer can still pass sub-cluster values, but those are
>> handled directly in qcow2_co_pdiscard()); and qcow2_make_empty()
>> was fixed to pass aligned clusters in commit a3e1505.
>=20
> I don't think this is true for the very part in the image if the image
> size isn't cluster aligned:
>=20
>     ret =3D qcow2_discard_clusters(bs, start_sector * BDRV_SECTOR_SIZE,=

>                                  MIN(sector_step,
>                                      bs->total_sectors - start_sector),=

>                                  QCOW2_DISCARD_SNAPSHOT, true);
>=20
> sector_step is alright after commit a3e1505, but bs->total_sectors can
> be unaligned.

Indeed; a slight tweak to qemu-iotests/097 exposes the problem.  I'll
include that in my next spin (although I note that Dan has patches on
the list to split 097 into two tests, in order to give qcow coverage
rather than just qcow2).

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--JbWkJ9eUTHpiFRIJbPQaBcpbv6fImEMUx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYvfH5AAoJEKeha0olJ0NqCekH/3Y1djpfICLexn8jUdqAFrOh
nw8qwtABv7rKD4WQwZU8fO3MyBvQuJ9R1kXxASYLH0nFjPesXUYCd/0V+gPaR88O
hc1BqIZh/OScyVXLeUIrLEpc3qkKgMW0sgfLjCCjmq7b1nwR8PAS4hZdp2wESzxo
KgRDII548WZ486v53uELkPtbdTF4bzgZFWWXUQ4V1nAhaORUZZ7n4+uObU3dEfiD
jaMg9vCjyvAvUjGQYMQSvRbRKTofnADMSqD8TRXOHA8TaYjOcclYaYMjMO2D8vPp
X5IX2NfwsLgWxdTZkVoKYDcSWbIyDAfR+eL66wPm4mWMpOVZOQhuqKBPBrYmNTM=
=taWz
-----END PGP SIGNATURE-----

--JbWkJ9eUTHpiFRIJbPQaBcpbv6fImEMUx--
