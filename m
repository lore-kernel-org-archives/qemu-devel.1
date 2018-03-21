Received: from eggs.gnu.org ([2001:4830:134:3::10]:51010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eykYL-0008Pr-22
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:41:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eykYH-0006w8-S3
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:41:45 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:47337)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eykYH-0006vy-IP
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:41:41 -0400
References: <1521663109-32262-1-git-send-email-cota@braap.org>
	<1521663109-32262-8-git-send-email-cota@braap.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <b342cf3b-d594-9728-a12d-d5b8c7090e09@vivier.eu>
Date: Wed, 21 Mar 2018 21:41:19 +0100
MIME-Version: 1.0
In-Reply-To: <1521663109-32262-8-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 07/14] fpu: introduce hostfloat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Le 21/03/2018 à 21:11, Emilio G. Cota a écrit :
> The appended paves the way for leveraging the host FPU for a subset
> of guest FP operations. For most guest workloads (e.g. FP flags
> aren't ever cleared, inexact occurs often and rounding is set to the
> default [to nearest]) this will yield sizable performance speedups.
> 
> The approach followed here avoids checking the FP exception flags register.
> See the comment at the top of hostfloat.c for details.
> 
> This assumes that QEMU is running on an IEEE754-compliant FPU and
> that the rounding is set to the default (to nearest). The
> implementation-dependent specifics of the FPU should not matter; things
> like tininess detection and snan representation are still dealt with in
> soft-fp. However, this approach will break on most hosts if we compile
> QEMU with flags such as -ffast-math. We control the flags so this should
> be easy to enforce though.
> 
> The licensing in softfloat.h is complicated at best, so to keep things
> simple I'm adding this as a separate, GPL'ed file.
> 
> This patch just adds some boilerplate code; subsequent patches add
> operations, one per commit to ease bisection.
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  Makefile.target           |  2 +-
>  include/fpu/hostfloat.h   | 14 +++++++
>  include/fpu/softfloat.h   |  1 +
>  fpu/hostfloat.c           | 96 +++++++++++++++++++++++++++++++++++++++++++++++
>  target/m68k/Makefile.objs |  2 +-
>  tests/fp-test/Makefile    |  2 +-
>  6 files changed, 114 insertions(+), 3 deletions(-)
>  create mode 100644 include/fpu/hostfloat.h
>  create mode 100644 fpu/hostfloat.c
> 
...
> diff --git a/target/m68k/Makefile.objs b/target/m68k/Makefile.objs
> index ac61948..2868b11 100644
> --- a/target/m68k/Makefile.objs
> +++ b/target/m68k/Makefile.objs
> @@ -1,5 +1,5 @@
>  obj-y += m68k-semi.o
>  obj-y += translate.o op_helper.o helper.o cpu.o
> -obj-y += fpu_helper.o softfloat.o
> +obj-y += fpu_helper.o softfloat.o hostfloat.o

I don't think you need to add hostfloat.o here,
the softfloat.o in this list contains function specific to m68k
emulation, it's not the one from fpu/

Thanks,
Laurent
