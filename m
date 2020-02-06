Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BFFC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:56:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ED9620661
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 11:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wrK/x6ws"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ED9620661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izflT-0000wv-90
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 06:56:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55196)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1izfks-0000XV-KU
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:55:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1izfkr-0005pd-Eu
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:55:34 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51098)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1izfkr-0005jc-5Z
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 06:55:33 -0500
Received: by mail-wm1-x341.google.com with SMTP id a5so6032543wmb.0
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 03:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=U1130NftMTubPVlpBaSp9sopcaVsQ1bNSiGJAUg/wtg=;
 b=wrK/x6wsmgELRYu1SDS5HkRm2OMBJ11+FYA41cdJ8/ryRuhv0Sdf0GXFpMWn3sDywn
 2J2MMiICljjjcPHWVITYLbmee2tfCrY4HGUlRUtvaqq4GbC/ydabSHNll2Enlv9HYBpi
 7n9l491DV5BnoK4ciXrgYBQ/rOSOcHcHLvJWdh/f/zvZSpPekIFBOABxatCE46oOVR+0
 2qzBMLUKiZpJmGNWXI4f/JhjkxTk5FYcD12d8a4hH3nG5fRZpjNXMXR/xNrYz9+qi0L8
 +ayB0rAdG79FjPE8LtMg4tHsbELPAiIb04f9pKUGSTBsdVwQOenw88W2fy126WkJN2uK
 g32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=U1130NftMTubPVlpBaSp9sopcaVsQ1bNSiGJAUg/wtg=;
 b=bxSLmAPQP3nu1Zw1fpC1yRCok+aCWx6B3M9y0a8T+yPZXmZnhlxRDVd7SZ66QZ9P8t
 ldM/JeWCS7PomrhQOipDdPNILzXS/uZfKwv2snD9CJVhC0mrTkxRpBXrNp/TYpHROnYu
 dUyv6cvb8jeWNw7LcPUhAjNLVUDVICzRhzurJLg5MuXz0MuI+PRgaMQtcYuqcn3QxroV
 cWwI5t0C1wZApDG3z1RGlKk0Uf6cRwIdJJFwwL4hdurLPlD9dDqeP3irxqvLIgBWaNgK
 FW68KwGVEZKaRwF1BL6+SWx5WW1OHJjW8VlCugy7pTbVIA9xIbUdBCr1M16hwx/TcY9P
 27cg==
X-Gm-Message-State: APjAAAWq8rZuPWEc69OkwcWmmfoeDO1qSucteN49XCSlFsPu1uwg2bQF
 UfCTPRB5V8EOyWXVh5Y6oIwHKg==
X-Google-Smtp-Source: APXvYqy3l6fttTw0YXgLAP+NxxvEe4Y5+XF3J7f9bCtC08o6Lg4636E6evPB7UAJGwlpZXhF0EGc+w==
X-Received: by 2002:a1c:2089:: with SMTP id g131mr3974166wmg.63.1580990132016; 
 Thu, 06 Feb 2020 03:55:32 -0800 (PST)
Received: from [10.43.13.93] ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id m21sm3558112wmi.27.2020.02.06.03.55.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 03:55:31 -0800 (PST)
Subject: Re: [PATCH v1 06/13] util/mmap-alloc: Factor out reserving of a
 memory region to mmap_reserve()
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200203183125.164879-1-david@redhat.com>
 <20200203183125.164879-7-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ac536bfa-ca47-f0bd-e054-ce981758d5f3@linaro.org>
Date: Thu, 6 Feb 2020 11:55:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200203183125.164879-7-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Greg Kurz <groug@kaod.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/3/20 6:31 PM, David Hildenbrand wrote:
> We want to reserve a memory region without actually populating memory.
> Let's factor that out.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Greg Kurz <groug@kaod.org>
> Cc: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  util/mmap-alloc.c | 58 +++++++++++++++++++++++++++--------------------
>  1 file changed, 33 insertions(+), 25 deletions(-)
> 
> diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
> index 82f02a2cec..43a26f38a8 100644
> --- a/util/mmap-alloc.c
> +++ b/util/mmap-alloc.c
> @@ -82,6 +82,38 @@ size_t qemu_mempath_getpagesize(const char *mem_path)
>      return qemu_real_host_page_size;
>  }
>  
> +/*
> + * Reserve a new memory region of the requested size to be used for mapping
> + * from the given fd (if any).
> + */
> +static void *mmap_reserve(size_t size, int fd)
> +{
> +    int flags = MAP_PRIVATE;
> +
> +#if defined(__powerpc64__) && defined(__linux__)
> +    /*
> +     * On ppc64 mappings in the same segment (aka slice) must share the same
> +     * page size. Since we will be re-allocating part of this segment
> +     * from the supplied fd, we should make sure to use the same page size, to
> +     * this end we mmap the supplied fd.  In this case, set MAP_NORESERVE to
> +     * avoid allocating backing store memory.
> +     * We do this unless we are using the system page size, in which case
> +     * anonymous memory is OK.
> +     */
> +    if (fd == -1 || qemu_fd_getpagesize(fd) == qemu_real_host_page_size) {
> +        fd = -1;
> +        flags |= MAP_ANONYMOUS;
> +    } else {
> +        flags |= MAP_NORESERVE;
> +    }
> +#else
> +    fd = -1;
> +    flags |= MAP_ANONYMOUS;
> +#endif

Because this is just code movement,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

But is there a reason not to add MAP_NORESERVE all of the time?
It seems to match intent, in that we're reserving vma but not planning to use
the memory, anonymous or not.


r~

