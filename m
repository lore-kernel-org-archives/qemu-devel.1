Received: from eggs.gnu.org ([2001:4830:134:3::10]:40326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1e5UWb-0005t6-5i
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 06:27:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1e5UWW-0007xL-Qz
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 06:27:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1e5UWW-0007vz-Ia
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 06:27:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9B79F7F41B
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 10:27:27 +0000 (UTC)
References: <20171020101219.2378-1-pbonzini@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <1b56a63f-ab38-219b-6b2c-2a43c343e5f0@redhat.com>
Date: Fri, 20 Oct 2017 12:27:25 +0200
MIME-Version: 1.0
In-Reply-To: <20171020101219.2378-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] build: disable -Wmissing-braces on older
 compilers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 10/20/17 12:12, Paolo Bonzini wrote:
> GCC 4.9 and newer stopped warning for missing braces around the
> "universal" C zero initializer {0}.  One such initializer sneaked

s/sneaked/snuck/

Hmmm, no, wait, both forms are valid!

https://en.wiktionary.org/wiki/sneaked
https://en.wiktionary.org/wiki/snuck

    The irregular form snuck originated by analogy with struck for the
    past of strike. Snuck was originally limited to a few dialects, but
    is now very widespread (especially in American English) and is
    recognized by most dictionaries. The word is now one of the best
    examples of irregularization of a regular verb, along with dove.

> into scsi/qemu-pr-helper.c and is breaking the build with such
> older GCC versions.
> 
> Detect the lack of support for the idiom, and disable the warning
> in that case.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>         Of course it's always possible to use "memset", but {0}
>         is neater in my opinion.

Strongly agree.

> 
>  configure | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/configure b/configure
> index 7766e74125..0b2d595c6e 100755
> --- a/configure
> +++ b/configure
> @@ -1651,6 +1651,19 @@ EOF
>    fi
>  fi
>  
> +# Disable -Wmissing-braces on older compilers that warn even for
> +# the "universal" C zero initializer {0}.
> +cat > $TMPC << EOF
> +struct {
> +  int a[2];
> +} x = {0};
> +EOF
> +if compile_object "-Werror" "" ; then
> +  :
> +else

Is this an established idiom for the configure script, in place of:

  if ! compile_object "-Werror" "" ; then

?

Looks good to me otherwise.

Thanks!
Laszlo

> +  QEMU_CFLAGS="$QEMU_CFLAGS -Wno-missing-braces"
> +fi
> +
>  # Workaround for http://gcc.gnu.org/PR55489.  Happens with -fPIE/-fPIC and
>  # large functions that use global variables.  The bug is in all releases of
>  # GCC, but it became particularly acute in 4.6.x and 4.7.x.  It is fixed in
> 
