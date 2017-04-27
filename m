Received: from eggs.gnu.org ([2001:4830:134:3::10]:47996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1d3did-0004QX-V3
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 03:20:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1d3dic-0005lB-Na
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 03:20:03 -0400
MIME-Version: 1.0
In-Reply-To: <5e859188-5072-ab41-c10a-82c0182406cc@redhat.com>
References: <1493150351-28918-1-git-send-email-ashijeetacharya@gmail.com>
	<1493150351-28918-4-git-send-email-ashijeetacharya@gmail.com>
	<5e859188-5072-ab41-c10a-82c0182406cc@redhat.com>
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Thu, 27 Apr 2017 12:49:58 +0530
Message-ID: <CAC2QTZa9csv6J=bK=B_oJTAmd9OG68CgW_V6+i5M9ECZGCOpag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v1 3/8] dmg: Limit the output buffer size
 to a max of 2MB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Peter Wu <peter@lekensteyn.nl>

On Thu, Apr 27, 2017 at 3:00 AM, John Snow <jsnow@redhat.com> wrote:
>
>
> On 04/25/2017 03:59 PM, Ashijeet Acharya wrote:
>> The size of the output buffer is limited to a maximum of 2MB so that
>> QEMU doesn't end up allocating huge amounts of memory while
>> decompressing compressed input streams.
>>
>> 2MB is an appropriate size because "qemu-img convert" has the same I/O
>> buffer size and the most important use case for DMG files is to be
>> compatible with qemu-img convert.
>>
>> Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
>> ---
>
> Patch 1 adds a new structure and patch 2 starts using it, but in a
> store-only manner and only with placeholder variables that are difficult
> to authenticate, so there's still "insufficient data" to review either
> patch meaningfully.
>
> This patch seems unrelated to either of those, so the ordering is strange.

Actually, I have tried to keep these patches very short so that it is
easier to review them (mainly because of the time limitation I have).
But seems like I over tried. If you have any suggestions for the first
2 patches, I am happy to change them in you preferred way.

>
>>  block/dmg.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/block/dmg.c b/block/dmg.c
>> index c6fe8b0..7ae30e3 100644
>> --- a/block/dmg.c
>> +++ b/block/dmg.c
>> @@ -37,8 +37,8 @@ enum {
>>      /* Limit chunk sizes to prevent unreasonable amounts of memory being used
>>       * or truncating when converting to 32-bit types
>>       */
>> -    DMG_LENGTHS_MAX = 64 * 1024 * 1024, /* 64 MB */
>> -    DMG_SECTORCOUNTS_MAX = DMG_LENGTHS_MAX / 512,
>> +    DMG_MAX_OUTPUT = 2 * 1024 * 1024, /* 2 MB */
>
> why "MAX OUTPUT" ? Aren't we using this for buffering on reads?

I just thought that this looked better, but I will revert back to the
original one.

>
>> +    DMG_SECTOR_MAX = DMG_MAX_OUTPUT / 512,
>>  };
>>
>>  static int dmg_probe(const uint8_t *buf, int buf_size, const char *filename)
>> @@ -260,10 +260,10 @@ static int dmg_read_mish_block(BDRVDMGState *s, DmgHeaderState *ds,
>>
>>          /* all-zeroes sector (type 2) does not need to be "uncompressed" and can
>>           * therefore be unbounded. */
>> -        if (s->types[i] != 2 && s->sectorcounts[i] > DMG_SECTORCOUNTS_MAX) {
>> +        if (s->types[i] != 2 && s->sectorcounts[i] > DMG_SECTOR_MAX) {
>>              error_report("sector count %" PRIu64 " for chunk %" PRIu32
>>                           " is larger than max (%u)",
>> -                         s->sectorcounts[i], i, DMG_SECTORCOUNTS_MAX);
>> +                         s->sectorcounts[i], i, DMG_SECTOR_MAX);
>>              ret = -EINVAL;
>>              goto fail;
>>          }
>> @@ -275,10 +275,10 @@ static int dmg_read_mish_block(BDRVDMGState *s, DmgHeaderState *ds,
>>          /* length in (compressed) data fork */
>>          s->lengths[i] = buff_read_uint64(buffer, offset + 0x20);
>>
>> -        if (s->lengths[i] > DMG_LENGTHS_MAX) {
>> +        if (s->lengths[i] > DMG_MAX_OUTPUT) {
>>              error_report("length %" PRIu64 " for chunk %" PRIu32
>>                           " is larger than max (%u)",
>> -                         s->lengths[i], i, DMG_LENGTHS_MAX);
>> +                         s->lengths[i], i, DMG_MAX_OUTPUT);
>>              ret = -EINVAL;
>>              goto fail;
>>          }
>>
>
> Seems OK otherwise, but I would normally expect you to fix the buffering
> problems first, and then reduce the size of the buffer -- not the other
> way around. This version introduces new limitations that didn't exist
> previously (As of this commit, QEMU can't open DMG files with chunks
> larger than 2MB now, right?)

I think I will squash it with the last one (patch 8) which removes
this limitation completely and will also fix the problem of handling
the buffering problems first and then reducing the buffer size?

Ashijeet
