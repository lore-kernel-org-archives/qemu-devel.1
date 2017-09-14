Received: from eggs.gnu.org ([2001:4830:134:3::10]:46792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dsUZS-00013P-RM
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 09:52:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dsUZR-00020w-QS
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 09:52:46 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:43518)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dsUZR-0001y9-J9
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 09:52:45 -0400
Received: by mail-wr0-x234.google.com with SMTP id a43so6013976wrc.0
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 06:52:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170911171639.22005-1-n54@gmx.com>
References: <20170903164952.26760-1-n54@gmx.com>
	<20170911171639.22005-1-n54@gmx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Sep 2017 14:52:23 +0100
Message-ID: <CAFEAcA-wNp2T7BGih1O3-Tq1+OrYNnM1VqAneM3QfXrd5u9ZPg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] Discover openpty(3) dynamically in
 configure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Jonathan Perkin <jperkin@joyent.com>

On 11 September 2017 at 18:16, Kamil Rytarowski <n54@gmx.com> wrote:
> openpty(3) might:
>  - exists in libc (OSX)
>  - exists in libutil (GNU, BSD)
>  - does not exist (SmartOS)
>
> Add a function to discover this function in the ./configure script.
> Add new config types: CONFIG_OPENPTY_LIBC and CONFIG_OPENPTY_LIBUTIL,
> respectively defined when openpts(3) links with -lc or -lutil.
>
> Replace the condition adding -lutil in tests (for openpty(3)) from
> CONFIG_POSIX to CONFIG_OPENPTY_LIBUTIL.
>
> Replace the fallback openpty(3) impelementation comment from Solaris
> to SmartOS. Solaris is EOL'ed and it's confirmed that it does not work
> on Oracle Solaris.
> ---
>  configure              | 25 +++++++++++++++++++++++++
>  tests/Makefile.include |  2 +-
>  util/qemu-openpty.c    |  4 ++--
>  3 files changed, 28 insertions(+), 3 deletions(-)
>
> diff --git a/configure b/configure
> index fd7e3a5e81..a614adcd29 100755
> --- a/configure
> +++ b/configure
> @@ -3819,6 +3819,25 @@ EOF
>    fi
>  fi
>
> +##########################################
> +# openpty probe
> +openpty_libc=no
> +openpty_libutil=no
> +cat > $TMPC << EOF
> +extern int openpty(int *amaster, int *aslave, char *name, void *termp, void *winp);

I think the need to provide a prototype here rather than
using the system header to define it is revealing that we
also need a configure test for
 * openpty() in <pty.h>
 * openpty() in <libutil.h>
 * openpty() in <util.h>

Something like this untested code ought to do:

cat > $TMPC << EOF
#if defined(CONFIG_OPENPTY_IN_PTY_H)
#include <pty.h>
#elif defined(CONFIG_OPENPTY_IN_LIBUTIL_H)
#include <libutil.h>
#elif defined(CONFIG_OPENPTY_IN_UTIL_H)
#include <util.h>
#endif
int main(void) { return openpty(0, 0, 0, 0, 0); }
EOF

# Different platforms put openpty() in different headers,
# and may or may not need us to link against -lutil
if compile_prog -DCONFIG_OPENPTY_IN_PTY_H ""; then
  openpty_in_pty_h=yes
elif compile_prog -D_CONFIG_OPENPTY_IN_PTY_H -lutil; then
  openpty_in_pty_h=yes
  openpty_libutil=yes
elif compile_object -DCONFIG_OPENPTY_IN_LIBUTIL_H; then
  openpty_in_libutil_h=yes
elif compile_prog -D_CONFIG_OPENPTY_IN_LIBUTIL_H -lutil; then
  openpty_in_libutil_h=yes
  openpty_libutil=yes
elif compile_object -DCONFIG_OPENPTY_IN_UTIL_H; then
  openpty_in_util_h=yes
elif compile_prog -D_CONFIG_OPENPTY_IN_UTIL_H -lutil; then
  openpty_in_util_h=yes
  openpty_libutil=yes
fi

Then in qemu-openpty.c we can do

#include <termios.h>

#if defined(CONFIG_OPENPTY_IN_PTY_H)
#include <pty.h>
#elif defined(CONFIG_OPENPTY_IN_LIBUTIL_H)
#include <libutil.h>
#elif defined(CONFIG_OPENPTY_IN_UTIL_H)
#include <util.h>
#else
/* sunos fallback code */
#endif


> +if test "$openpty_libc" = "yes" ; then
> +  echo "CONFIG_OPENPTY_LIBC=y" >> $config_host_mak
> +fi


If we use the CONFIG_OPENPTY_IN_*_H constants as above
we don't need CONFIG_OPENPTY_LIBC any more.

thanks
-- PMM
