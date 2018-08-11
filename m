Received: from eggs.gnu.org ([2001:4830:134:3::10]:33445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1focgr-0006aH-JY
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 18:48:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1focgm-0006wJ-O9
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 18:48:57 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:59919)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1focgm-0006vL-Ds
	for qemu-devel@nongnu.org; Sat, 11 Aug 2018 18:48:52 -0400
References: <20180612005145.3375-1-richard.henderson@linaro.org>
	<20180612005145.3375-20-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <b6c59fb9-f80c-d60a-b7bb-2a5eb6f69f94@vivier.eu>
Date: Sun, 12 Aug 2018 00:48:48 +0200
MIME-Version: 1.0
In-Reply-To: <20180612005145.3375-20-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 19/19] linux-user: Split out some
 process syscalls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Le 12/06/2018 à 02:51, Richard Henderson a écrit :
> This includes clone, getgroups, gettid, setfsgid, setfsuid,
> setgroups, setsid, setuid, fork, getegid, getegid32, geteuid,
> geteuid32, getgid, getgid32, getgroups32, getpgrp, getpid,
> getppid, getresgid, getresgid32, getresuid, getresuid32,
> getuid, getuid32, getxgid, getxpid, getxuid, setfsgid32,
> setgsuid32, setgid32, setgroups32, setregid, setregid32,
> setresgid, setresgid32, setresuid, setresuid32, setreuid,
> setreuid32, setuid32, vfork.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/syscall.h           | 108 ++++
>  linux-user/strace.c            |  36 +-
>  linux-user/syscall.c           | 799 ----------------------------
>  linux-user/syscall_proc.c      | 914 +++++++++++++++++++++++++++++++++
>  linux-user/Makefile.objs       |   5 +-
>  linux-user/gen_syscall_list.py |  43 ++
>  linux-user/strace.list         | 144 ------
>  7 files changed, 1072 insertions(+), 977 deletions(-)
>  create mode 100644 linux-user/syscall_proc.c
> 
...
> diff --git a/linux-user/gen_syscall_list.py b/linux-user/gen_syscall_list.py
> index 4eb83ae9ce..9c28221bdd 100644
> --- a/linux-user/gen_syscall_list.py
> +++ b/linux-user/gen_syscall_list.py
...
> @@ -43,12 +46,38 @@ unconditional_syscalls = [
>      "pwritev",
>      "read",
>      "readv",
> +    "setfsgid",
> +    "setfsuid",
> +    "setgid",
> +    "setgroups",
> +    "setsid",
> +    "setuid",
>      "write",
>      "writev",
>  ]
>  
>  # These syscalls are only supported by some target or abis.
>  conditional_syscalls = [
> +    "fork",
> +    "getegid",
> +    "getegid32",
> +    "geteuid",
> +    "geteuid32",
> +    "getgid",
> +    "getgid32",
> +    "getgroups32",
> +    "getpgrp",
> +    "getpid",
> +    "getppid",
> +    "getresgid",
> +    "getresgid32",
> +    "getresuid",
> +    "getresuid32",
> +    "getuid",
> +    "getuid32",
> +    "getxgid",
> +    "getxpid",
> +    "getxuid",
>      "ipc",
>      "mmap",
>      "mmap2"> @@ -60,10 +89,24 @@ conditional_syscalls = [
>      "semctl",
>      "semget",
>      "semop",
> +    "setfsgid32",
> +    "setfsuid32",
> +    "setgid32",
> +    "setgroups32",
> +    "setregid",
> +    "setregid32",
> +    "setresgid",
> +    "setresgid32",
> +    "setresuid",
> +    "setresuid32",
> +    "setreuid",
> +    "setreuid32",
> +    "setuid32",
>      "shmat",
>      "shmctl",
>      "shmdt",
>      "shmget",
> +    "vfork",
>  ]

At least the following syscalls are missing in the list:

get_thread_area, set_thread_area, set_tid_address, ...

Thanks,
Laurent
