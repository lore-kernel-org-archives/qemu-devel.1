Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C669C4332B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 23:33:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1405E20768
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 23:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SpoUTHz2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1405E20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEiBn-0001K7-5C
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 19:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40488)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jEiB3-0000tG-KD
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 19:32:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jEiB1-0004xA-8w
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 19:32:45 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:45288)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jEiB1-0004vY-4d
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 19:32:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584574362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uRblYc4/oBvYL3A87oyakwY/OmMj2ASQSpzKKHVIlWE=;
 b=SpoUTHz2Yo2bgGEBNtyfskbmrd+SOjDQBTWTWzZfGTFXopV6Y3uUhprmOC5zVRHpDVKlYN
 J/YISuwZQ6/47Vu3mG6EDlfsDjZzdlxw20rA8ZjNrQjoJhjvq9UWHr58kwFDCzuBPVSFQT
 PfNe/rhYaR5cynTtfPZwrdVZxtWNTrc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-BsU7A9qUMtaIf7LciUMXDw-1; Wed, 18 Mar 2020 19:32:38 -0400
X-MC-Unique: BsU7A9qUMtaIf7LciUMXDw-1
Received: by mail-wm1-f72.google.com with SMTP id 20so250526wmk.1
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 16:32:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bkPu88eFIhf0aCjYagPfrwJ7dqa2ZIKY0NNfBusOio0=;
 b=imlhGU6Oe2LZ2wJcB2l0hnTlIw0KFrwFlN/L8iTwXqKu5Dzig0o98YUVkOZcJf2vP+
 HY3/yBz6algNcg09MUmnXyvwl9tBmA/KFVNXlsVb8T4a1Mti90pPrgYKlJkEXR50HUbt
 /nCx+aSante0d8RWwse43rkxiTzHbvG8ZclHUaBpZ83qfpR0HZTbMyn/pbnn8yBT37Aq
 onl5EYPJjj7LrROOrjy/kqEy+CTkmx/hyKXrqHgaoMz/dSrIWwr96koS3fqXvGYQB2R/
 7bRqM3MI5t8bnhekQEOlaBl4ZIzDIQxZBXBydU0HI1QepVh+3gNGam8CRJ+p/7L4Jn8Y
 tD0g==
X-Gm-Message-State: ANhLgQ1S1sULr2tkOEcgiet4EWQjUTmMjXlaGhB6rRQmSHNBHiuOA+nb
 WbbYrTcRRokdAKogm+hisageaRLbctYYYsnxlIXJfdlQVgqa7/edjLnqojKrdAPqlbjPbqBTHuM
 rKAtmQbKNBKVFIYM=
X-Received: by 2002:adf:e68b:: with SMTP id r11mr351456wrm.138.1584574357036; 
 Wed, 18 Mar 2020 16:32:37 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vto0KRPR9f7xsdz8bnjhrbkX49eJpR8MzdY1Xl+pt8wyfVdHc+yWCneAOsvmbmC+WE+7Oukbg==
X-Received: by 2002:adf:e68b:: with SMTP id r11mr351425wrm.138.1584574356604; 
 Wed, 18 Mar 2020 16:32:36 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id b187sm540571wmc.14.2020.03.18.16.32.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2020 16:32:35 -0700 (PDT)
Subject: Re: [PATCH v9 1/4] linux-user: Protect more syscalls
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, laurent@vivier.eu
References: <cover.1584571250.git.alistair.francis@wdc.com>
 <e06642c862997571f3b3d7afe637d2f73548054a.1584571250.git.alistair.francis@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <53137b17-4b1a-334c-a2b8-cbd5aa1438da@redhat.com>
Date: Thu, 19 Mar 2020 00:32:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <e06642c862997571f3b3d7afe637d2f73548054a.1584571250.git.alistair.francis@wdc.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: alistair23@gmail.com, palmer@dabbelt.com,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/18/20 11:46 PM, Alistair Francis wrote:
> New y2038 safe 32-bit architectures (like RISC-V) don't support old
> syscalls with a 32-bit time_t. The kernel defines new *_time64 versions
> of these syscalls. Add some more #ifdefs to syscall.c in linux-user to
> allow us to compile without these old syscalls.
>=20
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   linux-user/strace.c  |  2 ++
>   linux-user/syscall.c | 68 ++++++++++++++++++++++++++++++++++++++++++--

This patch is easier to review with 'git-diff --function-context'.

>   2 files changed, 68 insertions(+), 2 deletions(-)
>=20
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 4f7130b2ff..6420ccd97b 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -775,6 +775,7 @@ print_syscall_ret_newselect(const struct syscallname =
*name, abi_long ret)
>   #define TARGET_TIME_OOP      3   /* leap second in progress */
>   #define TARGET_TIME_WAIT     4   /* leap second has occurred */
>   #define TARGET_TIME_ERROR    5   /* clock not synchronized */
> +#ifdef TARGET_NR_adjtimex
>   static void
>   print_syscall_ret_adjtimex(const struct syscallname *name, abi_long ret=
)
>   {
> @@ -813,6 +814,7 @@ print_syscall_ret_adjtimex(const struct syscallname *=
name, abi_long ret)
>  =20
>       qemu_log("\n");
>   }
> +#endif
>  =20
>   UNUSED static struct flags access_flags[] =3D {
>       FLAG_GENERIC(F_OK),
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 8d27d10807..909bec94a5 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -742,21 +742,30 @@ safe_syscall3(ssize_t, read, int, fd, void *, buff,=
 size_t, count)
>   safe_syscall3(ssize_t, write, int, fd, const void *, buff, size_t, coun=
t)
>   safe_syscall4(int, openat, int, dirfd, const char *, pathname, \
>                 int, flags, mode_t, mode)
> +#if defined(TARGET_NR_wait4) || defined(TARGET_NR_waitpid)
>   safe_syscall4(pid_t, wait4, pid_t, pid, int *, status, int, options, \
>                 struct rusage *, rusage)
> +#endif
>   safe_syscall5(int, waitid, idtype_t, idtype, id_t, id, siginfo_t *, inf=
op, \
>                 int, options, struct rusage *, rusage)
>   safe_syscall3(int, execve, const char *, filename, char **, argv, char =
**, envp)
> +#if defined(TARGET_NR_select) || defined(TARGET_NR__newselect) || \
> +    defined(TARGET_NR_pselect6)
>   safe_syscall6(int, pselect6, int, nfds, fd_set *, readfds, fd_set *, wr=
itefds, \
>                 fd_set *, exceptfds, struct timespec *, timeout, void *, =
sig)
> +#endif
> +#if defined(TARGET_NR_ppoll) || defined(TARGET_NR_poll)
>   safe_syscall5(int, ppoll, struct pollfd *, ufds, unsigned int, nfds,
>                 struct timespec *, tsp, const sigset_t *, sigmask,
>                 size_t, sigsetsize)
> +#endif
>   safe_syscall6(int, epoll_pwait, int, epfd, struct epoll_event *, events=
,
>                 int, maxevents, int, timeout, const sigset_t *, sigmask,
>                 size_t, sigsetsize)
> +#ifdef TARGET_NR_futex
>   safe_syscall6(int,futex,int *,uaddr,int,op,int,val, \
>                 const struct timespec *,timeout,int *,uaddr2,int,val3)
> +#endif
>   safe_syscall2(int, rt_sigsuspend, sigset_t *, newset, size_t, sigsetsiz=
e)
>   safe_syscall2(int, kill, pid_t, pid, int, sig)
>   safe_syscall2(int, tkill, int, tid, int, sig)
> @@ -776,12 +785,16 @@ safe_syscall6(ssize_t, recvfrom, int, fd, void *, b=
uf, size_t, len,
>   safe_syscall3(ssize_t, sendmsg, int, fd, const struct msghdr *, msg, in=
t, flags)
>   safe_syscall3(ssize_t, recvmsg, int, fd, struct msghdr *, msg, int, fla=
gs)
>   safe_syscall2(int, flock, int, fd, int, operation)
> +#ifdef TARGET_NR_rt_sigtimedwait
>   safe_syscall4(int, rt_sigtimedwait, const sigset_t *, these, siginfo_t =
*, uinfo,
>                 const struct timespec *, uts, size_t, sigsetsize)
> +#endif
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
> @@ -802,9 +815,11 @@ safe_syscall5(int, msgrcv, int, msgid, void *, msgp,=
 size_t, sz,
>   safe_syscall4(int, semtimedop, int, semid, struct sembuf *, tsops,
>                 unsigned, nsops, const struct timespec *, timeout)
>   #endif
> -#if defined(TARGET_NR_mq_open) && defined(__NR_mq_open)
> +#ifdef TARGET_NR_mq_timedsend
>   safe_syscall5(int, mq_timedsend, int, mqdes, const char *, msg_ptr,
>                 size_t, len, unsigned, prio, const struct timespec *, tim=
eout)
> +#endif
> +#ifdef TARGET_NR_mq_timedreceive
>   safe_syscall5(int, mq_timedreceive, int, mqdes, char *, msg_ptr,
>                 size_t, len, unsigned *, prio, const struct timespec *, t=
imeout)
>   #endif
> @@ -946,6 +961,8 @@ abi_long do_brk(abi_ulong new_brk)
>       return target_brk;
>   }
>  =20
> +#if defined(TARGET_NR_select) || defined(TARGET_NR__newselect) || \
> +    defined(TARGET_NR_pselect6)
>   static inline abi_long copy_from_user_fdset(fd_set *fds,
>                                               abi_ulong target_fds_addr,
>                                               int n)
> @@ -1021,6 +1038,7 @@ static inline abi_long copy_to_user_fdset(abi_ulong=
 target_fds_addr,
>  =20
>       return 0;
>   }
> +#endif
>  =20
>   #if defined(__alpha__)
>   #define HOST_HZ 1024
> @@ -1067,6 +1085,7 @@ static inline abi_long host_to_target_rusage(abi_ul=
ong target_addr,
>       return 0;
>   }
>  =20
> +#ifdef TARGET_NR_setrlimit
>   static inline rlim_t target_to_host_rlim(abi_ulong target_rlim)
>   {
>       abi_ulong target_rlim_swap;
> @@ -1082,7 +1101,9 @@ static inline rlim_t target_to_host_rlim(abi_ulong =
target_rlim)
>      =20
>       return result;
>   }
> +#endif
>  =20
> +#if defined(TARGET_NR_getrlimit) || defined(TARGET_NR_ugetrlimit)
>   static inline abi_ulong host_to_target_rlim(rlim_t rlim)
>   {
>       abi_ulong target_rlim_swap;
> @@ -1096,6 +1117,7 @@ static inline abi_ulong host_to_target_rlim(rlim_t =
rlim)
>      =20
>       return result;
>   }
> +#endif
>  =20
>   static inline int target_to_host_resource(int code)
>   {
> @@ -1186,6 +1208,12 @@ static inline abi_long copy_to_user_timeval64(abi_=
ulong target_tv_addr,
>       return 0;
>   }
>  =20
> +#if defined(TARGET_NR_futex) || \
> +    defined(TARGET_NR_rt_sigtimedwait) || \
> +    defined(TARGET_NR_pselect6) || defined(TARGET_NR_pselect6) || \
> +    defined(TARGET_NR_nanosleep) || defined(TARGET_NR_clock_settime) || =
\
> +    defined(TARGET_NR_utimensat) || defined(TARGET_NR_mq_timedsend) || \
> +    defined(TARGET_NR_mq_timedreceive)

Maybe we need a Kconfig equivalent for user-mode syscalls :P

>   static inline abi_long target_to_host_timespec(struct timespec *host_ts=
,
>                                                  abi_ulong target_addr)
>   {
> @@ -1199,6 +1227,7 @@ static inline abi_long target_to_host_timespec(stru=
ct timespec *host_ts,
>       unlock_user_struct(target_ts, target_addr, 0);
>       return 0;
>   }
> +#endif
>  =20
>   static inline abi_long host_to_target_timespec(abi_ulong target_addr,
>                                                  struct timespec *host_ts=
)
> @@ -1228,6 +1257,7 @@ static inline abi_long host_to_target_timespec64(ab=
i_ulong target_addr,
>       return 0;
>   }
>  =20
> +#if defined(TARGET_NR_settimeofday)
>   static inline abi_long copy_from_user_timezone(struct timezone *tz,
>                                                  abi_ulong target_tz_addr=
)
>   {
> @@ -1244,6 +1274,7 @@ static inline abi_long copy_from_user_timezone(stru=
ct timezone *tz,
>  =20
>       return 0;
>   }
> +#endif
>  =20
>   #if defined(TARGET_NR_mq_open) && defined(__NR_mq_open)
>   #include <mqueue.h>
> @@ -6565,6 +6596,8 @@ static inline abi_long target_ftruncate64(void *cpu=
_env, abi_long arg1,
>   }
>   #endif
>  =20
> +#if defined(TARGET_NR_timer_settime) || \
> +    (defined(TARGET_NR_timerfd_settime) && defined(CONFIG_TIMERFD))
>   static inline abi_long target_to_host_itimerspec(struct itimerspec *hos=
t_itspec,
>                                                    abi_ulong target_addr)
>   {
> @@ -6584,7 +6617,11 @@ static inline abi_long target_to_host_itimerspec(s=
truct itimerspec *host_itspec,
>       unlock_user_struct(target_itspec, target_addr, 1);
>       return 0;
>   }
> +#endif
>  =20
> +#if ((defined(TARGET_NR_timerfd_gettime) || \
> +      defined(TARGET_NR_timerfd_settime)) && defined(CONFIG_TIMERFD)) ||=
 \
> +    defined(TARGET_NR_timer_gettime) || defined(TARGET_NR_timer_settime)
>   static inline abi_long host_to_target_itimerspec(abi_ulong target_addr,
>                                                  struct itimerspec *host_=
its)
>   {
> @@ -6603,7 +6640,10 @@ static inline abi_long host_to_target_itimerspec(a=
bi_ulong target_addr,
>       unlock_user_struct(target_itspec, target_addr, 0);
>       return 0;
>   }
> +#endif
>  =20
> +#if defined(TARGET_NR_adjtimex) || \
> +    (defined(TARGET_NR_clock_adjtime) && defined(CONFIG_CLOCK_ADJTIME))
>   static inline abi_long target_to_host_timex(struct timex *host_tx,
>                                               abi_long target_addr)
>   {
> @@ -6673,7 +6713,7 @@ static inline abi_long host_to_target_timex(abi_lon=
g target_addr,
>       unlock_user_struct(target_tx, target_addr, 1);
>       return 0;
>   }
> -
> +#endif
>  =20
>   static inline abi_long target_to_host_sigevent(struct sigevent *host_se=
vp,
>                                                  abi_ulong target_addr)
> @@ -6840,6 +6880,7 @@ static inline abi_long host_to_target_statx(struct =
target_statx *host_stx,
>      futexes locally would make futexes shared between multiple processes
>      tricky.  However they're probably useless because guest atomic
>      operations won't work either.  */
> +#if defined(TARGET_NR_futex)
>   static int do_futex(target_ulong uaddr, int op, int val, target_ulong t=
imeout,
>                       target_ulong uaddr2, int val3)
>   {
> @@ -6886,6 +6927,7 @@ static int do_futex(target_ulong uaddr, int op, int=
 val, target_ulong timeout,
>           return -TARGET_ENOSYS;
>       }
>   }
> +#endif
>   #if defined(TARGET_NR_name_to_handle_at) && defined(CONFIG_OPEN_BY_HAND=
LE)
>   static abi_long do_name_to_handle_at(abi_long dirfd, abi_long pathname,
>                                        abi_long handle, abi_long mount_id=
,
> @@ -8494,6 +8536,7 @@ static abi_long do_syscall1(void *cpu_env, int num,=
 abi_long arg1,
>               }
>           }
>           return ret;
> +#ifdef TARGET_NR_rt_sigtimedwait
>       case TARGET_NR_rt_sigtimedwait:
>           {
>               sigset_t set;
> @@ -8530,6 +8573,7 @@ static abi_long do_syscall1(void *cpu_env, int num,=
 abi_long arg1,
>               }
>           }
>           return ret;
> +#endif
>       case TARGET_NR_rt_sigqueueinfo:
>           {
>               siginfo_t uinfo;
> @@ -8629,6 +8673,7 @@ static abi_long do_syscall1(void *cpu_env, int num,=
 abi_long arg1,
>               }
>           }
>           return ret;
> +#if defined(TARGET_NR_gettimeofday)
>       case TARGET_NR_gettimeofday:
>           {
>               struct timeval tv;
> @@ -8639,6 +8684,8 @@ static abi_long do_syscall1(void *cpu_env, int num,=
 abi_long arg1,
>               }
>           }
>           return ret;
> +#endif
> +#if defined(TARGET_NR_settimeofday)
>       case TARGET_NR_settimeofday:
>           {
>               struct timeval tv, *ptv =3D NULL;
> @@ -8660,6 +8707,7 @@ static abi_long do_syscall1(void *cpu_env, int num,=
 abi_long arg1,
>  =20
>               return get_errno(settimeofday(ptv, ptz));
>           }
> +#endif
>   #if defined(TARGET_NR_select)
>       case TARGET_NR_select:
>   #if defined(TARGET_WANT_NI_OLD_SELECT)
> @@ -9131,6 +9179,8 @@ static abi_long do_syscall1(void *cpu_env, int num,=
 abi_long arg1,
>   #ifdef TARGET_NR_sendmmsg
>       case TARGET_NR_sendmmsg:
>           return do_sendrecvmmsg(arg1, arg2, arg3, arg4, 1);
> +#endif
> +#ifdef TARGET_NR_recvmmsg
>       case TARGET_NR_recvmmsg:
>           return do_sendrecvmmsg(arg1, arg2, arg3, arg4, 0);
>   #endif
> @@ -9305,6 +9355,7 @@ static abi_long do_syscall1(void *cpu_env, int num,=
 abi_long arg1,
>           return do_syscall(cpu_env, arg1 & 0xffff, arg2, arg3, arg4, arg=
5,
>                             arg6, arg7, arg8, 0);
>   #endif
> +#if defined(TARGET_NR_wait4)
>       case TARGET_NR_wait4:
>           {
>               int status;
> @@ -9332,6 +9383,7 @@ static abi_long do_syscall1(void *cpu_env, int num,=
 abi_long arg1,
>               }
>           }
>           return ret;
> +#endif
>   #ifdef TARGET_NR_swapoff
>       case TARGET_NR_swapoff:
>           if (!(p =3D lock_user_string(arg1)))
> @@ -9476,6 +9528,7 @@ static abi_long do_syscall1(void *cpu_env, int num,=
 abi_long arg1,
>           return do_vm86(cpu_env, arg1, arg2);
>   #endif
>   #endif
> +#if defined(TARGET_NR_adjtimex)
>       case TARGET_NR_adjtimex:
>           {
>               struct timex host_buf;
> @@ -9491,6 +9544,7 @@ static abi_long do_syscall1(void *cpu_env, int num,=
 abi_long arg1,
>               }
>           }
>           return ret;
> +#endif
>   #if defined(TARGET_NR_clock_adjtime) && defined(CONFIG_CLOCK_ADJTIME)
>       case TARGET_NR_clock_adjtime:
>           {
> @@ -10007,6 +10061,7 @@ static abi_long do_syscall1(void *cpu_env, int nu=
m, abi_long arg1,
>           return get_errno(sched_get_priority_max(arg1));
>       case TARGET_NR_sched_get_priority_min:
>           return get_errno(sched_get_priority_min(arg1));
> +#ifdef TARGET_NR_sched_rr_get_interval
>       case TARGET_NR_sched_rr_get_interval:
>           {
>               struct timespec ts;
> @@ -10016,6 +10071,8 @@ static abi_long do_syscall1(void *cpu_env, int nu=
m, abi_long arg1,
>               }
>           }
>           return ret;
> +#endif
> +#if defined(TARGET_NR_nanosleep)
>       case TARGET_NR_nanosleep:
>           {
>               struct timespec req, rem;
> @@ -10026,6 +10083,7 @@ static abi_long do_syscall1(void *cpu_env, int nu=
m, abi_long arg1,
>               }
>           }
>           return ret;
> +#endif
>       case TARGET_NR_prctl:
>           switch (arg1) {
>           case PR_GET_PDEATHSIG:
> @@ -11496,8 +11554,10 @@ static abi_long do_syscall1(void *cpu_env, int n=
um, abi_long arg1,
>           }
>           return ret;
>   #endif
> +#ifdef TARGET_NR_futex
>       case TARGET_NR_futex:
>           return do_futex(arg1, arg2, arg3, arg4, arg5, arg6);
> +#endif
>   #if defined(TARGET_NR_inotify_init) && defined(__NR_inotify_init)
>       case TARGET_NR_inotify_init:
>           ret =3D get_errno(sys_inotify_init());
> @@ -11562,6 +11622,7 @@ static abi_long do_syscall1(void *cpu_env, int nu=
m, abi_long arg1,
>           unlock_user (p, arg1, 0);
>           return ret;
>  =20
> +#ifdef TARGET_NR_mq_timedsend
>       case TARGET_NR_mq_timedsend:
>           {
>               struct timespec ts;
> @@ -11577,7 +11638,9 @@ static abi_long do_syscall1(void *cpu_env, int nu=
m, abi_long arg1,
>               unlock_user (p, arg2, arg3);
>           }
>           return ret;
> +#endif
>  =20
> +#ifdef TARGET_NR_mq_timedreceive
>       case TARGET_NR_mq_timedreceive:
>           {
>               struct timespec ts;
> @@ -11598,6 +11661,7 @@ static abi_long do_syscall1(void *cpu_env, int nu=
m, abi_long arg1,
>                   put_user_u32(prio, arg4);
>           }
>           return ret;
> +#endif
>  =20
>       /* Not implemented for now... */
>   /*     case TARGET_NR_mq_notify: */
>=20

I hope I didn't miss anything:

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


