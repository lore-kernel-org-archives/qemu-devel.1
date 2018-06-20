Received: from eggs.gnu.org ([2001:4830:134:3::10]:35301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVfH4-0001we-ST
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 11:43:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVfH3-0005z0-Fq
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 11:43:58 -0400
References: <20180609151758.17343-1-vsementsov@virtuozzo.com>
	<20180609151758.17343-5-vsementsov@virtuozzo.com>
	<4ab9dd4e-1c79-fbe2-8e4b-6563e3775366@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <06695fb3-d395-ce4f-4cb8-c056aa60bfa1@redhat.com>
Date: Wed, 20 Jun 2018 10:43:52 -0500
MIME-Version: 1.0
In-Reply-To: <4ab9dd4e-1c79-fbe2-8e4b-6563e3775366@redhat.com>
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
Cc: kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org, armbru@redhat.com, mreitz@redhat.com

On 06/20/2018 06:24 AM, Eric Blake wrote:

>> +/* Set several extents, describing region of given @length with given=
=20
>> @flags.
>> + * Do not set more than @nb_extents, return number of set extents.
>> + */
>> +static unsigned add_extents(NBDExtent *extents, unsigned nb_extents,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 uint64_t length, uint32_t flags)
>> +{
>> +=C2=A0=C2=A0=C2=A0 unsigned i =3D 0;
>> +=C2=A0=C2=A0=C2=A0 uint32_t max_extent =3D QEMU_ALIGN_DOWN(INT32_MAX,=
 BDRV_SECTOR_SIZE);
>=20
> This is too small of a granularity wrong when the server advertised 4k=20
> alignment during NBD_OPT_GO; it should probably refer to=20
> bs->bl.request_alignment.

In fact, we can just use INT32_MAX. The dirty bitmap has a granularity=20
at least as large as the sector size, but no smaller than the=20
request_alignment. We don't have to worry about alignment here, as the=20
extents will already be naturally aligned when converting from the=20
bitmap into extents in the caller.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
