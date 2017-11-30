Received: from eggs.gnu.org ([2001:4830:134:3::10]:37113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKnhx-0002nZ-Ll
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 10:59:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKnhL-0005Fa-D7
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 10:58:33 -0500
References: <20171012185916.22776-1-eblake@redhat.com>
	<20171012185916.22776-10-eblake@redhat.com>
	<ea4f3617-a892-4fa1-4605-39d162a8df04@virtuozzo.com>
	<36925b5d-60f8-2799-b221-cebd940adc5f@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c6a0a807-11d9-0b3f-ad31-ce55a114bc10@redhat.com>
Date: Thu, 30 Nov 2017 16:18:02 -0600
MIME-Version: 1.0
In-Reply-To: <36925b5d-60f8-2799-b221-cebd940adc5f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 09/20] parallels: Switch to
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
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>, jsnow@redhat.com

On 11/30/2017 04:12 PM, Eric Blake wrote:

>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BDRVParallelsState *s =3D bs->opaque;
>>> -=C2=A0=C2=A0=C2=A0 int64_t offset;
>>> +=C2=A0=C2=A0=C2=A0 int count;
>>>
>>> +=C2=A0=C2=A0=C2=A0 assert(QEMU_IS_ALIGNED(offset | bytes, BDRV_SECTO=
R_SIZE));
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_co_mutex_lock(&s->lock);
>>> -=C2=A0=C2=A0=C2=A0 offset =3D block_status(s, sector_num, nb_sectors=
, pnum);
>>> +=C2=A0=C2=A0=C2=A0 offset =3D block_status(s, offset >> BDRV_SECTOR_=
BITS,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 bytes >> BDRV_SECTOR_BITS, &count);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_co_mutex_unlock(&s->lock);
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (offset < 0) {
>>
>> pnum=3Dcount*BDRV_SECTOR_SIZE and map=3D0 setting missed here.
>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> Setting *map is only required when return value includes=20
> BDRV_BLOCK_OFFSET_VALID, so that one was not necessary.=C2=A0 But you d=
o=20
> raise an interesting point about a pre-existing bug with pnum not being=
=20
> set.=C2=A0 Commit 298a1665a guarantees that *pnum is 0 (and not uniniti=
alized=20
> garbage) - but that still violates the contract that we (want to) have=20
> that all drivers either make progress or return an error (setting pnum=20
> to 0 should only be done at EOF or on error).

Oh. The pre-existing code DID set pnum to a non-zero value, as a side=20
effect of block_status(); the new code fails to do so.  So it is not=20
pre-existing; good catch!

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
