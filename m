Received: from eggs.gnu.org ([2001:4830:134:3::10]:33405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dowYu-0005YP-O5
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 14:57:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dowYp-0002dJ-Vp
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 14:57:32 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:56893)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dowYp-0002d9-KI
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 14:57:27 -0400
References: <1504545540-8002-1-git-send-email-peter.maydell@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <b3723c69-de30-0a37-a865-fb718375e54b@vivier.eu>
Date: Mon, 4 Sep 2017 20:57:24 +0200
MIME-Version: 1.0
In-Reply-To: <1504545540-8002-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] configure: Drop AIX host support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org

Le 04/09/2017 à 19:19, Peter Maydell a écrit :
> Nobody has mentioned AIX host support on the mailing list for years,
> and we have no test systems for it so it is most likely broken.
> We've advertised in configure for two releases now that we plan
> to drop support for this host OS, and have had no complaints.
> Drop the AIX host support code.
> 
> We can also drop the now-unused AIX version of sys_cache_info().
> 
> Note that the _CALL_AIX define used in the PPC tcg backend is
> also used for Linux PPC64, and so that code should not be removed.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

> ---
>  configure        | 13 +------------
>  util/cacheinfo.c | 11 +----------
>  2 files changed, 2 insertions(+), 22 deletions(-)
> 
> diff --git a/configure b/configure
> index fb7e34a..931b3ba 100755
> --- a/configure
> +++ b/configure
> @@ -350,7 +350,6 @@ cocoa="no"
>  softmmu="yes"
>  linux_user="no"
>  bsd_user="no"
> -aix="no"
>  blobs="yes"
>  pkgversion=""
>  pie=""
> @@ -554,8 +553,6 @@ elif check_define __NetBSD__; then
>    targetos='NetBSD'
>  elif check_define __APPLE__; then
>    targetos='Darwin'
> -elif check_define _AIX; then
> -  targetos='AIX'
>  else
>    # This is a fatal error, but don't report it yet, because we
>    # might be going to just print the --help text, or it might
> @@ -767,10 +764,6 @@ SunOS)
>    LIBS="$solarisnetlibs $LIBS"
>    libs_qga="$solarisnetlibs $libs_qga"
>  ;;
> -AIX)
> -  aix="yes"
> -  make="${MAKE-gmake}"
> -;;
>  Haiku)
>    haiku="yes"
>    QEMU_CFLAGS="-DB_USE_POSITIVE_POSIX_ERRORS $QEMU_CFLAGS"
> @@ -4214,7 +4207,7 @@ elif compile_prog "" "$pthread_lib -lrt" ; then
>  fi
>  
>  if test "$darwin" != "yes" -a "$mingw32" != "yes" -a "$solaris" != yes -a \
> -        "$aix" != "yes" -a "$haiku" != "yes" ; then
> +        "$haiku" != "yes" ; then
>      libs_softmmu="-lutil $libs_softmmu"
>  fi
>  
> @@ -5523,10 +5516,6 @@ if test "$darwin" = "yes" ; then
>    echo "CONFIG_DARWIN=y" >> $config_host_mak
>  fi
>  
> -if test "$aix" = "yes" ; then
> -  echo "CONFIG_AIX=y" >> $config_host_mak
> -fi
> -
>  if test "$solaris" = "yes" ; then
>    echo "CONFIG_SOLARIS=y" >> $config_host_mak
>  fi
> diff --git a/util/cacheinfo.c b/util/cacheinfo.c
> index 593940f..db5172d 100644
> --- a/util/cacheinfo.c
> +++ b/util/cacheinfo.c
> @@ -15,16 +15,7 @@ int qemu_dcache_linesize = 0;
>   * Operating system specific detection mechanisms.
>   */
>  
> -#if defined(_AIX)
> -# include <sys/systemcfg.h>
> -
> -static void sys_cache_info(int *isize, int *dsize)
> -{
> -    *isize = _system_configuration.icache_line;
> -    *dsize = _system_configuration.dcache_line;
> -}
> -
> -#elif defined(_WIN32)
> +#if defined(_WIN32)
>  
>  static void sys_cache_info(int *isize, int *dsize)
>  {
> 
