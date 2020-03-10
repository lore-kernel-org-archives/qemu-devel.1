Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C28C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 17:34:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DE4C21927
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 17:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GV8N7rJg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DE4C21927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBimK-0005rB-Em
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 13:34:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39586)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jBila-0005MG-03
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 13:34:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jBilY-0007uI-Qp
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 13:34:05 -0400
Received: from mail-vk1-xa44.google.com ([2607:f8b0:4864:20::a44]:45451)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jBilX-0007oJ-MQ
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 13:34:04 -0400
Received: by mail-vk1-xa44.google.com with SMTP id b187so1975751vkh.12
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2020 10:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=w2jQRu0pc9YlhzCPQQSUofCxUzCZRXb6WkCGqtOgMCA=;
 b=GV8N7rJgEs+camUuSYpIsi/fmTMvcZT6vttdDuTIDCPDjq5q1AJXIDo0vS/ZdxbpGG
 41cfXgosqGNr9pePW0adfiweZ8KtVAq73CzdZQwF4ovD+vCfCY2aE/4pMiX8qSvYzlH5
 aq75SOy9AR/PmbAHKDeRvAqeNUXsPVN0YMW8neXKk65JCSliru0MncVSoe2BLv9QTmLy
 YXjbzGw5am7VySjfBRBtxlrtRUe6YCjF5sjl9iy9o7f8/ZE10Nn3rIJ8G57oytTuzxDX
 ww4uMwUs4UrvqRiO4MM9c/0GIq9tyVVOyLEci51M2OrveyBQbyB4unJCSy9SDtfvdUMF
 6GYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=w2jQRu0pc9YlhzCPQQSUofCxUzCZRXb6WkCGqtOgMCA=;
 b=DlvZy2b9BZYzLSWuvJVMHi64YLYb3b8lwilXBaHtK/qqal2K8unRVEQ4tp2RAWM1NS
 LTzi8BWgLNA24Qpzenw5ZRJbgCpWid2WLAY3AnQa+rZy7V/eEGUqoW50pUq3IIghWKVK
 78w3U6J30zcdiuoE0uiXQDDhYiPE4ED2sJgOcVlAu2ThluT4M7E/7GQnwKBMENwcL52P
 kMy3QFh3pXvikwv6R1uf/J9R2Lcx6VhP9t7qEtc+VATRG0El1LC5MmqFqPfOBRtrt2wp
 R76vNn0nWeA7h8fAMjs5Cq4rO6TTfgRkPbuxqnKEFP71M7myMShvK4D1jHhL22626K1e
 e1Tw==
X-Gm-Message-State: ANhLgQ2F7P7XYamL9qUEcHWsFlSStIGUSjsCKM8cU4G0cuCeisA0/NZ2
 J0BIjn/Jw/1AdNbFGO2vHyo1tyPnH1tctsKQu+I=
X-Google-Smtp-Source: ADFU+vtEJLPfoaiy518+7LLixL6WfrDxFJ+1CkNRdytErUVlH4GrfXSJnJZEnZz4YCulSZOUxfQqurJN91PlmxLjMqc=
X-Received: by 2002:ac5:c1ca:: with SMTP id g10mr3303617vkk.16.1583861641856; 
 Tue, 10 Mar 2020 10:34:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200310110759.3331020-1-laurent@vivier.eu>
 <20200310110759.3331020-3-laurent@vivier.eu>
