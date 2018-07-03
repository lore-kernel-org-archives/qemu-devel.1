Received: from eggs.gnu.org ([2001:4830:134:3::10]:43761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faNvx-0008Hp-BU
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:13:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1faNvw-0008BV-8L
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 12:13:41 -0400
References: <20180702191458.28741-1-eblake@redhat.com>
	<20180702191458.28741-2-eblake@redhat.com>
	<79924948-36a8-e604-22c3-d7e407c84e30@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e2d6605a-bc73-941c-67d7-b28da34ca48d@redhat.com>
Date: Tue, 3 Jul 2018 11:13:32 -0500
MIME-Version: 1.0
In-Reply-To: <79924948-36a8-e604-22c3-d7e407c84e30@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/2] nbd/client: Add x-dirty-bitmap to
 query bitmap from server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 07/03/2018 04:46 AM, Vladimir Sementsov-Ogievskiy wrote:

>> =C2=A0 #
>> +# @x-dirty-bitmap: A "qemu:dirty-bitmap:NAME" string to query in=20
>> place of
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 traditional "base:allocation" block sta=
tus (see
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NBD_OPT_LIST_META_CONTEXT in the NBD pr=
otocol)=20
>> (since 3.0)
>> +#
>=20
> "x-dirty-bitmap=3Dqemu:dirty-bitmap:NAME", is a bit strange, looks like=
 it=20
> should be "x-dirty-bitmap=3DNAME", and "qemu:dirty-bitmap" added=20
> automatically. (and you don't check it, so actually this parameter is=20
> x-meta-context, and user can select any context, for example,=20
> "base:allocation", so "x-meta-context=3Dqemu:dirty-bitmap:NAME" sounds=20
> better too). But I'm ok to leave it as is for now, with x- prefix.

Good point on 'x-meta-context' being slightly nicer; but bikeshedding an=20
experimental name doesn't really impact the release.

For 3.1, I'd love to have:

qemu-img map --output=3Djson --image-opts driver=3Dnbd,...,bitmap=3DFOO

automatically connect to qemu:dirty-bitmap:FOO in addition to block=20
status, resulting in output for iotest 223 that resembles:

[{ "start": 0, "length": 1048576, "depth": 0, "zero": true, "data": false=
},
{ "start": 1048576, "length": 1048576, "depth": 0, "zero": false,=20
"data": true},
{ "start": 2097152, "length": 2097152, "depth": 0, "zero": false,=20
"data": true, "dirty": true}]

(that is, an optional 'dirty' member added to the JSON to identify the=20
dirty portions, in addition to everything else already identified).  I=20
also want to enhance that test to show that discarding clusters works=20
during dirty tracking (that is, a "data":false, "dirty":true entry=20
should be demonstrated).

Getting to that point will mean adding a new BDRV_BLOCK_DIRTY bit to the=20
output of bdrv_block_status() (even if only the NBD and passthrough=20
drivers set it), as well as teaching qemu-img map to optionally honor=20
that bit when present.  It also means the NBD client code will be=20
subscribing to status from two meta contexts at once, with the second=20
being exactly a qemu:dirty-bitmap (rather than a free-for-all string=20
that x-dirty-bitmap currently gives us).

It's too late to get these improvements into 3.0, but should be a good=20
path forward in the next few months.


>> @@ -982,9 +983,11 @@ int nbd_client_init(BlockDriverState *bs,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 client->info.request_sizes =3D true;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 client->info.structured_reply =3D true;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 client->info.base_allocation =3D true;
>> +=C2=A0=C2=A0=C2=A0 client->info.x_dirty_bitmap =3D g_strdup(x_dirty_b=
itmap);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D nbd_receive_negotiate(QIO_CHANN=
EL(sioc), export,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tlscreds, hostname,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &client->ioc, &client=
->info, errp);
>> +=C2=A0=C2=A0=C2=A0 g_free(client->info.x_dirty_bitmap);
>=20
> hm, pointer remains invalid. If you want free it here, what is the=20
> reason to strdup it? At least, it worth to zero out the pointer after=20
> g_free.. Or, free it not here but in client close.

The g_strdup() is necessary since client.x_dirty_bitmap is 'const char=20
*'.  Nothing used the pointer after it is freed, although I could agree=20
that assigning it to NULL to make that point obvious wouldn't hurt;=20
however, the pull request was already taken as-is, so we can just live=20
with it until the 3.1 improvements.

>=20
> with pointer zeroed or g_free to client destroy procedure,
>=20
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20
>=20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
