Received: from eggs.gnu.org ([2001:4830:134:3::10]:41380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1expjm-00052K-2q
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 04:01:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1expji-000262-7G
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 04:01:46 -0400
Received: from mail-it0-x22e.google.com ([2607:f8b0:4001:c0b::22e]:34098)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1expji-00025e-1w
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 04:01:42 -0400
Received: by mail-it0-x22e.google.com with SMTP id z7-v6so8416602iti.1
	for <qemu-devel@nongnu.org>; Mon, 19 Mar 2018 01:01:41 -0700 (PDT)
References: <201803191556183250813@zte.com.cn>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <1d1dea5a-2d1d-97cd-a777-a63df0417fbb@gmail.com>
Date: Mon, 19 Mar 2018 16:01:30 +0800
MIME-Version: 1.0
In-Reply-To: <201803191556183250813@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/8] migration: support to detect
 compressionand decompression errors
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



On 03/19/2018 03:56 PM, jiang.biao2@zte.com.cn wrote:
> Hi, guangrong
>> @@ -1051,11 +1052,13 @@ static int do_compress_ram_page(QEMUFile *f, z_stream *stream, RAMBlock *block,
>> {
>> RAMState *rs = ram_state;
>> int bytes_sent, blen;
>> -    uint8_t *p = block->host + (offset & TARGET_PAGE_MASK);
>> +    uint8_t buf[TARGET_PAGE_SIZE], *p;
> 
>> +    p = block->host + (offset & TARGET_PAGE_MASK);
>> bytes_sent = save_page_header(rs, f, block, offset |
>> RAM_SAVE_FLAG_COMPRESS_PAGE);
>> -    blen = qemu_put_compression_data(f, stream, p, TARGET_PAGE_SIZE);
>> +    memcpy(buf, p, TARGET_PAGE_SIZE);
>> +    blen = qemu_put_compression_data(f, stream, buf, TARGET_PAGE_SIZE);
> Memory copy operation for every page to be compressed is not cheap, especially
> when the page number is huge, and it may be not necessary for pages never
> updated during migration.

This is only for 4k page.

> Is there any possibility that we can distinguish the real compress/decompress
> errors from those being caused by source VM updating? Such as the return
> value of qemu_uncompress(distinguish Z_DATA_ERROR and other error codes
> returned by inflate())?

Unfortunately, no. :(
