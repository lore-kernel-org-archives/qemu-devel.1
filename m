Received: from eggs.gnu.org ([2001:4830:134:3::10]:43825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dPY6o-0004YC-92
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 13:47:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dPY6n-0000xQ-06
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 13:47:34 -0400
References: <20170613121639.17853-1-pbutsykin@virtuozzo.com>
	<20170613121639.17853-4-pbutsykin@virtuozzo.com>
	<aed64e0e-61ed-12c9-8676-ad55795b6e62@redhat.com>
	<5fb63c73-ddc7-ba42-268f-bda160aebb6e@virtuozzo.com>
	<d3c0c0c2-da7e-bfff-e3c6-2d419c1126b9@redhat.com>
	<3b1b1a7e-ab9f-1376-fc3c-0853fb12987b@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <67df3935-2ef1-b664-11aa-bb6bdf91013b@redhat.com>
Date: Mon, 26 Jun 2017 19:47:05 +0200
MIME-Version: 1.0
In-Reply-To: <3b1b1a7e-ab9f-1376-fc3c-0853fb12987b@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Hc0KApbsAv7sHX4PEXN5ubJXP45EU9MER"
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
--Hc0KApbsAv7sHX4PEXN5ubJXP45EU9MER
From: Max Reitz <mreitz@redhat.com>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, armbru@redhat.com, den@openvz.org
Message-ID: <67df3935-2ef1-b664-11aa-bb6bdf91013b@redhat.com>
Subject: Re: [PATCH v2 3/4] qcow2: add shrink image support
References: <20170613121639.17853-1-pbutsykin@virtuozzo.com>
 <20170613121639.17853-4-pbutsykin@virtuozzo.com>
 <aed64e0e-61ed-12c9-8676-ad55795b6e62@redhat.com>
 <5fb63c73-ddc7-ba42-268f-bda160aebb6e@virtuozzo.com>
 <d3c0c0c2-da7e-bfff-e3c6-2d419c1126b9@redhat.com>
 <3b1b1a7e-ab9f-1376-fc3c-0853fb12987b@virtuozzo.com>
In-Reply-To: <3b1b1a7e-ab9f-1376-fc3c-0853fb12987b@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-26 17:23, Pavel Butsykin wrote:
> On 23.06.2017 18:46, Max Reitz wrote:
>> On 2017-06-22 15:57, Pavel Butsykin wrote:
>>>
>>> On 22.06.2017 01:55, Max Reitz wrote:
>>>> On 2017-06-13 14:16, Pavel Butsykin wrote:
> []
>>>>> +        }
>>>>> +        qcow2_cache_put(bs, s->refcount_block_cache, &refblock);
>>>>> +
>>>>> +        reftable_tmp[i] =3D unused_block ? 0 :
>>>>> cpu_to_be64(s->refcount_table[i]);
>>>>> +    }
>>>>> +
>>>>> +    ret =3D bdrv_pwrite_sync(bs->file, s->refcount_table_offset,
>>>>> reftable_tmp,
>>>>> +                           sizeof(uint64_t) *
>>>>> s->refcount_table_size);
>>>>> +    if (ret < 0) {
>>>>> +        goto out;
>>>>> +    }
>>>>> +
>>>>> +    for (i =3D 0; i < s->refcount_table_size; i++) {
>>>>> +        if (s->refcount_table[i] && !reftable_tmp[i]) {
>>>>> +            qcow2_free_clusters(bs, s->refcount_table[i] &
>>>>> REFT_OFFSET_MASK,
>>>>> +                                s->cluster_size,
>>>>> QCOW2_DISCARD_ALWAYS);
>>>>
>>>> This doesn't feel like a very good idea. The bdrv_pwrite_sync() befo=
re
>>>> has brought the on-disk refcount structures into a different state t=
han
>>>> what we have cached.
>>>
>>> It is for this inside qcow2_free_clusters()->update_refcount() the ca=
che
>>> is discarded by qcow2_cache_discard().
>>
>> This doesn't change the fact that the in-memory reftable is different
>> from the on-disk reftable and that qcow2_free_clusters() may trip up o=
n
>> that; the main issue is the allocate_refcount_block() call before.

*alloc_refcount_block(), sorry.

> before what?

Before qcow2_cache_discard() is called.

> If we are talking about allocate_refcount_block() calls after
> bdrv_pwrite_sync(), then... Inside allocate_refcount_block() will alway=
s
> be called load_refcount_block(), what actually is not so dangerous even=

> if refcount_block_cache is empty. Because the refblock offset will
> always be taken from s->refcount_table.

Well, yes, and this offset has not been cleared yet, so it still points
to the old refblock (but the on-disk reftable does not, and this worries
me).

>> So we need a guarantee that update_refcount() won't touch the reftable=

>> if the refcount is decreased. It will call alloc_refcount_block() and
>> that should definitely find the respective refblock to already exist
>> because of course it has a refcount already.
>=20
> We don't touch the refblocks which contain references to other
> refblocks, this ensures that update_refcount() will not try to raise
> the discarded refblock.

It may ensure this in practice, yes, but I found proving this to be
rather difficult.

>> But here's an issue: It tries to read from s->refcount_table[], and yo=
u
>> are slowly overwriting it in the same loop here. So it may not actuall=
y
>> find the refcount (if a refblock is described by an earlier one).
>> (After more than an hour of debugging, I realized this is not true: Yo=
u
>> will only zero reftable entries if the refblock describes nothing or
>> only themselves. So overwriting one reftable entry cannot have effects=

>> on other refblocks. Or at least it should not.)
>=20
> As you've noticed, here uses a simple approach:

Well, if it is a simple approach, I'm just very dense.

> We discard only refblocks that contain nothing or own reference. If we
> have a refblock that is actually empty, but contains a reference to
> another empty refblock, we don't touch this refblock. Maybe it's not th=
e
> best solution, but at least it's simple and secure.

The theory is simple, yes, which is why I found it fine until the point
you decide to call usual refcount management functions with the on-disk
data differing from what is cached as s->refcount_table.

> There is another approach that can be applied here:
>=20
> 1. decrease the refcounts for all refblocks

I think this will leave a broken image at this point, so I'd rather
avoid it.

> 2. find all empty refblocks
> 3. increase the refcounts for all refblocks
> 4. rewrite the refcount_table on disk (with the empty reftable entries)=

> 5. release all the emptt reblocks in reverse order (start at the end of=

> the s->refcount_table)
>=20
> This will certainly allow us to get rid of all empty reblocks, but the
> code will be less welcoming :) Also the case when the refblock contains=

> a reference to another refblock is quite rare.

Another way would be to invoke the function for dropping empty refblocks
repeatedly until no refblocks can be dropped anymore. This wouldn't
cover cyclic references, but I think that's fine.

In any case, though, I agree that we don't need to put too much work
into this. Refblocks by default just use around 0.03 % of what's needed
for data, so...

>> Another potential issue is that you're assuming s->refcount_table_size=

>> to be constant. I cannot find a way for it not to be, but investigatin=
g
>> this is painful and I can't claim I know for sure that it is constant.=

>> If it isn't, you may get overflows when accessing reftable_tmp[].
>>
>> (Yes, it may be constant; but the reader of this code has to read
>> through qcow2_free_clusters(), allocate_refcount_block() and
>> update_refcount() to know (or at least to guess) that's the case.)
>=20
> Is there any guarantee that in the future this will not change? Because=

> in this case it can be a potential danger.

Since this behavior is not documented anywhere, there is no guarantee.

> I can add a comment... Or add a new variable with the size of
> reftable_tmp, and every time count min(s->refcount_table_size,
> reftable_tmp_size)
> before accessing to s->refcount_table[]/reftable_tmp[]

Or (1) you add an assertion that refcount_table_size doesn't change
along with a comment why that is the case, which also explains in detail
why the call to qcow2_free_clusters() should be safe: The on-disk
reftable differs from the one in memory. qcow2_free_clusters()and
update_refcount() themselves do not access the reftable, so they are
safe. However, update_refcount() calls alloc_refcount_block(), and that
function does access the reftable: Now, as long as
s->refcount_table_size does not shrink (which I can't see why it would),
refcount_table_index should always be smaller. Now we're accessing
s->refcount_table: This will always return an existing refblock because
this will either be the refblock itself (for self-referencing refblocks)
or another one that is not going to be freed by qcow2_shrink_reftable()
because this function will not free refblocks which cover other clusters
than themselves.
We will then proceed to update the refblock which is either right (if it
is not the refblock to be freed) or won't do anything (if it is the one
to be freed).
In any case, we will never write to the reftable and reading from the
basically outdated cached version will never do anything bad.

Or (2) you copy reftable_tmp into s->refcount_table[] *before* any call
to qcow2_free_clusters(). To make this work, you would need to also
discard all refblocks from the cache in this function here (and not in
update_refcount()) and then only call qcow2_free_clusters() on refblocks
which were not self-referencing. An alternative hack would be to simply
mark the image dirty and just not do any qcow2_free_clusters() call...

Or (3) of course it would be possible to not clean up refcount
structures at all...

Max


--Hc0KApbsAv7sHX4PEXN5ubJXP45EU9MER
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZUUiZEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQKM9
B/4pnkBFC2rACum+3a038btq3GacPVn8CaZVPxtxjCE1vI53TXYX5uICH1FvukHm
SkL08rEhI11dczMOTVzqRTeYzxD5Mlx+zFotWUg9PGfk5fqPaQuYuQRKHxGyfXMx
SGD98E8rzMoN8awO9KUocGtDtPIQ6beqDtvenBIapwKwkM9WIewDcefLAlGDugKh
oJ4277nvyY58UAgIe+hOA1e3b2dp4bdgFxO2MbTzs9upPLQVdEjOoG6eNrzPGUHi
pR6SbZ2XOK9Sss0Tbu+z+QkBnPvs888h0EoRrkBOUo9AjzRqiZpVq3BgOGtCkti3
y6Ma6GsUjJqo86ZQHu+hYehs
=G7XQ
-----END PGP SIGNATURE-----

--Hc0KApbsAv7sHX4PEXN5ubJXP45EU9MER--
