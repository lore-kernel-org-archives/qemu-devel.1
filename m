Received: from eggs.gnu.org ([2001:4830:134:3::10]:49979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1fvnw5-00078F-8i
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 14:14:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1fvnw2-0005re-Ke
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 14:14:21 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50312)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1fvnw2-0005rT-Ab
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 14:14:18 -0400
References: <1535733414-6812-1-git-send-email-Liam.Merwick@oracle.com>
	<1535733414-6812-9-git-send-email-Liam.Merwick@oracle.com>
	<8d2e5805-2d53-3c20-c34a-514614750dec@redhat.com>
From: Liam Merwick <liam.merwick@oracle.com>
Message-ID: <189770df-99cb-162d-007b-bdb48dd29a7c@oracle.com>
Date: Fri, 31 Aug 2018 19:16:01 +0100
MIME-Version: 1.0
In-Reply-To: <8d2e5805-2d53-3c20-c34a-514614750dec@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 8/8] qcow2: Read outside array bounds in
 qcow2_pre_write_overlap_check()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org



On 31/08/18 17:53, Eric Blake wrote:
> On 08/31/2018 11:36 AM, Liam Merwick wrote:
>> The commit for 0e4e4318eaa5 increments QCOW2_OL_MAX_BITNR but does not
>> add an array entry for QCOW2_OL_BITMAP_DIRECTORY_BITNR to=20
>> metadata_ol_names[].
>> As a result, an array dereference of metadata_ol_names[8] in
>> qcow2_pre_write_overlap_check() could result in a read outside of the=20
>> array bounds.
>>
>> Fixes: 0e4e4318eaa5 ('qcow2: add overlap check for bitmap directory')
>>
>> Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
>> ---
>> =C2=A0 block/qcow2-refcount.c | 26 ++++++++++++++++++--------
>> =C2=A0 1 file changed, 18 insertions(+), 8 deletions(-)
>>
>=20
>> +
>> +/*
>> + * Catch at compile time the case where an overlap detection bit
>> + * was added to QCow2MetadataOverlap in block/qcow2.h but a
>> + * corresponding entry to metadata_ol_names[] wasn't added.
>> + */
>=20
> I'm not sure the comment adds much value.=C2=A0 I'd be fine with droppi=
ng it.
>=20
>> +QEMU_BUILD_BUG_ON(QCOW2_OL_MAX_BITNR !=3D
>> +=C2=A0=C2=A0=C2=A0 (sizeof(metadata_ol_names) / sizeof(metadata_ol_na=
mes[0])));
>=20
> We have a macro for that.=C2=A0 Spell this:
>=20
> QEMU_BUILD_BUG_ON(QCOW2_OL_MAX_BITNR !=3D ARRAY_SIZE(metadata_ol_names)=
);
>=20
> and then you can have
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20

Thanks, I've updated those and removed the double space in patch6. Will=20
be in upcoming v3

Regards,
Liam
