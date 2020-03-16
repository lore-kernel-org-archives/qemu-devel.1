Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316E9C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:43:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F05A8206C0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GFkMDpRa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F05A8206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDspq-0007HU-4g
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 12:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40739)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jDqJ8-0006Rw-8p
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:01:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jDqJ6-0004cg-9T
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:01:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22172
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jDqJ6-0004Mg-1I
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 10:01:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584367286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JtynQXw1h72AaSdoWkMQ3V0Qgfio3ZIRtIZgrvW0mao=;
 b=GFkMDpRaV9CC5cTG2xJZP4fvhJkIpHgYp9uavU9/Lv5Q/2VnfNUJqdQ0+BcH4qG5dN9uRw
 MsIuLYAqpJc57GbYJuVlel3d5XsqWJ9f1qV8UTLF3ZeTeffqZz0EPsECvX/tU0HIHI5yDL
 oKkGyfA/AoODzs0SZdU6VkkpWjsMyLA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-Ce6RG78CPwCw2_o7zgR-Vw-1; Mon, 16 Mar 2020 10:01:22 -0400
X-MC-Unique: Ce6RG78CPwCw2_o7zgR-Vw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3B6612F178;
 Mon, 16 Mar 2020 14:01:18 +0000 (UTC)
Received: from [10.3.118.63] (ovpn-118-63.phx2.redhat.com [10.3.118.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F96A5C1B5;
 Mon, 16 Mar 2020 14:01:12 +0000 (UTC)
Subject: Re: [PATCH v6 3/4] qcow2: add zstd cluster compression
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200312092242.5536-1-dplotnikov@virtuozzo.com>
 <20200312092242.5536-4-dplotnikov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <6dd9966e-e22a-b0d0-80a1-7e2c9cc9671f@redhat.com>
Date: Mon, 16 Mar 2020 09:01:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200312092242.5536-4-dplotnikov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
 qemu-block@nongnu.org, armbru@redhat.com, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/12/20 4:22 AM, Denis Plotnikov wrote:
> zstd significantly reduces cluster compression time.
> It provides better compression performance maintaining
> the same level of the compression ratio in comparison with
> zlib, which, at the moment, is the only compression
> method available.
> 

> +++ b/docs/interop/qcow2.txt
> @@ -208,6 +208,7 @@ version 2.
>   
>                       Available compression type values:
>                           0: zlib <https://www.zlib.net/>
> +                        1: zstd <http://github.com/facebook/zstd>
>   
>   
>   === Header padding ===
> @@ -575,11 +576,30 @@ Compressed Clusters Descriptor (x = 62 - (cluster_bits - 8)):
>                       Another compressed cluster may map to the tail of the final
>                       sector used by this compressed cluster.
>   
> +                    The layout of the compressed data depends on the compression
> +                    type used for the image (see compressed cluster layout).
> +
>   If a cluster is unallocated, read requests shall read the data from the backing
>   file (except if bit 0 in the Standard Cluster Descriptor is set). If there is
>   no backing file or the backing file is smaller than the image, they shall read
>   zeros for all parts that are not covered by the backing file.
>   
> +=== Compressed Cluster Layout ===
> +
> +The compressed cluster data has a layout depending on the compression
> +type used for the image, as follows:
> +
> +Compressed data layout for the available compression types:
> +data_space_lenght - data chunk length available to store a compressed cluster.

length

> +(for more details see "Compressed Clusters Descriptor")
> +x = data_space_length - 1

If I understand correctly, data_space_length is really an upper bounds 
on the length available, because it is computed by rounding UP to the 
next 512-byte boundary (that is, the L2 descriptor lists the number of 
additional sectors used in storing the compressed data).  Which really 
means that we have the following, where + is cluster boundaries, S and E 
are the start and end of the compressed data, and D is the offset 
determined by data_space_length:

+-------+-------+------+
       S============E...D

> +
> +    0:  (default)  zlib <http://zlib.net/>:
> +            Byte  0 -  x:     the compressed data content
> +                              all the space provided used for compressed data

For zlib, we have byte 0-E are compressed data, and bytes (E+1)-D (if 
any) are ignored.  There is no way to tell how many bytes between E and 
D exist, because zlib doesn't care (the compression stream itself 
ensures that decompression stops when input reaches E because the output 
reached a cluster boundary at that point).

> +    1:  zstd <http://github.com/facebook/zstd>:
> +            Byte  0 -  3:     the length of compressed data in bytes
> +                  4 -  x:     the compressed data content

Whereas for zstd, the decompression MUST know the actual location of E, 
rather than passing in the slop between E and D; bytes 0-3 give us that 
information.

But your description is not very accurate:  if 'x' is point E, then it 
is NOT data_space_length - 1, but rather data_space_length - slop, where 
slop can be up to 511 bytes (the number of bytes from (E+1) to D).  And 
if 'x' is point E, then the real layout for zlib is:

byte 0 - E: the compressed data content
byte E+1 - x: ignored slop (E is implied solely by the compressed data)

and for zstd is:

byte 0 - 3: the length of the compressed data
byte 4 - E: the compressed data (E computed from byte 0-3)
byte E+1 - x: ignored

I'm not sure what the best way is to document this.

> +++ b/block/qcow2-threads.c

> +static ssize_t qcow2_zstd_compress(void *dest, size_t dest_size,
> +                                   const void *src, size_t src_size)
> +{
> +    size_t ret;
> +
> +    /*
> +     * steal ZSTD_LEN_BUF bytes in the very beginning of the buffer
> +     * to store compressed chunk size
> +     */
> +    char *d_buf = ((char *) dest) + ZSTD_LEN_BUF;
> +
> +    /*
> +     * sanity check that we can store the compressed data length,
> +     * and there is some space left for the compressor buffer
> +     */
> +    if (dest_size <= ZSTD_LEN_BUF) {
> +        return -ENOMEM;
> +    }
> +
> +    dest_size -= ZSTD_LEN_BUF;
> +
> +    ret = ZSTD_compress(d_buf, dest_size, src, src_size, 5);

Where does the magic number 5 come from?

> +
> +    if (ZSTD_isError(ret)) {
> +        if (ZSTD_getErrorCode(ret) == ZSTD_error_dstSize_tooSmall) {
> +            return -ENOMEM;
> +        } else {
> +            return -EIO;
> +        }
> +    }
> +
> +    /*
> +     * paranoid sanity check that we can store
> +     * the compressed size in the first 4 bytes
> +     */
> +    if (ret > UINT32_MAX) {
> +        return -ENOMEM;
> +    }

The if is awkward.  I'd prefer to change this to:

     /*
      * Our largest cluster is 2M, and we insist that compression
      * actually compressed things.
      */
     assert(ret < UINT32_MAX);

or even tighten to assert(ret <= dest_size)

> +
> +    /* store the compressed chunk size in the very beginning of the buffer */
> +    stl_be_p(dest, ret);
> +
> +    return ret + ZSTD_LEN_BUF;
> +}
> +
> +/*
> + * qcow2_zstd_decompress()
> + *
> + * Decompress some data (not more than @src_size bytes) to produce exactly
> + * @dest_size bytes using zstd compression method
> + *
> + * @dest - destination buffer, @dest_size bytes
> + * @src - source buffer, @src_size bytes
> + *
> + * Returns: 0 on success
> + *          -EIO on any error
> + */
> +static ssize_t qcow2_zstd_decompress(void *dest, size_t dest_size,
> +                                     const void *src, size_t src_size)
> +{
> +    /*
> +     * zstd decompress wants to know the exact length of the data.
> +     * For that purpose, on compression, the length is stored in
> +     * the very beginning of the compressed buffer
> +     */
> +    size_t s_size;
> +    const char *s_buf = ((const char *) src) + ZSTD_LEN_BUF;
> +
> +    /*
> +     * sanity check that we can read 4 byte the content length and
> +     * and there is some content to decompress
> +     */
> +    if (src_size <= ZSTD_LEN_BUF) {
> +        return -EIO;
> +    }
> +
> +    s_size = ldl_be_p(src);
> +
> +    /* sanity check that the buffer is big enough to read the content from */
> +    if (src_size - ZSTD_LEN_BUF < s_size) {
> +        return -EIO;
> +    }
> +
> +    if (ZSTD_isError(
> +            ZSTD_decompress(dest, dest_size, s_buf, s_size))) {

You are correct that ZSTD_decompress() is picky that it must be given 
the exact size of the compressed buffer it is decompressing.  But the 
ZSTD manual mentions that if an exact size is not known in advance, that 
the streaming API can be used instead:

https://facebook.github.io/zstd/zstd_manual.html#Chapter9

In other words, would it be possible to NOT have to prepend four bytes 
of exact size information, by instead setting up decompression via the 
streaming API where the input is (usually) oversized, but the output 
buffer limited to exactly one cluster is sufficient to consume the exact 
compressed data and ignore the slop, just as we do in zlib?

The rest of this patch looks okay.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


