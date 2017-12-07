Received: from eggs.gnu.org ([2001:4830:134:3::10]:35808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eMvsL-0000cN-GV
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 08:06:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eMvsK-0001qN-9y
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 08:06:05 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:44180)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eMvsK-0001q6-5D
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 08:06:04 -0500
Received: by mail-ot0-x243.google.com with SMTP id d27so6257646ote.11
	for <qemu-devel@nongnu.org>; Thu, 07 Dec 2017 05:06:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171205044844.3597-1-richard.henderson@linaro.org>
References: <20171205044844.3597-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Dec 2017 13:05:42 +0000
Message-ID: <CAFEAcA-i7pFPwdTvW=4VeRXfJC6hYD=PY6J-Z9XZcWmAk7hwiw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] linux-user: Use *at functions instead
 of caching interp_prefix contents
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On 5 December 2017 at 04:48, Richard Henderson
<richard.henderson@linaro.org> wrote:
> From: Richard Henderson <rth@twiddle.net>
>
> If the interp_prefix is a complete chroot, it may have a *lot* of files.
> Setting up the cache for this is quite expensive.  Instead, use the *at
> versions of various syscalls to attempt the operation in the prefix.
>
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>
> Changes since v1 (Nov 2016):
>   * Require interp_dirfd set before trying the *at path.
>
>
> r~
> ---
>  linux-user/qemu.h    |   1 +
>  linux-user/elfload.c |  12 ++-
>  linux-user/main.c    |   3 +-
>  linux-user/syscall.c | 236 ++++++++++++++++++++++++++++++++++++++++++---=
------
>  4 files changed, 208 insertions(+), 44 deletions(-)
>
> diff --git a/linux-user/qemu.h b/linux-user/qemu.h
> index 4edd7d0c08..d04924fd2e 100644
> --- a/linux-user/qemu.h
> +++ b/linux-user/qemu.h
> @@ -437,6 +437,7 @@ void mmap_fork_start(void);
>  void mmap_fork_end(int child);
>
>  /* main.c */
> +extern int interp_dirfd;
>  extern unsigned long guest_stack_size;
>
>  /* user access */
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 20f3d8c2c3..5d3f7aa11d 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -2203,7 +2203,17 @@ static void load_elf_interp(const char *filename, =
struct image_info *info,
>  {
>      int fd, retval;
>
> -    fd =3D open(path(filename), O_RDONLY);
> +    switch (interp_dirfd > 0 && filename[0] =3D=3D '/') {
> +    case true:

gcc doesn't like this pattern:

/home/petmay01/linaro/qemu-from-laptop/qemu/linux-user/syscall.c: In
function =E2=80=98do_name_to_handle_at=E2=80=99:
/home/petmay01/linaro/qemu-from-laptop/qemu/linux-user/syscall.c:7231:13:
error: switch condition has boolean value [-Werror=3Dswitch-bool]
     switch (interp_dirfd > 0 && name[0] =3D=3D '/') {
             ^

It seems like an odd way to write an if().

thanks
-- PMM
