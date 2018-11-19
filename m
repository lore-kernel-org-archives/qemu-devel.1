Received: from eggs.gnu.org ([2001:4830:134:3::10]:33969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.kanda@oracle.com>) id 1gOlOb-0001Ld-CG
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:23:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.kanda@oracle.com>) id 1gOlOY-0002oj-Qa
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 10:23:29 -0500
References: <20181116093152.27227-1-pbonzini@redhat.com>
From: Mark Kanda <mark.kanda@oracle.com>
Message-ID: <4c83906c-0d78-3a73-b40d-ae5f7e58ffa3@oracle.com>
Date: Mon, 19 Nov 2018 09:23:01 -0600
MIME-Version: 1.0
In-Reply-To: <20181116093152.27227-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.1] nvme: fix out-of-bounds access to
 the CMB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Keith Busch <keith.busch@intel.com>, Li Qiang <liq3ea@gmail.com>, qemu-block@nongnu.org, kwolf@redhat.com

For CVE-2018-16847, I just noticed Kevin pulled in Li's previous fix (as 
opposed to this one). Was this done in error?

Thanks,

-Mark

On 11/16/2018 3:31 AM, Paolo Bonzini wrote:
> Because the CMB BAR has a min_access_size of 2, if you read the last
> byte it will try to memcpy *2* bytes from n->cmbuf, causing an off-by-one
> error.  This is CVE-2018-16847.
> 
> Another way to fix this might be to register the CMB as a RAM memory
> region, which would also be more efficient.  However, that might be a
> change for big-endian machines; I didn't think this through and I don't
> know how real hardware works.  Add a basic testcase for the CMB in case
> somebody does this change later on.
> 
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: qemu-block@nongnu.org
> Cc: Li Qiang <liq3ea@gmail.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/block/nvme.c        |  2 +-
>   tests/Makefile.include |  2 +-
>   tests/nvme-test.c      | 58 +++++++++++++++++++++++++++++++++++++++---
>   3 files changed, 57 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 09d7c90259..5d92794ef7 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -1192,7 +1192,7 @@ static const MemoryRegionOps nvme_cmb_ops = {
>       .write = nvme_cmb_write,
>       .endianness = DEVICE_LITTLE_ENDIAN,
>       .impl = {
> -        .min_access_size = 2,
> +        .min_access_size = 1,
>           .max_access_size = 8,
>       },
>   };
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 613242bc6e..fb0b449c02 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -730,7 +730,7 @@ tests/test-hmp$(EXESUF): tests/test-hmp.o
>   tests/machine-none-test$(EXESUF): tests/machine-none-test.o
>   tests/drive_del-test$(EXESUF): tests/drive_del-test.o $(libqos-virtio-obj-y)
>   tests/qdev-monitor-test$(EXESUF): tests/qdev-monitor-test.o $(libqos-pc-obj-y)
> -tests/nvme-test$(EXESUF): tests/nvme-test.o
> +tests/nvme-test$(EXESUF): tests/nvme-test.o $(libqos-pc-obj-y)
>   tests/pvpanic-test$(EXESUF): tests/pvpanic-test.o
>   tests/i82801b11-test$(EXESUF): tests/i82801b11-test.o
>   tests/ac97-test$(EXESUF): tests/ac97-test.o
> diff --git a/tests/nvme-test.c b/tests/nvme-test.c
> index 7674a446e4..2abb3b6d19 100644
> --- a/tests/nvme-test.c
> +++ b/tests/nvme-test.c
> @@ -8,11 +8,64 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/units.h"
>   #include "libqtest.h"
> +#include "libqos/libqos-pc.h"
> +
> +static QOSState *qnvme_start(const char *extra_opts)
> +{
> +    QOSState *qs;
> +    const char *arch = qtest_get_arch();
> +    const char *cmd = "-drive id=drv0,if=none,file=null-co://,format=raw "
> +                      "-device nvme,addr=0x4.0,serial=foo,drive=drv0 %s";
> +
> +    if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
> +        qs = qtest_pc_boot(cmd, extra_opts ? : "");
> +        global_qtest = qs->qts;
> +        return qs;
> +    }
> +
> +    g_printerr("nvme tests are only available on x86\n");
> +    exit(EXIT_FAILURE);
> +}
> +
> +static void qnvme_stop(QOSState *qs)
> +{
> +    qtest_shutdown(qs);
> +}
>   
> -/* Tests only initialization so far. TODO: Replace with functional tests */
>   static void nop(void)
>   {
> +    QOSState *qs;
> +
> +    qs = qnvme_start(NULL);
> +    qnvme_stop(qs);
> +}
> +
> +static void nvmetest_cmb_test(void)
> +{
> +    const int cmb_bar_size = 2 * MiB;
> +    QOSState *qs;
> +    QPCIDevice *pdev;
> +    QPCIBar bar;
> +
> +    qs = qnvme_start("-global nvme.cmb_size_mb=2");
> +    pdev = qpci_device_find(qs->pcibus, QPCI_DEVFN(4,0));
> +    g_assert(pdev != NULL);
> +
> +    qpci_device_enable(pdev);
> +    bar = qpci_iomap(pdev, 2, NULL);
> +
> +    qpci_io_writel(pdev, bar, 0, 0xccbbaa99);
> +    g_assert_cmpint(qpci_io_readb(pdev, bar, 0), ==, 0x99);
> +    g_assert_cmpint(qpci_io_readw(pdev, bar, 0), ==, 0xaa99);
> +
> +    /* Test partially out-of-bounds accesses.  */
> +    qpci_io_writel(pdev, bar, cmb_bar_size - 1, 0x44332211);
> +    g_assert_cmpint(qpci_io_readb(pdev, bar, cmb_bar_size - 1), ==, 0x11);
> +    g_assert_cmpint(qpci_io_readw(pdev, bar, cmb_bar_size - 1), !=, 0x2211);
> +    g_assert_cmpint(qpci_io_readl(pdev, bar, cmb_bar_size - 1), !=, 0x44332211);
> +    qnvme_stop(qs);
>   }
>   
>   int main(int argc, char **argv)
> @@ -21,9 +74,8 @@ int main(int argc, char **argv)
>   
>       g_test_init(&argc, &argv, NULL);
>       qtest_add_func("/nvme/nop", nop);
> +    qtest_add_func("/nvme/cmb_test", nvmetest_cmb_test);
>   
> -    qtest_start("-drive id=drv0,if=none,file=null-co://,format=raw "
> -                "-device nvme,drive=drv0,serial=foo");
>       ret = g_test_run();
>   
>       qtest_end();
> 
