Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,HTML_OBFUSCATE_05_10,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B64C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 08:28:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 038F82084F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 08:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7UGMJH5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 038F82084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iURXH-0006P5-5S
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 03:28:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39703)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iURWQ-0005r0-Al
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 03:27:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iURWN-0002ca-Q2
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 03:27:34 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:43487)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iURWN-0002aE-Hi
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 03:27:31 -0500
Received: by mail-oi1-x243.google.com with SMTP id l20so14026996oie.10
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 00:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=oLisnJHkB3c96poit4QsT+7WWR8fVw6R+X36k6LQWJU=;
 b=P7UGMJH58scZClQouUlALBKErEmNi9uzlRRDn777Okj6msjbrOSDovla3xW/5wqBq0
 n+/DglBPUE5nSTlEXOOuRbQttJLDCUKdXjCrKzaTZYtynZrYWHjcxkrYHR2W2QQpURVI
 qg5EhaU4JUTBLjch2ie+dJroLTruLJ0da4yHlli3Y2/kAIyGt/mj5qc/y+6/PUhcVPZt
 nN7joa1+N+Yvp1occINGBB+fwZBVDlDR8DGNUFMijouPTRBL+VWfXEQr9iOHVKFqcN2K
 zUkklW4I90OsLFCSr9gfF0xxk486jK5qoykTapGJq1i1W36WQcPh4EGMb4iaWf98T1fs
 TxHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=oLisnJHkB3c96poit4QsT+7WWR8fVw6R+X36k6LQWJU=;
 b=TH/NQxD5vkKbToCb7V+Fi0kgKOC8KitUykmuU2PJFsAa1jpt1++3vw980tac8vNXoV
 4dkdDyL000mONfG5Kzs2uOx/u6z1zO2EXGHw2NTHau8HOFslC1sXBwyEB/ya582QY9WR
 vQilWKDml2U6XGOG0CJXU/mwk9ukeOEY89xKyC2b952faDKIwXnNkiTDY2FCsPi5bmTL
 ALdfZMoVZf7trhj6vAmz8Nj8d26IsEjauvB6GcS1vkxbX7mNBYYP9FDMfn1nCNPkpTRq
 xvT1yy8D658UsGe/bPNPm+tzOzuqqqjJBRJk5h7wXQ8K53Rq30x/3pEo6croet8xdRQI
 O+tw==
X-Gm-Message-State: APjAAAXSk7hqTiWzqjmrLfW3bEfv2aKnnR21SdFPfbSRXv0jv8QqjN1M
 NFEMbK3V34a8SR+WLRWecMXOTUYtZW25y6oI2tI=
X-Google-Smtp-Source: APXvYqwIWLkBpGbT0o6NhM/6gzIjfnKt636cp7GJ3H781yJBkntaHmv8wudgdHJLQpz9xXjFRz4qf9FIcZAXA7wu2tA=
X-Received: by 2002:aca:d17:: with SMTP id 23mr2962505oin.136.1573547250568;
 Tue, 12 Nov 2019 00:27:30 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6830:1391:0:0:0:0 with HTTP; Tue, 12 Nov 2019 00:27:30
 -0800 (PST)
In-Reply-To: <CAL1e-=iemtSNCyS1O6vfe1QL5EYP5tbKhZPAYJF8YQ4USPMFww@mail.gmail.com>
References: <7fc7a64e-cb52-fab6-5739-807b40be9c1d@ziglang.org>
 <66c80f5a-253a-722b-6f99-4e5b82078d1b@ziglang.org>
 <CAL1e-=iemtSNCyS1O6vfe1QL5EYP5tbKhZPAYJF8YQ4USPMFww@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 12 Nov 2019 09:27:30 +0100
Message-ID: <CAL1e-=hf6Z4cdZ-kfY=vg6fXWLX1Vo9R604AvDwxj7rFoXB2Tg@mail.gmail.com>
Subject: Re: [PATCH] enable translating statx syscalls on more arches
To: Andrew Kelley <andrew@ziglang.org>
Content-Type: multipart/alternative; boundary="000000000000e852a40597220441"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000e852a40597220441
Content-Type: text/plain; charset="UTF-8"

On Tuesday, November 12, 2019, Aleksandar Markovic <
aleksandar.m.mail@gmail.com> wrote:

