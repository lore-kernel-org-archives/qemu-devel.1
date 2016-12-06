Received: from eggs.gnu.org ([2001:4830:134:3::10]:50451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cEGwx-00073x-B9
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 09:42:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cEGww-0006SL-66
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 09:42:31 -0500
References: <20161205154934.24999-1-eblake@redhat.com>
	<7f28bb55-ceed-2551-1556-98945a10fcbc@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b575c977-9414-68cb-d5f1-897d38105d6e@redhat.com>
Date: Tue, 6 Dec 2016 08:42:18 -0600
MIME-Version: 1.0
In-Reply-To: <7f28bb55-ceed-2551-1556-98945a10fcbc@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="flmjUsKctbxJIltJ8mb9AjfKEe7NFeVhC"
Subject: Re: [Qemu-devel] [PATCH for-2.8 v2] qcow2: Don't strand clusters
 near 2G intervals during commit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--flmjUsKctbxJIltJ8mb9AjfKEe7NFeVhC
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <b575c977-9414-68cb-d5f1-897d38105d6e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.8 v2] qcow2: Don't strand clusters near
 2G intervals during commit
References: <20161205154934.24999-1-eblake@redhat.com>
 <7f28bb55-ceed-2551-1556-98945a10fcbc@redhat.com>
In-Reply-To: <7f28bb55-ceed-2551-1556-98945a10fcbc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/05/2016 01:52 PM, John Snow wrote:
>=20
>=20
> On 12/05/2016 10:49 AM, Eric Blake wrote:
>> The qcow2_make_empty() function is reached during 'qemu-img commit',
>> in order to clear out ALL clusters of an image.  However, if the
>> image cannot use the fast code path (true if the image is format
>> 0.10, or if the image contains a snapshot), the cluster size is
>> larger than 512, and the image is larger than 2G in size, then our
>> choice of sector_step causes problems.  Since it is not cluster
>> aligned, but qcow2_discard_clusters() silently ignores an unaligned
>> head or tail, we are leaving clusters allocated.
>>
>> Enhance the testsuite to expose the flaw, and patch the problem by
>> ensuring our step size is aligned.

>> +++ b/tests/qemu-iotests/097
>> @@ -46,7 +46,7 @@ _supported_proto file
>>  _supported_os Linux
>>
>>
>> -# Four passes:
>> +# Four main passes:
>>  #  0: Two-layer backing chain, commit to upper backing file (implicit=
ly)
>>  #     (in this case, the top image will be emptied)
>>  #  1: Two-layer backing chain, commit to upper backing file (explicit=
ly)
>> @@ -56,22 +56,30 @@ _supported_os Linux
>>  #  3: Two-layer backing chain, commit to lower backing file
>>  #     (in this case, the top image will implicitly stay unchanged)
>>  #
>> +# Each pass is run twice, since qcow2 has different code paths for cl=
eaning
>> +# an image depending on whether it has a snapshot.
>> +#
>>  # 020 already tests committing, so this only tests whether image chai=
ns are
>>  # working properly and that all images above the base are emptied; th=
erefore,
>> -# no complicated patterns are necessary
>> +# no complicated patterns are necessary.  Check near the 2G mark, as =
qcow2
>> +# has been buggy at that boundary in the past.
>>  for i in 0 1 2 3; do
>> +for j in 0 1; do
>>
>>  echo
>> -echo "=3D=3D=3D Test pass $i =3D=3D=3D"
>> +echo "=3D=3D=3D Test pass $i.$j =3D=3D=3D"

>=20
> I skimmed the test changes, but it looks good.

By the way, it was test 0.0 that fails without the change to qcow2.c
(the changes added the x.0 passes; the pre-existing x.1 passes all
succeed because they use the fast path, and passes 1-3.y succeed because
they aren't clearing all clusters).

Maybe I could have mentioned that in the commit message, and/or split
this into two patches to make the test changes have an easier diff (one
to shift the portion of the test image being written from 0-0x30000 out
to 0x7ffd0000-0x80000000, the other to double the number of passes). But
at this point, it's probably not worth a respin if we're going to get it
in 2.8; but I'm okay if the maintainer wants to add the above paragraph
into the commit message.

>=20
> Reviewed-by: John Snow <jsnow@redhat.com>
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--flmjUsKctbxJIltJ8mb9AjfKEe7NFeVhC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYRs5KAAoJEKeha0olJ0NqtWUH/jGQEihe/No2XjEsLVWTrkOm
J3aJAMy//ERBiedeDf0Sh/UiTePPEx6u/pSV05JVhIB/7/6F9QZBmLcB8dvKgYDq
MMbnbzkgJGVa6bSLNDX82X1zHgHV/mF7CmJ+2faQ1wWoYoZNd5/EjduxuKhR7U5y
gmypGrHeL1+IvaeTDupKHeIEZZ3Zt4C4aohc2TKrwx6s8m8gdT1U4vFBiE0TqqxK
buYZ65t430qckJvYUBKxdFSdAh8t35DRnSyGVoUH7DUVGUhkU7Eqw5JzjNVFu9K/
/AZr2fgoyWXt/fXWOVWwNp48QMhCEn9heFf56Eo9QhMnTXwO2UUJ2HxQENuukLI=
=pA/Z
-----END PGP SIGNATURE-----

--flmjUsKctbxJIltJ8mb9AjfKEe7NFeVhC--
