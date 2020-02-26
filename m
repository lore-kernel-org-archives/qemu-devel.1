Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B22C4BA21
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 19:41:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE0D624670
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 19:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VuEsNcAo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE0D624670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j72Z6-0005Ow-RH
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 14:41:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56202)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1j72Xk-0004Qt-1I
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 14:40:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1j72Xi-0006RH-H1
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 14:40:27 -0500
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:38444)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1j72Xh-0006LT-CS; Wed, 26 Feb 2020 14:40:26 -0500
Received: by mail-lj1-x242.google.com with SMTP id w1so443740ljh.5;
 Wed, 26 Feb 2020 11:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=7UWeIBoPKSYywb3sFB8Gd4kZL5c+IuRG3eWBXLP0dvA=;
 b=VuEsNcAohsx5+60vyPeXHPuIxbXZkDVsA00pzFHFnp25vFaFOAG2Srs17GNVDLJvsS
 K7Xj/RWsNff7KFGRjoJDbS3r8fXEOj3Ixne6FoRNZODfmQfyg0qTbdcYWBues0HLOZrz
 3SOEpPqrrFwUrkSA6lUbVR2zARoovZh0clV8Nixwq85bUoWPD4fxgQ1I2Z60DMN+UOPi
 vtIdflEocNr9Wf72lftvi5agG5P5HQrI2e7sa5/oeB+7Bwu2pzLGo1l8ChV/pjf+q/CG
 KUqZbHfjlpGjwvyAU5jRT6esXZzVivkHaqAlcjqNltZGmhIF7wfHUztmPwDJB8HPG+Vm
 Vgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=7UWeIBoPKSYywb3sFB8Gd4kZL5c+IuRG3eWBXLP0dvA=;
 b=k7N8WKqB6VrxA+GCp2caH+bycz73S61OTfLFpoRLWSnsNIAxcW6atkbnQ+5vO6A3ZV
 M74sSWcuz6T6vvBnPPJ8sMPehNTGwYIsQbbYoZd+V4g3l9mwgxpJfSnwc3gtWWmk+0RC
 bZM4YbPRy4ULUXEde5iLBsh4+86X7CEduLa54GZZjrb9KVPqptfT0cSLTvgl/9mCSMBp
 lEFV25JXTiz3lNpfchugum1SnwPmk/+qjnIb/o0aSf2B8eb6DeoWO++a7SdcahF484if
 z1wh1SqkaHXe46htw+kzBIQYV0zXVAbnt60PlIAlJWnIktN3XUSRPRMzX3iBZVZD1TKj
 U8xQ==
X-Gm-Message-State: ANhLgQ1upr2EeP99zvuQiEI94VowDfkWTaBzlC2rZ08r581fGNuarRTP
 Mymu0yFaIEpDD7HlY99lEmxCtddoULnRZVdWH5M=
X-Google-Smtp-Source: ADFU+vuOaotcmA4U5rnBdimVgzm3XVPuTEFCNHgxUULL4S2zymB+tiQVAgC5yeEHr5jEu3ycTTchtyZNvvkEh/t8Ocs=
X-Received: by 2002:a2e:7818:: with SMTP id t24mr320943ljc.195.1582746023370; 
 Wed, 26 Feb 2020 11:40:23 -0800 (PST)
MIME-Version: 1.0
References: <cover.1582586444.git.alistair.francis@wdc.com>
 <85f33856ee6f32125e5c81a9561346b28b340a3e.1582586444.git.alistair.francis@wdc.com>
 <24431d59-b535-97d4-95d7-fe4401e10787@vivier.eu>
