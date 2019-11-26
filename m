Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D73C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 20:24:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23F1B2075C
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 20:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnhQkBK3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F1B2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZhNS-0002oa-9p
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 15:24:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42072)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iZhMR-00020A-L2
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 15:23:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iZhMP-0002aJ-U5
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 15:22:59 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:33357)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iZhMP-0002Zv-Ls
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 15:22:57 -0500
Received: by mail-oi1-x242.google.com with SMTP id x21so10809113oic.0
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 12:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qh2V0VlcZFjP/RAhFZZOk63qLctJ78wV7QmgMw4RsF0=;
 b=QnhQkBK3t0mJF1fd7Z4bqOAm6baiFuV6kmYEHu9mv4H4Ua3mwnsloAoSp/DoZDwlDE
 BZgQp0s6TIeqMMYsIIZ0YQ0ZGx5MADNwLE7iBkCj0CmxOEPIGL4ahrzFO5CdAs9GwVwS
 a3h0+XLi2A+e0OLDOc1RvMzkL79HjqPfJHEDczw6jhRtCj71fiZy6L+whuGv8jtFotA9
 cNVNTW/Oo/gE0uElw9o2FQrOlPXpUv4e+uHO9YsLA1nVQodImVQct321OxDAi0Qc/buw
 omb43JSLzUIar7q4D5Z7VgCdemwpVnIqRbZWtFQOdHn3o0i5Yn1B2b4QXueFMen/iNPz
 k0bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qh2V0VlcZFjP/RAhFZZOk63qLctJ78wV7QmgMw4RsF0=;
 b=DBiSwdkZbr30Itbav3HVUTCFGriIymdKPl5F86tthfp7gJO1EXlUACCZzxuM8Pt7HP
 XsSlMGvGauQcykrDC45bB11lcFWhlnFhj7OCwmUxNlZeJ5uUK+nXGhQg+Sr5ZpLD6tRT
 HsmVZpbWmebzyMg47zj4xIotr+tOsndZY/gBGYjtanumUG54Q9YquHU3db03wxRmCkjn
 i3EjPyVmcqtOdzBme/tE9oAodxLUpciADygsvNV/vOSVfCGmXX6xdjR3BtItbysn0rhA
 GHPJErkRCFLjx4QkiLSuuOcfm/7UN68FqKBhfebZGczInZkuaLRXBkef3CSC7RHWOKNn
 myTw==
X-Gm-Message-State: APjAAAVa4LPdpaFtbx/vPG4qtjpN1eJNYuJupABFILKq6waSvq62itpk
 FNTZN8jkrjdgXL/lzqZkN/ZudBFrlPptoiZ+I9s=
X-Google-Smtp-Source: APXvYqzkGlLA4ArSEnxJAFgFgS3L+vf7WxyHkP2T19KVFaWWKf7LX9WhCryWQzgZec5c0XZtNYrKlrf3K36NIJllrqc=
X-Received: by 2002:aca:670b:: with SMTP id z11mr737467oix.79.1574799776548;
 Tue, 26 Nov 2019 12:22:56 -0800 (PST)
MIME-Version: 1.0
References: <20191124115656.GA23850@ls3530.fritz.box>
In-Reply-To: <20191124115656.GA23850@ls3530.fritz.box>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 26 Nov 2019 21:22:45 +0100
Message-ID: <CAL1e-=idLyYu6eSPRv50ayxE-UqQKAeo-d9ge_qudwvYZnTrkA@mail.gmail.com>
Subject: Re: [PATCH v2] linux-user/strace: Improve strace output for read()
 and getcwd()
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Nov 24, 2019 at 12:56 PM Helge Deller <deller@gmx.de> wrote:
>
> The strace functionality in qemu-user lacks the possibility to trace
> which real values get returned to pointers in userspace by syscalls.
>
> For example, the read() and getcwd() syscalls currently only show the
> destination address where the syscalls should put the return values:
> 2532 read(3,0xff80038c,512) = 512
> 2532 getcwd(0x18180,4096) = 9
>
> With the patch below, one now can specify in print_syscall_late() which
> syscalls should be executed first, before they get printed.
> After adding the read() and getcwd() syscalls, we now get this output in
> with strace instead:
> 1708 read(3,"\177ELF\1\2\1\3\0\0\0\0\0\0\0\0\0\3\0\17\0\0\0\1\0\2bl\0\0\04"...,512) = 512
> 1708 getcwd("/usr/bin",4096) = 9
>
> This patch adds just the framework with the respective implemenations for
> read() and getcwd(). If applied, more functions can be added easily later.
>
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
> Changes v2 to v1:
> - Print syscall name, e.g. "read(" before calling the syscall. In case of
>   crash people will then be able to see that it crashed in this "late" call.
>   Based on feedback by Aleksandar Markovic <aleksandar.m.mail@gmail.com>
>