>
>
> On Tuesday, November 12, 2019, Andrew Kelley <andrew@ziglang.org> wrote:
>
>> ping
>>
>> On 10/16/19 5:01 PM, Andrew Kelley wrote:
>> > Signed-off-by: Andrew Kelley <andrew@ziglang.org>
>> > ---
>> >  linux-user/aarch64/syscall_nr.h | 13 ++++++++++
>> >  linux-user/arm/syscall_nr.h     | 38 ++++++++++++++++++++++++++++
>> >  linux-user/i386/syscall_nr.h    | 43 ++++++++++++++++++++++++++++++++
>> >  linux-user/mips/cpu_loop.c      |  6 +++++
>> >  linux-user/ppc/syscall_nr.h     | 44 +++++++++++++++++++++++++++++++++
>> >  5 files changed, 144 insertions(+)
>> >
>
>
> Hello, Andrew.
>
> I support your change, but its title is not appropriate. It should have
> been "linux-user: Update system call code numbers for some targets" or
> similar. Also, you should have mentioned Laurent Vivier in cc. Also, are
> other targets updated? If not, I think you should include them as well.
> Additionally, what was the version (or commit number) of the kernel uou
> used as the reference?
>
> Thanks, Aleksandar
>
>
>
Forwarding to Laurent.

Laurent, can this or similar patch be integrated into 4.2? It can be viewed
as a bug fix, in a way.

Aleksandar


