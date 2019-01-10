Received: from eggs.gnu.org ([209.51.188.92]:60007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ghb99-0001ua-Ru
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 09:17:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1ghb96-0004WU-IW
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 09:17:23 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:38915)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ghb93-0004Tp-ID
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 09:17:17 -0500
References: <20181219042113.7364-1-richard.henderson@linaro.org>
	<20181219042113.7364-9-richard.henderson@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <7fc313fc-e9da-37fc-c632-62b846831c32@vivier.eu>
Date: Thu, 10 Jan 2019 15:17:14 +0100
MIME-Version: 1.0
In-Reply-To: <20181219042113.7364-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 8/8] linux-user: Split out some process
 syscalls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

On 19/12/2018 05:21, Richard Henderson wrote:
> This includes clone, getgroups, gettid, setfsgid, setfsuid,
> setgroups, setsid, setuid, fork, getegid, getegid32, geteuid,
> geteuid32, getgid, getgid32, getgroups32, getpgrp, getpid,
> getppid, getresgid, getresgid32, getresuid, getresuid32,
> getuid, getuid32, getxgid, getxpid, getxuid, setfsgid32,
> setgsuid32, setgid32, setgroups32, setregid, setregid32,
> setresgid, setresgid32, setresuid, setresuid32, setreuid,
> setreuid32, setuid32, vfork.

I have errors with getgroups.

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/syscall-defs.h     | 121 +++++
>  linux-user/syscall.h          |   1 +
>  linux-user/strace.c           |  36 +-
>  linux-user/syscall-proc.inc.c | 861 ++++++++++++++++++++++++++++++++++
>  linux-user/syscall.c          | 677 +-------------------------
>  linux-user/strace.list        | 147 ------
>  6 files changed, 988 insertions(+), 855 deletions(-)
>  create mode 100644 linux-user/syscall-proc.inc.c
...
> diff --git a/linux-user/syscall-proc.inc.c b/linux-user/syscall-proc.inc.c
> new file mode 100644
> index 0000000000..dee441b4ff
> --- /dev/null
> +++ b/linux-user/syscall-proc.inc.c
...
> +
> +SYSCALL_IMPL(getgroups)
> +{
> +    int gidsetsize = arg1;
> +    gid_t *grouplist;
> +    abi_long ret;
> +

kernel checks for gidsetsize < 0 and returns EINVAL in this case

> +    grouplist = g_try_new(gid_t, gidsetsize);
> +    if (!grouplist) {
> +        return -TARGET_ENOMEM;
> +    }

gidsetsize == 0 is a valid case (see man) but it fails with g_try_new().
Moreover, ENOMEM is not a valid error value for getgroups().

> +    ret = get_errno(getgroups(gidsetsize, grouplist));
> +
> +    if (!is_error(ret) && gidsetsize != 0) {
> +        size_t target_grouplist_size = gidsetsize * sizeof(target_id);
> +        target_id *target_grouplist
> +            = lock_user(VERIFY_WRITE, arg2, target_grouplist_size, 0);
> +        if (target_grouplist) {
> +            int i;
> +            for (i = 0; i < ret; i++) {
> +                target_grouplist[i] = tswapid(high2lowgid(grouplist[i]));
> +            }
> +            unlock_user(target_grouplist, arg2, target_grouplist_size);
> +        } else {
> +            ret = -TARGET_EFAULT;
> +        }
> +    }
> +    g_free(grouplist);
> +    return ret;
> +}
> +
> +#ifdef TARGET_NR_getgroups32
> +SYSCALL_IMPL(getgroups32)

likewise.

Thanks,
Laurent
