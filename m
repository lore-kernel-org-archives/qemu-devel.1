Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFDDC5DF62
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 12:20:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F88F20869
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 12:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="htqJc+6b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F88F20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSKIp-0003ry-CD
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 07:20:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52938)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iSKIB-0003Mu-T5
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 07:20:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iSKIA-0003af-Bm
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 07:20:07 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37739)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iSKI9-0003Yw-4p
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 07:20:06 -0500
Received: by mail-wm1-x343.google.com with SMTP id q130so3080990wme.2
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 04:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=RpgoQPK/LIDerO7lJEQ4U9SYduXiB2Zh7dzR1O0Iln0=;
 b=htqJc+6bldWKqzELJgsZtN7whFCVs7FF1pQeQgQkxhD9vhr41lA0i92w5eXrHyDX0v
 UgXIKW/pB0ma+i6/ZlDj51IKIAj1jUguoL7r7xqBpkBtdr7ZhoKgYVnLsNVsw///wwac
 kqfCIhG63FPxt6EEplOqzaTD/8H30JC/5TVdEH1/agwDwzXVJHnUU9W2KdiV29x9YXP/
 RC74yd5Tb+G5DzViPKv3htYVsPOvqF5wRxLLcgul8xss2iJ1eS+9VX5eYoEOXzE2q/VZ
 3vQVL53+uPcakZkyhtlf7iHa9R5YpPjvOx+g1TSBMI6DJXt5nngH3NKadLYRRkyNcj9s
 Y92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RpgoQPK/LIDerO7lJEQ4U9SYduXiB2Zh7dzR1O0Iln0=;
 b=V08pEoUo5pY5kQ4HAEY7AMx5rthtcyR+76Z45EMpm3oGmLsSYZj9IBh/bSay/8dgI9
 InOeE6yR2kgBixy3HGQGIXpJzFil4LgcY0jCDj5a01DgvQJQOqMuAnw7B7ev0zJ2d2Pm
 xswUVc/5kRtOSs0qMl8bjfGSL6Rn1jXrUBIC/8jqEuIg37o0Xp40xjhJkxG/osseZLKr
 VxxeMWQDenTlmTapHEfIA18U0J04uRKbzqboKNaw8FClv8ZTiAD0JNaLPTzPHo5eTTn7
 4s2pWNyMLe8uv2wDQaQb8busujwZ1TKcjloKB7GsdVzJ+O0nPO2kQgHFx2ZKH1XV0S7P
 Uxsw==
X-Gm-Message-State: APjAAAUEEM4vSWWq0iBgCGfaKrR7vJpJJfk/RkJY4zya1DThYMSGUnU7
 MjtCmakOXZUKxYC3XvOwOWzicA==
X-Google-Smtp-Source: APXvYqzroIhHkQSdGLo6acutV3vLksrRmQeHFLbXl0uC87zPIgBoz3VIDgdpv2lCs7HFkt2fKb+D7Q==
X-Received: by 2002:a1c:9ccd:: with SMTP id f196mr2247964wme.152.1573042803847; 
 Wed, 06 Nov 2019 04:20:03 -0800 (PST)
Received: from [192.168.8.102] (31.red-176-87-122.dynamicip.rima-tde.net.
 [176.87.122.31])
 by smtp.gmail.com with ESMTPSA id i3sm24118569wrw.69.2019.11.06.04.20.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 06 Nov 2019 04:20:03 -0800 (PST)
Subject: Re: [PATCH v2 2/4] Memory: Enable writeback for given memory region
To: Beata Michalska <beata.michalska@linaro.org>, qemu-devel@nongnu.org
References: <20191105234100.22052-1-beata.michalska@linaro.org>
 <20191105234100.22052-3-beata.michalska@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <5c75bd31-213f-88a4-2eee-0046f99f65fe@linaro.org>
Date: Wed, 6 Nov 2019 13:19:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191105234100.22052-3-beata.michalska@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: peter.maydell@linaro.org, quintela@redhat.com, dgilbert@redhat.com,
 shameerali.kolothum.thodi@huawei.com, eric.auger@redhat.com,
 qemu-arm@nongnu.org, pbonzini@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/6/19 12:40 AM, Beata Michalska wrote:
> +void qemu_ram_writeback(RAMBlock *block, ram_addr_t start, ram_addr_t length)
> +{
> +    void *addr = ramblock_ptr(block, start);
> +
> +    /*
> +     * The requested range might spread up to the very end of the block
> +     */
> +    if ((start + length) > block->used_length) {
> +        qemu_log("%s: sync range outside the block boundaries: "
> +                     "start: " RAM_ADDR_FMT " length: " RAM_ADDR_FMT
> +                     " block length: " RAM_ADDR_FMT " Narrowing down ..." ,
> +                     __func__, start, length, block->used_length);
> +        length = block->used_length - start;
> +    }

qemu_log_mask w/ GUEST_ERROR?  How do we expect the length to overflow?

> +#ifdef CONFIG_LIBPMEM
> +    /* The lack of support for pmem should not block the sync */
> +    if (ramblock_is_pmem(block)) {
> +        pmem_persist(addr, length);
> +    } else
> +#endif

Perhaps better to return out of that if block than have the dangling else.

> +/**
> + * Sync changes made to the memory mapped file back to the backing
> + * storage. For POSIX compliant systems this will simply fallback
> + * to regular msync call (thus the required alignment). Otherwise
> + * it will trigger whole file sync (including the metadata case
> + * there is no support to skip that otherwise)
> + *
> + * @addr   - start of the memory area to be synced
> + * @length - length of the are to be synced
> + * @align  - alignment (expected to be PAGE_SIZE)
> + * @fd     - file descriptor for the file to be synced
> + *           (mandatory only for POSIX non-compliant systems)
> + */
> +int qemu_msync(void *addr, size_t length, size_t align, int fd)
> +{
> +#ifdef CONFIG_POSIX
> +    size_t align_mask;
> +
> +    /* Bare minimum of sanity checks on the alignment */
> +    /* The start address needs to be a multiple of PAGE_SIZE */
> +    align = MAX(align, qemu_real_host_page_size);
> +    align_mask = ~(qemu_real_host_page_size - 1);
> +    align = (align + ~align_mask) & align_mask;
> +
> +    align_mask = ~(align - 1);

I don't understand what you're trying to do with align.

You pass in qemu_host_page_size from the one caller, and then adjust it for
qemu_real_host_page_size?

Why pass in anything at all, and just use qemu_real_host_page_mask?

> +    /**
> +     * There are no strict reqs as per the length of mapping
> +     * to be synced. Still the length needs to follow the address
> +     * alignment changes. Additionally - round the size to the multiple
> +     * of requested alignment (expected as PAGE_SIZE)
> +     */
> +    length += ((uintptr_t)addr & (align - 1));
> +    length = (length + ~align_mask) & align_mask;
> +
> +    addr = (void *)((uintptr_t)addr & align_mask);
> +
> +    return msync(addr, length, MS_SYNC);
> +#else /* CONFIG_POSIX */
> +    /**
> +     * Perform the sync based on the file descriptor
> +     * The sync range will most probably be wider than the one
> +     * requested - but it will still get the job done
> +     */
> +    return qemu_fdatasync(fd);
> +#endif /* CONFIG_POSIX */
> +}


r~


