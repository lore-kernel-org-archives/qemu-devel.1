Received: from eggs.gnu.org ([2001:4830:134:3::10]:50689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d7h0T-0002xD-Nm
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:39:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d7h0P-0004Ut-8N
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:39:13 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3977)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1d7h0N-0004TQ-Vp
	for qemu-devel@nongnu.org; Mon, 08 May 2017 07:39:09 -0400
From: Gonglei <arei.gonglei@huawei.com>
Date: Mon, 8 May 2017 19:38:24 +0800
Message-ID: <1494243504-127980-10-git-send-email-arei.gonglei@huawei.com>
In-Reply-To: <1494243504-127980-1-git-send-email-arei.gonglei@huawei.com>
References: <1494243504-127980-1-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC v1 9/9] qtest: emulate virtio crypto as a legacy
 device for experiment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, weidong.huang@huawei.com, pasic@linux.vnet.ibm.com, stefanha@redhat.com, luonengjun@huawei.com, cornelia.huck@de.ibm.com, linqiangmin@huawei.com, xin.zeng@intel.com, wu.wubin@huawei.com, Gonglei <arei.gonglei@huawei.com>

Because the current qtest framework do not support virtio-1
or latter devices. For experimental purpose,
let's emulate the virtio crypto device as a legacy virtio
device by default. Using 0x1014 as virtio crypto pci device ID
because virtio crypto ID is 20 (0x14).

Signed-off-by: Gonglei <arei.gonglei@huawei.com>

virtio-crypto-test: add qtest case for virtio-crypto

We can simply test the functions of virtio crypto
device, including session creation, session closing,
cipher encryption and decryption.

Quick usage:
 # make tests/virtio-crypto-test && ./tests/virtio-crypto-test
  CC    tests/virtio-crypto-test.o
  LINK  tests/virtio-crypto-test
/virtio/crypto/cbc(aes-128-session-mode): OK
/virtio/crypto/cbc(aes-128-stateless-mode): OK

Signed-off-by: Gonglei <arei.gonglei@huawei.com>
---
 docs/specs/pci-ids.txt        |   2 +
 hw/virtio/virtio-crypto-pci.c |   4 +-
 include/hw/pci/pci.h          |   2 +
 tests/Makefile.include        |   3 +
 tests/virtio-crypto-test.c    | 596 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 606 insertions(+), 1 deletion(-)
 create mode 100644 tests/virtio-crypto-test.c

diff --git a/docs/specs/pci-ids.txt b/docs/specs/pci-ids.txt
index 95adee0..fe1581d 100644
--- a/docs/specs/pci-ids.txt
+++ b/docs/specs/pci-ids.txt
@@ -22,6 +22,7 @@ maintained as part of the virtio specification.
 1af4:1004  SCSI host bus adapter device (legacy)
 1af4:1005  entropy generator device (legacy)
 1af4:1009  9p filesystem device (legacy)
+1af4:1014  crypto device (legacy)
 
 1af4:1041  network device (modern)
 1af4:1042  block device (modern)
@@ -32,6 +33,7 @@ maintained as part of the virtio specification.
 1af4:1049  9p filesystem device (modern)
 1af4:1050  virtio gpu device (modern)
 1af4:1052  virtio input device (modern)
+1af4:1054  crypto device (modern)
 
 1af4:10f0  Available for experimental usage without registration.  Must get
    to      official ID when the code leaves the test lab (i.e. when seeking
diff --git a/hw/virtio/virtio-crypto-pci.c b/hw/virtio/virtio-crypto-pci.c
index 422aca3..06b5917 100644
--- a/hw/virtio/virtio-crypto-pci.c
+++ b/hw/virtio/virtio-crypto-pci.c
@@ -37,7 +37,6 @@ static void virtio_crypto_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     }
 
     qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
