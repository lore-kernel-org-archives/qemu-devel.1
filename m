Received: from eggs.gnu.org ([2001:4830:134:3::10]:60837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1exm1Q-0004sH-D2
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 00:03:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1exm1M-0001z9-Do
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 00:03:44 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:35075)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1exm1M-0001yN-7G
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 00:03:40 -0400
Received: by mail-pf0-x243.google.com with SMTP id y186so6557791pfb.2
	for <qemu-devel@nongnu.org>; Sun, 18 Mar 2018 21:03:39 -0700 (PDT)
References: <201803190949243031468@zte.com.cn>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <4c7e78e1-da12-5346-e7e7-13b52882e31c@gmail.com>
Date: Mon, 19 Mar 2018 12:03:29 +0800
MIME-Version: 1.0
In-Reply-To: <201803190949243031468@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/8] migration: stop allocating and
 freeingmemory frequently
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jiang.biao2@zte.com.cn
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, xiaoguangrong@tencent.com, qemu-devel@nongnu.org, kvm@vger.kernel.org



On 03/19/2018 09:49 AM, jiang.biao2@zte.com.cn wrote:
> Hi, guangrong
>>
>> +/* return the size after compression, or negative value on error */
>> +static int qemu_compress_data(z_stream *stream, uint8_t *dest, size_t dest_len,
>> +                              const uint8_t *source, size_t source_len)
>> +{
>> +    int err;
>> +
>> +    err = deflateReset(stream);
>> +    if (err != Z_OK) {
>> +        return -1;
>> +    }
>> +
>> +    stream->avail_in = source_len;
>> +    stream->next_in = (uint8_t *)source;
>> +    stream->avail_out = dest_len;
>> +    stream->next_out = dest;
>> +
> duplicated code with qemu_uncompress(), would initializing stream outside
> of qemu_compress_data() be better? In that case, we could pass much less
> parameters down, and avoid the duplicated code. Or could we encapsulate
> some struct to ease the case?

There are multiple places to do compression/uncompression in QEMU,
i am going to introduce common functions to cleanup these places,
that can be another patchset later...

>> +    err = deflate(stream, Z_FINISH);
>> +    if (err != Z_STREAM_END) {
>> +        return -1;
>> +    }
>> +
>> +    return stream->next_out - dest;
>> +}
>> +
>>
>> @@ -683,8 +707,10 @@ ssize_t qemu_put_compression_data(QEMUFile *f, const uint8_t *p, size_t size,
>> return -1;
>> }
>> }
>> -    if (compress2(f->buf + f->buf_index + sizeof(int32_t), (uLongf *)&blen,
>> -                  (Bytef *)p, size, level) != Z_OK) {
>> +
>> +    blen = qemu_compress_data(stream, f->buf + f->buf_index + sizeof(int32_t),
>> +                              blen, p, size);
> The "level" parameter is never used after the patch, could we just removed it?
> On the other hand, deflate() of zlib supports compression level too(by
> deflateInit(stream, level)), should we just reuse the level properly?  If not, the
> *migrate parameter compress_level* will be useless.

The 'level' has been pushed to @stream:
+        if (deflateInit(&comp_param[i].stream,
+                           migrate_compress_level()) != Z_OK) {
+            goto exit;
+        }

>> +    if (blen < 0) {
>> error_report("Compress Failed!");
>> return 0;
>> }
>>
>> +/* return the size after decompression, or negative value on error */
>> +static int qemu_uncompress(z_stream *stream, uint8_t *dest, size_t dest_len,
>> +                           uint8_t *source, size_t source_len)
> The name of *qemu_uncompress* does not quite match *qemu_compress_data*,
> would *qemu_uncompress_data* be better?

It's good to me. will rename it.

> Besides, the prototype is not consistent with  *qemu_compress_data* either,
> should the -*source- be -const- also here?

Okay.

Thanks!
