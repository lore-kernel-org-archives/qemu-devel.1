Received: from eggs.gnu.org ([2001:4830:134:3::10]:50130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eQuwF-0006VW-NV
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 07:54:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eQuwE-0000Xb-LG
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 07:54:35 -0500
Received: from mail-ot0-x234.google.com ([2607:f8b0:4003:c0f::234]:42026)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eQuwE-0000Wh-D4
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 07:54:34 -0500
Received: by mail-ot0-x234.google.com with SMTP id i1so13237071oth.9
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 04:54:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171218124943.28529-1-ybettan@redhat.com>
References: <20171218124943.28529-1-ybettan@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Dec 2017 12:54:12 +0000
Message-ID: <CAFEAcA-vsJ-6MntBB6LuMzHhA+X-YZv=XJwZRuhD5m0wj-o+AA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH V2] vl.c && linux-user/main.c : removed
 **envp from main() arguments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yoni Bettan <ybettan@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 18 December 2017 at 12:49, Yoni Bettan <ybettan@redhat.com> wrote:
>          * it was added on 2008 902b3d5c392bb6f48ef340ad8ecc3311705d2800
>            when introduced cache-utils.[ch]
>
>          * since then cache-utils.[ch] were removed but **envp was left
>            behind
>
>         * by the way "to be portable it is best to write main to take two
>           arguments, and use the value of environ" according to
>           https://www.gnu.org/software/libc/manual/html_node/Program-\
>                 Arguments.html#Program-Arguments

> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index 330ccebf90..851a2dcd06 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -25,7 +25,6 @@
>  #include "qemu/osdep.h"
>
>  #import <Cocoa/Cocoa.h>
> -#include <crt_externs.h>
>
>  #include "qemu-common.h"
>  #include "ui/console.h"
> @@ -1050,7 +1049,7 @@ QemuCocoaView *cocoaView;
>      COCOA_DEBUG("QemuCocoaAppController: startEmulationWithArgc\n");
>
>      int status;
> -    status = qemu_main(argc, argv, *_NSGetEnviron());
> +    status = main(argc, argv);
>      exit(status);
>  }
>
> @@ -1391,7 +1390,7 @@ int main (int argc, const char * argv[]) {
>                  !strcmp(opt, "-curses") ||
>                  !strcmp(opt, "-display") ||
>                  !strcmp(opt, "-qtest")) {
> -                return qemu_main(gArgc, gArgv, *_NSGetEnviron());
> +                return main(gArgc, gArgv);
>              }
>          }
>      }

Did you test this on OSX? I'm pretty sure it will break,
because now the main() function in ui/cocoa.m will
recursively call itself, rather than calling the
function in vl.c. (Either that or it just won't
link at all because there are two main() functions.)

thanks
-- PMM