In-Reply-To: <24431d59-b535-97d4-95d7-fe4401e10787@vivier.eu>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 26 Feb 2020 11:32:45 -0800
Message-ID: <CAKmqyKObXNXj2jsMYTvAL-eHS43Wb5upwq6mHeHo7q-4Pr4W7g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] linux-user/riscv: Update the syscall_nr's to the
 5.5 kernel
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 25, 2020 at 3:50 AM Laurent Vivier <laurent@vivier.eu> wrote:
>
> Le 25/02/2020 =C3=A0 00:21, Alistair Francis a =C3=A9crit :
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  linux-user/riscv/syscall32_nr.h | 314 ++++++++++++++++++++++++++++++++
> >  linux-user/riscv/syscall64_nr.h | 303 ++++++++++++++++++++++++++++++
> >  linux-user/riscv/syscall_nr.h   | 294 +-----------------------------
> >  3 files changed, 619 insertions(+), 292 deletions(-)
> >  create mode 100644 linux-user/riscv/syscall32_nr.h
> >  create mode 100644 linux-user/riscv/syscall64_nr.h
> >
> > diff --git a/linux-user/riscv/syscall32_nr.h b/linux-user/riscv/syscall=
32_nr.h
> > new file mode 100644
> > index 0000000000..c3bf5930d0
> > --- /dev/null
> > +++ b/linux-user/riscv/syscall32_nr.h
> > @@ -0,0 +1,314 @@
> > +/*
> > + * Syscall numbers from asm-generic for RV32.
> > + */
> > +
> > +#ifndef LINUX_USER_RISCV_SYSCALL32_NR_H
> > +#define LINUX_USER_RISCV_SYSCALL32_NR_H
> > +
> > +#define TARGET_NR_io_setup 0
> > +#define TARGET_NR_io_destroy 1
> > +#define TARGET_NR_io_submit 2
> > +#define TARGET_NR_io_cancel 3
> > +#define TARGET_NR_setxattr 5
> > +#define TARGET_NR_lsetxattr 6
> > +#define TARGET_NR_fsetxattr 7
> > +#define TARGET_NR_getxattr 8
> > +#define TARGET_NR_lgetxattr 9
> > +#define TARGET_NR_fgetxattr 10
> > +#define TARGET_NR_listxattr 11
> > +#define TARGET_NR_llistxattr 12
> > +#define TARGET_NR_flistxattr 13
> > +#define TARGET_NR_removexattr 14
> > +#define TARGET_NR_lremovexattr 15
> > +#define TARGET_NR_fremovexattr 16
> > +#define TARGET_NR_getcwd 17
> > +#define TARGET_NR_lookup_dcookie 18
> > +#define TARGET_NR_eventfd2 19
> > +#define TARGET_NR_epoll_create1 20
> > +#define TARGET_NR_epoll_ctl 21
> > +#define TARGET_NR_epoll_pwait 22
> > +#define TARGET_NR_dup 23
> > +#define TARGET_NR_dup3 24
> > +#define TARGET_NR_fcntl64 25
> > +#define TARGET_NR_inotify_init1 26
> > +#define TARGET_NR_inotify_add_watch 27
> > +#define TARGET_NR_inotify_rm_watch 28
> > +#define TARGET_NR_ioctl 29
> > +#define TARGET_NR_ioprio_set 30
> > +#define TARGET_NR_ioprio_get 31
> > +#define TARGET_NR_flock 32
> > +#define TARGET_NR_mknodat 33
> > +#define TARGET_NR_mkdirat 34
> > +#define TARGET_NR_unlinkat 35
> > +#define TARGET_NR_symlinkat 36
> > +#define TARGET_NR_linkat 37
> > +#define TARGET_NR_umount2 39
> > +#define TARGET_NR_mount 40
> > +#define TARGET_NR_pivot_root 41
> > +#define TARGET_NR_nfsservctl 42
> > +#define TARGET_NR_statfs 43
> > +#define TARGET_NR_fstatfs 44
> > +#define TARGET_NR_truncate 45
> > +#define TARGET_NR_ftruncate 46
>
> For riscv32, it's the 64bit version name to use:
>
> #define TARGET_NR_statfs64 43
> #define TARGET_NR_fstatfs64 44
> #define TARGET_NR_truncate64 45
> #define TARGET_NR_ftruncate64 46
> (and below)

Fixed! Your script also updated this :)

