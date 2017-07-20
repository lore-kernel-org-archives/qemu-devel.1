Received: from eggs.gnu.org ([2001:4830:134:3::10]:49069)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1dYELH-0007T1-FY
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 12:30:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1dYELC-0006fV-9K
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 12:30:23 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:60285 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1dYELB-0006es-Vh
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 12:30:18 -0400
References: <1500560441-5670-1-git-send-email-pl@kamp.de>
	<1500560441-5670-9-git-send-email-pl@kamp.de>
	<6c67ca5d-56be-548b-8854-5891818c4217@redhat.com>
From: Peter Lieven <pl@kamp.de>
Message-ID: <8b0c6cba-3a8e-62dd-35af-46dc05420ec7@kamp.de>
Date: Thu, 20 Jul 2017 18:30:13 +0200
MIME-Version: 1.0
In-Reply-To: <6c67ca5d-56be-548b-8854-5891818c4217@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V4 08/10] block/qcow2: start using the
 compress format extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, lersek@redhat.com, den@openvz.org, mreitz@redhat.com, berrange@redhat.com

Am 20.07.2017 um 18:00 schrieb Eric Blake:
> On 07/20/2017 09:20 AM, Peter Lieven wrote:
>> we now pass the parameters to the zlib compressor if the
>> extension is present and use the old default values if
>> the extension is absent.
>>
>> Signed-off-by: Peter Lieven <pl@kamp.de>
>> ---
>>  block/qcow2-cluster.c | 58 ++++++++++++++++++++++++++++++---------------------
>>  block/qcow2.c         | 57 +++++++++++++++++++++++++++-----------------------
>>  2 files changed, 65 insertions(+), 50 deletions(-)
>>  static int decompress_buffer(uint8_t *out_buf, int out_buf_size,
>> -                             const uint8_t *buf, int buf_size)
>> +                             const uint8_t *buf, int buf_size,
>> +                             int compress_format)
>>  {
>> -
>> -    ret = inflateInit2(strm, -12);
> The old code initializes with 12,
>
>
>> +    switch (compress_format) {
>> +    case QCOW2_COMPRESS_FORMAT_ZLIB:
>> +    case -1: {
> What is case -1 supposed to be? When the compression format was not
> specified?  Again, I'd really like there a way to encode the default
> (when no format is encoded in the qcow2 file) to be representable
> alongside the new code, and then we just special-case writing the
> compression format to the file to omit the extension header if the user
> requested parameters that match the old default.
>
>> +        z_stream z_strm = {};
>> +
>> +        z_strm.next_in = (uint8_t *)buf;
>> +        z_strm.avail_in = buf_size;
>> +        z_strm.next_out = out_buf;
>> +        z_strm.avail_out = out_buf_size;
>> +
>> +        ret = inflateInit2(&z_strm, -15);
> The new code is now unconditionally initializing with -15 instead of
> -12.  Does that matter, or does decompression work regardless of window
> size used at creation, as long as the initialized size at decompression
> is at least as large?  On the other hand, I guess that means if someone
> compresses with a large window, and then I initialize the decompressor
> with a small window, my decompression will fail?  That's why knowing the
> minimum window size should be part of the spec, whether or not we make
> it a tunable.

The decompression is supposed to fail if you compress with 15 and
decompress with 12. In fact it doesn't.

>
>> +++ b/block/qcow2.c
>> @@ -3391,9 +3391,10 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
>>      BDRVQcow2State *s = bs->opaque;
>>      QEMUIOVector hd_qiov;
>>      struct iovec iov;
>> -    z_stream strm;
>> -    int ret, out_len;
>> -    uint8_t *buf, *out_buf, *local_buf = NULL;
>> +    z_stream z_strm = {};
>> +    int z_windowBits = -15, z_level = Z_DEFAULT_COMPRESSION;
>> +    int ret, out_len = 0;
>> +    uint8_t *buf, *out_buf = NULL, *local_buf = NULL;
>>      uint64_t cluster_offset;
>>  
>>      if (bytes == 0) {
>> @@ -3418,34 +3419,38 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
>>          buf = qiov->iov[0].iov_base;
>>      }
>>  
>> -    out_buf = g_malloc(s->cluster_size);
>> +    switch (s->compress_format) {
>> +    case -1:
>> +        z_windowBits = -12;
>> +    case QCOW2_COMPRESS_FORMAT_ZLIB:
>> +        out_buf = g_malloc(s->cluster_size);
>> +        if (s->compress_level > 0) {
>> +            z_level = s->compress_level;
>> +        }
> And this is where I wonder if z_windowBits should be explicitly encoded
> in the qcow2 format, rather than just magic numbers we use under the
> hood, so that someone else trying to reimplement things will create
> compatible files.
>
I would like to avoid the windowBits in the qcow2 header as it makes

the code to read and write it more complicated. If you don't like the change

of the windowBits we can even stick with 12. If someone wants fast compression

he will likely not use zlib at all and use lzo.

I just changed the windowBits to 15 as it increases speed and improves compression.

(likely at the cost of memory during compression/decompression)


Peter
