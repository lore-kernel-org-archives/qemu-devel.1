Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084BEC4BA2D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 00:18:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C607124650
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 00:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpkMj25b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C607124650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j76t5-0007ym-0R
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 19:18:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47937)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1j76sV-0007XP-Nb
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 19:18:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1j76sU-0002n3-CW
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 19:18:11 -0500
Received: from mail-lf1-x143.google.com ([2a00:1450:4864:20::143]:39337)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1j76sR-0002Zm-QF; Wed, 26 Feb 2020 19:18:07 -0500
Received: by mail-lf1-x143.google.com with SMTP id n30so679800lfh.6;
 Wed, 26 Feb 2020 16:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=HGjZG+q/TIz93Fu76a4gl82MvVhByu6oG1TEpb9fx8M=;
 b=hpkMj25b1JFmXZyBONbfMS5im0WihcrAg/lOKxnldtyig7MVL+hYbehiMI+/eSmYUh
 er4n9E6nCecCIWYPyH6O1OHykuzIJO6I6fCWpdIUB47/ky5LFmFT7Cv65Wk/Vxb1e1bV
 YTGQMo/DQvzA7vVw1KiU//bJpL9KZzMaCkyl2b4EvXhi0JsDnflq17yWrDBkr2jkyaqK
 3cCoCBbm/46MzKeXdBXXF8CsF05ixKgDrBMovLJIOHhQoM9pcGi3xtkZf1+4QJX5Oz7g
 O3Ci2uZcqxmU6P2Hq2DOJnrz5M4mUKN1Fnny/qpBzzikvaUYdeH/HX5HMGwAlRaPeZiU
 ooFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=HGjZG+q/TIz93Fu76a4gl82MvVhByu6oG1TEpb9fx8M=;
 b=pUHduIetp/31JyDsHpRP1K9AAbrHOjFletFA6UoVZpuZhxnohqH6oCnSxEvKiWhnWs
 E9zoX0JJnnaeCkvSC/nlPt3MMVVV7ggGpLYOLUJMEE6oTslkbHfq89JOyqoCehvmN0Qq
 +HNPD0y0KYjzrU1WNho83cIkkErbV3Ecif/+0+FuWFcASuR3h9Xzgsunfq7PzCpPFnKe
 Af3wMSP4eC5eLiu0BXfWsozgaL8V/Dw+EhvDWr+eoG3K3VLurZZNsFMhwSJeBHkKehso
 L/6D3/XxpJ7FfdWMyNJXNPz+b9NNoLxUo8NGCcrwDglKEFUlTtDMAvIEA7nVa8DsHZfA
 AsbQ==
X-Gm-Message-State: ANhLgQ2Lgq4wZdeekbDp0e0jaPa4XGgcdn/zUIjbGSz5yRpzN/9PEM0R
 wGdbnJyNlLt2pB1SrA9h7KCBBGuVTqGPVR2x0i0=
X-Google-Smtp-Source: ADFU+vsPvyrmWFCbj/4N/NP6bGboifSkgK85E05l4KFFoHYKu97/8Tq1l+FjTQBgrr20zEo/C6xxOJ5FrnpQzC3BVjY=
X-Received: by 2002:a19:8585:: with SMTP id h127mr579263lfd.196.1582762686278; 
 Wed, 26 Feb 2020 16:18:06 -0800 (PST)
MIME-Version: 1.0
References: <cover.1582586444.git.alistair.francis@wdc.com>
 <85f33856ee6f32125e5c81a9561346b28b340a3e.1582586444.git.alistair.francis@wdc.com>
 <24431d59-b535-97d4-95d7-fe4401e10787@vivier.eu>
 <CAKmqyKObXNXj2jsMYTvAL-eHS43Wb5upwq6mHeHo7q-4Pr4W7g@mail.gmail.com>
 <fd0e0b49-b2c4-9adf-8cbe-9e160b89f9f2@vivier.eu>
In-Reply-To: <fd0e0b49-b2c4-9adf-8cbe-9e160b89f9f2@vivier.eu>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 26 Feb 2020 16:10:29 -0800
Message-ID: <CAKmqyKM+nmUwr65i8keu578wLfMappj-9yUJHg+rO44+_YVz6w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] linux-user/riscv: Update the syscall_nr's to the
 5.5 kernel
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::143
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 26, 2020 at 4:02 PM Laurent Vivier <laurent@vivier.eu> wrote:
>
> Le 26/02/2020 =C3=A0 20:32, Alistair Francis a =C3=A9crit :
> > On Tue, Feb 25, 2020 at 3:50 AM Laurent Vivier <laurent@vivier.eu> wrot=
e:
> >>
> >> Le 25/02/2020 =C3=A0 00:21, Alistair Francis a =C3=A9crit :
> >>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ...
> >> I think you can remove following defintion as they should be translate=
d
> >> by the target glibc.
> >
> > glibc won't be exposing these externally, the current plan is just to
> > use this internally to glibc.
>
> But if they are defined internally to glibc, glibc will always translate
> the older ones to the 64bit ones and thus glibc will never use the older
> ones with the kernel, only the 64bit ones, thus the older syscalls
> should never come to QEMU.

That's part of the problem. QEMU has no TARGET_NR_futex_time64
support, so we define TARGET_NR_futex to be TARGET_NR_futex_time64.

Looking a bit more it looks like there will still be issues as the
syscall.c makes assumptions on time_t and friends being the word
length (which isn't true for RV32), but this is at least a step in the
right direction.

Would it be possible to define the type sizes per architecture like glibc d=
oes?

Alistair

>
> So why do we need to define the translation older-to-64bit in QEMU too?
>
> >
> >>
> >>> +/*
> >>> + * Alias some of the older pre 64-bit time_t syscalls to the 64-bit
> >>> + * ones for RV32. This is based on the list used by glibc.
> >>> + */
> >>> +#define TARGET_NR_futex TARGET_NR_futex_time64
> >>> +#define TARGET_NR_rt_sigtimedwait TARGET_NR_rt_sigtimedwait_time64
> >>> +#define TARGET_NR_ppoll TARGET_NR_ppoll_time64
> >>> +#define TARGET_NR_utimensat TARGET_NR_utimensat_time64
> >>> +#define TARGET_NR_pselect6 TARGET_NR_pselect6_time64
> >>> +#define TARGET_NR_recvmmsg TARGET_NR_recvmmsg_time64
> >>> +#define TARGET_NR_semtimedop TARGET_NR_semtimedop_time64
> >>> +#define TARGET_NR_mq_timedreceive TARGET_NR_mq_timedreceive_time64
> >>> +#define TARGET_NR_mq_timedsend TARGET_NR_mq_timedsend_time64
> >>> +#define TARGET_NR_clock_getres TARGET_NR_clock_getres_time64
> >>> +#define TARGET_NR_timerfd_settime TARGET_NR_timerfd_settime64
> >>> +#define TARGET_NR_timerfd_gettime TARGET_NR_timerfd_gettime64
> >>> +#define TARGET_NR_sched_rr_get_interval TARGET_NR_sched_rr_get_inter=
val_time64
> >>> +#define TARGET_NR_clock_adjtime TARGET_NR_clock_adjtime64
> >>> +
> >>> +#endif
> >>> diff --git a/linux-user/riscv/syscall64_nr.h b/linux-user/riscv/sysca=
ll64_nr.h
> >>> new file mode 100644
> >>> index 0000000000..b58364b570
> >>> --- /dev/null
> >>> +++ b/linux-user/riscv/syscall64_nr.h
> >>
> >> syscall64_nr.h is correct.
> >>
> >> Thanks,
> >> Laurent
> >>
> >
>

