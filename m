Received: from eggs.gnu.org ([2001:4830:134:3::10]:53783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctx34-0000xr-Q9
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 09:57:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctx33-0003Kt-SM
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 09:57:06 -0400
References: <20170330223645.349-1-eblake@redhat.com>
	<20170330223645.349-4-eblake@redhat.com>
	<7827f670-c46a-cf69-c385-569e5114da96@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a864cbde-9109-06a9-6cea-543fedebc539@redhat.com>
Date: Fri, 31 Mar 2017 08:56:57 -0500
MIME-Version: 1.0
In-Reply-To: <7827f670-c46a-cf69-c385-569e5114da96@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ckGQlDHKDD5LhxkMqpe4JFpxWEwPpoMtw"
Subject: Re: [Qemu-devel] [PATCH v7 3/3] qcow2: Discard unaligned tail when
 wiping image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ckGQlDHKDD5LhxkMqpe4JFpxWEwPpoMtw
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <a864cbde-9109-06a9-6cea-543fedebc539@redhat.com>
Subject: Re: [PATCH v7 3/3] qcow2: Discard unaligned tail when wiping image
References: <20170330223645.349-1-eblake@redhat.com>
 <20170330223645.349-4-eblake@redhat.com>
 <7827f670-c46a-cf69-c385-569e5114da96@redhat.com>
In-Reply-To: <7827f670-c46a-cf69-c385-569e5114da96@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/31/2017 07:51 AM, Max Reitz wrote:
> On 31.03.2017 00:36, Eric Blake wrote:
>> The previous commit pointed out a subtle difference between the
>> fast and slow path of qcow2_make_empty(), where we failed to discard
>> the final (partial) cluster of an unaligned image.
>>

>> +    /* The caller must cluster-align start; round end down except at =
EOF */
>> +    assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
>> +    if (end_offset !=3D bs->total_sectors * BDRV_SECTOR_SIZE) {
>> +        end_offset =3D start_of_cluster(s, end_offset);
>>      }
>=20
> This change looks good and works for qcow2_make_empty(), but
> qcow2_co_pdiscard() will still drop these requests:

Yes, but qcow2_co_pdiscard() is advisory, and leaving the last partial
cluster undiscarded (consistent for what we do for all other partial
cluster requests) is different than our documented notion that
qcow2_make_empty() gets rid of all clusters no matter what.

> We don't necessarily have to fix it for 2.9, so:

Agreed that enhancing pdiscard to special-case a partial cluster at EOF
is not a bug fix, and therefore 2.10 material if we even want it.

>=20
> Reviewed-by: Max Reitz <mreitz@redhat.com>
>=20
>>
>>      nb_clusters =3D size_to_clusters(s, end_offset - offset);
>> diff --git a/tests/qemu-iotests/176.out b/tests/qemu-iotests/176.out
>> index 990a41c..6271fa7 100644
>> --- a/tests/qemu-iotests/176.out
>> +++ b/tests/qemu-iotests/176.out
>> @@ -35,7 +35,7 @@ Offset          Length          File
>>  Offset          Length          File
>>  0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
>>  0x7ffe0000      0x20000         TEST_DIR/t.IMGFMT.itmd
>> -0x83400000      0x200           TEST_DIR/t.IMGFMT
>> +0x83400000      0x200           TEST_DIR/t.IMGFMT.itmd

As to your comment about swapping patches 2 and 3, if I did that, then I
would not have this change to 176.out during the bug fix, and would
instead squash this line into the single patch touching the testsuite to
add the enhancement.  How important is the swapped order? Do I need to
respin for that, or is it something a maintainer could tweak, or is the
series fine as-is?  For what it's worth, the policy of single test after
the patch is somewhat opposite of Markus' approach of test first showing
the buggy behavior, then patch that includes the testsuite fix to match
the patch.  But I can live with either order, so I won't respin without
an explicit request to do so.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--ckGQlDHKDD5LhxkMqpe4JFpxWEwPpoMtw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY3mApAAoJEKeha0olJ0NqmSkH/2b3IVtnPsfa3lRf0wbj/dzL
2n0/HvhYQtjQ8otyyM1uKR51Ewy9YqWBGqP/uiOmyzvRqvOogrkww2k3DfLz70HE
bJTp6Urj4Rk21XzfPMm/dun3i55Uw6lGqLKWU/D0z7duMgqEbwbriI4fR1Jk5Oqc
QT+ApeCSX96CMYK1DWwx4UKhRe1RJSboE8vrhhCoLvuK3Kb6koc7zd0TXiUz63aL
6j0DH3P+RPkb9vsUGdufBmqOqzdU9aSmLqQ94G39QfcSRiqhg+6yk+ApZ2SmyHXE
XNFCqAkxAxTCJeGArK0uyYeNdyVWslKDBkYkeEnXCC3j0yno+lUg6wz3unZRNRk=
=SOOV
-----END PGP SIGNATURE-----

--ckGQlDHKDD5LhxkMqpe4JFpxWEwPpoMtw--
