Received: from eggs.gnu.org ([2001:4830:134:3::10]:36841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7MUQ-0000l7-SQ
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 11:21:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7MUQ-0005Dc-5U
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 11:21:34 -0400
References: <20181002113325.12911-1-vsementsov@virtuozzo.com>
	<20181002113325.12911-2-vsementsov@virtuozzo.com>
	<5709dbd2-1de5-3440-870e-127aae8f469e@redhat.com>
	<ef7c913f-21a6-a85a-55e2-22761dd03084@virtuozzo.com>
	<e1e14dad-78bc-f504-9f7f-738ca53af3f6@redhat.com>
	<3c64931c-014a-3911-2ff8-4ac3cfef84b3@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4de51a49-c0a1-99fb-8a0b-67af3c22e74d@redhat.com>
Date: Tue, 2 Oct 2018 10:21:23 -0500
MIME-Version: 1.0
In-Reply-To: <3c64931c-014a-3911-2ff8-4ac3cfef84b3@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] qapi: support device id for
 x-block-latency-histogram-set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "armbru@redhat.com" <armbru@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, Denis Lunev <den@virtuozzo.com>, Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>, "jsnow@redhat.com" <jsnow@redhat.com>

On 10/2/18 9:58 AM, Vladimir Sementsov-Ogievskiy wrote:

>>>>> -# @device: device name to set latency histogram for.
>>>>> +# @device: device name to set latency histogram for (better use @i=
d).
>>>>> +#
>>>>> +# @id: The name or QOM path of the guest device.
>>>>

> Hm. It all looks a bit weird. I've just duplicated block_set_io_throttl=
e
> interface:

But that interface was pre-existing under a stable name, so it had to=20
worry about back-compat. Here, we are adding a new command, so we don't=20
have to be stuck with back-compat ugliness.

>=20
> # @device: Block device name (deprecated, use @id instead)
> #
> # @id: The name or QOM path of the guest device (since: 2.8)
>=20
>   =C2=A0=C2=A0=C2=A0 blk =3D qmp_get_blk(arg->has_device ? arg->device =
: NULL,
>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arg->has_id ? a=
rg->id : NULL,
> errp);
>   =C2=A0=C2=A0=C2=A0 if (!blk) {
> return;
>   =C2=A0=C2=A0=C2=A0 }
>=20
>=20
> So, looks like "The name or" is wrong part. @id can be only path.
>=20
> However, I can call blk_by_name on @id, if blk_by_qdev_id failed..
>=20
> So, variants:
>=20
> 1. both parameters, current code, but fix documentation (will be @id:
> QOM path of the guest device.)
> 2. only @id and only QOM path
> 3. only @id, but fullback to blk_by_name(@id) if failed to find qdev.
>=20
> Any option is ok for me, I don't care. What do you think?

I'm leaning towards 3.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
