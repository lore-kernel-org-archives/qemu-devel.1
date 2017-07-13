Received: from eggs.gnu.org ([2001:4830:134:3::10]:42098)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1dVeil-0006zp-O4
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:04:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1dVeig-0007w8-RZ
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:03:59 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:53383 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1dVeig-0007vW-IG
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:03:54 -0400
References: <1498733831-15254-6-git-send-email-pl@kamp.de>
	<20170710132546.GG5772@noname.redhat.com>
	<cbc8ec09-9de2-afe6-1cf0-e414482bc6a4@kamp.de>
	<20170710133459.GI5772@noname.redhat.com>
	<20170710134436.GB6770@redhat.com>
	<20170710135218.GK5772@noname.redhat.com>
	<20170710135539.GD6770@redhat.com>
	<e7640733-88fa-230b-2631-d43e22404b16@kamp.de>
	<20170713092100.GD4011@redhat.com>
	<e0a85555-aaa9-c2d0-efc7-8a932ca8a915@kamp.de>
	<20170713140022.GN4011@redhat.com>
From: Peter Lieven <pl@kamp.de>
Message-ID: <1f4ca3cc-b17b-b577-f5a7-5d550c387cb5@kamp.de>
Date: Thu, 13 Jul 2017 16:03:47 +0200
MIME-Version: 1.0
In-Reply-To: <20170713140022.GN4011@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, lersek@redhat.com, den@openvz.org, mreitz@redhat.com, eblake@redhat.com

Am 13.07.2017 um 16:00 schrieb Daniel P. Berrange:
> On Thu, Jul 13, 2017 at 03:49:09PM +0200, Peter Lieven wrote:
>> Am 13.07.2017 um 11:21 schrieb Daniel P. Berrange:
>>> On Thu, Jul 13, 2017 at 10:44:53AM +0200, Peter Lieven wrote:
>>>> Am 10.07.2017 um 15:55 schrieb Daniel P. Berrange:
>>>>> On Mon, Jul 10, 2017 at 03:52:18PM +0200, Kevin Wolf wrote:
>>>>>> Am 10.07.2017 um 15:44 hat Daniel P. Berrange geschrieben:
>>>>>>> On Mon, Jul 10, 2017 at 03:34:59PM +0200, Kevin Wolf wrote:
>>>>>>>> Am 10.07.2017 um 15:29 hat Peter Lieven geschrieben:
>>>>>>>>> Am 10.07.2017 um 15:25 schrieb Kevin Wolf:
>>>>>>>>>> Am 29.06.2017 um 12:57 hat Peter Lieven geschrieben:
>>>>>>>>>>> we now read the extension on open and write it on update, but
>>>>>>>>>>> do not yet use it.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Peter Lieven <pl@kamp.de>
>>>>>>>>>>> ---
>>>>>>>>>>>     block/qcow2.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++++++--------
>>>>>>>>>>>     block/qcow2.h |  23 +++++++++++---
>>>>>>>>>>>     2 files changed, 104 insertions(+), 19 deletions(-)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/block/qcow2.c b/block/qcow2.c
>>>>>>>>>>> index 308121a..39a8afc 100644
>>>>>>>>>>> --- a/block/qcow2.c
>>>>>>>>>>> +++ b/block/qcow2.c
>>>>>>>>>>> @@ -63,6 +63,7 @@ typedef struct {
>>>>>>>>>>>     #define  QCOW2_EXT_MAGIC_END 0
>>>>>>>>>>>     #define  QCOW2_EXT_MAGIC_BACKING_FORMAT 0xE2792ACA
>>>>>>>>>>>     #define  QCOW2_EXT_MAGIC_FEATURE_TABLE 0x6803f857
>>>>>>>>>>> +#define  QCOW2_EXT_MAGIC_COMPRESS_FORMAT 0xC03183A3
>>>>>>>>>>>     static int qcow2_probe(const uint8_t *buf, int buf_size, const char *filename)
>>>>>>>>>>>     {
>>>>>>>>>>> @@ -76,6 +77,26 @@ static int qcow2_probe(const uint8_t *buf, int buf_size, const char *filename)
>>>>>>>>>>>             return 0;
>>>>>>>>>>>     }
>>>>>>>>>>> +static int qcow2_compress_format_from_name(char *fmt)
>>>>>>>>>>> +{
>>>>>>>>>>> +    if (!fmt || !fmt[0]) {
>>>>>>>>>>> +        return QCOW2_COMPRESS_ZLIB_COMPAT;
>>>>>>>>>>> +    } else if (g_str_equal(fmt, "zlib")) {
>>>>>>>>>>> +        return QCOW2_COMPRESS_ZLIB;
>>>>>>>>>>> +    } else {
>>>>>>>>>>> +        return -EINVAL;
>>>>>>>>>>> +    }
>>>>>>>>>>> +}
>>>>>>>>>> It might make sense to allow specifying the old compression format in
>>>>>>>>>> the compression header. But I'm not so sure about using the empty string
>>>>>>>>>> rather than a proper name for it, and even less about not documenting
>>>>>>>>>> it.
>>>>>>>>> The old format is used if and only if the compression header is absent.
>>>>>>>>> It makes no sense to write a header and use the old format. The old
>>>>>>>>> settings are suboptimal and old versions can't open a qcow2 with a
>>>>>>>>> compression header anyway.
>>>>>>>> Your code allows an empty string in the header extension. If you don't
>>>>>>>> want it there, you need to reject it.
>>>>>>> This is a good reason to use the QAPI schema to parse the create options
>>>>>>> instead of doing it using qemu_opts - the QAPI schema will generate correct
>>>>>>> code to parse & validate enum values
>>>>>> I'd really like to see QAPI used for bdrv_create(), but here we're in
>>>>>> the bdrv_open() path and parsing qcow2 headers. So either way this one
>>>>>> specifically wouldn't be fixed.
>>>>> Sorry, yes, I was getting mixed up in the two different patches with
>>>>> similar bits of code.
>>>>>
>>>>> We could still replace the qcow2_compress_format_from_name() method
>>>>> though with a call to the qapi_enum_parse() passing in the
>>>>> 'QcowCompressFormat_lookup' table.
>>>> Can you advise how exactly I would do that? Sorry, but this is new stuff
>>>> for me.
>>> In your line of code:
>>>
>>>             s->compress_format_id =
>>>                  qcow2_compress_format_from_name(s->compress_format.name);
>>>
>>> Instead do
>>>
>>>              s->compress_format_id =
>>>                  qapi_enum_parse(QcowCompressFormat_lookup, s->compress_format.name);
>>>
>>>
>>> The 'QcowCompressFormat_lookup' symbol is a global variable that is an
>>> array of strings, automatically created from the 'enum' you define in
>>> the QAPI schema.
>> Is it possible to limit the valid integer values for an integer in the QAPI specification?
>>
>> I would like to do that for the compress.level stuff.
> Not that I know of.

If I specify an enum, what values are assigned to them? I am thinking of specifying an enum {0, 1, 2, 3, 4, 5, 6, 7, 8, 9} for the valid
compress levels of zlib.

Peter
