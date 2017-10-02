Received: from eggs.gnu.org ([2001:4830:134:3::10]:34622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dz2Me-0004Z1-7K
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:10:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dz2MZ-0007BZ-ID
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:10:36 -0400
References: <150680635276.96.4363000165685666262@b58463cdfd5f>
	<4cac1113-5d6a-3dd1-1ef0-6fde5482a125@redhat.com>
	<20171002145030.GC4362@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5a1170f8-cf25-d562-cca8-a10f85eef42f@redhat.com>
Date: Mon, 2 Oct 2017 10:10:02 -0500
MIME-Version: 1.0
In-Reply-To: <20171002145030.GC4362@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="G1nn6IRFwKpII0f0RuRkX1bSrXsbSpLM9"
Subject: Re: [Qemu-devel] [PATCH 0/4] block: Avoid copy-on-read assertions
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org
List-ID: <qemu-devel.nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--G1nn6IRFwKpII0f0RuRkX1bSrXsbSpLM9
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, jsnow@redhat.com,
 qemu-block@nongnu.org
Message-ID: <5a1170f8-cf25-d562-cca8-a10f85eef42f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/4] block: Avoid copy-on-read assertions
References: <150680635276.96.4363000165685666262@b58463cdfd5f>
 <4cac1113-5d6a-3dd1-1ef0-6fde5482a125@redhat.com>
 <20171002145030.GC4362@localhost.localdomain>
In-Reply-To: <20171002145030.GC4362@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/02/2017 09:50 AM, Kevin Wolf wrote:

>> The warning is a false negative (the error message is actually pointin=
g
>> to a line in bdrv_co_do_copy_on_readv - but the compiler must have
>> inlined it into bdrv_aligned_preadv) - the function is only ever calle=
d
>> with non-zero bytes, and therefore the 'while (cluster_bytes)' loop wi=
ll
>> execute at least once, and ret always gets assigned.  But the compiler=

>> can't see that, so I'll squash this in:
>=20
> Well, you could help the compiler with this:
>=20
>     assert(cluster_bytes > 0);
>=20
> Then it compiles. Unfortunately, the compiler was right and you weren't=
:
>=20
>     $ ./qemu-io -C -c 'read 0 0' /tmp/test.qcow2
>     qemu-io: block/io.c:988: bdrv_co_do_copy_on_readv: Assertion `clust=
er_bytes > 0' failed.
>     Abgebrochen (Speicherabzug geschrieben)
>=20
> Maybe a case to add to the test?

Of course - that's a good test to have.

So it turns out the reason we get in with 0 length is:

        ret =3D bdrv_is_allocated(bs, offset, bytes, &pnum);
        if (ret < 0) {
            goto out;
        }

        if (!ret || pnum !=3D bytes) {
            ret =3D bdrv_co_do_copy_on_readv(child, offset, bytes, qiov);=

            goto out;
        }

because bdrv_is_allocated() returns 0 for a 0-length query.  I wonder if
we should instead assert that bdrv_is_allocated/bdrv_get_block_status()
are given a non-zero size, and fix callers to avoid a 0-length query
(after all, it's tough to argue that the read is allocated in the
current layer or defers to a backing layer, when there is nothing to be
read).

>> +++ b/block/io.c
>> @@ -952,7 +952,7 @@ static int coroutine_fn
>> bdrv_co_do_copy_on_readv(BdrvChild *child,
>>      int64_t cluster_offset;
>>      unsigned int cluster_bytes;
>>      size_t skip_bytes;
>> -    int ret;
>> +    int ret =3D 0;
>>      int max_transfer =3D MIN_NON_ZERO(bs->bl.max_transfer,
>>                                      BDRV_REQUEST_MAX_BYTES);
>>      unsigned int progress =3D 0;
>=20
> I would prefer a ret =3D 0 immediately before err: so that we'll still =
get
> warning if we forget assigning ret in any future error path.

Sure, I can take that approach instead.  v2 coming up, after a bit more
of a wait for any other review comments on the main patch rather than
just this fixup.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--G1nn6IRFwKpII0f0RuRkX1bSrXsbSpLM9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnSVsoACgkQp6FrSiUn
Q2q2DQgAqxTZ6/nVmj9ygrcItxi+HE9gV1Dz70J+K7lQaEWxlTO3k54oy4Z+tKRS
FBDy1fj+U8HWMy3Yab/CvWaa6fC92L+xOuPWPMkCYusHvsjM0UvPYWaVohi5n4lJ
QPrYKl7B3CQtKFGcEI600xbtVG+0uXNWeBh+ieQjqhOQR0hdX51sJqen5lk1cD7H
n/MUvxvRZ6ol1RPe5BWdAuGALm9EqqqCU3f+lYka6Wa8eonR3gNUjP8GQo8lZRY5
jVQaWFpwxyxEiVCFOpgY6GvWrHd88wWjagqj/DVJ1CghTfvI25MbG9tD0bnWRqWY
ze9rKhJX7NedpSlZkCAMsXPk1Oex3g==
=n+jp
-----END PGP SIGNATURE-----

--G1nn6IRFwKpII0f0RuRkX1bSrXsbSpLM9--