Very nice output if everything goes nice and dendy.

Still not good for people that use strace when something goes wrong.
The output for read() scenario for crash/hang situations is reduced to:

read(

while it used to be

read(3,0xff80038c,512)

This is a regression.

Please consider the content of the patch to be an option, settable
by end user.

Best regards,
Aleksandar




>
> diff --git a/linux-user/qemu.h b/linux-user/qemu.h
> index f6f5fe5fbb..65557660a9 100644
> --- a/linux-user/qemu.h
> +++ b/linux-user/qemu.h
> @@ -371,6 +371,10 @@ extern long safe_syscall_base(int *pending, long number, ...);
>  int host_to_target_waitstatus(int status);
>
>  /* strace.c */
> +const struct syscallname *print_syscall_prologue_num(int num);
> +void print_syscall_late(const struct syscallname *sc,
> +              abi_long arg1, abi_long arg2, abi_long arg3,
> +              abi_long arg4, abi_long arg5, abi_long arg6);
>  void print_syscall(int num,
>                     abi_long arg1, abi_long arg2, abi_long arg3,
>                     abi_long arg4, abi_long arg5, abi_long arg6);
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index de43238fa4..dc963accd5 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -61,6 +61,7 @@ UNUSED static void print_open_flags(abi_long, int);
>  UNUSED static void print_syscall_prologue(const struct syscallname *);
>  UNUSED static void print_syscall_epilogue(const struct syscallname *);
>  UNUSED static void print_string(abi_long, int);
> +UNUSED static void print_encoded_string(abi_long addr, unsigned int maxlen, int last);
>  UNUSED static void print_buf(abi_long addr, abi_long len, int last);
>  UNUSED static void print_raw_param(const char *, abi_long, int);
>  UNUSED static void print_timeval(abi_ulong, int);
> @@ -1196,6 +1197,26 @@ print_syscall_prologue(const struct syscallname *sc)
>      gemu_log("%s(", sc->name);
>  }
>
> +void
> +print_syscall_late(const struct syscallname *sc,
> +              abi_long arg1, abi_long arg2, abi_long arg3,
> +              abi_long arg4, abi_long arg5, abi_long arg6)
> +{
> +    const char *format = TARGET_ABI_FMT_ld "," TARGET_ABI_FMT_ld ","
> +                    TARGET_ABI_FMT_ld "," TARGET_ABI_FMT_ld ","
> +                    TARGET_ABI_FMT_ld "," TARGET_ABI_FMT_ld ")";
> +
> +    if (sc->call != NULL) {
> +        sc->call(sc, arg1, arg2, arg3, arg4, arg5, arg6);
> +    } else {
> +        if (sc->format != NULL) {
> +            format = sc->format;
> +        }
> +        gemu_log(format, arg1, arg2, arg3, arg4, arg5, arg6);
> +    }
> +}
> +
> +
>  /*ARGSUSED*/
>  static void
>  print_syscall_epilogue(const struct syscallname *sc)
> @@ -1204,6 +1225,37 @@ print_syscall_epilogue(const struct syscallname *sc)
>      gemu_log(")");
>  }
>
> +#define MAX_ENCODED_CHARS 32
> +static void
> +print_encoded_string(abi_long addr, unsigned int maxlen, int last)
> +{
> +    unsigned int maxout;
> +    char *s, *str;
> +
> +    s = lock_user_string(addr);
> +    if (s == NULL) {
> +        /* can't get string out of it, so print it as pointer */
> +        print_pointer(addr, last);
> +        return;
> +    }
> +
> +    str = s;
> +    gemu_log("\"");
> +    maxout = MIN(maxlen, MAX_ENCODED_CHARS);
> +    while (maxout--) {
> +        unsigned char c = *str++;
> +        if (isprint(c)) {
> +            gemu_log("%c", c);
> +        } else {
> +            gemu_log("\\%o", (unsigned int) c);
> +        }
> +    }
> +    unlock_user(s, addr, 0);
> +
> +    gemu_log("\"%s%s", maxlen > MAX_ENCODED_CHARS ? "..." : "",
> +                    get_comma(last));
> +}
> +
>  static void
>  print_string(abi_long addr, int last)
>  {
> @@ -1633,6 +1685,18 @@ print_futimesat(const struct syscallname *name,
>  }
>  #endif
>
> +#ifdef TARGET_NR_getcwd
> +static void
> +print_getcwd(const struct syscallname *name,
> +    abi_long arg0, abi_long arg1, abi_long arg2,
> +    abi_long arg3, abi_long arg4, abi_long arg5)
> +{
> +    print_string(arg0, 0);
> +    print_raw_param("%u", arg1, 1);
> +    print_syscall_epilogue(name);
> +}
> +#endif
> +
>  #ifdef TARGET_NR_settimeofday
>  static void
>  print_settimeofday(const struct syscallname *name,
> @@ -2428,6 +2492,19 @@ print_fstatat64(const struct syscallname *name,
>  #define print_newfstatat    print_fstatat64
>  #endif
>
> +#ifdef TARGET_NR_read
> +static void
> +print_read(const struct syscallname *name,
> +    abi_long arg0, abi_long arg1, abi_long arg2,
> +    abi_long arg3, abi_long arg4, abi_long arg5)
> +{
> +    print_raw_param("%d", arg0, 0);
> +    print_encoded_string(arg1, arg2, 0);
> +    print_raw_param("%u", arg2, 1);
> +    print_syscall_epilogue(name);
> +}
> +#endif
> +
>  #ifdef TARGET_NR_readlink
>  static void
>  print_readlink(const struct syscallname *name,
> @@ -2817,6 +2894,22 @@ static int nsyscalls = ARRAY_SIZE(scnames);
>  /*
>   * The public interface to this module.
>   */
> +
> +const struct syscallname *print_syscall_prologue_num(int num)
> +{
> +    int i;
> +
> +    gemu_log("%d ", getpid());
> +
> +    for (i = 0; i < nsyscalls; i++)
> +        if (scnames[i].nr == num) {
> +            print_syscall_prologue(&scnames[i]);
> +            return &scnames[i];
> +        }
> +    gemu_log("Unknown syscall %d\n", num);
> +    return NULL; /* will crash qemu */
> +}
> +
>  void
>  print_syscall(int num,
>                abi_long arg1, abi_long arg2, abi_long arg3,
> diff --git a/linux-user/strace.list b/linux-user/strace.list
> index d49a1e92a8..220b1f4c46 100644
> --- a/linux-user/strace.list
> +++ b/linux-user/strace.list
> @@ -272,7 +272,7 @@
>  { TARGET_NR_getcpu, "getcpu" , "%s(%p,%d)", NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_getcwd
> -{ TARGET_NR_getcwd, "getcwd" , "%s(%p,%d)", NULL, NULL },
> +{ TARGET_NR_getcwd, "getcwd" , NULL, print_getcwd, NULL },
>  #endif
>  #ifdef TARGET_NR_getdents
>  { TARGET_NR_getdents, "getdents" , NULL, NULL, NULL },
> @@ -1080,7 +1080,7 @@
>  { TARGET_NR_quotactl, "quotactl" , NULL, NULL, NULL },
>  #endif
>  #ifdef TARGET_NR_read
> -{ TARGET_NR_read, "read" , "%s(%d,%#x,%d)", NULL, NULL },
> +{ TARGET_NR_read, "read" , NULL, print_read, NULL },
>  #endif
>  #ifdef TARGET_NR_readahead
>  { TARGET_NR_readahead, "readahead" , NULL, NULL, NULL },
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index ce399a55f0..7207826137 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -12069,6 +12069,21 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>      return ret;
>  }
>
> +/*
> + * True if this syscall should be printed after having called the native
> + * syscall, so that values which are fed back to userspace gets printed.
> + */
> +static int is_print_syscall_late(int syscall)
> +{
> +    switch (syscall) {
> +    case TARGET_NR_getcwd:
> +    case TARGET_NR_read:
> +        return 1;
> +    default:
> +        return 0;
> +    }
> +}
> +
>  abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>                      abi_long arg2, abi_long arg3, abi_long arg4,
>                      abi_long arg5, abi_long arg6, abi_long arg7,
> @@ -12095,9 +12110,20 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>                           arg2, arg3, arg4, arg5, arg6, arg7, arg8);
>
>      if (unlikely(do_strace)) {
> -        print_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
> +        const struct syscallname *sc;
> +        int late_printing;
> +
> +        late_printing = is_print_syscall_late(num);
> +        if (late_printing) {
> +            sc = print_syscall_prologue_num(num);
> +        } else {
> +            print_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
> +        }
>          ret = do_syscall1(cpu_env, num, arg1, arg2, arg3, arg4,
>                            arg5, arg6, arg7, arg8);
> +        if (late_printing) {
> +            print_syscall_late(sc, arg1, arg2, arg3, arg4, arg5, arg6);
> +        }
>          print_syscall_ret(num, ret);
>      } else {
>          ret = do_syscall1(cpu_env, num, arg1, arg2, arg3, arg4,

