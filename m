Received: from eggs.gnu.org ([2001:4830:134:3::10]:59737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXUIX-0005xl-2P
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:25:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXUIS-0000uc-4a
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:25:01 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:40871)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXUIR-0000uN-Uu
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:24:56 -0400
Received: by mail-qk0-x242.google.com with SMTP id b129-v6so7811696qke.7
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 09:24:55 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180625160658.7315-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <91f270d1-1477-3b75-1b1b-fd72bf4228e6@amsat.org>
Date: Mon, 25 Jun 2018 13:24:49 -0300
MIME-Version: 1.0
In-Reply-To: <20180625160658.7315-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] osdep: work around Coverity parsing errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>

On 06/25/2018 01:06 PM, Paolo Bonzini wrote:
> Coverity does not like the new _Float* types that are used by
> recent glibc, and croaks on every single file that includes
> stdlib.h.  Add dummy typedefs to please it.

This matches http://gcc.gnu.org/onlinedocs/gcc-8.1.0/gcc/Floating-Types.html

> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> 	I've been using this patch for a couple months, and Peter pointed
> 	out that other projects are doing similar hacks.  So it's probably
> 	time to send it upstream.
> 
> 	Note that this is a parse error, so it cannot be fixed in the
> 	model file.
> 
>  include/qemu/osdep.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 9ed62423c0..0084f3fa71 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -33,6 +33,14 @@
>  #else
>  #include "exec/poison.h"
>  #endif
> +#ifdef __COVERITY__
> +typedef float _Float32;
> +typedef double _Float32x;
> +typedef double _Float64;
> +typedef __float80 _Float64x;
> +typedef __float128 _Float128;
> +#endif
> +
>  #include "qemu/compiler.h"
>  
>  /* Older versions of C++ don't get definitions of various macros from
> 
