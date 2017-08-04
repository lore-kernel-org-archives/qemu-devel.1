Received: from eggs.gnu.org ([2001:4830:134:3::10]:33220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1ddiXV-0002Bq-3v
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 15:45:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1ddiXR-0000ts-UY
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 15:45:41 -0400
References: <20170804151013.13057-1-den@openvz.org>
	<20170804151013.13057-4-den@openvz.org>
	<d3c51c4e-ba65-1d1e-dbce-dbc15fff3522@redhat.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <b5c693e1-4ad0-a8d1-6e27-c0d20865a5ff@openvz.org>
Date: Fri, 4 Aug 2017 22:45:26 +0300
MIME-Version: 1.0
In-Reply-To: <d3c51c4e-ba65-1d1e-dbce-dbc15fff3522@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 3/3] parallels: drop check that
 bdrv_truncate() is working
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

On 08/04/2017 10:32 PM, Eric Blake wrote:
> On 08/04/2017 10:10 AM, Denis V. Lunev wrote:
>> This would be actually strange and error prone. If truncate() nowadays=

>> will fail, there is something fatally wrong. Let's check for that duri=
ng
>> the actual work.
>>
>> The only fallback case is when the file is not zero initialized. In th=
is
>> case we should switch to preallocation via fallocate().
> I got confused by the commit message.  Here's my attempt an an
> alternative, to see if I'm understanding the point of this patch:
>
> The code was trying to truncate a file to its current length, as an
> optimization to help decide whether an alternative prealloc mode was
> useful.  But it forgot to check whether bdrv_getlength() succeeded, and=

> dealing with that failure just complicates what was supposed to be a
> no-op probe for optimizing later operation.  We will still properly fai=
l
> later when an actual truncation attempt is made and the device can't
> support it.  So when deciding how to set prealloc_mode while opening th=
e
> device, all we really need is to check just the one condition that
> matters - knowing whether the device is zero initialized.
>

This is not an optimization. This is check that truncate is working for
underlying BDS. 2 years ago I though that I have seen some BDSes
without truncate support.

So, with this patch I have dropped this check. If the user has specified
to change preallocation mode, he is responsible to be correct. If truncat=
e
is broken, this will be revealed at the first attempt to expand the file.=


>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> CC: Markus Armbruster <armbru@redhat.com>
>> CC: Kevin Wolf <kwolf@redhat.com>
>> CC: Max Reitz <mreitz@redhat.com>
>> CC: Stefan Hajnoczi <stefanha@redhat.com>
>> ---
>>  block/parallels.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
> The code change makes sense at first glance, but I'm a bit reluctant to=

> give R-b, since the commit message threw me off and I'm not familiar
> with the parallels code in the first place.
>
>> diff --git a/block/parallels.c b/block/parallels.c
>> index 6794e53c0b..e1e06d23cc 100644
>> --- a/block/parallels.c
>> +++ b/block/parallels.c
>> @@ -703,9 +703,7 @@ static int parallels_open(BlockDriverState *bs, QD=
ict *options, int flags,
>>          goto fail_options;
>>      }
>> =20
>> -    if (!(flags & BDRV_O_RESIZE) || !bdrv_has_zero_init(bs->file->bs)=
 ||
>> -            bdrv_truncate(bs->file, bdrv_getlength(bs->file->bs),
>> -                          PREALLOC_MODE_OFF, NULL) !=3D 0) {
>> +    if (!bdrv_has_zero_init(bs->file->bs)) {
>>          s->prealloc_mode =3D PRL_PREALLOC_MODE_FALLOCATE;
>>      }
>> =20
>>
