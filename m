Received: from eggs.gnu.org ([2001:4830:134:3::10]:38870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=thZ3=X7=redhat.com=mst@kernel.org>)
	id 1cHzsI-0003V0-2D
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 16:17:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=thZ3=X7=redhat.com=mst@kernel.org>)
	id 1cHzsC-0006u2-8A
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 16:17:06 -0500
Received: from mail.kernel.org ([198.145.29.136]:48866)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=thZ3=X7=redhat.com=mst@kernel.org>)
	id 1cHzsB-0006s8-M6
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 16:17:00 -0500
Date: Fri, 16 Dec 2016 23:16:49 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1481922841-4324-6-git-send-email-mst@redhat.com>
References: <1481922841-4324-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1481922841-4324-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for-2.9 5/9] contrib: add libvhost-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Felipe Franciosi <felipe@nutanix.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

From: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

Add a library to help implementing vhost-user backend (or slave).

Dealing with vhost-user as an application developer isn't so easy: you
have all the trouble with any protocol: validation, unix ancillary data,
shared memory, eventfd, logging, and on top of that you need to deal
with virtio queues, if possible efficiently.

qemu test has a nice vhost-user testing application vhost-user-bridge,
which implements most of vhost-user, and virtio.c which implements
virtqueues manipulation. Based on these two, I tried to make a simple
library, reusable for tests or development of new vhost-user scenarios.

Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
[Felipe: set used_idx copy on SET_VRING_ADDR and update shadow avail idx
 on SET_VRING_BASE]
Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 Makefile                              |    1 +
 contrib/libvhost-user/libvhost-user.h |  435 ++++++++++
 contrib/libvhost-user/libvhost-user.c | 1499 +++++++++++++++++++++++++++=
++++++
 Makefile.objs                         |    2 +-
 contrib/libvhost-user/Makefile.objs   |    1 +
 5 files changed, 1937 insertions(+), 1 deletion(-)
 create mode 100644 contrib/libvhost-user/libvhost-user.h
 create mode 100644 contrib/libvhost-user/libvhost-user.c
 create mode 100644 contrib/libvhost-user/Makefile.objs

