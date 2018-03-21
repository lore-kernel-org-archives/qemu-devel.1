Received: from eggs.gnu.org ([2001:4830:134:3::10]:41759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eydTw-0006i4-8z
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:08:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eydTv-0004ty-6j
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:08:44 -0400
References: <20180320135515.16823-1-berto@igalia.com>
	<665e0ccd-4440-4e0e-30f9-e38537795325@redhat.com>
	<w51po3xixqz.fsf@maestria.local.igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1809fec1-cdf6-0da4-14e8-04b01d4fc48b@redhat.com>
Date: Wed, 21 Mar 2018 08:08:23 -0500
MIME-Version: 1.0
In-Reply-To: <w51po3xixqz.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12] qcow2: Reset free_cluster_index
 when allocating a new refcount block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 03/21/2018 04:28 AM, Alberto Garcia wrote:
> On Tue 20 Mar 2018 06:54:15 PM CET, Eric Blake wrote:
>=20
>>> When we try to allocate new clusters we first look for available ones
>>> starting from s->free_cluster_index and once we find them we increase
>>> their reference counts. Before we get to call update_refcount() to do
>>> this last step s->free_cluster_index is already pointing to the next
>>> cluster after the ones we are trying to allocate.
>>>
>>   > During update_refcount() it may happen however that we also need t=
o
>>   > allocate a new refcount block in order to store the refcounts of
>>   > these new clusters
>>
>> Your changes to test 121 covers this...
>>
>>   > (and to complicate things further that may also require us to grow
>>   > the refcount table).
>>
>> ...but not this.  Is it worth also trying to cover this case in the
>> testsuite as well?
>=20
> I checked and the patch doesn't really fix that scenario. There's a
> different problem that I haven't debugged completely yet, because of tw=
o
> reasons:
>=20
>   - One difference is that when we grow the refcount table we actually
>     allocate a new one, so s->free_cluster_index points to the beginnin=
g
>     of the image (where the previous table was) and any holes left duri=
ng
>     the process are allocated after that (depending on how much data we
>     write though).

Yeah, that can make the test harder to reason about, and is slightly=20
more sensitive to our internal algorithm - but it also explains why you=20
checked for index > start rather than unconditionally assigning index =3D=
=20
start.

>=20
>   - This scenario is harder to reach: in order to fill a 1-cluster
>     refcount table the size of the image needs to be larger than
>     (cluster_size=C2=B3 / refcount_bits) bytes, that's 16TB with the de=
fault
>     parameters. So although it can be reproduced easily if you reduce t=
he
>     cluster size I think it's very infrequent under normal conditions.

Yes, 16TB for default size, but only 2M for the best-case (512-byte=20
cluster, 64-bit refcount), so still easy to write a test for.

>=20
> But yes, it's a task left for the future.

Fair enough.

>=20
>>> +            /* If the caller needs to restart the search for free cl=
usters,
>>> +             * try the same ones first to see if they're still free.=
 */
>>> +            if (ret =3D=3D -EAGAIN) {
>>> +                if (s->free_cluster_index > (start >> s->cluster_bit=
s)) {
>>> +                    s->free_cluster_index =3D (start >> s->cluster_b=
its);
>>> +                }
>>
>> Is there any harm in making this assignment unconditional, instead of
>> only doing it when free_cluster_index has grown larger than start?
>=20
> It can happen that it is smaller than 'start' if we were moving the
> refcount table to a new location, so we want to keep the lowest value.

Okay, then my R-b is sufficient on the patch as-is.

>=20
>> [And unrelated, but it might be nice to do a followup cleanup to track
>> free_cluster_offset by bytes instead of having to shift
>> free_cluster_index everywhere]
>=20
> I've actually just seen that we already have free_byte_offset, we use
> that for compressed clusters, so it might be possible to use that one..=
.

free_byte_offset really IS a byte offset, as it can point mid-cluster.=20
But having EVERYTHING be byte-based seems like it will make reasoning=20
about the code easier to do.

>=20
> I'll put that in my TODO list.
>=20
> Berto
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
