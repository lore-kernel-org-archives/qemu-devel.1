Received: from eggs.gnu.org ([2001:4830:134:3::10]:54893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cYk84-0005da-BM
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 20:54:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cYk83-0006zp-CK
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 20:54:36 -0500
References: <20161220191523.5779-1-eblake@redhat.com>
	<20161220191523.5779-3-eblake@redhat.com>
	<c251adb7-7269-95f1-66aa-6d2457e5d8f6@redhat.com>
	<08d6f722-22b5-5604-46f7-0d1f812756f5@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <47a9569b-791e-2c16-7a13-d73d5e0bcd58@redhat.com>
Date: Wed, 1 Feb 2017 02:54:26 +0100
MIME-Version: 1.0
In-Reply-To: <08d6f722-22b5-5604-46f7-0d1f812756f5@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="tWGFnpEJMxW3CmBnfNluo80oPqa0tP8PD"
Subject: Re: [Qemu-devel] [PATCH v4 2/7] qcow2: Discard/zero clusters by
 byte count
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:qcow2" <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tWGFnpEJMxW3CmBnfNluo80oPqa0tP8PD
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:qcow2" <qemu-block@nongnu.org>
Message-ID: <47a9569b-791e-2c16-7a13-d73d5e0bcd58@redhat.com>
Subject: Re: [PATCH v4 2/7] qcow2: Discard/zero clusters by byte count
References: <20161220191523.5779-1-eblake@redhat.com>
 <20161220191523.5779-3-eblake@redhat.com>
 <c251adb7-7269-95f1-66aa-6d2457e5d8f6@redhat.com>
 <08d6f722-22b5-5604-46f7-0d1f812756f5@redhat.com>
In-Reply-To: <08d6f722-22b5-5604-46f7-0d1f812756f5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 30.01.2017 17:52, Eric Blake wrote:
> On 01/28/2017 02:21 PM, Max Reitz wrote:
>> On 20.12.2016 20:15, Eric Blake wrote:
>>> Passing a byte offset, but sector count, when we ultimately
>>> want to operate on cluster granularity, is madness.  Clean up
>>> the interfaces to take both offset and count as bytes, while
>>> still keeping the assertion added previously that the caller
>>> must align the values to a cluster.  Then rename things to
>>> make sure backports don't get confused by changed units:
>>> instead of qcow2_discard_clusters() and qcow2_zero_clusters(),
>>> we now have qcow2_cluster_discard and qcow2_cluster_zeroize().
>>>
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>>
>=20
>>> +int qcow2_cluster_zeroize(BlockDriverState *bs, uint64_t offset,
>>> +                          uint64_t count, int flags);
>>
>> I know byte count parameters are often called "count", but I find it a=

>> bit problematic if the function name contains a word that can be a uni=
t.
>> In these cases, it's not entirely clear whether "count" refers to byte=
s
>> or clusters. Maybe "length" or "size" would be better?
>=20
> Now that you mention it, 'cluster' and 'count' is indeed confusing.  I'=
m
> leaning towards 'size'.  Do I need to respin, or is that something that=

> the maintainer is comfortable tweaking?

There's probably not too much that could go wrong, but I wouldn't be
exactly comfortable with it.

>> Purely subjective and thus optional, of course.
>>
>> Another thing: I'm not quite positive whether qcow2_cluster_zeroize()
>> can actually handle a byte count greater than INT_MAX. If you could pa=
ss
>> such a number to it, the multiplication "ret * s->cluster_size" might
>> overflow. It's only caller qcow2_co_pwrite_zeroes() will never exceed
>> that limit, but maybe this should be made clear somewhere -- either by=

>> making the parameter an int instead of a uint64_t or by asserting it i=
n
>> the function.
>=20
> I'd lean towards an assertion, especially since it would be nice to
> someday unify all the internal block interfaces to get to a 64-bit
> interface wherever possible

Kevin once said "We should write code that makes sense today, not code
that will make sense some day in the future." Or something like that. :-)=


>                             (limiting ourselves to 32-bit is necessary
> for some drivers, like NBD, but that limitation should be enforced via
> proper BlockLimits, rather than by inherent limits in our API).  An
> assertion with 64-bit types is better than yet one more place to audit
> for missing assertions if we use a 32-bit type now and then widen to
> 64-bit later.

Depends on the viewpoint. You're right, it does prevent us from
accidentally implicitly narrowing a 64 bit size, but on the other hand,
it won't be clear just from looking at the function signature that this
function actually only supports a 32 bit parameter.

Not sure what to do here. Maybe switch to a language that would warn us
before implicitly narrowing values. */me ducks*

As long as the assertion is visible enough (i.e. immediately after the
variable declaration block), it should be fine.

Max

>>> -int qcow2_discard_clusters(BlockDriverState *bs, uint64_t offset,
>>> -    int nb_sectors, enum qcow2_discard_type type, bool full_discard)=

>>> +int qcow2_cluster_discard(BlockDriverState *bs, uint64_t offset,
>>> +                          uint64_t count, enum qcow2_discard_type ty=
pe,
>>> +                          bool full_discard)
>>>  {
>>>      BDRVQcow2State *s =3D bs->opaque;
>>> -    uint64_t end_offset;
>>> +    uint64_t end_offset =3D offset + count;
>>>      uint64_t nb_clusters;
>>>      int ret;
>>>
>>> -    end_offset =3D offset + (nb_sectors << BDRV_SECTOR_BITS);
>>> -
>>>      /* Caller must pass aligned values */
>>>      assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
>>>      assert(QEMU_IS_ALIGNED(end_offset, s->cluster_size));
>>
>> Directly below this we have "offset - end_offset" which could be
>> shortened to "count" (or "length" or "size" or...).
>=20
> Okay, there's now enough comments that it's worth me respinning a v5.


--tWGFnpEJMxW3CmBnfNluo80oPqa0tP8PD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliRP9ISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ArfMH/imTbiV/VUA08PhB02m2F/7wjfZvMngi
5/fIB7voA0mw29/hIgUpx2y5svO+y9iPi27ESjsdJ1CpIkK6F7IkJGQruQ3DArgp
qAqHuPOpDe9pptvts4MXygDrT3UR+weDtBfb3Hbv71xvuKMQOKKH5AWimVUTyjPX
7imv1VRfyhqHpASChjAeULYaD51obLfhkqYuq7rlrdpKm94NORi5yWvf+9XWvx0x
5LHpBOvmK3BPN4tiLSrzQ3OoY3FwDXR0jWXcGs9XXgdm4NSLw2TTGzkJI9C0Essm
9jgwEstpsuWW6lxkO+z7QL6xee3ylQYJy5MJxfKrD47BvDWiW4foTkk=
=E1Pm
-----END PGP SIGNATURE-----

--tWGFnpEJMxW3CmBnfNluo80oPqa0tP8PD--
