Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B18C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 19:41:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EB622063A
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 19:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xnzeca2/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EB622063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXsKl-0004yu-8t
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 14:41:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36870)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iXsJu-0003Mb-IK
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 14:40:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iXsJq-0008PV-Rt
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 14:40:50 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:39671)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iXsJq-0008PA-KZ
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 14:40:46 -0500
Received: by mail-ot1-x341.google.com with SMTP id w24so4045361otk.6
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 11:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NUI/2xqU7+GnmfnvM/mCI+VQfu2ZmuOKpR+gEG6IAss=;
 b=Xnzeca2/uFUpirWJyCVWhlSiIFicNiNBvbTZZyoY+MOqB4TFo/OYa7y+BLRVCRzlG/
 9Ud5ofp1qCkKcKrlFp7Xhohi9XkIFIV727bdLz4zGUreu4TBnMkPbJBtOZvZIYa0pSsE
 F0cl1OtpuOMboxNNxOLhzIEhwkOBYYdoGS2iV8tZ+q2m2wyYvnM3wRRU2uMivGFIB+kE
 b4tquoso+jtWXIeZoTOux8c2uDkAHEf6/rbLWM1vpLDQepTcwlASayGwlQssOtLL95sU
 RvnVgW/0NDHTaNwh8AyoLbS2p+nXeL47no2SGa8PpI7MIehxK0548QuCZDNiO1LH4i87
 o2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NUI/2xqU7+GnmfnvM/mCI+VQfu2ZmuOKpR+gEG6IAss=;
 b=BFRGJlw0bcWQfneUMSehjgJXe8W1R3udkIC7ewSVhO/So+8Y1Wnt8bMtGrnXspUmr5
 aG6UWATHjz+CLGKM/RxoOkJr1DHdI9P/qx3na5pL9zikGkDvxLeHIMbT+SHflyYBMcAI
 9nJDTczCHOGI3vWNQ4knBngWQ99+UXe9uCloonBp6Ci1GHpQ86frYRd5cat8GSjPFd7K
 KDCoKXpy/xC+e9hTBZB2pQ60izIWMfykgRp/uhMYX1cFsJ/qCGQcBuisBxDryMWoFGgs
 BA3gqWX+TCg6noMa5VAkvwVB+1FNuV128EDIrsAKGCnM8xhdHpCKT1ThwShLlq3uWbC5
 i1Tw==
X-Gm-Message-State: APjAAAXnLdF5OjYC1XGCWCpxraa6N9VSLbBy7O9EPzbs/4vGPr2BQxlD
 swlNHMv39bFvvfSdDCT5cmwfeFpxxjz1h378p8Y=
X-Google-Smtp-Source: APXvYqxFI2Sr62h2WRSIYIRXMCJneNcqx2tyBKqvSHp5LlmMyG8NnuiOPQd/+yiw+dRzO51rmdOqHw3extyS0bj35Gg=
X-Received: by 2002:a05:6830:44c:: with SMTP id
 d12mr7487085otc.121.1574365245575; 
 Thu, 21 Nov 2019 11:40:45 -0800 (PST)
MIME-Version: 1.0
References: <20191121193351.GA31821@ls3530.fritz.box>
In-Reply-To: <20191121193351.GA31821@ls3530.fritz.box>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 21 Nov 2019 20:40:35 +0100
Message-ID: <CAL1e-=iJ1evMipDeqLXNp-Mvvb74-hDgknoMaSaz651QRU0Z6w@mail.gmail.com>
Subject: Re: [PATCH v3] linux-user/strace: Improve output of various syscalls
To: Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 21, 2019 at 8:33 PM Helge Deller <deller@gmx.de> wrote:
>
> Improve strace output of various syscalls which either have none
> or only int-type parameters.
>
> Signed-off-by: Helge Deller <deller@gmx.de>
>
> ---

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>


