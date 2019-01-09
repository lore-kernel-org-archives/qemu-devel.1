Received: from eggs.gnu.org ([209.51.188.92]:43992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghBZI-0007xR-N0
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 05:58:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghBZF-0001bc-T8
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 05:58:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41142)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ghBZ8-0001IQ-PL
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 05:58:32 -0500
Date: Wed, 9 Jan 2019 10:58:18 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190109105818.GG3998@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1546857926-5958-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1546857926-5958-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] configure: Force the C standard to gnu11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, pbonzini@redhat.com, peter.maydell@linaro.org

On Mon, Jan 07, 2019 at 11:45:26AM +0100, Thomas Huth wrote:
> Different versions of GCC and Clang use different versions of the C standard.
> This repeatedly caused problems already, e.g. with duplicated typedefs:
> 
>  https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg05829.html
> 
> or with for-loop variable initializers:
> 
>  https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg00237.html
> 
> To avoid these problems, we should enforce the C language version to the
> same level for all compilers. Since our minimum compiler versions are
> GCC v4.8 and Clang v3.4 now, and both basically support "gnu11" already,
> this seems to be a good choice.

In 4.x   gnu11 is marked as experimental. I'm not really comfortable
using experimental features - even if its warning free there's a risk
it would silently mis-compile something.

gnu99 is ok with 4.x - it is merely "incomplete".

> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  configure | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index 79375af..07f8105 100755
> --- a/configure
> +++ b/configure
> @@ -107,6 +107,9 @@ update_cxxflags() {
>              -Wstrict-prototypes|-Wmissing-prototypes|-Wnested-externs|\
>              -Wold-style-declaration|-Wold-style-definition|-Wredundant-decls)
>                  ;;
> +            -std=gnu11)
> +                QEMU_CXXFLAGS=${QEMU_CXXFLAGS:+$QEMU_CXXFLAGS }-std=gnu++11
> +                ;;
>              *)
>                  QEMU_CXXFLAGS=${QEMU_CXXFLAGS:+$QEMU_CXXFLAGS }$arg
>                  ;;
> @@ -585,7 +588,7 @@ ARFLAGS="${ARFLAGS-rv}"
>  # left shift of signed integers is well defined and has the expected
>  # 2s-complement style results. (Both clang and gcc agree that it
>  # provides these semantics.)
> -QEMU_CFLAGS="-fno-strict-aliasing -fno-common -fwrapv $QEMU_CFLAGS"
> +QEMU_CFLAGS="-fno-strict-aliasing -fno-common -fwrapv -std=gnu11 $QEMU_CFLAGS"
>  QEMU_CFLAGS="-Wall -Wundef -Wwrite-strings -Wmissing-prototypes $QEMU_CFLAGS"
>  QEMU_CFLAGS="-Wstrict-prototypes -Wredundant-decls $QEMU_CFLAGS"
>  QEMU_CFLAGS="-D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE $QEMU_CFLAGS"
> -- 
> 1.8.3.1
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
