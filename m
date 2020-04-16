Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07AD1C2BB55
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 12:55:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7583208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 12:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="n0wWxw1T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7583208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jP43e-0005YN-Up
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 08:55:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56982)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jP42x-0004yX-2l
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 08:55:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1jP42v-0006TT-JA
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 08:55:10 -0400
Received: from fanzine.igalia.com ([178.60.130.6]:40099)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1jP42v-0006SG-0j; Thu, 16 Apr 2020 08:55:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=ox/kQiC1a6/nqDl5kcC0rENu8it0xjOuE36Kh6BEXuU=; 
 b=n0wWxw1Ta1ceDWmKET5xmrYzgTPPccUsPCFkCsbPju7oWlXYvbtS9wNKOV2M/iLSfN3u+ARbWA9dcMa1wM7NbRKkHLi6FGbJXZ/5qqalbc6Ej+79SNP7Q/nb1NQVtTowFfN1g4It91Gk7R/MRgJ7uFjbENa4+5d0Pz0E6YNqIUfjvMu5/bA6sppaA7FPNwPNJE/SJej0h/NMZgRWeHiHJCjrvQW0fqEN8TDG+72ZwsSoVjjrpKeODdMuxa2FrvrLRMg54PuvzwErg7ovN5BBJYU0DFiDO5xIKyNA2bIGlSbEAffaN9ANJoIdsdr2I0BuwlAF0E641MpERRjNFN6YAw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jP42r-0000m2-Nv; Thu, 16 Apr 2020 14:55:05 +0200
Received: from berto by mail.igalia.com with local (Exim)
 id 1jP42r-0003I8-EY; Thu, 16 Apr 2020 14:55:05 +0200
From: Alberto Garcia <berto@igalia.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v18 3/4] qcow2: add zstd cluster compression
In-Reply-To: <20200402063645.23685-4-dplotnikov@virtuozzo.com>
References: <20200402063645.23685-1-dplotnikov@virtuozzo.com>
 <20200402063645.23685-4-dplotnikov@virtuozzo.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Thu, 16 Apr 2020 14:55:05 +0200
Message-ID: <w51d087a8uu.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic] [fuzzy]
X-Received-From: 178.60.130.6
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 armbru@redhat.com, mreitz@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu 02 Apr 2020 08:36:44 AM CEST, Denis Plotnikov wrote:
> +static ssize_t qcow2_zstd_compress(void *dest, size_t dest_size,
> +                                   const void *src, size_t src_size)
> +{
> +    ssize_t ret;
> +    ZSTD_outBuffer output = { dest, dest_size, 0 };
> +    ZSTD_inBuffer input = { src, src_size, 0 };
> +    ZSTD_CCtx *cctx = ZSTD_createCCtx();
> +
> +    if (!cctx) {
> +        return -EIO;
> +    }
> +    /*
> +     * Use the zstd streamed interface for symmetry with decompression,
> +     * where streaming is essential since we don't record the exact
> +     * compressed size.
> +     *
> +     * In the loop, we try to compress all the data into one zstd frame.
> +     * ZSTD_compressStream2 potentially can finish a frame earlier
> +     * than the full input data is consumed. That's why we are looping
> +     * until all the input data is consumed.
> +     */
> +    while (input.pos < input.size) {
> +        size_t zstd_ret;
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

The patch looks good to me, but why don't you assert this at the
beginning of the function? You already know the buffer sizes...

Either way,

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto

