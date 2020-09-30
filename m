Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF04FC4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 01:25:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 055E020B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 01:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CREd8xW2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 055E020B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNQro-0003Wy-Vk
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 21:25:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kNQqs-00031I-VS
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 21:24:14 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:46940)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kNQqr-000581-5V
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 21:24:14 -0400
Received: by mail-il1-x141.google.com with SMTP id l16so6877328ilt.13
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 18:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NPyGlJQgiz95bjuxjz4K21GBO2IGQ2YpDA4/2nPalEw=;
 b=CREd8xW2nkIvqGOg/yM+cJeNenNImFIVkxbBtf52YdmCzfmIc6jREFP0vi3oQxe/Yb
 UHHL35W2BTWMwPtBeDcenhUNTkXpRfv5TRCaq2wneMZ4602L1HEkkvBShXLoZwc9BvXg
 RiM92YfktUTPmUGLTeuLxq/EtQupLk2jqwRknEKF15cMKRkU1wx5cKyWLGadgXV1U9lZ
 W8N7BuEcpJJhMtCiJ+cc2QimCBsarcWvhIF5TUx0Ap53MyZN2+Qkyfq0DFVTVPURIwY1
 KbQ8hRdv9XmVM/wUAb1wZBIL5oshThnAdTgbkUFDZIfGAc0uAXnKEdAhdCgssP/Pzxab
 k2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NPyGlJQgiz95bjuxjz4K21GBO2IGQ2YpDA4/2nPalEw=;
 b=Ak8Fwfx8BOkUSx6GK4kZTj6I8321kYZuqLa8uO98ODPPB8H/vbgccJdrMM+7IIHuSZ
 LUYbqGzN8uRN5Kgn8OviPyLcc8ZwmijDNNZT9HBSgMkG3eO2jEETM+KCC3iGTe9urwTB
 iZiLvqOvz+hmqgp9KOtkBOlnhNtc2/IPb2zO3g41FbI+IVVCFx3/TmQnELZdeSppB0Ik
 2Nnn07yRzIv0UQ1ap2/IJdH1zqpLoPvbE9YKnyxJ0elzNbpKnZnZ0Hlq8GiMK2MWK8Lj
 ZmMBAqNistYjhwtL7dH9fp06Yq3YwK+IbEOMN01hNbbASAQHUbpTzzV5OUD9QvddjeiP
 TInQ==
X-Gm-Message-State: AOAM533OdykaBZVZDPtCTYHvuwVKN7VQahzVEWaTEoKl/Fx7YMa3XLRQ
 OdKay48+WBEa4H+oQFsIvjHnHFDu0PDofBKE3n4=
X-Google-Smtp-Source: ABdhPJz8J9sFEogkwHDUoJ6e8vg78urgSAHREt1BtsZCVAmVwFMSNp8XyMqHJO1cYeSA7jtSJwuFVDcf3eRA8i3V9Lc=
X-Received: by 2002:a92:9817:: with SMTP id l23mr62029ili.131.1601429051257;
 Tue, 29 Sep 2020 18:24:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200930003033.554124-1-laurent@vivier.eu>
 <20200930003033.554124-2-laurent@vivier.eu>
In-Reply-To: <20200930003033.554124-2-laurent@vivier.eu>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 29 Sep 2020 18:12:48 -0700
Message-ID: <CAKmqyKP_1MkXzgPG+eQk65-ey+YJGBOKbkysnjGWoMYsNcMNjQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] linux-user: update syscall_nr.h to Linux 5.9-rc7
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 29, 2020 at 5:34 PM Laurent Vivier <laurent@vivier.eu> wrote:
>
> Update gensyscalls.sh not to generate an empty line at the end of the file
>
> And then automatically update syscall_nr.h running scripts/gensyscalls.sh
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

