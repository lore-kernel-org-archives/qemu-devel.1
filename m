Received: from eggs.gnu.org ([2001:4830:134:3::10]:34745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ffpCZ-0000e8-H9
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 12:21:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ffpCW-00007C-8r
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 12:21:19 -0400
Date: Wed, 18 Jul 2018 17:21:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180718162111.GR9812@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180712192603.11599-1-sw@weilnetz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180712192603.11599-1-sw@weilnetz.de>
Subject: Re: [Qemu-devel] [PATCH] configure: Support pkg-config for zlib
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>
Cc: QEMU Developer <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>

On Thu, Jul 12, 2018 at 09:26:03PM +0200, Stefan Weil wrote:
> This is needed for builds with the mingw64-* packages from Cygwin,
> but also works for Linux.
> 
> Move the zlib test also more to the end because users should
> get information on the really important missing packages
> (which also require zlib) first.

According to the zlib Changelog file pkgconfig support was added
in 2006 !

[quote]
Changes in 1.2.3.1 (16 August 2006)

  - Add pkgconfig support [Weigelt]
[/quote]

Given our target build platforms support guidelines

  https://qemu.weilnetz.de/doc/qemu-doc.html#Supported-build-platforms

we can safely say that all supported platforms will have a zlib
that contains pkgconfig support, so......

> 
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> ---
>  configure | 40 +++++++++++++++++++++++-----------------
>  1 file changed, 23 insertions(+), 17 deletions(-)
> 
> diff --git a/configure b/configure
> index 2a7796ea80..dcaab01729 100755
> --- a/configure
> +++ b/configure
> @@ -2140,23 +2140,6 @@ EOF
>    fi
>  fi
>  
> -#########################################
> -# zlib check
> -
> -if test "$zlib" != "no" ; then
> -    cat > $TMPC << EOF
> -#include <zlib.h>
> -int main(void) { zlibVersion(); return 0; }
> -EOF
> -    if compile_prog "" "-lz" ; then
> -        :
> -    else
> -        error_exit "zlib check failed" \
> -            "Make sure to have the zlib libs and headers installed."
> -    fi
> -fi
> -LIBS="$LIBS -lz"
> -
>  ##########################################
>  # lzo check
>  
> @@ -3525,6 +3508,29 @@ if ! compile_prog "$glib_cflags -Werror" "$glib_libs" ; then
>      fi
>  fi
>  
> +#########################################
> +# zlib check
> +
> +if test "$zlib" != "no" ; then
> +    if $pkg_config --exists zlib; then
> +        zlib_cflags=$($pkg_config --cflags zlib)
> +        zlib_libs=$($pkg_config --libs zlib)
> +        QEMU_CFLAGS="$zlib_cflags $QEMU_CFLAGS"
> +        LIBS="$zlib_libs $LIBS"
> +    else
> +        cat > $TMPC << EOF
> +#include <zlib.h>
> +int main(void) { zlibVersion(); return 0; }
> +EOF
> +        if compile_prog "" "-lz" ; then
> +            LIBS="$LIBS -lz"
> +        else
> +            error_exit "zlib check failed" \
> +                "Make sure to have the zlib libs and headers installed."
> +        fi
> +    fi

.... this fallback support for non-pkgconfig scenarios can be entirely
deleted, just leaving the error_exit message. 


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
