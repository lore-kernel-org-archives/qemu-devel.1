Received: from eggs.gnu.org ([2001:4830:134:3::10]:52555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gX0Hk-0000S7-Tv
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 03:54:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gX0Hh-00071d-N4
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 03:54:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43602)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gX0Hh-00070r-EW
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 03:54:25 -0500
From: Thomas Huth <thuth@redhat.com>
References: <1543937577-28256-1-git-send-email-thuth@redhat.com>
	<1543937577-28256-4-git-send-email-thuth@redhat.com>
Message-ID: <40274cd1-64d7-3362-e2a4-4a64bca68180@redhat.com>
Date: Wed, 12 Dec 2018 09:54:22 +0100
MIME-Version: 1.0
In-Reply-To: <1543937577-28256-4-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 v2 3/7] configure: Remove old
 -fno-gcse workaround for GCC 4.6.x and 4.7.[012]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, pbonzini@redhat.com, Richard Henderson <rth@twiddle.net>

On 2018-12-04 16:32, Thomas Huth wrote:
> Now that we require at least GCC 4.8, we don't need this als workaround
> for 4.6 and 4.7 anymore.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  Makefile.target |  3 ---
>  configure       | 27 ---------------------------
>  2 files changed, 30 deletions(-)
> 
> diff --git a/Makefile.target b/Makefile.target
> index 4d56298..44ec4b6 100644
> --- a/Makefile.target
> +++ b/Makefile.target
> @@ -158,9 +158,6 @@ GENERATED_FILES += hmp-commands.h hmp-commands-info.h
>  
>  endif # CONFIG_SOFTMMU
>  
> -# Workaround for http://gcc.gnu.org/PR55489, see configure.
> -%/translate.o: QEMU_CFLAGS += $(TRANSLATE_OPT_CFLAGS)
> -
>  dummy := $(call unnest-vars,,obj-y)
>  all-obj-y := $(obj-y)
>  
> diff --git a/configure b/configure
> index ca364f6..c160b59 100755
> --- a/configure
> +++ b/configure
> @@ -1936,32 +1936,6 @@ else
>    QEMU_CFLAGS="$QEMU_CFLAGS -Wno-missing-braces"
>  fi
>  
> -# Workaround for http://gcc.gnu.org/PR55489.  Happens with -fPIE/-fPIC and
> -# large functions that use global variables.  The bug is in all releases of
> -# GCC, but it became particularly acute in 4.6.x and 4.7.x.  It is fixed in
> -# 4.7.3 and 4.8.0.  We should be able to delete this at the end of 2013.
> -cat > $TMPC << EOF
> -#if __GNUC__ == 4 && (__GNUC_MINOR__ == 6 || (__GNUC_MINOR__ == 7 && __GNUC_PATCHLEVEL__ <= 2))
> -int main(void) { return 0; }
> -#else
> -#error No bug in this compiler.
> -#endif
> -EOF
> -if compile_prog "-Werror -fno-gcse" "" ; then
> -  TRANSLATE_OPT_CFLAGS=-fno-gcse
> -fi
> -
> -if test "$static" = "yes" ; then
> -  if test "$modules" = "yes" ; then
> -    error_exit "static and modules are mutually incompatible"
> -  fi
> -  if test "$pie" = "yes" ; then
> -    error_exit "static and pie are mutually incompatible"
> -  else
> -    pie="no"
> -  fi
> -fi

For the records: I just noticed that the last 10 lines do not belong to
the gcse workaround - I'll remove them from the patch again.

 Thomas
