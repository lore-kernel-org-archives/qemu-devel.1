Received: from eggs.gnu.org ([2001:4830:134:3::10]:56379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ehJVI-0006IJ-NF
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:22:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ehJVH-0001ZO-9Y
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 13:22:32 -0500
References: <cover.1516978645.git.berto@igalia.com>
	<07a984cef4f1c97dcca44e365aa90ba5b6881e09.1516978645.git.berto@igalia.com>
	<c57f7978-d54d-75f8-58f3-32d8fa5284a6@redhat.com>
	<w51r2q46eg2.fsf@maestria.local.igalia.com>
	<d81eae0f-1481-9dd3-0df9-40063c215784@virtuozzo.com>
	<w511si467gu.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <003a82eb-6444-9f5e-e6b0-1cc7cf45d98c@redhat.com>
Date: Thu, 1 Feb 2018 19:22:16 +0100
MIME-Version: 1.0
In-Reply-To: <w511si467gu.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UxbQwN1Q3H6nSFy53XKP7PmRkcshZT46s"
Subject: Re: [Qemu-devel] [PATCH v3 17/39] qcow2: Update l2_allocate() to
 support L2 slices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UxbQwN1Q3H6nSFy53XKP7PmRkcshZT46s
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>,
 Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 qemu-block@nongnu.org
Message-ID: <003a82eb-6444-9f5e-e6b0-1cc7cf45d98c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 17/39] qcow2: Update l2_allocate() to
 support L2 slices
References: <cover.1516978645.git.berto@igalia.com>
 <07a984cef4f1c97dcca44e365aa90ba5b6881e09.1516978645.git.berto@igalia.com>
 <c57f7978-d54d-75f8-58f3-32d8fa5284a6@redhat.com>
 <w51r2q46eg2.fsf@maestria.local.igalia.com>
 <d81eae0f-1481-9dd3-0df9-40063c215784@virtuozzo.com>
 <w511si467gu.fsf@maestria.local.igalia.com>
In-Reply-To: <w511si467gu.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-01 16:43, Alberto Garcia wrote:
> On Thu 01 Feb 2018 04:23:09 PM CET, Anton Nefedov wrote:
>>>> However, I'm wondering whether this is the best approach.  The old
>>>> L2 table is probably not going to be used after this function, so
>>>> we're basically polluting the cache here.  That was bad enough so
>>>> far, but now that actually means wasting multiple cache entries on
>>>> it.
>>>>
>>>> Sure, the code is simpler this way.  But maybe it would still be
>>>> better to manually copy the data over from the old offset...  (As
>>>> long as it's not much more complicated.)
>>>
>>> You mean bypassing the cache altogether?
>>>
>>>      qcow2_cache_flush(bs, s->l2_table_cache);
>>>      new_table =3D g_malloc(s->cluster_size);
>>>      if (old_l2_offset & L1E_OFFSET_MASK) {
>>>          bdrv_pread(bs->file, old_l2_offset, new_table, s->cluster_si=
ze);
>>>      } else {
>>>          memset(new_table, 0, s->cluster_size);
>>>      }
>>>      bdrv_pwrite(bs->file, new_l2_offset, new_table, s->cluster_size)=
;
>>>      g_free(new_table);
>>>
>>> ??
>>
>> (I know it's a draft so you probably just skipped that but just in
>> case) It seems ok to bypass the cache read - perhaps even a flush is
>> not necessary: old_l2_offset must be read-only and flushed at this
>> point; I believe new_l2_offset might be cached too, so it needs to be
>> updated.
>=20
> One problem I see with this is that while we wouldn't pollute the cache=

> we'd always be reading the table twice from disk in all cases:
>=20
>  1) Read old table
>  2) Write new table
>  3) Read new table (after l2_allocate(), using the cache this time)
>=20
> We can of course improve it by reading the old table from disk but
> directly in the cache -so we'd spare step (3)-, but we'd still have to
> read at least once from disk.
>=20
> With the old code (especially if slice_size =3D=3D cluster_size) we don=
't
> need to read anything if the L2 table is already cached:
>=20
>  1) Get empty table from the cache
>  2) memcpy() the old data
>  3) Get new table from the cache (after l2_allocate()).

Well, then scratch the bdrv_pwrite() for the new table and keep using
the cache for that (because that actually sounds useful).

On second thought, though, it's rather probable the old L2 table is
already in the cache...  Before the guest does a write to a location, it
is reasonable to assume it has read from there before.

So I guess we could think about adding a parameter to qcow2_cache_put()
or something to reset the LRU counter because we probably won't need
that entry anymore.  But not something for this series, of course.

Max


--UxbQwN1Q3H6nSFy53XKP7PmRkcshZT46s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpzWtgSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A+zQIAKG8Tv7mi9Sw63IjM47lfiZNd5kD7NFW
0942KTuChskD+7o9okoGkJmYBTOtR3KfMciP/XBaQPk+4jPL6U/LUKYloCkMIw5m
C6mQ0OIdHHtnle5/2CKTAPUWwaqXbZhRa02kLz67Jffh3OVAFakn9QIxr9a8FULs
vyxAPcPiMkTzDeR383vVTzi9WCCnySqRLcmdljno+prL1b/VFH61eMWp84yKDaSL
jgni+P3BGPR/qAh0+3RgAbwuI26G7nbfdSDOqj4569WzRq1cUYRQ7TfB4pWiMGQd
sFznD2GFLzU/py1rc//6DdSpElsPh7Q8iSg5BN8jbIHsz49Pkr8Ltg0=
=XG5I
-----END PGP SIGNATURE-----

--UxbQwN1Q3H6nSFy53XKP7PmRkcshZT46s--
