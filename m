Received: from eggs.gnu.org ([2001:4830:134:3::10]:37633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnrV3-0002O2-85
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 15:21:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnrUz-0002wU-Vu
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 15:21:05 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170901180340.30009-1-eblake@redhat.com>
	<20170901180340.30009-13-eblake@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <13667793-2b90-2e9d-4582-6087258adfc2@amsat.org>
Date: Fri, 1 Sep 2017 16:20:46 -0300
MIME-Version: 1.0
In-Reply-To: <20170901180340.30009-13-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v6 12/29] libqos: Track QTestState with
 QPCIBus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: "open list:IDE" <qemu-block@nongnu.org>, Alexander Graf <agraf@suse.de>, armbru@redhat.com, "open list:sPAPR" <qemu-ppc@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, pbonzini@redhat.com, John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

Hi Eric,

On 09/01/2017 03:03 PM, Eric Blake wrote:
> When initializing a QPCIBus, track which QTestState the bus is
> associated with (so that a later patch can then explicitly use
> that test state for all communication on the bus, rather than
> blindly relying on global_qtest).  Update the initialization
> functions to take another parameter, and update all callers to
> pass in state (for now, most callers get away with passing the
> current global_qtest as the current state, although this required
> fixing the order of initialization to ensure qtest_start() is
> called before qpci_init*() in rtl8139-test, and provided an
> opportunity to pass in the allocator in e1000e-test).
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   tests/libqos/ahci.h       | 2 +-
>   tests/libqos/libqos.h     | 2 +-
>   tests/libqos/pci-pc.h     | 2 +-
>   tests/libqos/pci-spapr.h  | 2 +-
>   tests/libqos/pci.h        | 1 +
>   tests/ahci-test.c         | 2 +-
>   tests/e1000e-test.c       | 6 +++---
>   tests/i440fx-test.c       | 2 +-
>   tests/ide-test.c          | 2 +-
>   tests/libqos/ahci.c       | 4 ++--
>   tests/libqos/libqos.c     | 4 ++--
>   tests/libqos/pci-pc.c     | 5 ++++-
>   tests/libqos/pci-spapr.c  | 6 +++++-
>   tests/q35-test.c          | 4 ++--
>   tests/rtl8139-test.c      | 5 +++--
>   tests/tco-test.c          | 2 +-
>   tests/usb-hcd-ehci-test.c | 2 +-
>   tests/vhost-user-test.c   | 4 ++--
>   18 files changed, 33 insertions(+), 24 deletions(-)
> 
> diff --git a/tests/libqos/ahci.h b/tests/libqos/ahci.h
> index 5f9627bb0f..715ca1e226 100644
> --- a/tests/libqos/ahci.h
> +++ b/tests/libqos/ahci.h
> @@ -571,7 +571,7 @@ void ahci_free(AHCIQState *ahci, uint64_t addr);
>   void ahci_clean_mem(AHCIQState *ahci);
> 
>   /* Device management */
> -QPCIDevice *get_ahci_device(uint32_t *fingerprint);
> +QPCIDevice *get_ahci_device(QTestState *qts, uint32_t *fingerprint);
>   void free_ahci_device(QPCIDevice *dev);
>   void ahci_pci_enable(AHCIQState *ahci);
>   void start_ahci_device(AHCIQState *ahci);
> diff --git a/tests/libqos/libqos.h b/tests/libqos/libqos.h
> index 231969766f..78e5c044a0 100644
> --- a/tests/libqos/libqos.h
> +++ b/tests/libqos/libqos.h
> @@ -10,7 +10,7 @@ typedef struct QOSState QOSState;
>   typedef struct QOSOps {
>       QGuestAllocator *(*init_allocator)(QAllocOpts);
>       void (*uninit_allocator)(QGuestAllocator *);
> -    QPCIBus *(*qpci_init)(QGuestAllocator *alloc);
> +    QPCIBus *(*qpci_init)(QTestState *qts, QGuestAllocator *alloc);
>       void (*qpci_free)(QPCIBus *bus);
>       void (*shutdown)(QOSState *);
>   } QOSOps;
> diff --git a/tests/libqos/pci-pc.h b/tests/libqos/pci-pc.h
> index 9479b51642..491eeac756 100644
> --- a/tests/libqos/pci-pc.h
> +++ b/tests/libqos/pci-pc.h
> @@ -16,7 +16,7 @@
>   #include "libqos/pci.h"
>   #include "libqos/malloc.h"
> 
> -QPCIBus *qpci_init_pc(QGuestAllocator *alloc);
> +QPCIBus *qpci_init_pc(QTestState *qts, QGuestAllocator *alloc);
>   void     qpci_free_pc(QPCIBus *bus);
> 
>   #endif
> diff --git a/tests/libqos/pci-spapr.h b/tests/libqos/pci-spapr.h
> index 4192126d86..387686dfc8 100644
> --- a/tests/libqos/pci-spapr.h
> +++ b/tests/libqos/pci-spapr.h
> @@ -11,7 +11,7 @@
>   #include "libqos/malloc.h"
>   #include "libqos/pci.h"
> 
> -QPCIBus *qpci_init_spapr(QGuestAllocator *alloc);
> +QPCIBus *qpci_init_spapr(QTestState *qts, QGuestAllocator *alloc);
>   void     qpci_free_spapr(QPCIBus *bus);
> 
>   #endif
> diff --git a/tests/libqos/pci.h b/tests/libqos/pci.h
> index ed480614ff..429c382282 100644
> --- a/tests/libqos/pci.h
> +++ b/tests/libqos/pci.h
> @@ -48,6 +48,7 @@ struct QPCIBus {
>       void (*config_writel)(QPCIBus *bus, int devfn,
>                             uint8_t offset, uint32_t value);
> 
> +    QTestState *qts;
>       uint16_t pio_alloc_ptr;
>       uint64_t mmio_alloc_ptr, mmio_limit;
>   };
> diff --git a/tests/ahci-test.c b/tests/ahci-test.c
> index 999121bb7c..c94d1bd712 100644
> --- a/tests/ahci-test.c
> +++ b/tests/ahci-test.c
> @@ -160,7 +160,7 @@ static AHCIQState *ahci_vboot(const char *cli, va_list ap)
>       alloc_set_flags(s->parent->alloc, ALLOC_LEAK_ASSERT);
> 
>       /* Verify that we have an AHCI device present. */
> -    s->dev = get_ahci_device(&s->fingerprint);
> +    s->dev = get_ahci_device(s->parent->qts, &s->fingerprint);
> 
>       return s;
>   }
> diff --git a/tests/e1000e-test.c b/tests/e1000e-test.c
> index c612dc64ec..d8085d944e 100644
> --- a/tests/e1000e-test.c
> +++ b/tests/e1000e-test.c
> @@ -392,12 +392,12 @@ static void data_test_init(e1000e_device *d)
>       qtest_start(cmdline);
>       g_free(cmdline);
> 
> -    test_bus = qpci_init_pc(NULL);
> -    g_assert_nonnull(test_bus);
> -
>       test_alloc = pc_alloc_init();
>       g_assert_nonnull(test_alloc);
> 
> +    test_bus = qpci_init_pc(global_qtest, test_alloc);
> +    g_assert_nonnull(test_bus);
> +
>       e1000e_device_init(test_bus, d);
>   }
> 
> diff --git a/tests/i440fx-test.c b/tests/i440fx-test.c
> index e9d05c87d1..4390e5591e 100644
> --- a/tests/i440fx-test.c
> +++ b/tests/i440fx-test.c
> @@ -38,7 +38,7 @@ static QPCIBus *test_start_get_bus(const TestData *s)
>       cmdline = g_strdup_printf("-smp %d", s->num_cpus);
>       qtest_start(cmdline);
>       g_free(cmdline);
> -    return qpci_init_pc(NULL);
> +    return qpci_init_pc(global_qtest, NULL);
>   }
> 
>   static void test_i440fx_defaults(gconstpointer opaque)
> diff --git a/tests/ide-test.c b/tests/ide-test.c
> index aa9de065fc..b2237b6158 100644
> --- a/tests/ide-test.c
> +++ b/tests/ide-test.c
> @@ -143,7 +143,7 @@ static QPCIDevice *get_pci_device(QPCIBar *bmdma_bar, QPCIBar *ide_bar)
>       uint16_t vendor_id, device_id;
> 
>       if (!pcibus) {
> -        pcibus = qpci_init_pc(NULL);
> +        pcibus = qpci_init_pc(global_qtest, NULL);
>       }
> 
>       /* Find PCI device and verify it's the right one */
> diff --git a/tests/libqos/ahci.c b/tests/libqos/ahci.c
> index 1ca7f456b5..790ef991b3 100644
> --- a/tests/libqos/ahci.c
> +++ b/tests/libqos/ahci.c
> @@ -123,13 +123,13 @@ bool is_atapi(AHCIQState *ahci, uint8_t port)
>   /**
>    * Locate, verify, and return a handle to the AHCI device.
>    */
> -QPCIDevice *get_ahci_device(uint32_t *fingerprint)
> +QPCIDevice *get_ahci_device(QTestState *qts, uint32_t *fingerprint)
>   {
>       QPCIDevice *ahci;
>       uint32_t ahci_fingerprint;
>       QPCIBus *pcibus;
> 
> -    pcibus = qpci_init_pc(NULL);
> +    pcibus = qpci_init_pc(qts, NULL);
> 
>       /* Find the AHCI PCI device and verify it's the right one. */
>       ahci = qpci_device_find(pcibus, QPCI_DEVFN(0x1F, 0x02));
> diff --git a/tests/libqos/libqos.c b/tests/libqos/libqos.c
> index 6226546c28..c95428e1cb 100644
> --- a/tests/libqos/libqos.c
> +++ b/tests/libqos/libqos.c
> @@ -26,8 +26,8 @@ QOSState *qtest_vboot(QOSOps *ops, const char *cmdline_fmt, va_list ap)
>           if (ops->init_allocator) {
>               qs->alloc = ops->init_allocator(ALLOC_NO_FLAGS);
>           }
> -        if (ops->qpci_init && qs->alloc) {
> -            qs->pcibus = ops->qpci_init(qs->alloc);
> +        if (ops->qpci_init) {
> +            qs->pcibus = ops->qpci_init(qs->qts, qs->alloc);
>           }
>       }
> 
> diff --git a/tests/libqos/pci-pc.c b/tests/libqos/pci-pc.c
> index 02ce49927a..85b34c6d13 100644
> --- a/tests/libqos/pci-pc.c
> +++ b/tests/libqos/pci-pc.c
> @@ -115,11 +115,14 @@ static void qpci_pc_config_writel(QPCIBus *bus, int devfn, uint8_t offset, uint3
>       outl(0xcfc, value);
>   }
> 
> -QPCIBus *qpci_init_pc(QGuestAllocator *alloc)
> +QPCIBus *qpci_init_pc(QTestState *qts, QGuestAllocator *alloc)
>   {
>       QPCIBusPC *ret;
> 
> +    assert(qts);
> +
>       ret = g_malloc(sizeof(*ret));

I'd rather use g_malloc0() here (safer!)

> +    ret->bus.qts = qts;
> 
>       ret->bus.pio_readb = qpci_pc_pio_readb;
>       ret->bus.pio_readw = qpci_pc_pio_readw;

or init qts field in same order than struct:

...
         ret->bus.config_writel = qpci_pc_config_writel;

+       ret->bus.qts = qts;

         ret->bus.pio_alloc_ptr = 0xc000;
...

> diff --git a/tests/libqos/pci-spapr.c b/tests/libqos/pci-spapr.c
> index 2043f1e123..cd9b8f52d2 100644
> --- a/tests/libqos/pci-spapr.c
> +++ b/tests/libqos/pci-spapr.c
> @@ -154,11 +154,14 @@ static void qpci_spapr_config_writel(QPCIBus *bus, int devfn, uint8_t offset,
>   #define SPAPR_PCI_MMIO32_WIN_SIZE    0x80000000 /* 2 GiB */
>   #define SPAPR_PCI_IO_WIN_SIZE        0x10000
> 
> -QPCIBus *qpci_init_spapr(QGuestAllocator *alloc)
> +QPCIBus *qpci_init_spapr(QTestState *qts, QGuestAllocator *alloc)
>   {
>       QPCIBusSPAPR *ret;
> 
> +    assert(qts);
> +
>       ret = g_malloc(sizeof(*ret));
> +    ret->bus.qts = qts;

same

Either ways:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
>       ret->alloc = alloc;
> 
> @@ -201,6 +204,7 @@ QPCIBus *qpci_init_spapr(QGuestAllocator *alloc)
>       ret->bus.mmio_alloc_ptr = ret->mmio32.pci_base;
>       ret->bus.mmio_limit = ret->mmio32.pci_base + ret->mmio32.size;
> 
> +
>       return &ret->bus;
>   }
> 
> diff --git a/tests/q35-test.c b/tests/q35-test.c
> index f98bed7a2d..e149c4c51d 100644
> --- a/tests/q35-test.c
> +++ b/tests/q35-test.c
> @@ -86,7 +86,7 @@ static void test_smram_lock(void)
> 
>       qtest_start("-M q35");
> 
> -    pcibus = qpci_init_pc(NULL);
> +    pcibus = qpci_init_pc(global_qtest, NULL);
>       g_assert(pcibus != NULL);
> 
>       pcidev = qpci_device_find(pcibus, 0);
> @@ -145,7 +145,7 @@ static void test_tseg_size(const void *data)
>       g_free(cmdline);
> 
>       /* locate the DRAM controller */
> -    pcibus = qpci_init_pc(NULL);
> +    pcibus = qpci_init_pc(global_qtest, NULL);
>       g_assert(pcibus != NULL);
>       pcidev = qpci_device_find(pcibus, 0);
>       g_assert(pcidev != NULL);
> diff --git a/tests/rtl8139-test.c b/tests/rtl8139-test.c
> index 7de7dc45ae..68bfc42178 100644
> --- a/tests/rtl8139-test.c
> +++ b/tests/rtl8139-test.c
> @@ -35,7 +35,7 @@ static QPCIDevice *get_device(void)
>   {
>       QPCIDevice *dev;
> 
> -    pcibus = qpci_init_pc(NULL);
> +    pcibus = qpci_init_pc(global_qtest, NULL);
>       qpci_device_foreach(pcibus, 0x10ec, 0x8139, save_fn, &dev);
>       g_assert(dev != NULL);
> 
> @@ -197,11 +197,12 @@ int main(int argc, char **argv)
>   {
>       int ret;
> 
> +    qtest_start("-device rtl8139");
> +
>       g_test_init(&argc, &argv, NULL);
>       qtest_add_func("/rtl8139/nop", nop);
>       qtest_add_func("/rtl8139/timer", test_init);
> 
> -    qtest_start("-device rtl8139");
>       ret = g_test_run();
> 
>       qtest_end();
> diff --git a/tests/tco-test.c b/tests/tco-test.c
> index f2ed6ed91c..0387971953 100644
> --- a/tests/tco-test.c
> +++ b/tests/tco-test.c
> @@ -64,7 +64,7 @@ static void test_init(TestData *d)
>       qtest_irq_intercept_in(qs, "ioapic");
>       g_free(s);
> 
> -    d->bus = qpci_init_pc(NULL);
> +    d->bus = qpci_init_pc(qs, NULL);
>       d->dev = qpci_device_find(d->bus, QPCI_DEVFN(0x1f, 0x00));
>       g_assert(d->dev != NULL);
> 
> diff --git a/tests/usb-hcd-ehci-test.c b/tests/usb-hcd-ehci-test.c
> index 944eb1c088..55d4743a2a 100644
> --- a/tests/usb-hcd-ehci-test.c
> +++ b/tests/usb-hcd-ehci-test.c
> @@ -52,7 +52,7 @@ static void ehci_port_test(struct qhc *hc, int port, uint32_t expect)
> 
>   static void test_init(void)
>   {
> -    pcibus = qpci_init_pc(NULL);
> +    pcibus = qpci_init_pc(global_qtest, NULL);
>       g_assert(pcibus != NULL);
> 
>       qusb_pci_init_one(pcibus, &uhci1, QPCI_DEVFN(0x1d, 0), 4);
> diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
> index d4da09f147..ea7d38ea44 100644
> --- a/tests/vhost-user-test.c
> +++ b/tests/vhost-user-test.c
> @@ -164,7 +164,7 @@ static void init_virtio_dev(TestServer *s)
>       QVirtioPCIDevice *dev;
>       uint32_t features;
> 
> -    s->bus = qpci_init_pc(NULL);
> +    s->bus = qpci_init_pc(global_qtest, NULL);
>       g_assert_nonnull(s->bus);
> 
>       dev = qvirtio_pci_device_find(s->bus, VIRTIO_ID_NET);
> @@ -891,7 +891,7 @@ static void test_multiqueue(void)
>       qtest_start(cmd);
>       g_free(cmd);
> 
> -    bus = qpci_init_pc(NULL);
> +    bus = qpci_init_pc(global_qtest, NULL);
>       dev = virtio_net_pci_init(bus, PCI_SLOT);
> 
>       alloc = pc_alloc_init();
> 
