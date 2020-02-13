Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFD8C352A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 01:27:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B9A121739
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 01:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bP2c/OFP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B9A121739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j23Hz-0005zv-9G
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 20:27:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46429)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j23HD-0005UW-4T
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 20:26:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j23HB-0000xH-4o
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 20:26:47 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:45527)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1j23HA-0000vu-Ta
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 20:26:45 -0500
Received: by mail-ot1-x342.google.com with SMTP id 59so3967755otp.12
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 17:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=iaIAo7pLbscNcNUxgJc9kyQMDr0b/YMJZNwRma4S4H8=;
 b=bP2c/OFPenlrPyAnTZ7ABV+10xl6XRhIn0xiUfcEs/q4cKuDbpYJnWKQd6DMusq4H/
 UV9EWOr0K7GMhXtt5VQ7oRhkO55bAD8O/aq2KpfIyWAmE+UwjhVzVkpkxLTMOzjjmSt5
 W4nq5OZW3eTrDr4ly1FogDfwOxClteX+0q7Z3ObHBx4yE8xfUP9fb0iaIuFaHs8HH/45
 FGIZdEgbGODu7PCKNYBuS4C86hP5QlIvJ+eW1Of4+PlbWIj1uNHNqlN267tg1F9ZV/Yq
 MCWzyVtVtjSFzt6zOjzNlL1LbTr1EIbZOGpe782kgs3rR8d5Z4BWorMD829wqc5AwY32
 oz6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=iaIAo7pLbscNcNUxgJc9kyQMDr0b/YMJZNwRma4S4H8=;
 b=KKF34Cu4bSrMSCvYKc9xQq54v+DT7fRjoTmXQ6nk5CiEg6oEDoXs6D0G0k/ZZKbFg0
 DBF7EEAJr2AF4bsZS5YL6YBmeLxDCpfCbvrmN1Mz4arkgv7TaTeHzSSARdYE7aIrpsq2
 xeMZDmIwQTSp5chPKplkDrTOHGF8LB74vBkm4VCys48/pzAfZBiG3xFVHYG8xrd/oWYS
 SYzQnpUdJG5WXUy+zRaPlbtS1HSiloTXxwvE1JOeQRz+QHSyzeMl30TTqdNiQYEHYgQh
 G+dQWs2twf4Ez2pm/v8ab/9DWaNeexYZ2M2e4Zivoezi/carPmfGBgZZJzNMVKY9D/5Q
 srlA==
X-Gm-Message-State: APjAAAUpNyOBmO1o2jPsxkDrUG7/LQfn9WT5JLFNaEjzHXzvBhPKFNUk
 XwTQhjOkiTudBK3Tan9aZW6V0Oq5krZb1K/ciUE=
X-Google-Smtp-Source: APXvYqwHSFxN77pqnePKslPQ8xT2x8zh9J738Oz95jBJ0q9MGaVgqJTmO37sY05J5apmCzPYL4i+TkdMkNLVJlBiFCM=
X-Received: by 2002:a05:6830:1042:: with SMTP id
 b2mr11437776otp.306.1581557203851; 
 Wed, 12 Feb 2020 17:26:43 -0800 (PST)
MIME-Version: 1.0
References: <1580818058-16159-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1580818058-16159-6-git-send-email-aleksandar.markovic@rt-rk.com>
 <92f1a3ae-ed61-693f-f619-6a63c39e66a2@vivier.eu>
