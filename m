Received: from eggs.gnu.org ([2001:4830:134:3::10]:35574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fyGTL-0008Pw-Uh
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 09:06:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fyGTH-0006cI-9q
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 09:06:51 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:34991)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fyGTG-0006Yk-PK
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 09:06:47 -0400
Received: by mail-wr1-x429.google.com with SMTP id j26-v6so14937547wre.2
	for <qemu-devel@nongnu.org>; Fri, 07 Sep 2018 06:06:46 -0700 (PDT)
References: <152819515565.30857.16834004920507717324.stgit@pasha-ThinkPad-T60>
	<152819517217.30857.1806942753626059939.stgit@pasha-ThinkPad-T60>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <152819517217.30857.1806942753626059939.stgit@pasha-ThinkPad-T60>
Date: Fri, 07 Sep 2018 14:06:44 +0100
Message-ID: <87va7hzcbf.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 3/7] plugins: provide helper
 functions for plugins
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, pbonzini@redhat.com, vilanova@ac.upc.edu


Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru> writes:

> From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
>
> This patch adds interface functions that may be called from the loaded pl=
ugins.
> Such functions are needed to inspect the VM state and to pass data
> to the QEMU (e.g., QEMU-side logging).
>
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  Makefile.target           |    2 +-
>  plugins/include/plugins.h |    6 ++++++
>  plugins/qemulib.c         |   31 +++++++++++++++++++++++++++++++
>  3 files changed, 38 insertions(+), 1 deletion(-)
>  create mode 100644 plugins/qemulib.c
>
> diff --git a/Makefile.target b/Makefile.target
> index 4cffd96..5648c9c 100644
> --- a/Makefile.target
> +++ b/Makefile.target
> @@ -93,7 +93,7 @@ all: $(PROGS) stap
>  # cpu emulator library
>  obj-y +=3D exec.o
>  obj-y +=3D accel/
> -obj-$(CONFIG_PLUGINS) +=3D plugins/plugins.o
> +obj-$(CONFIG_PLUGINS) +=3D plugins/plugins.o plugins/qemulib.o
>  obj-$(CONFIG_TCG) +=3D tcg/tcg.o tcg/tcg-op.o tcg/tcg-op-vec.o tcg/tcg-o=
p-gvec.o
>  obj-$(CONFIG_TCG) +=3D tcg/tcg-common.o tcg/optimize.o
>  obj-$(CONFIG_TCG_INTERPRETER) +=3D tcg/tci.o
> diff --git a/plugins/include/plugins.h b/plugins/include/plugins.h
> index 100a786..fa624ea 100644
> --- a/plugins/include/plugins.h
> +++ b/plugins/include/plugins.h
> @@ -9,4 +9,10 @@ bool plugin_init(const char *args);
>  bool plugin_needs_before_insn(uint64_t pc, void *cpu);
>  void plugin_before_insn(uint64_t pc, void *cpu);
>
> +/* QEMU interface */
> +
> +void qemulib_log(const char *fmt, ...) /*GCC_FMT_ATTR(1, 2)*/;
> +int qemulib_read_memory(void *cpu, uint64_t addr, uint8_t *buf, int len);
> +int qemulib_read_register(void *cpu, uint8_t *mem_buf, int reg);
> +
>  #endif /* PLUGINS_INTERFACE_H */
> diff --git a/plugins/qemulib.c b/plugins/qemulib.c
> new file mode 100644
> index 0000000..eb812c1
> --- /dev/null
> +++ b/plugins/qemulib.c
> @@ -0,0 +1,31 @@
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +#include "cpu.h"
> +#include "qemu/error-report.h"
> +#include "qemu/plugins.h"
> +#include "qemu/log.h"
> +#include "include/plugins.h"
> +
> +void qemulib_log(const char *fmt, ...)
> +{
> +    va_list args;
> +    va_start(args, fmt);
> +    qemu_log_vprintf(fmt, args);
> +    va_end(args);
> +}
> +
> +int qemulib_read_memory(void *cpu, uint64_t addr, uint8_t *buf, int len)
> +{
> +    return cpu_memory_rw_debug(cpu, addr, buf, len, false);
> +}
> +
> +int qemulib_read_register(void *cpu, uint8_t *mem_buf, int reg)
> +{
> +    CPUClass *cc =3D CPU_GET_CLASS(cpu);
> +
> +    if (reg < cc->gdb_num_core_regs) {
> +        return cc->gdb_read_register(cpu, mem_buf, reg);
> +    }
> +
> +    return 0;
> +}


--
Alex Benn=C3=A9e
