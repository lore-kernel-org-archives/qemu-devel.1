Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADE8C35641
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 08:56:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E993D2067D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 08:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VL8N7NNS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E993D2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5478-0000Od-64
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 03:56:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46726)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j546H-0007pU-8v
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 03:55:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j546F-0004YZ-Rn
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 03:55:57 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37195
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j546F-0004Un-NT
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 03:55:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582275355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/EIOH8WDfiqC9lzg26BfHX947YU1X2TFa8wdh1twarQ=;
 b=VL8N7NNST/wrMgSsDIQ2K9SxhNhBL1+JnJUkHOSb549dt72ArDM4wIHIDw0RqEfkFCJSf2
 EYEHAtCKsJUYQeApNYJ8AM2IQye8/7KKwOtcnC0Md19pcNzMCJuH4UuswLovdW2B0nlA9X
 TAAm6EitaHFCAMQo5wkkgY0aFcdJeko=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-D5vUxDSTMwGd2L9ukMqlIA-1; Fri, 21 Feb 2020 03:55:53 -0500
Received: by mail-wr1-f72.google.com with SMTP id o9so722296wrw.14
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 00:55:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7jOt6cP2T8QDaLQhyqa389q5g4bxDMOkc18L4Kt1hy4=;
 b=esKFxW6Har7FZGptpPlbgzvl0Cb4XoxX8Y6ClObVXXPKa4/VTdMyRPPeABT+D8CG+B
 NDw58MDsqlZ3t6taFur45mGCOZ1d0eIGj1I1hx6Ujd5+jnko0x2d22oVCnhoWKFAlyIk
 xP4kLTAnZGtVrmikb9IWBlGqPuzVoeH6Owja1/y9Ol8K63WAbrDy08hhE95f1orHAk5n
 VrWRNvq5psGAoYmCOhWyU1NW8kkAiu6+h2XDJMKakkEjkINd2L9tDSO/ZfyAmXRV/EXd
 c4GjQ/2h3DBvq/0z5fKI/S7FJFp9yH7ABw1VpiWQgmcEvj9MUIYS4P1M1CMU5WJvMymK
 kB2Q==
X-Gm-Message-State: APjAAAW2b7Ml49QMjfmH4Fd9i7xy6sqxeuieIXqfQcLWS8FWEo1fhxEn
 3gNC+gO/o5G7OZszdEKUZuKidy3AMMGD7kb8zeO2zbu2JaHLWnRihhFVzGCYLZE7ICHuhvNqoQQ
 Zt8CDcsNa8dn0LbI=
X-Received: by 2002:a7b:c08d:: with SMTP id r13mr2454736wmh.84.1582275351945; 
 Fri, 21 Feb 2020 00:55:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqxsJvNFK6Zv85qQK9vTwUOm80RJ8bJEhupOK00sOA6KeVNXsIxEM/QltthTuQxBYzBYFGQwvA==
X-Received: by 2002:a7b:c08d:: with SMTP id r13mr2454706wmh.84.1582275351622; 
 Fri, 21 Feb 2020 00:55:51 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id f65sm2852527wmf.29.2020.02.21.00.55.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2020 00:55:51 -0800 (PST)
Subject: Re: [PATCH v1 1/2] linux-user: Protect more syscalls
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <cover.1582240656.git.alistair.francis@wdc.com>
 <3fd846fa30a95eb11e2b27d95fce19f3d619d8f0.1582240656.git.alistair.francis@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d063cb08-3efa-95b0-a9b7-f766f6a0a2ef@redhat.com>
