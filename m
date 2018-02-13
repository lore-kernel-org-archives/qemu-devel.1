Received: from eggs.gnu.org ([2001:4830:134:3::10]:45228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1elZRs-0004m9-69
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:12:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1elZRq-0005uE-NG
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:12:36 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:42929)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1elZRq-0005u4-GT
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 07:12:34 -0500
Received: by mail-ot0-x241.google.com with SMTP id a7so17111461otk.9
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 04:12:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180128221510.13722-1-richard.henderson@linaro.org>
References: <20180128221510.13722-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Feb 2018 12:12:13 +0000
Message-ID: <CAFEAcA_3s_prsUy7CXP3rC-i048FeEduqe92Mwg_VrTJ7YScHg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] linux-user: Use *at functions to implement
 interp_prefix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Eric Blake <eblake@redhat.com>

On 28 January 2018 at 22:15, Richard Henderson
<richard.henderson@linaro.org> wrote:
> From: Richard Henderson <rth@twiddle.net>
>
> If the interp_prefix is a complete chroot, it may have a *lot* of files.
> Setting up the cache for this is quite expensive.
>
> For the most part, we can use the *at versions of various syscalls to
> attempt the operation in the prefix.  For the few cases that remain,
> use faccessat and create the full path on demand.
>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>
> Changes since v3 (Dec 29 2017):
>   * Use DO/WHILE as the control construct; wrap it in a macro.
>   * Introduce linux_user_path to handle the cases *at syscalls
>     do not cover.
>
> Changes since v2 (Dec 4 2017):
>   * Use IF as the control construct instead of SWITCH.
>
> Changes since v1 (Nov 2016):
>   * Require interp_dirfd set before trying the *at path.
>
>
> r~
>
> ---
>  linux-user/qemu.h    |  15 ++++++
>  linux-user/elfload.c |   5 +-
>  linux-user/main.c    |  36 +++++++++++++-
>  linux-user/syscall.c | 130 +++++++++++++++++++++++++++++++++++----------------
>  4 files changed, 141 insertions(+), 45 deletions(-)
>
> diff --git a/linux-user/qemu.h b/linux-user/qemu.h
> index 4edd7d0c08..5b621f26e0 100644
> --- a/linux-user/qemu.h
> +++ b/linux-user/qemu.h
> @@ -437,8 +437,23 @@ void mmap_fork_start(void);
>  void mmap_fork_end(int child);
>
>  /* main.c */
> +extern int interp_dirfd;
>  extern unsigned long guest_stack_size;
>
> +#define CHOOSE_INTERP(RET, PATH, OPENAT_EXPR, NORMAL_EXPR)  \
> +    do {                                                    \
> +        if (interp_dirfd >= 0 && PATH[0] == '/') {          \
> +            RET = OPENAT_EXPR;                              \
> +            if (!(RET < 0 && errno == ENOENT)) {            \
> +                break;                                      \
> +            }                                               \
> +        }                                                   \
> +        RET = NORMAL_EXPR;                                  \
> +    } while (0)
> +
> +const char *linux_user_path(const char *);
> +#define path(x)  linux_user_path(x)
> +
>  /* user access */
>
>  #define VERIFY_READ 0
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 32a47674e6..1fb097e30d 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -6,7 +6,6 @@
>
>  #include "qemu.h"
>  #include "disas/disas.h"
> -#include "qemu/path.h"
>
>  #ifdef _ARCH_PPC64
>  #undef ARCH_DLINFO
> @@ -2204,7 +2203,9 @@ static void load_elf_interp(const char *filename, struct image_info *info,
>  {
>      int fd, retval;
>
> -    fd = open(path(filename), O_RDONLY);
> +    CHOOSE_INTERP(fd, filename,
> +                  openat(interp_dirfd, filename + 1, O_RDONLY),
> +                  open(filename, O_RDONLY));
>      if (fd < 0) {
>          goto exit_perror;
>      }
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 2140465709..8f4087d508 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -23,7 +23,6 @@
>
>  #include "qapi/error.h"
>  #include "qemu.h"
> -#include "qemu/path.h"
>  #include "qemu/config-file.h"
>  #include "qemu/cutils.h"
>  #include "qemu/help_option.h"
> @@ -98,8 +97,41 @@ unsigned long reserved_va;
>  static void usage(int exitcode);
>
>  static const char *interp_prefix = CONFIG_QEMU_INTERP_PREFIX;
> +int interp_dirfd;
>  const char *qemu_uname_release;
>
> +const char *linux_user_path(const char *pathname)
> +{
> +    static THREAD size_t save_len;
> +    static THREAD char *save_buf;

I think THREAD is a remnant of when we used to support configuration
with and without NPTL, so we should be looking to get rid of it,
and just use __thread instead.

> +    size_t len, prefix_len, path_len;
> +    int e;
> +
> +    /* Only consider absolute paths.  */
> +    if (pathname[0] != '/' || interp_dirfd < 0) {
> +        return pathname;
> +    }
> +
> +    /* Test if the path within interp_dir exists.  */
> +    e = faccessat(interp_dirfd, pathname + 1, F_OK, AT_SYMLINK_NOFOLLOW);
> +    if (e < 0 && errno != ENOENT) {
> +        return pathname;
> +    }
> +
> +    /* It does -- form the new absolute path.  */
> +    prefix_len = strlen(interp_prefix);
> +    path_len = strlen(pathname) + 1;
> +    len = prefix_len + path_len;
> +    if (len <= save_len) {
> +        save_len = len;
> +        save_buf = realloc(save_buf, len);
> +    }
> +    memcpy(save_buf, interp_prefix, prefix_len);
> +    memcpy(save_buf + prefix_len, pathname, path_len);
> +
> +    return save_buf;
> +}

The split of an atomic syscall into a two-part thing involving
an existence/access check and then the syscall makes me a bit
nervous about races, but I guess there's nothing terrible that
would happen here...

I had a look at where we still need this function:
 * NR_acct
 * NR_statfs (various flavours)
 * NR_inotify_add_watch

For inotify_add_watch, we can first try the syscall on the
path inside the interp_dir, and if that fails ENOENT then
try it with the normal path.

Similarly with NR_acct and the statfs syscalls I think we can do
"try the interp_dir path first, then the other if that fails ENOENT".

That would allow us to get rid of this function entirely.

> +
>  /* XXX: on x86 MAP_GROWSDOWN only works if ESP <= address + 32, so
>     we allocate a bigger stack. Need a better solution, for example
>     by remapping the process stack directly at the right place */
> @@ -4319,7 +4351,7 @@ int main(int argc, char **argv, char **envp)
>      memset(&bprm, 0, sizeof (bprm));
>
>      /* Scan interp_prefix dir for replacement files. */
> -    init_paths(interp_prefix);
> +    interp_dirfd = open(interp_prefix, O_CLOEXEC | O_DIRECTORY | O_PATH);
>
>      init_qemu_uname_release();

I wonder if there are guest programs that make assumptions about
file descriptor numbers such that it would be worthwhile dup2'ing
the interp_dirfd away from the presumably low number fd it will
get by default into something larger...

Have you tried an LTP test run with this patchset to see whether
we get any new passes/fails ?

thanks
-- PMM
