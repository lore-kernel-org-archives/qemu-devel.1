Received: from eggs.gnu.org ([2001:4830:134:3::10]:38635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eoQS1-0003xA-4b
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 04:12:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eoQRx-0000zJ-VK
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 04:12:33 -0500
Received: from mail-qt0-f171.google.com ([209.85.216.171]:42714)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1eoQRx-0000yw-Qb
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 04:12:29 -0500
Received: by mail-qt0-f171.google.com with SMTP id l19so1051112qtj.9
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 01:12:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1519174995-1039-1-git-send-email-cota@braap.org>
References: <1519174995-1039-1-git-send-email-cota@braap.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 21 Feb 2018 10:12:28 +0100
Message-ID: <CAMxuvazD3r_-soineNOs1ZEdfUZdrYuCOq5j2xJVb0ZY5k7iaQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] configure: fix sanitizers' test program to
 mend ASan detection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

Hi

On Wed, Feb 21, 2018 at 2:03 AM, Emilio G. Cota <cota@braap.org> wrote:
> Commit 218bb57 ("build-sys: check static linking of UBSAN", 2018-02-13)
> adds a small test program to check whether ubsan works even when
> configuring with --static. This added program is used to
> detect all sanitizers, which breaks ASan's detection since the
> compilation fails with -fsanitize=3Daddress, at least with gcc 5.4.0
> and 7.2.0:
>
>   qemu-conf.c: In function =E2=80=98main=E2=80=99:
>   qemu-conf.c:3:20: error: integer overflow in expression [-Werror=3Dover=
flow]
>      return INT32_MIN / -1;
>                       ^
>   cc1: all warnings being treated as errors


I sent a patch a few days ago:
"[PATCH 1/6] build-sys: fix -fsanitize=3Daddress check"

>
> Fix it by:
>
> - Changing the test program to one that incurs undefined behaviour that i=
sn't
>   detected at compile-time, even with -fsanitize=3Daddress.
>
> - To be extra safe (since compilers might evolve and eventually figure ou=
t
>   the UB at compile-time), use this newly-added test only when checking
>   for UBSan; use the skeleton otherwise.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  configure | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/configure b/configure
> index 913e148..56f647f 100755
> --- a/configure
> +++ b/configure
> @@ -5306,13 +5306,13 @@ fi
>  ##########################################
>  # checks for sanitizers
>
> -# we could use a simple skeleton for flags checks, but this also
> -# detect the static linking issue of ubsan, see also:
> +# Use this program to detect the static linking issue of ubsan; see
>  # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D84285
>  cat > $TMPC << EOF
> -#include <stdint.h>
> -int main(void) {
> -  return INT32_MIN / -1;
> +int main(int argc, char **argv) {
> +  int k =3D 0x7fffffff;
> +  k +=3D argc;
> +  return 0;
>  }
>  EOF
>
> @@ -5322,12 +5322,16 @@ have_asan_iface_h=3Dno
>  have_asan_iface_fiber=3Dno
>
>  if test "$sanitizers" =3D "yes" ; then
> +  if compile_prog "$CPU_CFLAGS -Werror -fsanitize=3Dundefined" ""; then
> +    have_ubsan=3Dyes
> +  fi
> +
> +  # Use the skeleton for all other sanitizer checks
> +  write_c_skeleton
> +
>    if compile_prog "$CPU_CFLAGS -Werror -fsanitize=3Daddress" ""; then
>        have_asan=3Dyes
>    fi
> -  if compile_prog "$CPU_CFLAGS -Werror -fsanitize=3Dundefined" ""; then
> -      have_ubsan=3Dyes
> -  fi
>
>    if check_include "sanitizer/asan_interface.h" ; then
>        have_asan_iface_h=3Dyes
> --
> 2.7.4
>
