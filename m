Received: from eggs.gnu.org ([2001:4830:134:3::10]:47581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d76LV-000625-Rd
	for qemu-devel@nongnu.org; Sat, 06 May 2017 16:30:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d76LU-00011o-PJ
	for qemu-devel@nongnu.org; Sat, 06 May 2017 16:30:29 -0400
References: <20170504030755.1001-1-eblake@redhat.com>
	<20170504030755.1001-5-eblake@redhat.com>
	<030dca5b-7b6a-8ec7-0f46-bfef6346dfbe@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <33cd5d43-b732-68bf-f072-5abaf312e148@redhat.com>
Date: Sat, 6 May 2017 15:30:18 -0500
MIME-Version: 1.0
In-Reply-To: <030dca5b-7b6a-8ec7-0f46-bfef6346dfbe@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="06OoiAnoAdJ3TGgO8MlpmuT5iOnq8Ingr"
Subject: Re: [Qemu-devel] [PATCH v12 04/10] qcow2: Make distinction between
 zero cluster types obvious
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--06OoiAnoAdJ3TGgO8MlpmuT5iOnq8Ingr
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com
Message-ID: <33cd5d43-b732-68bf-f072-5abaf312e148@redhat.com>
Subject: Re: [PATCH v12 04/10] qcow2: Make distinction between zero cluster
 types obvious
References: <20170504030755.1001-1-eblake@redhat.com>
 <20170504030755.1001-5-eblake@redhat.com>
 <030dca5b-7b6a-8ec7-0f46-bfef6346dfbe@redhat.com>
In-Reply-To: <030dca5b-7b6a-8ec7-0f46-bfef6346dfbe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/05/2017 03:51 PM, Max Reitz wrote:
> On 04.05.2017 05:07, Eric Blake wrote:
>> Treat plain zero clusters differently from allocated ones, so that
>> we can simplify the logic of checking whether an offset is present.
>> Do this by splitting QCOW2_CLUSTER_ZERO into two new enums,
>> QCOW2_CLUSTER_ZERO_PLAIN and QCOW2_CLUSTER_ZERO_ALLOC.
>>
>> I tried to arrange the enum so that we could use
>> 'ret <=3D QCOW2_CLUSTER_ZERO_PLAIN' for all unallocated types, and
>> 'ret >=3D QCOW2_CLUSTER_ZERO_ALLOC' for allocated types, although
>> I didn't actually end up taking advantage of the layout.
>>
>> In many cases, this leads to simpler code, by properly combining
>> cases (sometimes, both zero types pair together, other times,
>> plain zero is more like unallocated while allocated zero is more
>> like normal).
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>

>> @@ -558,52 +557,32 @@ int qcow2_get_cluster_offset(BlockDriverState *b=
s, uint64_t offset,
>>      assert(nb_clusters <=3D INT_MAX);
>>
>>      ret =3D qcow2_get_cluster_type(*cluster_offset);
>> +    if (s->qcow_version < 3 && (ret =3D=3D QCOW2_CLUSTER_ZERO_PLAIN |=
|
>> +                                ret =3D=3D QCOW2_CLUSTER_ZERO_ALLOC))=
 {
>> +        qcow2_signal_corruption(bs, true, -1, -1, "Zero cluster entry=
 found"
>> +                                " in pre-v3 image (L2 offset: %#" PRI=
x64
>> +                                ", L2 index: %#x)", l2_offset, l2_ind=
ex);
>> +        ret =3D -EIO;
>> +        goto fail;
>> +    }
=2E..
>> +    case QCOW2_CLUSTER_ZERO_PLAIN:
>>      case QCOW2_CLUSTER_UNALLOCATED:
>>          /* how many empty clusters ? */
>>          c =3D count_contiguous_clusters_unallocated(nb_clusters,
>> -                                                  &l2_table[l2_index]=
,
>> -                                                  QCOW2_CLUSTER_UNALL=
OCATED);
>> +                                                  &l2_table[l2_index]=
, ret);
>=20
> Nit pick: Using ret here is a bit weird (because it's such a meaningles=
s
> name). It would be good if we had a separate cluster_type variable.

qcow2_get_cluster_offset() returns the cluster type on success, and
-errno on failure.  So 'ret' actually makes some sense: it really is the
value we are about to return.  But it may also work to have a separate
variable up front, then assign ret =3D cluster_type at the end; I'll play=

with it and see which one looks better.

>=20
>>          *cluster_offset =3D 0;
>>          break;
>> +    case QCOW2_CLUSTER_ZERO_ALLOC:
>>      case QCOW2_CLUSTER_NORMAL:
>>          /* how many allocated clusters ? */
>>          c =3D count_contiguous_clusters(nb_clusters, s->cluster_size,=

>> -                &l2_table[l2_index], QCOW_OFLAG_ZERO);
>> +                                      &l2_table[l2_index], QCOW_OFLAG=
_ZERO);
>>          *cluster_offset &=3D L2E_OFFSET_MASK;
>>          if (offset_into_cluster(s, *cluster_offset)) {
>>              qcow2_signal_corruption(bs, true, -1, -1, "Data cluster o=
ffset %#"
>=20
> Well, preallocated zero clusters are not exactly data clusters... Not
> that any user cared, but s/Data cluster/Cluster allocation/ would be
> more correct.

Good idea.

>=20
> By the way, allow me to state just how much I love this hunk: Very much=
=2E
> Looks great! It gets a place on my list of favorite hunks of this year
> at least.
>=20
> [...]
>=20
>> @@ -1760,7 +1740,8 @@ static int expand_zero_clusters_in_l1(BlockDrive=
rState *bs, uint64_t *l1_table,
>>              int cluster_type =3D qcow2_get_cluster_type(l2_entry);>  =
            bool preallocated =3D offset !=3D 0;
>=20
> I could get behind removing this variable and replacing all
> "if (!preallocated)" instances by
> "if (cluster_type =3D=3D QCOW2_CLUSTER_ZERO_PLAIN)". Up to you, though.=


Makes sense.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--06OoiAnoAdJ3TGgO8MlpmuT5iOnq8Ingr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZDjJaAAoJEKeha0olJ0Nqqx0H/1tmB/HBc6tm1S/pgbuqVjUb
YU5l5Wn38mx7ZXvXK//3cr54i+StM5H5uWMMQqf60OdR4ShygolOBi5ZsLE2CEYo
9Ce8XAi/UMW9m4dHMbCm/69J19hjlgMZEVkdqlF2dI37IeCfGlVf1hhnXhigQkDl
eX1xw15Zuj/49c62Rf53+ZBZhGyqNxzlpgJbkhExIzQHJfvvVZFvGh2RDDDUuDKz
LUVlWnGZsKzXk8osglnvJXwj8uignTlfmaCeBPh9cdmn+SaPS7IyBbn15NfFtEAv
a9KKrb83RdyxgNKMiL/GflLRxeuCba4eVmqTiP/YrDEfcuDiwG9SvnCN5WFRmrk=
=XJ1K
-----END PGP SIGNATURE-----

--06OoiAnoAdJ3TGgO8MlpmuT5iOnq8Ingr--
