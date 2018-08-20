Received: from eggs.gnu.org ([2001:4830:134:3::10]:49215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <T.E.Baldwin99@members.leeds.ac.uk>)
	id 1frevU-0005fe-PU
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 03:48:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <T.E.Baldwin99@members.leeds.ac.uk>)
	id 1frevQ-00013W-Ol
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 03:48:36 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:55241)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <T.E.Baldwin99@members.leeds.ac.uk>)
	id 1frevQ-0000x8-Jc
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 03:48:32 -0400
References: <1534182832-554-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1534182832-554-82-git-send-email-aleksandar.markovic@rt-rk.com>
From: Timothy Baldwin <T.E.Baldwin99@members.leeds.ac.uk>
Message-ID: <c9eb581f-3f03-c28e-4095-3064e556f7c0@members.leeds.ac.uk>
Date: Mon, 20 Aug 2018 08:48:20 +0100
MIME-Version: 1.0
In-Reply-To: <1534182832-554-82-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 81/87] linux-user: Add support for
 statx() syscall for all platforms
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, pburton@wavecomp.com, smarkovic@wavecomp.com, riku.voipio@iki.fi, richard.henderson@linaro.org, laurent@vivier.eu, philippe.mathieu.daude@gmail.com, amarkovic@wavecomp.com, pjovanovic@wavecomp.com, aurelien@aurel32.net

On 13/08/18 18:53, Aleksandar Markovic wrote:
> From: Aleksandar Rikalo <arikalo@wavecomp.com>
> 
> Implement support for translation of system call statx(). The
> implementation includes invoking other (more mature) syscalls
> (from the same 'stat' family) on the host side. This way,
> problems of availability of statx() on the host side are
> avoided.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>   linux-user/syscall.c      | 121 +++++++++++++++++++++++++++++++++++++++++++++-
>   linux-user/syscall_defs.h |  38 +++++++++++++++
>   2 files changed, 158 insertions(+), 1 deletion(-)
> 


> +            if ((p == NULL) || (*((char *)p) == 0)) {
> +                /* By file descriptor */
> +                ret = get_errno(fstat(dirfd, &st));
> +                unlock_user(p, arg2, 0);
> +            } else if (*((char *)p) == '/') {
> +                /* Absolute pathname */
> +                ret = get_errno(stat(path(p), &st));
> +                unlock_user(p, arg2, 0);
> +            } else {
> +                if (dirfd == AT_FDCWD) {
> +                    /* Pathname relative to the current working directory */
> +                    ret = get_errno(stat(path(p), &st));
> +                    unlock_user(p, arg2, 0);
> +                } else {
> +                    /*
> +                     * Pathname relative to the directory referred to by the
> +                     * file descriptor dirfd
> +                     */
> +                    ret = get_errno(fstatat(dirfd, path(p), &st, flags));
> +                    unlock_user(p, arg2, 0);
> +                }
> +            }

This doesn't correctly handle the flags argument, it is ignored unless a 
relative path and directory file descriptor is provided. As such an 
implementation of lstat that uses statx will be broken.

Since fstatat exists since 2.6.16 this can be reduced to a call to fstatat.