-    virtio_pci_force_virtio_1(vpci_dev);
     object_property_set_bool(OBJECT(vdev), true, "realized", errp);
     object_property_set_link(OBJECT(vcrypto),
                  OBJECT(vcrypto->vdev.conf.cryptodev), "cryptodev",
@@ -53,6 +52,9 @@ static void virtio_crypto_pci_class_init(ObjectClass *klass, void *data)
     k->realize = virtio_crypto_pci_realize;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     dc->props = virtio_crypto_pci_properties;
+    pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
+    pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_CRYPTO;
+    pcidev_k->revision = 0;
     pcidev_k->class_id = PCI_CLASS_OTHERS;
 }
 
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index a37a2d5..9f06db6 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -83,6 +83,8 @@
 #define PCI_DEVICE_ID_VIRTIO_RNG         0x1005
 #define PCI_DEVICE_ID_VIRTIO_9P          0x1009
 #define PCI_DEVICE_ID_VIRTIO_VSOCK       0x1012
+#define PCI_DEVICE_ID_VIRTIO_CRYPTO      0x1014
+
 
 #define PCI_VENDOR_ID_REDHAT             0x1b36
 #define PCI_DEVICE_ID_REDHAT_BRIDGE      0x0001
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 31931c0..e3af4b9 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -168,6 +168,8 @@ check-qtest-virtio-y += tests/virtio-serial-test$(EXESUF)
 gcov-files-virtio-y += i386-softmmu/hw/char/virtio-serial-bus.c
 check-qtest-virtio-y += $(check-qtest-virtioserial-y)
 gcov-files-virtio-y += $(gcov-files-virtioserial-y)
+check-qtest-virtio-y += tests/virtio-crypto-test$(EXESUF)
+gcov-files-virtio-y += i386-softmmu/hw/virtio/virtio-crypto.c
 
 check-qtest-pci-y += tests/e1000-test$(EXESUF)
 gcov-files-pci-y += hw/net/e1000.c
@@ -717,6 +719,7 @@ tests/virtio-scsi-test$(EXESUF): tests/virtio-scsi-test.o $(libqos-virtio-obj-y)
 tests/virtio-9p-test$(EXESUF): tests/virtio-9p-test.o $(libqos-virtio-obj-y)
 tests/virtio-serial-test$(EXESUF): tests/virtio-serial-test.o
 tests/virtio-console-test$(EXESUF): tests/virtio-console-test.o
+tests/virtio-crypto-test$(EXESUF): tests/virtio-crypto-test.o $(libqos-virtio-obj-y)
 tests/tpci200-test$(EXESUF): tests/tpci200-test.o
 tests/display-vga-test$(EXESUF): tests/display-vga-test.o
 tests/ipoctal232-test$(EXESUF): tests/ipoctal232-test.o
