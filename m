Received: from eggs.gnu.org ([2001:4830:134:3::10]:33135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dsDIx-0006jH-8m
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 15:26:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dsDIw-0004t2-6S
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 15:26:35 -0400
References: <20170913160333.23622-1-eblake@redhat.com>
	<20170913160333.23622-22-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bffcf3f2-86a5-388e-0ad3-a1fbcec51c7a@redhat.com>
Date: Wed, 13 Sep 2017 14:26:19 -0500
MIME-Version: 1.0
In-Reply-To: <20170913160333.23622-22-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vU6dL22Hkrx27xjxT4Eq44kkiPxbVKJtE"
Subject: Re: [Qemu-devel] [PATCH v4 21/23] block: Align block status requests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vU6dL22Hkrx27xjxT4Eq44kkiPxbVKJtE
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 jsnow@redhat.com
Message-ID: <bffcf3f2-86a5-388e-0ad3-a1fbcec51c7a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 21/23] block: Align block status requests
References: <20170913160333.23622-1-eblake@redhat.com>
 <20170913160333.23622-22-eblake@redhat.com>
In-Reply-To: <20170913160333.23622-22-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/13/2017 11:03 AM, Eric Blake wrote:
> Any device that has request_alignment greater than 512 should be
> unable to report status at a finer granularity; it may also be
> simpler for such devices to be guaranteed that the block layer
> has rounded things out to the granularity boundary (the way the
> block layer already rounds all other I/O out).  Besides, getting
> the code correct for super-sector alignment also benefits us
> for the fact that our public interface now has byte granularity,
> even though none of our drivers have byte-level callbacks.
>=20
> Add an assertion in blkdebug that proves that the block layer
> never requests status of unaligned sections, similar to what it
> does on other requests (while still keeping the generic helper
> in place for when future patches add a throttle driver).  Note
> that iotest 177 already covers this (it would fail if you use
> just the blkdebug.c hunk without the io.c changes).  Meanwhile,
> we can drop assertions in callers that no longer have to pass
> in sector-aligned addresses.

Bummer - 'git bisect' says this patch causes iotests 190 to hang.  I'm
investigating root cause, but I'll have to post a fixup once I figure it
out.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--vU6dL22Hkrx27xjxT4Eq44kkiPxbVKJtE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm5hlsACgkQp6FrSiUn
Q2q/lAf/cnnAHzYPLGgKGUvtfHVbaLJPn9jgm7OS/3uGZxtDHY0kj9RPEIxljUqP
w1uhbDKX2jtQfbgahPXXQA9tCGC/s/M5M4qIUkmSAtjy0YrqZLAoGcHOprJbtghR
cLKd1Oirp5j8+9HC2mkjmBXCgUU7o39gl6+JcKVPE7YmPqWhz+yaC+9l6zcGMfxx
WIzLK2BpIHnj4X3vmsJY3vbgNAwoZkoxs2wNFAIRa82AyuXKeXXTDy1+w/RCNaYD
tRFH4+mk+ulFgF4xBI0p96ehgn4Y7RVTN0pF1gKhsc2fDmxEAntEjbsRLHjgpQWJ
hXBVmoUKsRWqgAoJ6YCihDmxRanjAw==
=mTXH
-----END PGP SIGNATURE-----

--vU6dL22Hkrx27xjxT4Eq44kkiPxbVKJtE--
