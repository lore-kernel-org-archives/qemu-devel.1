Received: from eggs.gnu.org ([2001:4830:134:3::10]:38671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dQDVE-0004UO-RA
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:59:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dQDVD-0002g1-T6
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 09:59:32 -0400
References: <20170613121639.17853-1-pbutsykin@virtuozzo.com>
	<20170613121639.17853-4-pbutsykin@virtuozzo.com>
	<aed64e0e-61ed-12c9-8676-ad55795b6e62@redhat.com>
	<5fb63c73-ddc7-ba42-268f-bda160aebb6e@virtuozzo.com>
	<d3c0c0c2-da7e-bfff-e3c6-2d419c1126b9@redhat.com>
	<3b1b1a7e-ab9f-1376-fc3c-0853fb12987b@virtuozzo.com>
	<67df3935-2ef1-b664-11aa-bb6bdf91013b@redhat.com>
	<9bbacbbf-e9c2-f3b2-d81f-eba03e6ff7fc@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <dbbc524c-97db-2a37-26e3-fd0eea328f7c@redhat.com>
Date: Wed, 28 Jun 2017 15:59:19 +0200
MIME-Version: 1.0
In-Reply-To: <9bbacbbf-e9c2-f3b2-d81f-eba03e6ff7fc@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="w8kB9n4Ghcx7AxwpJoG6rRd3xIcUAbvXd"
Subject: Re: [Qemu-devel] [PATCH v2 3/4] qcow2: add shrink image support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, armbru@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--w8kB9n4Ghcx7AxwpJoG6rRd3xIcUAbvXd
From: Max Reitz <mreitz@redhat.com>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, armbru@redhat.com, den@openvz.org
Message-ID: <dbbc524c-97db-2a37-26e3-fd0eea328f7c@redhat.com>
Subject: Re: [PATCH v2 3/4] qcow2: add shrink image support
References: <20170613121639.17853-1-pbutsykin@virtuozzo.com>
 <20170613121639.17853-4-pbutsykin@virtuozzo.com>
 <aed64e0e-61ed-12c9-8676-ad55795b6e62@redhat.com>
 <5fb63c73-ddc7-ba42-268f-bda160aebb6e@virtuozzo.com>
 <d3c0c0c2-da7e-bfff-e3c6-2d419c1126b9@redhat.com>
 <3b1b1a7e-ab9f-1376-fc3c-0853fb12987b@virtuozzo.com>
 <67df3935-2ef1-b664-11aa-bb6bdf91013b@redhat.com>
 <9bbacbbf-e9c2-f3b2-d81f-eba03e6ff7fc@virtuozzo.com>
In-Reply-To: <9bbacbbf-e9c2-f3b2-d81f-eba03e6ff7fc@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-27 17:06, Pavel Butsykin wrote:
> On 26.06.2017 20:47, Max Reitz wrote:
>> On 2017-06-26 17:23, Pavel Butsykin wrote:
> []
>>>
>>> Is there any guarantee that in the future this will not change? Becau=
se
>>> in this case it can be a potential danger.
>>
>> Since this behavior is not documented anywhere, there is no guarantee.=

>>
>>> I can add a comment... Or add a new variable with the size of
>>> reftable_tmp, and every time count min(s->refcount_table_size,
>>> reftable_tmp_size)
>>> before accessing to s->refcount_table[]/reftable_tmp[]
>>
>> Or (1) you add an assertion that refcount_table_size doesn't change
>> along with a comment why that is the case, which also explains in deta=
il
>> why the call to qcow2_free_clusters() should be safe: The on-disk
>> reftable differs from the one in memory. qcow2_free_clusters()and
>> update_refcount() themselves do not access the reftable, so they are
>> safe. However, update_refcount() calls alloc_refcount_block(), and tha=
t
>> function does access the reftable: Now, as long as
>> s->refcount_table_size does not shrink (which I can't see why it would=
),
>> refcount_table_index should always be smaller. Now we're accessing
>> s->refcount_table: This will always return an existing refblock becaus=
e
>> this will either be the refblock itself (for self-referencing refblock=
s)
>> or another one that is not going to be freed by qcow2_shrink_reftable(=
)
>> because this function will not free refblocks which cover other cluste=
rs
>> than themselves.
>> We will then proceed to update the refblock which is either right (if =
it
>> is not the refblock to be freed) or won't do anything (if it is the on=
e
>> to be freed).
>> In any case, we will never write to the reftable and reading from the
>> basically outdated cached version will never do anything bad.
>=20
> OK, SGTM.
>=20
>> Or (2) you copy reftable_tmp into s->refcount_table[] *before* any cal=
l
>> to qcow2_free_clusters(). To make this work, you would need to also
>> discard all refblocks from the cache in this function here (and not in=

>> update_refcount()) and then only call qcow2_free_clusters() on refbloc=
ks
>> which were not self-referencing. An alternative hack would be to simpl=
y
>> mark the image dirty and just not do any qcow2_free_clusters() call...=

>=20
> The main purpose of qcow2_reftable_shrink() function is discard all
> unnecessary refblocks from the file. If we do only rewrite
> refcount_table and discard non-self-referencing refblocks (which are
> actually very rare), then the meaning of the function is lost.

It would do exactly the same. The idea is that you do not need to call
qcow2_free_clusters() on self-referencing refblocks at all, since they
are freed automatically when their reftable entry is overwritten with 0.

>> Or (3) of course it would be possible to not clean up refcount
>> structures at all...
>=20
> Nice solution :)

It is, because as I said refcount structures only have a small overhead.

Max


--w8kB9n4Ghcx7AxwpJoG6rRd3xIcUAbvXd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZU7Y4EhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQJeF
CACVIaaeWDz3FekJfurjks9P3Mp18JbVhei9UON/Z6DKGncrFYmc0Q3BZK0vUwfE
XEEYbbGcziovNiUiYNAKBwXLZqGHn7X7CtFHm1x5Eyklbbn80AIQgJdCrUHgrao/
FW25D5bHaLVEf8zj/Xf0YFg0zQHyhQiv6oh15g3UfgcGZDU0ztCwgWNMeFDpppG5
VB2jO/J6tUA++PC2LNjuTVzYsdNbqjcGs5HBIY4dW90HHu1uJ3TUGEjCi4fQ6a4T
J+kcXwkeyQL1L1A0+WoI6A8VO7X6a1no0DH94D6Swg8vAq5/dOYyC4PnVgrHW/SS
3yl1H7j7h5WElKX39EKQb8VC
=UNZP
-----END PGP SIGNATURE-----

--w8kB9n4Ghcx7AxwpJoG6rRd3xIcUAbvXd--
