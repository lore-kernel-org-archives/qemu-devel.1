Received: from eggs.gnu.org ([2001:4830:134:3::10]:57063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHvcE-00035V-1L
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 11:44:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHvcC-0006MW-Qk
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 11:44:14 -0500
Received: from mail-ua0-x234.google.com ([2607:f8b0:400c:c08::234]:35768)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cHvcC-0006M9-Bp
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 11:44:12 -0500
Received: by mail-ua0-x234.google.com with SMTP id 12so43324051uas.2
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 08:44:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1480003738-8754-2-git-send-email-Lena.Djokic@rt-rk.com>
References: <1480003738-8754-1-git-send-email-Lena.Djokic@rt-rk.com>
	<1480003738-8754-2-git-send-email-Lena.Djokic@rt-rk.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Dec 2016 16:43:50 +0000
Message-ID: <CAFEAcA-5v-jMtL1MVS4evMGiL2vdmFGFKe7KBQ=dO3p8DWi0sA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 1/7] linux-user: Add fanotify
 implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lena Djokic <Lena.Djokic@rt-rk.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>

On 24 November 2016 at 16:08, Lena Djokic <Lena.Djokic@rt-rk.com> wrote:
> This commit adds implementation of fanotify_init and fanotify_mark.
> Second argument for fanotify_init needs conversion because of flags
> which can be FAN_NONBLOCK and FAN_CLOEXEC which rely on O_NONBLOCK
> and O_CLOEXEC and those can have different values on different platforms.
> For fanotify_mark argument layout is different for 32-bit and 64-bit
> platforms and this implementation have support for that situation.
> Also, support for writing and reading of file descriptor opened by
> fanotify_init is added.
> Configure file contains checks for excistence of fanotify support on
> given build system.
>
> Signed-off-by: Lena Djokic <Lena.Djokic@rt-rk.com>

Thanks for this patch; it looks basically the right shape
but I have some review comments below. (Also, sorry for taking
so long to get to reviewing it.)

> ---

> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 7b77503..f5d9a26 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -76,6 +76,9 @@ int __clone2(int (*fn)(void *), void *child_stack_base,
>  #ifdef CONFIG_SENDFILE
>  #include <sys/sendfile.h>
>  #endif
> +#ifdef CONFIG_FANOTIFY
> +#include <sys/fanotify.h>
> +#endif
>
>  #define termios host_termios
>  #define winsize host_winsize
> @@ -499,9 +502,13 @@ enum {
>      QEMU___IFLA_INET6_MAX
>  };
>
> +typedef abi_long (*TargetFdReadFunc)(void *, size_t);
> +typedef abi_long (*TargetFdWriteFunc)(void *, size_t);
>  typedef abi_long (*TargetFdDataFunc)(void *, size_t);
>  typedef abi_long (*TargetFdAddrFunc)(void *, abi_ulong, socklen_t);
>  typedef struct TargetFdTrans {
> +    TargetFdReadFunc read_op;
> +    TargetFdWriteFunc write_op;
>      TargetFdDataFunc host_to_target_data;
>      TargetFdDataFunc target_to_host_data;
>      TargetFdAddrFunc target_to_host_addr;

What's the difference between read_op/write_op and the existing
target_to_host_data/host_to_target_data hooks ? I feel like we
should just use the existing hooks unless there's something
specific that means they don't work. If we do need extra hooks
we should add doc comments so it's clear which hooks get
invoked in which contexts.


> +#if defined(CONFIG_FANOTIFY)
> +static inline abi_long fanotify_fd_read_op(void *buf, size_t len)
> +{
> +    struct fanotify_event_metadata *fem;
> +    int num;

This should probably be a size_t, or you have problems with
really large reads.

> +
> +    /* Read buffer for fanotify file descriptor contains one or more
> +     * of fanotify_event_metadata structures.
> +     */
> +    fem = (struct fanotify_event_metadata *)buf;
> +    num = len / sizeof(struct fanotify_event_metadata);
> +    for (int i = 0; i < num; i++) {
> +        (fem + i)->event_len = tswap32((fem + i)->event_len);
> +        /* Fields (fem+i)->vers and (fem+i)->reserved are single byte,
> +         * so swapping is not needed for them.
> +         */
> +        (fem + i)->metadata_len = tswap16((fem + i)->metadata_len);
> +        (fem + i)->mask = tswap64((fem + i)->mask);
> +        (fem + i)->fd = tswap32((fem + i)->fd);
> +        (fem + i)->pid = tswap32((fem + i)->pid);
> +    }
> +
> +    return len;
> +}
> +
> +static inline abi_long fanotify_fd_write_op(void *buf, size_t len)
> +{
> +    struct fanotify_response *fr = (struct fanotify_response *)buf;
> +
> +    fr->fd = tswap32(fr->fd);
> +    fr->response = tswap32(fr->response);
> +
> +    return len;
> +}
> +
> +static TargetFdTrans fanotify_trans = {
> +    .read_op = fanotify_fd_read_op,
> +    .write_op = fanotify_fd_write_op,
> +};
> +#endif
> +
>  /* do_syscall() should always have a single exit point at the end so
>     that actions, such as logging of syscall results, can be performed.
>     All errnos that do_syscall() returns must be -TARGET_<errcode>. */
> @@ -7613,16 +7677,27 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>              if (!(p = lock_user(VERIFY_WRITE, arg2, arg3, 0)))
>                  goto efault;
>              ret = get_errno(safe_read(arg1, p, arg3));
> -            if (ret >= 0 &&
> -                fd_trans_host_to_target_data(arg1)) {
> -                ret = fd_trans_host_to_target_data(arg1)(p, ret);
> -            }
> +            if (ret >= 0) {
> +                if (fd_trans_read_op(arg1)) {
> +                    ret = fd_trans_read_op(arg1)(p, ret);
> +                }
> +                if (fd_trans_host_to_target_data(arg1)) {
> +                    ret = fd_trans_host_to_target_data(arg1)(p, ret);
> +                }
> +             }
>              unlock_user(p, arg2, ret);
>          }
>          break;
>      case TARGET_NR_write:
>          if (!(p = lock_user(VERIFY_READ, arg2, arg3, 1)))
>              goto efault;
> +        if (fd_trans_write_op(arg1)) {
> +            ret = fd_trans_write_op(arg1)(p, arg3);
> +            if (is_error(ret)) {
> +                unlock_user(p, arg2, 0);
> +                break;
> +            }
> +        }
>          ret = get_errno(safe_write(arg1, p, arg3));
>          unlock_user(p, arg2, 0);
>          break;
> @@ -11567,6 +11642,49 @@ abi_long do_syscall(void *cpu_env, int num, abi_long arg1,
>          break;
>  #endif
>
> +#if defined(TARGET_NR_fanotify_init) && defined(CONFIG_FANOTIFY)
> +    case TARGET_NR_fanotify_init:
> +        {
> +            ret = get_errno(fanotify_init(arg1, target_to_host_bitmask(arg2,
> +                                                fcntl_flags_tbl)));
> +            if (ret >= 0) {
> +                fd_trans_register(ret, &fanotify_trans);
> +            }
> +        }
> +        break;
> +#endif
> +#if defined(TARGET_NR_fanotify_mark) && defined(CONFIG_FANOTIFY)
> +    case TARGET_NR_fanotify_mark:
> +        {
> +            p = NULL;
> +#if (TARGET_ABI_BITS == 32)
> +            if (arg6) {
> +                p = lock_user_string(arg6);
> +                if (!p) {
> +                    goto efault;
> +                }
> +            }
> +            ret = get_errno(fanotify_mark(arg1, arg2,
> +                                target_offset64(arg3, arg4), arg5 , p));
> +            if (arg6) {
> +                unlock_user(p, arg6, 0);
> +            }

The logic in the two halves of this #if is basically the same;
I think it would be clearer to write

    uint64_t mask;
    int dirfd;
    abi_long pathname_arg;

#if TARGET_ABI_BITS == 32
    mask = target_offset64(arg3, arg4);
    dirfd = arg5;
    pathname_arg = arg6;
#else
    mask = arg3;
    dirfd = arg4;
    pathname_arg = arg5;
#endif

and then share the code that actually operates on them.

> +#else
> +            if (arg5) {
> +                p = lock_user_string(arg5);
> +                if (!p) {
> +                    goto efault;
> +                }
> +            }
> +            ret = get_errno(fanotify_mark(arg1, arg2, arg3, arg4 , p));
> +            if (arg5) {
> +                unlock_user(p, arg5, 0);
> +            }

You don't need the conditional, because unlock_user(NULL, ...) is a
no-op.

> +#endif
> +        }
> +        break;
> +#endif
> +
>  #if defined(TARGET_NR_mq_open) && defined(__NR_mq_open)
>      case TARGET_NR_mq_open:
>          {
> --
> 2.7.4

thanks
-- PMM
