Received: from eggs.gnu.org ([2001:4830:134:3::10]:45137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVfVJ-0005mt-H6
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 11:58:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVfVI-0002Qn-MK
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 11:58:41 -0400
References: <20180609151758.17343-1-vsementsov@virtuozzo.com>
	<20180609151758.17343-5-vsementsov@virtuozzo.com>
	<4ab9dd4e-1c79-fbe2-8e4b-6563e3775366@redhat.com>
	<06695fb3-d395-ce4f-4cb8-c056aa60bfa1@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <48d62992-9e91-6df9-5e46-fa6f81eab74b@redhat.com>
Date: Wed, 20 Jun 2018 10:58:32 -0500
MIME-Version: 1.0
In-Reply-To: <06695fb3-d395-ce4f-4cb8-c056aa60bfa1@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 4/6] nbd/server: implement dirty bitmap
 export
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, mreitz@redhat.com, armbru@redhat.com, den@openvz.org

On 06/20/2018 10:43 AM, Eric Blake wrote:
> On 06/20/2018 06:24 AM, Eric Blake wrote:
>=20
>>> +/* Set several extents, describing region of given @length with=20
>>> given @flags.
>>> + * Do not set more than @nb_extents, return number of set extents.
>>> + */
>>> +static unsigned add_extents(NBDExtent *extents, unsigned nb_extents,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 uint64_t length, uint32_t flags)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 unsigned i =3D 0;
>>> +=C2=A0=C2=A0=C2=A0 uint32_t max_extent =3D QEMU_ALIGN_DOWN(INT32_MAX=
, BDRV_SECTOR_SIZE);
>>
>> This is too small of a granularity wrong when the server advertised 4k=
=20
>> alignment during NBD_OPT_GO; it should probably refer to=20
>> bs->bl.request_alignment.
>=20
> In fact, we can just use INT32_MAX. The dirty bitmap has a granularity=20
> at least as large as the sector size, but no smaller than the=20
> request_alignment. We don't have to worry about alignment here, as the=20
> extents will already be naturally aligned when converting from the=20
> bitmap into extents in the caller.

Oh, I see. The NBD protocol can only ask for a length of up to 32 bits,=20
but if you learn via bitmap query that the entire rest of the image has=20
the same state, you can indeed call add_extents() with a value larger=20
than 32 bits, that needs to be fragmented back down into sub-32-bit=20
chunks.  INT32_MAX isn't quite right, but rounding may still pick the=20
wrong granularity on an export with 4k alignment; however, INT32_MAX +=20
1U is just fine, and unlikely to run into alignment issues.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
