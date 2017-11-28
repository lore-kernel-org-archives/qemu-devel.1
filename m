Received: from eggs.gnu.org ([2001:4830:134:3::10]:52533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eJfeW-0005Kd-Dz
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 08:10:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eJfeQ-0007Uz-DE
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 08:10:20 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:36497)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eJfeP-0007Ue-QE
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 08:10:14 -0500
Received: by mail-ot0-x241.google.com with SMTP id t79so240393ota.3
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 05:10:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170112040534.15179-1-rth@twiddle.net>
References: <20170112040534.15179-1-rth@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Nov 2017 13:09:52 +0000
Message-ID: <CAFEAcA-VKJ2AnbDh1FSw1VHJ4WYz7AsE9ScSfNb74bZtELpe5Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] linux-user: Use *at functions instead of
 caching interp_prefix contents
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>

On 12 January 2017 at 04:05, Richard Henderson <rth@twiddle.net> wrote:
> If the interp_prefix is a complete chroot, it may have a *lot* of files.
> Setting up the cache for this is quite expensive.  Instead, use the *at
> versions of various syscalls to attempt the operation in the prefix.
>
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  linux-user/elfload.c |  12 ++-
>  linux-user/main.c    |   3 +-
>  linux-user/qemu.h    |   1 +
>  linux-user/syscall.c | 236 ++++++++++++++++++++++++++++++++++++++++++---------
>  util/Makefile.objs   |   2 +-
>  util/path.c          | 178 --------------------------------------
>  6 files changed, 209 insertions(+), 223 deletions(-)
>  delete mode 100644 util/path.c
>
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 547053c..8b947fd 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -2026,7 +2026,17 @@ static void load_elf_interp(const char *filename, struct image_info *info,
>  {
>      int fd, retval;
>
> -    fd = open(path(filename), O_RDONLY);
> +    switch (filename[0]) {
> +    case '/':
> +        fd = openat(interp_dirfd, filename + 1, O_RDONLY);
> +        if (fd >= 0 || errno != ENOENT) {
> +            break;
> +        }
> +        /* fallthru */
> +    default:
> +        fd = open(filename, O_RDONLY);
> +        break;
> +    }
>      if (fd < 0) {
>          goto exit_perror;
>      }
> diff --git a/linux-user/main.c b/linux-user/main.c
> index c1d5eb4..dba988b 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -81,6 +81,7 @@ unsigned long reserved_va;
>  static void usage(int exitcode);
>
>  static const char *interp_prefix = CONFIG_QEMU_INTERP_PREFIX;
> +int interp_dirfd;
>  const char *qemu_uname_release;
>
>  /* XXX: on x86 MAP_GROWSDOWN only works if ESP <= address + 32, so
> @@ -4013,7 +4014,7 @@ int main(int argc, char **argv, char **envp)
>      memset(&bprm, 0, sizeof (bprm));
>
>      /* Scan interp_prefix dir for replacement files. */
> -    init_paths(interp_prefix);
> +    interp_dirfd = open(interp_prefix, O_CLOEXEC | O_DIRECTORY | O_PATH);

I've been using this patch over the last week or so as a convenient
way of being able to run guest binaries without having to actually use
chroot, and I just noticed a bug here:
if the interp_prefix doesn't exist, this will set interp_dirfd to -1
and then every file access will fail with EBADF. We should treat "prefix
doesn't exist" like "don't use a prefix", because by default we use
/usr/gnemul/qemu-something, which probably doesn't exist for most people.

thanks
-- PMM
