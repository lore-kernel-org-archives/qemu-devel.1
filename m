Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4214C43215
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 10:55:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70ACF2071F
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 10:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e6Fy5pF5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70ACF2071F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY6bS-0003Xb-Lp
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 05:55:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35469)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iY6af-0002bC-Pp
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 05:55:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iY6ae-0004KA-7N
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 05:55:05 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49672
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iY6ae-0004Jb-3H
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 05:55:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574420103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yA+n9m4NbpvbTkIVtCkxldHUKshnAPLWLyWBzQSZG1c=;
 b=e6Fy5pF5H1dNDD2BiFs7bIbEY7C/wkw8syNB8l7N5QeXVyjbDGivMhfLBBc5Dl4Du2xvW4
 HBxRLz4eO7iHhlD2158JqwP7jpqrm2U3LCud7RQ0gfbPqSbmtLA0zDl4WQHHSGtKLZfRe5
 a6ss2b8zphhefRYrYJiWo39E6iIEvkQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-hOSPZSiSMSu1-KL80nl7Xg-1; Fri, 22 Nov 2019 05:55:01 -0500
Received: by mail-wr1-f71.google.com with SMTP id q12so3734290wrr.3
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 02:55:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tbfzFxhLooAq6hk3XXz9SO/05r8vdgJ9ttODf4WDVRU=;
 b=r1WyDsLUX/oNVhMkSqyrmqg+M1KuqVuLHmWyQwbmlxCK3Y+A5lfF/gp9Y+o8yD0M0O
 LJ0lY0h3c4QEvOqrL8WY1SGp/WYevX2qF8erlkPQIfxgkXpXy90Den9y9vtFTZ8HfucS
 hBFdG1FXbHoCgQroiR2hJh/XBG0rJQny8O1NraWi0Q9yQBPKzmHDlUdTz0mLhHLxK1wS
 lTRlXQVENr0thmQ7DckMv3B0KcjhcViJZhEF6+p50fZZNNJOZkHzqbj3IUKlZxrrmzHr
 6BZ0EWCNHHBCOrzMOB3XSXY6gciJhxOQKbCH2R9UVR3Ps8IVtNwJM7m5mSFVXYq/Ulzn
 NqJw==
X-Gm-Message-State: APjAAAUGGbUmoBNGckn6AU3jofzqREWtEbpxZx7k7zNGQWb6Ukd6WNFo
 Lo+eaZzz7lk8pVBuUfAWcS2hgiC5ftQdMnO3+0B3Le5fSAu8xcVOJxDDq7HOw6HjM8QPSOA261p
 zHej9E+Bxb1keQrY=
X-Received: by 2002:a1c:740a:: with SMTP id p10mr15644296wmc.121.1574420100196; 
 Fri, 22 Nov 2019 02:55:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqyJC51E2SRuE/lPm1Ii/W6tNwP/ddSztn6goWjDMXJbIc+41k0hHUixiuAiH/FAKV9TpMpJ7A==
X-Received: by 2002:a1c:740a:: with SMTP id p10mr15644268wmc.121.1574420099951; 
 Fri, 22 Nov 2019 02:54:59 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id o187sm3138197wmo.20.2019.11.22.02.54.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2019 02:54:59 -0800 (PST)
Subject: Re: [PATCH v3] linux-user/strace: Improve output of various syscalls
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20191121193351.GA31821@ls3530.fritz.box>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <37ef09e9-4e53-f896-30ac-b1cbf1e582b5@redhat.com>
Date: Fri, 22 Nov 2019 11:54:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191121193351.GA31821@ls3530.fritz.box>
Content-Language: en-US
X-MC-Unique: hOSPZSiSMSu1-KL80nl7Xg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/21/19 8:33 PM, Helge Deller wrote:
> Improve strace output of various syscalls which either have none
> or only int-type parameters.
>=20
> Signed-off-by: Helge Deller <deller@gmx.de>
>=20
> ---
> Changes in v3:
>      fixed alarm()
>      added epoll_create(), epoll_create1(), eventfd(), eventfd2()
>=20
> Changes in v2:
>      fixed ioctl()
>=20
>=20
> diff --git a/linux-user/strace.list b/linux-user/strace.list
> index 1de4319dcf..d49a1e92a8 100644
> --- a/linux-user/strace.list
> +++ b/linux-user/strace.list
> @@ -26,7 +26,7 @@
>   { TARGET_NR_afs_syscall, "afs_syscall" , NULL, NULL, NULL },
>   #endif
>   #ifdef TARGET_NR_alarm
> -{ TARGET_NR_alarm, "alarm" , NULL, NULL, NULL },
> +{ TARGET_NR_alarm, "alarm" , "%s(%u)", NULL, NULL },
>   #endif
>   #ifdef TARGET_NR_aplib
>   { TARGET_NR_aplib, "aplib" , NULL, NULL, NULL },
> @@ -116,19 +116,19 @@
>   { TARGET_NR_dipc, "dipc" , NULL, NULL, NULL },
>   #endif
>   #ifdef TARGET_NR_dup
> -{ TARGET_NR_dup, "dup" , NULL, NULL, NULL },
> +{ TARGET_NR_dup, "dup" , "%s(%d)", NULL, NULL },
>   #endif
>   #ifdef TARGET_NR_dup2
> -{ TARGET_NR_dup2, "dup2" , NULL, NULL, NULL },
> +{ TARGET_NR_dup2, "dup2" , "%s(%d,%d)", NULL, NULL },
>   #endif
>   #ifdef TARGET_NR_dup3
> -{ TARGET_NR_dup3, "dup3" , NULL, NULL, NULL },
> +{ TARGET_NR_dup3, "dup3" , "%s(%d,%d,%d)", NULL, NULL },
>   #endif
>   #ifdef TARGET_NR_epoll_create
> -{ TARGET_NR_epoll_create, "epoll_create" , NULL, NULL, NULL },
> +{ TARGET_NR_epoll_create, "%s(%d)", NULL, NULL, NULL },
>   #endif
>   #ifdef TARGET_NR_epoll_create1
> -{ TARGET_NR_epoll_create1, "epoll_create1" , NULL, NULL, NULL },
> +{ TARGET_NR_epoll_create1, "%s(%d)", NULL, NULL, NULL },
>   #endif
>   #ifdef TARGET_NR_epoll_ctl
>   { TARGET_NR_epoll_ctl, "epoll_ctl" , NULL, NULL, NULL },
> @@ -146,10 +146,10 @@
>   { TARGET_NR_epoll_wait_old, "epoll_wait_old" , NULL, NULL, NULL },
>   #endif
>   #ifdef TARGET_NR_eventfd
> -{ TARGET_NR_eventfd, "eventfd" , NULL, NULL, NULL },
> +{ TARGET_NR_eventfd, "eventfd", "%s(%d)", NULL, NULL },
>   #endif
>   #ifdef TARGET_NR_eventfd2
> -{ TARGET_NR_eventfd2, "eventfd2" , NULL, NULL, NULL },
> +{ TARGET_NR_eventfd2, "eventfd2" , "%s(%d,%d)", NULL, NULL },
>   #endif
>   #ifdef TARGET_NR_execv
>   { TARGET_NR_execv, "execv" , NULL, print_execv, NULL },
> @@ -191,7 +191,7 @@
>   { TARGET_NR_fanotify_mark, "fanotify_mark" , NULL, NULL, NULL },
>   #endif
>   #ifdef TARGET_NR_fchdir
> -{ TARGET_NR_fchdir, "fchdir" , NULL, NULL, NULL },
> +{ TARGET_NR_fchdir, "fchdir" , "%s(%d)", NULL, NULL },
>   #endif
>   #ifdef TARGET_NR_fchmod
>   { TARGET_NR_fchmod, "fchmod" , "%s(%d,%#o)", NULL, NULL },
> @@ -287,7 +287,7 @@
>   { TARGET_NR_getdtablesize, "getdtablesize" , NULL, NULL, NULL },
>   #endif
>   #ifdef TARGET_NR_getegid
> -{ TARGET_NR_getegid, "getegid" , NULL, NULL, NULL },
> +{ TARGET_NR_getegid, "getegid" , "%s()", NULL, NULL },

Oh I didn't realize using this format improves the output by not=20
displaying the value of unused registers.
Few other syscalls can be improved this way too.

Good cleanup.
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

>   #endif
>   #ifdef TARGET_NR_getegid32
>   { TARGET_NR_getegid32, "getegid32" , NULL, NULL, NULL },
> @@ -299,7 +299,7 @@
>   { TARGET_NR_geteuid32, "geteuid32" , NULL, NULL, NULL },
>   #endif
>   #ifdef TARGET_NR_getgid
> -{ TARGET_NR_getgid, "getgid" , NULL, NULL, NULL },
> +{ TARGET_NR_getgid, "getgid" , "%s()", NULL, NULL },
>   #endif
>   #ifdef TARGET_NR_getgid32
>   { TARGET_NR_getgid32, "getgid32" , NULL, NULL, NULL },
> @@ -329,10 +329,10 @@
>   { TARGET_NR_getpeername, "getpeername" , NULL, NULL, NULL },
>   #endif
>   #ifdef TARGET_NR_getpgid
> -{ TARGET_NR_getpgid, "getpgid" , NULL, NULL, NULL },
> +{ TARGET_NR_getpgid, "getpgid" , "%s(%u)", NULL, NULL },
>   #endif
>   #ifdef TARGET_NR_getpgrp
> -{ TARGET_NR_getpgrp, "getpgrp" , NULL, NULL, NULL },
> +{ TARGET_NR_getpgrp, "getpgrp" , "%s()", NULL, NULL },
>   #endif
>   #ifdef TARGET_NR_getpid
>   { TARGET_NR_getpid, "getpid" , "%s()", NULL, NULL },
> @@ -432,7 +432,7 @@
>   { TARGET_NR_io_cancel, "io_cancel" , NULL, NULL, NULL },
>   #endif
>   #ifdef TARGET_NR_ioctl
> -{ TARGET_NR_ioctl, "ioctl" , NULL, NULL, NULL },
> +{ TARGET_NR_ioctl, "ioctl" , "%s(%d,%#x,%#x)", NULL, NULL },
>   #endif
>   #ifdef TARGET_NR_io_destroy
>   { TARGET_NR_io_destroy, "io_destroy" , NULL, NULL, NULL },
> @@ -1257,22 +1257,22 @@
>   { TARGET_NR_setdomainname, "setdomainname" , NULL, NULL, NULL },
>   #endif
>   #ifdef TARGET_NR_setfsgid
> -{ TARGET_NR_setfsgid, "setfsgid" , NULL, NULL, NULL },
> +{ TARGET_NR_setfsgid, "setfsgid" , "%s(%u)", NULL, NULL },
>   #endif
>   #ifdef TARGET_NR_setfsgid32
> -{ TARGET_NR_setfsgid32, "setfsgid32" , NULL, NULL, NULL },
> +{ TARGET_NR_setfsgid32, "setfsgid32" , "%s(%u)" , NULL, NULL },
>   #endif
>   #ifdef TARGET_NR_setfsuid
> -{ TARGET_NR_setfsuid, "setfsuid" , NULL, NULL, NULL },
> +{ TARGET_NR_setfsuid, "setfsuid" , "%s(%u)" , NULL, NULL },
>   #endif
>   #ifdef TARGET_NR_setfsuid32
>   { TARGET_NR_setfsuid32, "setfsuid32" , NULL, NULL, NULL },
>   #endif
>   #ifdef TARGET_NR_setgid
> -{ TARGET_NR_setgid, "setgid" , NULL, NULL, NULL },
> +{ TARGET_NR_setgid, "setgid" , "%s(%u)", NULL, NULL },
>   #endif
>   #ifdef TARGET_NR_setgid32
> -{ TARGET_NR_setgid32, "setgid32" , NULL, NULL, NULL },
> +{ TARGET_NR_setgid32, "setgid32" , "%s(%u)", NULL, NULL },
>   #endif
>   #ifdef TARGET_NR_setgroups
>   { TARGET_NR_setgroups, "setgroups" , NULL, NULL, NULL },
> @@ -1296,7 +1296,7 @@
>   { TARGET_NR_setns, "setns" , NULL, NULL, NULL },
>   #endif
>   #ifdef TARGET_NR_setpgid
> -{ TARGET_NR_setpgid, "setpgid" , NULL, NULL, NULL },
> +{ TARGET_NR_setpgid, "setpgid" , "%s(%u,%u)", NULL, NULL },
>   #endif
>   #ifdef TARGET_NR_setpgrp
>   { TARGET_NR_setpgrp, "setpgrp" , NULL, NULL, NULL },
> @@ -1311,22 +1311,22 @@
>   { TARGET_NR_setregid32, "setregid32" , NULL, NULL, NULL },
>   #endif
>   #ifdef TARGET_NR_setresgid
> -{ TARGET_NR_setresgid, "setresgid" , NULL, NULL, NULL },
> +{ TARGET_NR_setresgid, "setresgid" , "%s(%u,%u,%u)", NULL, NULL },
>   #endif
>   #ifdef TARGET_NR_setresgid32
>   { TARGET_NR_setresgid32, "setresgid32" , NULL, NULL, NULL },
>   #endif
>   #ifdef TARGET_NR_setresuid
> -{ TARGET_NR_setresuid, "setresuid" , NULL, NULL, NULL },
> +{ TARGET_NR_setresuid, "setresuid" , "%s(%u,%u,%u)", NULL, NULL },
>   #endif
>   #ifdef TARGET_NR_setresuid32
> -{ TARGET_NR_setresuid32, "setresuid32" , NULL, NULL, NULL },
> +{ TARGET_NR_setresuid32, "setresuid32" , "%s(%u,%u,%u)", NULL, NULL },
>   #endif
>   #ifdef TARGET_NR_setreuid
> -{ TARGET_NR_setreuid, "setreuid" , NULL, NULL, NULL },
> +{ TARGET_NR_setreuid, "setreuid" , "%s(%u,%u)", NULL, NULL },
>   #endif
>   #ifdef TARGET_NR_setreuid32
> -{ TARGET_NR_setreuid32, "setreuid32" , NULL, NULL, NULL },
> +{ TARGET_NR_setreuid32, "setreuid32" , "%s(%u,%u)", NULL, NULL },
>   #endif
>   #ifdef TARGET_NR_setrlimit
>   { TARGET_NR_setrlimit, "setrlimit" , NULL, NULL, NULL },
> @@ -1335,7 +1335,7 @@
>   { TARGET_NR_set_robust_list, "set_robust_list" , NULL, NULL, NULL },
>   #endif
>   #ifdef TARGET_NR_setsid
> -{ TARGET_NR_setsid, "setsid" , NULL, NULL, NULL },
> +{ TARGET_NR_setsid, "setsid" , "%s()", NULL, NULL },
>   #endif
>   #ifdef TARGET_NR_setsockopt
>   { TARGET_NR_setsockopt, "setsockopt" , NULL, NULL, NULL },
>=20


