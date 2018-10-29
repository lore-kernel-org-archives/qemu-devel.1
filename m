Received: from eggs.gnu.org ([2001:4830:134:3::10]:41840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gH5GH-0001ts-Ir
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 06:59:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gH5GC-0008Ch-Ik
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 06:59:09 -0400
Received: from mail.ispras.ru ([83.149.199.45]:49862)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gH5GC-0008AT-98
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 06:59:04 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20181025172057.20414-1-cota@braap.org>
	<20181025172057.20414-49-cota@braap.org>
In-Reply-To: <20181025172057.20414-49-cota@braap.org>
Date: Mon, 29 Oct 2018 13:59:03 +0300
Message-ID: <000b01d46f76$67926b20$36b74160$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: ru
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
To: "'Emilio G. Cota'" <cota@braap.org>, qemu-devel@nongnu.org
Cc: 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, =?utf-8?Q?'Llu=C3=ADs_Vilanova'?= <vilanova@ac.upc.edu>, 'Peter Maydell' <peter.maydell@linaro.org>, =?utf-8?Q?'Alex_Benn=C3=A9e'?= <alex.bennee@linaro.org>, 'Stefan Hajnoczi' <stefanha@gmail.com>

> From: Emilio G. Cota [mailto:cota@braap.org]
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  plugin-examples/bbcount_avgsize_racy.c | 50 ++++++++++++++++++++++
>  plugin-examples/mem_count_racy_both.c  | 58 ++++++++++++++++++++++++++
>  plugin-examples/Makefile               | 31 ++++++++++++++
>  3 files changed, 139 insertions(+)
>  create mode 100644 plugin-examples/bbcount_avgsize_racy.c
>  create mode 100644 plugin-examples/mem_count_racy_both.c
>  create mode 100644 plugin-examples/Makefile
> 

<snip>

> diff --git a/plugin-examples/mem_count_racy_both.c b/plugin-examples/mem_count_racy_both.c
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
> +static void vcpu_mem(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
> +                     uint64_t vaddr, void *udata)
> +{
> +    mem_count++;
> +}
> +
> +static void vcpu_tb_trans(qemu_plugin_id_t id, unsigned int cpu_index,
> +                          struct qemu_plugin_tb *tb)
> +{
> +    size_t n = qemu_plugin_tb_n_insns(tb);
> +    size_t i;
> +
> +    for (i = 0; i < n; i++) {
> +        struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
> +
> +        if (do_inline) {
> +            qemu_plugin_register_vcpu_mem_inline(insn,
> +                                                 QEMU_PLUGIN_INLINE_ADD_U64,
> +                                                 &mem_count, 1);
> +        } else {
> +            qemu_plugin_register_vcpu_mem_cb(insn, vcpu_mem,
> +                                             QEMU_PLUGIN_CB_NO_REGS, NULL);
> +        }
> +    }
> +}
> +
> +QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id, int argc,
> +                                           char **argv)
> +{
> +    if (argc && strcmp(argv[0], "inline") == 0) {
> +        do_inline = true;
> +    }
> +    /* plugin_exit might write to stdout after stdout has been closed */
> +    stdout_fd = dup(STDOUT_FILENO);
> +    assert(stdout_fd);
> +
> +    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
> +    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
> +    return 0;
> +}

Thanks for the series.
Can you provide more plugin examples for better understanding of double-translate idea?
E.g., plugins that hook specific instructions or addresses.

Pavel Dovgalyuk
