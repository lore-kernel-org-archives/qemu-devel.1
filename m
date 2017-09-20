Received: from eggs.gnu.org ([2001:4830:134:3::10]:42858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dueoJ-0000Do-3k
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:13:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dueo9-0007l8-Vf
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:13:03 -0400
References: <20170919201910.25656-1-eblake@redhat.com>
	<20170919201910.25656-6-eblake@redhat.com>
	<26069637-9535-cb59-8920-9d9a7eef78b7@redhat.com>
	<20170920021014.GB18491@lemon>
From: Eric Blake <eblake@redhat.com>
Message-ID: <de133330-5cc3-d877-516c-38fc1928bebf@redhat.com>
Date: Wed, 20 Sep 2017 08:11:44 -0500
MIME-Version: 1.0
In-Reply-To: <20170920021014.GB18491@lemon>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5Lgxq2DsDSfF2p2tw4QFFgXQFaDf3e3Wa"
Subject: Re: [Qemu-devel] [PATCH v9 05/20] dirty-bitmap: Avoid size query
 failure during truncate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5Lgxq2DsDSfF2p2tw4QFFgXQFaDf3e3Wa
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <de133330-5cc3-d877-516c-38fc1928bebf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v9 05/20] dirty-bitmap: Avoid size query
 failure during truncate
References: <20170919201910.25656-1-eblake@redhat.com>
 <20170919201910.25656-6-eblake@redhat.com>
 <26069637-9535-cb59-8920-9d9a7eef78b7@redhat.com>
 <20170920021014.GB18491@lemon>
In-Reply-To: <20170920021014.GB18491@lemon>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/19/2017 09:10 PM, Fam Zheng wrote:

>>
>> Do you suspect that almost certainly if bdrv_truncate() fails overall
>> that the image format driver will either unmount the image or become
>> read-only?

Uggh - it feels like I've bitten off more than I can chew with this
patch - I'm getting bogged down by trying to fix bad behavior in code
that is mostly unrelated to the patch at hand, so I don't have a good
opinion on WHAT is supposed to happen if bdrv_truncate() fails, only
that I'm trying to avoid compounding that failure even worse.

>> I suppose if *not* that's a bug for callers of bdrv_truncate to allow
>> that kind of monkey business, but if it CAN happen, hbitmap only guard=
s
>> against such things with an assert (which, IIRC, is not guaranteed to =
be
>> on for all builds)
>=20
> It's guaranteed since a few hours ago:
>=20
> commit 262a69f4282e44426c7a132138581d400053e0a1

Indeed - but even without my patch, we would have hit the assertion
failures when trying to resize the dirty bitmap to -1 when
bdrv_nb_sectors() fails (which was likely if refresh_total_sectors()
failed).

>> So the question is: "bdrv_truncate failure is NOT considered recoverab=
le
>> in ANY case, is it?"
>>
>> It may possibly be safer to, if the initial truncate request succeeds,=

>> apply a best-effort to the bitmap before returning the error.
>=20
> Like fallback "offset" (or it aligned up to bs cluster size) if
> refresh_total_sectors() returns error? I think that is okay.

Here's my proposal for squashing in a best-effort dirty-bitmap resize no
matter what happens in refresh_total_sectors() (but really, if you
successfully truncate the disk but then get a failure while trying to
read back the actual new size, which may differ from the requested size,
you're probably doomed down the road anyways).

diff --git i/block.c w/block.c
index 3caf6bb093..ef5af81f66 100644
--- i/block.c
+++ w/block.c
@@ -3552,8 +3552,9 @@ int bdrv_truncate(BdrvChild *child, int64_t
offset, PreallocMode prealloc,
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Could not refresh total sector
count");
     } else {
-        bdrv_dirty_bitmap_truncate(bs, bs->total_sectors *
BDRV_SECTOR_SIZE);
+        offset =3D bs->total_sectors * BDRV_SECTOR_SIZE;
     }
+    bdrv_dirty_bitmap_truncate(bs, offset);
     bdrv_parent_cb_resize(bs);
     atomic_inc(&bs->write_gen);
     return ret;


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--5Lgxq2DsDSfF2p2tw4QFFgXQFaDf3e3Wa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnCaRAACgkQp6FrSiUn
Q2ottQf/fEEEsxRqUMqBqiDZtwCAeVaIRFs8yz33gd0J96hc2DyFtgIHRoJwVHds
cBwAeO6ysDjd3ctYLAgmQQs1whCxvT+TZfk/PwHAKmQu8QVOspytHiq3hazcnlE+
0FIb6XwHr62UjF+qTB8oXoaYgqgpA83h3gs1ZB8eehm5asa97T94hVGONKH0Ps89
4Z/9yb6piVyaMovqAEIk1ozZZyvaMgXwoBH7EdMQdm2Yf7cbOSJFN89XW0AgMnMs
2MfoanvyI6ktdlQ54vYxNdy0YA1wCMQgCJXnyfDqZTYxl5apF1chryADu8v7OeQT
NOiQ8sDNn26PS0tUPtqZlh/GYL/UUA==
=DWVK
-----END PGP SIGNATURE-----

--5Lgxq2DsDSfF2p2tw4QFFgXQFaDf3e3Wa--
