Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED07C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 22:21:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 966D220709
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 22:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cge8/Sqt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 966D220709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXYM0-0003za-NP
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 17:21:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45256)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iXYL7-0003WL-D9
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 17:20:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iXYL5-0006qg-8M
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 17:20:45 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:44567)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iXYL3-0006p6-GD
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 17:20:43 -0500
Received: by mail-oi1-x242.google.com with SMTP id s71so1279977oih.11
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 14:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2KzanXCTdBlt7aFoGb0vLqDx1/tOvEceR10tndxMgR8=;
 b=cge8/Sqt1Sm+JQwvQgRf9HhZlILIJe32vM3ppwu29eznhH5H9swqOuTMuC6/y4BFll
 kzscRShLe3Tosx72kl0vjAok1aUi8+PHg0ltHn1l498XXhqIjYFxUXB6VC3Vc2XGGj6s
 81x4NKML9gPuXp0u03dOU7JECzONpM+FgxVgSf/kFUfojrFGbYBuh4hS9mwDTFsOn9C8
 Xh0dztfEpZbAT4GJ756oX7Uh5b+rLuntv/e6mc+h8EBrUeUbujDAdMDlmqk7BZkHFg5g
 mKIkGxMJT9vZ45cZ+1Zwbm9QUZqvEU+ItHVuEF3+bQdIzZpwxlM7K7OtwpTbNYgUnFfy
 VsgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2KzanXCTdBlt7aFoGb0vLqDx1/tOvEceR10tndxMgR8=;
 b=YG+T+wx2kxrXL3NjRhWVZen85iZWn7QQhh/r0XXdtzcSqyqL0FKMq2l7wqi+F8k15f
 zPcwlKZ6pzf8IL6JuFy+WXe6blwqGeVIoTBNHJ0SwZaU6vlTV2G/CMDd1dv9cXmrbMnp
 WjJjhIQ5adIXzJsutJlzY4jo0xPcz4IBVJpqP2kFecPSVB3/GlVKtq4mPaa+alJaJ4ka
 LF8iwHerM9XqEBmIFWgOdSq+Uzf731jSU7/ClzqVVB2TGTop/tq7zVNszklDbM+jeto6
 GOLY9CzWKfExeRgBadmiKxoYO7ip6cvn/eZBlHNqtIaWyX2WA6F4qrQhcqtNfX8EEJMa
 s+RQ==
X-Gm-Message-State: APjAAAWHXI67gVVBtK4QcRauWs2iB7CXKDvsOXYC+yBn5G6RXP/yftk2
 /UTHVcq9/H9y8Kr3cCqm0zXEru8Eo6wNPp3aasQ=
X-Google-Smtp-Source: APXvYqxcFJmFUxDi+iNsZifG10njXuyv5KJ6B0LghY5IinETh3cXvI0YvqV6/KD8+N8FH7uFxzqIxyHmat1nHu1yno0=
X-Received: by 2002:aca:670b:: with SMTP id z11mr4597851oix.79.1574288439083; 
 Wed, 20 Nov 2019 14:20:39 -0800 (PST)
MIME-Version: 1.0
References: <20191120145724.GA15677@ls3530.fritz.box>
 <CAL1e-=jqoV0v0NdpeL3NUTOfURNJ9qmD6FcCjV30pXsdBeCD=Q@mail.gmail.com>
In-Reply-To: <CAL1e-=jqoV0v0NdpeL3NUTOfURNJ9qmD6FcCjV30pXsdBeCD=Q@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 20 Nov 2019 23:20:28 +0100
Message-ID: <CAL1e-=gOHZOTnyB0=HOAqzqS4gBF1YkB7x3yQYGJvi5qWg20Kg@mail.gmail.com>
Subject: Re: [PATCH v2] linux-user/strace: Improve output of various syscalls
To: Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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

On Wed, Nov 20, 2019 at 10:13 PM Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
>
> On Wed, Nov 20, 2019 at 3:58 PM Helge Deller <deller@gmx.de> wrote:
> >
> > Improve strace output of various syscalls which either have none
> > or only int-type parameters.
> >
> > Signed-off-by: Helge Deller <deller@gmx.de>
> >
>
> It would be nice if you included a history of the patch (after the line
> "---", as it is customary for single patch submission). You changed
> only ioctl() in v2, right?
>
> I missed your v2, but responded with several hints to v1.
>

userfaultfd(), membarrier(), mlock2()... - all could be included into
your patch.

The table https://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/
would make your job almost effortless.

