Received: from eggs.gnu.org ([2001:4830:134:3::10]:45367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gF3ed-0003Cz-O9
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 16:51:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gF3c0-0001vf-TB
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 16:49:17 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:43329)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gF3c0-0001tG-Bx
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 16:49:12 -0400
References: <1540300056-7935-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1540300056-7935-2-git-send-email-aleksandar.markovic@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <ee2154c6-d236-2aac-16de-733f1cb70cfc@vivier.eu>
Date: Tue, 23 Oct 2018 21:48:25 +0100
MIME-Version: 1.0
In-Reply-To: <1540300056-7935-2-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/3] linux-user: Add support for statx()
 syscall
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, arikalo@wavecomp.com, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, riku.voipio@iki.fi, ysu@wavecomp.com

On 23/10/2018 14:07, Aleksandar Markovic wrote:
> From: Aleksandar Rikalo <arikalo@wavecomp.com>
> 
> Implement support for translation of system call statx(). The
> implementation includes invoking other (more mature) syscalls
> (from the same 'stat' family) on the host side. This way,
> problems of availability of statx() on the host side are
> avoided.
> 
> Signed-off-by: Aleksandar Rikalo <arikalo@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  linux-user/syscall.c      | 129 +++++++++++++++++++++++++++++++++++++++++++++-
>  linux-user/syscall_defs.h |  38 ++++++++++++++
>  2 files changed, 166 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index d2cc971..8b01ab0 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -6710,7 +6710,8 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>      abi_long ret;
>  #if defined(TARGET_NR_stat) || defined(TARGET_NR_stat64) \
>      || defined(TARGET_NR_lstat) || defined(TARGET_NR_lstat64) \
> -    || defined(TARGET_NR_fstat) || defined(TARGET_NR_fstat64)
> +    || defined(TARGET_NR_fstat) || defined(TARGET_NR_fstat64) \
> +    || defined(TARGET_NR_statx)
>      struct stat st;
>  #endif
>  #if defined(TARGET_NR_statfs) || defined(TARGET_NR_statfs64) \
> @@ -9635,6 +9636,132 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>              ret = host_to_target_stat64(cpu_env, arg3, &st);
>          return ret;
>  #endif
> +#if defined(TARGET_NR_statx)
> +    case TARGET_NR_statx:
> +        {
> +            struct target_statx *target_stx;
> +            int dirfd = tswap32(arg1);
> +            int flags = tswap32(arg3);
> +

Normally arg1, arg3 are already in the host byte order (like arg2 below)

> +            p = lock_user_string(arg2);
> +            if (p == NULL) {
> +                return -TARGET_EFAULT;
> +            }
> +#if defined(__NR_statx)
> +            {
> +                /*
> +                 * It is assumed that struct statx is arhitecture independent
> +                 */
> +                struct target_statx host_stx;

if it is host_statx, the structure to use is statx, not target_statx.

> +                int mask = tswap32(arg4);

no tswap32() needed

> +
> +                ret = get_errno(syscall(__NR_statx, dirfd, p, flags, mask,
> +                                        &host_stx));
> +                if (!is_error(ret)) {
> +                    unlock_user(p, arg2, 0);
> +                    if (!lock_user_struct(VERIFY_WRITE, target_stx, arg5, 0)) {
> +                        return -TARGET_EFAULT;
> +                    }
> +                    memset(target_stx, 0, sizeof(*target_stx));


It would be clearer to put the following conversion lines into a
separate function like host_to_target_statx().

> +                    __put_user(host_stx.stx_mask, &target_stx->stx_mask);
> +                    __put_user(host_stx.stx_blksize, &target_stx->stx_blksize);
> +                    __put_user(host_stx.stx_attributes,
> +                               &target_stx->stx_attributes);
> +                    __put_user(host_stx.stx_nlink, &target_stx->stx_nlink);
> +                    __put_user(host_stx.stx_uid, &target_stx->stx_uid);
> +                    __put_user(host_stx.stx_gid, &target_stx->stx_gid);
> +                    __put_user(host_stx.stx_mode, &target_stx->stx_mode);
> +                    __put_user(host_stx.stx_ino, &target_stx->stx_ino);
> +                    __put_user(host_stx.stx_size, &target_stx->stx_size);
> +                    __put_user(host_stx.stx_blocks, &target_stx->stx_blocks);
> +                    __put_user(host_stx.stx_attributes_mask,
> +                               &target_stx->stx_attributes_mask);

perhaps you can also define host_target_statx_timestamp() function to
convert the timestamps.

> +                    __put_user(host_stx.stx_atime.tv_sec,
> +                               &target_stx->stx_atime.tv_sec);
> +                    __put_user(host_stx.stx_atime.tv_nsec,
> +                               &target_stx->stx_atime.tv_nsec);
> +                    __put_user(host_stx.stx_btime.tv_sec,
> +                               &target_stx->stx_atime.tv_sec);
> +                    __put_user(host_stx.stx_btime.tv_nsec,
> +                               &target_stx->stx_atime.tv_nsec);
> +                    __put_user(host_stx.stx_ctime.tv_sec,
> +                               &target_stx->stx_atime.tv_sec);
> +                    __put_user(host_stx.stx_ctime.tv_nsec,
> +                               &target_stx->stx_atime.tv_nsec);
> +                    __put_user(host_stx.stx_mtime.tv_sec,
> +                               &target_stx->stx_atime.tv_sec);
> +                    __put_user(host_stx.stx_mtime.tv_nsec,
> +                               &target_stx->stx_atime.tv_nsec);
> +                    __put_user(host_stx.stx_rdev_major,
> +                               &target_stx->stx_rdev_major);
> +                    __put_user(host_stx.stx_rdev_minor,
> +                               &target_stx->stx_rdev_minor);
> +                    __put_user(host_stx.stx_dev_major,
> +                               &target_stx->stx_dev_major);
> +                    __put_user(host_stx.stx_dev_minor,
> +                               &target_stx->stx_dev_minor);
> +                }
> +
> +                if (ret != TARGET_ENOSYS) {
> +                    break;

it should be "return ret;"

> +                }
> +            }
> +#endif

You use p here as it can be unlocked in the last 'if" body".

> +            if ((p == NULL) || (*((char *)p) == 0)) {
> +                /*
> +                 * By file descriptor
> +                 */

if AT_EMPY_PATH is not specified in the flags, you should return -ENOENT

> +                ret = get_errno(fstat(dirfd, &st));
> +                unlock_user(p, arg2, 0);
> +            } else if (*((char *)p) == '/') {
> +                /*
> +                 * By absolute pathname
> +                 */
> +                ret = get_errno(stat(path(p), &st));
> +                unlock_user(p, arg2, 0);
> +            } else {
> +                if (dirfd == AT_FDCWD) {
> +                    /*
> +                     * By pathname relative to the current working directory
> +                     */
> +                    ret = get_errno(stat(path(p), &st));
> +                    unlock_user(p, arg2, 0);
> +                } else {
> +                    /*
> +                     * By pathname relative to the directory referred to by
> +                     * the file descriptor 'dirfd'
> +                     */
> +                    ret = get_errno(fstatat(dirfd, path(p), &st, flags));
> +                    unlock_user(p, arg2, 0);
> +                }
> +            }

I think you can put the unlock_user() only once here.

> +
> +            if (!is_error(ret)) {
> +                if (!lock_user_struct(VERIFY_WRITE, target_stx, arg5, 0)) {
> +                    return -TARGET_EFAULT;
> +                }
> +                memset(target_stx, 0, sizeof(*target_stx));
> +                __put_user(major(st.st_dev), &target_stx->stx_dev_major);
> +                __put_user(minor(st.st_dev), &target_stx->stx_dev_minor);
> +                __put_user(st.st_ino, &target_stx->stx_ino);
> +                __put_user(st.st_mode, &target_stx->stx_mode);
> +                __put_user(st.st_uid, &target_stx->stx_uid);
> +                __put_user(st.st_gid, &target_stx->stx_gid);
> +                __put_user(st.st_nlink, &target_stx->stx_nlink);
> +                __put_user(major(st.st_rdev), &target_stx->stx_rdev_major);
> +                __put_user(minor(st.st_rdev), &target_stx->stx_rdev_minor);
> +                __put_user(st.st_size, &target_stx->stx_size);
> +                __put_user(st.st_blksize, &target_stx->stx_blksize);
> +                __put_user(st.st_blocks, &target_stx->stx_blocks);
> +                __put_user(st.st_atime, &target_stx->stx_atime.tv_sec);
> +                __put_user(st.st_mtime, &target_stx->stx_mtime.tv_sec);
> +                __put_user(st.st_ctime, &target_stx->stx_ctime.tv_sec);
> +                unlock_user_struct(target_stx, arg5, 1);
> +            }
> +        }
> +        break;

