Received: from eggs.gnu.org ([2001:4830:134:3::10]:33718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fY3Vr-0003s1-Js
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 02:01:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fY3Vq-0004QT-Pi
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 02:01:07 -0400
References: <20180626222226.27620-1-jsnow@redhat.com>
	<20180626222226.27620-2-jsnow@redhat.com>
	<67381f57-d8a6-b8e2-ac70-9e0fa10cbd94@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <12876318-b3e4-d498-ed99-d75326efd4f3@redhat.com>
Date: Wed, 27 Jun 2018 02:00:57 -0400
MIME-Version: 1.0
In-Reply-To: <67381f57-d8a6-b8e2-ac70-9e0fa10cbd94@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 1/2] block: allow blockdev-backup from
 any source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>



On 06/26/2018 09:38 PM, Eric Blake wrote:
> On 06/26/2018 05:22 PM, John Snow wrote:
>> In the case of image fleecing, the node we choose as the source
>> for a blockdev-backup is going to be both a root node AND the
>> backing node for the exported image. It does not qualify as a root
>> image in this case.
>>
>> Loosen the restriction.
>=20
> Did we regress (and if so, when), or has this never worked?=C2=A0 But y=
ou are
> right: visually, we are starting with:

It's actually a regression, because I had a variant of this test in my
local files that used to work. We never really advertised or tested this
feature, though, so ...

>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Device
> Base (backing) <- Top (active)
>=20
> then want to add nodes for an NBD export:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Device=C2=A0=C2=A0=C2=A0 NBD
> Base (backing) <- Top=C2=A0=C2=A0=C2=A0 <- Tmp

          [device] --> [active]
                          ^
[nbd] --> [fleecing]------'


So active here has two parents: the device root, and the temporary
fleecing node. This disqualifies it from being the source in
blockdev_backup, but there's no real reason to.

If the caller of blockdev_backup chooses a dumb source node they'll get
dumb data. GIGO.

>=20
> with a blockdev-backup "sync":"none" from Top to Tmp (any writes from
> the Device first copy the old data to Tmp; the NBD export sees a
> read-only view of Tmp that is unchanging from the time the backup job
> started, regardless of what the Device does in the meantime).
>=20
> Then when the fleece job ends, the NBD export is stopped, the
> blockdev-backup job is canceled, and Tmp is thrown away as unneeded.
>=20

Yup, highlighted a little better in the next patch.

>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>> =C2=A0 blockdev.c | 2 +-
>> =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/blockdev.c b/blockdev.c
>> index 58d7570932..526f8b60be 100644
>> --- a/blockdev.c
>> +++ b/blockdev.c
>> @@ -3517,7 +3517,7 @@ BlockJob *do_blockdev_backup(BlockdevBackup
>> *backup, JobTxn *txn,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 backup->compres=
s =3D false;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 bs =3D qmp_get_root_bs(backup->device, errp=
);
>> +=C2=A0=C2=A0=C2=A0 bs =3D bdrv_lookup_bs(backup->device, backup->devi=
ce, errp);
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!bs) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>=20
