Received: from eggs.gnu.org ([2001:4830:134:3::10]:50188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dyPtM-0003iU-ML
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 18:05:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dyPtL-0002JL-G8
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 18:05:48 -0400
References: <150680635276.96.4363000165685666262@b58463cdfd5f>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4cac1113-5d6a-3dd1-1ef0-6fde5482a125@redhat.com>
Date: Sat, 30 Sep 2017 17:05:34 -0500
MIME-Version: 1.0
In-Reply-To: <150680635276.96.4363000165685666262@b58463cdfd5f>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="U71pAWIi81jUMdgw0UNK4elUkN1h2LoKg"
Subject: Re: [Qemu-devel] [PATCH 0/4] block: Avoid copy-on-read assertions
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org
List-ID: <qemu-devel.nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--U71pAWIi81jUMdgw0UNK4elUkN1h2LoKg
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org
Message-ID: <4cac1113-5d6a-3dd1-1ef0-6fde5482a125@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/4] block: Avoid copy-on-read assertions
References: <150680635276.96.4363000165685666262@b58463cdfd5f>
In-Reply-To: <150680635276.96.4363000165685666262@b58463cdfd5f>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/30/2017 04:19 PM, no-reply@patchew.org wrote:
> Hi,
>=20
> This series failed build test on s390x host. Please find the details be=
low.
>=20

> /var/tmp/patchew-tester-tmp-a2p2tpcc/src/block/io.c: In function =E2=80=
=98bdrv_aligned_preadv=E2=80=99:
> /var/tmp/patchew-tester-tmp-a2p2tpcc/src/block/io.c:955:9: error: =E2=80=
=98ret=E2=80=99 may be used uninitialized in this function [-Werror=3Dmay=
be-uninitialized]
>      int ret;
>          ^~~

Blah - I compiled with -g instead of -O2, which masks this warning in my
setup.

The warning is a false negative (the error message is actually pointing
to a line in bdrv_co_do_copy_on_readv - but the compiler must have
inlined it into bdrv_aligned_preadv) - the function is only ever called
with non-zero bytes, and therefore the 'while (cluster_bytes)' loop will
execute at least once, and ret always gets assigned.  But the compiler
can't see that, so I'll squash this in:

commit a201636c3133827bd632d5fdd9eb1f5df81d0e0e
Author: Eric Blake <eblake@redhat.com>
Date:   Sat Sep 30 14:27:51 2017 -0500

    fixup! block: Perform copy-on-read in loop

    Signed-off-by: Eric Blake <eblake@redhat.com>

diff --git a/block/io.c b/block/io.c
index 5ef5adc7a7..e7519464bb 100644
--- a/block/io.c
+++ b/block/io.c
@@ -952,7 +952,7 @@ static int coroutine_fn
bdrv_co_do_copy_on_readv(BdrvChild *child,
     int64_t cluster_offset;
     unsigned int cluster_bytes;
     size_t skip_bytes;
-    int ret;
+    int ret =3D 0;
     int max_transfer =3D MIN_NON_ZERO(bs->bl.max_transfer,
                                     BDRV_REQUEST_MAX_BYTES);
     unsigned int progress =3D 0;


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--U71pAWIi81jUMdgw0UNK4elUkN1h2LoKg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnQFS4ACgkQp6FrSiUn
Q2r6IAgAi5RScgPvqBTrHUGpdiidWxcxnj+Vs7ZAfdZ1fJ2tdS8WgbcIKrcUv2Um
100S9g+D+iBd7R0SdsLRInFBRPgKp8Spln43hitkwoBn40AmygynFX08IfA+3DZr
6/zxVolfG/Zy2jB6YWgY5xZMkD34TyhUw94X0FYUcAnxH2MOyzaIfjQ/6WeOKTAe
z/cVP8NYwk1XlHnmgZSYmM4SuKlTA9BqIk18l9sdcI0RmycQVX0dbwEPgu9Z5nUM
aPj+BXiZtoBopnfiXV0GHK/mPEe2LgLQ5Kb+wpoNVq9hqu9p70CcXC8WunMP4l1q
Kj5dvPHm/oc6olMhRz4HyF24mC3Mlg==
=x7lt
-----END PGP SIGNATURE-----

--U71pAWIi81jUMdgw0UNK4elUkN1h2LoKg--
