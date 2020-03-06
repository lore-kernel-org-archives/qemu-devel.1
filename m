Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCFBC10F00
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 10:50:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CB152072D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 10:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Sg7gG64i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CB152072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAAYu-0003tT-DL
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 05:50:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52131)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berto@igalia.com>) id 1jAAYG-0003FH-4A
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 05:49:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berto@igalia.com>) id 1jAAYE-00023B-4t
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 05:49:55 -0500
Received: from fanzine.igalia.com ([178.60.130.6]:57916)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <berto@igalia.com>)
 id 1jAAYD-0001u2-JY; Fri, 06 Mar 2020 05:49:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
 s=20170329; 
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From;
 bh=OvgShc1bODdLUc3O28qQRwQfFl47bjX4F0aK9chmUEA=; 
 b=Sg7gG64iS07CZUUx4YrkVV0GmknciDjsIU0eaB1ZlW7ZGcSqxQHL5Ye36r7WJ2f298eIVGHuSUfHCOx4+74Nk/0+2ixqxsqJbGEub/1xpRHcp076RMg/c3E2lk5RotaoU8bwveYKFv52m73cUSoF36HdpY7TmSa5i/cIxmFYTyDVxWCXX42aXV9+TijlTF0dbDWCwlQO3w/bLMjj0GsXIQ/DVl1kGe5nQH7SH9Rh9tSh4QSMSgKVVzBmq8hYxnde3QaBRUMJDszl2ZqtE+HcvDa6+UdqxrlhlB0YysGHQEJxTTPyf7spdEQZT+OUVjo9CxydRu0M/Qb9iTUKsyVmAw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine.igalia.com with esmtps 
 (Cipher TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim)
 id 1jAAY8-0002sv-Nh; Fri, 06 Mar 2020 11:49:48 +0100
Received: from berto by mail.igalia.com with local (Exim)
 id 1jAAY8-0003vI-Db; Fri, 06 Mar 2020 11:49:48 +0100
From: Alberto Garcia <berto@igalia.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v5 4/5] qcow2: add zstd cluster compression
In-Reply-To: <20200304133538.9159-5-dplotnikov@virtuozzo.com>
References: <20200304133538.9159-1-dplotnikov@virtuozzo.com>
 <20200304133538.9159-5-dplotnikov@virtuozzo.com>
User-Agent: Notmuch/0.18.2 (http://notmuchmail.org) Emacs/24.4.1
 (i586-pc-linux-gnu)
Date: Fri, 06 Mar 2020 11:49:48 +0100
Message-ID: <w51pndpsqpf.fsf@maestria.local.igalia.com>
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

On Wed 04 Mar 2020 02:35:37 PM CET, Denis Plotnikov wrote:
> +#ifdef CONFIG_ZSTD
> +
> +#define ZSTD_LEN_BUF 4

I think it's worth adding a comment explaining what this is. I know it's
quite clear once you read the code, but still...

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
> +        return -EIO;
> +    }
> +
> +    return 0;
> +}

In this one you could also return -ENOMEM if the destination buffer is
not big enough.

But not of my comments is so important, so whether you decide to make
those changes or not,

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto

