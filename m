Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20617C31E51
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 03:37:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D26F22082C
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 03:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ie4Oeuin"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D26F22082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34890 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdRPD-0006LT-6t
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 23:37:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47297)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pranith.foss@gmail.com>) id 1hdRO7-0005Pb-Gi
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 23:35:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pranith.foss@gmail.com>) id 1hdRNy-0006WU-TH
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 23:35:50 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:35200)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pranith.foss@gmail.com>)
 id 1hdRNq-0006LX-18
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 23:35:39 -0400
Received: by mail-yb1-xb44.google.com with SMTP id v17so7016502ybm.2
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 20:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=edpi2M77S5cYBbSfGZX7OwQJkg5JWEjrdd3gLwsw5iE=;
 b=ie4OeuinHbH/MJJIn0flGtpldtsvgiOyQrHReYoIKh/+Dnbiw1XhW2+G5TCWc/Ep99
 ib3wfHjkZ4rpBxGFj5lPu4M9E2w8z6Sj5PBjUjHTvB0xj/bonGiABVIHpaWW8E+R57Kk
 ESShaS+GcTYdFsQpNlr6G3cblwEVRSb5PYw592ossBNMCwjrW/ncC2k0MKjCMbi4OdxG
 S3itMXCyMHVFObYLzAJPhIwAorPwhW/rBHOevY6hrT0poVb0cLxbhB8V+SyFSFpz/UMQ
 GdwESc//Y52ZIF/1HsKSoa3fmRmGIW0OhcNSfr379guG6z0CZ8u5zc5gG6sYvhNQ2Di3
 /cwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=edpi2M77S5cYBbSfGZX7OwQJkg5JWEjrdd3gLwsw5iE=;
 b=aY6nIDP9/D+W6TrjmPF+ys2KQbAMmSXkSwSTe4lHzfxE8wsfIGZ48oMbNKUQ8YSaJP
 tWIhV6KBxbfvTTWvZCoGXhAGaYbLZ/YLnuLjHpQLqLRouSVYoGSQI+xJyQXPbeO7qmqw
 DKC2O+Ld5FuIlU+JLefbfPFtGBXfoDX4R23d8r2wNeRjnVDYBWPleqH+R7gs6nkwfSac
 yTG4IKo//+tOtF8B8IBXYYD882SG/nQhIXDeO4yT4QBLTv/JdHh0tbaOxLLk0mukFhp+
 UE+UUOay1x1V/lE+iA4bPyI1LnYsrqcq0yNXUP/89LTh1nrieW6Z6psQRt/FIxSDlSyg
 M1Kw==
X-Gm-Message-State: APjAAAUL+zDXwPqbKVxfkLeOdON8nbteQYyPXW+pR2TTzQlEykpNuINh
 gXWXxtEHNpnnXPzJbJZDl3PdhMZKVMeqNLxLKlM=
X-Google-Smtp-Source: APXvYqzh8Y3CytoXH2+VskbWJWJ1Vo7VCJjxqZNNVXiX18oSRC/ip6bXhq1zWcXamwKEbVyQjx5O7ZFZkM0oa+H/BEQ=
X-Received: by 2002:a25:9704:: with SMTP id d4mr58702974ybo.312.1560915333838; 
 Tue, 18 Jun 2019 20:35:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190614171200.21078-1-alex.bennee@linaro.org>
 <20190614171200.21078-23-alex.bennee@linaro.org>
In-Reply-To: <20190614171200.21078-23-alex.bennee@linaro.org>
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Tue, 18 Jun 2019 20:35:23 -0700
Message-ID: <CADYwmhFz6jjhK0_D1WGMqLcV5XvWaT5mRgtfbbhrU8vchuoAZA@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b44
Subject: Re: [Qemu-devel] [PATCH v3 22/50] *-user: plugin syscalls
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
Cc: Riku Voipio <riku.voipio@iki.fi>, "Emilio G. Cota" <cota@braap.org>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Minor nits.

On Fri, Jun 14, 2019 at 11:41 AM Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>
> From: "Emilio G. Cota" <cota@braap.org>
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  bsd-user/syscall.c   | 9 +++++++++
>  linux-user/syscall.c | 3 +++
>  2 files changed, 12 insertions(+)
>
> diff --git a/bsd-user/syscall.c b/bsd-user/syscall.c
> index 84a983a9a1..50e47d217c 100644
> --- a/bsd-user/syscall.c
> +++ b/bsd-user/syscall.c
> @@ -323,6 +323,8 @@ abi_long do_freebsd_syscall(void *cpu_env, int num, a=
bi_long arg1,
>      gemu_log("freebsd syscall %d\n", num);
>  #endif
>      trace_guest_user_syscall(cpu, num, arg1, arg2, arg3, arg4, arg5, arg=
6, arg7, arg8);
> +    qemu_plugin_vcpu_syscall(cpu, num, arg1, arg2, arg3, arg4, arg5, arg=
6, arg7,
> +                             arg8);

Looking at the previous line, seems like you can avoid splitting this
line into 2. Keeps it more consistent that way.

>      if(do_strace)
>          print_freebsd_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
>
> @@ -404,6 +406,7 @@ abi_long do_freebsd_syscall(void *cpu_env, int num, a=
bi_long arg1,
>      if (do_strace)
>          print_freebsd_syscall_ret(num, ret);
>      trace_guest_user_syscall_ret(cpu, num, ret);
> +    qemu_plugin_vcpu_syscall_ret(cpu, num, ret);
>      return ret;
>   efault:
>      ret =3D -TARGET_EFAULT;
> @@ -422,6 +425,8 @@ abi_long do_netbsd_syscall(void *cpu_env, int num, ab=
i_long arg1,
>      gemu_log("netbsd syscall %d\n", num);
>  #endif
>      trace_guest_user_syscall(cpu, num, arg1, arg2, arg3, arg4, arg5, arg=
6, 0, 0);
> +    qemu_plugin_vcpu_syscall(cpu, num, arg1, arg2, arg3, arg4, arg5, arg=
6, 0,
> +                             0);

ditto.

>      if(do_strace)
>          print_netbsd_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
>
> @@ -480,6 +485,7 @@ abi_long do_netbsd_syscall(void *cpu_env, int num, ab=
i_long arg1,
>      if (do_strace)
>          print_netbsd_syscall_ret(num, ret);
>      trace_guest_user_syscall_ret(cpu, num, ret);
> +    qemu_plugin_vcpu_syscall_ret(cpu, num, ret);
>      return ret;
>   efault:
>      ret =3D -TARGET_EFAULT;
> @@ -498,6 +504,8 @@ abi_long do_openbsd_syscall(void *cpu_env, int num, a=
bi_long arg1,
>      gemu_log("openbsd syscall %d\n", num);
>  #endif
>      trace_guest_user_syscall(cpu, num, arg1, arg2, arg3, arg4, arg5, arg=
6, 0, 0);
> +    qemu_plugin_vcpu_syscall(cpu, num, arg1, arg2, arg3, arg4, arg5, arg=
6, 0,
> +                             0);

ditto.

>      if(do_strace)
>          print_openbsd_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
>
> @@ -556,6 +564,7 @@ abi_long do_openbsd_syscall(void *cpu_env, int num, a=
bi_long arg1,
>      if (do_strace)
>          print_openbsd_syscall_ret(num, ret);
>      trace_guest_user_syscall_ret(cpu, num, ret);
> +    qemu_plugin_vcpu_syscall_ret(cpu, num, ret);
>      return ret;
>   efault:
>      ret =3D -TARGET_EFAULT;
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index b187c1281d..7f3cfdee84 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -11724,6 +11724,8 @@ abi_long do_syscall(void *cpu_env, int num, abi_l=
ong arg1,
>
>      trace_guest_user_syscall(cpu, num, arg1, arg2, arg3, arg4,
>                               arg5, arg6, arg7, arg8);
> +    qemu_plugin_vcpu_syscall(cpu, num, arg1, arg2, arg3, arg4, arg5, arg=
6, arg7,
> +                             arg8);

This I am not sure.


>
>      if (unlikely(do_strace)) {
>          print_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
> @@ -11736,5 +11738,6 @@ abi_long do_syscall(void *cpu_env, int num, abi_l=
ong arg1,
>      }
>
>      trace_guest_user_syscall_ret(cpu, num, ret);
> +    qemu_plugin_vcpu_syscall_ret(cpu, num, ret);
>      return ret;
>  }
> --
> 2.20.1
>
>