For the RISC-V part:

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  linux-user/aarch64/syscall_nr.h  | 7 +++++--
>  linux-user/nios2/syscall_nr.h    | 7 +++++--
>  linux-user/openrisc/syscall_nr.h | 8 ++++++--
>  linux-user/riscv/syscall32_nr.h  | 8 +++++++-
>  linux-user/riscv/syscall64_nr.h  | 8 +++++++-
>  scripts/gensyscalls.sh           | 3 +--
>  6 files changed, 31 insertions(+), 10 deletions(-)
>
> diff --git a/linux-user/aarch64/syscall_nr.h b/linux-user/aarch64/syscall_nr.h
> index 85de000b2490..6fd5b331e780 100644
> --- a/linux-user/aarch64/syscall_nr.h
> +++ b/linux-user/aarch64/syscall_nr.h
> @@ -298,7 +298,10 @@
>  #define TARGET_NR_fspick 433
>  #define TARGET_NR_pidfd_open 434
>  #define TARGET_NR_clone3 435
> -#define TARGET_NR_syscalls 436
> +#define TARGET_NR_close_range 436
> +#define TARGET_NR_openat2 437
> +#define TARGET_NR_pidfd_getfd 438
> +#define TARGET_NR_faccessat2 439
> +#define TARGET_NR_syscalls 440
>
>  #endif /* LINUX_USER_AARCH64_SYSCALL_NR_H */
> -
> diff --git a/linux-user/nios2/syscall_nr.h b/linux-user/nios2/syscall_nr.h
> index 32d485dc9ae8..e37f40179bf3 100644
> --- a/linux-user/nios2/syscall_nr.h
> +++ b/linux-user/nios2/syscall_nr.h
> @@ -318,7 +318,10 @@
>  #define TARGET_NR_fsmount 432
>  #define TARGET_NR_fspick 433
>  #define TARGET_NR_pidfd_open 434
> -#define TARGET_NR_syscalls 436
> +#define TARGET_NR_close_range 436
> +#define TARGET_NR_openat2 437
> +#define TARGET_NR_pidfd_getfd 438
> +#define TARGET_NR_faccessat2 439
> +#define TARGET_NR_syscalls 440
>
>  #endif /* LINUX_USER_NIOS2_SYSCALL_NR_H */
> -
> diff --git a/linux-user/openrisc/syscall_nr.h b/linux-user/openrisc/syscall_nr.h
> index 340383beb2c6..a8fc0295109a 100644
> --- a/linux-user/openrisc/syscall_nr.h
> +++ b/linux-user/openrisc/syscall_nr.h
> @@ -318,7 +318,11 @@
>  #define TARGET_NR_fsmount 432
>  #define TARGET_NR_fspick 433
>  #define TARGET_NR_pidfd_open 434
> -#define TARGET_NR_syscalls 436
> +#define TARGET_NR_clone3 435
> +#define TARGET_NR_close_range 436
> +#define TARGET_NR_openat2 437
> +#define TARGET_NR_pidfd_getfd 438
> +#define TARGET_NR_faccessat2 439
> +#define TARGET_NR_syscalls 440
>
>  #endif /* LINUX_USER_OPENRISC_SYSCALL_NR_H */
> -
> diff --git a/linux-user/riscv/syscall32_nr.h b/linux-user/riscv/syscall32_nr.h
> index 4fef73e954da..079b804daef5 100644
> --- a/linux-user/riscv/syscall32_nr.h
> +++ b/linux-user/riscv/syscall32_nr.h
> @@ -1,5 +1,7 @@
>  /*
>   * This file contains the system call numbers.
> + * Do not modify.
> + * This file is generated by scripts/gensyscalls.sh
>   */
>  #ifndef LINUX_USER_RISCV_SYSCALL32_NR_H
>  #define LINUX_USER_RISCV_SYSCALL32_NR_H
> @@ -290,6 +292,10 @@
>  #define TARGET_NR_fspick 433
>  #define TARGET_NR_pidfd_open 434
>  #define TARGET_NR_clone3 435
> -#define TARGET_NR_syscalls 436
> +#define TARGET_NR_close_range 436
> +#define TARGET_NR_openat2 437
> +#define TARGET_NR_pidfd_getfd 438
> +#define TARGET_NR_faccessat2 439
> +#define TARGET_NR_syscalls 440
>
>  #endif /* LINUX_USER_RISCV_SYSCALL32_NR_H */
> diff --git a/linux-user/riscv/syscall64_nr.h b/linux-user/riscv/syscall64_nr.h
> index cc82f3244f55..d54224ccec64 100644
> --- a/linux-user/riscv/syscall64_nr.h
> +++ b/linux-user/riscv/syscall64_nr.h
> @@ -1,5 +1,7 @@
>  /*
>   * This file contains the system call numbers.
> + * Do not modify.
> + * This file is generated by scripts/gensyscalls.sh
>   */
>  #ifndef LINUX_USER_RISCV_SYSCALL64_NR_H
>  #define LINUX_USER_RISCV_SYSCALL64_NR_H
> @@ -296,6 +298,10 @@
>  #define TARGET_NR_fspick 433
>  #define TARGET_NR_pidfd_open 434
>  #define TARGET_NR_clone3 435
> -#define TARGET_NR_syscalls 436
> +#define TARGET_NR_close_range 436
> +#define TARGET_NR_openat2 437
> +#define TARGET_NR_pidfd_getfd 438
> +#define TARGET_NR_faccessat2 439
> +#define TARGET_NR_syscalls 440
>
>  #endif /* LINUX_USER_RISCV_SYSCALL64_NR_H */
> diff --git a/scripts/gensyscalls.sh b/scripts/gensyscalls.sh
> index b7b8456f6312..bba9fb052c47 100755
> --- a/scripts/gensyscalls.sh
> +++ b/scripts/gensyscalls.sh
> @@ -86,8 +86,7 @@ generate_syscall_nr()
>      read_includes $arch $bits | filter_defines | rename_defines | \
>                                  evaluate_values | sort -n -k 3
>      echo
> -    echo "#endif /* ${guard} */"
> -    echo) > "$file"
> +    echo "#endif /* ${guard} */") > "$file"
>  }
>
>  mkdir "$TMP/asm"
> --
> 2.26.2
>
>

