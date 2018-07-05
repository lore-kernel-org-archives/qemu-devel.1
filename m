Received: from eggs.gnu.org ([2001:4830:134:3::10]:50871)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1fbAee-0007CC-Mk
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 16:15:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1fbAea-0007Nr-MH
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 16:15:04 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:34876 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1fbAea-0007MG-Cu
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 16:15:00 -0400
Received: from submission.kamp.de ([195.62.97.28]) by kerio.kamp.de with ESMTPS
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	for qemu-devel@nongnu.org; Thu, 5 Jul 2018 22:14:53 +0200
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Peter Lieven <pl@kamp.de>
In-Reply-To: <20180705151531.GM3309@localhost.localdomain>
Date: Thu, 5 Jul 2018 22:14:54 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <C85D9257-D4E7-48A2-9DF4-A696E2E08015@kamp.de>
References: <1530787950-25306-1-git-send-email-pl@kamp.de>
	<20180705151531.GM3309@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH V3] qemu-img: align result of
 is_allocated_sectors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com


> Am 05.07.2018 um 17:15 schrieb Kevin Wolf <kwolf@redhat.com>:
>=20
> Am 05.07.2018 um 12:52 hat Peter Lieven geschrieben:
>> We currently don't enforce that the sparse segments we detect during =
convert are
>> aligned. This leads to unnecessary and costly read-modify-write =
cycles either
>> internally in Qemu or in the background on the storage device as =
nearly all
>> modern filesystems or hardware have a 4k alignment internally.
>>=20
>> The number of RMW cycles when converting an example image [1] to a =
raw device that
>> has 4k sector size is about 4600 4k read requests to perform a total =
of about 15000
>> write requests. With this path the additional 4600 read requests are =
eliminated.
>>=20
>> [1] =
https://cloud-images.ubuntu.com/releases/16.04/release/ubuntu-16.04-server=
-cloudimg-amd64-disk1.vmdk
>>=20
>> Signed-off-by: Peter Lieven <pl@kamp.de>
>> ---
>> V2->V3: - ensure that s.alignment is a power of 2
>>        - correctly handle n < alignment in is_allocated_sectors if
>>          sector_num % alignment > 0.
>> V1->V2: - take the current sector offset into account [Max]
>>        - try to figure out the target alignment [Max]
>>=20
>> qemu-img.c | 46 ++++++++++++++++++++++++++++++++++++----------
>> 1 file changed, 36 insertions(+), 10 deletions(-)
>>=20
>> diff --git a/qemu-img.c b/qemu-img.c
>> index e1a506f..db91b9e 100644
>> --- a/qemu-img.c
>> +++ b/qemu-img.c
>> @@ -1105,8 +1105,11 @@ static int64_t find_nonzero(const uint8_t =
*buf, int64_t n)
>>  *
>>  * 'pnum' is set to the number of sectors (including and immediately =
following
>>  * the first one) that are known to be in the same =
allocated/unallocated state.
>> + * The function will try to align 'pnum' to the number of sectors =
specified
>> + * in 'alignment' to avoid unnecassary RMW cycles on modern =
hardware.
>>  */
>> -static int is_allocated_sectors(const uint8_t *buf, int n, int =
*pnum)
>> +static int is_allocated_sectors(const uint8_t *buf, int n, int =
*pnum,
>> +                                int64_t sector_num, int alignment)
>> {
>>     bool is_zero;
>>     int i;
>> @@ -1115,14 +1118,26 @@ static int is_allocated_sectors(const uint8_t =
*buf, int n, int *pnum)
>>         *pnum =3D 0;
>>         return 0;
>>     }
>> -    is_zero =3D buffer_is_zero(buf, 512);
>> -    for(i =3D 1; i < n; i++) {
>> -        buf +=3D 512;
>> -        if (is_zero !=3D buffer_is_zero(buf, 512)) {
>> +
>> +    if (n % alignment) {
>> +        alignment =3D 1;
>> +    }
>=20
> So if n is unaligned, we keep the result unaligned, too. Makes sense,
> because otherwise we'd just split the request in two, but still get =
the
> same result.
>=20
> Worth mentioning in the function comment, though?
>=20
>> +
>> +    if (sector_num % alignment) {
>> +        n =3D ROUND_UP(sector_num, alignment) - sector_num;
>> +        alignment =3D 1;
>> +    }
>=20
> So if the start is unaligned, only check until the next alignment
> boundary.
>=20
> This one isn't obvious to me. Doesn't it result in the same scenario
> where a request is needlessly split in two? Wouldn't it be better to
> first check the unaligned head and then continue with the rest of n if
> that results in an aligned end offset?
>=20
> Actually, should the order of both checks be reversed, because an
> unaligned n with an unaligned sector_num could actually result in an
> aligned end offset?


I think the key is that the function should just try to end with an =
aligned
offset.

It seems not trivial to decide how to round up or down to the next =
boundary tough...

I think for the allocated case its just rounding up to the next boundary =
(if its not
beyond the end of the buffer). If the status is unallocated it is =
rounding down, if *pnum will still be > 0?

Please keep in mind that is_allocated_sectors is only invoked from =
is_allocated_sectors_min, so a small *pnum for unallocated sectors will =
have no effect of a split request as everything below min (which is =
min_sparse) will be count as allocated.

Best,
Peter
