Received: from eggs.gnu.org ([2001:4830:134:3::10]:47354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cGhwL-0004qI-HT
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 02:55:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cGhwI-0007m7-E5
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 02:55:57 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1481585316-31612-1-git-send-email-lvivier@redhat.com>
	<1481585316-31612-5-git-send-email-lvivier@redhat.com>
Date: Tue, 13 Dec 2016 08:55:49 +0100
In-Reply-To: <1481585316-31612-5-git-send-email-lvivier@redhat.com> (Laurent
	Vivier's message of "Tue, 13 Dec 2016 00:28:36 +0100")
Message-ID: <877f74w9dm.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 4/4] qtest: add ivshmem-test for ppc64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

Laurent Vivier <lvivier@redhat.com> writes:

> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  tests/Makefile.include |  3 ++-
>  tests/ivshmem-test.c   | 46 +++++++++++++++++++++++++++++-----------------
>  2 files changed, 31 insertions(+), 18 deletions(-)
>
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index b574964..09fe5b6 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -287,6 +287,7 @@ check-qtest-ppc64-y += tests/test-netfilter$(EXESUF)
>  check-qtest-ppc64-y += tests/test-filter-mirror$(EXESUF)
>  check-qtest-ppc64-y += tests/test-filter-redirector$(EXESUF)
>  check-qtest-ppc64-y += tests/display-vga-test$(EXESUF)
> +check-qtest-ppc64-y += tests/ivshmem-test$(EXESUF)
>  
>  check-qtest-sh4-y = tests/endianness-test$(EXESUF)
>  
> @@ -690,7 +691,7 @@ tests/test-netfilter$(EXESUF): tests/test-netfilter.o $(qtest-obj-y)
>  tests/test-filter-mirror$(EXESUF): tests/test-filter-mirror.o $(qtest-obj-y)
>  tests/test-filter-redirector$(EXESUF): tests/test-filter-redirector.o $(qtest-obj-y)
>  tests/test-x86-cpuid-compat$(EXESUF): tests/test-x86-cpuid-compat.o $(qtest-obj-y)
> -tests/ivshmem-test$(EXESUF): tests/ivshmem-test.o contrib/ivshmem-server/ivshmem-server.o $(libqos-pc-obj-y)
> +tests/ivshmem-test$(EXESUF): tests/ivshmem-test.o contrib/ivshmem-server/ivshmem-server.o $(libqos-pc-obj-y) $(libqos-spapr-obj-y)
>  tests/vhost-user-bridge$(EXESUF): tests/vhost-user-bridge.o
>  tests/test-uuid$(EXESUF): tests/test-uuid.o $(test-util-obj-y)
>  tests/test-arm-mptimer$(EXESUF): tests/test-arm-mptimer.o
> diff --git a/tests/ivshmem-test.c b/tests/ivshmem-test.c
> index 04a5c5d..5c6dc38 100644
> --- a/tests/ivshmem-test.c
> +++ b/tests/ivshmem-test.c
> @@ -11,8 +11,9 @@
>  #include "qemu/osdep.h"
>  #include <glib/gstdio.h>
>  #include "contrib/ivshmem-server/ivshmem-server.h"
> -#include "libqos/pci-pc.h"
>  #include "libqtest.h"
> +#include "libqos/libqos-pc.h"
> +#include "libqos/libqos-spapr.h"
>  #include "qemu-common.h"
>  
>  #define TMPSHMSIZE (1 << 20)
> @@ -40,9 +41,8 @@ static QPCIDevice *get_device(QPCIBus *pcibus)
>  }
>  
>  typedef struct _IVState {
> -    QTestState *qtest;
> +    QOSState *qs;
>      QPCIBar reg_bar, mem_bar;
> -    QPCIBus *pcibus;
>      QPCIDevice *dev;
>  } IVState;
>  
> @@ -74,7 +74,7 @@ static inline unsigned in_reg(IVState *s, enum Reg reg)
>      QTestState *qtest = global_qtest;
>      unsigned res;
>  
> -    global_qtest = s->qtest;
> +    global_qtest = s->qs->qts;
>      res = qpci_io_readl(s->dev, s->reg_bar, reg);
>      g_test_message("*%s -> %x\n", name, res);
>      global_qtest = qtest;
> @@ -87,7 +87,7 @@ static inline void out_reg(IVState *s, enum Reg reg, unsigned v)
>      const char *name = reg2str(reg);
>      QTestState *qtest = global_qtest;
>  
> -    global_qtest = s->qtest;
> +    global_qtest = s->qs->qts;
>      g_test_message("%x -> *%s\n", v, name);
>      qpci_io_writel(s->dev, s->reg_bar, reg, v);
>      global_qtest = qtest;
> @@ -97,7 +97,7 @@ static inline void read_mem(IVState *s, uint64_t off, void *buf, size_t len)
>  {
>      QTestState *qtest = global_qtest;
>  
> -    global_qtest = s->qtest;
> +    global_qtest = s->qs->qts;
>      qpci_memread(s->dev, s->mem_bar, off, buf, len);
>      global_qtest = qtest;
>  }
> @@ -107,7 +107,7 @@ static inline void write_mem(IVState *s, uint64_t off,
>  {
>      QTestState *qtest = global_qtest;
>  
> -    global_qtest = s->qtest;
> +    global_qtest = s->qs->qts;
>      qpci_memwrite(s->dev, s->mem_bar, off, buf, len);
>      global_qtest = qtest;
>  }
> @@ -115,17 +115,23 @@ static inline void write_mem(IVState *s, uint64_t off,
>  static void cleanup_vm(IVState *s)
>  {
>      g_free(s->dev);
> -    qpci_free_pc(s->pcibus);
> -    qtest_quit(s->qtest);
> +    qtest_shutdown(s->qs);
>  }
>  
>  static void setup_vm_cmd(IVState *s, const char *cmd, bool msix)
>  {
>      uint64_t barsize;
> +    const char *arch = qtest_get_arch();
>  
> -    s->qtest = qtest_start(cmd);
> -    s->pcibus = qpci_init_pc(NULL);
> -    s->dev = get_device(s->pcibus);
> +    if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
> +        s->qs = qtest_pc_boot(cmd);
> +    } else if (strcmp(arch, "ppc64") == 0) {
> +        s->qs = qtest_spapr_boot(cmd);
> +    } else {
> +        g_printerr("vshmem-test tests are only available on x86 or ppc64\n");

Typo: s/vshmem/ivshmem

To get here, you need to build and run this manually, as make check only
builds and runs this for targets that work.  But the check doesn't hurt,
and documents expectations.

> +        exit(EXIT_FAILURE);
> +    }
> +    s->dev = get_device(s->qs->pcibus);
>  
>      s->reg_bar = qpci_iomap(s->dev, 0, &barsize);
>      g_assert_cmpuint(barsize, ==, 256);
> @@ -347,7 +353,7 @@ static void test_ivshmem_server(bool msi)
>      g_assert_cmpint(vm1, !=, vm2);
>  
>      /* check number of MSI-X vectors */
> -    global_qtest = s1->qtest;
> +    global_qtest = s1->qs->qts;
>      if (msi) {
>          ret = qpci_msix_table_size(s1->dev);
>          g_assert_cmpuint(ret, ==, nvectors);
> @@ -370,7 +376,7 @@ static void test_ivshmem_server(bool msi)
>      g_assert_cmpuint(ret, !=, 0);
>  
>      /* ping vm1 -> vm2 on vector 1 */
> -    global_qtest = s2->qtest;
> +    global_qtest = s2->qs->qts;
>      if (msi) {
>          ret = qpci_msix_pending(s2->dev, 1);
>          g_assert_cmpuint(ret, ==, 0);
> @@ -412,6 +418,7 @@ static void test_ivshmem_server_irq(void)
>  
>  static void test_ivshmem_hotplug(void)
>  {
> +    const char *arch = qtest_get_arch();
>      gchar *opts;
>  
>      qtest_start("");

Unlike the other tests, this one doesn't refuse to run on unexpected
targets.  Intentional?

> @@ -419,7 +426,9 @@ static void test_ivshmem_hotplug(void)
>      opts = g_strdup_printf("'shm': '%s', 'size': '1M'", tmpshm);
>  
>      qpci_plug_device_test("ivshmem", "iv1", PCI_SLOT_HP, opts);
> -    qpci_unplug_acpi_device_test("iv1", PCI_SLOT_HP);
> +    if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
> +        qpci_unplug_acpi_device_test("iv1", PCI_SLOT_HP);
> +    }

Disables unplug test for ppc64.

>  
>      qtest_end();
>      g_free(opts);
> @@ -491,6 +500,7 @@ static gchar *mktempshm(int size, int *fd)
>  int main(int argc, char **argv)
>  {
>      int ret, fd;
> +    const char *arch = qtest_get_arch();
>      gchar dir[] = "/tmp/ivshmem-test.XXXXXX";
>  
>  #if !GLIB_CHECK_VERSION(2, 31, 0)
> @@ -521,8 +531,10 @@ int main(int argc, char **argv)
>      qtest_add_func("/ivshmem/memdev", test_ivshmem_memdev);
>      if (g_test_slow()) {
>          qtest_add_func("/ivshmem/pair", test_ivshmem_pair);
> -        qtest_add_func("/ivshmem/server-msi", test_ivshmem_server_msi);
> -        qtest_add_func("/ivshmem/server-irq", test_ivshmem_server_irq);
> +        if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
> +            qtest_add_func("/ivshmem/server-msi", test_ivshmem_server_msi);
> +            qtest_add_func("/ivshmem/server-irq", test_ivshmem_server_irq);
> +        }
>      }
>  
>      ret = g_test_run();

The commit message should explain things in a bit more detail: the test
works only for x86, and is only compiled and executed for x86.  The
patch converts it to libqos, adds ppc64, and makes the test fail for
targets that don't work.  It also disables the unplug part of test
/ivshmem/hotplug for ppc64; please explain why.

Please make the conversion to libqos a separate patch, for easier
review.
