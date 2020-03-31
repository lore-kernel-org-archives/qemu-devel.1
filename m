Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55A6C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 18:33:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAA2D20786
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 18:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ePBNbjCb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAA2D20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJLhL-0004mF-OQ
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 14:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60391)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jJLgg-0004Ib-1t
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 14:32:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jJLgd-0006Mr-Sd
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 14:32:33 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26697
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jJLgc-0006LD-Rp
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 14:32:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585679550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1wrFpbH5u512CztARbv0t1asibVUu6hjkDjwWTWGHPA=;
 b=ePBNbjCbYmmWHOPAVv4c3TP3t2Z0qQHa77nmTx+qAdcdY7UUAOjzQtGKBI4xep/GNZ8dGu
 it5EwuaYj2NDBjzyqAnk0EVUgRBkcY2RHS+BayfRUS2xign3OZ3wdHwAx8diAZoLWBkZYv
 DttHIFghovTwZxPgqxVXQIW0u3bhbWw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-ntD1ewfmN5e4XTz27tKuYg-1; Tue, 31 Mar 2020 14:32:23 -0400
X-MC-Unique: ntD1ewfmN5e4XTz27tKuYg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B330DB60;
 Tue, 31 Mar 2020 18:32:22 +0000 (UTC)
Received: from [10.3.113.246] (ovpn-113-246.phx2.redhat.com [10.3.113.246])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 27EDF19C6A;
 Tue, 31 Mar 2020 18:32:20 +0000 (UTC)
Subject: Re: [PATCH v14 3/4] qcow2: add zstd cluster compression
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200331174455.31792-1-dplotnikov@virtuozzo.com>
 <20200331174455.31792-4-dplotnikov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <ba8457b9-c88e-5b29-8b53-6ed8313f43f4@redhat.com>
Date: Tue, 31 Mar 2020 13:32:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200331174455.31792-4-dplotnikov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

On 3/31/20 12:44 PM, Denis Plotnikov wrote:
> zstd significantly reduces cluster compression time.
> It provides better compression performance maintaining
> the same level of the compression ratio in comparison with
> zlib, which, at the moment, is the only compression
> method available.
> 

> 
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> QAPI part:
> Acked-by: Markus Armbruster <armbru@redhat.com>
> ---

> +/*
> + * qcow2_zstd_compress()
> + *
> + * Compress @src_size bytes of data using zstd compression method
> + *
> + * @dest - destination buffer, @dest_size bytes
> + * @src - source buffer, @src_size bytes
> + *
> + * Returns: compressed size on success
> + *          -ENOMEM destination buffer is not enough to store compressed data
> + *          -EIO    on any other error
> + */
> +static ssize_t qcow2_zstd_compress(void *dest, size_t dest_size,
> +                                   const void *src, size_t src_size)
> +{
> +    ssize_t ret;
> +    size_t zstd_ret = 0;
> +    ZSTD_outBuffer output = { dest, dest_size, 0 };
> +    ZSTD_inBuffer input = { src, src_size, 0 };
> +    ZSTD_CCtx *cctx = ZSTD_createCCtx();
> +
> +    if (!cctx) {
> +        return -EIO;
> +    }
> +    /*
> +     * We want to use zstd streamed interface on decompression,
> +     * as we won't know the exact size of the compressed data.

This comment feels like it belongs to decompression rather than 
compression.  We _do_ know the exact source size of the data to be 
compressed, but we don't know the resulting compressed size.  Maybe:

'Use the zstd streamed interface for symmetry with decompression, where 
streaming is essential since we don't record the exact compressed size.'

> +     *
> +     * In the loop, we try to compress all the data into one zstd frame.
> +     * ZSTD_compressStream2 potentially can finish a frame earlier
> +     * than the full input data is consumed. That's why we are looping
> +     * until all the input data is consumed.
> +     */
> +    while (input.pos < input.size) {
> +        /*
> +         * ZSTD spec: "You must continue calling ZSTD_compressStream2()
> +         * with ZSTD_e_end until it returns 0, at which point you are
> +         * free to start a new frame". We assume that "start a new frame"
> +         * means call ZSTD_compressStream2 in the very beginning or when
> +         * ZSTD_compressStream2 has returned with 0.
> +         */
> +        do {
> +            zstd_ret = ZSTD_compressStream2(cctx, &output, &input, ZSTD_e_end);
> +
> +            if (ZSTD_isError(zstd_ret)) {
> +                ret = -EIO;
> +                goto out;
> +            }
> +            /* Dest buffer isn't big enough to store compressed content */
> +            if (zstd_ret > output.size - output.pos) {
> +                ret = -ENOMEM;
> +                goto out;
> +            }
> +        } while (zstd_ret);
> +    }
> +    /* make sure we can safely return compressed buffer size with ssize_t */
> +    assert(output.pos <= SSIZE_MAX);
> +    ret = output.pos;
> +out:
> +    ZSTD_freeCCtx(cctx);
> +    return ret;
> +}