diff --git a/tests/virtio-crypto-test.c b/tests/virtio-crypto-test.c
new file mode 100644
index 0000000..630eb9d
--- /dev/null
+++ b/tests/virtio-crypto-test.c
@@ -0,0 +1,596 @@
+/*
+ * QTest testcase for VirtIO Crypto Device
+ *
+ * Copyright (c) 2016 HUAWEI TECHNOLOGIES CO., LTD.
+ *
+ * Authors:
+ *    Gonglei <arei.gonglei@huawei.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include <stdlib.h>
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "libqos/virtio.h"
+#include "libqos/virtio-pci.h"
+#include "libqos/virtio-mmio.h"
+#include "libqos/pci-pc.h"
+#include "libqos/malloc.h"
+#include "libqos/malloc-pc.h"
+#include "libqos/malloc-generic.h"
+#include "qemu/bswap.h"
+#include "standard-headers/linux/virtio_ids.h"
+#include "standard-headers/linux/virtio_config.h"
+#include "standard-headers/linux/virtio_ring.h"
+#include "standard-headers/linux/virtio_crypto.h"
+#include "standard-headers/linux/virtio_pci.h"
+
+#define QVIRTIO_CRYPTO_TIMEOUT_US  (30 * 1000 * 1000)
+
+#define PCI_SLOT_HP             0x06
+#define PCI_SLOT                0x04
+#define PCI_FN                  0x00
+
+/*
+ * VirtIOCryptoCipherTestData:  structure to describe a cipher test
+ * @key:    A pointer to a key used by the test
+ * @key_len:    The length of @key
+ * @iv:     A pointer to the IV/Counter used by the test
+ * @iv_len: The length of @iv
+ * @input:  A pointer to data used as input
+ * @ilen    The length of data in @input
+ * @output: A pointer to what the test need to produce
+ * @olen:   The length of data in @output
+ * @algo:   The type of algorithm, refer to VIRTIO_CRYPTO_CIPHER_AES_*
+ */
+typedef struct VirtIOCryptoCipherTestData {
+    const char *path;
+    unsigned short algo;
+    const char *key;
+    const char *iv;
+    const char *input;
+    const char *output;
+    unsigned char key_len;
+    unsigned char iv_len;
+    unsigned short ilen;
+    unsigned short olen;
+    bool is_statelss_mode;
+} VirtIOCryptoCipherTestData;
+
+
+static VirtIOCryptoCipherTestData cipher_test_data[] = {
+    { /* From RFC 3602 */
+        .path = "/virtio/crypto/cbc(aes-128-session-mode)",
+        .algo = VIRTIO_CRYPTO_CIPHER_AES_CBC,
+        .key  = "\x06\xa9\x21\x40\x36\xb8\xa1\x5b"
+                "\x51\x2e\x03\xd5\x34\x12\x00\x06",
+        .key_len   = 16,
+        .iv = "\x3d\xaf\xba\x42\x9d\x9e\xb4\x30"
+              "\xb4\x22\xda\x80\x2c\x9f\xac\x41",
+        .iv_len = 16,
+        .input  = "Single block msg",
+        .ilen   = 16,
+        .output = "\xe3\x53\x77\x9c\x10\x79\xae\xb8"
+                  "\x27\x08\x94\x2d\xbe\x77\x18\x1a",
+        .olen   = 16,
+        .is_statelss_mode = false,
+    },
+    { /* From RFC 3602 */
+        .path = "/virtio/crypto/cbc(aes-128-stateless-mode)",
+        .algo = VIRTIO_CRYPTO_CIPHER_AES_CBC,
+        .key  = "\x06\xa9\x21\x40\x36\xb8\xa1\x5b"
+                "\x51\x2e\x03\xd5\x34\x12\x00\x06",
+        .key_len   = 16,
+        .iv = "\x3d\xaf\xba\x42\x9d\x9e\xb4\x30"
+              "\xb4\x22\xda\x80\x2c\x9f\xac\x41",
+        .iv_len = 16,
+        .input  = "Single block msg",
+        .ilen   = 16,
+        .output = "\xe3\x53\x77\x9c\x10\x79\xae\xb8"
+                  "\x27\x08\x94\x2d\xbe\x77\x18\x1a",
+        .olen   = 16,
+        .is_statelss_mode = true,
+    },
+};
+
+static QPCIBus *virtio_crypto_test_start(void)
+{
+    char *cmdline;
+
+    cmdline = g_strdup_printf(
+               "-object cryptodev-backend-builtin,id=cryptodev0 "
+               "-device virtio-crypto-pci,id=crypto0,"
+               "cryptodev=cryptodev0");
+
+    qtest_start(cmdline);
+    g_free(cmdline);
+
+    return qpci_init_pc(NULL);
+}
+
+static void test_end(void)
+{
+    qtest_end();
+}
+
+static QVirtioPCIDevice *virtio_crypto_pci_init(QPCIBus *bus, int slot)
+{
+    QVirtioPCIDevice *dev;
+
+    dev = qvirtio_pci_device_find(bus, VIRTIO_ID_CRYPTO);
+    g_assert(dev != NULL);
+    g_assert_cmphex(dev->vdev.device_type, ==, VIRTIO_ID_CRYPTO);
+
+    qvirtio_pci_device_enable(dev);
+    qvirtio_reset(&dev->vdev);
+    qvirtio_set_acknowledge(&dev->vdev);
+    qvirtio_set_driver(&dev->vdev);
+
+    return dev;
+}
+
+static uint64_t
+virtio_crypto_ctrl_request(QGuestAllocator *alloc,
+                           struct virtio_crypto_op_ctrl_req *req)
+{
+    uint64_t addr;
+
+    addr = guest_alloc(alloc, sizeof(*req));
+
+    memwrite(addr, req, sizeof(*req));
+
+    return addr;
+}
+
+static uint64_t
+virtio_crypto_data_request(QGuestAllocator *alloc,
+                           struct virtio_crypto_op_data_req *req)
+{
+    uint64_t addr;
+
+    addr = guest_alloc(alloc, sizeof(*req));
+
+    memwrite(addr, req, sizeof(*req));
+
+    return addr;
+}
+
+static void
+virtio_crypto_driver_init(QVirtioDevice *dev)
+{
+    /* Read configure space to get  supported crypto services */
+
+    qvirtio_set_driver_ok(dev);
+}
+
+static uint64_t
+virtio_crypto_create_session(QVirtioDevice *dev,
+            QGuestAllocator *alloc, QVirtQueue *vq,
+            VirtIOCryptoCipherTestData *data,
+            int encrypt)
+{
+    uint32_t free_head;
+    struct virtio_crypto_op_ctrl_req ctrl;
+    struct virtio_crypto_session_input input;
+    uint32_t key_len = data->key_len;
+    uint64_t req_addr;
+    uint64_t key_addr, input_addr; /* cipher key guest physical address */
+    uint64_t session_id;
+    QVRingIndirectDesc *indirect;
+
+    /* Create an encryption session */
+    ctrl.header.opcode = VIRTIO_CRYPTO_CIPHER_CREATE_SESSION;
+    ctrl.header.algo = data->algo;
+    /* Set the default dataqueue id to 0 */
+    ctrl.header.queue_id = 0;
+
+    /* Pad cipher's parameters */
+    ctrl.u.sym_create_session.op_type = VIRTIO_CRYPTO_SYM_OP_CIPHER;
+    ctrl.u.sym_create_session.u.cipher.para.algo = ctrl.header.algo;
+    ctrl.u.sym_create_session.u.cipher.para.keylen = key_len;
+    if (encrypt) {
+        ctrl.u.sym_create_session.u.cipher.para.op = VIRTIO_CRYPTO_OP_ENCRYPT;
+    } else {
+        ctrl.u.sym_create_session.u.cipher.para.op = VIRTIO_CRYPTO_OP_DECRYPT;
+    }
+
+    req_addr = virtio_crypto_ctrl_request(alloc, &ctrl);
+
+    /* Pad cipher's output data */
+    key_addr = guest_alloc(alloc, key_len);
+    memwrite(key_addr, data->key, key_len);
+
+    input.status = VIRTIO_CRYPTO_ERR;
+    input_addr = guest_alloc(alloc, sizeof(input));
+    memwrite(input_addr, &input, sizeof(input));
+
+    indirect = qvring_indirect_desc_setup(dev, alloc, 3);
+    qvring_indirect_desc_add(indirect, req_addr, sizeof(ctrl), false);
+    qvring_indirect_desc_add(indirect, key_addr, key_len, false);
+    qvring_indirect_desc_add(indirect, input_addr, sizeof(input), true);
+    free_head = qvirtqueue_add_indirect(vq, indirect);
+
+    qvirtqueue_kick(dev, vq, free_head);
+
+    qvirtio_wait_queue_isr(dev, vq, QVIRTIO_CRYPTO_TIMEOUT_US);
+
+    /* calculate the offset of input data */
+
+    memread(input_addr, &input, sizeof(input));
+
+    /* Verify the result */
+    g_assert_cmpint(input.status, ==, VIRTIO_CRYPTO_OK);
+
+    session_id = input.session_id;
+
+    g_free(indirect);
+    guest_free(alloc, input_addr);
+    guest_free(alloc, key_addr);
+    guest_free(alloc, req_addr);
+
+    return session_id;
+}
+
+static void
+virtio_crypto_close_session(QVirtioDevice *dev,
+            QGuestAllocator *alloc, QVirtQueue *vq,
+            uint64_t session_id)
+{
+    uint32_t free_head;
+    struct virtio_crypto_op_ctrl_req ctrl;
+    uint64_t req_addr, status_addr;
+    uint8_t status;
+    QVRingIndirectDesc *indirect;
+
+    /* Create an encryption session */
+    ctrl.header.opcode = VIRTIO_CRYPTO_CIPHER_DESTROY_SESSION;
+    /* Set the default dataqueue id to 0 */
+    ctrl.header.queue_id = 0;
+
+    ctrl.u.destroy_session.session_id = session_id;
+
+    req_addr = virtio_crypto_ctrl_request(alloc, &ctrl);
+
+    status_addr = guest_alloc(alloc, sizeof(status));
+    writel(status_addr, VIRTIO_CRYPTO_ERR);
+
+    indirect = qvring_indirect_desc_setup(dev, alloc, 2);
+    qvring_indirect_desc_add(indirect, req_addr, sizeof(ctrl), false);
+    qvring_indirect_desc_add(indirect, status_addr, sizeof(status), true);
+    free_head = qvirtqueue_add_indirect(vq, indirect);
+
+    qvirtqueue_kick(dev, vq, free_head);
+
+    qvirtio_wait_queue_isr(dev, vq, QVIRTIO_CRYPTO_TIMEOUT_US);
+
+    /* Verify the result */
+    status = readl(status_addr);
+    g_assert_cmpint(status, ==, VIRTIO_CRYPTO_OK);
+
+    g_free(indirect);
+    guest_free(alloc, req_addr);
+    guest_free(alloc, status_addr);
+}
+
+
+static void
+virtio_crypto_test_cipher_session_mode(QVirtioDevice *dev,
+            QGuestAllocator *alloc, QVirtQueue *ctrlq,
+            QVirtQueue *vq, VirtIOCryptoCipherTestData *data,
+            int encrypt)
+{
+    uint32_t free_head;
+    struct virtio_crypto_op_data_req req;
+    uint64_t req_addr, status_addr;
+    uint64_t iv_addr = 0, src_addr, dst_addr;
+    uint64_t session_id;
+    char *output;
+    uint32_t src_len, dst_len;
+    uint8_t status;
+    QVRingIndirectDesc *indirect;
+    uint8_t entry_num;
+
+    /* Create a session */
+    session_id = virtio_crypto_create_session(dev, alloc,
+                                             ctrlq, data, encrypt);
+
+    /* Head of operation */
+    req.header.session_id = session_id;
+    if (encrypt) {
+        req.header.opcode = VIRTIO_CRYPTO_CIPHER_ENCRYPT;
+    } else {
+        req.header.opcode = VIRTIO_CRYPTO_CIPHER_DECRYPT;
+    }
+
+    req.u.sym_req.op_type = VIRTIO_CRYPTO_SYM_OP_CIPHER;
+    req.u.sym_req.u.cipher.para.iv_len = data->iv_len;
+    req.u.sym_req.u.cipher.para.src_data_len = data->ilen;
+    req.u.sym_req.u.cipher.para.dst_data_len = data->olen;
+
+    req_addr = virtio_crypto_data_request(alloc, &req);
+
+    /* IV */
+    if (data->iv_len > 0) {
+        iv_addr = guest_alloc(alloc, data->iv_len);
+        memwrite(iv_addr, data->iv, data->iv_len);
+
+        /* header + iv + src + dst + status */
+        entry_num = 5;
+    } else {
+        /* header + src + dst + status */
+        entry_num = 4;
+    }
+
+    if (encrypt) {
+        src_len = data->ilen;
+        dst_len = data->olen;
+        /* Source data is the input data which is a single buffer */
+        src_addr = guest_alloc(alloc, src_len);
+        memwrite(src_addr, data->input, src_len);
+    } else {
+        src_len = data->olen;
+        dst_len = data->ilen;
+        /* Source data is the output data which is a single buffer */
+        src_addr = guest_alloc(alloc, src_len);
+        memwrite(src_addr, data->output, src_len);
+    }
+
+    dst_addr = guest_alloc(alloc, dst_len);
+
+    status_addr = guest_alloc(alloc, sizeof(status));
+    writel(status_addr, VIRTIO_CRYPTO_ERR);
+
+    /* Allocate descripto table entries */
+    indirect = qvring_indirect_desc_setup(dev, alloc, entry_num);
+    qvring_indirect_desc_add(indirect, req_addr, sizeof(req), false);
+    if (data->iv_len > 0) {
+        qvring_indirect_desc_add(indirect, iv_addr, data->iv_len, false);
+    }
+    qvring_indirect_desc_add(indirect, src_addr, src_len, false);
+    qvring_indirect_desc_add(indirect, dst_addr, dst_len, true);
+    qvring_indirect_desc_add(indirect, status_addr, sizeof(status), true);
+    free_head = qvirtqueue_add_indirect(vq, indirect);
+
+    qvirtqueue_kick(dev, vq, free_head);
+
+    qvirtio_wait_queue_isr(dev, vq, QVIRTIO_CRYPTO_TIMEOUT_US);
+
+    /* Verify the result */
+    status = readl(status_addr);
+    g_assert_cmpint(status, ==, VIRTIO_CRYPTO_OK);
+
+    output = g_malloc0(dst_len);
+    memread(dst_addr, output, dst_len);
+    if (encrypt) {
+        g_assert_cmpstr(output, ==, data->output);
+    } else {
+        g_assert_cmpstr(output, ==, data->input);
+    }
+    g_free(output);
+
+    g_free(indirect);
+
+    if (data->iv_len > 0) {
+        guest_free(alloc, iv_addr);
+    }
+    guest_free(alloc, src_addr);
+    guest_free(alloc, dst_addr);
+    guest_free(alloc, req_addr);
+    guest_free(alloc, status_addr);
+
+    /* Close the session */
+    virtio_crypto_close_session(dev, alloc, ctrlq, session_id);
+}
+
+static void
+virtio_crypto_test_cipher_stateless_mode(QVirtioDevice *dev,
+            QGuestAllocator *alloc,
+            QVirtQueue *vq, VirtIOCryptoCipherTestData *data,
+            int encrypt)
+{
+    uint32_t free_head;
+    struct virtio_crypto_op_data_req_mux req;
+    uint64_t req_addr, status_addr;
+    uint64_t iv_addr = 0, src_addr, dst_addr, key_addr;
+    char *output;
+    uint32_t src_len, dst_len;
+    uint8_t status;
+    QVRingIndirectDesc *indirect;
+    uint8_t entry_num;
+
+    /* Head of operation */
+    req.header.flag = VIRTIO_CRYPTO_FLAG_STATELESS_MODE;
+    if (encrypt) {
+        req.header.opcode = VIRTIO_CRYPTO_CIPHER_ENCRYPT;
+        req.u.sym_stateless_req.u.cipher.para.sess_para.op =
+            VIRTIO_CRYPTO_OP_ENCRYPT;
+    } else {
+        req.header.opcode = VIRTIO_CRYPTO_CIPHER_DECRYPT;
+        req.u.sym_stateless_req.u.cipher.para.sess_para.op =
+            VIRTIO_CRYPTO_OP_DECRYPT;
+    }
+
+    req.u.sym_stateless_req.op_type = VIRTIO_CRYPTO_SYM_OP_CIPHER;
+    req.u.sym_stateless_req.u.cipher.para.sess_para.algo = data->algo;
+    req.u.sym_stateless_req.u.cipher.para.sess_para.keylen = data->key_len;
+    req.u.sym_stateless_req.u.cipher.para.iv_len = data->iv_len;
+    req.u.sym_stateless_req.u.cipher.para.src_data_len = data->ilen;
+    req.u.sym_stateless_req.u.cipher.para.dst_data_len = data->olen;
+
+    req_addr = guest_alloc(alloc, sizeof(req));
+    memwrite(req_addr, &req, sizeof(req));
+
+    g_assert(data->key_len > 0);
+    key_addr = guest_alloc(alloc, data->key_len);
+    memwrite(key_addr, data->key, data->key_len);
+
+    /* IV */
+    if (data->iv_len > 0) {
+        iv_addr = guest_alloc(alloc, data->iv_len);
+        memwrite(iv_addr, data->iv, data->iv_len);
+
+        /* header + key + iv + src + dst + status */
+        entry_num = 6;
+    } else {
+        /* header + key + src + dst + status */
+        entry_num = 5;
+    }
+
+    if (encrypt) {
+        src_len = data->ilen;
+        dst_len = data->olen;
+        /* Source data is the input data which is a single buffer */
+        src_addr = guest_alloc(alloc, src_len);
+        memwrite(src_addr, data->input, src_len);
+    } else {
+        src_len = data->olen;
+        dst_len = data->ilen;
+        /* Source data is the output data which is a single buffer */
+        src_addr = guest_alloc(alloc, src_len);
+        memwrite(src_addr, data->output, src_len);
+    }
+
+    dst_addr = guest_alloc(alloc, dst_len);
+
+    status_addr = guest_alloc(alloc, sizeof(status));
+    writel(status_addr, VIRTIO_CRYPTO_ERR);
+
+    /* Allocate desc table entries */
+    indirect = qvring_indirect_desc_setup(dev, alloc, entry_num);
+    qvring_indirect_desc_add(indirect, req_addr, sizeof(req), false);
+    qvring_indirect_desc_add(indirect, key_addr, data->key_len, false);
+    if (data->iv_len > 0) {
+        qvring_indirect_desc_add(indirect, iv_addr, data->iv_len, false);
+    }
+    qvring_indirect_desc_add(indirect, src_addr, src_len, false);
+    qvring_indirect_desc_add(indirect, dst_addr, dst_len, true);
+    qvring_indirect_desc_add(indirect, status_addr, sizeof(status), true);
+    free_head = qvirtqueue_add_indirect(vq, indirect);
+
+    qvirtqueue_kick(dev, vq, free_head);
+
+    qvirtio_wait_queue_isr(dev, vq, QVIRTIO_CRYPTO_TIMEOUT_US);
+
+    /* Verify the result */
+    status = readl(status_addr);
+    g_assert_cmpint(status, ==, VIRTIO_CRYPTO_OK);
+
+    output = g_malloc0(dst_len);
+    memread(dst_addr, output, dst_len);
+    if (encrypt) {
+        g_assert_cmpstr(output, ==, data->output);
+    } else {
+        g_assert_cmpstr(output, ==, data->input);
+    }
+    g_free(output);
+
+    g_free(indirect);
+    guest_free(alloc, key_addr);
+    if (data->iv_len > 0) {
+        guest_free(alloc, iv_addr);
+    }
+    guest_free(alloc, src_addr);
+    guest_free(alloc, dst_addr);
+    guest_free(alloc, req_addr);
+    guest_free(alloc, status_addr);
+}
+
+static void
+virtio_crypto_test_cipher(QVirtioDevice *dev,
+            QGuestAllocator *alloc, QVirtQueue *ctrlq,
+            QVirtQueue *dataq, VirtIOCryptoCipherTestData *data,
+            int encrypt)
+{
+    if (!data->is_statelss_mode) {
+        virtio_crypto_test_cipher_session_mode(dev, alloc,
+            ctrlq, dataq, data, encrypt);
+    } else {
+        virtio_crypto_test_cipher_stateless_mode(dev, alloc,
+            dataq, data, encrypt);
+    }
+}
+
+static void virtio_crypto_pci_basic(void *opaque)
+{
+    VirtIOCryptoCipherTestData *test_data = opaque;
+    QVirtioPCIDevice *dev;
+    QPCIBus *bus;
+    QGuestAllocator *alloc;
+    QVirtQueuePCI *dataq, *controlq;
+    uint32_t features;
+
+    bus = virtio_crypto_test_start();
+    dev = virtio_crypto_pci_init(bus, PCI_SLOT);
+
+    alloc = pc_alloc_init();
+
+    features = qvirtio_get_features(&dev->vdev);
+    g_assert_cmphex(features & (1u << VIRTIO_RING_F_INDIRECT_DESC), !=, 0);
+
+    if (!test_data->is_statelss_mode) {
+        features = features & ~(QVIRTIO_F_BAD_FEATURE |
+                                (1u << VIRTIO_RING_F_EVENT_IDX |
+                                1u << VIRTIO_CRYPTO_F_MUX_MODE |
+                                1u << VIRTIO_CRYPTO_F_CIPHER_STATELESS_MODE));
+    } else {
+        features = features & ~(QVIRTIO_F_BAD_FEATURE |
+                                (1u << VIRTIO_RING_F_EVENT_IDX));
+    }
+    qvirtio_set_features(&dev->vdev, features);
+
+    dataq = (QVirtQueuePCI *)qvirtqueue_setup(&dev->vdev,
+                                           alloc, 0);
+    controlq = (QVirtQueuePCI *)qvirtqueue_setup(&dev->vdev,
+                                           alloc, 1);
+
+    virtio_crypto_driver_init(&dev->vdev);
+
+    /* Step 1: Encryption */
+    virtio_crypto_test_cipher(&dev->vdev, alloc,
+                              &controlq->vq, &dataq->vq,
+                              test_data, 1);
+    /* Step 2: Decryption */
+    virtio_crypto_test_cipher(&dev->vdev, alloc,
+                              &controlq->vq, &dataq->vq,
+                              test_data, 0);
+
+    /* End test */
+    guest_free(alloc, dataq->vq.desc);
+    guest_free(alloc, controlq->vq.desc);
+    pc_alloc_uninit(alloc);
+    qvirtio_pci_device_disable(dev);
+    g_free(dev);
+    qpci_free_pc(bus);
+    test_end();
+}
+
+int main(int argc, char **argv)
+{
+    const char *qemu;
+    const char *arch;
+    int i, ret;
+
+    qemu = getenv("QTEST_QEMU_BINARY");
+    if (qemu == NULL) {
+        ret = setenv("QTEST_QEMU_BINARY",
+                     "x86_64-softmmu/qemu-system-x86_64", 0);
+        g_assert(ret == 0);
+    }
+
+    arch = qtest_get_arch();
+
+    g_test_init(&argc, &argv, NULL);
+
+    if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
+        for (i = 0; i < G_N_ELEMENTS(cipher_test_data); i++) {
+            g_test_add_data_func(cipher_test_data[i].path,
+                                 (void *)&cipher_test_data[i],
+                                 (GTestDataFunc)virtio_crypto_pci_basic);
+        }
+    }
+
+    return g_test_run();
+}
-- 
1.8.3.1
