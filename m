Received: from eggs.gnu.org ([2001:4830:134:3::10]:43150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fx8oA-0003Nc-TY
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 06:43:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fx8o6-0005bW-PM
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 06:43:42 -0400
Date: Tue, 4 Sep 2018 11:43:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180904104333.GC22349@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1536044538-22507-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1536044538-22507-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] configure: Save PKG_CONFIG_LIBDIR and
 WINDRES in config.status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Stefan Weil <sw@weilnetz.de>

On Tue, Sep 04, 2018 at 09:02:18AM +0200, Thomas Huth wrote:
> When cross-compiling QEMU for a target that significantly differs from
> the host, the current information in config.status is not enough to
> properly re-create the configuration. For example when I try to test
> my build with the mingw32 cross-compiler, I regularly get this error
> after the build system tried to re-create the configuration with the
> config.status file:
> 
> ERROR: sizeof(size_t) doesn't match GLIB_SIZEOF_SIZE_T.
>        You probably need to set PKG_CONFIG_LIBDIR
>        to point to the right pkg-config files for your
>        build target
> 
> A similar problem exists for the "windres" tool, where you have to
> set the WINDRES variable in case it has a different name.
> So let's fix these issues by storing the configuration for these
> variables in the config.status file, too.

Doh, I sent a patch to fix this problem more broadly years ago now:

  https://lists.nongnu.org/archive/html/qemu-devel/2015-11/msg04157.html

but it appears no maintainer ever merged it !

> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  configure | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/configure b/configure
> index 58862d2..4d8888f 100755
> --- a/configure
> +++ b/configure
> @@ -7534,6 +7534,12 @@ cat <<EOD >config.status
>  # Compiler output produced by configure, useful for debugging
>  # configure, is in config.log if it exists.
>  EOD
> +if [ -n "$PKG_CONFIG_LIBDIR" ]; then
> +    echo "export PKG_CONFIG_LIBDIR=\"$PKG_CONFIG_LIBDIR\"" >>config.status
> +fi
> +if [ -n "$WINDRES" ]; then
> +    echo "export WINDRES=\"$WINDRES\"" >>config.status
> +fi
>  printf "exec" >>config.status
>  printf " '%s'" "$0" "$@" >>config.status
>  echo ' "$@"' >>config.status

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