Date: Fri, 21 Feb 2020 09:55:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <3fd846fa30a95eb11e2b27d95fce19f3d619d8f0.1582240656.git.alistair.francis@wdc.com>
Content-Language: en-US
X-MC-Unique: D5vUxDSTMwGd2L9ukMqlIA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: alistair23@gmail.com, palmer@dabbelt.com, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/21/20 12:18 AM, Alistair Francis wrote:
> New y2038 safe 32-bit architectures (like RISC-V) don't support old
> syscalls with a 32-bit time_t. The kernel defines new *_time64 versions
> of these syscalls. Add some more #ifdefs to syscall.c in linux-user to
> allow us to compile without these old syscalls.
>=20
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   linux-user/strace.c  |  2 ++
>   linux-user/syscall.c | 18 ++++++++++++++++++
>   2 files changed, 20 insertions(+)
>=20
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 3d4d684450..2eb8ae3d31 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -770,6 +770,7 @@ print_syscall_ret_newselect(const struct syscallname =
*name, abi_long ret)
>   #define TARGET_TIME_OOP      3   /* leap second in progress */
>   #define TARGET_TIME_WAIT     4   /* leap second has occurred */
>   #define TARGET_TIME_ERROR    5   /* clock not synchronized */
> +#ifdef TARGET_NR_adjtimex
>   static void
>   print_syscall_ret_adjtimex(const struct syscallname *name, abi_long ret=
)
>   {
> @@ -808,6 +809,7 @@ print_syscall_ret_adjtimex(const struct syscallname *=
name, abi_long ret)
>  =20
>       gemu_log("\n");
>   }
> +#endif
>  =20
>   UNUSED static struct flags access_flags[] =3D {
>       FLAG_GENERIC(F_OK),
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index c930577686..44632a7f6a 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -738,8 +738,10 @@ safe_syscall3(ssize_t, read, int, fd, void *, buff, =
size_t, count)
>   safe_syscall3(ssize_t, write, int, fd, const void *, buff, size_t, coun=
t)
>   safe_syscall4(int, openat, int, dirfd, const char *, pathname, \
>                 int, flags, mode_t, mode)
> +#if defined(TARGET_NR_wait4)
>   safe_syscall4(pid_t, wait4, pid_t, pid, int *, status, int, options, \
>                 struct rusage *, rusage)
> +#endif
>   safe_syscall5(int, waitid, idtype_t, idtype, id_t, id, siginfo_t *, inf=
op, \
>                 int, options, struct rusage *, rusage)
>   safe_syscall3(int, execve, const char *, filename, char **, argv, char =
**, envp)
> @@ -776,8 +778,10 @@ safe_syscall4(int, rt_sigtimedwait, const sigset_t *=
, these, siginfo_t *, uinfo,
>                 const struct timespec *, uts, size_t, sigsetsize)
>   safe_syscall4(int, accept4, int, fd, struct sockaddr *, addr, socklen_t=
 *, len,
>                 int, flags)
> +#if defined(TARGET_NR_nanosleep)
>   safe_syscall2(int, nanosleep, const struct timespec *, req,
>                 struct timespec *, rem)
> +#endif
>   #ifdef TARGET_NR_clock_nanosleep
>   safe_syscall4(int, clock_nanosleep, const clockid_t, clock, int, flags,
>                 const struct timespec *, req, struct timespec *, rem)
> @@ -1063,6 +1067,7 @@ static inline abi_long host_to_target_rusage(abi_ul=
ong target_addr,
>       return 0;
>   }
>  =20
> +#ifdef TARGET_NR_setrlimit
>   static inline rlim_t target_to_host_rlim(abi_ulong target_rlim)
>   {
>       abi_ulong target_rlim_swap;
> @@ -1078,7 +1083,9 @@ static inline rlim_t target_to_host_rlim(abi_ulong =
target_rlim)
>      =20
>       return result;
>   }
> +#endif
>  =20
> +#if defined(TARGET_NR_getrlimit) || defined (TARGET_NR_ugetrlimit)
>   static inline abi_ulong host_to_target_rlim(rlim_t rlim)
>   {
>       abi_ulong target_rlim_swap;
> @@ -1092,6 +1099,7 @@ static inline abi_ulong host_to_target_rlim(rlim_t =
rlim)
>      =20
>       return result;
>   }
> +#endif
>  =20
>   static inline int target_to_host_resource(int code)
>   {
> @@ -8584,6 +8592,7 @@ static abi_long do_syscall1(void *cpu_env, int num,=
 abi_long arg1,
>               }
>           }
>           return ret;
> +#if defined(TARGET_NR_gettimeofday)
>       case TARGET_NR_gettimeofday:
>           {
>               struct timeval tv;
> @@ -8594,6 +8603,8 @@ static abi_long do_syscall1(void *cpu_env, int num,=
 abi_long arg1,
>               }
>           }
>           return ret;
> +#endif
> +#if defined(TARGET_NR_settimeofday)
>       case TARGET_NR_settimeofday:
>           {
>               struct timeval tv, *ptv =3D NULL;
> @@ -8615,6 +8626,7 @@ static abi_long do_syscall1(void *cpu_env, int num,=
 abi_long arg1,
>  =20
>               return get_errno(settimeofday(ptv, ptz));
>           }
> +#endif
>   #if defined(TARGET_NR_select)
>       case TARGET_NR_select:
>   #if defined(TARGET_WANT_NI_OLD_SELECT)
> @@ -9260,6 +9272,7 @@ static abi_long do_syscall1(void *cpu_env, int num,=
 abi_long arg1,
>           return do_syscall(cpu_env, arg1 & 0xffff, arg2, arg3, arg4, arg=
5,
>                             arg6, arg7, arg8, 0);
>   #endif
> +#if defined(TARGET_NR_wait4)
>       case TARGET_NR_wait4:
>           {
>               int status;
> @@ -9287,6 +9300,7 @@ static abi_long do_syscall1(void *cpu_env, int num,=
 abi_long arg1,
>               }
>           }
>           return ret;
> +#endif
>   #ifdef TARGET_NR_swapoff
>       case TARGET_NR_swapoff:
>           if (!(p =3D lock_user_string(arg1)))
> @@ -9431,6 +9445,7 @@ static abi_long do_syscall1(void *cpu_env, int num,=
 abi_long arg1,
>           return do_vm86(cpu_env, arg1, arg2);
>   #endif
>   #endif
> +#if defined(TARGET_NR_adjtimex)
>       case TARGET_NR_adjtimex:
>           {
>               struct timex host_buf;
> @@ -9446,6 +9461,7 @@ static abi_long do_syscall1(void *cpu_env, int num,=
 abi_long arg1,
>               }
>           }
>           return ret;
> +#endif
>   #if defined(TARGET_NR_clock_adjtime) && defined(CONFIG_CLOCK_ADJTIME)
>       case TARGET_NR_clock_adjtime:
>           {
> @@ -9971,6 +9987,7 @@ static abi_long do_syscall1(void *cpu_env, int num,=
 abi_long arg1,
>               }
>           }
>           return ret;
> +#if defined(TARGET_NR_nanosleep)
>       case TARGET_NR_nanosleep:
>           {
>               struct timespec req, rem;
> @@ -9981,6 +9998,7 @@ static abi_long do_syscall1(void *cpu_env, int num,=
 abi_long arg1,
>               }
>           }
>           return ret;
> +#endif
>       case TARGET_NR_prctl:
>           switch (arg1) {
>           case PR_GET_PDEATHSIG:
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


