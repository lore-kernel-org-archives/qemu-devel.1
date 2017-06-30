Received: from eggs.gnu.org ([2001:4830:134:3::10]:35092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dR0eY-0000Ur-VU
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 14:28:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dR0eX-0001LY-Ng
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 14:28:26 -0400
References: <20170628120530.31251-1-vsementsov@virtuozzo.com>
	<20170628120530.31251-20-vsementsov@virtuozzo.com>
	<f92fea0e-fe66-6888-dcd2-10782aec4fd2@redhat.com>
	<b084acc4-a9d6-ecf5-e8f1-beb7c3a80072@redhat.com>
	<bddd14a1-5d18-58b2-8e4b-8579ad0e7f49@redhat.com>
	<fc19b4a1-081e-008d-5573-59e29419786f@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <300b367a-cc70-612f-70d0-7a447b720f22@redhat.com>
Date: Fri, 30 Jun 2017 13:28:04 -0500
MIME-Version: 1.0
In-Reply-To: <fc19b4a1-081e-008d-5573-59e29419786f@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XwnPoCTID4gEtOeFK9pb5feThJlP5HbJr"
Subject: Re: [Qemu-devel] [PATCH v22 19/30] qcow2: add persistent dirty
 bitmaps support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XwnPoCTID4gEtOeFK9pb5feThJlP5HbJr
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, famz@redhat.com, den@openvz.org,
 stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <300b367a-cc70-612f-70d0-7a447b720f22@redhat.com>
Subject: Re: [PATCH v22 19/30] qcow2: add persistent dirty bitmaps support
References: <20170628120530.31251-1-vsementsov@virtuozzo.com>
 <20170628120530.31251-20-vsementsov@virtuozzo.com>
 <f92fea0e-fe66-6888-dcd2-10782aec4fd2@redhat.com>
 <b084acc4-a9d6-ecf5-e8f1-beb7c3a80072@redhat.com>
 <bddd14a1-5d18-58b2-8e4b-8579ad0e7f49@redhat.com>
 <fc19b4a1-081e-008d-5573-59e29419786f@redhat.com>
In-Reply-To: <fc19b4a1-081e-008d-5573-59e29419786f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/30/2017 12:58 PM, John Snow wrote:

>>
>> "Structure of a bitmap directory entry:
>> ...
>>          8 - 11:    bitmap_table_size
>>                     Number of entries in the bitmap table of the bitma=
p."
>>
>=20
> This is the number of bitmaps stored in the qcow2, not the size of one
> particular bitmap.

No, I was quoting from "Structure of a bitmap directory entry" (the same
struct that also includes a per-bitmap granularity).

However, on re-reading the difference between the bitmap table and the
bitmap data, I see that the bitmap_table_size it formally the number of
cluster mappings that the bitmap occupies - so while it is not a precise
size of the bitmap, it IS an approximation (where scaling has introduced
lost precision for all sizes that map within the final cluster).  But my
point remains - we have some imprecision on whether bitmap_table_size
has to be clamped to the same number as you would get if the current
virtual disk size is converted into bitmaps, or whether it is valid to
have a qcow2 file where a bitmap table contains fewer cluster mappings
than would be required to cover the whole virtual file, or conversely
contains more cluster mappings than what you get even when rounding the
virtual table size up to the bitmap granularity and further scaled by
how many bits fit per cluster.

Concretely, if I'm using 512-byte clusters (the qcow2 minimum), and
qcow2 forces me to use a bitmap granularity no smaller than 9 (each bit
of the bitmap covers 512 bytes), then one cluster of bitmap data covers
2M of virtual size.  If I have an image with a virtual size of exactly
4M, and a bitmap covering that image, then my bitmap table _should_ have
exactly two mappings (bitmap_table_size should be 2, because it required
2 8-byte entries in the table to give the mapping for the 2 clusters
used to contain all the bits of the bitmap; the remaining 496 bytes of
the bitmap table should be 0 because there are no further mappings).
But note that any size in the range (2M, 4M] as the same
bitmap_table_size of 2 for that granularity.

If the bitmap is tied to the image (has the 'auto' and/or 'dirty' bit
set), then I agree that the bitmap size should match the virtual image
size.  But if the bitmap is independent, what technical reason do we
have that prevents us from having a bitmap covering 2M or less of data
(bitmap_table_size of 1), or more than 4M of data (bitmap_table_size of
3 or more), even though it has no relation to the current virtual image
size of 4M?

Meanwhile, if I use a bitmap granularity of 1k instead of 512, in the
same image with 512-byte clusters, a virtual size of 2M is
indistinguishable from a virtual size of 4M (both bitmaps fit within a
single cluster, or bitmap_table_size of 1; although the 2M case only
uses 256 of the 512 bytes in the bitmap data cluster).

I'm worried that we are too strict in stating that ALL bitmaps are tied
to the current virtual image size, but I'm also worried that our spec
might not be strict enough in enforcing that certain bitmaps MUST match
the virtual size (if the bitmap is automatically tracking writes to the
virtual image); and also worried whether we are setting ourselves up for
obscure failures based on the interaction of resize and/or internal
snapshots when bitmaps are in play (or whether we are being conservative
and forbidding those interactions until we've had time to further prove
that we handle their interaction safely).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--XwnPoCTID4gEtOeFK9pb5feThJlP5HbJr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZVpg0AAoJEKeha0olJ0NqyigH/13ygZe5CJbf/N9NDJ6LXps3
i0EEK7b9GLq+PB2sAyQJROQGfqrYrJ7Wye+P5FZuNv1Cn1MOkQHMqe+4oHvcjtHt
69hlKQCRqt3KRg1qvWzu39nV12o1VsyutUhaAeYNotI6X+thUh6iONQouL4qywsb
XcFcVW54mq6gSyL7gdCxpXk6TFRdXU9TisrgOWu49MCOUMNe26RFRuDTdpgIboWp
7H3/zu2uXXUwCrEUguR86FI0RhXcC/pANTemAhLUuiYSlbVP4oJp/9HB+e6d9cuT
SlT6E5moP4dlXJSIE13ZHsivC/5AvRVTf9TPYx71tLMllss49+qC77PnfDZst28=
=nyhx
-----END PGP SIGNATURE-----

--XwnPoCTID4gEtOeFK9pb5feThJlP5HbJr--