> Changes in v3:
>     fixed alarm()
>     added epoll_create(), epoll_create1(), eventfd(), eventfd2()
>
> Changes in v2:
>     fixed ioctl()
>
>
> diff --git a/linux-user/strace.list b/linux-user/strace.list
> index 1de4319dcf..d49a1e92a8 100644
> --- a/linux-user/strace.list
> +++ b/linux-user/strace.list
> @@ -26,7 +26,7 @@
>  { TARGET_NR_afs_syscall, "afs_syscall" , NULL, NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_alarm
> -{ TARGET_NR_alarm, "alarm" , NULL, NULL, NULL },
> +{ TARGET_NR_alarm, "alarm" , "%s(%u)", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_aplib
>  { TARGET_NR_aplib, "aplib" , NULL, NULL, NULL },
> @@ -116,19 +116,19 @@
>  { TARGET_NR_dipc, "dipc" , NULL, NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_dup
> -{ TARGET_NR_dup, "dup" , NULL, NULL, NULL },
> +{ TARGET_NR_dup, "dup" , "%s(%d)", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_dup2
> -{ TARGET_NR_dup2, "dup2" , NULL, NULL, NULL },
> +{ TARGET_NR_dup2, "dup2" , "%s(%d,%d)", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_dup3
> -{ TARGET_NR_dup3, "dup3" , NULL, NULL, NULL },
> +{ TARGET_NR_dup3, "dup3" , "%s(%d,%d,%d)", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_epoll_create
> -{ TARGET_NR_epoll_create, "epoll_create" , NULL, NULL, NULL },
> +{ TARGET_NR_epoll_create, "%s(%d)", NULL, NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_epoll_create1
> -{ TARGET_NR_epoll_create1, "epoll_create1" , NULL, NULL, NULL },
> +{ TARGET_NR_epoll_create1, "%s(%d)", NULL, NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_epoll_ctl
>  { TARGET_NR_epoll_ctl, "epoll_ctl" , NULL, NULL, NULL },
> @@ -146,10 +146,10 @@
>  { TARGET_NR_epoll_wait_old, "epoll_wait_old" , NULL, NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_eventfd
> -{ TARGET_NR_eventfd, "eventfd" , NULL, NULL, NULL },
> +{ TARGET_NR_eventfd, "eventfd", "%s(%d)", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_eventfd2
> -{ TARGET_NR_eventfd2, "eventfd2" , NULL, NULL, NULL },
> +{ TARGET_NR_eventfd2, "eventfd2" , "%s(%d,%d)", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_execv
>  { TARGET_NR_execv, "execv" , NULL, print_execv, NULL },
> @@ -191,7 +191,7 @@
>  { TARGET_NR_fanotify_mark, "fanotify_mark" , NULL, NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_fchdir
> -{ TARGET_NR_fchdir, "fchdir" , NULL, NULL, NULL },
> +{ TARGET_NR_fchdir, "fchdir" , "%s(%d)", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_fchmod
>  { TARGET_NR_fchmod, "fchmod" , "%s(%d,%#o)", NULL, NULL },
> @@ -287,7 +287,7 @@
>  { TARGET_NR_getdtablesize, "getdtablesize" , NULL, NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_getegid
> -{ TARGET_NR_getegid, "getegid" , NULL, NULL, NULL },
> +{ TARGET_NR_getegid, "getegid" , "%s()", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_getegid32
>  { TARGET_NR_getegid32, "getegid32" , NULL, NULL, NULL },
> @@ -299,7 +299,7 @@
>  { TARGET_NR_geteuid32, "geteuid32" , NULL, NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_getgid
> -{ TARGET_NR_getgid, "getgid" , NULL, NULL, NULL },
> +{ TARGET_NR_getgid, "getgid" , "%s()", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_getgid32
>  { TARGET_NR_getgid32, "getgid32" , NULL, NULL, NULL },
> @@ -329,10 +329,10 @@
>  { TARGET_NR_getpeername, "getpeername" , NULL, NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_getpgid
> -{ TARGET_NR_getpgid, "getpgid" , NULL, NULL, NULL },
> +{ TARGET_NR_getpgid, "getpgid" , "%s(%u)", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_getpgrp
> -{ TARGET_NR_getpgrp, "getpgrp" , NULL, NULL, NULL },
> +{ TARGET_NR_getpgrp, "getpgrp" , "%s()", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_getpid
>  { TARGET_NR_getpid, "getpid" , "%s()", NULL, NULL },
> @@ -432,7 +432,7 @@
>  { TARGET_NR_io_cancel, "io_cancel" , NULL, NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_ioctl
> -{ TARGET_NR_ioctl, "ioctl" , NULL, NULL, NULL },
> +{ TARGET_NR_ioctl, "ioctl" , "%s(%d,%#x,%#x)", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_io_destroy
>  { TARGET_NR_io_destroy, "io_destroy" , NULL, NULL, NULL },
> @@ -1257,22 +1257,22 @@
>  { TARGET_NR_setdomainname, "setdomainname" , NULL, NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_setfsgid
> -{ TARGET_NR_setfsgid, "setfsgid" , NULL, NULL, NULL },
> +{ TARGET_NR_setfsgid, "setfsgid" , "%s(%u)", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_setfsgid32
> -{ TARGET_NR_setfsgid32, "setfsgid32" , NULL, NULL, NULL },
> +{ TARGET_NR_setfsgid32, "setfsgid32" , "%s(%u)" , NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_setfsuid
> -{ TARGET_NR_setfsuid, "setfsuid" , NULL, NULL, NULL },
> +{ TARGET_NR_setfsuid, "setfsuid" , "%s(%u)" , NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_setfsuid32
>  { TARGET_NR_setfsuid32, "setfsuid32" , NULL, NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_setgid
> -{ TARGET_NR_setgid, "setgid" , NULL, NULL, NULL },
> +{ TARGET_NR_setgid, "setgid" , "%s(%u)", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_setgid32
> -{ TARGET_NR_setgid32, "setgid32" , NULL, NULL, NULL },
> +{ TARGET_NR_setgid32, "setgid32" , "%s(%u)", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_setgroups
>  { TARGET_NR_setgroups, "setgroups" , NULL, NULL, NULL },
> @@ -1296,7 +1296,7 @@
>  { TARGET_NR_setns, "setns" , NULL, NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_setpgid
> -{ TARGET_NR_setpgid, "setpgid" , NULL, NULL, NULL },
> +{ TARGET_NR_setpgid, "setpgid" , "%s(%u,%u)", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_setpgrp
>  { TARGET_NR_setpgrp, "setpgrp" , NULL, NULL, NULL },
> @@ -1311,22 +1311,22 @@
>  { TARGET_NR_setregid32, "setregid32" , NULL, NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_setresgid
> -{ TARGET_NR_setresgid, "setresgid" , NULL, NULL, NULL },
> +{ TARGET_NR_setresgid, "setresgid" , "%s(%u,%u,%u)", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_setresgid32
>  { TARGET_NR_setresgid32, "setresgid32" , NULL, NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_setresuid
> -{ TARGET_NR_setresuid, "setresuid" , NULL, NULL, NULL },
> +{ TARGET_NR_setresuid, "setresuid" , "%s(%u,%u,%u)", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_setresuid32
> -{ TARGET_NR_setresuid32, "setresuid32" , NULL, NULL, NULL },
> +{ TARGET_NR_setresuid32, "setresuid32" , "%s(%u,%u,%u)", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_setreuid
> -{ TARGET_NR_setreuid, "setreuid" , NULL, NULL, NULL },
> +{ TARGET_NR_setreuid, "setreuid" , "%s(%u,%u)", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_setreuid32
> -{ TARGET_NR_setreuid32, "setreuid32" , NULL, NULL, NULL },
> +{ TARGET_NR_setreuid32, "setreuid32" , "%s(%u,%u)", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_setrlimit
>  { TARGET_NR_setrlimit, "setrlimit" , NULL, NULL, NULL },
> @@ -1335,7 +1335,7 @@
>  { TARGET_NR_set_robust_list, "set_robust_list" , NULL, NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_setsid
> -{ TARGET_NR_setsid, "setsid" , NULL, NULL, NULL },
> +{ TARGET_NR_setsid, "setsid" , "%s()", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_setsockopt
>  { TARGET_NR_setsockopt, "setsockopt" , NULL, NULL, NULL },

