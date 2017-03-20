Received: from eggs.gnu.org ([2001:4830:134:3::10]:37053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cpxvi-0000s3-Ph
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 10:05:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cpxvc-0006ZG-Tf
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 10:05:02 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:33131)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cpxvc-0006Yz-MB
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 10:04:56 -0400
Received: by mail-wr0-x236.google.com with SMTP id u48so93118780wrc.0
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 07:04:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170320135708.GV17887@stefanha-x1.localdomain>
References: <CAKPgXcFwSHgb+sLimF=+En_fHM1rYnV1+jX3Tg_hP07EmzyiJg@mail.gmail.com>
	<20170320135708.GV17887@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Mar 2017 14:04:34 +0000
Message-ID: <CAFEAcA-2QCXtNXspY+AcZyk=24nBs8LjMXffLgguCt5COT2AhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] qemu-ga static compilation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Sameeh Jubran <sameeh@daynix.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>

On 20 March 2017 at 13:57, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> I guess GLIB_STATIC_COMPILATION is not defined in your build (see the
> definition of GLIB_VAR in the glib headers).
>
> The pkg-config file for glib doesn't define GLIB_STATIC_COMPILATION for
> pkg-config --static.  I guess we must add it manually.

This seems like a pkg-config config file bug to me.

> Does this work?
>
> diff --git a/configure b/configure
> index 99d8bec..10f23b7 100755
> --- a/configure
> +++ b/configure
> @@ -3047,6 +3047,10 @@ if test "$modules" = yes; then
>      glib_modules="$glib_modules gmodule-2.0"
>  fi
>
> +if test "$static" = yes; then
> +    QEMU_CFLAGS="-DGLIB_STATIC_COMPILATION $QEMU_CFLAGS"
> +fi
> +

I know this is just a "let's see if this works" patch, but
some notes for if this becomes a real patch later:

If we work around this packaging bug in our configure script
we should have a comment stating that it's a workaround for
a packaging bug, and we should probably restrict it to only
being done for Windows builds.

thanks
-- PMM
