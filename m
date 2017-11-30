Received: from eggs.gnu.org ([2001:4830:134:3::10]:38404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKniu-0003rn-V7
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:00:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKniE-0006Ak-T7
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 10:59:33 -0500
References: <20171012185916.22776-1-eblake@redhat.com>
	<20171012185916.22776-19-eblake@redhat.com>
	<2798892b-cd79-e958-9a26-5ff6ee9185fd@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <51bb9d75-fafe-6970-fb8a-746d279ece74@redhat.com>
Date: Thu, 30 Nov 2017 17:28:59 -0600
MIME-Version: 1.0
In-Reply-To: <2798892b-cd79-e958-9a26-5ff6ee9185fd@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 18/20] vpc: Switch to
 .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 11/30/2017 06:22 AM, Vladimir Sementsov-Ogievskiy wrote:
> 12.10.2017 21:59, Eric Blake wrote:
>> We are gradually moving away from sector-based interfaces, towards
>> byte-based.=C2=A0 Update the vpc driver accordingly.=C2=A0 Drop the no=
w-unused
>> get_sector_offset().
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>
>> ---

>>
>> -=C2=A0=C2=A0=C2=A0 offset =3D get_image_offset(bs, sector_num << BDRV=
_SECTOR_BITS,=20
>> false, NULL);
>> -=C2=A0=C2=A0=C2=A0 start =3D offset;
>> -=C2=A0=C2=A0=C2=A0 allocated =3D (offset !=3D -1);
>> +=C2=A0=C2=A0=C2=A0 image_offset =3D get_image_offset(bs, offset, fals=
e, NULL);
>> +=C2=A0=C2=A0=C2=A0 start =3D image_offset & BDRV_BLOCK_OFFSET_MASK;
>=20
> why do you do so? round down to sector boundary? does it mean,
> that *map will corresponds not to offset, but to some previous byte?

Ouch, leftovers from before the interface change in v4.  Will fix.


>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 offset =3D get_image_offse=
t(bs, sector_num << BDRV_SECTOR_BITS,=20
>> false,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 image_offset =3D get_image=
_offset(bs, offset, false, NULL);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } while (offset =3D=3D -1);
>=20
> image_offset here?

Yes.  (Does it show that for non-typical formats, I only compile-tested=20
instead of actually running iotests on the format?)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
