Received: from eggs.gnu.org ([2001:4830:134:3::10]:60654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dAFWR-0001e4-AB
	for qemu-devel@nongnu.org; Mon, 15 May 2017 08:54:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dAFWQ-0003kb-A5
	for qemu-devel@nongnu.org; Mon, 15 May 2017 08:54:47 -0400
Date: Mon, 15 May 2017 13:54:43 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170515125443.GB1201@stefanha-x1.localdomain>
References: <20170505021500.19315-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
Content-Disposition: inline
In-Reply-To: <20170505021500.19315-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [RFC PATCH 0/2] Enhance block status
 when crossing EOF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com


--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 04, 2017 at 09:14:58PM -0500, Eric Blake wrote:
> As mentioned in my 'qcow2 zero-cluster tweaks' cover letter
> https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg00722.html
> I hit a case where we were not fully optimizing a write-zeroes
> operation when we have a backing file that is shorter than the
> active layer, and where the request crosses that boundary.  I don't
> know that the situation will be all that common (most qcow2 files
> happen to be cluster-aligned in size; and most backing chains use
> the same length at each layer of the chain), but for RFC purposes,
> I wanted to explore how easy it would be to optimize the case
> anyways, and to see if we can think of any other cases where
> knowing that a block status crossed an end-of-file boundary can
> be exploited for less work.
>=20
> Thus, this is a followup to that series, but I'm also okay if we
> think it is too much maintenance compared to the potential gains,
> and decide to drop it after all.
>=20
> Another potential use that I thought of: we may someday want to
> track BDS length by bytes.  Right now, bdrv_getlength() returns a
> value in bytes, but which is sector-aligned, by adding padding;
> but raw-format.c is able to see the transition between data up to
> EOF followed by a hole after EOF.  Because of that, my series to
> convert bdrv_get_block_status() into a byte-based interface has to
> fudge things - any time we see a mid-sector hole being reported,
> we know it is because we hit EOF, and can round the result up to
> the next sector boundary.  Having the BDRV_BLOCK_EOF flag set in
> that case may alert clients that the rounding took place, or help
> us when we quit doing the rounding and actually start tracking BDS
> lengths by bytes even where it is not sector-aligned.
>=20
> Eric Blake (2):
>   block: Add BDRV_BLOCK_EOF to bdrv_get_block_status()
>   block: Exploit BDRV_BLOCK_EOF for larger zero blocks
>=20
>  include/block/block.h      |  2 ++
>  block/io.c                 | 42 +++++++++++++++++++++++++++++++++-------=
--
>  tests/qemu-iotests/154     |  4 ----
>  tests/qemu-iotests/154.out | 12 ++++++------
>  4 files changed, 41 insertions(+), 19 deletions(-)
>=20
> --=20
> 2.9.3
>=20
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZGaUTAAoJEJykq7OBq3PIgZEH+gMRJ0+JelWImyG/vDlKiXYK
ZZ8wZXZ0m1QglH8DSprVZ+1/Z8gDtRWfLl9PwZCDLrrtcRxYDAesQ27f6sOHxc0K
xe6m80cWwyAphmq0/t6RIhXM8+j9tTPJa/nHYGbWEE9HYc2LICivF06YhroU8mlT
vwAxCCPARVtqemy+bHyTacujfzUenz1zOjIAFfUlalv4Gq/rKEDb8GT9Un5trdc5
+8k3uxh5tVaVn1x6j1oiNFhbR521uL4Foajkfcmr1OVjAzE0ISsJ1pwcGM03F+oq
ufwWGRTVe2chcwDwx8qwbvNhEb3+MBjtkuA4OnCrxT3hPFdttw9sKmBsVaSoEdg=
=e5gp
-----END PGP SIGNATURE-----

--cvVnyQ+4j833TQvp--
