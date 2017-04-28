Received: from eggs.gnu.org ([2001:4830:134:3::10]:38625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d4BJ7-0007fj-6r
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 15:11:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d4BJ6-0003yl-6W
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 15:11:57 -0400
References: <20170427014626.11553-1-eblake@redhat.com>
	<20170427014626.11553-5-eblake@redhat.com>
	<68eee3c7-a1b2-4011-21e6-1e12b15b90dd@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3b5ee0d4-a8bc-f4bb-b7be-78cfa352c236@redhat.com>
Date: Fri, 28 Apr 2017 14:11:48 -0500
MIME-Version: 1.0
In-Reply-To: <68eee3c7-a1b2-4011-21e6-1e12b15b90dd@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iv2xfvosVec1a3LGpU3OOXe4lQNKwjt0u"
Subject: Re: [Qemu-devel] [PATCH v10 04/17] qcow2: Optimize zero_single_l2()
 to minimize L2 churn
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
--iv2xfvosVec1a3LGpU3OOXe4lQNKwjt0u
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <3b5ee0d4-a8bc-f4bb-b7be-78cfa352c236@redhat.com>
Subject: Re: [PATCH v10 04/17] qcow2: Optimize zero_single_l2() to minimize L2
 churn
References: <20170427014626.11553-1-eblake@redhat.com>
 <20170427014626.11553-5-eblake@redhat.com>
 <68eee3c7-a1b2-4011-21e6-1e12b15b90dd@redhat.com>
In-Reply-To: <68eee3c7-a1b2-4011-21e6-1e12b15b90dd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/28/2017 01:00 PM, Max Reitz wrote:
> On 27.04.2017 03:46, Eric Blake wrote:
>> Similar to discard_single_l2(), we should try to avoid dirtying
>> the L2 cache when the cluster we are changing already has the
>> right characteristics.
>>

>> -        /* Update L2 entries */
>> +        /*
>> +         * Minimize L2 changes if the cluster already reads back as
>> +         * zeroes with correct allocation.
>> +         */
>> +        if (qcow2_get_cluster_type(old_offset) =3D=3D QCOW2_CLUSTER_Z=
ERO &&
>> +            !(unmap && old_offset & L2E_OFFSET_MASK)) {
>> +            continue;
>> +        }
>> +
>>          qcow2_cache_entry_mark_dirty(bs, s->l2_table_cache, l2_table)=
;
>> -        if (old_offset & QCOW_OFLAG_COMPRESSED || flags & BDRV_REQ_MA=
Y_UNMAP) {
>> +        if (old_offset & QCOW_OFLAG_COMPRESSED || unmap) {
>=20
> Works, but I'd like it better to store the cluster type somewhere and
> then use it here instead of checking the COMPRESSED flag.

Indeed, qcow2_get_cluster_type() checks QCOW_OFLAG_COMPRESSED first -
but I like the idea of storing it in a temporary variable now that we
are using the cluster type in more than one place.

>=20
> But it works, so it's up to you:
>=20
> Reviewed-by: Max Reitz <mreitz@redhat.com>
>=20
>>              l2_table[l2_index + i] =3D cpu_to_be64(QCOW_OFLAG_ZERO);
>>              qcow2_free_any_clusters(bs, old_offset, 1, QCOW2_DISCARD_=
REQUEST);
>>          } else {
>>
>=20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--iv2xfvosVec1a3LGpU3OOXe4lQNKwjt0u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZA5P0AAoJEKeha0olJ0NqBYUIAIXoE+tOLEZVlRT4ho1QWT8F
RFBJJWNTTfuRP/6nyrUS+Cu7nimCqRIoT30BSDk828/5n0NWxaBWt3m9IAtZ+I83
V2V3OdQ3ISW+jRGsymGXnA8dO10i1rXYGoTwY4gZvah7RCj9kRlqmbwuCLRaAyBz
+iITJA+Co/2lKW5oEtIy8kAXEh4RjyXc42tanaabVa4II5CwGj4UHJzmiQ3UCKsp
/5ySZjn4VQFrK7LL11KyP8j8CdvzjsSKq+4Cna5f5nKubrI74fvH4XlS9u0ucEMx
tCt+Y1PYuByYUPkgVpthe50ldOknLFYWqmDJenOejvmO3pLI/U+O3Cg/T0tLaIc=
=1+Qk
-----END PGP SIGNATURE-----

--iv2xfvosVec1a3LGpU3OOXe4lQNKwjt0u--
