Received: from eggs.gnu.org ([2001:4830:134:3::10]:39115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnrYh-0005xI-8C
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 15:24:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dnrYb-0004zf-PG
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 15:24:51 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170901180340.30009-1-eblake@redhat.com>
	<20170901180340.30009-15-eblake@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6c2e878d-fbb3-ce73-2b90-6fd1d92cfef1@amsat.org>
Date: Fri, 1 Sep 2017 16:24:26 -0300
MIME-Version: 1.0
In-Reply-To: <20170901180340.30009-15-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v6 14/29] libqos: Use explicit QTestState
 for fw_cfg operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: "open list:IDE" <qemu-block@nongnu.org>, Alexander Graf <agraf@suse.de>, armbru@redhat.com, "open list:sPAPR" <qemu-ppc@nongnu.org>, pbonzini@redhat.com, John Snow <jsnow@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On 09/01/2017 03:03 PM, Eric Blake wrote:
> Drop one more client of global_qtest by teaching all fw_cfg test
> functionality (invoked through alloc-pc) to pass in an explicit
> QTestState, adjusting all callers.  In particular, fw_cfg-test
> had to reorder things to create the test state prior to creating
> the fw_cfg.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   tests/libqos/fw_cfg.h       | 10 ++++++----
>   tests/libqos/libqos.h       |  2 +-
>   tests/libqos/malloc-pc.h    |  4 ++--
>   tests/libqos/malloc-spapr.h |  2 +-
>   tests/libqos/malloc.h       |  1 +
>   tests/boot-order-test.c     |  6 +++---
>   tests/e1000e-test.c         |  2 +-
>   tests/fw_cfg-test.c         | 14 ++++++--------
>   tests/ide-test.c            |  2 +-
>   tests/libqos/fw_cfg.c       | 14 ++++++++------
>   tests/libqos/libqos.c       |  2 +-
>   tests/libqos/malloc-pc.c    |  8 ++++----
>   tests/libqos/malloc-spapr.c |  4 ++--
>   tests/vhost-user-test.c     |  2 +-
>   14 files changed, 38 insertions(+), 35 deletions(-)
> 
> diff --git a/tests/libqos/fw_cfg.h b/tests/libqos/fw_cfg.h
> index e8371b2317..396dd4ee1e 100644
> --- a/tests/libqos/fw_cfg.h
> +++ b/tests/libqos/fw_cfg.h
> @@ -15,10 +15,12 @@
> 
> 
>   typedef struct QFWCFG QFWCFG;
> +typedef struct QTestState QTestState;
> 
>   struct QFWCFG
>   {
>       uint64_t base;
> +    QTestState *qts;
>       void (*select)(QFWCFG *fw_cfg, uint16_t key);
>       void (*read)(QFWCFG *fw_cfg, void *data, size_t len);
>   };
> @@ -30,12 +32,12 @@ uint16_t qfw_cfg_get_u16(QFWCFG *fw_cfg, uint16_t key);
>   uint32_t qfw_cfg_get_u32(QFWCFG *fw_cfg, uint16_t key);
>   uint64_t qfw_cfg_get_u64(QFWCFG *fw_cfg, uint16_t key);
> 
> -QFWCFG *mm_fw_cfg_init(uint64_t base);
> -QFWCFG *io_fw_cfg_init(uint16_t base);
> +QFWCFG *mm_fw_cfg_init(QTestState *qts, uint64_t base);
> +QFWCFG *io_fw_cfg_init(QTestState *qts, uint16_t base);
> 
> -static inline QFWCFG *pc_fw_cfg_init(void)
> +static inline QFWCFG *pc_fw_cfg_init(QTestState *qts)
>   {
> -    return io_fw_cfg_init(0x510);
> +    return io_fw_cfg_init(qts, 0x510);
>   }
> 
>   #endif
> diff --git a/tests/libqos/libqos.h b/tests/libqos/libqos.h
> index 78e5c044a0..07d4b93d1d 100644
> --- a/tests/libqos/libqos.h
> +++ b/tests/libqos/libqos.h
> @@ -8,7 +8,7 @@
>   typedef struct QOSState QOSState;
> 
>   typedef struct QOSOps {
> -    QGuestAllocator *(*init_allocator)(QAllocOpts);
> +    QGuestAllocator *(*init_allocator)(QTestState *qts, QAllocOpts);
>       void (*uninit_allocator)(QGuestAllocator *);
>       QPCIBus *(*qpci_init)(QTestState *qts, QGuestAllocator *alloc);
>       void (*qpci_free)(QPCIBus *bus);
> diff --git a/tests/libqos/malloc-pc.h b/tests/libqos/malloc-pc.h
> index 86ab9f0429..10f3da6cf2 100644
> --- a/tests/libqos/malloc-pc.h
> +++ b/tests/libqos/malloc-pc.h
> @@ -15,8 +15,8 @@
> 
>   #include "libqos/malloc.h"
> 
> -QGuestAllocator *pc_alloc_init(void);
> -QGuestAllocator *pc_alloc_init_flags(QAllocOpts flags);
> +QGuestAllocator *pc_alloc_init(QTestState *qts);
> +QGuestAllocator *pc_alloc_init_flags(QTestState *qts, QAllocOpts flags);
>   void pc_alloc_uninit(QGuestAllocator *allocator);
> 
>   #endif
> diff --git a/tests/libqos/malloc-spapr.h b/tests/libqos/malloc-spapr.h
> index 64d0e770d1..52a9346a26 100644
> --- a/tests/libqos/malloc-spapr.h
> +++ b/tests/libqos/malloc-spapr.h
> @@ -11,7 +11,7 @@
>   #include "libqos/malloc.h"
> 
>   QGuestAllocator *spapr_alloc_init(void);
> -QGuestAllocator *spapr_alloc_init_flags(QAllocOpts flags);
> +QGuestAllocator *spapr_alloc_init_flags(QTestState *qts, QAllocOpts flags);
>   void spapr_alloc_uninit(QGuestAllocator *allocator);
> 
>   #endif
> diff --git a/tests/libqos/malloc.h b/tests/libqos/malloc.h
> index ae9dac8f61..828fddabdb 100644
> --- a/tests/libqos/malloc.h
> +++ b/tests/libqos/malloc.h
> @@ -14,6 +14,7 @@
>   #define LIBQOS_MALLOC_H
> 
>   #include "qemu/queue.h"
> +#include "libqtest.h"
> 
>   typedef enum {
>       ALLOC_NO_FLAGS    = 0x00,
> diff --git a/tests/boot-order-test.c b/tests/boot-order-test.c
> index 9d516830dd..5fc2ca8e9e 100644
> --- a/tests/boot-order-test.c
> +++ b/tests/boot-order-test.c
> @@ -135,7 +135,7 @@ static void test_prep_boot_order(void)
> 
>   static uint64_t read_boot_order_pmac(void)
>   {
> -    QFWCFG *fw_cfg = mm_fw_cfg_init(0xf0000510);
> +    QFWCFG *fw_cfg = mm_fw_cfg_init(global_qtest, 0xf0000510);
> 
>       return qfw_cfg_get_u16(fw_cfg, FW_CFG_BOOT_DEVICE);
>   }
> @@ -160,7 +160,7 @@ static void test_pmac_newworld_boot_order(void)
> 
>   static uint64_t read_boot_order_sun4m(void)
>   {
> -    QFWCFG *fw_cfg = mm_fw_cfg_init(0xd00000510ULL);
> +    QFWCFG *fw_cfg = mm_fw_cfg_init(global_qtest, 0xd00000510ULL);
> 
>       return qfw_cfg_get_u16(fw_cfg, FW_CFG_BOOT_DEVICE);
>   }
> @@ -172,7 +172,7 @@ static void test_sun4m_boot_order(void)
> 
>   static uint64_t read_boot_order_sun4u(void)
>   {
> -    QFWCFG *fw_cfg = io_fw_cfg_init(0x510);
> +    QFWCFG *fw_cfg = io_fw_cfg_init(global_qtest, 0x510);
> 
>       return qfw_cfg_get_u16(fw_cfg, FW_CFG_BOOT_DEVICE);
>   }
> diff --git a/tests/e1000e-test.c b/tests/e1000e-test.c
> index d8085d944e..32aa738b72 100644
> --- a/tests/e1000e-test.c
> +++ b/tests/e1000e-test.c
> @@ -392,7 +392,7 @@ static void data_test_init(e1000e_device *d)
>       qtest_start(cmdline);
>       g_free(cmdline);
> 
> -    test_alloc = pc_alloc_init();
> +    test_alloc = pc_alloc_init(global_qtest);
>       g_assert_nonnull(test_alloc);
> 
>       test_bus = qpci_init_pc(global_qtest, test_alloc);
> diff --git a/tests/fw_cfg-test.c b/tests/fw_cfg-test.c
> index 688342bed5..47596c57a1 100644
> --- a/tests/fw_cfg-test.c
> +++ b/tests/fw_cfg-test.c
> @@ -107,7 +107,11 @@ int main(int argc, char **argv)
> 
>       g_test_init(&argc, &argv, NULL);
> 
> -    fw_cfg = pc_fw_cfg_init();
> +    cmdline = g_strdup_printf("-uuid 4600cb32-38ec-4b2f-8acb-81c6ea54f2d8 ");
> +    s = qtest_start(cmdline);
> +    g_free(cmdline);
> +
> +    fw_cfg = pc_fw_cfg_init(s);
> 
>       qtest_add_func("fw_cfg/signature", test_fw_cfg_signature);
>       qtest_add_func("fw_cfg/id", test_fw_cfg_id);
> @@ -125,15 +129,9 @@ int main(int argc, char **argv)
>       qtest_add_func("fw_cfg/numa", test_fw_cfg_numa);
>       qtest_add_func("fw_cfg/boot_menu", test_fw_cfg_boot_menu);
> 
> -    cmdline = g_strdup_printf("-uuid 4600cb32-38ec-4b2f-8acb-81c6ea54f2d8 ");
> -    s = qtest_start(cmdline);
> -    g_free(cmdline);
> -
>       ret = g_test_run();
> 
> -    if (s) {
> -        qtest_quit(s);
> -    }
> +    qtest_quit(s);
> 
>       return ret;
>   }
> diff --git a/tests/ide-test.c b/tests/ide-test.c
> index b2237b6158..084f6a5f96 100644
> --- a/tests/ide-test.c
> +++ b/tests/ide-test.c
> @@ -125,7 +125,7 @@ static void ide_test_start(const char *cmdline_fmt, ...)
>       va_end(ap);
> 
>       qtest_start(cmdline);
> -    guest_malloc = pc_alloc_init();
> +    guest_malloc = pc_alloc_init(global_qtest);
> 
>       g_free(cmdline);
>   }
> diff --git a/tests/libqos/fw_cfg.c b/tests/libqos/fw_cfg.c
> index 4d9dc3fd0b..d0889d1e22 100644
> --- a/tests/libqos/fw_cfg.c
> +++ b/tests/libqos/fw_cfg.c
> @@ -56,7 +56,7 @@ uint64_t qfw_cfg_get_u64(QFWCFG *fw_cfg, uint16_t key)
> 
>   static void mm_fw_cfg_select(QFWCFG *fw_cfg, uint16_t key)
>   {
> -    writew(fw_cfg->base, key);
> +    qtest_writew(fw_cfg->qts, fw_cfg->base, key);
>   }
> 
>   static void mm_fw_cfg_read(QFWCFG *fw_cfg, void *data, size_t len)
> @@ -65,15 +65,16 @@ static void mm_fw_cfg_read(QFWCFG *fw_cfg, void *data, size_t len)
>       int i;
> 
>       for (i = 0; i < len; i++) {
> -        ptr[i] = readb(fw_cfg->base + 2);
> +        ptr[i] = qtest_readb(fw_cfg->qts, fw_cfg->base + 2);
>       }
>   }
> 
> -QFWCFG *mm_fw_cfg_init(uint64_t base)
> +QFWCFG *mm_fw_cfg_init(QTestState *qts, uint64_t base)
>   {
>       QFWCFG *fw_cfg = g_malloc0(sizeof(*fw_cfg));
> 
>       fw_cfg->base = base;
> +    fw_cfg->qts = qts;
>       fw_cfg->select = mm_fw_cfg_select;
>       fw_cfg->read = mm_fw_cfg_read;
> 
> @@ -82,7 +83,7 @@ QFWCFG *mm_fw_cfg_init(uint64_t base)
> 
>   static void io_fw_cfg_select(QFWCFG *fw_cfg, uint16_t key)
>   {
> -    outw(fw_cfg->base, key);
> +    qtest_outw(fw_cfg->qts, fw_cfg->base, key);
>   }
> 
>   static void io_fw_cfg_read(QFWCFG *fw_cfg, void *data, size_t len)
> @@ -91,15 +92,16 @@ static void io_fw_cfg_read(QFWCFG *fw_cfg, void *data, size_t len)
>       int i;
> 
>       for (i = 0; i < len; i++) {
> -        ptr[i] = inb(fw_cfg->base + 1);
> +        ptr[i] = qtest_inb(fw_cfg->qts, fw_cfg->base + 1);
>       }
>   }
> 
> -QFWCFG *io_fw_cfg_init(uint16_t base)
> +QFWCFG *io_fw_cfg_init(QTestState *qts, uint16_t base)
>   {
>       QFWCFG *fw_cfg = g_malloc0(sizeof(*fw_cfg));
> 
>       fw_cfg->base = base;
> +    fw_cfg->qts = qts;
>       fw_cfg->select = io_fw_cfg_select;
>       fw_cfg->read = io_fw_cfg_read;
> 
> diff --git a/tests/libqos/libqos.c b/tests/libqos/libqos.c
> index c95428e1cb..62d2f39b93 100644
> --- a/tests/libqos/libqos.c
> +++ b/tests/libqos/libqos.c
> @@ -24,7 +24,7 @@ QOSState *qtest_vboot(QOSOps *ops, const char *cmdline_fmt, va_list ap)
>       qs->ops = ops;
>       if (ops) {
>           if (ops->init_allocator) {
> -            qs->alloc = ops->init_allocator(ALLOC_NO_FLAGS);
> +            qs->alloc = ops->init_allocator(qs->qts, ALLOC_NO_FLAGS);
>           }
>           if (ops->qpci_init) {
>               qs->pcibus = ops->qpci_init(qs->qts, qs->alloc);
> diff --git a/tests/libqos/malloc-pc.c b/tests/libqos/malloc-pc.c
> index dd2b900c5f..634b9c288a 100644
> --- a/tests/libqos/malloc-pc.c
> +++ b/tests/libqos/malloc-pc.c
> @@ -29,11 +29,11 @@ void pc_alloc_uninit(QGuestAllocator *allocator)
>       alloc_uninit(allocator);
>   }
> 
> -QGuestAllocator *pc_alloc_init_flags(QAllocOpts flags)
> +QGuestAllocator *pc_alloc_init_flags(QTestState *qts, QAllocOpts flags)
>   {
>       QGuestAllocator *s;
>       uint64_t ram_size;
> -    QFWCFG *fw_cfg = pc_fw_cfg_init();
> +    QFWCFG *fw_cfg = pc_fw_cfg_init(qts);
> 
>       ram_size = qfw_cfg_get_u64(fw_cfg, FW_CFG_RAM_SIZE);
>       s = alloc_init_flags(flags, 1 << 20, MIN(ram_size, 0xE0000000));
> @@ -45,7 +45,7 @@ QGuestAllocator *pc_alloc_init_flags(QAllocOpts flags)
>       return s;
>   }
> 
> -inline QGuestAllocator *pc_alloc_init(void)
> +inline QGuestAllocator *pc_alloc_init(QTestState *qts)
>   {
> -    return pc_alloc_init_flags(ALLOC_NO_FLAGS);
> +    return pc_alloc_init_flags(qts, ALLOC_NO_FLAGS);
>   }
> diff --git a/tests/libqos/malloc-spapr.c b/tests/libqos/malloc-spapr.c
> index 006404af33..1c359cea6c 100644
> --- a/tests/libqos/malloc-spapr.c
> +++ b/tests/libqos/malloc-spapr.c
> @@ -22,7 +22,7 @@ void spapr_alloc_uninit(QGuestAllocator *allocator)
>       alloc_uninit(allocator);
>   }
> 
> -QGuestAllocator *spapr_alloc_init_flags(QAllocOpts flags)
> +QGuestAllocator *spapr_alloc_init_flags(QTestState *qts, QAllocOpts flags)
>   {
>       QGuestAllocator *s;
> 
> @@ -34,5 +34,5 @@ QGuestAllocator *spapr_alloc_init_flags(QAllocOpts flags)
> 
>   QGuestAllocator *spapr_alloc_init(void)
>   {
> -    return spapr_alloc_init_flags(ALLOC_NO_FLAGS);
> +    return spapr_alloc_init_flags(NULL, ALLOC_NO_FLAGS);
>   }
> diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
> index ea7d38ea44..562bfaefd2 100644
> --- a/tests/vhost-user-test.c
> +++ b/tests/vhost-user-test.c
> @@ -894,7 +894,7 @@ static void test_multiqueue(void)
>       bus = qpci_init_pc(global_qtest, NULL);
>       dev = virtio_net_pci_init(bus, PCI_SLOT);
> 
> -    alloc = pc_alloc_init();
> +    alloc = pc_alloc_init(global_qtest);
>       for (i = 0; i < queues * 2; i++) {
>           vq[i] = (QVirtQueuePCI *)qvirtqueue_setup(&dev->vdev, alloc, i);
>       }
> 
