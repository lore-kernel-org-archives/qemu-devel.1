Received: from eggs.gnu.org ([2001:4830:134:3::10]:44908)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1dUYlG-0004PT-Co
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 09:30:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1dUYlD-0001zQ-65
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 09:30:02 -0400
Received: from mx01.kamp.de ([82.141.2.16]:45860)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1dUYlC-0001yc-TT
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 09:29:59 -0400
References: <1498733831-15254-1-git-send-email-pl@kamp.de>
	<1498733831-15254-6-git-send-email-pl@kamp.de>
	<20170710132546.GG5772@noname.redhat.com>
From: Peter Lieven <pl@kamp.de>
Message-ID: <cbc8ec09-9de2-afe6-1cf0-e414482bc6a4@kamp.de>
Date: Mon, 10 Jul 2017 15:29:54 +0200
MIME-Version: 1.0
In-Reply-To: <20170710132546.GG5772@noname.redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V2 5/8] block/qcow2: read and write the
 compress format extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, lersek@redhat.com, den@openvz.org, mreitz@redhat.com, eblake@redhat.com, berrange@redhat.com

Am 10.07.2017 um 15:25 schrieb Kevin Wolf:
> Am 29.06.2017 um 12:57 hat Peter Lieven geschrieben:
>> we now read the extension on open and write it on update, but
>> do not yet use it.
>>
>> Signed-off-by: Peter Lieven <pl@kamp.de>
>> ---
>>   block/qcow2.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++++++--------
>>   block/qcow2.h |  23 +++++++++++---
>>   2 files changed, 104 insertions(+), 19 deletions(-)
>>
>> diff --git a/block/qcow2.c b/block/qcow2.c
>> index 308121a..39a8afc 100644
>> --- a/block/qcow2.c
>> +++ b/block/qcow2.c
>> @@ -63,6 +63,7 @@ typedef struct {
>>   #define  QCOW2_EXT_MAGIC_END 0
>>   #define  QCOW2_EXT_MAGIC_BACKING_FORMAT 0xE2792ACA
>>   #define  QCOW2_EXT_MAGIC_FEATURE_TABLE 0x6803f857
>> +#define  QCOW2_EXT_MAGIC_COMPRESS_FORMAT 0xC03183A3
>>   
>>   static int qcow2_probe(const uint8_t *buf, int buf_size, const char *filename)
>>   {
>> @@ -76,6 +77,26 @@ static int qcow2_probe(const uint8_t *buf, int buf_size, const char *filename)
>>           return 0;
>>   }
>>   
>> +static int qcow2_compress_format_from_name(char *fmt)
>> +{
>> +    if (!fmt || !fmt[0]) {
>> +        return QCOW2_COMPRESS_ZLIB_COMPAT;
>> +    } else if (g_str_equal(fmt, "zlib")) {
>> +        return QCOW2_COMPRESS_ZLIB;
>> +    } else {
>> +        return -EINVAL;
>> +    }
>> +}
> It might make sense to allow specifying the old compression format in
> the compression header. But I'm not so sure about using the empty string
> rather than a proper name for it, and even less about not documenting
> it.

The old format is used if and only if the compression header is absent.
It makes no sense to write a header and use the old format. The old
settings are suboptimal and old versions can't open a qcow2 with a
compression header anyway.

Peter