In-Reply-To: <20200310110759.3331020-3-laurent@vivier.eu>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 10 Mar 2020 10:26:14 -0700
Message-ID: <CAKmqyKOFWv90RUq7h9Y5cUV5aJr3br2dOeb5bx-+U+RkL4Dpxg@mail.gmail.com>
Subject: Re: [PATCH 2/4] linux-user,
 aarch64: sync syscall numbers with kernel v5.5
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::a44
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
Cc: Marek Vasut <marex@denx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Jia Liu <proljc@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 10, 2020 at 4:10 AM Laurent Vivier <laurent@vivier.eu> wrote:
>
> Use helper script scripts/gensyscalls.sh to generate the file.
>
> This change TARGET_NR_fstatat64 by TARGET_NR_newfstatat that is correct
> because definitions from linux are:
>
> arch/arm64/include/uapi/asm/unistd.h
>
>   #define __ARCH_WANT_NEW_STAT
>
> include/uapi/asm-generic/unistd.h
>
>   #if defined(__ARCH_WANT_NEW_STAT) || defined(__ARCH_WANT_STAT64)
>   #define __NR3264_fstatat 79
>   __SC_3264(__NR3264_fstatat, sys_fstatat64, sys_newfstatat)
>   #define __NR3264_fstat 80
>   __SC_3264(__NR3264_fstat, sys_fstat64, sys_newfstat)
>   #endif
>   ...
>   #if __BITS_PER_LONG == 64 && !defined(__SYSCALL_COMPAT)
>   ...
>   #if defined(__ARCH_WANT_NEW_STAT) || defined(__ARCH_WANT_STAT64)
>   #define __NR_newfstatat __NR3264_fstatat
>   #define __NR_fstat __NR3264_fstat
>   #endif
>   ...
>
> Add syscalls 286 (preadv2) to 435 (clone3).
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  linux-user/aarch64/syscall_nr.h | 32 +++++++++++++++++++++++++++-----
>  1 file changed, 27 insertions(+), 5 deletions(-)
>
> diff --git a/linux-user/aarch64/syscall_nr.h b/linux-user/aarch64/syscall_nr.h
> index f00ffd7fb82f..eb5287bf6c98 100644
> --- a/linux-user/aarch64/syscall_nr.h
> +++ b/linux-user/aarch64/syscall_nr.h
> @@ -1,7 +1,6 @@
>  /*
>   * This file contains the system call numbers.
>   */
> -
>  #ifndef LINUX_USER_AARCH64_SYSCALL_NR_H
>  #define LINUX_USER_AARCH64_SYSCALL_NR_H
>
> @@ -84,7 +83,7 @@
>  #define TARGET_NR_splice 76
>  #define TARGET_NR_tee 77
>  #define TARGET_NR_readlinkat 78
> -#define TARGET_NR_fstatat64 79
> +#define TARGET_NR_newfstatat 79
>  #define TARGET_NR_fstat 80
>  #define TARGET_NR_sync 81
>  #define TARGET_NR_fsync 82
> @@ -254,8 +253,8 @@
>  #define TARGET_NR_prlimit64 261
>  #define TARGET_NR_fanotify_init 262
>  #define TARGET_NR_fanotify_mark 263
> -#define TARGET_NR_name_to_handle_at         264
> -#define TARGET_NR_open_by_handle_at         265
> +#define TARGET_NR_name_to_handle_at 264
> +#define TARGET_NR_open_by_handle_at 265
>  #define TARGET_NR_clock_adjtime 266
>  #define TARGET_NR_syncfs 267
>  #define TARGET_NR_setns 268
> @@ -276,5 +275,28 @@
>  #define TARGET_NR_membarrier 283
>  #define TARGET_NR_mlock2 284
>  #define TARGET_NR_copy_file_range 285
> +#define TARGET_NR_preadv2 286
> +#define TARGET_NR_pwritev2 287
> +#define TARGET_NR_pkey_mprotect 288
> +#define TARGET_NR_pkey_alloc 289
> +#define TARGET_NR_pkey_free 290
> +#define TARGET_NR_statx 291
> +#define TARGET_NR_io_pgetevents 292
> +#define TARGET_NR_rseq 293
> +#define TARGET_NR_kexec_file_load 294
> +#define TARGET_NR_pidfd_send_signal 424
> +#define TARGET_NR_io_uring_setup 425
> +#define TARGET_NR_io_uring_enter 426
> +#define TARGET_NR_io_uring_register 427
> +#define TARGET_NR_open_tree 428
> +#define TARGET_NR_move_mount 429
> +#define TARGET_NR_fsopen 430
> +#define TARGET_NR_fsconfig 431
> +#define TARGET_NR_fsmount 432
> +#define TARGET_NR_fspick 433
> +#define TARGET_NR_pidfd_open 434
> +#define TARGET_NR_clone3 435
> +#define TARGET_NR_syscalls 436
> +
> +#endif /* LINUX_USER_AARCH64_SYSCALL_NR_H */
>
> -#endif
> --
> 2.24.1
>
>

