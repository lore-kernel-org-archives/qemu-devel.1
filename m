Received: from eggs.gnu.org ([2001:4830:134:3::10]:53954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1eAZpr-0001qp-Np
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 07:08:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1eAZpm-0002WI-Nn
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 07:08:27 -0400
References: <cover.1509368614.git.jcody@redhat.com>
	<e3abcb61ba8cdc2bb236368ab14a9037cbe7729b.1509368614.git.jcody@redhat.com>
	<20171103110500.GM5078@stefanha-x1.localdomain>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <5d2d57d5-6bac-72df-362c-996a6873ec9b@openvz.org>
Date: Fri, 3 Nov 2017 14:08:13 +0300
MIME-Version: 1.0
In-Reply-To: <20171103110500.GM5078@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 2/3] block/parallals: Do
 not update header or truncate image when INMIGRATE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Jeff Cody <jcody@redhat.com>
Cc: qemu-block@nongnu.org, kwolf@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com

On 11/03/2017 02:05 PM, Stefan Hajnoczi wrote:
> On Mon, Oct 30, 2017 at 02:10:27PM +0100, Jeff Cody wrote:
>> If we write or modify the image file while the QEMU run state is
>> INMIGRATE, then the BDRV_O_INACTIVE BDS flag is set.  This will cause
>> an assert, since the image is marked inactive.  Make sure we obey this=

>> flag.
>>
>> Signed-off-by: Jeff Cody <jcody@redhat.com>
>> ---
>>  block/parallels.c | 7 ++-----
>>  1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/block/parallels.c b/block/parallels.c
>> index 2b6c6e5709..7b7a3efa1d 100644
>> --- a/block/parallels.c
>> +++ b/block/parallels.c
>> @@ -708,7 +708,7 @@ static int parallels_open(BlockDriverState *bs, QD=
ict *options, int flags,
>>          s->prealloc_mode =3D PRL_PREALLOC_MODE_FALLOCATE;
>>      }
>> =20
>> -    if (flags & BDRV_O_RDWR) {
>> +    if ((flags & BDRV_O_RDWR) && !(flags & BDRV_O_INACTIVE)) {
>>          s->header->inuse =3D cpu_to_le32(HEADER_INUSE_MAGIC);
>>          ret =3D parallels_update_header(bs);
>>          if (ret < 0) {
> Where do we ensure that HEADER_INUSE_MAGIC is set on the destination?
good point. it should be set in invalidate_cache following QCOW2 scheme.
Thus we should add that callback with this patch.
