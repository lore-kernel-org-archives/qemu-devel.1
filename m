Received: from eggs.gnu.org ([2001:4830:134:3::10]:51446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZgpZ-0005kb-1K
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 11:35:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZgpY-0002uQ-6Q
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 11:35:25 -0500
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:35545)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cZgpX-0002u2-Uo
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 11:35:24 -0500
Received: by mail-wm0-x232.google.com with SMTP id b65so37030945wmf.0
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 08:35:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <3787ef677853c10ae60beb867c4b3d170391ad2d.1484929304.git.julian@codesourcery.com>
References: <cover.1484929304.git.julian@codesourcery.com>
	<3787ef677853c10ae60beb867c4b3d170391ad2d.1484929304.git.julian@codesourcery.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Feb 2017 16:35:02 +0000
Message-ID: <CAFEAcA8+w1=gObsvn-o0JoFyuTHA7At9LQd3FrbXH4_+cOg5Jw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v3 5/7] ARM big-endian system-mode gdbstub
 support.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julian Brown <julian@codesourcery.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 20 January 2017 at 16:32, Julian Brown <julian@codesourcery.com> wrote:
> When debugging a big-endian (either BE8 or BE32) executable, GDB uses
> a big-endian byte ordering for its remote protocol.  The gdb stub
> code in QEMU needs to interpret data in host (little-endian) order in
> arm_cpu_gdb_read_register and arm_cpu_gdb_write_register, so this patch
> arranges to byte-swap the data to/from GDB in those cases.
>
> Signed-off-by: Julian Brown <julian@codesourcery.com>
> ---
>  target/arm/gdbstub.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>
> diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
> index 04c1208..1e9fe68 100644
> --- a/target/arm/gdbstub.c
> +++ b/target/arm/gdbstub.c
> @@ -21,6 +21,7 @@
>  #include "qemu-common.h"
>  #include "cpu.h"
>  #include "exec/gdbstub.h"
> +#include "exec/softmmu-arm-semi.h"
>
>  /* Old gdb always expect FPA registers.  Newer (xml-aware) gdb only expect
>     whatever the target description contains.  Due to a historical mishap
> @@ -32,10 +33,22 @@ int arm_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
>  {
>      ARMCPU *cpu = ARM_CPU(cs);
>      CPUARMState *env = &cpu->env;
> +#ifndef CONFIG_USER_ONLY
> +    bool targ_bigendian = arm_bswap_needed(env);
> +#endif

This is a "what is the state of the CPU right this instant" test,
but surely gdb doesn't flip its protocol definition as the CPU
flips between big and little endian at runtime? I'm not sure
what the right check is but it probably isn't this.

>
>      if (n < 16) {
>          /* Core integer register.  */
> +#ifdef CONFIG_USER_ONLY
>          return gdb_get_reg32(mem_buf, env->regs[n]);
> +#else
> +        if (targ_bigendian) {
> +            stl_be_p(mem_buf, env->regs[n]);
> +        } else {
> +            stl_le_p(mem_buf, env->regs[n]);
> +        }
> +        return 4;
> +#endif

There's probably a phrasing here that avoids the ifdeffery...

thanks
-- PMM