>
>
>> > diff --git a/linux-user/aarch64/syscall_nr.h
>> > b/linux-user/aarch64/syscall_nr.h
>> > index f00ffd7fb8..4e8d0bbb15 100644
>> > --- a/linux-user/aarch64/syscall_nr.h
>> > +++ b/linux-user/aarch64/syscall_nr.h
>> > @@ -276,5 +276,18 @@
>> >  #define TARGET_NR_membarrier 283
>> >  #define TARGET_NR_mlock2 284
>> >  #define TARGET_NR_copy_file_range 285
>> > +#define TARGET_NR_preadv2 286
>> > +#define TARGET_NR_pwritev2 287
>> > +#define TARGET_NR_pkey_mprotect 288
>> > +#define TARGET_NR_pkey_alloc 289
>> > +#define TARGET_NR_pkey_free 290
>> > +#define TARGET_NR_statx 291
>> > +#define TARGET_NR_io_pgetevents 292
>> > +#define TARGET_NR_rseq 293
>> > +#define TARGET_NR_kexec_file_load 294
>> > +#define TARGET_NR_pidfd_send_signal 424
>> > +#define TARGET_NR_io_uring_setup 425
>> > +#define TARGET_NR_io_uring_enter 426
>> > +#define TARGET_NR_io_uring_register 427
>> >
>> >  #endif
>> > diff --git a/linux-user/arm/syscall_nr.h b/linux-user/arm/syscall_nr.h
>> > index e7eda0d766..20afa3992a 100644
>> > --- a/linux-user/arm/syscall_nr.h
>> > +++ b/linux-user/arm/syscall_nr.h
>> > @@ -400,4 +400,42 @@
>> >  #define TARGET_NR_membarrier                   (389)
>> >  #define TARGET_NR_mlock2                       (390)
>> >
>> > +#define TARGET_NR_copy_file_range              (391)
>> > +#define TARGET_NR_preadv2                      (392)
>> > +#define TARGET_NR_pwritev2                     (393)
>> > +#define TARGET_NR_pkey_mprotect                (394)
>> > +#define TARGET_NR_pkey_alloc                   (395)
>> > +#define TARGET_NR_pkey_free                    (396)
>> > +#define TARGET_NR_statx                        (397)
>> > +#define TARGET_NR_rseq                         (398)
>> > +#define TARGET_NR_io_pgetevents                (399)
>> > +#define TARGET_NR_migrate_pages                (400)
>> > +
>> > +#define TARGET_NR_kexec_file_load              (401)
>> > +#define TARGET_NR_clock_gettime64              (403)
>> > +#define TARGET_NR_clock_settime64              (404)
>> > +#define TARGET_NR_clock_adjtime64              (405)
>> > +#define TARGET_NR_clock_getres_time64          (406)
>> > +#define TARGET_NR_clock_nanosleep_time64       (407)
>> > +#define TARGET_NR_timer_gettime64              (408)
>> > +#define TARGET_NR_timer_settime64              (409)
>> > +#define TARGET_NR_timerfd_gettime64            (410)
>> > +
>> > +#define TARGET_NR_timerfd_settime64            (411)
>> > +#define TARGET_NR_utimensat_time64             (412)
>> > +#define TARGET_NR_pselect6_time64              (413)
>> > +#define TARGET_NR_ppoll_time64                 (414)
>> > +#define TARGET_NR_io_pgetevents_time64         (416)
>> > +#define TARGET_NR_recvmmsg_time64              (417)
>> > +#define TARGET_NR_mq_timedsend_time64          (418)
>> > +#define TARGET_NR_mq_timedreceive_time64       (419)
>> > +#define TARGET_NR_semtimedop_time64            (420)
>> > +
>> > +#define TARGET_NR_rt_sigtimedwait_time64       (421)
>> > +#define TARGET_NR_futex_time64                 (422)
>> > +#define TARGET_NR_sched_rr_get_interval_time64 (423)
>> > +#define TARGET_NR_pidfd_send_signal            (424)
>> > +#define TARGET_NR_io_uring_setup               (425)
>> > +#define TARGET_NR_io_uring_enter               (426)
>> > +#define TARGET_NR_io_uring_register            (427)
>> >  #endif
>> > diff --git a/linux-user/i386/syscall_nr.h b/linux-user/i386/syscall_nr.h
>> > index 3234ec21c6..e641674daf 100644
>> > --- a/linux-user/i386/syscall_nr.h
>> > +++ b/linux-user/i386/syscall_nr.h
>> > @@ -383,5 +383,48 @@
>> >  #define TARGET_NR_membarrier            375
>> >  #define TARGET_NR_mlock2                376
>> >  #define TARGET_NR_copy_file_range       377
>> > +#define TARGET_NR_preadv2 378
>> > +#define TARGET_NR_pwritev2 379
>> > +#define TARGET_NR_pkey_mprotect 380
>> > +#define TARGET_NR_pkey_alloc 381
>> > +#define TARGET_NR_pkey_free 382
>> > +#define TARGET_NR_statx 383
>> > +#define TARGET_NR_arch_prctl 384
>> > +#define TARGET_NR_io_pgetevents 385
>> > +#define TARGET_NR_rseq 386
>> > +#define TARGET_NR_semget 393
>> > +#define TARGET_NR_semctl 394
>> > +#define TARGET_NR_shmget 395
>> > +#define TARGET_NR_shmctl 396
>> > +#define TARGET_NR_shmat 397
>> > +#define TARGET_NR_shmdt 398
>> > +#define TARGET_NR_msgget 399
>> > +#define TARGET_NR_msgsnd 400
>> > +#define TARGET_NR_msgrcv 401
>> > +#define TARGET_NR_msgctl 402
>> > +#define TARGET_NR_clock_gettime64 403
>> > +#define TARGET_NR_clock_settime64 404
>> > +#define TARGET_NR_clock_adjtime64 405
>> > +#define TARGET_NR_clock_getres_time64 406
>> > +#define TARGET_NR_clock_nanosleep_time64 407
>> > +#define TARGET_NR_timer_gettime64 408
>> > +#define TARGET_NR_timer_settime64 409
>> > +#define TARGET_NR_timerfd_gettime64 410
>> > +#define TARGET_NR_timerfd_settime64 411
>> > +#define TARGET_NR_utimensat_time64 412
>> > +#define TARGET_NR_pselect6_time64 413
>> > +#define TARGET_NR_ppoll_time64 414
>> > +#define TARGET_NR_io_pgetevents_time64 416
>> > +#define TARGET_NR_recvmmsg_time64 417
>> > +#define TARGET_NR_mq_timedsend_time64 418
>> > +#define TARGET_NR_mq_timedreceive_time64 419
>> > +#define TARGET_NR_semtimedop_time64 420
>> > +#define TARGET_NR_rt_sigtimedwait_time64 421
>> > +#define TARGET_NR_futex_time64 422
>> > +#define TARGET_NR_sched_rr_get_interval_time64 423
>> > +#define TARGET_NR_pidfd_send_signal 424
>> > +#define TARGET_NR_io_uring_setup 425
>> > +#define TARGET_NR_io_uring_enter 426
>> > +#define TARGET_NR_io_uring_register 427
>> >
>> >  #endif
>> > diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
>> > index 39915b3fde..044a00f531 100644
>> > --- a/linux-user/mips/cpu_loop.c
>> > +++ b/linux-user/mips/cpu_loop.c
>> > @@ -390,6 +390,12 @@ static const uint8_t mips_syscall_args[] = {
>> >          MIPS_SYS(sys_copy_file_range, 6) /* 360 */
>> >          MIPS_SYS(sys_preadv2, 6)
>> >          MIPS_SYS(sys_pwritev2, 6)
>> > +        MIPS_SYS(sys_pkey_mprotect, 4)
>> > +        MIPS_SYS(sys_pkey_alloc, 2)
>> > +        MIPS_SYS(sys_pkey_free, 1)
>> > +        MIPS_SYS(sys_statx, 5)
>> > +        MIPS_SYS(sys_rseq, 4)
>> > +        MIPS_SYS(sys_io_pgetevents, 5)
>> >  };
>> >  #  undef MIPS_SYS
>> >  # endif /* O32 */
>> > diff --git a/linux-user/ppc/syscall_nr.h b/linux-user/ppc/syscall_nr.h
>> > index b57a07b931..eea4056e3d 100644
>> > --- a/linux-user/ppc/syscall_nr.h
>> > +++ b/linux-user/ppc/syscall_nr.h
>> > @@ -398,5 +398,49 @@
>> >  #define TARGET_NR_shmget                376
>> >  #define TARGET_NR_shmctl                377
>> >  #define TARGET_NR_mlock2                378
>> > +#define TARGET_NR_copy_file_range       379
>> > +#define TARGET_NR_preadv2               380
>> > +#define TARGET_NR_pwritev2              381
>> > +#define TARGET_NR_kexec_file_load       382
>> > +#define TARGET_NR_statx                 383
>> > +#define TARGET_NR_pkey_alloc            384
>> > +#define TARGET_NR_pkey_free             385
>> > +#define TARGET_NR_pkey_mprotect         386
>> > +#define TARGET_NR_rseq                  387
>> > +#define TARGET_NR_io_pgetevents         388
>> > +#define TARGET_NR_semget                393
>> > +#define TARGET_NR_semctl                394
>> > +#define TARGET_NR_shmget                395
>> > +#define TARGET_NR_shmctl                396
>> > +#define TARGET_NR_shmat                 397
>> > +#define TARGET_NR_shmdt                 398
>> > +#define TARGET_NR_msgget                399
>> > +#define TARGET_NR_msgsnd                400
>> > +#define TARGET_NR_msgrcv                401
>> > +#define TARGET_NR_msgctl                402
>> > +#define TARGET_NR_clock_gettime64       403
>> > +#define TARGET_NR_clock_settime64       404
>> > +#define TARGET_NR_clock_adjtime64       405
>> > +#define TARGET_NR_clock_getres_time64   406
>> > +#define TARGET_NR_clock_nanosleep_time64 407
>> > +#define TARGET_NR_timer_gettime64       408
>> > +#define TARGET_NR_timer_settime64       409
>> > +#define TARGET_NR_timerfd_gettime64     410
>> > +#define TARGET_NR_timerfd_settime64     411
>> > +#define TARGET_NR_utimensat_time64      412
>> > +#define TARGET_NR_pselect6_time64       413
>> > +#define TARGET_NR_ppoll_time64          414
>> > +#define TARGET_NR_io_pgetevents_time64  416
>> > +#define TARGET_NR_recvmmsg_time64       417
>> > +#define TARGET_NR_mq_timedsend_time64   418
>> > +#define TARGET_NR_mq_timedreceive_time64 419
>> > +#define TARGET_NR_semtimedop_time64     420
>> > +#define TARGET_NR_rt_sigtimedwait_time64 421
>> > +#define TARGET_NR_futex_time64          422
>> > +#define TARGET_NR_sched_rr_get_interval_time64 423
>> > +#define TARGET_NR_pidfd_send_signal     424
>> > +#define TARGET_NR_io_uring_setup        425
>> > +#define TARGET_NR_io_uring_enter        426
>> > +#define TARGET_NR_io_uring_register     427
>> >
>> >  #endif
>> >
>>
>>
>>