>
> because:
>
> include/uapi/asm-generic/unistd.h
>
> #if __BITS_PER_LONG =3D=3D 64 && !defined(__SYSCALL_COMPAT)
> ...
> #else
> #define __NR_fcntl64 __NR3264_fcntl
> #define __NR_statfs64 __NR3264_statfs
> #define __NR_fstatfs64 __NR3264_fstatfs
> #define __NR_truncate64 __NR3264_truncate
> #define __NR_ftruncate64 __NR3264_ftruncate
> #define __NR_llseek __NR3264_lseek
> #define __NR_sendfile64 __NR3264_sendfile
> #if defined(__ARCH_WANT_NEW_STAT) || defined(__ARCH_WANT_STAT64)
> #define __NR_fstatat64 __NR3264_fstatat
> #define __NR_fstat64 __NR3264_fstat
> #endif
> ...
>
> arch/riscv/include/uapi/asm/unistd.h
> #define __ARCH_WANT_NEW_STAT
>
> arch/riscv/include/uapi/asm/bitsperlong.h
>
> #define __BITS_PER_LONG (__SIZEOF_POINTER__ * 8)
>
> ...
> > +#define TARGET_NR_getdents64 61
> > +#define TARGET_NR__llseek 62
>
> TARGET_NR_llseek
>
> > +#define TARGET_NR_read 63
> > +#define TARGET_NR_write 64
> > +#define TARGET_NR_readv 65
> > +#define TARGET_NR_writev 66
> > +#define TARGET_NR_pread64 67
> > +#define TARGET_NR_pwrite64 68
> > +#define TARGET_NR_preadv 69
> > +#define TARGET_NR_pwritev 70
> > +#define TARGET_NR_sendfile 71
>
> TARGET_NR_sendfile64
>
> > +#define TARGET_NR_signalfd4 74
> > +#define TARGET_NR_vmsplice 75
> > +#define TARGET_NR_splice 76
> > +#define TARGET_NR_tee 77
> > +#define TARGET_NR_readlinkat 78
> > +#define TARGET_NR_newfstatat 79
> > +#define TARGET_NR_fstat 80
>
> #define TARGET_NR_fstatat64 79
> #define TARGET_NR_fstat64 80
>
> ...
> > +#define TARGET_NR_sethostname 161
> > +#define TARGET_NR_setdomainname 162
>
> #define TARGET_NR_getrlimit 163
> #define TARGET_NR_setrlimit 164
>
> because
>
> include/uapi/asm-generic/unistd.h
>
> #ifdef __ARCH_WANT_SET_GET_RLIMIT
> /* getrlimit and setrlimit are superseded with prlimit64 */
> #define __NR_getrlimit 163
> __SC_COMP(__NR_getrlimit, sys_getrlimit, compat_sys_getrlimit)
> #define __NR_setrlimit 164
> __SC_COMP(__NR_setrlimit, sys_setrlimit, compat_sys_setrlimit)
> #endif
>
> arch/riscv/include/uapi/asm/unistd.h
>
> #define __ARCH_WANT_SET_GET_RLIMIT
>
> ...
> > +#define TARGET_NR_arch_specific_syscall 244
> > +#define TARGET_NR_riscv_flush_icache TARGET_NR_arch_specific_syscall +=
 15
>
> It should be good to keep parenthesis around the declaration:
>
> (TARGET_NR_arch_specific_syscall + 15)

I added brackets and fixed everything above.

>
> ...
>
> I think you can remove following defintion as they should be translated
> by the target glibc.

glibc won't be exposing these externally, the current plan is just to
use this internally to glibc.

Alistair


>
> > +/*
> > + * Alias some of the older pre 64-bit time_t syscalls to the 64-bit
> > + * ones for RV32. This is based on the list used by glibc.
> > + */
> > +#define TARGET_NR_futex TARGET_NR_futex_time64
> > +#define TARGET_NR_rt_sigtimedwait TARGET_NR_rt_sigtimedwait_time64
> > +#define TARGET_NR_ppoll TARGET_NR_ppoll_time64
> > +#define TARGET_NR_utimensat TARGET_NR_utimensat_time64
> > +#define TARGET_NR_pselect6 TARGET_NR_pselect6_time64
> > +#define TARGET_NR_recvmmsg TARGET_NR_recvmmsg_time64
> > +#define TARGET_NR_semtimedop TARGET_NR_semtimedop_time64
> > +#define TARGET_NR_mq_timedreceive TARGET_NR_mq_timedreceive_time64
> > +#define TARGET_NR_mq_timedsend TARGET_NR_mq_timedsend_time64
> > +#define TARGET_NR_clock_getres TARGET_NR_clock_getres_time64
> > +#define TARGET_NR_timerfd_settime TARGET_NR_timerfd_settime64
> > +#define TARGET_NR_timerfd_gettime TARGET_NR_timerfd_gettime64
> > +#define TARGET_NR_sched_rr_get_interval TARGET_NR_sched_rr_get_interva=
l_time64
> > +#define TARGET_NR_clock_adjtime TARGET_NR_clock_adjtime64
> > +
> > +#endif
> > diff --git a/linux-user/riscv/syscall64_nr.h b/linux-user/riscv/syscall=
64_nr.h
> > new file mode 100644
> > index 0000000000..b58364b570
> > --- /dev/null
> > +++ b/linux-user/riscv/syscall64_nr.h
>
> syscall64_nr.h is correct.
>
> Thanks,
> Laurent
>

