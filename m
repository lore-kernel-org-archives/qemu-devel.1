Received: from eggs.gnu.org ([2001:4830:134:3::10]:38074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gX5Va-0000TZ-1r
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 09:29:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gX5VW-0004ma-Mh
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 09:29:05 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:41577)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gX5VW-0004mB-Bp
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 09:29:02 -0500
Received: by mail-wr1-f43.google.com with SMTP id x10so17876037wrs.8
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 06:29:02 -0800 (PST)
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
	<1543851204-41186-29-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3c07c948-6815-04ff-6750-a0153e503368@redhat.com>
Date: Wed, 12 Dec 2018 15:28:59 +0100
MIME-Version: 1.0
In-Reply-To: <1543851204-41186-29-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 28/71] qos-test: sdhci test node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, Laurent Vivier <laurent@vivier.eu>

On 12/3/18 4:32 PM, Paolo Bonzini wrote:
> From: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
> 
> Convert tests/sdhci-test in first qgraph test node, sdhci-test. This test
> consumes an sdhci interface and checks that its function return the
> expected values.
> 
> Note that this test does not allocate any sdhci structure, it's all done by the
> qtest walking graph mechanism
> 
> Signed-off-by: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  tests/Makefile.include |   7 +-
>  tests/sdhci-test.c     | 185 ++++++-------------------------------------------
>  2 files changed, 24 insertions(+), 168 deletions(-)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 752f2c2..e6be21c 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -216,7 +216,6 @@ check-qtest-i386-y += tests/migration-test$(EXESUF)
>  check-qtest-i386-y += tests/test-x86-cpuid-compat$(EXESUF)
>  check-qtest-i386-y += tests/numa-test$(EXESUF)
>  check-qtest-x86_64-y += $(check-qtest-i386-y)
> -check-qtest-x86_64-$(CONFIG_SDHCI) += tests/sdhci-test$(EXESUF)
>  
>  check-qtest-alpha-y += tests/boot-serial-test$(EXESUF)
>  
> @@ -278,11 +277,9 @@ check-qtest-arm-y += tests/m25p80-test$(EXESUF)
>  check-qtest-arm-y += tests/virtio-blk-test$(EXESUF)
>  check-qtest-arm-y += tests/test-arm-mptimer$(EXESUF)
>  check-qtest-arm-y += tests/boot-serial-test$(EXESUF)
> -check-qtest-arm-$(CONFIG_SDHCI) += tests/sdhci-test$(EXESUF)
>  check-qtest-arm-y += tests/hexloader-test$(EXESUF)
>  
>  check-qtest-aarch64-y = tests/numa-test$(EXESUF)
> -check-qtest-aarch64-$(CONFIG_SDHCI) += tests/sdhci-test$(EXESUF)
>  check-qtest-aarch64-y += tests/boot-serial-test$(EXESUF)
>  check-qtest-aarch64-y += tests/migration-test$(EXESUF)
>  
> @@ -688,6 +685,9 @@ qos-test-obj-y += tests/libqos/arm-smdkc210-machine.o
>  qos-test-obj-y += tests/libqos/arm-xilinx-zynq-a9-machine.o
>  qos-test-obj-y += tests/libqos/x86_64_pc-machine.o
>  
> +# Tests
> +qos-test-obj-y += tests/sdhci-test.o
> +
>  check-unit-y += tests/test-qgraph$(EXESUF)
>  tests/test-qgraph$(EXESUF): tests/test-qgraph.o $(libqgraph-obj-y)
>  
> @@ -780,7 +780,6 @@ tests/test-arm-mptimer$(EXESUF): tests/test-arm-mptimer.o
>  tests/test-qapi-util$(EXESUF): tests/test-qapi-util.o $(test-util-obj-y)
>  tests/numa-test$(EXESUF): tests/numa-test.o
>  tests/vmgenid-test$(EXESUF): tests/vmgenid-test.o tests/boot-sector.o tests/acpi-utils.o
> -tests/sdhci-test$(EXESUF): tests/sdhci-test.o $(libqos-pc-obj-y)
>  tests/cdrom-test$(EXESUF): tests/cdrom-test.o tests/boot-sector.o $(libqos-obj-y)
>  
>  tests/migration/stress$(EXESUF): tests/migration/stress.o
> diff --git a/tests/sdhci-test.c b/tests/sdhci-test.c
> index 28d481b..2f177e5 100644
> --- a/tests/sdhci-test.c
> +++ b/tests/sdhci-test.c
> @@ -12,6 +12,8 @@
>  #include "libqtest.h"
>  #include "libqos/pci-pc.h"
>  #include "hw/pci/pci.h"
> +#include "libqos/qgraph.h"
> +#include "libqos/sdhci.h"
>  
>  #define SDHC_CAPAB                      0x40
>  FIELD(SDHC_CAPAB, BASECLKFREQ,               8, 8); /* since v2 */
> @@ -20,99 +22,11 @@ FIELD(SDHC_CAPAB, SDR,                      32, 3); /* since v3 */
>  FIELD(SDHC_CAPAB, DRIVER,                   36, 3); /* since v3 */
>  #define SDHC_HCVER                      0xFE
>  
> -static const struct sdhci_t {
> -    const char *arch, *machine;
> -    struct {
> -        uintptr_t addr;
> -        uint8_t version;
> -        uint8_t baseclock;
> -        struct {
> -            bool sdma;
> -            uint64_t reg;
> -        } capab;
> -    } sdhci;
> -    struct {
> -        uint16_t vendor_id, device_id;
> -    } pci;
> -} models[] = {
> -    /* PC via PCI */
> -    { "x86_64", "pc",
> -        {-1,         2, 0,  {1, 0x057834b4} },
> -        .pci = { PCI_VENDOR_ID_REDHAT, PCI_DEVICE_ID_REDHAT_SDHCI } },
> -
> -    /* Exynos4210 */
> -    { "arm",    "smdkc210",
> -        {0x12510000, 2, 0,  {1, 0x5e80080} } },
> -
> -    /* i.MX 6 */
> -    { "arm",    "sabrelite",
> -        {0x02190000, 3, 0,  {1, 0x057834b4} } },
> -
> -    /* BCM2835 */
> -    { "arm",    "raspi2",
> -        {0x3f300000, 3, 52, {0, 0x052134b4} } },
> -
> -    /* Zynq-7000 */
> -    { "arm",    "xilinx-zynq-a9",   /* Datasheet: UG585 (v1.12.1) */
> -        {0xe0100000, 2, 0,  {1, 0x69ec0080} } },
> -
> -    /* ZynqMP */
> -    { "aarch64", "xlnx-zcu102",     /* Datasheet: UG1085 (v1.7) */
> -        {0xff160000, 3, 0,  {1, 0x280737ec6481} } },
> -
> -};
> -
> -typedef struct QSDHCI {
> -    struct {
> -        QPCIBus *bus;
> -        QPCIDevice *dev;
> -    } pci;
> -    union {
> -        QPCIBar mem_bar;
> -        uint64_t addr;
> -    };
> -} QSDHCI;
> -
> -static uint16_t sdhci_readw(QSDHCI *s, uint32_t reg)
> -{
> -    uint16_t val;
> -
> -    if (s->pci.dev) {
> -        val = qpci_io_readw(s->pci.dev, s->mem_bar, reg);
> -    } else {
> -        val = qtest_readw(global_qtest, s->addr + reg);
> -    }
> -
> -    return val;
> -}
> -
> -static uint64_t sdhci_readq(QSDHCI *s, uint32_t reg)
> -{
> -    uint64_t val;
> -
> -    if (s->pci.dev) {
> -        val = qpci_io_readq(s->pci.dev, s->mem_bar, reg);
> -    } else {
> -        val = qtest_readq(global_qtest, s->addr + reg);
> -    }
> -
> -    return val;
> -}
> -
> -static void sdhci_writeq(QSDHCI *s, uint32_t reg, uint64_t val)
> -{
> -    if (s->pci.dev) {
> -        qpci_io_writeq(s->pci.dev, s->mem_bar, reg, val);
> -    } else {
> -        qtest_writeq(global_qtest, s->addr + reg, val);
> -    }
> -}
> -
>  static void check_specs_version(QSDHCI *s, uint8_t version)
>  {
>      uint32_t v;
>  
> -    v = sdhci_readw(s, SDHC_HCVER);
> +    v = s->readw(s, SDHC_HCVER);
>      v &= 0xff;
>      v += 1;
>      g_assert_cmpuint(v, ==, version);
> @@ -122,7 +36,7 @@ static void check_capab_capareg(QSDHCI *s, uint64_t expec_capab)
>  {
>      uint64_t capab;
>  
> -    capab = sdhci_readq(s, SDHC_CAPAB);
> +    capab = s->readq(s, SDHC_CAPAB);
>      g_assert_cmphex(capab, ==, expec_capab);
>  }
>  
> @@ -131,11 +45,11 @@ static void check_capab_readonly(QSDHCI *s)
>      const uint64_t vrand = 0x123456789abcdef;
>      uint64_t capab0, capab1;
>  
> -    capab0 = sdhci_readq(s, SDHC_CAPAB);
> +    capab0 = s->readq(s, SDHC_CAPAB);
>      g_assert_cmpuint(capab0, !=, vrand);
>  
> -    sdhci_writeq(s, SDHC_CAPAB, vrand);
> -    capab1 = sdhci_readq(s, SDHC_CAPAB);
> +    s->writeq(s, SDHC_CAPAB, vrand);
> +    capab1 = s->readq(s, SDHC_CAPAB);
>      g_assert_cmpuint(capab1, !=, vrand);
>      g_assert_cmpuint(capab1, ==, capab0);
>  }
> @@ -147,7 +61,7 @@ static void check_capab_baseclock(QSDHCI *s, uint8_t expec_freq)
>      if (!expec_freq) {
>          return;
>      }
> -    capab = sdhci_readq(s, SDHC_CAPAB);
> +    capab = s->readq(s, SDHC_CAPAB);
>      capab_freq = FIELD_EX64(capab, SDHC_CAPAB, BASECLKFREQ);
>      g_assert_cmpuint(capab_freq, ==, expec_freq);
>  }
> @@ -156,7 +70,7 @@ static void check_capab_sdma(QSDHCI *s, bool supported)
>  {
>      uint64_t capab, capab_sdma;
>  
> -    capab = sdhci_readq(s, SDHC_CAPAB);
> +    capab = s->readq(s, SDHC_CAPAB);
>      capab_sdma = FIELD_EX64(capab, SDHC_CAPAB, SDMA);
>      g_assert_cmpuint(capab_sdma, ==, supported);
>  }
> @@ -167,7 +81,7 @@ static void check_capab_v3(QSDHCI *s, uint8_t version)
>  
>      if (version < 3) {
>          /* before v3 those fields are RESERVED */
> -        capab = sdhci_readq(s, SDHC_CAPAB);
> +        capab = s->readq(s, SDHC_CAPAB);
>          capab_v3 = FIELD_EX64(capab, SDHC_CAPAB, SDR);
>          g_assert_cmpuint(capab_v3, ==, 0);
>          capab_v3 = FIELD_EX64(capab, SDHC_CAPAB, DRIVER);
> @@ -175,78 +89,21 @@ static void check_capab_v3(QSDHCI *s, uint8_t version)
>      }
>  }
>  
> -static QSDHCI *machine_start(const struct sdhci_t *test)
> -{
> -    QSDHCI *s = g_new0(QSDHCI, 1);
> -
> -    if (test->pci.vendor_id) {
> -        /* PCI */
> -        uint16_t vendor_id, device_id;
> -        uint64_t barsize;
> -
> -        global_qtest = qtest_initf("-machine %s -device sdhci-pci",
> -                                   test->machine);
> -
> -        s->pci.bus = qpci_new_pc(global_qtest, NULL);
> -
> -        /* Find PCI device and verify it's the right one */
> -        s->pci.dev = qpci_device_find(s->pci.bus, QPCI_DEVFN(4, 0));
> -        g_assert_nonnull(s->pci.dev);
> -        vendor_id = qpci_config_readw(s->pci.dev, PCI_VENDOR_ID);
> -        device_id = qpci_config_readw(s->pci.dev, PCI_DEVICE_ID);
> -        g_assert(vendor_id == test->pci.vendor_id);
> -        g_assert(device_id == test->pci.device_id);
> -        s->mem_bar = qpci_iomap(s->pci.dev, 0, &barsize);
> -        qpci_device_enable(s->pci.dev);
> -    } else {
> -        /* SysBus */
> -        global_qtest = qtest_initf("-machine %s", test->machine);
> -        s->addr = test->sdhci.addr;
> -    }
> -
> -    return s;
> -}
> -
> -static void machine_stop(QSDHCI *s)
> -{
> -    qpci_free_pc(s->pci.bus);
> -    g_free(s->pci.dev);
> -    qtest_quit(global_qtest);
> -    g_free(s);
> -}
> -
> -static void test_machine(const void *data)
> +static void test_registers(void *obj, void *data, QGuestAllocator *alloc)
>  {
> -    const struct sdhci_t *test = data;
> -    QSDHCI *s;
> +    QSDHCI *s = obj;
>  
> -    s = machine_start(test);
> -
> -    check_specs_version(s, test->sdhci.version);
> -    check_capab_capareg(s, test->sdhci.capab.reg);
> +    check_specs_version(s, s->props.version);
> +    check_capab_capareg(s, s->props.capab.reg);
>      check_capab_readonly(s);
> -    check_capab_v3(s, test->sdhci.version);
> -    check_capab_sdma(s, test->sdhci.capab.sdma);
> -    check_capab_baseclock(s, test->sdhci.baseclock);
> -
> -    machine_stop(s);
> +    check_capab_v3(s, s->props.version);
> +    check_capab_sdma(s, s->props.capab.sdma);
> +    check_capab_baseclock(s, s->props.baseclock);
>  }
>  
> -int main(int argc, char *argv[])
> +static void register_sdhci_test(void)
>  {
> -    const char *arch = qtest_get_arch();
> -    char *name;
> -    int i;
> -
> -    g_test_init(&argc, &argv, NULL);
> -    for (i = 0; i < ARRAY_SIZE(models); i++) {
> -        if (strcmp(arch, models[i].arch)) {
> -            continue;
> -        }
> -        name = g_strdup_printf("sdhci/%s", models[i].machine);
> -        qtest_add_data_func(name, &models[i], test_machine);
> -        g_free(name);
> -    }
> -
> -    return g_test_run();
> +    qos_add_test("registers", "sdhci", test_registers, NULL);
>  }
> +
> +libqos_init(register_sdhci_test);
> 