diff --git a/Makefile b/Makefile
index 474cc5e..68accb9 100644
--- a/Makefile
+++ b/Makefile
@@ -149,6 +149,7 @@ dummy :=3D $(call unnest-vars,, \
                 qga-obj-y \
                 ivshmem-client-obj-y \
                 ivshmem-server-obj-y \
+                libvhost-user-obj-y \
                 qga-vss-dll-obj-y \
                 block-obj-y \
                 block-obj-m \
diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-use=
r/libvhost-user.h
new file mode 100644
index 0000000..156b50e
--- /dev/null
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -0,0 +1,435 @@
+/*
+ * Vhost User library
+ *
+ * Copyright (c) 2016 Red Hat, Inc.
+ *
+ * Authors:
+ *  Victor Kaplansky <victork@redhat.com>
+ *  Marc-Andr=E9 Lureau <mlureau@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * later.  See the COPYING file in the top-level directory.
+ */
+
+#ifndef LIBVHOST_USER_H
+#define LIBVHOST_USER_H
+
+#include <stdint.h>
+#include <stdbool.h>
+#include <stddef.h>
+#include <linux/vhost.h>
+#include "standard-headers/linux/virtio_ring.h"
+
+/* Based on qemu/hw/virtio/vhost-user.c */
+#define VHOST_USER_F_PROTOCOL_FEATURES 30
+#define VHOST_LOG_PAGE 4096
+
+#define VHOST_MAX_NR_VIRTQUEUE 8
+#define VIRTQUEUE_MAX_SIZE 1024
+
+#define VHOST_MEMORY_MAX_NREGIONS 8
+
+enum VhostUserProtocolFeature {
+    VHOST_USER_PROTOCOL_F_MQ =3D 0,
+    VHOST_USER_PROTOCOL_F_LOG_SHMFD =3D 1,
+    VHOST_USER_PROTOCOL_F_RARP =3D 2,
+
+    VHOST_USER_PROTOCOL_F_MAX
+};
+
+#define VHOST_USER_PROTOCOL_FEATURE_MASK ((1 << VHOST_USER_PROTOCOL_F_MA=
X) - 1)
+
+typedef enum VhostUserRequest {
+    VHOST_USER_NONE =3D 0,
+    VHOST_USER_GET_FEATURES =3D 1,
+    VHOST_USER_SET_FEATURES =3D 2,
+    VHOST_USER_SET_OWNER =3D 3,
+    VHOST_USER_RESET_OWNER =3D 4,
+    VHOST_USER_SET_MEM_TABLE =3D 5,
+    VHOST_USER_SET_LOG_BASE =3D 6,
+    VHOST_USER_SET_LOG_FD =3D 7,
+    VHOST_USER_SET_VRING_NUM =3D 8,
+    VHOST_USER_SET_VRING_ADDR =3D 9,
+    VHOST_USER_SET_VRING_BASE =3D 10,
+    VHOST_USER_GET_VRING_BASE =3D 11,
+    VHOST_USER_SET_VRING_KICK =3D 12,
+    VHOST_USER_SET_VRING_CALL =3D 13,
+    VHOST_USER_SET_VRING_ERR =3D 14,
+    VHOST_USER_GET_PROTOCOL_FEATURES =3D 15,
+    VHOST_USER_SET_PROTOCOL_FEATURES =3D 16,
+    VHOST_USER_GET_QUEUE_NUM =3D 17,
+    VHOST_USER_SET_VRING_ENABLE =3D 18,
+    VHOST_USER_SEND_RARP =3D 19,
+    VHOST_USER_INPUT_GET_CONFIG =3D 20,
+    VHOST_USER_MAX
+} VhostUserRequest;
+
+typedef struct VhostUserMemoryRegion {
+    uint64_t guest_phys_addr;
+    uint64_t memory_size;
+    uint64_t userspace_addr;
+    uint64_t mmap_offset;
+} VhostUserMemoryRegion;
+
+typedef struct VhostUserMemory {
+    uint32_t nregions;
+    uint32_t padding;
+    VhostUserMemoryRegion regions[VHOST_MEMORY_MAX_NREGIONS];
+} VhostUserMemory;
+
+typedef struct VhostUserLog {
+    uint64_t mmap_size;
+    uint64_t mmap_offset;
+} VhostUserLog;
+
+#if defined(_WIN32)
+# define VU_PACKED __attribute__((gcc_struct, packed))
+#else
+# define VU_PACKED __attribute__((packed))
+#endif
+
+typedef struct VhostUserMsg {
+    VhostUserRequest request;
+
+#define VHOST_USER_VERSION_MASK     (0x3)
+#define VHOST_USER_REPLY_MASK       (0x1 << 2)
+    uint32_t flags;
+    uint32_t size; /* the following payload size */
+
+    union {
+#define VHOST_USER_VRING_IDX_MASK   (0xff)
+#define VHOST_USER_VRING_NOFD_MASK  (0x1 << 8)
+        uint64_t u64;
+        struct vhost_vring_state state;
+        struct vhost_vring_addr addr;
+        VhostUserMemory memory;
+        VhostUserLog log;
+    } payload;
+
+    int fds[VHOST_MEMORY_MAX_NREGIONS];
+    int fd_num;
+    uint8_t *data;
+} VU_PACKED VhostUserMsg;
+
+typedef struct VuDevRegion {
+    /* Guest Physical address. */
+    uint64_t gpa;
+    /* Memory region size. */
+    uint64_t size;
+    /* QEMU virtual address (userspace). */
+    uint64_t qva;
+    /* Starting offset in our mmaped space. */
+    uint64_t mmap_offset;
+    /* Start address of mmaped space. */
+    uint64_t mmap_addr;
+} VuDevRegion;
+
+typedef struct VuDev VuDev;
+
+typedef uint64_t (*vu_get_features_cb) (VuDev *dev);
+typedef void (*vu_set_features_cb) (VuDev *dev, uint64_t features);
+typedef int (*vu_process_msg_cb) (VuDev *dev, VhostUserMsg *vmsg,
+                                  int *do_reply);
+typedef void (*vu_queue_set_started_cb) (VuDev *dev, int qidx, bool star=
ted);
+
+typedef struct VuDevIface {
+    /* called by VHOST_USER_GET_FEATURES to get the features bitmask */
+    vu_get_features_cb get_features;
+    /* enable vhost implementation features */
+    vu_set_features_cb set_features;
+    /* get the protocol feature bitmask from the underlying vhost
+     * implementation */
+    vu_get_features_cb get_protocol_features;
+    /* enable protocol features in the underlying vhost implementation. =
*/
+    vu_set_features_cb set_protocol_features;
+    /* process_msg is called for each vhost-user message received */
+    /* skip libvhost-user processing if return value !=3D 0 */
+    vu_process_msg_cb process_msg;
+    /* tells when queues can be processed */
+    vu_queue_set_started_cb queue_set_started;
+} VuDevIface;
+
+typedef void (*vu_queue_handler_cb) (VuDev *dev, int qidx);
+
+typedef struct VuRing {
+    unsigned int num;
+    struct vring_desc *desc;
+    struct vring_avail *avail;
+    struct vring_used *used;
+    uint64_t log_guest_addr;
+    uint32_t flags;
+} VuRing;
+
+typedef struct VuVirtq {
+    VuRing vring;
+
+    /* Next head to pop */
+    uint16_t last_avail_idx;
+
+    /* Last avail_idx read from VQ. */
+    uint16_t shadow_avail_idx;
+
+    uint16_t used_idx;
+
+    /* Last used index value we have signalled on */
+    uint16_t signalled_used;
+
+    /* Last used index value we have signalled on */
+    bool signalled_used_valid;
+
+    /* Notification enabled? */
+    bool notification;
+
+    int inuse;
+
+    vu_queue_handler_cb handler;
+
+    int call_fd;
+    int kick_fd;
+    int err_fd;
+    unsigned int enable;
+    bool started;
+} VuVirtq;
+
+enum VuWatchCondtion {
+    VU_WATCH_IN =3D 1 << 0,
+    VU_WATCH_OUT =3D 1 << 1,
+    VU_WATCH_PRI =3D 1 << 2,
+    VU_WATCH_ERR =3D 1 << 3,
+    VU_WATCH_HUP =3D 1 << 4,
+};
+
+typedef void (*vu_panic_cb) (VuDev *dev, const char *err);
+typedef void (*vu_watch_cb) (VuDev *dev, int condition, void *data);
+typedef void (*vu_set_watch_cb) (VuDev *dev, int fd, int condition,
+                                 vu_watch_cb cb, void *data);
+typedef void (*vu_remove_watch_cb) (VuDev *dev, int fd);
+
+struct VuDev {
+    int sock;
+    uint32_t nregions;
+    VuDevRegion regions[VHOST_MEMORY_MAX_NREGIONS];
+    VuVirtq vq[VHOST_MAX_NR_VIRTQUEUE];
+    int log_call_fd;
+    uint64_t log_size;
+    uint8_t *log_table;
+    uint64_t features;
+    uint64_t protocol_features;
+    bool broken;
+
+    /* @set_watch: add or update the given fd to the watch set,
+     * call cb when condition is met */
+    vu_set_watch_cb set_watch;
+
+    /* @remove_watch: remove the given fd from the watch set */
+    vu_remove_watch_cb remove_watch;
+
+    /* @panic: encountered an unrecoverable error, you may try to
+     * re-initialize */
+    vu_panic_cb panic;
+    const VuDevIface *iface;
+};
+
+typedef struct VuVirtqElement {
+    unsigned int index;
+    unsigned int out_num;
+    unsigned int in_num;
+    struct iovec *in_sg;
+    struct iovec *out_sg;
+} VuVirtqElement;
+
+/**
+ * vu_init:
+ * @dev: a VuDev context
+ * @socket: the socket connected to vhost-user master
+ * @panic: a panic callback
+ * @set_watch: a set_watch callback
+ * @remove_watch: a remove_watch callback
+ * @iface: a VuDevIface structure with vhost-user device callbacks
+ *
+ * Intializes a VuDev vhost-user context.
+ **/
+void vu_init(VuDev *dev,
+             int socket,
+             vu_panic_cb panic,
+             vu_set_watch_cb set_watch,
+             vu_remove_watch_cb remove_watch,
+             const VuDevIface *iface);
+
+
+/**
+ * vu_deinit:
+ * @dev: a VuDev context
+ *
+ * Cleans up the VuDev context
+ */
+void vu_deinit(VuDev *dev);
+
+/**
+ * vu_dispatch:
+ * @dev: a VuDev context
+ *
+ * Process one vhost-user message.
+ *
+ * Returns: TRUE on success, FALSE on failure.
+ */
+bool vu_dispatch(VuDev *dev);
+
+/**
+ * vu_gpa_to_va:
+ * @dev: a VuDev context
+ * @guest_addr: guest address
+ *
+ * Translate a guest address to a pointer. Returns NULL on failure.
+ */
+void *vu_gpa_to_va(VuDev *dev, uint64_t guest_addr);
+
+/**
+ * vu_get_queue:
+ * @dev: a VuDev context
+ * @qidx: queue index
+ *
+ * Returns the queue number @qidx.
+ */
+VuVirtq *vu_get_queue(VuDev *dev, int qidx);
+
+/**
+ * vu_set_queue_handler:
+ * @dev: a VuDev context
+ * @vq: a VuVirtq queue
+ * @handler: the queue handler callback
+ *
+ * Set the queue handler. This function may be called several times
+ * for the same queue. If called with NULL @handler, the handler is
+ * removed.
+ */
+void vu_set_queue_handler(VuDev *dev, VuVirtq *vq,
+                          vu_queue_handler_cb handler);
+
+
+/**
+ * vu_queue_set_notification:
+ * @dev: a VuDev context
+ * @vq: a VuVirtq queue
+ * @enable: state
+ *
+ * Set whether the queue notifies (via event index or interrupt)
+ */
+void vu_queue_set_notification(VuDev *dev, VuVirtq *vq, int enable);
+
+/**
+ * vu_queue_enabled:
+ * @dev: a VuDev context
+ * @vq: a VuVirtq queue
+ *
+ * Returns: whether the queue is enabled.
+ */
+bool vu_queue_enabled(VuDev *dev, VuVirtq *vq);
+
+/**
+ * vu_queue_enabled:
+ * @dev: a VuDev context
+ * @vq: a VuVirtq queue
+ *
+ * Returns: whether the queue is empty.
+ */
+int vu_queue_empty(VuDev *dev, VuVirtq *vq);
+
+/**
+ * vu_queue_notify:
+ * @dev: a VuDev context
+ * @vq: a VuVirtq queue
+ *
+ * Request to notify the queue via callfd (skipped if unnecessary)
+ */
+void vu_queue_notify(VuDev *dev, VuVirtq *vq);
+
+/**
+ * vu_queue_pop:
+ * @dev: a VuDev context
+ * @vq: a VuVirtq queue
+ * @sz: the size of struct to return (must be >=3D VuVirtqElement)
+ *
+ * Returns: a VuVirtqElement filled from the queue or NULL.
+ */
+void *vu_queue_pop(VuDev *dev, VuVirtq *vq, size_t sz);
+
+/**
+ * vu_queue_rewind:
+ * @dev: a VuDev context
+ * @vq: a VuVirtq queue
+ * @num: number of elements to push back
+ *
+ * Pretend that elements weren't popped from the virtqueue.  The next
+ * virtqueue_pop() will refetch the oldest element.
+ *
+ * Returns: true on success, false if @num is greater than the number of=
 in use
+ * elements.
+ */
+bool vu_queue_rewind(VuDev *dev, VuVirtq *vq, unsigned int num);
+
+/**
+ * vu_queue_fill:
+ * @dev: a VuDev context
+ * @vq: a VuVirtq queue
+ * @elem: a VuVirtqElement
+ * @len: length in bytes to write
+ * @idx: optional offset for the used ring index (0 in general)
+ *
+ * Fill the used ring with @elem element.
+ */
+void vu_queue_fill(VuDev *dev, VuVirtq *vq,
+                   const VuVirtqElement *elem,
+                   unsigned int len, unsigned int idx);
+
+/**
+ * vu_queue_push:
+ * @dev: a VuDev context
+ * @vq: a VuVirtq queue
+ * @elem: a VuVirtqElement
+ * @len: length in bytes to write
+ *
+ * Helper that combines vu_queue_fill() with a vu_queue_flush().
+ */
+void vu_queue_push(VuDev *dev, VuVirtq *vq,
+                   const VuVirtqElement *elem, unsigned int len);
+
+/**
+ * vu_queue_flush:
+ * @dev: a VuDev context
+ * @vq: a VuVirtq queue
+ * @num: number of elements to flush
+ *
+ * Mark the last number of elements as done (used.idx is updated by
+ * num elements).
+*/
+void vu_queue_flush(VuDev *dev, VuVirtq *vq, unsigned int num);
+
+/**
+ * vu_queue_get_avail_bytes:
+ * @dev: a VuDev context
+ * @vq: a VuVirtq queue
+ * @in_bytes: in bytes
+ * @out_bytes: out bytes
+ * @max_in_bytes: stop counting after max_in_bytes
+ * @max_out_bytes: stop counting after max_out_bytes
+ *
+ * Count the number of available bytes, up to max_in_bytes/max_out_bytes=
.
+ */
+void vu_queue_get_avail_bytes(VuDev *vdev, VuVirtq *vq, unsigned int *in=
_bytes,
+                              unsigned int *out_bytes,
+                              unsigned max_in_bytes, unsigned max_out_by=
tes);
+
+/**
+ * vu_queue_avail_bytes:
+ * @dev: a VuDev context
+ * @vq: a VuVirtq queue
+ * @in_bytes: expected in bytes
+ * @out_bytes: expected out bytes
+ *
+ * Returns: true if in_bytes <=3D in_total && out_bytes <=3D out_total
+ */
+bool vu_queue_avail_bytes(VuDev *dev, VuVirtq *vq, unsigned int in_bytes=
,
+                          unsigned int out_bytes);
+
+#endif /* LIBVHOST_USER_H */
diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
new file mode 100644
index 0000000..af4faad
--- /dev/null
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -0,0 +1,1499 @@
+/*
+ * Vhost User library
+ *
+ * Copyright IBM, Corp. 2007
+ * Copyright (c) 2016 Red Hat, Inc.
+ *
+ * Authors:
+ *  Anthony Liguori <aliguori@us.ibm.com>
+ *  Marc-Andr=E9 Lureau <mlureau@redhat.com>
+ *  Victor Kaplansky <victork@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * later.  See the COPYING file in the top-level directory.
+ */
+
+#include <qemu/osdep.h>
+#include <sys/eventfd.h>
+#include <linux/vhost.h>
+
+#include "qemu/atomic.h"
+
+#include "libvhost-user.h"
+
+#define VHOST_USER_HDR_SIZE offsetof(VhostUserMsg, payload.u64)
+
+/* The version of the protocol we support */
+#define VHOST_USER_VERSION 1
+#define LIBVHOST_USER_DEBUG 0
+
+#define DPRINT(...)                             \
+    do {                                        \
+        if (LIBVHOST_USER_DEBUG) {              \
+            fprintf(stderr, __VA_ARGS__);        \
+        }                                       \
+    } while (0)
+
+static const char *
+vu_request_to_string(int req)
+{
+#define REQ(req) [req] =3D #req
+    static const char *vu_request_str[] =3D {
+        REQ(VHOST_USER_NONE),
+        REQ(VHOST_USER_GET_FEATURES),
+        REQ(VHOST_USER_SET_FEATURES),
+        REQ(VHOST_USER_NONE),
+        REQ(VHOST_USER_GET_FEATURES),
+        REQ(VHOST_USER_SET_FEATURES),
+        REQ(VHOST_USER_SET_OWNER),
+        REQ(VHOST_USER_RESET_OWNER),
+        REQ(VHOST_USER_SET_MEM_TABLE),
+        REQ(VHOST_USER_SET_LOG_BASE),
+        REQ(VHOST_USER_SET_LOG_FD),
+        REQ(VHOST_USER_SET_VRING_NUM),
+        REQ(VHOST_USER_SET_VRING_ADDR),
+        REQ(VHOST_USER_SET_VRING_BASE),
+        REQ(VHOST_USER_GET_VRING_BASE),
+        REQ(VHOST_USER_SET_VRING_KICK),
+        REQ(VHOST_USER_SET_VRING_CALL),
+        REQ(VHOST_USER_SET_VRING_ERR),
+        REQ(VHOST_USER_GET_PROTOCOL_FEATURES),
+        REQ(VHOST_USER_SET_PROTOCOL_FEATURES),
+        REQ(VHOST_USER_GET_QUEUE_NUM),
+        REQ(VHOST_USER_SET_VRING_ENABLE),
+        REQ(VHOST_USER_SEND_RARP),
+        REQ(VHOST_USER_INPUT_GET_CONFIG),
+        REQ(VHOST_USER_MAX),
+    };
+#undef REQ
+
+    if (req < VHOST_USER_MAX) {
+        return vu_request_str[req];
+    } else {
+        return "unknown";
+    }
+}
+
+static void
+vu_panic(VuDev *dev, const char *msg, ...)
+{
+    char *buf =3D NULL;
+    va_list ap;
+
+    va_start(ap, msg);
+    (void)vasprintf(&buf, msg, ap);
+    va_end(ap);
+
+    dev->broken =3D true;
+    dev->panic(dev, buf);
+    free(buf);
+
+    /* FIXME: find a way to call virtio_error? */
+}
+
+/* Translate guest physical address to our virtual address.  */
+void *
+vu_gpa_to_va(VuDev *dev, uint64_t guest_addr)
+{
+    int i;
+
+    /* Find matching memory region.  */
+    for (i =3D 0; i < dev->nregions; i++) {
+        VuDevRegion *r =3D &dev->regions[i];
+
+        if ((guest_addr >=3D r->gpa) && (guest_addr < (r->gpa + r->size)=
)) {
+            return (void *)(uintptr_t)
+                guest_addr - r->gpa + r->mmap_addr + r->mmap_offset;
+        }
+    }
+
+    return NULL;
+}
+
+/* Translate qemu virtual address to our virtual address.  */
+static void *
+qva_to_va(VuDev *dev, uint64_t qemu_addr)
+{
+    int i;
+
+    /* Find matching memory region.  */
+    for (i =3D 0; i < dev->nregions; i++) {
+        VuDevRegion *r =3D &dev->regions[i];
+
+        if ((qemu_addr >=3D r->qva) && (qemu_addr < (r->qva + r->size)))=
 {
+            return (void *)(uintptr_t)
+                qemu_addr - r->qva + r->mmap_addr + r->mmap_offset;
+        }
+    }
+
+    return NULL;
+}
+
+static void
+vmsg_close_fds(VhostUserMsg *vmsg)
+{
+    int i;
+
+    for (i =3D 0; i < vmsg->fd_num; i++) {
+        close(vmsg->fds[i]);
+    }
+}
+
+static bool
+vu_message_read(VuDev *dev, int conn_fd, VhostUserMsg *vmsg)
+{
+    char control[CMSG_SPACE(VHOST_MEMORY_MAX_NREGIONS * sizeof(int))] =3D=
 { };
+    struct iovec iov =3D {
+        .iov_base =3D (char *)vmsg,
+        .iov_len =3D VHOST_USER_HDR_SIZE,
+    };
+    struct msghdr msg =3D {
+        .msg_iov =3D &iov,
+        .msg_iovlen =3D 1,
+        .msg_control =3D control,
+        .msg_controllen =3D sizeof(control),
+    };
+    size_t fd_size;
+    struct cmsghdr *cmsg;
+    int rc;
+
+    do {
+        rc =3D recvmsg(conn_fd, &msg, 0);
+    } while (rc < 0 && (errno =3D=3D EINTR || errno =3D=3D EAGAIN));
+
+    if (rc <=3D 0) {
+        vu_panic(dev, "Error while recvmsg: %s", strerror(errno));
+        return false;
+    }
+
+    vmsg->fd_num =3D 0;
+    for (cmsg =3D CMSG_FIRSTHDR(&msg);
+         cmsg !=3D NULL;
+         cmsg =3D CMSG_NXTHDR(&msg, cmsg))
+    {
+        if (cmsg->cmsg_level =3D=3D SOL_SOCKET && cmsg->cmsg_type =3D=3D=
 SCM_RIGHTS) {
+            fd_size =3D cmsg->cmsg_len - CMSG_LEN(0);
+            vmsg->fd_num =3D fd_size / sizeof(int);
+            memcpy(vmsg->fds, CMSG_DATA(cmsg), fd_size);
+            break;
+        }
+    }
+
+    if (vmsg->size > sizeof(vmsg->payload)) {
+        vu_panic(dev,
+                 "Error: too big message request: %d, size: vmsg->size: =
%u, "
+                 "while sizeof(vmsg->payload) =3D %zu\n",
+                 vmsg->request, vmsg->size, sizeof(vmsg->payload));
+        goto fail;
+    }
+
+    if (vmsg->size) {
+        do {
+            rc =3D read(conn_fd, &vmsg->payload, vmsg->size);
+        } while (rc < 0 && (errno =3D=3D EINTR || errno =3D=3D EAGAIN));
+
+        if (rc <=3D 0) {
+            vu_panic(dev, "Error while reading: %s", strerror(errno));
+            goto fail;
+        }
+
+        assert(rc =3D=3D vmsg->size);
+    }
+
+    return true;
+
+fail:
+    vmsg_close_fds(vmsg);
+
+    return false;
+}
+
+static bool
+vu_message_write(VuDev *dev, int conn_fd, VhostUserMsg *vmsg)
+{
+    int rc;
+    uint8_t *p =3D (uint8_t *)vmsg;
+
+    /* Set the version in the flags when sending the reply */
+    vmsg->flags &=3D ~VHOST_USER_VERSION_MASK;
+    vmsg->flags |=3D VHOST_USER_VERSION;
+    vmsg->flags |=3D VHOST_USER_REPLY_MASK;
+
+    do {
+        rc =3D write(conn_fd, p, VHOST_USER_HDR_SIZE);
+    } while (rc < 0 && (errno =3D=3D EINTR || errno =3D=3D EAGAIN));
+
+    do {
+        if (vmsg->data) {
+            rc =3D write(conn_fd, vmsg->data, vmsg->size);
+        } else {
+            rc =3D write(conn_fd, p + VHOST_USER_HDR_SIZE, vmsg->size);
+        }
+    } while (rc < 0 && (errno =3D=3D EINTR || errno =3D=3D EAGAIN));
+
+    if (rc <=3D 0) {
+        vu_panic(dev, "Error while writing: %s", strerror(errno));
+        return false;
+    }
+
+    return true;
+}
+
+/* Kick the log_call_fd if required. */
+static void
+vu_log_kick(VuDev *dev)
+{
+    if (dev->log_call_fd !=3D -1) {
+        DPRINT("Kicking the QEMU's log...\n");
+        if (eventfd_write(dev->log_call_fd, 1) < 0) {
+            vu_panic(dev, "Error writing eventfd: %s", strerror(errno));
+        }
+    }
+}
+
+static void
+vu_log_page(uint8_t *log_table, uint64_t page)
+{
+    DPRINT("Logged dirty guest page: %"PRId64"\n", page);
+    atomic_or(&log_table[page / 8], 1 << (page % 8));
+}
+
+static void
+vu_log_write(VuDev *dev, uint64_t address, uint64_t length)
+{
+    uint64_t page;
+
+    if (!(dev->features & (1ULL << VHOST_F_LOG_ALL)) ||
+        !dev->log_table || !length) {
+        return;
+    }
+
+    assert(dev->log_size > ((address + length - 1) / VHOST_LOG_PAGE / 8)=
);
+
+    page =3D address / VHOST_LOG_PAGE;
+    while (page * VHOST_LOG_PAGE < address + length) {
+        vu_log_page(dev->log_table, page);
+        page +=3D VHOST_LOG_PAGE;
+    }
+
+    vu_log_kick(dev);
+}
+
+static void
+vu_kick_cb(VuDev *dev, int condition, void *data)
+{
+    int index =3D (intptr_t)data;
+    VuVirtq *vq =3D &dev->vq[index];
+    int sock =3D vq->kick_fd;
+    eventfd_t kick_data;
+    ssize_t rc;
+
+    rc =3D eventfd_read(sock, &kick_data);
+    if (rc =3D=3D -1) {
+        vu_panic(dev, "kick eventfd_read(): %s", strerror(errno));
+        dev->remove_watch(dev, dev->vq[index].kick_fd);
+    } else {
+        DPRINT("Got kick_data: %016"PRIx64" handler:%p idx:%d\n",
+               kick_data, vq->handler, index);
+        if (vq->handler) {
+            vq->handler(dev, index);
+        }
+    }
+}
+
+static bool
+vu_get_features_exec(VuDev *dev, VhostUserMsg *vmsg)
+{
+    vmsg->payload.u64 =3D
+        1ULL << VHOST_F_LOG_ALL |
+        1ULL << VHOST_USER_F_PROTOCOL_FEATURES;
+
+    if (dev->iface->get_features) {
+        vmsg->payload.u64 |=3D dev->iface->get_features(dev);
+    }
+
+    vmsg->size =3D sizeof(vmsg->payload.u64);
+
+    DPRINT("Sending back to guest u64: 0x%016"PRIx64"\n", vmsg->payload.=
u64);
+
+    return true;
+}
+
+static void
+vu_set_enable_all_rings(VuDev *dev, bool enabled)
+{
+    int i;
+
+    for (i =3D 0; i < VHOST_MAX_NR_VIRTQUEUE; i++) {
+        dev->vq[i].enable =3D enabled;
+    }
+}
+
+static bool
+vu_set_features_exec(VuDev *dev, VhostUserMsg *vmsg)
+{
+    DPRINT("u64: 0x%016"PRIx64"\n", vmsg->payload.u64);
+
+    dev->features =3D vmsg->payload.u64;
+
+    if (!(dev->features & VHOST_USER_F_PROTOCOL_FEATURES)) {
+        vu_set_enable_all_rings(dev, true);
+    }
+
+    if (dev->iface->set_features) {
+        dev->iface->set_features(dev, dev->features);
+    }
+
+    return false;
+}
+
+static bool
+vu_set_owner_exec(VuDev *dev, VhostUserMsg *vmsg)
+{
+    return false;
+}
+
+static void
+vu_close_log(VuDev *dev)
+{
+    if (dev->log_table) {
+        if (munmap(dev->log_table, dev->log_size) !=3D 0) {
+            perror("close log munmap() error");
+        }
+
+        dev->log_table =3D NULL;
+    }
+    if (dev->log_call_fd !=3D -1) {
+        close(dev->log_call_fd);
+        dev->log_call_fd =3D -1;
+    }
+}
+
+static bool
+vu_reset_device_exec(VuDev *dev, VhostUserMsg *vmsg)
+{
+    vu_set_enable_all_rings(dev, false);
+
+    return false;
+}
+
+static bool
+vu_set_mem_table_exec(VuDev *dev, VhostUserMsg *vmsg)
+{
+    int i;
+    VhostUserMemory *memory =3D &vmsg->payload.memory;
+    dev->nregions =3D memory->nregions;
+
+    DPRINT("Nregions: %d\n", memory->nregions);
+    for (i =3D 0; i < dev->nregions; i++) {
+        void *mmap_addr;
+        VhostUserMemoryRegion *msg_region =3D &memory->regions[i];
+        VuDevRegion *dev_region =3D &dev->regions[i];
+
+        DPRINT("Region %d\n", i);
+        DPRINT("    guest_phys_addr: 0x%016"PRIx64"\n",
+               msg_region->guest_phys_addr);
+        DPRINT("    memory_size:     0x%016"PRIx64"\n",
+               msg_region->memory_size);
+        DPRINT("    userspace_addr   0x%016"PRIx64"\n",
+               msg_region->userspace_addr);
+        DPRINT("    mmap_offset      0x%016"PRIx64"\n",
+               msg_region->mmap_offset);
+
+        dev_region->gpa =3D msg_region->guest_phys_addr;
+        dev_region->size =3D msg_region->memory_size;
+        dev_region->qva =3D msg_region->userspace_addr;
+        dev_region->mmap_offset =3D msg_region->mmap_offset;
+
+        /* We don't use offset argument of mmap() since the
+         * mapped address has to be page aligned, and we use huge
+         * pages.  */
+        mmap_addr =3D mmap(0, dev_region->size + dev_region->mmap_offset=
,
+                         PROT_READ | PROT_WRITE, MAP_SHARED,
+                         vmsg->fds[i], 0);
+
+        if (mmap_addr =3D=3D MAP_FAILED) {
+            vu_panic(dev, "region mmap error: %s", strerror(errno));
+        } else {
+            dev_region->mmap_addr =3D (uint64_t)(uintptr_t)mmap_addr;
+            DPRINT("    mmap_addr:       0x%016"PRIx64"\n",
+                   dev_region->mmap_addr);
+        }
+
+        close(vmsg->fds[i]);
+    }
+
+    return false;
+}
+
+static bool
+vu_set_log_base_exec(VuDev *dev, VhostUserMsg *vmsg)
+{
+    int fd;
+    uint64_t log_mmap_size, log_mmap_offset;
+    void *rc;
+
+    if (vmsg->fd_num !=3D 1 ||
+        vmsg->size !=3D sizeof(vmsg->payload.log)) {
+        vu_panic(dev, "Invalid log_base message");
+        return true;
+    }
+
+    fd =3D vmsg->fds[0];
+    log_mmap_offset =3D vmsg->payload.log.mmap_offset;
+    log_mmap_size =3D vmsg->payload.log.mmap_size;
+    DPRINT("Log mmap_offset: %"PRId64"\n", log_mmap_offset);
+    DPRINT("Log mmap_size:   %"PRId64"\n", log_mmap_size);
+
+    rc =3D mmap(0, log_mmap_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd=
,
+              log_mmap_offset);
+    if (rc =3D=3D MAP_FAILED) {
+        perror("log mmap error");
+    }
+    dev->log_table =3D rc;
+    dev->log_size =3D log_mmap_size;
+
+    vmsg->size =3D sizeof(vmsg->payload.u64);
+
+    return true;
+}
+
+static bool
+vu_set_log_fd_exec(VuDev *dev, VhostUserMsg *vmsg)
+{
+    if (vmsg->fd_num !=3D 1) {
+        vu_panic(dev, "Invalid log_fd message");
+        return false;
+    }
+
+    if (dev->log_call_fd !=3D -1) {
+        close(dev->log_call_fd);
+    }
+    dev->log_call_fd =3D vmsg->fds[0];
+    DPRINT("Got log_call_fd: %d\n", vmsg->fds[0]);
+
+    return false;
+}
+
+static bool
+vu_set_vring_num_exec(VuDev *dev, VhostUserMsg *vmsg)
+{
+    unsigned int index =3D vmsg->payload.state.index;
+    unsigned int num =3D vmsg->payload.state.num;
+
+    DPRINT("State.index: %d\n", index);
+    DPRINT("State.num:   %d\n", num);
+    dev->vq[index].vring.num =3D num;
+
+    return false;
+}
+
+static bool
+vu_set_vring_addr_exec(VuDev *dev, VhostUserMsg *vmsg)
+{
+    struct vhost_vring_addr *vra =3D &vmsg->payload.addr;
+    unsigned int index =3D vra->index;
+    VuVirtq *vq =3D &dev->vq[index];
+
+    DPRINT("vhost_vring_addr:\n");
+    DPRINT("    index:  %d\n", vra->index);
+    DPRINT("    flags:  %d\n", vra->flags);
+    DPRINT("    desc_user_addr:   0x%016llx\n", vra->desc_user_addr);
+    DPRINT("    used_user_addr:   0x%016llx\n", vra->used_user_addr);
+    DPRINT("    avail_user_addr:  0x%016llx\n", vra->avail_user_addr);
+    DPRINT("    log_guest_addr:   0x%016llx\n", vra->log_guest_addr);
+
+    vq->vring.flags =3D vra->flags;
+    vq->vring.desc =3D qva_to_va(dev, vra->desc_user_addr);
+    vq->vring.used =3D qva_to_va(dev, vra->used_user_addr);
+    vq->vring.avail =3D qva_to_va(dev, vra->avail_user_addr);
+    vq->vring.log_guest_addr =3D vra->log_guest_addr;
+
+    DPRINT("Setting virtq addresses:\n");
+    DPRINT("    vring_desc  at %p\n", vq->vring.desc);
+    DPRINT("    vring_used  at %p\n", vq->vring.used);
+    DPRINT("    vring_avail at %p\n", vq->vring.avail);
+
+    if (!(vq->vring.desc && vq->vring.used && vq->vring.avail)) {
+        vu_panic(dev, "Invalid vring_addr message");
+        return false;
+    }
+
+    vq->used_idx =3D vq->vring.used->idx;
+
+    return false;
+}
+
+static bool
+vu_set_vring_base_exec(VuDev *dev, VhostUserMsg *vmsg)
+{
+    unsigned int index =3D vmsg->payload.state.index;
+    unsigned int num =3D vmsg->payload.state.num;
+
+    DPRINT("State.index: %d\n", index);
+    DPRINT("State.num:   %d\n", num);
+    dev->vq[index].shadow_avail_idx =3D dev->vq[index].last_avail_idx =3D=
 num;
+
+    return false;
+}
+
+static bool
+vu_get_vring_base_exec(VuDev *dev, VhostUserMsg *vmsg)
+{
+    unsigned int index =3D vmsg->payload.state.index;
+
+    DPRINT("State.index: %d\n", index);
+    vmsg->payload.state.num =3D dev->vq[index].last_avail_idx;
+    vmsg->size =3D sizeof(vmsg->payload.state);
+
+    dev->vq[index].started =3D false;
+    if (dev->iface->queue_set_started) {
+        dev->iface->queue_set_started(dev, index, false);
+    }
+
+    if (dev->vq[index].call_fd !=3D -1) {
+        close(dev->vq[index].call_fd);
+        dev->vq[index].call_fd =3D -1;
+    }
+    if (dev->vq[index].kick_fd !=3D -1) {
+        dev->remove_watch(dev, dev->vq[index].kick_fd);
+        close(dev->vq[index].kick_fd);
+        dev->vq[index].kick_fd =3D -1;
+    }
+
+    return true;
+}
+
+static bool
+vu_check_queue_msg_file(VuDev *dev, VhostUserMsg *vmsg)
+{
+    int index =3D vmsg->payload.u64 & VHOST_USER_VRING_IDX_MASK;
+
+    if (index >=3D VHOST_MAX_NR_VIRTQUEUE) {
+        vmsg_close_fds(vmsg);
+        vu_panic(dev, "Invalid queue index: %u", index);
+        return false;
+    }
+
+    if (vmsg->payload.u64 & VHOST_USER_VRING_NOFD_MASK ||
+        vmsg->fd_num !=3D 1) {
+        vmsg_close_fds(vmsg);
+        vu_panic(dev, "Invalid fds in request: %d", vmsg->request);
+        return false;
+    }
+
+    return true;
+}
+
+static bool
+vu_set_vring_kick_exec(VuDev *dev, VhostUserMsg *vmsg)
+{
+    int index =3D vmsg->payload.u64 & VHOST_USER_VRING_IDX_MASK;
+
+    DPRINT("u64: 0x%016"PRIx64"\n", vmsg->payload.u64);
+
+    if (!vu_check_queue_msg_file(dev, vmsg)) {
+        return false;
+    }
+
+    if (dev->vq[index].kick_fd !=3D -1) {
+        dev->remove_watch(dev, dev->vq[index].kick_fd);
+        close(dev->vq[index].kick_fd);
+        dev->vq[index].kick_fd =3D -1;
+    }
+
+    if (!(vmsg->payload.u64 & VHOST_USER_VRING_NOFD_MASK)) {
+        dev->vq[index].kick_fd =3D vmsg->fds[0];
+        DPRINT("Got kick_fd: %d for vq: %d\n", vmsg->fds[0], index);
+    }
+
+    dev->vq[index].started =3D true;
+    if (dev->iface->queue_set_started) {
+        dev->iface->queue_set_started(dev, index, true);
+    }
+
+    if (dev->vq[index].kick_fd !=3D -1 && dev->vq[index].handler) {
+        dev->set_watch(dev, dev->vq[index].kick_fd, VU_WATCH_IN,
+                       vu_kick_cb, (void *)(long)index);
+
+        DPRINT("Waiting for kicks on fd: %d for vq: %d\n",
+               dev->vq[index].kick_fd, index);
+    }
+
+    return false;
+}
+
+void vu_set_queue_handler(VuDev *dev, VuVirtq *vq,
+                          vu_queue_handler_cb handler)
+{
+    int qidx =3D vq - dev->vq;
+
+    vq->handler =3D handler;
+    if (vq->kick_fd >=3D 0) {
+        if (handler) {
+            dev->set_watch(dev, vq->kick_fd, VU_WATCH_IN,
+                           vu_kick_cb, (void *)(long)qidx);
+        } else {
+            dev->remove_watch(dev, vq->kick_fd);
+        }
+    }
+}
+
+static bool
+vu_set_vring_call_exec(VuDev *dev, VhostUserMsg *vmsg)
+{
+    int index =3D vmsg->payload.u64 & VHOST_USER_VRING_IDX_MASK;
+
+    DPRINT("u64: 0x%016"PRIx64"\n", vmsg->payload.u64);
+
+    if (!vu_check_queue_msg_file(dev, vmsg)) {
+        return false;
+    }
+
+    if (dev->vq[index].call_fd !=3D -1) {
+        close(dev->vq[index].call_fd);
+        dev->vq[index].call_fd =3D -1;
+    }
+
+    if (!(vmsg->payload.u64 & VHOST_USER_VRING_NOFD_MASK)) {
+        dev->vq[index].call_fd =3D vmsg->fds[0];
+    }
+
+    DPRINT("Got call_fd: %d for vq: %d\n", vmsg->fds[0], index);
+
+    return false;
+}
+
+static bool
+vu_set_vring_err_exec(VuDev *dev, VhostUserMsg *vmsg)
+{
+    int index =3D vmsg->payload.u64 & VHOST_USER_VRING_IDX_MASK;
+
+    DPRINT("u64: 0x%016"PRIx64"\n", vmsg->payload.u64);
+
+    if (!vu_check_queue_msg_file(dev, vmsg)) {
+        return false;
+    }
+
+    if (dev->vq[index].err_fd !=3D -1) {
+        close(dev->vq[index].err_fd);
+        dev->vq[index].err_fd =3D -1;
+    }
+
+    if (!(vmsg->payload.u64 & VHOST_USER_VRING_NOFD_MASK)) {
+        dev->vq[index].err_fd =3D vmsg->fds[0];
+    }
+
+    return false;
+}
+
+static bool
+vu_get_protocol_features_exec(VuDev *dev, VhostUserMsg *vmsg)
+{
+    uint64_t features =3D 1ULL << VHOST_USER_PROTOCOL_F_LOG_SHMFD;
+
+    if (dev->iface->get_protocol_features) {
+        features |=3D dev->iface->get_protocol_features(dev);
+    }
+
+    vmsg->payload.u64 =3D features;
+    vmsg->size =3D sizeof(vmsg->payload.u64);
+
+    return true;
+}
+
+static bool
+vu_set_protocol_features_exec(VuDev *dev, VhostUserMsg *vmsg)
+{
+    uint64_t features =3D vmsg->payload.u64;
+
+    DPRINT("u64: 0x%016"PRIx64"\n", features);
+
+    dev->protocol_features =3D vmsg->payload.u64;
+
+    if (dev->iface->set_protocol_features) {
+        dev->iface->set_protocol_features(dev, features);
+    }
+
+    return false;
+}
+
+static bool
+vu_get_queue_num_exec(VuDev *dev, VhostUserMsg *vmsg)
+{
+    DPRINT("Function %s() not implemented yet.\n", __func__);
+    return false;
+}
+
+static bool
+vu_set_vring_enable_exec(VuDev *dev, VhostUserMsg *vmsg)
+{
+    unsigned int index =3D vmsg->payload.state.index;
+    unsigned int enable =3D vmsg->payload.state.num;
+
+    DPRINT("State.index: %d\n", index);
+    DPRINT("State.enable:   %d\n", enable);
+
+    if (index >=3D VHOST_MAX_NR_VIRTQUEUE) {
+        vu_panic(dev, "Invalid vring_enable index: %u", index);
+        return false;
+    }
+
+    dev->vq[index].enable =3D enable;
+    return false;
+}
+
+static bool
+vu_process_message(VuDev *dev, VhostUserMsg *vmsg)
+{
+    int do_reply =3D 0;
+
+    /* Print out generic part of the request. */
+    DPRINT("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D Vhost user =
message =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n");
+    DPRINT("Request: %s (%d)\n", vu_request_to_string(vmsg->request),
+           vmsg->request);
+    DPRINT("Flags:   0x%x\n", vmsg->flags);
+    DPRINT("Size:    %d\n", vmsg->size);
+
+    if (vmsg->fd_num) {
+        int i;
+        DPRINT("Fds:");
+        for (i =3D 0; i < vmsg->fd_num; i++) {
+            DPRINT(" %d", vmsg->fds[i]);
+        }
+        DPRINT("\n");
+    }
+
+    if (dev->iface->process_msg &&
+        dev->iface->process_msg(dev, vmsg, &do_reply)) {
+        return do_reply;
+    }
+
+    switch (vmsg->request) {
+    case VHOST_USER_GET_FEATURES:
+        return vu_get_features_exec(dev, vmsg);
+    case VHOST_USER_SET_FEATURES:
+        return vu_set_features_exec(dev, vmsg);
+    case VHOST_USER_GET_PROTOCOL_FEATURES:
+        return vu_get_protocol_features_exec(dev, vmsg);
+    case VHOST_USER_SET_PROTOCOL_FEATURES:
+        return vu_set_protocol_features_exec(dev, vmsg);
+    case VHOST_USER_SET_OWNER:
+        return vu_set_owner_exec(dev, vmsg);
+    case VHOST_USER_RESET_OWNER:
+        return vu_reset_device_exec(dev, vmsg);
+    case VHOST_USER_SET_MEM_TABLE:
+        return vu_set_mem_table_exec(dev, vmsg);
+    case VHOST_USER_SET_LOG_BASE:
+        return vu_set_log_base_exec(dev, vmsg);
+    case VHOST_USER_SET_LOG_FD:
+        return vu_set_log_fd_exec(dev, vmsg);
+    case VHOST_USER_SET_VRING_NUM:
+        return vu_set_vring_num_exec(dev, vmsg);
+    case VHOST_USER_SET_VRING_ADDR:
+        return vu_set_vring_addr_exec(dev, vmsg);
+    case VHOST_USER_SET_VRING_BASE:
+        return vu_set_vring_base_exec(dev, vmsg);
+    case VHOST_USER_GET_VRING_BASE:
+        return vu_get_vring_base_exec(dev, vmsg);
+    case VHOST_USER_SET_VRING_KICK:
+        return vu_set_vring_kick_exec(dev, vmsg);
+    case VHOST_USER_SET_VRING_CALL:
+        return vu_set_vring_call_exec(dev, vmsg);
+    case VHOST_USER_SET_VRING_ERR:
+        return vu_set_vring_err_exec(dev, vmsg);
+    case VHOST_USER_GET_QUEUE_NUM:
+        return vu_get_queue_num_exec(dev, vmsg);
+    case VHOST_USER_SET_VRING_ENABLE:
+        return vu_set_vring_enable_exec(dev, vmsg);
+    default:
+        vmsg_close_fds(vmsg);
+        vu_panic(dev, "Unhandled request: %d", vmsg->request);
+    }
+
+    return false;
+}
+
+bool
+vu_dispatch(VuDev *dev)
+{
+    VhostUserMsg vmsg =3D { 0, };
+    int reply_requested;
+    bool success =3D false;
+
+    if (!vu_message_read(dev, dev->sock, &vmsg)) {
+        goto end;
+    }
+
+    reply_requested =3D vu_process_message(dev, &vmsg);
+    if (!reply_requested) {
+        success =3D true;
+        goto end;
+    }
+
+    if (!vu_message_write(dev, dev->sock, &vmsg)) {
+        goto end;
+    }
+
+    success =3D true;
+
+end:
+    g_free(vmsg.data);
+    return success;
+}
+
+void
+vu_deinit(VuDev *dev)
+{
+    int i;
+
+    for (i =3D 0; i < dev->nregions; i++) {
+        VuDevRegion *r =3D &dev->regions[i];
+        void *m =3D (void *) (uintptr_t) r->mmap_addr;
+        if (m !=3D MAP_FAILED) {
+            munmap(m, r->size + r->mmap_offset);
+        }
+    }
+    dev->nregions =3D 0;
+
+    for (i =3D 0; i < VHOST_MAX_NR_VIRTQUEUE; i++) {
+        VuVirtq *vq =3D &dev->vq[i];
+
+        if (vq->call_fd !=3D -1) {
+            close(vq->call_fd);
+            vq->call_fd =3D -1;
+        }
+
+        if (vq->kick_fd !=3D -1) {
+            close(vq->kick_fd);
+            vq->kick_fd =3D -1;
+        }
+
+        if (vq->err_fd !=3D -1) {
+            close(vq->err_fd);
+            vq->err_fd =3D -1;
+        }
+    }
+
+
+    vu_close_log(dev);
+
+    if (dev->sock !=3D -1) {
+        close(dev->sock);
+    }
+}
+
+void
+vu_init(VuDev *dev,
+        int socket,
+        vu_panic_cb panic,
+        vu_set_watch_cb set_watch,
+        vu_remove_watch_cb remove_watch,
+        const VuDevIface *iface)
+{
+    int i;
+
+    assert(socket >=3D 0);
+    assert(set_watch);
+    assert(remove_watch);
+    assert(iface);
+    assert(panic);
+
+    memset(dev, 0, sizeof(*dev));
+
+    dev->sock =3D socket;
+    dev->panic =3D panic;
+    dev->set_watch =3D set_watch;
+    dev->remove_watch =3D remove_watch;
+    dev->iface =3D iface;
+    dev->log_call_fd =3D -1;
+    for (i =3D 0; i < VHOST_MAX_NR_VIRTQUEUE; i++) {
+        dev->vq[i] =3D (VuVirtq) {
+            .call_fd =3D -1, .kick_fd =3D -1, .err_fd =3D -1,
+            .notification =3D true,
+        };
+    }
+}
+
+VuVirtq *
+vu_get_queue(VuDev *dev, int qidx)
+{
+    assert(qidx < VHOST_MAX_NR_VIRTQUEUE);
+    return &dev->vq[qidx];
+}
+
+bool
+vu_queue_enabled(VuDev *dev, VuVirtq *vq)
+{
+    return vq->enable;
+}
+
+static inline uint16_t
+vring_avail_flags(VuVirtq *vq)
+{
+    return vq->vring.avail->flags;
+}
+
+static inline uint16_t
+vring_avail_idx(VuVirtq *vq)
+{
+    vq->shadow_avail_idx =3D vq->vring.avail->idx;
+
+    return vq->shadow_avail_idx;
+}
+
+static inline uint16_t
+vring_avail_ring(VuVirtq *vq, int i)
+{
+    return vq->vring.avail->ring[i];
+}
+
+static inline uint16_t
+vring_get_used_event(VuVirtq *vq)
+{
+    return vring_avail_ring(vq, vq->vring.num);
+}
+
+static int
+virtqueue_num_heads(VuDev *dev, VuVirtq *vq, unsigned int idx)
+{
+    uint16_t num_heads =3D vring_avail_idx(vq) - idx;
+
+    /* Check it isn't doing very strange things with descriptor numbers.=
 */
+    if (num_heads > vq->vring.num) {
+        vu_panic(dev, "Guest moved used index from %u to %u",
+                 idx, vq->shadow_avail_idx);
+        return -1;
+    }
+    if (num_heads) {
+        /* On success, callers read a descriptor at vq->last_avail_idx.
+         * Make sure descriptor read does not bypass avail index read. *=
/
+        smp_rmb();
+    }
+
+    return num_heads;
+}
+
+static bool
+virtqueue_get_head(VuDev *dev, VuVirtq *vq,
+                   unsigned int idx, unsigned int *head)
+{
+    /* Grab the next descriptor number they're advertising, and incremen=
t
+     * the index we've seen. */
+    *head =3D vring_avail_ring(vq, idx % vq->vring.num);
+
+    /* If their number is silly, that's a fatal mistake. */
+    if (*head >=3D vq->vring.num) {
+        vu_panic(dev, "Guest says index %u is available", head);
+        return false;
+    }
+
+    return true;
+}
+
+enum {
+    VIRTQUEUE_READ_DESC_ERROR =3D -1,
+    VIRTQUEUE_READ_DESC_DONE =3D 0,   /* end of chain */
+    VIRTQUEUE_READ_DESC_MORE =3D 1,   /* more buffers in chain */
+};
+
+static int
+virtqueue_read_next_desc(VuDev *dev, struct vring_desc *desc,
+                         int i, unsigned int max, unsigned int *next)
+{
+    /* If this descriptor says it doesn't chain, we're done. */
+    if (!(desc[i].flags & VRING_DESC_F_NEXT)) {
+        return VIRTQUEUE_READ_DESC_DONE;
+    }
+
+    /* Check they're not leading us off end of descriptors. */
+    *next =3D desc[i].next;
+    /* Make sure compiler knows to grab that: we don't want it changing!=
 */
+    smp_wmb();
+
+    if (*next >=3D max) {
+        vu_panic(dev, "Desc next is %u", next);
+        return VIRTQUEUE_READ_DESC_ERROR;
+    }
+
+    return VIRTQUEUE_READ_DESC_MORE;
+}
+
+void
+vu_queue_get_avail_bytes(VuDev *dev, VuVirtq *vq, unsigned int *in_bytes=
,
+                         unsigned int *out_bytes,
+                         unsigned max_in_bytes, unsigned max_out_bytes)
+{
+    unsigned int idx;
+    unsigned int total_bufs, in_total, out_total;
+    int rc;
+
+    idx =3D vq->last_avail_idx;
+
+    total_bufs =3D in_total =3D out_total =3D 0;
+    while ((rc =3D virtqueue_num_heads(dev, vq, idx)) > 0) {
+        unsigned int max, num_bufs, indirect =3D 0;
+        struct vring_desc *desc;
+        unsigned int i;
+
+        max =3D vq->vring.num;
+        num_bufs =3D total_bufs;
+        if (!virtqueue_get_head(dev, vq, idx++, &i)) {
+            goto err;
+        }
+        desc =3D vq->vring.desc;
+
+        if (desc[i].flags & VRING_DESC_F_INDIRECT) {
+            if (desc[i].len % sizeof(struct vring_desc)) {
+                vu_panic(dev, "Invalid size for indirect buffer table");
+                goto err;
+            }
+
+            /* If we've got too many, that implies a descriptor loop. */
+            if (num_bufs >=3D max) {
+                vu_panic(dev, "Looped descriptor");
+                goto err;
+            }
+
+            /* loop over the indirect descriptor table */
+            indirect =3D 1;
+            max =3D desc[i].len / sizeof(struct vring_desc);
+            desc =3D vu_gpa_to_va(dev, desc[i].addr);
+            num_bufs =3D i =3D 0;
+        }
+
+        do {
+            /* If we've got too many, that implies a descriptor loop. */
+            if (++num_bufs > max) {
+                vu_panic(dev, "Looped descriptor");
+                goto err;
+            }
+
+            if (desc[i].flags & VRING_DESC_F_WRITE) {
+                in_total +=3D desc[i].len;
+            } else {
+                out_total +=3D desc[i].len;
+            }
+            if (in_total >=3D max_in_bytes && out_total >=3D max_out_byt=
es) {
+                goto done;
+            }
+            rc =3D virtqueue_read_next_desc(dev, desc, i, max, &i);
+        } while (rc =3D=3D VIRTQUEUE_READ_DESC_MORE);
+
+        if (rc =3D=3D VIRTQUEUE_READ_DESC_ERROR) {
+            goto err;
+        }
+
+        if (!indirect) {
+            total_bufs =3D num_bufs;
+        } else {
+            total_bufs++;
+        }
+    }
+    if (rc < 0) {
+        goto err;
+    }
+done:
+    if (in_bytes) {
+        *in_bytes =3D in_total;
+    }
+    if (out_bytes) {
+        *out_bytes =3D out_total;
+    }
+    return;
+
+err:
+    in_total =3D out_total =3D 0;
+    goto done;
+}
+
+bool
+vu_queue_avail_bytes(VuDev *dev, VuVirtq *vq, unsigned int in_bytes,
+                     unsigned int out_bytes)
+{
+    unsigned int in_total, out_total;
+
+    vu_queue_get_avail_bytes(dev, vq, &in_total, &out_total,
+                             in_bytes, out_bytes);
+
+    return in_bytes <=3D in_total && out_bytes <=3D out_total;
+}
+
+/* Fetch avail_idx from VQ memory only when we really need to know if
+ * guest has added some buffers. */
+int
+vu_queue_empty(VuDev *dev, VuVirtq *vq)
+{
+    if (vq->shadow_avail_idx !=3D vq->last_avail_idx) {
+        return 0;
+    }
+
+    return vring_avail_idx(vq) =3D=3D vq->last_avail_idx;
+}
+
+static inline
+bool has_feature(uint64_t features, unsigned int fbit)
+{
+    assert(fbit < 64);
+    return !!(features & (1ULL << fbit));
+}
+
+static inline
+bool vu_has_feature(VuDev *dev,
+                    unsigned int fbit)
+{
+    return has_feature(dev->features, fbit);
+}
+
+static bool
+vring_notify(VuDev *dev, VuVirtq *vq)
+{
+    uint16_t old, new;
+    bool v;
+
+    /* We need to expose used array entries before checking used event. =
*/
+    smp_mb();
+
+    /* Always notify when queue is empty (when feature acknowledge) */
+    if (vu_has_feature(dev, VIRTIO_F_NOTIFY_ON_EMPTY) &&
+        !vq->inuse && vu_queue_empty(dev, vq)) {
+        return true;
+    }
+
+    if (!vu_has_feature(dev, VIRTIO_RING_F_EVENT_IDX)) {
+        return !(vring_avail_flags(vq) & VRING_AVAIL_F_NO_INTERRUPT);
+    }
+
+    v =3D vq->signalled_used_valid;
+    vq->signalled_used_valid =3D true;
+    old =3D vq->signalled_used;
+    new =3D vq->signalled_used =3D vq->used_idx;
+    return !v || vring_need_event(vring_get_used_event(vq), new, old);
+}
+
+void
+vu_queue_notify(VuDev *dev, VuVirtq *vq)
+{
+    if (unlikely(dev->broken)) {
+        return;
+    }
+
+    if (!vring_notify(dev, vq)) {
+        DPRINT("skipped notify...\n");
+        return;
+    }
+
+    if (eventfd_write(vq->call_fd, 1) < 0) {
+        vu_panic(dev, "Error writing eventfd: %s", strerror(errno));
+    }
+}
+
+static inline void
+vring_used_flags_set_bit(VuVirtq *vq, int mask)
+{
+    uint16_t *flags;
+
+    flags =3D (uint16_t *)((char*)vq->vring.used +
+                         offsetof(struct vring_used, flags));
+    *flags |=3D mask;
+}
+
+static inline void
+vring_used_flags_unset_bit(VuVirtq *vq, int mask)
+{
+    uint16_t *flags;
+
+    flags =3D (uint16_t *)((char*)vq->vring.used +
+                         offsetof(struct vring_used, flags));
+    *flags &=3D ~mask;
+}
+
+static inline void
+vring_set_avail_event(VuVirtq *vq, uint16_t val)
+{
+    if (!vq->notification) {
+        return;
+    }
+
+    *((uint16_t *) &vq->vring.used->ring[vq->vring.num]) =3D val;
+}
+
+void
+vu_queue_set_notification(VuDev *dev, VuVirtq *vq, int enable)
+{
+    vq->notification =3D enable;
+    if (vu_has_feature(dev, VIRTIO_RING_F_EVENT_IDX)) {
+        vring_set_avail_event(vq, vring_avail_idx(vq));
+    } else if (enable) {
+        vring_used_flags_unset_bit(vq, VRING_USED_F_NO_NOTIFY);
+    } else {
+        vring_used_flags_set_bit(vq, VRING_USED_F_NO_NOTIFY);
+    }
+    if (enable) {
+        /* Expose avail event/used flags before caller checks the avail =
idx. */
+        smp_mb();
+    }
+}
+
+static void
+virtqueue_map_desc(VuDev *dev,
+                   unsigned int *p_num_sg, struct iovec *iov,
+                   unsigned int max_num_sg, bool is_write,
+                   uint64_t pa, size_t sz)
+{
+    unsigned num_sg =3D *p_num_sg;
+
+    assert(num_sg <=3D max_num_sg);
+
+    if (!sz) {
+        vu_panic(dev, "virtio: zero sized buffers are not allowed");
+        return;
+    }
+
+    iov[num_sg].iov_base =3D vu_gpa_to_va(dev, pa);
+    iov[num_sg].iov_len =3D sz;
+    num_sg++;
+
+    *p_num_sg =3D num_sg;
+}
+
+/* Round number down to multiple */
+#define ALIGN_DOWN(n, m) ((n) / (m) * (m))
+
+/* Round number up to multiple */
+#define ALIGN_UP(n, m) ALIGN_DOWN((n) + (m) - 1, (m))
+
+static void *
+virtqueue_alloc_element(size_t sz,
+                                     unsigned out_num, unsigned in_num)
+{
+    VuVirtqElement *elem;
+    size_t in_sg_ofs =3D ALIGN_UP(sz, __alignof__(elem->in_sg[0]));
+    size_t out_sg_ofs =3D in_sg_ofs + in_num * sizeof(elem->in_sg[0]);
+    size_t out_sg_end =3D out_sg_ofs + out_num * sizeof(elem->out_sg[0])=
;
+
+    assert(sz >=3D sizeof(VuVirtqElement));
+    elem =3D malloc(out_sg_end);
+    elem->out_num =3D out_num;
+    elem->in_num =3D in_num;
+    elem->in_sg =3D (void *)elem + in_sg_ofs;
+    elem->out_sg =3D (void *)elem + out_sg_ofs;
+    return elem;
+}
+
+void *
+vu_queue_pop(VuDev *dev, VuVirtq *vq, size_t sz)
+{
+    unsigned int i, head, max;
+    VuVirtqElement *elem;
+    unsigned out_num, in_num;
+    struct iovec iov[VIRTQUEUE_MAX_SIZE];
+    struct vring_desc *desc;
+    int rc;
+
+    if (unlikely(dev->broken)) {
+        return NULL;
+    }
+
+    if (vu_queue_empty(dev, vq)) {
+        return NULL;
+    }
+    /* Needed after virtio_queue_empty(), see comment in
+     * virtqueue_num_heads(). */
+    smp_rmb();
+
+    /* When we start there are none of either input nor output. */
+    out_num =3D in_num =3D 0;
+
+    max =3D vq->vring.num;
+    if (vq->inuse >=3D vq->vring.num) {
+        vu_panic(dev, "Virtqueue size exceeded");
+        return NULL;
+    }
+
+    if (!virtqueue_get_head(dev, vq, vq->last_avail_idx++, &head)) {
+        return NULL;
+    }
+
+    if (vu_has_feature(dev, VIRTIO_RING_F_EVENT_IDX)) {
+        vring_set_avail_event(vq, vq->last_avail_idx);
+    }
+
+    i =3D head;
+    desc =3D vq->vring.desc;
+    if (desc[i].flags & VRING_DESC_F_INDIRECT) {
+        if (desc[i].len % sizeof(struct vring_desc)) {
+            vu_panic(dev, "Invalid size for indirect buffer table");
+        }
+
+        /* loop over the indirect descriptor table */
+        max =3D desc[i].len / sizeof(struct vring_desc);
+        desc =3D vu_gpa_to_va(dev, desc[i].addr);
+        i =3D 0;
+    }
+
+    /* Collect all the descriptors */
+    do {
+        if (desc[i].flags & VRING_DESC_F_WRITE) {
+            virtqueue_map_desc(dev, &in_num, iov + out_num,
+                               VIRTQUEUE_MAX_SIZE - out_num, true,
+                               desc[i].addr, desc[i].len);
+        } else {
+            if (in_num) {
+                vu_panic(dev, "Incorrect order for descriptors");
+                return NULL;
+            }
+            virtqueue_map_desc(dev, &out_num, iov,
+                               VIRTQUEUE_MAX_SIZE, false,
+                               desc[i].addr, desc[i].len);
+        }
+
+        /* If we've got too many, that implies a descriptor loop. */
+        if ((in_num + out_num) > max) {
+            vu_panic(dev, "Looped descriptor");
+        }
+        rc =3D virtqueue_read_next_desc(dev, desc, i, max, &i);
+    } while (rc =3D=3D VIRTQUEUE_READ_DESC_MORE);
+
+    if (rc =3D=3D VIRTQUEUE_READ_DESC_ERROR) {
+        return NULL;
+    }
+
+    /* Now copy what we have collected and mapped */
+    elem =3D virtqueue_alloc_element(sz, out_num, in_num);
+    elem->index =3D head;
+    for (i =3D 0; i < out_num; i++) {
+        elem->out_sg[i] =3D iov[i];
+    }
+    for (i =3D 0; i < in_num; i++) {
+        elem->in_sg[i] =3D iov[out_num + i];
+    }
+
+    vq->inuse++;
+
+    return elem;
+}
+
+bool
+vu_queue_rewind(VuDev *dev, VuVirtq *vq, unsigned int num)
+{
+    if (num > vq->inuse) {
+        return false;
+    }
+    vq->last_avail_idx -=3D num;
+    vq->inuse -=3D num;
+    return true;
+}
+
+static inline
+void vring_used_write(VuDev *dev, VuVirtq *vq,
+                      struct vring_used_elem *uelem, int i)
+{
+    struct vring_used *used =3D vq->vring.used;
+
+    used->ring[i] =3D *uelem;
+    vu_log_write(dev, vq->vring.log_guest_addr +
+                 offsetof(struct vring_used, ring[i]),
+                 sizeof(used->ring[i]));
+}
+
+
+static void
+vu_log_queue_fill(VuDev *dev, VuVirtq *vq,
+                  const VuVirtqElement *elem,
+                  unsigned int len)
+{
+    struct vring_desc *desc =3D vq->vring.desc;
+    unsigned int i, max, min;
+    unsigned num_bufs =3D 0;
+
+    max =3D vq->vring.num;
+    i =3D elem->index;
+
+    if (desc[i].flags & VRING_DESC_F_INDIRECT) {
+        if (desc[i].len % sizeof(struct vring_desc)) {
+            vu_panic(dev, "Invalid size for indirect buffer table");
+        }
+
+        /* loop over the indirect descriptor table */
+        max =3D desc[i].len / sizeof(struct vring_desc);
+        desc =3D vu_gpa_to_va(dev, desc[i].addr);
+        i =3D 0;
+    }
+
+    do {
+        if (++num_bufs > max) {
+            vu_panic(dev, "Looped descriptor");
+            return;
+        }
+
+        if (desc[i].flags & VRING_DESC_F_WRITE) {
+            min =3D MIN(desc[i].len, len);
+            vu_log_write(dev, desc[i].addr, min);
+            len -=3D min;
+        }
+
+    } while (len > 0 &&
+             (virtqueue_read_next_desc(dev, desc, i, max, &i)
+              =3D=3D VIRTQUEUE_READ_DESC_MORE));
+}
+
+void
+vu_queue_fill(VuDev *dev, VuVirtq *vq,
+              const VuVirtqElement *elem,
+              unsigned int len, unsigned int idx)
+{
+    struct vring_used_elem uelem;
+
+    if (unlikely(dev->broken)) {
+        return;
+    }
+
+    vu_log_queue_fill(dev, vq, elem, len);
+
+    idx =3D (idx + vq->used_idx) % vq->vring.num;
+
+    uelem.id =3D elem->index;
+    uelem.len =3D len;
+    vring_used_write(dev, vq, &uelem, idx);
+}
+
+static inline
+void vring_used_idx_set(VuDev *dev, VuVirtq *vq, uint16_t val)
+{
+    vq->vring.used->idx =3D val;
+    vu_log_write(dev,
+                 vq->vring.log_guest_addr + offsetof(struct vring_used, =
idx),
+                 sizeof(vq->vring.used->idx));
+
+    vq->used_idx =3D val;
+}
+
+void
+vu_queue_flush(VuDev *dev, VuVirtq *vq, unsigned int count)
+{
+    uint16_t old, new;
+
+    if (unlikely(dev->broken)) {
+        return;
+    }
+
+    /* Make sure buffer is written before we update index. */
+    smp_wmb();
+
+    old =3D vq->used_idx;
+    new =3D old + count;
+    vring_used_idx_set(dev, vq, new);
+    vq->inuse -=3D count;
+    if (unlikely((int16_t)(new - vq->signalled_used) < (uint16_t)(new - =
old))) {
+        vq->signalled_used_valid =3D false;
+    }
+}
+
+void
+vu_queue_push(VuDev *dev, VuVirtq *vq,
+              const VuVirtqElement *elem, unsigned int len)
+{
+    vu_queue_fill(dev, vq, elem, len, 0);
+    vu_queue_flush(dev, vq, 1);
+}
diff --git a/Makefile.objs b/Makefile.objs
index 06f74b8..ecd6576 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -116,7 +116,7 @@ qga-vss-dll-obj-y =3D qga/
 # contrib
 ivshmem-client-obj-y =3D contrib/ivshmem-client/
 ivshmem-server-obj-y =3D contrib/ivshmem-server/
-
+libvhost-user-obj-y =3D contrib/libvhost-user/
=20
 ######################################################################
 trace-events-y =3D trace-events
diff --git a/contrib/libvhost-user/Makefile.objs b/contrib/libvhost-user/=
Makefile.objs
new file mode 100644
index 0000000..cef1ad6
--- /dev/null
+++ b/contrib/libvhost-user/Makefile.objs
@@ -0,0 +1 @@
+libvhost-user-obj-y =3D libvhost-user.o
--=20
MST