--000000000000e852a40597220441
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Tuesday, November 12, 2019, Aleksandar Markovic &lt;<a href=3D"m=
ailto:aleksandar.m.mail@gmail.com">aleksandar.m.mail@gmail.com</a>&gt; wrot=
e:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex"><br><br>On Tuesday, November 12, 2019,=
 Andrew Kelley &lt;<a href=3D"mailto:andrew@ziglang.org" target=3D"_blank">=
andrew@ziglang.org</a>&gt; wrote:<br><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">ping<br=
>
<br>
On 10/16/19 5:01 PM, Andrew Kelley wrote:<br>
&gt; Signed-off-by: Andrew Kelley &lt;<a href=3D"mailto:andrew@ziglang.org"=
 target=3D"_blank">andrew@ziglang.org</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 linux-user/aarch64/syscall_nr.<wbr>h | 13 ++++++++++<br>
&gt;=C2=A0 linux-user/arm/syscall_nr.h=C2=A0 =C2=A0 =C2=A0| 38 ++++++++++++=
++++++++++++++++<br>
&gt;=C2=A0 linux-user/i386/syscall_nr.h=C2=A0 =C2=A0 | 43 +++++++++++++++++=
+++++++++++++<wbr>++<br>
&gt;=C2=A0 linux-user/mips/cpu_loop.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 6 +++++<b=
r>
&gt;=C2=A0 linux-user/ppc/syscall_nr.h=C2=A0 =C2=A0 =C2=A0| 44 ++++++++++++=
++++++++++++++++++<wbr>+++<br>
&gt;=C2=A0 5 files changed, 144 insertions(+)<br>
&gt;=C2=A0</blockquote><div><br></div><div>Hello, Andrew.</div><div><br></d=
iv><div>I support your change, but its title is not appropriate. It should =
have been &quot;linux-user: Update system call code numbers for some target=
s&quot; or similar. Also, you should have mentioned Laurent Vivier in cc. A=
lso, are other targets updated? If not, I think you should include them as =
well. Additionally, what was the version (or commit number) of the kernel u=
ou used as the reference?</div><div><br></div><div>Thanks, Aleksandar</div>=
<div><br></div><div><br></div></blockquote><div><br></div><div>Forwarding t=
o Laurent.</div><div><br></div><div>Laurent, can this or similar patch be i=
ntegrated into 4.2? It can be viewed as a bug fix, in a way.</div><div><br>=
</div><div>Aleksandar</div><div>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">=
<div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">
&gt; diff --git a/linux-user/aarch64/syscall_n<wbr>r.h<br>
&gt; b/linux-user/aarch64/syscall_n<wbr>r.h<br>
&gt; index f00ffd7fb8..4e8d0bbb15 100644<br>
&gt; --- a/linux-user/aarch64/syscall_n<wbr>r.h<br>
&gt; +++ b/linux-user/aarch64/syscall_n<wbr>r.h<br>
&gt; @@ -276,5 +276,18 @@<br>
&gt;=C2=A0 #define TARGET_NR_membarrier 283<br>
&gt;=C2=A0 #define TARGET_NR_mlock2 284<br>
&gt;=C2=A0 #define TARGET_NR_copy_file_range 285<br>
&gt; +#define TARGET_NR_preadv2 286<br>
&gt; +#define TARGET_NR_pwritev2 287<br>
&gt; +#define TARGET_NR_pkey_mprotect 288<br>
&gt; +#define TARGET_NR_pkey_alloc 289<br>
&gt; +#define TARGET_NR_pkey_free 290<br>
&gt; +#define TARGET_NR_statx 291<br>
&gt; +#define TARGET_NR_io_pgetevents 292<br>
&gt; +#define TARGET_NR_rseq 293<br>
&gt; +#define TARGET_NR_kexec_file_load 294<br>
&gt; +#define TARGET_NR_pidfd_send_signal 424<br>
&gt; +#define TARGET_NR_io_uring_setup 425<br>
&gt; +#define TARGET_NR_io_uring_enter 426<br>
&gt; +#define TARGET_NR_io_uring_register 427<br>
&gt; <br>
&gt;=C2=A0 #endif<br>
&gt; diff --git a/linux-user/arm/syscall_nr.h b/linux-user/arm/syscall_nr.h=
<br>
&gt; index e7eda0d766..20afa3992a 100644<br>
&gt; --- a/linux-user/arm/syscall_nr.h<br>
&gt; +++ b/linux-user/arm/syscall_nr.h<br>
&gt; @@ -400,4 +400,42 @@<br>
&gt;=C2=A0 #define TARGET_NR_membarrier=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(389)<br>
&gt;=C2=A0 #define TARGET_NR_mlock2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(390)<br>
&gt; <br>
&gt; +#define TARGET_NR_copy_file_range=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 (391)<br>
&gt; +#define TARGET_NR_preadv2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (392)<br>
&gt; +#define TARGET_NR_pwritev2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(393)<br>
&gt; +#define TARGET_NR_pkey_mprotect=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 (394)<br>
&gt; +#define TARGET_NR_pkey_alloc=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0(395)<br>
&gt; +#define TARGET_NR_pkey_free=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (396)<br>
&gt; +#define TARGET_NR_statx=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (397)<br>
&gt; +#define TARGET_NR_rseq=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(398)<br>
&gt; +#define TARGET_NR_io_pgetevents=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 (399)<br>
&gt; +#define TARGET_NR_migrate_pages=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 (400)<br>
&gt; +<br>
&gt; +#define TARGET_NR_kexec_file_load=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 (401)<br>
&gt; +#define TARGET_NR_clock_gettime64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 (403)<br>
&gt; +#define TARGET_NR_clock_settime64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 (404)<br>
&gt; +#define TARGET_NR_clock_adjtime64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 (405)<br>
&gt; +#define TARGET_NR_clock_getres_time64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (406)<br>
&gt; +#define TARGET_NR_clock_nanosleep_time<wbr>64=C2=A0 =C2=A0 =C2=A0 =C2=
=A0(407)<br>
&gt; +#define TARGET_NR_timer_gettime64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 (408)<br>
&gt; +#define TARGET_NR_timer_settime64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 (409)<br>
&gt; +#define TARGET_NR_timerfd_gettime64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 (410)<br>
&gt; +<br>
&gt; +#define TARGET_NR_timerfd_settime64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 (411)<br>
&gt; +#define TARGET_NR_utimensat_time64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(412)<br>
&gt; +#define TARGET_NR_pselect6_time64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 (413)<br>
&gt; +#define TARGET_NR_ppoll_time64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0(414)<br>
&gt; +#define TARGET_NR_io_pgetevents_<wbr>time64=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0(416)<br>
&gt; +#define TARGET_NR_recvmmsg_time64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 (417)<br>
&gt; +#define TARGET_NR_mq_timedsend_time64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (418)<br>
&gt; +#define TARGET_NR_mq_timedreceive_time<wbr>64=C2=A0 =C2=A0 =C2=A0 =C2=
=A0(419)<br>
&gt; +#define TARGET_NR_semtimedop_time64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 (420)<br>
&gt; +<br>
&gt; +#define TARGET_NR_rt_sigtimedwait_time<wbr>64=C2=A0 =C2=A0 =C2=A0 =C2=
=A0(421)<br>
&gt; +#define TARGET_NR_futex_time64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0(422)<br>
&gt; +#define TARGET_NR_sched_rr_get_interva<wbr>l_time64 (423)<br>
&gt; +#define TARGET_NR_pidfd_send_signal=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 (424)<br>
&gt; +#define TARGET_NR_io_uring_setup=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0(425)<br>
&gt; +#define TARGET_NR_io_uring_enter=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0(426)<br>
&gt; +#define TARGET_NR_io_uring_register=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 (427)<br>
&gt;=C2=A0 #endif<br>
&gt; diff --git a/linux-user/i386/syscall_nr.h b/linux-user/i386/syscall_nr=
.h<br>
&gt; index 3234ec21c6..e641674daf 100644<br>
&gt; --- a/linux-user/i386/syscall_nr.h<br>
&gt; +++ b/linux-user/i386/syscall_nr.h<br>
&gt; @@ -383,5 +383,48 @@<br>
&gt;=C2=A0 #define TARGET_NR_membarrier=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 375<br>
&gt;=C2=A0 #define TARGET_NR_mlock2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 376<br>
&gt;=C2=A0 #define TARGET_NR_copy_file_range=C2=A0 =C2=A0 =C2=A0 =C2=A0377<=
br>
&gt; +#define TARGET_NR_preadv2 378<br>
&gt; +#define TARGET_NR_pwritev2 379<br>
&gt; +#define TARGET_NR_pkey_mprotect 380<br>
&gt; +#define TARGET_NR_pkey_alloc 381<br>
&gt; +#define TARGET_NR_pkey_free 382<br>
&gt; +#define TARGET_NR_statx 383<br>
&gt; +#define TARGET_NR_arch_prctl 384<br>
&gt; +#define TARGET_NR_io_pgetevents 385<br>
&gt; +#define TARGET_NR_rseq 386<br>
&gt; +#define TARGET_NR_semget 393<br>
&gt; +#define TARGET_NR_semctl 394<br>
&gt; +#define TARGET_NR_shmget 395<br>
&gt; +#define TARGET_NR_shmctl 396<br>
&gt; +#define TARGET_NR_shmat 397<br>
&gt; +#define TARGET_NR_shmdt 398<br>
&gt; +#define TARGET_NR_msgget 399<br>
&gt; +#define TARGET_NR_msgsnd 400<br>
&gt; +#define TARGET_NR_msgrcv 401<br>
&gt; +#define TARGET_NR_msgctl 402<br>
&gt; +#define TARGET_NR_clock_gettime64 403<br>
&gt; +#define TARGET_NR_clock_settime64 404<br>
&gt; +#define TARGET_NR_clock_adjtime64 405<br>
&gt; +#define TARGET_NR_clock_getres_time64 406<br>
&gt; +#define TARGET_NR_clock_nanosleep_time<wbr>64 407<br>
&gt; +#define TARGET_NR_timer_gettime64 408<br>
&gt; +#define TARGET_NR_timer_settime64 409<br>
&gt; +#define TARGET_NR_timerfd_gettime64 410<br>
&gt; +#define TARGET_NR_timerfd_settime64 411<br>
&gt; +#define TARGET_NR_utimensat_time64 412<br>
&gt; +#define TARGET_NR_pselect6_time64 413<br>
&gt; +#define TARGET_NR_ppoll_time64 414<br>
&gt; +#define TARGET_NR_io_pgetevents_time64 416<br>
&gt; +#define TARGET_NR_recvmmsg_time64 417<br>
&gt; +#define TARGET_NR_mq_timedsend_time64 418<br>
&gt; +#define TARGET_NR_mq_timedreceive_time<wbr>64 419<br>
&gt; +#define TARGET_NR_semtimedop_time64 420<br>
&gt; +#define TARGET_NR_rt_sigtimedwait_time<wbr>64 421<br>
&gt; +#define TARGET_NR_futex_time64 422<br>
&gt; +#define TARGET_NR_sched_rr_get_interva<wbr>l_time64 423<br>
&gt; +#define TARGET_NR_pidfd_send_signal 424<br>
&gt; +#define TARGET_NR_io_uring_setup 425<br>
&gt; +#define TARGET_NR_io_uring_enter 426<br>
&gt; +#define TARGET_NR_io_uring_register 427<br>
&gt; <br>
&gt;=C2=A0 #endif<br>
&gt; diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c<b=
r>
&gt; index 39915b3fde..044a00f531 100644<br>
&gt; --- a/linux-user/mips/cpu_loop.c<br>
&gt; +++ b/linux-user/mips/cpu_loop.c<br>
&gt; @@ -390,6 +390,12 @@ static const uint8_t mips_syscall_args[] =3D {<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_copy_file_range, 6) /* =
360 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_preadv2, 6)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_pwritev2, 6)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_pkey_mprotect, 4)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_pkey_alloc, 2)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_pkey_free, 1)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_statx, 5)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_rseq, 4)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 MIPS_SYS(sys_io_pgetevents, 5)<br>
&gt;=C2=A0 };<br>
&gt;=C2=A0 #=C2=A0 undef MIPS_SYS<br>
&gt;=C2=A0 # endif /* O32 */<br>
&gt; diff --git a/linux-user/ppc/syscall_nr.h b/linux-user/ppc/syscall_nr.h=
<br>
&gt; index b57a07b931..eea4056e3d 100644<br>
&gt; --- a/linux-user/ppc/syscall_nr.h<br>
&gt; +++ b/linux-user/ppc/syscall_nr.h<br>
&gt; @@ -398,5 +398,49 @@<br>
&gt;=C2=A0 #define TARGET_NR_shmget=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 376<br>
&gt;=C2=A0 #define TARGET_NR_shmctl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 377<br>
&gt;=C2=A0 #define TARGET_NR_mlock2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 378<br>
&gt; +#define TARGET_NR_copy_file_range=C2=A0 =C2=A0 =C2=A0 =C2=A0379<br>
&gt; +#define TARGET_NR_preadv2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0380<br>
&gt; +#define TARGET_NR_pwritev2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 381<br>
&gt; +#define TARGET_NR_kexec_file_load=C2=A0 =C2=A0 =C2=A0 =C2=A0382<br>
&gt; +#define TARGET_NR_statx=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0383<br>
&gt; +#define TARGET_NR_pkey_alloc=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 384<br>
&gt; +#define TARGET_NR_pkey_free=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0385<br>
&gt; +#define TARGET_NR_pkey_mprotect=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0386<=
br>
&gt; +#define TARGET_NR_rseq=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 387<br>
&gt; +#define TARGET_NR_io_pgetevents=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0388<=
br>
&gt; +#define TARGET_NR_semget=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 393<br>
&gt; +#define TARGET_NR_semctl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 394<br>
&gt; +#define TARGET_NR_shmget=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 395<br>
&gt; +#define TARGET_NR_shmctl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 396<br>
&gt; +#define TARGET_NR_shmat=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0397<br>
&gt; +#define TARGET_NR_shmdt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0398<br>
&gt; +#define TARGET_NR_msgget=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 399<br>
&gt; +#define TARGET_NR_msgsnd=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 400<br>
&gt; +#define TARGET_NR_msgrcv=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 401<br>
&gt; +#define TARGET_NR_msgctl=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 402<br>
&gt; +#define TARGET_NR_clock_gettime64=C2=A0 =C2=A0 =C2=A0 =C2=A0403<br>
&gt; +#define TARGET_NR_clock_settime64=C2=A0 =C2=A0 =C2=A0 =C2=A0404<br>
&gt; +#define TARGET_NR_clock_adjtime64=C2=A0 =C2=A0 =C2=A0 =C2=A0405<br>
&gt; +#define TARGET_NR_clock_getres_time64=C2=A0 =C2=A0406<br>
&gt; +#define TARGET_NR_clock_nanosleep_time<wbr>64 407<br>
&gt; +#define TARGET_NR_timer_gettime64=C2=A0 =C2=A0 =C2=A0 =C2=A0408<br>
&gt; +#define TARGET_NR_timer_settime64=C2=A0 =C2=A0 =C2=A0 =C2=A0409<br>
&gt; +#define TARGET_NR_timerfd_gettime64=C2=A0 =C2=A0 =C2=A0410<br>
&gt; +#define TARGET_NR_timerfd_settime64=C2=A0 =C2=A0 =C2=A0411<br>
&gt; +#define TARGET_NR_utimensat_time64=C2=A0 =C2=A0 =C2=A0 412<br>
&gt; +#define TARGET_NR_pselect6_time64=C2=A0 =C2=A0 =C2=A0 =C2=A0413<br>
&gt; +#define TARGET_NR_ppoll_time64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 414<=
br>
&gt; +#define TARGET_NR_io_pgetevents_<wbr>time64=C2=A0 416<br>
&gt; +#define TARGET_NR_recvmmsg_time64=C2=A0 =C2=A0 =C2=A0 =C2=A0417<br>
&gt; +#define TARGET_NR_mq_timedsend_time64=C2=A0 =C2=A0418<br>
&gt; +#define TARGET_NR_mq_timedreceive_time<wbr>64 419<br>
&gt; +#define TARGET_NR_semtimedop_time64=C2=A0 =C2=A0 =C2=A0420<br>
&gt; +#define TARGET_NR_rt_sigtimedwait_time<wbr>64 421<br>
&gt; +#define TARGET_NR_futex_time64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 422<=
br>
&gt; +#define TARGET_NR_sched_rr_get_interva<wbr>l_time64 423<br>
&gt; +#define TARGET_NR_pidfd_send_signal=C2=A0 =C2=A0 =C2=A0424<br>
&gt; +#define TARGET_NR_io_uring_setup=C2=A0 =C2=A0 =C2=A0 =C2=A0 425<br>
&gt; +#define TARGET_NR_io_uring_enter=C2=A0 =C2=A0 =C2=A0 =C2=A0 426<br>
&gt; +#define TARGET_NR_io_uring_register=C2=A0 =C2=A0 =C2=A0427<br>
&gt; <br>
&gt;=C2=A0 #endif<br>
&gt; <br>
<br>
<br>
</blockquote>
</blockquote>

--000000000000e852a40597220441--

