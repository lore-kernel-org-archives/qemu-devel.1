Received: from eggs.gnu.org ([2001:4830:134:3::10]:35285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fbYZ1-0004dn-2B
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 17:46:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fbYZ0-0007ao-4O
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 17:46:51 -0400
References: <20180705074638.770905-1-vsementsov@virtuozzo.com>
	<20180705074638.770905-2-vsementsov@virtuozzo.com>
	<2da7c234-6157-18d5-139b-2d4d5480c6b9@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7707136c-2b10-9882-6cf1-69aff3226bcd@redhat.com>
Date: Fri, 6 Jul 2018 16:46:38 -0500
MIME-Version: 1.0
In-Reply-To: <2da7c234-6157-18d5-139b-2d4d5480c6b9@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/4] block: disallow
 BDRV_REQ_NO_SERIALISING for write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, stefanha@redhat.com, jcody@redhat.com, pl@kamp.de, mreitz@redhat.com, ronniesahlberg@gmail.com, pbonzini@redhat.com, den@openvz.org, jsnow@redhat.com

On 07/06/2018 04:32 PM, Eric Blake wrote:
> On 07/05/2018 02:46 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Before commit 9ded4a01149 "backup: Use copy offloading",
>> BDRV_REQ_NO_SERIALISING was used for only one case: read in
>> copy-on-write operation during backup. Also, the flag was handled only
>> on read path (in bdrv_co_preadv and bdrv_aligned_preadv).
>>
>> After 9ded4a01149, flag is used for not waiting serializing operations
>> on backup target (in same case of copy-on-write operation). This
>> behavior change is unsubstantiated and potentially dangerous, let's
>> drop it.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>> =C2=A0 include/block/block.h | 13 +++++++++++++
>> =C2=A0 block/io.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 7 ++++++-
>> =C2=A0 2 files changed, 19 insertions(+), 1 deletion(-)
>>
>=20
> Commenting only on the grammar:
>=20
>> diff --git a/include/block/block.h b/include/block/block.h
>> index e5c7759a0c..a06a4d27de 100644
>> --- a/include/block/block.h
>> +++ b/include/block/block.h
>> @@ -50,6 +50,19 @@ typedef enum {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * opened with BDRV_O_UNMAP.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BDRV_REQ_MAY_UNMAP=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0x4,
>> +
>> +=C2=A0=C2=A0=C2=A0 /* The BDRV_REQ_NO_SERIALISING means that we don't=
 want to
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * wait_serialising_requests(), when reading.
>=20
> Either:
>=20
> /* BDRV_REQ_NO_SERALISING means that...
>=20
> or
>=20
> /* The BDRV_REQ_NO_SERIALISING flag means that...
>=20
> s/want to/want/

Or, after reading patch 3/4,

BDRV_REQ_NO_SERAILISING bypasses request serialisation during reads.

(where the counterpart starts:

BDRV_REQ_SERIALISING forces request serialisation during writes.
)

>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0 *
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * This flag is used for backup copy on write=
 operation, when we=20
>> need to
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * read old data before write (write notifier=
 triggered). It is=20
>> ok, due to
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * we already waited for serializing requests=
 in initiative write=20
>> (see
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * bdrv_aligned_pwritev), and it is necessary=
 for the case when=20
>> initiative
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * write is serializing itself (we'll dead lo=
ck waiting it).
>=20
> It is okay since we already waited for other serializing requests in th=
e=20
> initiating write (see bdrv_aligned_pwritev), and it is necessary since=20
> the initiating write is already serializing (without the flag, the read=
=20
> would deadlock waiting for the write to complete).
>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0 *
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * The described case is the only usage for t=
he flag for now, so,=20
>> it is
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * supported only for read operation and rest=
ricted for write.
>=20
> This last sentence is rather wordy; I'm fine with just:
>=20
> The flag is only valid during read operations.

Or even just drop this last paragraph, since the first sentence of the=20
comment already stated it was only for reads.

>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BDRV_REQ_NO_SERIALISING=C2=A0=C2=A0=C2=A0=
=C2=A0 =3D 0x8,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BDRV_REQ_FUA=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0x10,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BDRV_REQ_WRITE_COMPRESSED=C2=A0=C2=A0 =3D=
 0x20,
>=20
> We're inconsistent on which flags we document; it might be nice to have=
=20
> a comment for each of them.=C2=A0 But not necessarily this patch's prob=
lem.
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
