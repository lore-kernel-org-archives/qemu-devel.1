Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7D4C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 15:18:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37D0C20665
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 15:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JLOOdPoZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37D0C20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCmZx-0004BD-Ug
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 11:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35082)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iClIj-0002BP-AN
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:56:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iClIh-0006kh-Re
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:56:21 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33559)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iClIh-0006hP-KB
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:56:19 -0400
Received: by mail-wr1-x443.google.com with SMTP id b9so2080185wrs.0
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 06:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=VZ+NFYcRuWNEduMtBKNgZAQq1lD5JOldft0P6C/wMzU=;
 b=JLOOdPoZXsOr8cTE39lQHyLMfEpo3XrOtnRN6F+vWEesbaOgK/E2ZvjY/E3Rd1ARkL
 sz/m97foyulbTwGdsdzuM+XdYmrpYhMOpuayDWIgRXHPwiF1hE74LRhzTPayJU+Fyghb
 RcU9t38YdlJJOgO8fqQoYdW7BZLVQitKxFSThCZxcTwewxupqQn9lEiIsv//qE2ml8nf
 NRmMkuVKxJ5utAhyAV+8BrICbX/NZ2cgfYyFQ18PNuQkp3RVM2Cd/UEZ0IptJE86elqb
 PxGVD9W9pLJX7VGH6Ib1NhQY3sQaW73ZSUvDLuJ4iT+Hn6OOXM/P0u3YVvlDbMg/DAsS
 QEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=VZ+NFYcRuWNEduMtBKNgZAQq1lD5JOldft0P6C/wMzU=;
 b=gBg9/Vd31PuN5mousT3JKHd5i8NRJo2Lk4lbsehKyW0zopOrLZlYRwXuKHNHRt9zbn
 G3WJymaukQP8Wcp7uFREAUND8eRng9oaqeA5VTFhRNIgJhNbnSQ/G4JpPo9Kv99Js9tu
 JhcJGKl2lUDFkAEJ0JQcinVWIuzfdbU3OUdHIGbxUPu/VTAF4GkhH5Ulc3T+M41JXLlO
 daPpqZgcjDHqgxDB4kMe8sFtvsnIFjcbRxX/RuY30drrnJHWz7LMJ0mXdmOIoZtHeaaf
 rdQLY8k5uaoDrV02PWFRlHRWjqpkA7oRp4jkCGnzGzrxqAUJk8hoQ6JsLrEB/vMIpd0b
 zWxw==
X-Gm-Message-State: APjAAAXIVcX+XTGxgXK/8KuEVrbh1qTLLne1IVca4LcHbosebj94fRhW
 SfFNRfWDqH0YOx6pjKEksWJBJA==
X-Google-Smtp-Source: APXvYqyPl7rQU0AnOLzJ5gJMXhaosnBt3s/SVSm/zmLlYOgoru0b8jdWBBYGMVru9UfAw1BIyPwd0Q==
X-Received: by 2002:a5d:430e:: with SMTP id h14mr2394280wrq.18.1569333378338; 
 Tue, 24 Sep 2019 06:56:18 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t18sm32267wmi.44.2019.09.24.06.56.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2019 06:56:17 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D5A8E1FF87;
 Tue, 24 Sep 2019 14:56:16 +0100 (BST)
References: <20190923230004.9231-1-richard.henderson@linaro.org>
 <20190923230004.9231-3-richard.henderson@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v4 02/16] cputlb: Disable __always_inline__ without
 optimization
In-reply-to: <20190923230004.9231-3-richard.henderson@linaro.org>
Date: Tue, 24 Sep 2019 14:56:16 +0100
Message-ID: <878sqdbxxb.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> This forced inlining can result in missing symbols,
> which makes a debugging build harder to follow.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/qemu/compiler.h | 11 +++++++++++
>  accel/tcg/cputlb.c      |  4 ++--
>  2 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
> index 09fc44cca4..20780e722d 100644
> --- a/include/qemu/compiler.h
> +++ b/include/qemu/compiler.h
> @@ -170,6 +170,17 @@
>  # define QEMU_NONSTRING
>  #endif
>
> +/*
> + * Forced inlining may be desired to encourage constant propagation
> + * of function parameters.  However, it can also make debugging harder,
> + * so disable it for a non-optimizing build.
> + */
> +#if defined(__OPTIMIZE__)
> +#define QEMU_ALWAYS_INLINE  __attribute__((always_inline))
> +#else
> +#define QEMU_ALWAYS_INLINE
> +#endif
> +
>  /* Implement C11 _Generic via GCC builtins.  Example:
>   *
>   *    QEMU_GENERIC(x, (float, sinf), (long double, sinl), sin) (x)
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index abae79650c..2222b87764 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1281,7 +1281,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, t=
arget_ulong addr,
>  typedef uint64_t FullLoadHelper(CPUArchState *env, target_ulong addr,
>                                  TCGMemOpIdx oi, uintptr_t retaddr);
>
> -static inline uint64_t __attribute__((always_inline))
> +static inline uint64_t QEMU_ALWAYS_INLINE
>  load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
>              uintptr_t retaddr, MemOp op, bool code_read,
>              FullLoadHelper *full_load)
> @@ -1530,7 +1530,7 @@ tcg_target_ulong helper_be_ldsl_mmu(CPUArchState *e=
nv, target_ulong addr,
>   * Store Helpers
>   */
>
> -static inline void __attribute__((always_inline))
> +static inline void QEMU_ALWAYS_INLINE
>  store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
>               TCGMemOpIdx oi, uintptr_t retaddr, MemOp op)
>  {


--
Alex Benn=C3=A9e