In-Reply-To: <92f1a3ae-ed61-693f-f619-6a63c39e66a2@vivier.eu>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 13 Feb 2020 02:26:32 +0100
Message-ID: <CAL1e-=h21X7tv4mwSQ7zfE-rM1VcR9Fg2ZZJqhhBh9B1d+Rxyw@mail.gmail.com>
Subject: Re: [PATCH 5/9] linux-user: mips: Update syscall numbers to kernel
 5.5 level
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 12, 2020 at 10:10 PM Laurent Vivier <laurent@vivier.eu> wrote:
>
> Le 04/02/2020 =C3=A0 13:07, Aleksandar Markovic a =C3=A9crit :
> > From: Aleksandar Markovic <amarkovic@wavecomp.com>
> >
> > Update mips syscall numbers based on Linux kernel tag v5.5.
> >
> > CC: Aurelien Jarno <aurelien@aurel32.net>
> > CC: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
> > Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> > ---
> >  linux-user/mips/cpu_loop.c     | 78 ++++++++++++++++++++++++++++++++++=
+++++++-
> >  linux-user/mips/syscall_nr.h   | 45 ++++++++++++++++++++++++
> >  linux-user/mips64/syscall_nr.h | 13 +++++++
> >  3 files changed, 135 insertions(+), 1 deletion(-)
> >
> > diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
> > index 39915b3..b81479b 100644
> > --- a/linux-user/mips/cpu_loop.c
> > +++ b/linux-user/mips/cpu_loop.c
> > @@ -25,8 +25,9 @@
> >  #include "internal.h"
> >
> >  # ifdef TARGET_ABI_MIPSO32
> > +#  define MIPS_SYSCALL_NUMBER_UNUSED -1
> >  #  define MIPS_SYS(name, args) args,
> > -static const uint8_t mips_syscall_args[] =3D {
> > +static const int8_t mips_syscall_args[] =3D {
> >          MIPS_SYS(sys_syscall    , 8)    /* 4000 */
> >          MIPS_SYS(sys_exit       , 1)
> >          MIPS_SYS(sys_fork       , 0)
> > @@ -390,6 +391,75 @@ static const uint8_t mips_syscall_args[] =3D {
> >          MIPS_SYS(sys_copy_file_range, 6) /* 360 */
> >          MIPS_SYS(sys_preadv2, 6)
> >          MIPS_SYS(sys_pwritev2, 6)
> > +        MIPS_SYS(sys_pkey_mprotect, 4)
> > +        MIPS_SYS(sys_pkey_alloc, 2)
> > +        MIPS_SYS(sys_pkey_free, 1)                 /* 365 */
> > +        MIPS_SYS(sys_statx, 5)
> > +        MIPS_SYS(sys_rseq, 4)
> > +        MIPS_SYS(sys_io_pgetevents, 6)
> > +        MIPS_SYSCALL_NUMBER_UNUSED,
> > +        MIPS_SYSCALL_NUMBER_UNUSED,                /* 370 */
> > +        MIPS_SYSCALL_NUMBER_UNUSED,
> > +        MIPS_SYSCALL_NUMBER_UNUSED,
> > +        MIPS_SYSCALL_NUMBER_UNUSED,
> > +        MIPS_SYSCALL_NUMBER_UNUSED,
> > +        MIPS_SYSCALL_NUMBER_UNUSED,                /* 375 */
> > +        MIPS_SYSCALL_NUMBER_UNUSED,
> > +        MIPS_SYSCALL_NUMBER_UNUSED,
> > +        MIPS_SYSCALL_NUMBER_UNUSED,
> > +        MIPS_SYSCALL_NUMBER_UNUSED,
> > +        MIPS_SYSCALL_NUMBER_UNUSED,                /* 380 */
> > +        MIPS_SYSCALL_NUMBER_UNUSED,
> > +        MIPS_SYSCALL_NUMBER_UNUSED,
> > +        MIPS_SYSCALL_NUMBER_UNUSED,
> > +        MIPS_SYSCALL_NUMBER_UNUSED,
> > +        MIPS_SYSCALL_NUMBER_UNUSED,                /* 385 */
> > +        MIPS_SYSCALL_NUMBER_UNUSED,
> > +        MIPS_SYSCALL_NUMBER_UNUSED,
> > +        MIPS_SYSCALL_NUMBER_UNUSED,
> > +        MIPS_SYSCALL_NUMBER_UNUSED,
> > +        MIPS_SYSCALL_NUMBER_UNUSED,                /* 390 */
> > +        MIPS_SYSCALL_NUMBER_UNUSED,
> > +        MIPS_SYSCALL_NUMBER_UNUSED,
> > +        MIPS_SYS(sys_semget, 3)
> > +        MIPS_SYS(sys_semctl, 4)
> > +        MIPS_SYS(sys_shmget, 3)                    /* 395 */
> > +        MIPS_SYS(sys_shmctl, 3)
> > +        MIPS_SYS(sys_shmat, 3)
> > +        MIPS_SYS(sys_shmdt, 1)
> > +        MIPS_SYS(sys_msgget, 2)
> > +        MIPS_SYS(sys_msgsnd, 4)                    /* 400 */
> > +        MIPS_SYS(sys_msgrcv, 5)
> > +        MIPS_SYS(sys_msgctl, 3)
> > +        MIPS_SYS(sys_timer_gettime64, 2)
> > +        MIPS_SYS(sys_timer_settime64, 4)
> > +        MIPS_SYS(sys_timerfd_gettime64, 2)         /* 410 */
> > +        MIPS_SYS(sys_timerfd_settime64, 4)
>
> These have different names in the kernel:
>
> clock_gettime64                  403
> clock_settime64                  404
> clock_adjtime64                  405
> clock_getres_time64              406
> clock_nanosleep_time64           407
>

In fact, the whole range 403 - 407 was missing, names are good for
408-411, and all following them.

> > +        MIPS_SYS(sys_utimensat_time64, 4)
> > +        MIPS_SYS(sys_pselect6_time64, 6)
> > +        MIPS_SYS(sys_ppoll_time64, 5)
> > +        MIPS_SYSCALL_NUMBER_UNUSED,                /* 415 */
> > +        MIPS_SYS(sys_io_pgetevents_time64, 6)
> > +        MIPS_SYS(sys_recvmmsg_time64, 5)
> > +        MIPS_SYS(sys_mq_timedsend_time64, 5)
> > +        MIPS_SYS(sys_mq_timedreceive_time64, 5)
> > +        MIPS_SYS(sys_semtimedop_time64, 4)         /* 420 */
> > +        MIPS_SYS(sys_rt_sigtimedwait_time64, 4)
> > +        MIPS_SYS(sys_futex_time64, 6)
> > +        MIPS_SYS(sys_sched_rr_get_interval_time64, 2)
> > +        MIPS_SYS(sys_pidfd_send_signal, 4)
> > +        MIPS_SYS(sys_io_uring_setup, 2)            /* 425 */
> > +        MIPS_SYS(sys_io_uring_enter, 6)
> > +        MIPS_SYS(sys_io_uring_register, 4)
> > +        MIPS_SYS(sys_open_tree, 3)
> > +        MIPS_SYS(sys_move_mount, 5)
> > +        MIPS_SYS(sys_fsopen, 2)                    /* 430 */
> > +        MIPS_SYS(sys_fsconfig, 5)
> > +        MIPS_SYS(sys_fsmount, 3)
> > +        MIPS_SYS(sys_fspick, 3)
> > +        MIPS_SYS(sys_pidfd_open, 2)
> > +        MIPS_SYS(sys_clone3, 2)                    /* 435 */
>
> This comes from arch/mips/kernel/syscalls/syscall_o32.tbl for the
> syscall number.
>
> Where do you find the number of the arguments in the kernel?
>

From strace repository:

https://github.com/strace/strace/blob/master/linux/syscallent-common.h
https://github.com/strace/strace/blob/master/linux/syscallent-common-32.h

> > +
> >  };
> >  #  undef MIPS_SYS
> >  # endif /* O32 */
> > @@ -447,8 +517,14 @@ void cpu_loop(CPUMIPSState *env)
> >  # ifdef TARGET_ABI_MIPSO32
> >              syscall_num =3D env->active_tc.gpr[2] - 4000;
> >              if (syscall_num >=3D sizeof(mips_syscall_args)) {
> > +                /* syscall_num is larger that any defined for MIPS O32=
 */
> > +                ret =3D -TARGET_ENOSYS;
> > +            } else if (mips_syscall_args[syscall_num] =3D=3D
> > +                       MIPS_SYSCALL_NUMBER_UNUSED) {
> > +                /* syscall_num belongs to the range not defined for MI=
PS O32 */
> >                  ret =3D -TARGET_ENOSYS;
> >              } else {
> > +                /* syscall_num is valid */
> >                  int nb_args;
> >                  abi_ulong sp_reg;
> >                  abi_ulong arg5 =3D 0, arg6 =3D 0, arg7 =3D 0, arg8 =3D=
 0;
> > diff --git a/linux-user/mips/syscall_nr.h b/linux-user/mips/syscall_nr.=
h
> > index 7fa7fa5..0be3af1 100644
> > --- a/linux-user/mips/syscall_nr.h
> > +++ b/linux-user/mips/syscall_nr.h
> > @@ -376,5 +376,50 @@
> >  #define TARGET_NR_statx                 (TARGET_NR_Linux + 366)
> >  #define TARGET_NR_rseq                  (TARGET_NR_Linux + 367)
> >  #define TARGET_NR_io_pgetevents         (TARGET_NR_Linux + 368)
> > +/* room for arch specific calls */
> > +#define TARGET_NR_semget                (TARGET_NR_Linux + 393)
> > +#define TARGET_NR_semctl                (TARGET_NR_Linux + 394)
> > +#define TARGET_NR_shmget                (TARGET_NR_Linux + 395)
> > +#define TARGET_NR_shmctl                (TARGET_NR_Linux + 396)
> > +#define TARGET_NR_shmat                 (TARGET_NR_Linux + 397)
> > +#define TARGET_NR_shmdt                 (TARGET_NR_Linux + 398)
> > +#define TARGET_NR_msgget                (TARGET_NR_Linux + 399)
> > +#define TARGET_NR_msgsnd                (TARGET_NR_Linux + 400)
> > +#define TARGET_NR_msgrcv                (TARGET_NR_Linux + 401)
> > +#define TARGET_NR_msgctl                (TARGET_NR_Linux + 402)
> > +/* 403-423 common for 32-bit archs */
> > +#define TARGET_NR_clock_gettime64              (TARGET_NR_Linux + 403)
> > +#define TARGET_NR_clock_settime64              (TARGET_NR_Linux + 404)
> > +#define TARGET_NR_clock_adjtime64              (TARGET_NR_Linux + 405)
> > +#define TARGET_NR_clock_getres_time64          (TARGET_NR_Linux + 406)
> > +#define TARGET_NR_clock_nanosleep_time64       (TARGET_NR_Linux + 407)
> > +#define TARGET_NR_timer_gettime64              (TARGET_NR_Linux + 408)
> > +#define TARGET_NR_timer_settime64              (TARGET_NR_Linux + 409)
> > +#define TARGET_NR_timerfd_gettime64            (TARGET_NR_Linux + 410)
> > +#define TARGET_NR_timerfd_settime64            (TARGET_NR_Linux + 411)
> > +#define TARGET_NR_utimensat_time64             (TARGET_NR_Linux + 412)
> > +#define TARGET_NR_pselect6_time64              (TARGET_NR_Linux + 413)
> > +#define TARGET_NR_ppoll_time64                 (TARGET_NR_Linux + 414)
> > +#define TARGET_NR_io_pgetevents_time64         (TARGET_NR_Linux + 416)
> > +#define TARGET_NR_recvmmsg_time64              (TARGET_NR_Linux + 417)
> > +#define TARGET_NR_mq_timedsend_time64          (TARGET_NR_Linux + 418)
> > +#define TARGET_NR_mq_timedreceive_time64       (TARGET_NR_Linux + 419)
> > +#define TARGET_NR_semtimedop_time64            (TARGET_NR_Linux + 420)
> > +#define TARGET_NR_rt_sigtimedwait_time64       (TARGET_NR_Linux + 421)
> > +#define TARGET_NR_futex_time64                 (TARGET_NR_Linux + 422)
> > +#define TARGET_NR_sched_rr_get_interval_time64 (TARGET_NR_Linux + 423)
> > +/* 424 onwards common for all archs */
> > +#define TARGET_NR_pidfd_send_signal            (TARGET_NR_Linux + 424)
> > +#define TARGET_NR_io_uring_setup               (TARGET_NR_Linux + 425)
> > +#define TARGET_NR_io_uring_enter               (TARGET_NR_Linux + 426)
> > +#define TARGET_NR_io_uring_register            (TARGET_NR_Linux + 427)
> > +#define TARGET_NR_open_tree                    (TARGET_NR_Linux + 428)
> > +#define TARGET_NR_move_mount                   (TARGET_NR_Linux + 429)
> > +#define TARGET_NR_fsopen                       (TARGET_NR_Linux + 430)
> > +#define TARGET_NR_fsconfig                     (TARGET_NR_Linux + 431)
> > +#define TARGET_NR_fsmount                      (TARGET_NR_Linux + 432)
> > +#define TARGET_NR_fspick                       (TARGET_NR_Linux + 433)
> > +#define TARGET_NR_pidfd_open                   (TARGET_NR_Linux + 434)
> > +#define TARGET_NR_clone3                       (TARGET_NR_Linux + 435)
>
> These values come from linux/arch/mips/kernel/syscalls/syscall_o32.tbl
>
> >  #endif
> > diff --git a/linux-user/mips64/syscall_nr.h b/linux-user/mips64/syscall=
_nr.h
> > index db40f69..c86943a 100644
> > --- a/linux-user/mips64/syscall_nr.h
> > +++ b/linux-user/mips64/syscall_nr.h
> > @@ -674,6 +674,19 @@
> >  #define TARGET_NR_statx                 (TARGET_NR_Linux + 326)
> >  #define TARGET_NR_rseq                  (TARGET_NR_Linux + 327)
> >  #define TARGET_NR_io_pgetevents         (TARGET_NR_Linux + 328)
> > +/* 329 through 423 are reserved to sync up with other architectures */
> > +#define TARGET_NR_pidfd_send_signal     (TARGET_NR_Linux + 424)
> > +#define TARGET_NR_io_uring_setup        (TARGET_NR_Linux + 425)
> > +#define TARGET_NR_io_uring_enter        (TARGET_NR_Linux + 426)
> > +#define TARGET_NR_io_uring_register     (TARGET_NR_Linux + 427)
> > +#define TARGET_NR_open_tree             (TARGET_NR_Linux + 428)
> > +#define TARGET_NR_move_mount            (TARGET_NR_Linux + 429)
> > +#define TARGET_NR_fsopen                (TARGET_NR_Linux + 430)
> > +#define TARGET_NR_fsconfig              (TARGET_NR_Linux + 431)
> > +#define TARGET_NR_fsmount               (TARGET_NR_Linux + 432)
> > +#define TARGET_NR_fspick                (TARGET_NR_Linux + 433)
> > +#define TARGET_NR_pidfd_open            (TARGET_NR_Linux + 434)
> > +#define TARGET_NR_clone3                (TARGET_NR_Linux + 435)
> >  #endif
>
> These values come from linux/arch/mips/kernel/syscalls/syscall_n64.tbl
>
> So why don't you update the value for
> arch/mips/kernel/syscalls/syscall_n32.tbl (also in mips64/syscall_nr.h,
> enclosed in TARGET_ABI32)?
>
> clock_gettime64                  403
> clock_settime64                  404
> clock_adjtime64                  405
> clock_getres_time64              406
> clock_nanosleep_time64           407
> timer_gettime64                  408
> timer_settime64                  409
> timerfd_gettime64                410
> timerfd_settime64                411
> utimensat_time64                 412
> pselect6_time64                  413
> ppoll_time64                     414
> io_pgetevents_time64             416
> recvmmsg_time64                  417
> mq_timedsend_time64              418
> mq_timedreceive_time64           419
> semtimedop_time64                420
> rt_sigtimedwait_time64           421
> futex_time64                     422
> sched_rr_get_interval_time64     423
> pidfd_send_signal                424
> io_uring_setup                   425
> io_uring_enter                   426
> io_uring_register                427
> open_tree                        428
> move_mount                       429
> fsopen                           430
> fsconfig                         431
> fsmount                          432
> fspick                           433
> pidfd_open                       434
> clone3                           435
>

I am going to add all this.

I'll send v2 shortly.

Thanks,
Aleksandar

> Thanks,
> Laurent
>

