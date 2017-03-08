Received: from eggs.gnu.org ([2001:4830:134:3::10]:37142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1clcTe-00032u-Gp
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 09:22:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1clcTd-00059q-Ie
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 09:22:06 -0500
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:37822)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1clcTd-00059k-C2
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 09:22:05 -0500
Received: by mail-wm0-x232.google.com with SMTP id n11so32071759wma.0
	for <qemu-devel@nongnu.org>; Wed, 08 Mar 2017 06:22:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170308124955.35623-1-aik@ozlabs.ru>
References: <20170308124955.35623-1-aik@ozlabs.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 8 Mar 2017 15:21:43 +0100
Message-ID: <CAFEAcA_pq6cUVVqzg0in-QTKngsf2cSpzpaGnP=gH5X2GnzOQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [RFC PATCH qemu] dtc: Allow compiling with old gcc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>

On 8 March 2017 at 13:49, Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> After 6e85fce0225f "dtc: Update requirement to v1.4.2" QEMU stopped
> compiling in CentOS7:
>
> In file included from /home/aik/p/qemu/dtc/libfdt/libfdt.h:54:0,
>                  from /home/aik/p/qemu/device_tree.c:30:
> /home/aik/p/qemu/dtc/libfdt/libfdt_env.h:64:0: error: "__bitwise" redefined [-Werror]
>  #define __bitwise
>  ^
> In file included from /usr/include/asm/ptrace.h:27:0,
>                  from /usr/include/asm/sigcontext.h:11,
>                  from /usr/include/bits/sigcontext.h:27,
>                  from /usr/include/signal.h:340,
>                  from /home/aik/p/qemu/include/qemu/osdep.h:86,
>                  from /home/aik/p/qemu/device_tree.c:14:
> /usr/include/linux/types.h:21:0: note: this is the location of the previous definition
>  #define __bitwise __bitwise__
>  ^
> cc1: all warnings being treated as errors
> make: *** [device_tree.o] Error 1
> make: *** Waiting for unfinished jobs....
>
> The reason is that CentOS7 comes with libfdt 1.4.0 so QEMU tries using
> the internal one which does not compile as CentOS7 comes with gcc v4.8.5
> which reports warnings which it would not if the OS's libfdt was used
> (libfdt_env.h has not changed between 1.4.0 and 1.4.2).
>
> gcc 6.2.0 from Ubuntu v16.10 handles this fine.
>
> This replaces -I with -isystem to suppress the warning (which turns
> to an error because of -Werror).

Thanks for the bug report. I think it would be cleaner to fix this
by fixing the problem upstream in libfdt and then moving our
submodule forward to the fixed version. (libfdt should not be
defining __ prefixed symbols as these are reserved for the
system.)

thanks
-- PMM
