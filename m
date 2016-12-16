Received: from eggs.gnu.org ([2001:4830:134:3::10]:40013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cHtSY-00010s-Ir
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 09:26:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cHtSX-00014r-JI
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 09:26:06 -0500
References: <1479835586-74394-1-git-send-email-vsementsov@virtuozzo.com>
	<1479835586-74394-8-git-send-email-vsementsov@virtuozzo.com>
	<b80f7704-75c4-6390-aacf-d3af1e7853c7@redhat.com>
	<eb802f93-aeb6-9ec2-651a-f41a4d4902ff@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <0de07570-68fd-432c-fdb6-5c065ac7cc43@redhat.com>
Date: Fri, 16 Dec 2016 15:25:53 +0100
MIME-Version: 1.0
In-Reply-To: <eb802f93-aeb6-9ec2-651a-f41a4d4902ff@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XrbXvSgN5sR3WoKTEA6wVNnoHm2QgwRIC"
Subject: Re: [Qemu-devel] [PATCH 07/21] qcow2: add bitmaps extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XrbXvSgN5sR3WoKTEA6wVNnoHm2QgwRIC
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <0de07570-68fd-432c-fdb6-5c065ac7cc43@redhat.com>
Subject: Re: [PATCH 07/21] qcow2: add bitmaps extension
References: <1479835586-74394-1-git-send-email-vsementsov@virtuozzo.com>
 <1479835586-74394-8-git-send-email-vsementsov@virtuozzo.com>
 <b80f7704-75c4-6390-aacf-d3af1e7853c7@redhat.com>
 <eb802f93-aeb6-9ec2-651a-f41a4d4902ff@virtuozzo.com>
In-Reply-To: <eb802f93-aeb6-9ec2-651a-f41a4d4902ff@virtuozzo.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 14.12.2016 13:23, Vladimir Sementsov-Ogievskiy wrote:
> 07.12.2016 21:25, Max Reitz wrote:
>> On 22.11.2016 18:26, Vladimir Sementsov-Ogievskiy wrote:
>>> Add bitmap extension as specified in docs/specs/qcow2.txt.
>>> For now, just mirror extension header into Qcow2 state and check
>>> constraints.
>>>
>>> For now, disable image resize if it has bitmaps. It will be fixed lat=
er.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>> Reviewed-by: John Snow <jsnow@redhat.com>
>>> ---
>>>   block/qcow2.c | 107
>>> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>>>   block/qcow2.h |  24 +++++++++++++
>>>   2 files changed, 129 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/block/qcow2.c b/block/qcow2.c
>>> index 6d5689a..7908657 100644
>>> --- a/block/qcow2.c
>>> +++ b/block/qcow2.c
>>> @@ -63,6 +63,7 @@ typedef struct {
>>>   #define  QCOW2_EXT_MAGIC_END 0
>>>   #define  QCOW2_EXT_MAGIC_BACKING_FORMAT 0xE2792ACA
>>>   #define  QCOW2_EXT_MAGIC_FEATURE_TABLE 0x6803f857
>>> +#define  QCOW2_EXT_MAGIC_BITMAPS 0x23852875
>>>     static int qcow2_probe(const uint8_t *buf, int buf_size, const
>>> char *filename)
>>>   {
>>> @@ -92,6 +93,7 @@ static int qcow2_read_extensions(BlockDriverState
>>> *bs, uint64_t start_offset,
>>>       QCowExtension ext;
>>>       uint64_t offset;
>>>       int ret;
>>> +    Qcow2BitmapHeaderExt bitmaps_ext;
>>>     #ifdef DEBUG_EXT
>>>       printf("qcow2_read_extensions: start=3D%ld end=3D%ld\n",
>>> start_offset, end_offset);
>>> @@ -162,6 +164,81 @@ static int
>>> qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
>>>               }
>>>               break;
>>>   +        case QCOW2_EXT_MAGIC_BITMAPS:
>>> +            if (ext.len !=3D sizeof(bitmaps_ext)) {
>>> +                error_setg_errno(errp, -ret, "bitmaps_ext: "
>>> +                                 "Invalid extension length");
>>> +                return -EINVAL;
>>> +            }
>>> +
>>> +            if (!(s->autoclear_features & QCOW2_AUTOCLEAR_BITMAPS)) =
{
>>> +                fprintf(stderr,
>>> +                        "WARNING: a program lacking bitmap support
>>> modified "
>>> +                        "this file, so all bitmaps are now considere=
d "
>>> +                        "inconsistent");
>>> +                break;
>>> +            }
>> I think It would be nice if qemu-img check could remove all bitmaps an=
d
>> related data if this bit is not set. Otherwise, we're practically
>> leaking data.
>=20
> Is it safe? Can old version somehow reuse these clusters?

You're right, it can. It's not so easy then.

>                                                           Actually, all=

> data will be removed on check, as there will be no refcounts if this bi=
t
> is not set.

The refcounts will be there, but no references, right. So an old
qemu-img check -r leaks will free the clusters.

We could still remove this extension field, right? Then the clusters are
at least really leaked so that even a new qemu-img check -r leaks will
free them.

> So, IMHO, only extension header should be deleted additionally in
> qemu-img check.

I think we could remove it here instead of only in qemu-img check, but
either way should be fine. Doing it in qemu-img check is probably
cleaner, actually.

If you do it there, however, the warning should probably include a hint
like "(Use 'qemu-img check -r leaks' to reclaim the space used for the
bitmaps)".

Max


--XrbXvSgN5sR3WoKTEA6wVNnoHm2QgwRIC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlhT+XESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AsMEH+QFkIedcH7L9t7fDhsLnqeVeapwDzxD3
4EhSDi9jfiTfaqYtOoyyFYW5eJppNFwgLJaqzgEvnNRk84nxxgcaOPoCKl6tGTuZ
6AwjetTczlOFotkS7AZNyrK36y+gClsrOE6EbnhC1X8parUmObvOL414TNhYkl9z
AzNMXkQEdT+X6t5fFsV/4JtrJgLTzLrDlLVwFryqFIFkr/XIiODeWB/5A7G/+VOv
WJgxHMVvGPB6L19z0gHmCLFreQp0F9Z4k+v4GbBvHaiDURB9cB7ueQTzwqgX2hsG
yJnx1Jf5LbVkODmBCWMTfGhB96Yr/RmFiB0YPuU3oKD8lVGhVLGvyxM=
=4VZ8
-----END PGP SIGNATURE-----

--XrbXvSgN5sR3WoKTEA6wVNnoHm2QgwRIC--