should be "return ret;" now.

> +#endif
>  #ifdef TARGET_NR_lchown
>      case TARGET_NR_lchown:
>          if (!(p = lock_user_string(arg1)))
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 18d434d..b6c5c4f 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -2488,4 +2488,42 @@ struct target_user_cap_data {
>  /* Return size of the log buffer */
>  #define TARGET_SYSLOG_ACTION_SIZE_BUFFER   10
>  
> +struct target_statx_timestamp {
> +   int64_t tv_sec;
> +   uint32_t tv_nsec;
> +   int32_t __reserved;
> +};

You sould use abi_ullong, abi_uint and abi_int to have the good
alignment in the structure.

> +
> +struct target_statx {
> +   /* 0x00 */
> +   uint32_t stx_mask;       /* What results were written [uncond] */
> +   uint32_t stx_blksize;    /* Preferred general I/O size [uncond] */
> +   uint64_t stx_attributes; /* Flags conveying information about the file */
> +   /* 0x10 */
> +   uint32_t stx_nlink;      /* Number of hard links */
> +   uint32_t stx_uid;        /* User ID of owner */
> +   uint32_t stx_gid;        /* Group ID of owner */
> +   uint16_t stx_mode;       /* File mode */
> +   uint16_t __spare0[1];
> +   /* 0x20 */
> +   uint64_t stx_ino;        /* Inode number */
> +   uint64_t stx_size;       /* File size */
> +   uint64_t stx_blocks;     /* Number of 512-byte blocks allocated */
> +   uint64_t stx_attributes_mask; /* Mask to show what's supported in
> +                                    stx_attributes */
> +   /* 0x40 */
> +   struct target_statx_timestamp  stx_atime;  /* Last access time */
> +   struct target_statx_timestamp  stx_btime;  /* File creation time */
> +   struct target_statx_timestamp  stx_ctime;  /* Last attribute change time */
> +   struct target_statx_timestamp  stx_mtime;  /* Last data modification time */
> +   /* 0x80 */
> +   uint32_t stx_rdev_major;   /* Device ID of special file [if bdev/cdev] */
> +   uint32_t stx_rdev_minor;
> +   uint32_t stx_dev_major; /* ID of device containing file [uncond] */
> +   uint32_t stx_dev_minor;
> +   /* 0x90 */
> +   uint64_t __spare2[14];  /* Spare space for future expansion */
> +   /* 0x100 */
> +};
>

Same here use abi_XXX types.

>  #endif
> 

Thanks,
Laurent
