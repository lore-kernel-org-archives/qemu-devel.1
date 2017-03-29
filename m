Received: from eggs.gnu.org ([2001:4830:134:3::10]:38447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctLp5-0003Ey-CR
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 18:12:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctLp4-0008VC-6K
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 18:12:11 -0400
References: <20170313214001.26339-1-mreitz@redhat.com>
	<20170313214117.27350-4-mreitz@redhat.com>
	<20170320112637.GM17887@stefanha-x1.localdomain>
	<c84b9653-d89f-2baa-a92c-9332ce072b6d@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ccebecca-53e1-61b7-e5ea-f28656f586c3@redhat.com>
Date: Thu, 30 Mar 2017 00:12:01 +0200
MIME-Version: 1.0
In-Reply-To: <c84b9653-d89f-2baa-a92c-9332ce072b6d@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="msiNtiqlEEJrTuBjI5q3HKhStxp9S5eSJ"
Subject: Re: [Qemu-devel] [PATCH for-2.10 13/16] block/qcow2:
 qcow2_calc_size_usage() for truncate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--msiNtiqlEEJrTuBjI5q3HKhStxp9S5eSJ
From: Max Reitz <mreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <ccebecca-53e1-61b7-e5ea-f28656f586c3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 13/16] block/qcow2:
 qcow2_calc_size_usage() for truncate
References: <20170313214001.26339-1-mreitz@redhat.com>
 <20170313214117.27350-4-mreitz@redhat.com>
 <20170320112637.GM17887@stefanha-x1.localdomain>
 <c84b9653-d89f-2baa-a92c-9332ce072b6d@redhat.com>
In-Reply-To: <c84b9653-d89f-2baa-a92c-9332ce072b6d@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 20.03.2017 16:14, Max Reitz wrote:
> On 20.03.2017 12:26, Stefan Hajnoczi wrote:
>> On Mon, Mar 13, 2017 at 10:41:14PM +0100, Max Reitz wrote:
>>> This patch extends qcow2_calc_size_usage() so it can calculate the
>>> additional space needed for preallocating image growth.
>>>
>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>> ---
>>>  block/qcow2.c | 137 +++++++++++++++++++++++++++++++++++++++++-------=
----------
>>>  1 file changed, 98 insertions(+), 39 deletions(-)
>>>
>>> diff --git a/block/qcow2.c b/block/qcow2.c
>>> index 21b2b3cd53..80fb815b15 100644
>>> --- a/block/qcow2.c
>>> +++ b/block/qcow2.c
>>> @@ -2101,7 +2101,15 @@ done:
>>>      return ret;
>>>  }
>>> =20
>>> -static uint64_t qcow2_calc_size_usage(uint64_t new_size,
>>> +/**
>>> + * Returns the number of bytes that must be allocated in the underly=
ing file
>>> + * to accomodate an image growth from @current_size to @new_size.
>>> + *
>>> + * @current_size must be 0 when creating a new image. In that case, =
@bs is
>>> + * ignored; otherwise it must be valid.
>>> + */
>>> +static uint64_t qcow2_calc_size_usage(BlockDriverState *bs,
>>> +                                      uint64_t current_size, uint64_=
t new_size,
>>>                                        int cluster_bits, int refcount=
_order)
>>>  {
>>>      size_t cluster_size =3D 1u << cluster_bits;
>>> @@ -2122,47 +2130,97 @@ static uint64_t qcow2_calc_size_usage(uint64_=
t new_size,
>>>      refblock_bits =3D cluster_bits - (refcount_order - 3);
>>>      refblock_size =3D 1 << refblock_bits;
>>> =20
>>> -    /* header: 1 cluster */
>>> -    meta_size +=3D cluster_size;
>>> -
>>> -    /* total size of L2 tables */
>>> -    nl2e =3D aligned_total_size / cluster_size;
>>> -    nl2e =3D align_offset(nl2e, cluster_size / sizeof(uint64_t));
>>> -    meta_size +=3D nl2e * sizeof(uint64_t);
>>> +    if (!current_size) {
>>
>> This massive if statement effectively makes two functions: the old
>> qcow2_calc_size_usage() and the new qcow2_calc_size_change(bs) functio=
n.
>>
>> It might be nicer to split the two functions.
>=20
> Hm, yes, but at that point I might as well just write two completely
> separate functions. I'll see what I can do, maybe I'll just put the new=

> logic that's needed into a completely new function after all.

I'm having a bit of trouble with the split, due to a couple of reasons:

First, I can't think of a good name for the new function.
qcow2_calc_growth_size_usage() is a bit long and still not really
meaningful...

Second, having all the functionality in a single function means we can
"share" the explanation of how nrefblocke is calculated. I don't really
want to just put a reference comment there ("look it up in
qcow2_create2()"), but I definitely don't want to duplicate it either.

Finally, having it in a single function may not make much sense from the
inside but it does very much so from the outside. Even though we have to
follow much different code paths, from the outside it's pretty much the
same thing.


Therefore, I'm probably going to keep this patch as-is in v2 (for now),
expecting more criticism and stronger wording than "might be nicer",
forcing me to finally do the split in an eventual v3. O:-)

Max


--msiNtiqlEEJrTuBjI5q3HKhStxp9S5eSJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljcMTESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Ar5wH/3DDbWJLW+DDqHldTLRGImJpzsW1NqoV
o75H4BlrElRSdaXX1mVP6UTaukHCRLagEGRIH3X0Nur2VpTn9vgyCNERwMH6W1Gn
BTd5Fw/65nVQkgFZpO2qINflFlx27l48VBfhcccuVR9nd/zI6XFngVlU7OvNWS0p
vttZlBVMiqxuM55i+1apjko93HL+6G3kf+agm3O0Vfe5TXTFvLHl41/sIFCXUFQx
joh3tmICquiWrEXKK2SOfcWWQxkFTxV+mhn8ikJ3zWhtXplHNcOBT5lTv8B1lECo
VWnFz0lmXCXOVKtbXgQIFv2OGEHrEPhDW4OJO21AtHgth9iXAENVLQc=
=yMWM
-----END PGP SIGNATURE-----

--msiNtiqlEEJrTuBjI5q3HKhStxp9S5eSJ--
