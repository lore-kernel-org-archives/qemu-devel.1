Received: from eggs.gnu.org ([209.51.188.92]:56675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gj1V1-0007Vi-92
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 07:37:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gj1Uz-00016i-5a
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 07:37:51 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:40102)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gj1Uv-00014w-BG
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 07:37:47 -0500
Received: by mail-oi1-x243.google.com with SMTP id t204so17685444oie.7
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 04:37:44 -0800 (PST)
MIME-Version: 1.0
References: <1547468589-17579-1-git-send-email-thuth@redhat.com>
In-Reply-To: <1547468589-17579-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Jan 2019 12:37:32 +0000
Message-ID: <CAFEAcA-6Z2eeB6TEUVVPBk1pBEyy7vXh-cYfLaa=XEa1iUmzRg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] configure: Only build the s390-ccw bios if
 the compiler supports -march=z900
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>

On Mon, 14 Jan 2019 at 12:24, Thomas Huth <thuth@redhat.com> wrote:
>
> We want to build our s390-ccw bios with -march=z900 so that it also
> works with the oldest s390x CPU that we support with TCG. However,
> Clang on s390x does not support -march=z900 anymore, so we can not
> use this compiler to build the s390-ccw bios. Thus add a proper test
> to the configure script to see whether the compiler is usable.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  configure | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/configure b/configure
> index 05b7e85..df34974 100755
> --- a/configure
> +++ b/configure
> @@ -5906,7 +5906,10 @@ if test "$cpu" = "ppc64" -a "$targetos" != "Darwin" ; then
>  fi
>
>  if test "$cpu" = "s390x" ; then
> -  roms="$roms s390-ccw"
> +  # Only build the s390-ccw bios if the compiler supports -march=z900
> +  if "$cc" -dumpspecs 2>/dev/null | grep -q "march=z900"; then
> +    roms="$roms s390-ccw"
> +  fi
>  fi

clang doesn't support -dumpspecs at all, so you're implicitly
saying "not clang" by doing the check this way... If you
want to check "does the compiler supoprt -march=z900" why
not do a test compile with that in the compile flags ?

   write_c_skeleton
   if compile_prog "-march=z900" ""; then
       roms="$roms s390-ccw"
   fi

?

(untested)

thanks
-- PMM
