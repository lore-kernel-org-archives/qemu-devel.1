Received: from eggs.gnu.org ([2001:4830:134:3::10]:36939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emKaU-0000mh-WD
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 09:32:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1emKaT-0006kM-OW
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 09:32:39 -0500
References: <1516366207-109842-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1516366207-109842-9-git-send-email-anton.nefedov@virtuozzo.com>
	<b0066a7f-0197-73c9-4012-67b5e48e178a@redhat.com>
	<87tvuyf4it.fsf@dusky.pond.sub.org>
	<8639a69c-ca85-d11b-7aaa-e67ffb660991@virtuozzo.com>
	<3066afcc-60e6-2bb9-5ea9-4befff726eb0@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ef7ef789-6143-5cad-4353-dc7454c7b481@redhat.com>
Date: Thu, 15 Feb 2018 08:32:19 -0600
MIME-Version: 1.0
In-Reply-To: <3066afcc-60e6-2bb9-5ea9-4befff726eb0@virtuozzo.com>
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
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, den@virtuozzo.com, qemu-block@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com, jsnow@redhat.com

On 02/15/2018 04:23 AM, Anton Nefedov wrote:
>> The output is better indeed, thanks; a little drawback is now we need =
to
>> pass the whole BlockStats to the driver so it fills its stats.
>>
>> e.g. the interface:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 void (*bdrv_get_stats)(BlockDriverState *bs, =
BlockStats *stats);
>>
>> And that BlockdevDriver subset type (or a generator patch) still seems
>> to be needed
>>
>> =C2=A0=C2=A0 { 'enum' : 'BlockdevDriverWithStats',
>> =C2=A0=C2=A0=C2=A0=C2=A0 'data' : [ 'file' ] }
>=20
> Hmm, actually it seems the driver-specific-stats should either be
> optional, or we need to handle the rest of the drivers in the generated
> code.

No, we don't want a new enum.  Rather, use the existing enum, and use an=20
empty type for all the branches of the union that have no additional=20
stats to add.

>=20
> (i.e. with the dummy enum as above, what should the mandatory 'driver'
> field be when there's e.g. nbd driver? It will default to 0, and that i=
s
> BLOCKDEV_DRIVER_WITH_STATS_FILE, so it will be interpreted as 'file' in
> qmp output)
>=20
>=20
> If we patch the generator, I guess we could add smth like a new tag to
> the union that has no data for some discriminators?

Right now, the way to write a union where only some branches add fields i=
s:

{ 'struct': 'SomeEmptyType', 'data': {} }
{ 'union': 'MyUnion', 'base':'Base', 'discriminator':'foo',
   'data': { 'file': 'ExtraFields',
             'nbd': 'SomeEmptyType',
             ... } }

I also have a patch that I can revive (posted months ago) that would allo=
w:

   'data': { 'file': 'ExtraFields',
             'nbd': {},
             ... } }

so that we don't have to explicitly create a pointless empty type for=20
the branches that don't care.

Meanwhile, here's an example post that uses the explicit empty type idiom=
:
https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg03991.html

>=20
> e.g.
>=20
> { 'union': 'BlockStats',
>  =C2=A0 'base': {'*device': 'str', '*node-name': 'str',
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'stats': =
'BlockDeviceStats',
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '*parent'=
: 'BlockStats',
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 '*backing=
': 'BlockStats',
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'driver':=
 'BlockdevDriver'},
>  =C2=A0 'discriminator': 'driver',
>  =C2=A0 'data-optional': {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 <---- instead of 'data'
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'file': 'BlockDriverStatsFile',
>  =C2=A0 } }
>=20
> Then the generator would need to:
>  =C2=A0 - pick either 'data-optional' or 'data' members

I'd rather keep it 'data': {} for the list of branches that have=20
additional members, and add a new boolean, maybe 'partial-data':true, as=20
the witness of whether the generator requires coverage for all enum=20
values, or will implicitly allow the uncovered enum values as though=20
they had an empty type.

>  =C2=A0 - skip 'data missing branch' check for such unions
>  =C2=A0 - do not abort() when visiting the union and discriminator poin=
ting
>  =C2=A0=C2=A0=C2=A0 to no data type
>=20
> I can try and implement this if there's no other suggestion?

Or I could fold that into my patch from months ago.  Let's see what I=20
can come up with this week.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
