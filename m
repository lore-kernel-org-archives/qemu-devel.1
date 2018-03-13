Received: from eggs.gnu.org ([2001:4830:134:3::10]:41641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1evppE-0001pk-6E
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 15:43:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1evppD-00076X-8y
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 15:43:08 -0400
References: <20180313180320.339796-1-vsementsov@virtuozzo.com>
	<20180313180320.339796-12-vsementsov@virtuozzo.com>
	<20180313182208.GM3545@work-vm>
	<14ad1e8a-4b08-7707-0a8f-d443c65abb22@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <2c256209-a5e6-1e57-eb75-27fd3ef6860c@redhat.com>
Date: Tue, 13 Mar 2018 15:42:33 -0400
MIME-Version: 1.0
In-Reply-To: <14ad1e8a-4b08-7707-0a8f-d443c65abb22@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v11 11/13] migration: add postcopy
 migration of dirty bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: kwolf@redhat.com, peter.maydell@linaro.org, famz@redhat.com, lirans@il.ibm.com, qemu-block@nongnu.org, quintela@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com, stefanha@redhat.com, den@openvz.org, amit.shah@redhat.com, pbonzini@redhat.com, mreitz@redhat.com



On 03/13/2018 02:29 PM, Vladimir Sementsov-Ogievskiy wrote:
> 13.03.2018 21:22, Dr. David Alan Gilbert wrote:
>> * Vladimir Sementsov-Ogievskiy (vsementsov@virtuozzo.com) wrote:
>>> Postcopy migration of dirty bitmaps. Only named dirty bitmaps are
>>> migrated.
>>>
>>> If destination qemu is already containing a dirty bitmap with the
>>> same name
>>> as a migrated bitmap (for the same node), then, if their
>>> granularities are
>>> the same the migration will be done, otherwise the error will be
>>> generated.
>>>
>>> If destination qemu doesn't contain such bitmap it will be created.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>> ---
>=20
> [...]
>=20
>>> +
>>> +static int dirty_bitmap_load_bits(QEMUFile *f, DirtyBitmapLoadState =
*s)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 uint64_t first_byte =3D qemu_get_be64(f) << BDRV_=
SECTOR_BITS;
>>> +=C2=A0=C2=A0=C2=A0 uint64_t nr_bytes =3D (uint64_t)qemu_get_be32(f) =
<< BDRV_SECTOR_BITS;
>>> +=C2=A0=C2=A0=C2=A0 trace_dirty_bitmap_load_bits_enter(first_byte >> =
BDRV_SECTOR_BITS,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 nr_bytes >> BDRV_SECTOR_BITS);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (s->flags & DIRTY_BITMAP_MIG_FLAG_ZEROES) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_dirty_bitmap_load_b=
its_zeroes();
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmap_deseria=
lize_zeroes(s->bitmap, first_byte,
>>> nr_bytes,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 false);
>>> +=C2=A0=C2=A0=C2=A0 } else {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t ret;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint8_t *buf;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t buf_size =3D qem=
u_get_be64(f);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t needed_size =3D
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b=
drv_dirty_bitmap_serialization_size(s->bitmap,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fir=
st_byte, nr_bytes);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (needed_size > buf_siz=
e ||
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b=
uf_size > QEMU_ALIGN_UP(needed_size, 4 + sizeof(long))
>> I think you meant '4 * sizeof(long)';=C2=A0 other than that, from the
>> migration side I'm OK, so with that fixed, and someone from the block
>> side checking the block code:
>>
>>
>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>
>=20
> Ohh, yes, 4 * sizeof(long).
> Who will finally pull it? Should I respin, or you fix it inflight?
>=20

I'm testing and staging it right now. David gave his blessing for me to
send a Pull Request.

--js
