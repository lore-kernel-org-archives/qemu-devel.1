Received: from eggs.gnu.org ([2001:4830:134:3::10]:38259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gQEsf-0001e2-6M
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 12:04:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gQEsZ-0002mH-BQ
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 12:04:37 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34301)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gQEsZ-0002jw-2q
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 12:04:31 -0500
Received: by mail-wr1-x442.google.com with SMTP id j2so13012461wrw.1
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 09:04:30 -0800 (PST)
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-22-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025172057.20414-22-cota@braap.org>
Date: Fri, 23 Nov 2018 17:04:28 +0000
Message-ID: <87o9afhgir.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 21/48] *-user: plugin syscalls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?utf-8?Q?Llu=C3=ADs?= Vilanova <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>


Emilio G. Cota <cota@braap.org> writes:

> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  bsd-user/syscall.c   | 9 +++++++++
>  linux-user/syscall.c | 3 +++
>  2 files changed, 12 insertions(+)
>
> diff --git a/bsd-user/syscall.c b/bsd-user/syscall.c
> index b7818af450..4993f81b2b 100644
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

I think we discussed this on my series about avoiding this sort of
duplication by providing a wrapper for trace points that are also plugin
hooks. So something like:

       trace_and_plugin_guest_user_syscall(...)

Although it's probably worth keeping the trace names grep-able so maybe:

       plug_trace_guest_user_syscall(...)

?
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
> index ae3c0dfef7..a6d17a9f37 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -11232,6 +11232,8 @@ abi_long do_syscall(void *cpu_env, int num, abi_l=
ong arg1,
>
>      trace_guest_user_syscall(cpu, num, arg1, arg2, arg3, arg4,
>                               arg5, arg6, arg7, arg8);
> +    qemu_plugin_vcpu_syscall(cpu, num, arg1, arg2, arg3, arg4, arg5, arg=
6, arg7,
> +                             arg8);
>
>      if (unlikely(do_strace)) {
>          print_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
> @@ -11244,5 +11246,6 @@ abi_long do_syscall(void *cpu_env, int num, abi_l=
ong arg1,
>      }
>
>      trace_guest_user_syscall_ret(cpu, num, ret);
> +    qemu_plugin_vcpu_syscall_ret(cpu, num, ret);
>      return ret;
>  }


--
Alex Benn=C3=A9e