> Yours,
> Aleksandar
>
> > diff --git a/linux-user/strace.list b/linux-user/strace.list
> > index 1de4319dcf..add53b1734 100644
> > --- a/linux-user/strace.list
> > +++ b/linux-user/strace.list
> > @@ -26,7 +26,7 @@
> >  { TARGET_NR_afs_syscall, "afs_syscall" , NULL, NULL, NULL },
> >  #endif
> >  #ifdef TARGET_NR_alarm
> > -{ TARGET_NR_alarm, "alarm" , NULL, NULL, NULL },
> > +{ TARGET_NR_alarm, "alarm" , "%s(%d)", NULL, NULL },
> >  #endif
> >  #ifdef TARGET_NR_aplib
> >  { TARGET_NR_aplib, "aplib" , NULL, NULL, NULL },
> > @@ -116,13 +116,13 @@
> >  { TARGET_NR_dipc, "dipc" , NULL, NULL, NULL },
> >  #endif
> >  #ifdef TARGET_NR_dup
> > -{ TARGET_NR_dup, "dup" , NULL, NULL, NULL },
> > +{ TARGET_NR_dup, "dup" , "%s(%d)", NULL, NULL },
> >  #endif
> >  #ifdef TARGET_NR_dup2
> > -{ TARGET_NR_dup2, "dup2" , NULL, NULL, NULL },
> > +{ TARGET_NR_dup2, "dup2" , "%s(%d,%d)", NULL, NULL },
> >  #endif
> >  #ifdef TARGET_NR_dup3
> > -{ TARGET_NR_dup3, "dup3" , NULL, NULL, NULL },
> > +{ TARGET_NR_dup3, "dup3" , "%s(%d,%d,%d)", NULL, NULL },
> >  #endif
> >  #ifdef TARGET_NR_epoll_create
> >  { TARGET_NR_epoll_create, "epoll_create" , NULL, NULL, NULL },
> > @@ -191,7 +191,7 @@
> >  { TARGET_NR_fanotify_mark, "fanotify_mark" , NULL, NULL, NULL },
> >  #endif
> >  #ifdef TARGET_NR_fchdir
> > -{ TARGET_NR_fchdir, "fchdir" , NULL, NULL, NULL },
> > +{ TARGET_NR_fchdir, "fchdir" , "%s(%d)", NULL, NULL },
> >  #endif
> >  #ifdef TARGET_NR_fchmod
> >  { TARGET_NR_fchmod, "fchmod" , "%s(%d,%#o)", NULL, NULL },
> > @@ -287,7 +287,7 @@
> >  { TARGET_NR_getdtablesize, "getdtablesize" , NULL, NULL, NULL },
> >  #endif
> >  #ifdef TARGET_NR_getegid
> > -{ TARGET_NR_getegid, "getegid" , NULL, NULL, NULL },
> > +{ TARGET_NR_getegid, "getegid" , "%s()", NULL, NULL },
> >  #endif
> >  #ifdef TARGET_NR_getegid32
> >  { TARGET_NR_getegid32, "getegid32" , NULL, NULL, NULL },
> > @@ -299,7 +299,7 @@
> >  { TARGET_NR_geteuid32, "geteuid32" , NULL, NULL, NULL },
> >  #endif
> >  #ifdef TARGET_NR_getgid
> > -{ TARGET_NR_getgid, "getgid" , NULL, NULL, NULL },
> > +{ TARGET_NR_getgid, "getgid" , "%s()", NULL, NULL },
> >  #endif
> >  #ifdef TARGET_NR_getgid32
> >  { TARGET_NR_getgid32, "getgid32" , NULL, NULL, NULL },
> > @@ -329,10 +329,10 @@
> >  { TARGET_NR_getpeername, "getpeername" , NULL, NULL, NULL },
> >  #endif
> >  #ifdef TARGET_NR_getpgid
> > -{ TARGET_NR_getpgid, "getpgid" , NULL, NULL, NULL },
> > +{ TARGET_NR_getpgid, "getpgid" , "%s(%u)", NULL, NULL },
> >  #endif
> >  #ifdef TARGET_NR_getpgrp
> > -{ TARGET_NR_getpgrp, "getpgrp" , NULL, NULL, NULL },
> > +{ TARGET_NR_getpgrp, "getpgrp" , "%s()", NULL, NULL },
> >  #endif
> >  #ifdef TARGET_NR_getpid
> >  { TARGET_NR_getpid, "getpid" , "%s()", NULL, NULL },
> > @@ -432,7 +432,7 @@
> >  { TARGET_NR_io_cancel, "io_cancel" , NULL, NULL, NULL },
> >  #endif
> >  #ifdef TARGET_NR_ioctl
> > -{ TARGET_NR_ioctl, "ioctl" , NULL, NULL, NULL },
> > +{ TARGET_NR_ioctl, "ioctl" , "%s(%d,%#x,%#x)", NULL, NULL },
> >  #endif
> >  #ifdef TARGET_NR_io_destroy
> >  { TARGET_NR_io_destroy, "io_destroy" , NULL, NULL, NULL },
> > @@ -1257,22 +1257,22 @@
> >  { TARGET_NR_setdomainname, "setdomainname" , NULL, NULL, NULL },
> >  #endif
> >  #ifdef TARGET_NR_setfsgid
> > -{ TARGET_NR_setfsgid, "setfsgid" , NULL, NULL, NULL },
> > +{ TARGET_NR_setfsgid, "setfsgid" , "%s(%u)", NULL, NULL },
> >  #endif
> >  #ifdef TARGET_NR_setfsgid32
> > -{ TARGET_NR_setfsgid32, "setfsgid32" , NULL, NULL, NULL },
> > +{ TARGET_NR_setfsgid32, "setfsgid32" , "%s(%u)" , NULL, NULL },
> >  #endif
> >  #ifdef TARGET_NR_setfsuid
> > -{ TARGET_NR_setfsuid, "setfsuid" , NULL, NULL, NULL },
> > +{ TARGET_NR_setfsuid, "setfsuid" , "%s(%u)" , NULL, NULL },
> >  #endif
> >  #ifdef TARGET_NR_setfsuid32
> >  { TARGET_NR_setfsuid32, "setfsuid32" , NULL, NULL, NULL },
> >  #endif
> >  #ifdef TARGET_NR_setgid
> > -{ TARGET_NR_setgid, "setgid" , NULL, NULL, NULL },
> > +{ TARGET_NR_setgid, "setgid" , "%s(%u)", NULL, NULL },
> >  #endif
> >  #ifdef TARGET_NR_setgid32
> > -{ TARGET_NR_setgid32, "setgid32" , NULL, NULL, NULL },
> > +{ TARGET_NR_setgid32, "setgid32" , "%s(%u)", NULL, NULL },
> >  #endif
> >  #ifdef TARGET_NR_setgroups
> >  { TARGET_NR_setgroups, "setgroups" , NULL, NULL, NULL },
> > @@ -1296,7 +1296,7 @@
> >  { TARGET_NR_setns, "setns" , NULL, NULL, NULL },
> >  #endif
> >  #ifdef TARGET_NR_setpgid
> > -{ TARGET_NR_setpgid, "setpgid" , NULL, NULL, NULL },
> > +{ TARGET_NR_setpgid, "setpgid" , "%s(%u,%u)", NULL, NULL },
> >  #endif
> >  #ifdef TARGET_NR_setpgrp
> >  { TARGET_NR_setpgrp, "setpgrp" , NULL, NULL, NULL },
> > @@ -1311,22 +1311,22 @@
> >  { TARGET_NR_setregid32, "setregid32" , NULL, NULL, NULL },
> >  #endif
> >  #ifdef TARGET_NR_setresgid
> > -{ TARGET_NR_setresgid, "setresgid" , NULL, NULL, NULL },
> > +{ TARGET_NR_setresgid, "setresgid" , "%s(%u,%u,%u)", NULL, NULL },
> >  #endif
> >  #ifdef TARGET_NR_setresgid32
> >  { TARGET_NR_setresgid32, "setresgid32" , NULL, NULL, NULL },
> >  #endif
> >  #ifdef TARGET_NR_setresuid
> > -{ TARGET_NR_setresuid, "setresuid" , NULL, NULL, NULL },
> > +{ TARGET_NR_setresuid, "setresuid" , "%s(%u,%u,%u)", NULL, NULL },
> >  #endif
> >  #ifdef TARGET_NR_setresuid32
> > -{ TARGET_NR_setresuid32, "setresuid32" , NULL, NULL, NULL },
> > +{ TARGET_NR_setresuid32, "setresuid32" , "%s(%u,%u,%u)", NULL, NULL },
> >  #endif
> >  #ifdef TARGET_NR_setreuid
> > -{ TARGET_NR_setreuid, "setreuid" , NULL, NULL, NULL },
> > +{ TARGET_NR_setreuid, "setreuid" , "%s(%u,%u)", NULL, NULL },
> >  #endif
> >  #ifdef TARGET_NR_setreuid32
> > -{ TARGET_NR_setreuid32, "setreuid32" , NULL, NULL, NULL },
> > +{ TARGET_NR_setreuid32, "setreuid32" , "%s(%u,%u)", NULL, NULL },
> >  #endif
> >  #ifdef TARGET_NR_setrlimit
> >  { TARGET_NR_setrlimit, "setrlimit" , NULL, NULL, NULL },
> > @@ -1335,7 +1335,7 @@
> >  { TARGET_NR_set_robust_list, "set_robust_list" , NULL, NULL, NULL },
> >  #endif
> >  #ifdef TARGET_NR_setsid
> > -{ TARGET_NR_setsid, "setsid" , NULL, NULL, NULL },
> > +{ TARGET_NR_setsid, "setsid" , "%s()", NULL, NULL },
> >  #endif
> >  #ifdef TARGET_NR_setsockopt
> >  { TARGET_NR_setsockopt, "setsockopt" , NULL, NULL, NULL },
> >

