Received: from eggs.gnu.org ([2001:4830:134:3::10]:57144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1fvjae-0005lR-Mx
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 09:35:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1fvjVE-0005nO-SH
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 09:30:25 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40814)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1fvjVB-0005lP-5t
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 09:30:18 -0400
References: <1535644031-848-1-git-send-email-Liam.Merwick@oracle.com>
	<1535644031-848-9-git-send-email-Liam.Merwick@oracle.com>
	<f8b68066-8427-ba2f-9205-a9b316a926b5@redhat.com>
From: Liam Merwick <liam.merwick@oracle.com>
Message-ID: <ac300921-251a-7b9b-c097-150196fce7fe@oracle.com>
Date: Fri, 31 Aug 2018 14:32:05 +0100
MIME-Version: 1.0
In-Reply-To: <f8b68066-8427-ba2f-9205-a9b316a926b5@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 8/8] qcow2: Read outside array bounds in
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



On 30/08/18 19:43, Eric Blake wrote:
> On 08/30/2018 10:47 AM, Liam Merwick wrote:
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
>> Reviewed-by: Darren Kenny <Darren.Kenny@oracle.com>
>> Reviewed-by: Mark Kanda <Mark.Kanda@oracle.com>
>> ---
>> =C2=A0 block/qcow2-refcount.c | 17 +++++++++--------
>> =C2=A0 1 file changed, 9 insertions(+), 8 deletions(-)
>=20
> The fix looks correct, but to prevent the problem from happening again,=
=20
> I'd suggest you also add a compile-time BUG_ON that fails if the array=20
> size gets out of sync again due to another addition of another overlap=20
> detection bit.
>=20

Good idea. There is no generic BUG_ON in QEMU (just a few private=20
copies) or BUILD_BUG_ON. I can add a commit that introduces a copy of=20
include/linux/build_bug.h from the Linux kernel and use BUILD_BUG_ON in=20
this commit.  Is there any reason not to do that?

Regards,
Liam