I didn't closely check the zstd documentation, but based on naming, this 
loop looks reasonable.  And of course, if you can read an image created 
with this code, then the round trip proves it was used correctly for 
that case.

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
> +    size_t ret = 0;
> +    ZSTD_outBuffer output = { dest, dest_size, 0 };
> +    ZSTD_inBuffer input = { src, src_size, 0 };
> +    ZSTD_DCtx *dctx = ZSTD_createDCtx();
> +
> +    if (!dctx) {
> +        return -EIO;
> +    }
> +
> +    /*
> +     * The compressed stream from input buffer may consist from more
> +     * than one zstd frames. So we iterate until we get a fully

The compressed stream from the input buffer may consist of more than one 
zstd frame.  So we iterate...


> +     * uncompressed cluster.
> +     * from zstd docs related to ZSTD_decompressStream:
> +     * "return : 0 when a frame is completely decoded and fully flushed"
> +     * We suppose that this means: each time ZSTD_decompressStream reads
> +     * only ONE full frame and return 0 if and only if that frame

returns

> +     * is completely decoded and flushed. Only after returning 0,
> +     * ZSTD_decompressStream reads another ONE full frame.
> +     */
> +    while (output.pos < output.size) {
> +        size_t last_in_pos = input.pos;
> +        size_t last_out_pos = output.pos;
> +        ret = ZSTD_decompressStream(dctx, &output, &input);
> +        /*
> +         * zstd manual doesn't explicitly states what happens,

state

> +         * if ZSTD_decompressStream reads the frame partially.
> +         * But, based on our tests, if we don't fully populate
> +         * the output and have read all the frames from the input,
> +         * we end up with error here.
> +         */
> +        if (ZSTD_isError(ret)) {
> +            ret = -EIO;
> +            break;
> +        }
> +
> +        /*
> +         * As ZSTD manual is vague about what to do if it

s/As/The/

> +         * reads the buffer partially, we afraid of case
> +         * when we stuck in the infinite loop, because
> +         * output isn't full and input has read partially, so

partially, and we don't want to get stuck in an infinite loop where 
ZSTD_decompressStream

> +         * ZSTD_decompressStream returns > 0 waiting for
> +         * another input chunk. So, we add a paranoid check
> +         * that on each step the loop makes some progress.
> +         */
> +        if (last_in_pos >= input.pos &&
> +            last_out_pos >= output.pos) {
> +            ret = -EIO;
> +            break;
> +        }
> +    }
> +    /*
> +     * Make sure that we have the frame fully flushed here
> +     * if not, we somehow managed to get uncompressed cluster
> +     * greater then the cluster size, possibly because of its
> +     * damage.
> +     */
> +    if (ret > 0) {
> +        ret = -EIO;
> +    }
> +
> +    ZSTD_freeDCtx(dctx);
> +    assert(ret == 0 || ret == -EIO);
> +    return ret;
> +}

Again, I didn't closely check the ZSTD documentation or implementation, 
but based on function names, the loop looks reasonable.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


