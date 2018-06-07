Received: from eggs.gnu.org ([2001:4830:134:3::10]:53757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fQzuL-0004FA-Iu
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 14:45:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fQzuK-0000pR-Fq
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 14:45:13 -0400
References: <1516366207-109842-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1516366207-109842-9-git-send-email-anton.nefedov@virtuozzo.com>
	<b0066a7f-0197-73c9-4012-67b5e48e178a@redhat.com>
	<87tvuyf4it.fsf@dusky.pond.sub.org>
	<959271ee-c39e-09ab-9f9a-90d97d34f4f5@virtuozzo.com>
	<87wovar5tl.fsf@dusky.pond.sub.org>
	<c807b13d-8176-46a5-72b9-dade0ad0712a@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <02f27bf7-e371-c396-eaec-1f9e3e24611e@redhat.com>
Date: Thu, 7 Jun 2018 13:45:03 -0500
MIME-Version: 1.0
In-Reply-To: <c807b13d-8176-46a5-72b9-dade0ad0712a@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 8/8] qapi: query-blockstat: add driver
 specific file-posix stats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, Markus Armbruster <armbru@redhat.com>
Cc: kwolf@redhat.com, den@virtuozzo.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com, jsnow@redhat.com

On 06/07/2018 10:23 AM, Anton Nefedov wrote:
>>> If we introduce BlockdevDriver as a discriminator as Markus suggests
>>> above, we need some way to define its value.
>>> I guess one would be to check blk->bs->drv->format_name but it won't
>>> always work; often it's even blk->bs =3D=3D NULL.
>>
>> There is no blk->bs, at least not if blk is a BlockBackend *.
>>
>> I figure the problem you're trying to describe is query-blockstats
>> running into BlockBackends that aren't associated with a
>> BlockDriverState (blk->root is null), and thus aren't associated with =
a
>> BlockDriver.=C2=A0 Correct?
>>
>=20
> Sorry, yes, exactly

Okay, that sounds like the driver stats have to be optional, present=20
only when blk->bs is non-NULL.

>=20
>>> I guess we could add a default ('unspecified'?) to BlockdevDriver enu=
m?
>>
>> This part I understand, but...
>>
>>> But I'd rather leave an optional BlockDriverStats union (but make it
>>> flat). Only the drivers that provide these stats will need to set
>>> BlockdevDriver field. What do you think?
>>
>> I'm not sure I got this part.=C2=A0 Care to sketch the QAPI schema sni=
ppet?
>>
>=20
> You earlier proposed:
>=20
>  >>> You're adding a union of driver-specific stats to a struct of gene=
ric
>  >>> stats.=C2=A0 That's unnecessarily complicated.=C2=A0 Instead, turn=
 the struct of
>  >>> generic stats into a flat union, like this:
>  >>>
>  >>> { 'union': 'BlockStats',
>  >>>=C2=A0=C2=A0=C2=A0=C2=A0 'base': { ... the generic stats, i.e. the =
members of BlockStats
>  >>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 before this patch ...
>  >>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 'driver': 'BlockdevDriver' }
>  >>>=C2=A0=C2=A0=C2=A0=C2=A0 'discriminator': 'driver',
>  >>>=C2=A0=C2=A0=C2=A0=C2=A0 'data': {
>  >>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'file': 'BlockDriv=
erStatsFile',
>  >>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ... } }

That would require 'driver' to always resolve to something, even when=20
there is no driver (unless we create a superset enum that adds 'none'=20
beyond what 'BlockdevDriver' supports).

>=20
> But I meant to leave it as:
>=20
> + { 'union': 'BlockDriverStats':
> +=C2=A0=C2=A0=C2=A0=C2=A0 'base': { 'driver': 'BlockdevDriver' },
> +=C2=A0=C2=A0=C2=A0=C2=A0 'discriminator': 'driver',
> +=C2=A0=C2=A0=C2=A0=C2=A0 'data': {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'file': 'BlockDriverS=
tatsFile' } }
>=20
>=20
>  =C2=A0 { 'struct': 'BlockStats',
>  =C2=A0=C2=A0=C2=A0 'data': {'*device': 'str', '*node-name': 'str',
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 'stats': 'BlockDeviceStats',
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '*d=
river-stats': 'BlockDriverStats',
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 '*parent': 'BlockStats',
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 '*backing': 'BlockStats'} }
>=20
> so those block backends which do not provide driver stats do not need t=
o
> set BlockdevDriver field.

This makes the most sense to me - we're stuck with a layer of nesting,=20
but that's because driver-stats truly is optional (we don't always have=20
access to a driver).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
