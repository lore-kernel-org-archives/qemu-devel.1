Received: from eggs.gnu.org ([2001:4830:134:3::10]:44989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gRy10-0006zm-Rn
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 06:28:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gRy0x-0007i7-UP
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 06:28:22 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:44208)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gRy0x-0007fD-1z
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 06:28:19 -0500
Received: by mail-wr1-x432.google.com with SMTP id z5so21607980wrt.11
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 03:28:14 -0800 (PST)
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-49-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181025172057.20414-49-cota@braap.org>
Date: Wed, 28 Nov 2018 11:28:11 +0000
Message-ID: <87bm694f1w.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 48/48] plugin: add a couple of very simple
 examples
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?utf-8?Q?Llu=C3=ADs?= Vilanova <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>


Emilio G. Cota <cota@braap.org> writes:

> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  plugin-examples/bbcount_avgsize_racy.c | 50 ++++++++++++++++++++++
>  plugin-examples/mem_count_racy_both.c  | 58 ++++++++++++++++++++++++++
>  plugin-examples/Makefile               | 31 ++++++++++++++

So I think we need to be putting these somewhere else and also building
the examples by default. As plugins only make sense with tcg guests
maybe a layout like:

  tcg/plugins/plugin.c
  tcg/plugins/examples/

>  3 files changed, 139 insertions(+)
>  create mode 100644 plugin-examples/bbcount_avgsize_racy.c
>  create mode 100644 plugin-examples/mem_count_racy_both.c
>  create mode 100644 plugin-examples/Makefile
>
> diff --git a/plugin-examples/bbcount_avgsize_racy.c b/plugin-examples/bbc=
ount_avgsize_racy.c
> new file mode 100644
> index 0000000000..ccdf96c1fa
> --- /dev/null
> +++ b/plugin-examples/bbcount_avgsize_racy.c
> @@ -0,0 +1,50 @@
> +#include <inttypes.h>
> +#include <assert.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <stdio.h>
> +
> +#include <qemu-plugin.h>

-#include <qemu-plugin.h>
+#include <plugin-api.h>

> +
> +static uint64_t bb_count;
> +static uint64_t insn_count;
> +const char *filename;
> +static int stdout_fd;
> +
> +static void plugin_exit(qemu_plugin_id_t id, void *p)
> +{
> +    dprintf(stdout_fd, "insns: %" PRIu64", bb: %" PRIu64 ", "
> +            "avg insns/bb: %.2f\n",
> +            insn_count, bb_count, (double)insn_count / bb_count);
> +}
> +
> +static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
> +{
> +    unsigned long n_insns =3D (unsigned long)udata;
> +
> +    insn_count +=3D n_insns;
> +    bb_count++;
> +}
> +
> +static void vcpu_tb_trans(qemu_plugin_id_t id, unsigned int cpu_index,
> +                          struct qemu_plugin_tb *tb)
> +{
> +    unsigned long n_insns =3D qemu_plugin_tb_n_insns(tb);
> +
> +    qemu_plugin_register_vcpu_tb_exec_cb(tb, vcpu_tb_exec,
> +                                         QEMU_PLUGIN_CB_NO_REGS,
> +                                         (void *)n_insns);
> +}
> +
> +QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id, int argc,
> +                                           char **argv)
> +{
> +    /* plugin_exit might write to stdout after stdout has been closed */
> +    stdout_fd =3D dup(STDOUT_FILENO);
> +    assert(stdout_fd);
> +
> +    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
> +    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
> +    return 0;
> +}
> diff --git a/plugin-examples/mem_count_racy_both.c b/plugin-examples/mem_=
count_racy_both.c
> new file mode 100644
> index 0000000000..a47f2025bf
> --- /dev/null
> +++ b/plugin-examples/mem_count_racy_both.c
> @@ -0,0 +1,58 @@
> +#include <inttypes.h>
> +#include <assert.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <stdio.h>
> +
> +#include <qemu-plugin.h>

-#include <qemu-plugin.h>
+#include <plugin-api.h>

> +
> +static uint64_t mem_count;
> +static int stdout_fd;
> +static bool do_inline;
> +
> +static void plugin_exit(qemu_plugin_id_t id, void *p)
> +{
> +    dprintf(stdout_fd, "accesses: %" PRIu64 "\n", mem_count);
> +}
> +
> +static void vcpu_mem(unsigned int cpu_index, qemu_plugin_meminfo_t memin=
fo,
> +                     uint64_t vaddr, void *udata)
> +{
> +    mem_count++;
> +}
> +
> +static void vcpu_tb_trans(qemu_plugin_id_t id, unsigned int cpu_index,
> +                          struct qemu_plugin_tb *tb)
> +{
> +    size_t n =3D qemu_plugin_tb_n_insns(tb);
> +    size_t i;
> +
> +    for (i =3D 0; i < n; i++) {
> +        struct qemu_plugin_insn *insn =3D qemu_plugin_tb_get_insn(tb, i);
> +
> +        if (do_inline) {
> +            qemu_plugin_register_vcpu_mem_inline(insn,
> +                                                 QEMU_PLUGIN_INLINE_ADD_=
U64,
> +                                                 &mem_count, 1);
> +        } else {
> +            qemu_plugin_register_vcpu_mem_cb(insn, vcpu_mem,
> +                                             QEMU_PLUGIN_CB_NO_REGS, NUL=
L);
> +        }
> +    }
> +}
> +
> +QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id, int argc,
> +                                           char **argv)
> +{
> +    if (argc && strcmp(argv[0], "inline") =3D=3D 0) {
> +        do_inline =3D true;
> +    }
> +    /* plugin_exit might write to stdout after stdout has been closed */
> +    stdout_fd =3D dup(STDOUT_FILENO);
> +    assert(stdout_fd);
> +
> +    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
> +    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
> +    return 0;
> +}
> diff --git a/plugin-examples/Makefile b/plugin-examples/Makefile
> new file mode 100644
> index 0000000000..71bbcda7a8
> --- /dev/null
> +++ b/plugin-examples/Makefile
> @@ -0,0 +1,31 @@
> +NAMES :=3D
> +NAMES +=3D bbcount_avgsize_racy
> +NAMES +=3D mem_count_racy_both
> +
> +SONAMES :=3D $(addsuffix .so,$(addprefix lib,$(NAMES)))
> +
> +# QEMU installed path, set by --prefix during configure
> +QEMU_PATH ?=3D /data/src/qemu-inst/plugin-test

I guess we should use SRC_PATH (or maybe QEMU_SRC_PATH) if we want the
Makefile to be both invoked as a sub-make from a normal QEMU build and
to be used as an example for out-of-tree builds.

> +
> +CC :=3D gcc
> +CFLAGS :=3D
> +CFLAGS +=3D -O2 -Werror -Wall
> +CFLAGS +=3D -Wundef -Wwrite-strings -Wmissing-prototypes
> +CFLAGS +=3D -Wstrict-prototypes -Wredundant-decls
> +CFLAGS +=3D -fno-strict-aliasing -fno-common -fwrapv
> +CFLAGS +=3D -I$(QEMU_PATH)/include

-CFLAGS +=3D -I$(QEMU_PATH)/include
+CFLAGS +=3D -I$(QEMU_PATH)/include/qemu

--
Alex Benn=C3=A9e
