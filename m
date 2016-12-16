Received: from eggs.gnu.org ([2001:4830:134:3::10]:38916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=thZ3=X7=redhat.com=mst@kernel.org>)
	id 1cHzsX-0003dY-1H
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 16:17:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=thZ3=X7=redhat.com=mst@kernel.org>)
	id 1cHzsS-0007B2-Nd
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 16:17:20 -0500
Received: from mail.kernel.org ([198.145.29.136]:48896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=thZ3=X7=redhat.com=mst@kernel.org>)
	id 1cHzsS-00079k-45
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 16:17:16 -0500
Date: Fri, 16 Dec 2016 23:17:07 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1481922841-4324-7-git-send-email-mst@redhat.com>
References: <1481922841-4324-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1481922841-4324-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for-2.9 6/9] tests/vhost-user-bridge: use
 contrib/libvhost-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Victor Kaplansky <victork@redhat.com>, stefanha@redhat.com

From: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

Use the libvhost-user library.

This ended up being a rather large patch that cannot be easily splitted,
due to massive code move and API changes.

Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/vhost-user-bridge.c | 1177 +++++++++------------------------------=
------
 tests/Makefile.include    |    2 +-
 2 files changed, 229 insertions(+), 950 deletions(-)

diff --git a/tests/vhost-user-bridge.c b/tests/vhost-user-bridge.c
index 5b618f6..8618c20 100644
--- a/tests/vhost-user-bridge.c
+++ b/tests/vhost-user-bridge.c
@@ -30,17 +30,9 @@
 #define _FILE_OFFSET_BITS 64
=20
 #include "qemu/osdep.h"
-#include <sys/socket.h>
-#include <sys/un.h>
-#include <sys/unistd.h>
-#include <sys/eventfd.h>
-#include <arpa/inet.h>
-#include <netdb.h>
-#include <linux/vhost.h>
-
-#include "qemu/atomic.h"
+#include "qemu/iov.h"
 #include "standard-headers/linux/virtio_net.h"
-#include "standard-headers/linux/virtio_ring.h"
+#include "contrib/libvhost-user/libvhost-user.h"
=20
 #define VHOST_USER_BRIDGE_DEBUG 1
=20
@@ -64,6 +56,17 @@ typedef struct Dispatcher {
     Event events[FD_SETSIZE];
 } Dispatcher;
=20
+typedef struct VubrDev {
+    VuDev vudev;
+    Dispatcher dispatcher;
+    int backend_udp_sock;
+    struct sockaddr_in backend_udp_dest;
+    int hdrlen;
+    int sock;
+    int ready;
+    int quit;
+} VubrDev;
+
 static void
 vubr_die(const char *s)
 {
@@ -155,1036 +158,313 @@ dispatcher_wait(Dispatcher *dispr, uint32_t time=
out)
     return 0;
 }
=20
-typedef struct VubrVirtq {
-    int call_fd;
-    int kick_fd;
-    uint32_t size;
-    uint16_t last_avail_index;
-    uint16_t last_used_index;
-    struct vring_desc *desc;
-    struct vring_avail *avail;
-    struct vring_used *used;
-    uint64_t log_guest_addr;
-    int enable;
-} VubrVirtq;
-
-/* Based on qemu/hw/virtio/vhost-user.c */
-
-#define VHOST_MEMORY_MAX_NREGIONS    8
-#define VHOST_USER_F_PROTOCOL_FEATURES 30
-/* v1.0 compliant. */
-#define VIRTIO_F_VERSION_1		32
-
-#define VHOST_LOG_PAGE 4096
-
-enum VhostUserProtocolFeature {
-    VHOST_USER_PROTOCOL_F_MQ =3D 0,
-    VHOST_USER_PROTOCOL_F_LOG_SHMFD =3D 1,
-    VHOST_USER_PROTOCOL_F_RARP =3D 2,
-
-    VHOST_USER_PROTOCOL_F_MAX
-};
-
-#define VHOST_USER_PROTOCOL_FEATURE_MASK ((1 << VHOST_USER_PROTOCOL_F_MA=
X) - 1)
-
-typedef enum VhostUserRequest {
-    VHOST_USER_NONE =3D 0,
-    VHOST_USER_GET_FEATURES =3D 1,
-    VHOST_USER_SET_FEATURES =3D 2,
-    VHOST_USER_SET_OWNER =3D 3,
-    VHOST_USER_RESET_OWNER =3D 4,
-    VHOST_USER_SET_MEM_TABLE =3D 5,
-    VHOST_USER_SET_LOG_BASE =3D 6,
-    VHOST_USER_SET_LOG_FD =3D 7,
-    VHOST_USER_SET_VRING_NUM =3D 8,
-    VHOST_USER_SET_VRING_ADDR =3D 9,
-    VHOST_USER_SET_VRING_BASE =3D 10,
-    VHOST_USER_GET_VRING_BASE =3D 11,
-    VHOST_USER_SET_VRING_KICK =3D 12,
-    VHOST_USER_SET_VRING_CALL =3D 13,
-    VHOST_USER_SET_VRING_ERR =3D 14,
-    VHOST_USER_GET_PROTOCOL_FEATURES =3D 15,
-    VHOST_USER_SET_PROTOCOL_FEATURES =3D 16,
-    VHOST_USER_GET_QUEUE_NUM =3D 17,
-    VHOST_USER_SET_VRING_ENABLE =3D 18,
-    VHOST_USER_SEND_RARP =3D 19,
-    VHOST_USER_MAX
-} VhostUserRequest;
-
-typedef struct VhostUserMemoryRegion {
-    uint64_t guest_phys_addr;
-    uint64_t memory_size;
-    uint64_t userspace_addr;
-    uint64_t mmap_offset;
-} VhostUserMemoryRegion;
-
-typedef struct VhostUserMemory {
-    uint32_t nregions;
-    uint32_t padding;
-    VhostUserMemoryRegion regions[VHOST_MEMORY_MAX_NREGIONS];
-} VhostUserMemory;
-
-typedef struct VhostUserLog {
-    uint64_t mmap_size;
-    uint64_t mmap_offset;
-} VhostUserLog;
-
-typedef struct VhostUserMsg {
-    VhostUserRequest request;
-
-#define VHOST_USER_VERSION_MASK     (0x3)
-#define VHOST_USER_REPLY_MASK       (0x1<<2)
-    uint32_t flags;
-    uint32_t size; /* the following payload size */
-    union {
-#define VHOST_USER_VRING_IDX_MASK   (0xff)
-#define VHOST_USER_VRING_NOFD_MASK  (0x1<<8)
-        uint64_t u64;
-        struct vhost_vring_state state;
-        struct vhost_vring_addr addr;
-        VhostUserMemory memory;
-        VhostUserLog log;
-    } payload;
-    int fds[VHOST_MEMORY_MAX_NREGIONS];
-    int fd_num;
-} QEMU_PACKED VhostUserMsg;
-
-#define VHOST_USER_HDR_SIZE offsetof(VhostUserMsg, payload.u64)
-
-/* The version of the protocol we support */
-#define VHOST_USER_VERSION    (0x1)
-
-#define MAX_NR_VIRTQUEUE (8)
-
-typedef struct VubrDevRegion {
-    /* Guest Physical address. */
-    uint64_t gpa;
-    /* Memory region size. */
-    uint64_t size;
-    /* QEMU virtual address (userspace). */
-    uint64_t qva;
-    /* Starting offset in our mmaped space. */
-    uint64_t mmap_offset;
-    /* Start address of mmaped space. */
-    uint64_t mmap_addr;
-} VubrDevRegion;
-
-typedef struct VubrDev {
-    int sock;
-    Dispatcher dispatcher;
-    uint32_t nregions;
-    VubrDevRegion regions[VHOST_MEMORY_MAX_NREGIONS];
-    VubrVirtq vq[MAX_NR_VIRTQUEUE];
-    int log_call_fd;
-    uint64_t log_size;
-    uint8_t *log_table;
-    int backend_udp_sock;
-    struct sockaddr_in backend_udp_dest;
-    int ready;
-    uint64_t features;
-    int hdrlen;
-} VubrDev;
-
-static const char *vubr_request_str[] =3D {
-    [VHOST_USER_NONE]                   =3D  "VHOST_USER_NONE",
-    [VHOST_USER_GET_FEATURES]           =3D  "VHOST_USER_GET_FEATURES",
-    [VHOST_USER_SET_FEATURES]           =3D  "VHOST_USER_SET_FEATURES",
-    [VHOST_USER_SET_OWNER]              =3D  "VHOST_USER_SET_OWNER",
-    [VHOST_USER_RESET_OWNER]           =3D  "VHOST_USER_RESET_OWNER",
-    [VHOST_USER_SET_MEM_TABLE]          =3D  "VHOST_USER_SET_MEM_TABLE",
-    [VHOST_USER_SET_LOG_BASE]           =3D  "VHOST_USER_SET_LOG_BASE",
-    [VHOST_USER_SET_LOG_FD]             =3D  "VHOST_USER_SET_LOG_FD",
-    [VHOST_USER_SET_VRING_NUM]          =3D  "VHOST_USER_SET_VRING_NUM",
-    [VHOST_USER_SET_VRING_ADDR]         =3D  "VHOST_USER_SET_VRING_ADDR"=
,
-    [VHOST_USER_SET_VRING_BASE]         =3D  "VHOST_USER_SET_VRING_BASE"=
,
-    [VHOST_USER_GET_VRING_BASE]         =3D  "VHOST_USER_GET_VRING_BASE"=
,
-    [VHOST_USER_SET_VRING_KICK]         =3D  "VHOST_USER_SET_VRING_KICK"=
,
-    [VHOST_USER_SET_VRING_CALL]         =3D  "VHOST_USER_SET_VRING_CALL"=
,
-    [VHOST_USER_SET_VRING_ERR]          =3D  "VHOST_USER_SET_VRING_ERR",
-    [VHOST_USER_GET_PROTOCOL_FEATURES]  =3D  "VHOST_USER_GET_PROTOCOL_FE=
ATURES",
-    [VHOST_USER_SET_PROTOCOL_FEATURES]  =3D  "VHOST_USER_SET_PROTOCOL_FE=
ATURES",
-    [VHOST_USER_GET_QUEUE_NUM]          =3D  "VHOST_USER_GET_QUEUE_NUM",
-    [VHOST_USER_SET_VRING_ENABLE]       =3D  "VHOST_USER_SET_VRING_ENABL=
E",
-    [VHOST_USER_SEND_RARP]              =3D  "VHOST_USER_SEND_RARP",
-    [VHOST_USER_MAX]                    =3D  "VHOST_USER_MAX",
-};
-
 static void
-print_buffer(uint8_t *buf, size_t len)
+vubr_handle_tx(VuDev *dev, int qidx)
 {
-    int i;
-    printf("Raw buffer:\n");
-    for (i =3D 0; i < len; i++) {
-        if (i % 16 =3D=3D 0) {
-            printf("\n");
-        }
-        if (i % 4 =3D=3D 0) {
-            printf("   ");
-        }
-        printf("%02x ", buf[i]);
-    }
-    printf("\n..........................................................=
..\n");
-}
+    VuVirtq *vq =3D vu_get_queue(dev, qidx);
+    VubrDev *vubr =3D container_of(dev, VubrDev, vudev);
+    int hdrlen =3D vubr->hdrlen;
+    VuVirtqElement *elem =3D NULL;
=20
-/* Translate guest physical address to our virtual address.  */
-static uint64_t
-gpa_to_va(VubrDev *dev, uint64_t guest_addr)
-{
-    int i;
-
-    /* Find matching memory region.  */
-    for (i =3D 0; i < dev->nregions; i++) {
-        VubrDevRegion *r =3D &dev->regions[i];
-
-        if ((guest_addr >=3D r->gpa) && (guest_addr < (r->gpa + r->size)=
)) {
-            return guest_addr - r->gpa + r->mmap_addr + r->mmap_offset;
-        }
-    }
-
-    assert(!"address not found in regions");
-    return 0;
-}
-
-/* Translate qemu virtual address to our virtual address.  */
-static uint64_t
-qva_to_va(VubrDev *dev, uint64_t qemu_addr)
-{
-    int i;
+    assert(qidx % 2);
=20
-    /* Find matching memory region.  */
-    for (i =3D 0; i < dev->nregions; i++) {
-        VubrDevRegion *r =3D &dev->regions[i];
+    for (;;) {
+        ssize_t ret;
+        unsigned int out_num;
+        struct iovec sg[VIRTQUEUE_MAX_SIZE], *out_sg;
=20
-        if ((qemu_addr >=3D r->qva) && (qemu_addr < (r->qva + r->size)))=
 {
-            return qemu_addr - r->qva + r->mmap_addr + r->mmap_offset;
+        elem =3D vu_queue_pop(dev, vq, sizeof(VuVirtqElement));
+        if (!elem) {
+            break;
         }
-    }
-
-    assert(!"address not found in regions");
-    return 0;
-}
=20
-static void
-vubr_message_read(int conn_fd, VhostUserMsg *vmsg)
-{
-    char control[CMSG_SPACE(VHOST_MEMORY_MAX_NREGIONS * sizeof(int))] =3D=
 { };
-    struct iovec iov =3D {
-        .iov_base =3D (char *)vmsg,
-        .iov_len =3D VHOST_USER_HDR_SIZE,
-    };
-    struct msghdr msg =3D {
-        .msg_iov =3D &iov,
-        .msg_iovlen =3D 1,
-        .msg_control =3D control,
-        .msg_controllen =3D sizeof(control),
-    };
-    size_t fd_size;
-    struct cmsghdr *cmsg;
-    int rc;
-
-    rc =3D recvmsg(conn_fd, &msg, 0);
-
-    if (rc =3D=3D 0) {
-        fprintf(stderr, "Peer disconnected.\n");
-        exit(1);
-    }
-    if (rc < 0) {
-        vubr_die("recvmsg");
-    }
-
-    vmsg->fd_num =3D 0;
-    for (cmsg =3D CMSG_FIRSTHDR(&msg);
-         cmsg !=3D NULL;
-         cmsg =3D CMSG_NXTHDR(&msg, cmsg))
-    {
-        if (cmsg->cmsg_level =3D=3D SOL_SOCKET && cmsg->cmsg_type =3D=3D=
 SCM_RIGHTS) {
-            fd_size =3D cmsg->cmsg_len - CMSG_LEN(0);
-            vmsg->fd_num =3D fd_size / sizeof(int);
-            memcpy(vmsg->fds, CMSG_DATA(cmsg), fd_size);
+        out_num =3D elem->out_num;
+        out_sg =3D elem->out_sg;
+        if (out_num < 1) {
+            fprintf(stderr, "virtio-net header not in first element\n");
             break;
         }
-    }
-
-    if (vmsg->size > sizeof(vmsg->payload)) {
-        fprintf(stderr,
-                "Error: too big message request: %d, size: vmsg->size: %=
u, "
-                "while sizeof(vmsg->payload) =3D %zu\n",
-                vmsg->request, vmsg->size, sizeof(vmsg->payload));
-        exit(1);
-    }
-
-    if (vmsg->size) {
-        rc =3D read(conn_fd, &vmsg->payload, vmsg->size);
-        if (rc =3D=3D 0) {
-            vubr_die("recvmsg");
-            fprintf(stderr, "Peer disconnected.\n");
-            exit(1);
+        if (VHOST_USER_BRIDGE_DEBUG) {
+            iov_hexdump(out_sg, out_num, stderr, "TX:", 1024);
         }
-        if (rc < 0) {
-            vubr_die("recvmsg");
+
+        if (hdrlen) {
+            unsigned sg_num =3D iov_copy(sg, ARRAY_SIZE(sg),
+                                       out_sg, out_num,
+                                       hdrlen, -1);
+            out_num =3D sg_num;
+            out_sg =3D sg;
         }
=20
-        assert(rc =3D=3D vmsg->size);
-    }
-}
+        struct msghdr msg =3D {
+            .msg_name =3D (struct sockaddr *) &vubr->backend_udp_dest,
+            .msg_namelen =3D sizeof(struct sockaddr_in),
+            .msg_iov =3D out_sg,
+            .msg_iovlen =3D out_num,
+        };
+        do {
+            ret =3D sendmsg(vubr->backend_udp_sock, &msg, 0);
+        } while (ret =3D=3D -1 && (errno =3D=3D EAGAIN || errno =3D=3D E=
INTR));
=20
-static void
-vubr_message_write(int conn_fd, VhostUserMsg *vmsg)
-{
-    int rc;
+        if (ret =3D=3D -1) {
+            vubr_die("sendmsg()");
+        }
=20
-    do {
-        rc =3D write(conn_fd, vmsg, VHOST_USER_HDR_SIZE + vmsg->size);
-    } while (rc < 0 && errno =3D=3D EINTR);
+        vu_queue_push(dev, vq, elem, 0);
+        vu_queue_notify(dev, vq);
=20
-    if (rc < 0) {
-        vubr_die("write");
+        free(elem);
+        elem =3D NULL;
     }
-}
=20
-static void
-vubr_backend_udp_sendbuf(VubrDev *dev, uint8_t *buf, size_t len)
-{
-    int slen =3D sizeof(struct sockaddr_in);
-
-    if (sendto(dev->backend_udp_sock, buf, len, 0,
-               (struct sockaddr *) &dev->backend_udp_dest, slen) =3D=3D =
-1) {
-        vubr_die("sendto()");
-    }
+    free(elem);
 }
=20
-static int
-vubr_backend_udp_recvbuf(VubrDev *dev, uint8_t *buf, size_t buflen)
+static void
+iov_restore_front(struct iovec *front, struct iovec *iov, size_t bytes)
 {
-    int slen =3D sizeof(struct sockaddr_in);
-    int rc;
+    struct iovec *cur;
=20
-    rc =3D recvfrom(dev->backend_udp_sock, buf, buflen, 0,
-                  (struct sockaddr *) &dev->backend_udp_dest,
-                  (socklen_t *)&slen);
-    if (rc =3D=3D -1) {
-        vubr_die("recvfrom()");
+    for (cur =3D front; front !=3D iov; cur++) {
+        bytes -=3D cur->iov_len;
     }
=20
-    return rc;
+    cur->iov_base -=3D bytes;
+    cur->iov_len +=3D bytes;
 }
=20
 static void
-vubr_consume_raw_packet(VubrDev *dev, uint8_t *buf, uint32_t len)
+iov_truncate(struct iovec *iov, unsigned iovc, size_t bytes)
 {
-    int hdrlen =3D dev->hdrlen;
-    DPRINT("    hdrlen =3D %d\n", dev->hdrlen);
+    unsigned i;
=20
-    if (VHOST_USER_BRIDGE_DEBUG) {
-        print_buffer(buf, len);
-    }
-    vubr_backend_udp_sendbuf(dev, buf + hdrlen, len - hdrlen);
-}
+    for (i =3D 0; i < iovc; i++, iov++) {
+        if (bytes < iov->iov_len) {
+            iov->iov_len =3D bytes;
+            return;
+        }
=20
-/* Kick the log_call_fd if required. */
-static void
-vubr_log_kick(VubrDev *dev)
-{
-    if (dev->log_call_fd !=3D -1) {
-        DPRINT("Kicking the QEMU's log...\n");
-        eventfd_write(dev->log_call_fd, 1);
+        bytes -=3D iov->iov_len;
     }
-}
=20
-/* Kick the guest if necessary. */
-static void
-vubr_virtqueue_kick(VubrVirtq *vq)
-{
-    if (!(vq->avail->flags & VRING_AVAIL_F_NO_INTERRUPT)) {
-        DPRINT("Kicking the guest...\n");
-        eventfd_write(vq->call_fd, 1);
-    }
+    assert(!"couldn't truncate iov");
 }
=20
 static void
-vubr_log_page(uint8_t *log_table, uint64_t page)
+vubr_backend_recv_cb(int sock, void *ctx)
 {
-    DPRINT("Logged dirty guest page: %"PRId64"\n", page);
-    atomic_or(&log_table[page / 8], 1 << (page % 8));
-}
+    VubrDev *vubr =3D (VubrDev *) ctx;
+    VuDev *dev =3D &vubr->vudev;
+    VuVirtq *vq =3D vu_get_queue(dev, 0);
+    VuVirtqElement *elem =3D NULL;
+    struct iovec mhdr_sg[VIRTQUEUE_MAX_SIZE];
+    struct virtio_net_hdr_mrg_rxbuf mhdr;
+    unsigned mhdr_cnt =3D 0;
+    int hdrlen =3D vubr->hdrlen;
+    int i =3D 0;
+    struct virtio_net_hdr hdr =3D {
+        .flags =3D 0,
+        .gso_type =3D VIRTIO_NET_HDR_GSO_NONE
+    };
=20
-static void
-vubr_log_write(VubrDev *dev, uint64_t address, uint64_t length)
-{
-    uint64_t page;
+    DPRINT("\n\n   ***   IN UDP RECEIVE CALLBACK    ***\n\n");
+    DPRINT("    hdrlen =3D %d\n", hdrlen);
=20
-    if (!(dev->features & (1ULL << VHOST_F_LOG_ALL)) ||
-        !dev->log_table || !length) {
+    if (!vu_queue_enabled(dev, vq) ||
+        !vu_queue_avail_bytes(dev, vq, hdrlen, 0)) {
+        DPRINT("Got UDP packet, but no available descriptors on RX virtq=
.\n");
         return;
     }
=20
-    assert(dev->log_size > ((address + length - 1) / VHOST_LOG_PAGE / 8)=
);
-
-    page =3D address / VHOST_LOG_PAGE;
-    while (page * VHOST_LOG_PAGE < address + length) {
-        vubr_log_page(dev->log_table, page);
-        page +=3D VHOST_LOG_PAGE;
-    }
-    vubr_log_kick(dev);
-}
-
-static void
-vubr_post_buffer(VubrDev *dev, VubrVirtq *vq, uint8_t *buf, int32_t len)
-{
-    struct vring_desc *desc =3D vq->desc;
-    struct vring_avail *avail =3D vq->avail;
-    struct vring_used *used =3D vq->used;
-    uint64_t log_guest_addr =3D vq->log_guest_addr;
-    int32_t remaining_len =3D len;
-
-    unsigned int size =3D vq->size;
-
-    uint16_t avail_index =3D atomic_mb_read(&avail->idx);
-
-    /* We check the available descriptors before posting the
-     * buffer, so here we assume that enough available
-     * descriptors. */
-    assert(vq->last_avail_index !=3D avail_index);
-    uint16_t a_index =3D vq->last_avail_index % size;
-    uint16_t u_index =3D vq->last_used_index % size;
-    uint16_t d_index =3D avail->ring[a_index];
-
-    int i =3D d_index;
-    uint32_t written_len =3D 0;
-
     do {
-        DPRINT("Post packet to guest on vq:\n");
-        DPRINT("    size             =3D %d\n", vq->size);
-        DPRINT("    last_avail_index =3D %d\n", vq->last_avail_index);
-        DPRINT("    last_used_index  =3D %d\n", vq->last_used_index);
-        DPRINT("    a_index =3D %d\n", a_index);
-        DPRINT("    u_index =3D %d\n", u_index);
-        DPRINT("    d_index =3D %d\n", d_index);
-        DPRINT("    desc[%d].addr    =3D 0x%016"PRIx64"\n", i, desc[i].a=
ddr);
-        DPRINT("    desc[%d].len     =3D %d\n", i, desc[i].len);
-        DPRINT("    desc[%d].flags   =3D %d\n", i, desc[i].flags);
-        DPRINT("    avail->idx =3D %d\n", avail_index);
-        DPRINT("    used->idx  =3D %d\n", used->idx);
-
-        if (!(desc[i].flags & VRING_DESC_F_WRITE)) {
-            /* FIXME: we should find writable descriptor. */
-            fprintf(stderr, "Error: descriptor is not writable. Exiting.=
\n");
-            exit(1);
-        }
-
-        void *chunk_start =3D (void *)(uintptr_t)gpa_to_va(dev, desc[i].=
addr);
-        uint32_t chunk_len =3D desc[i].len;
-        uint32_t chunk_write_len =3D MIN(remaining_len, chunk_len);
+        struct iovec *sg;
+        ssize_t ret, total =3D 0;
+        unsigned int num;
=20
-        memcpy(chunk_start, buf + written_len, chunk_write_len);
-        vubr_log_write(dev, desc[i].addr, chunk_write_len);
-        remaining_len -=3D chunk_write_len;
-        written_len +=3D chunk_write_len;
-
-        if ((remaining_len =3D=3D 0) || !(desc[i].flags & VRING_DESC_F_N=
EXT)) {
+        elem =3D vu_queue_pop(dev, vq, sizeof(VuVirtqElement));
+        if (!elem) {
             break;
         }
=20
-        i =3D desc[i].next;
-    } while (1);
-
-    if (remaining_len > 0) {
-            fprintf(stderr,
-                    "Too long packet for RX, remaining_len =3D %d, Dropp=
ing...\n",
-                    remaining_len);
-            return;
-    }
-
-    /* Add descriptor to the used ring. */
-    used->ring[u_index].id =3D d_index;
-    used->ring[u_index].len =3D len;
-    vubr_log_write(dev,
-                   log_guest_addr + offsetof(struct vring_used, ring[u_i=
ndex]),
-                   sizeof(used->ring[u_index]));
-
-    vq->last_avail_index++;
-    vq->last_used_index++;
-
-    atomic_mb_set(&used->idx, vq->last_used_index);
-    vubr_log_write(dev,
-                   log_guest_addr + offsetof(struct vring_used, idx),
-                   sizeof(used->idx));
-
-    /* Kick the guest if necessary. */
-    vubr_virtqueue_kick(vq);
-}
-
-static int
-vubr_process_desc(VubrDev *dev, VubrVirtq *vq)
-{
-    struct vring_desc *desc =3D vq->desc;
-    struct vring_avail *avail =3D vq->avail;
-    struct vring_used *used =3D vq->used;
-    uint64_t log_guest_addr =3D vq->log_guest_addr;
-
-    unsigned int size =3D vq->size;
-
-    uint16_t a_index =3D vq->last_avail_index % size;
-    uint16_t u_index =3D vq->last_used_index % size;
-    uint16_t d_index =3D avail->ring[a_index];
-
-    uint32_t i, len =3D 0;
-    size_t buf_size =3D 4096;
-    uint8_t buf[4096];
-
-    DPRINT("Chunks: ");
-    i =3D d_index;
-    do {
-        void *chunk_start =3D (void *)(uintptr_t)gpa_to_va(dev, desc[i].=
addr);
-        uint32_t chunk_len =3D desc[i].len;
-
-        assert(!(desc[i].flags & VRING_DESC_F_WRITE));
-
-        if (len + chunk_len < buf_size) {
-            memcpy(buf + len, chunk_start, chunk_len);
-            DPRINT("%d ", chunk_len);
-        } else {
-            fprintf(stderr, "Error: too long packet. Dropping...\n");
+        if (elem->in_num < 1) {
+            fprintf(stderr, "virtio-net contains no in buffers\n");
             break;
         }
=20
-        len +=3D chunk_len;
-
-        if (!(desc[i].flags & VRING_DESC_F_NEXT)) {
-            break;
+        sg =3D elem->in_sg;
+        num =3D elem->in_num;
+        if (i =3D=3D 0) {
+            if (hdrlen =3D=3D 12) {
+                mhdr_cnt =3D iov_copy(mhdr_sg, ARRAY_SIZE(mhdr_sg),
+                                    sg, elem->in_num,
+                                    offsetof(typeof(mhdr), num_buffers),
+                                    sizeof(mhdr.num_buffers));
+            }
+            iov_from_buf(sg, elem->in_num, 0, &hdr, sizeof hdr);
+            total +=3D hdrlen;
+            assert(iov_discard_front(&sg, &num, hdrlen) =3D=3D hdrlen);
         }
=20
-        i =3D desc[i].next;
-    } while (1);
-    DPRINT("\n");
-
-    if (!len) {
-        return -1;
-    }
-
-    /* Add descriptor to the used ring. */
-    used->ring[u_index].id =3D d_index;
-    used->ring[u_index].len =3D len;
-    vubr_log_write(dev,
-                   log_guest_addr + offsetof(struct vring_used, ring[u_i=
ndex]),
-                   sizeof(used->ring[u_index]));
-
-    vubr_consume_raw_packet(dev, buf, len);
-
-    return 0;
-}
+        struct msghdr msg =3D {
+            .msg_name =3D (struct sockaddr *) &vubr->backend_udp_dest,
+            .msg_namelen =3D sizeof(struct sockaddr_in),
+            .msg_iov =3D sg,
+            .msg_iovlen =3D elem->in_num,
+            .msg_flags =3D MSG_DONTWAIT,
+        };
+        do {
+            ret =3D recvmsg(vubr->backend_udp_sock, &msg, 0);
+        } while (ret =3D=3D -1 && (errno =3D=3D EINTR));
=20
-static void
-vubr_process_avail(VubrDev *dev, VubrVirtq *vq)
-{
-    struct vring_avail *avail =3D vq->avail;
-    struct vring_used *used =3D vq->used;
-    uint64_t log_guest_addr =3D vq->log_guest_addr;
-
-    while (vq->last_avail_index !=3D atomic_mb_read(&avail->idx)) {
-        vubr_process_desc(dev, vq);
-        vq->last_avail_index++;
-        vq->last_used_index++;
-    }
+        if (i =3D=3D 0) {
+            iov_restore_front(elem->in_sg, sg, hdrlen);
+        }
=20
-    atomic_mb_set(&used->idx, vq->last_used_index);
-    vubr_log_write(dev,
-                   log_guest_addr + offsetof(struct vring_used, idx),
-                   sizeof(used->idx));
-}
+        if (ret =3D=3D -1) {
+            if (errno =3D=3D EWOULDBLOCK) {
+                vu_queue_rewind(dev, vq, 1);
+                break;
+            }
=20
-static void
-vubr_backend_recv_cb(int sock, void *ctx)
-{
-    VubrDev *dev =3D (VubrDev *) ctx;
-    VubrVirtq *rx_vq =3D &dev->vq[0];
-    uint8_t buf[4096];
-    struct virtio_net_hdr_v1 *hdr =3D (struct virtio_net_hdr_v1 *)buf;
-    int hdrlen =3D dev->hdrlen;
-    int buflen =3D sizeof(buf);
-    int len;
-
-    if (!dev->ready) {
-        return;
-    }
+            vubr_die("recvmsg()");
+        }
=20
-    DPRINT("\n\n   ***   IN UDP RECEIVE CALLBACK    ***\n\n");
-    DPRINT("    hdrlen =3D %d\n", hdrlen);
+        total +=3D ret;
+        iov_truncate(elem->in_sg, elem->in_num, total);
+        vu_queue_fill(dev, vq, elem, total, i++);
=20
-    uint16_t avail_index =3D atomic_mb_read(&rx_vq->avail->idx);
+        free(elem);
+        elem =3D NULL;
+    } while (false); /* could loop if DONTWAIT worked? */
=20
-    /* If there is no available descriptors, just do nothing.
-     * The buffer will be handled by next arrived UDP packet,
-     * or next kick on receive virtq. */
-    if (rx_vq->last_avail_index =3D=3D avail_index) {
-        DPRINT("Got UDP packet, but no available descriptors on RX virtq=
.\n");
-        return;
+    if (mhdr_cnt) {
+        mhdr.num_buffers =3D i;
+        iov_from_buf(mhdr_sg, mhdr_cnt,
+                     0,
+                     &mhdr.num_buffers, sizeof mhdr.num_buffers);
     }
=20
-    memset(buf, 0, hdrlen);
-    /* TODO: support mergeable buffers. */
-    if (hdrlen =3D=3D 12)
-        hdr->num_buffers =3D 1;
-    len =3D vubr_backend_udp_recvbuf(dev, buf + hdrlen, buflen - hdrlen)=
;
+    vu_queue_flush(dev, vq, i);
+    vu_queue_notify(dev, vq);
=20
-    vubr_post_buffer(dev, rx_vq, buf, len + hdrlen);
+    free(elem);
 }
=20
 static void
-vubr_kick_cb(int sock, void *ctx)
+vubr_receive_cb(int sock, void *ctx)
 {
-    VubrDev *dev =3D (VubrDev *) ctx;
-    eventfd_t kick_data;
-    ssize_t rc;
+    VubrDev *vubr =3D (VubrDev *)ctx;
=20
-    rc =3D eventfd_read(sock, &kick_data);
-    if (rc =3D=3D -1) {
-        vubr_die("eventfd_read()");
-    } else {
-        DPRINT("Got kick_data: %016"PRIx64"\n", kick_data);
-        vubr_process_avail(dev, &dev->vq[1]);
+    if (!vu_dispatch(&vubr->vudev)) {
+        fprintf(stderr, "Error while dispatching\n");
     }
 }
=20
-static int
-vubr_none_exec(VubrDev *dev, VhostUserMsg *vmsg)
-{
-    DPRINT("Function %s() not implemented yet.\n", __func__);
-    return 0;
-}
+typedef struct WatchData {
+    VuDev *dev;
+    vu_watch_cb cb;
+    void *data;
+} WatchData;
=20
-static int
-vubr_get_features_exec(VubrDev *dev, VhostUserMsg *vmsg)
+static void
+watch_cb(int sock, void *ctx)
 {
-    vmsg->payload.u64 =3D
-            ((1ULL << VIRTIO_NET_F_MRG_RXBUF) |
-             (1ULL << VHOST_F_LOG_ALL) |
-             (1ULL << VIRTIO_NET_F_GUEST_ANNOUNCE) |
-             (1ULL << VHOST_USER_F_PROTOCOL_FEATURES));
-
-    vmsg->size =3D sizeof(vmsg->payload.u64);
+    struct WatchData *wd =3D ctx;
=20
-    DPRINT("Sending back to guest u64: 0x%016"PRIx64"\n", vmsg->payload.=
u64);
-
-    /* Reply */
-    return 1;
+    wd->cb(wd->dev, VU_WATCH_IN, wd->data);
 }
=20
-static int
-vubr_set_features_exec(VubrDev *dev, VhostUserMsg *vmsg)
+static void
+vubr_set_watch(VuDev *dev, int fd, int condition,
+               vu_watch_cb cb, void *data)
 {
-    DPRINT("u64: 0x%016"PRIx64"\n", vmsg->payload.u64);
-
-    dev->features =3D vmsg->payload.u64;
-    if ((dev->features & (1ULL << VIRTIO_F_VERSION_1)) ||
-        (dev->features & (1ULL << VIRTIO_NET_F_MRG_RXBUF))) {
-        dev->hdrlen =3D 12;
-    } else {
-        dev->hdrlen =3D 10;
-    }
+    VubrDev *vubr =3D container_of(dev, VubrDev, vudev);
+    static WatchData watches[FD_SETSIZE];
+    struct WatchData *wd =3D &watches[fd];
=20
-    return 0;
-}
-
-static int
-vubr_set_owner_exec(VubrDev *dev, VhostUserMsg *vmsg)
-{
-    return 0;
+    wd->cb =3D cb;
+    wd->data =3D data;
+    wd->dev =3D dev;
+    dispatcher_add(&vubr->dispatcher, fd, wd, watch_cb);
 }
=20
 static void
-vubr_close_log(VubrDev *dev)
+vubr_remove_watch(VuDev *dev, int fd)
 {
-    if (dev->log_table) {
-        if (munmap(dev->log_table, dev->log_size) !=3D 0) {
-            vubr_die("munmap()");
-        }
+    VubrDev *vubr =3D container_of(dev, VubrDev, vudev);
=20
-        dev->log_table =3D 0;
-    }
-    if (dev->log_call_fd !=3D -1) {
-        close(dev->log_call_fd);
-        dev->log_call_fd =3D -1;
-    }
-}
-
-static int
-vubr_reset_device_exec(VubrDev *dev, VhostUserMsg *vmsg)
-{
-    vubr_close_log(dev);
-    dev->ready =3D 0;
-    dev->features =3D 0;
-    return 0;
+    dispatcher_remove(&vubr->dispatcher, fd);
 }
=20
 static int
-vubr_set_mem_table_exec(VubrDev *dev, VhostUserMsg *vmsg)
+vubr_send_rarp_exec(VuDev *dev, VhostUserMsg *vmsg)
 {
-    int i;
-    VhostUserMemory *memory =3D &vmsg->payload.memory;
-    dev->nregions =3D memory->nregions;
-
-    DPRINT("Nregions: %d\n", memory->nregions);
-    for (i =3D 0; i < dev->nregions; i++) {
-        void *mmap_addr;
-        VhostUserMemoryRegion *msg_region =3D &memory->regions[i];
-        VubrDevRegion *dev_region =3D &dev->regions[i];
-
-        DPRINT("Region %d\n", i);
-        DPRINT("    guest_phys_addr: 0x%016"PRIx64"\n",
-               msg_region->guest_phys_addr);
-        DPRINT("    memory_size:     0x%016"PRIx64"\n",
-               msg_region->memory_size);
-        DPRINT("    userspace_addr   0x%016"PRIx64"\n",
-               msg_region->userspace_addr);
-        DPRINT("    mmap_offset      0x%016"PRIx64"\n",
-               msg_region->mmap_offset);
-
-        dev_region->gpa =3D msg_region->guest_phys_addr;
-        dev_region->size =3D msg_region->memory_size;
-        dev_region->qva =3D msg_region->userspace_addr;
-        dev_region->mmap_offset =3D msg_region->mmap_offset;
-
-        /* We don't use offset argument of mmap() since the
-         * mapped address has to be page aligned, and we use huge
-         * pages.  */
-        mmap_addr =3D mmap(0, dev_region->size + dev_region->mmap_offset=
,
-                         PROT_READ | PROT_WRITE, MAP_SHARED,
-                         vmsg->fds[i], 0);
-
-        if (mmap_addr =3D=3D MAP_FAILED) {
-            vubr_die("mmap");
-        }
-        dev_region->mmap_addr =3D (uint64_t)(uintptr_t)mmap_addr;
-        DPRINT("    mmap_addr:       0x%016"PRIx64"\n", dev_region->mmap=
_addr);
-
-        close(vmsg->fds[i]);
-    }
-
+    DPRINT("Function %s() not implemented yet.\n", __func__);
     return 0;
 }
=20
 static int
-vubr_set_log_base_exec(VubrDev *dev, VhostUserMsg *vmsg)
+vubr_process_msg(VuDev *dev, VhostUserMsg *vmsg, int *do_reply)
 {
-    int fd;
-    uint64_t log_mmap_size, log_mmap_offset;
-    void *rc;
-
-    assert(vmsg->fd_num =3D=3D 1);
-    fd =3D vmsg->fds[0];
-
-    assert(vmsg->size =3D=3D sizeof(vmsg->payload.log));
-    log_mmap_offset =3D vmsg->payload.log.mmap_offset;
-    log_mmap_size =3D vmsg->payload.log.mmap_size;
-    DPRINT("Log mmap_offset: %"PRId64"\n", log_mmap_offset);
-    DPRINT("Log mmap_size:   %"PRId64"\n", log_mmap_size);
-
-    rc =3D mmap(0, log_mmap_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd=
,
-              log_mmap_offset);
-    if (rc =3D=3D MAP_FAILED) {
-        vubr_die("mmap");
+    switch (vmsg->request) {
+    case VHOST_USER_SEND_RARP:
+        *do_reply =3D vubr_send_rarp_exec(dev, vmsg);
+        return 1;
+    default:
+        /* let the library handle the rest */
+        return 0;
     }
-    dev->log_table =3D rc;
-    dev->log_size =3D log_mmap_size;
=20
-    vmsg->size =3D sizeof(vmsg->payload.u64);
-    /* Reply */
-    return 1;
-}
-
-static int
-vubr_set_log_fd_exec(VubrDev *dev, VhostUserMsg *vmsg)
-{
-    assert(vmsg->fd_num =3D=3D 1);
-    dev->log_call_fd =3D vmsg->fds[0];
-    DPRINT("Got log_call_fd: %d\n", vmsg->fds[0]);
     return 0;
 }
=20
-static int
-vubr_set_vring_num_exec(VubrDev *dev, VhostUserMsg *vmsg)
+static void
+vubr_set_features(VuDev *dev, uint64_t features)
 {
-    unsigned int index =3D vmsg->payload.state.index;
-    unsigned int num =3D vmsg->payload.state.num;
-
-    DPRINT("State.index: %d\n", index);
-    DPRINT("State.num:   %d\n", num);
-    dev->vq[index].size =3D num;
-    return 0;
-}
+    VubrDev *vubr =3D container_of(dev, VubrDev, vudev);
=20
-static int
-vubr_set_vring_addr_exec(VubrDev *dev, VhostUserMsg *vmsg)
-{
-    struct vhost_vring_addr *vra =3D &vmsg->payload.addr;
-    unsigned int index =3D vra->index;
-    VubrVirtq *vq =3D &dev->vq[index];
-
-    DPRINT("vhost_vring_addr:\n");
-    DPRINT("    index:  %d\n", vra->index);
-    DPRINT("    flags:  %d\n", vra->flags);
-    DPRINT("    desc_user_addr:   0x%016llx\n", vra->desc_user_addr);
-    DPRINT("    used_user_addr:   0x%016llx\n", vra->used_user_addr);
-    DPRINT("    avail_user_addr:  0x%016llx\n", vra->avail_user_addr);
-    DPRINT("    log_guest_addr:   0x%016llx\n", vra->log_guest_addr);
-
-    vq->desc =3D (struct vring_desc *)(uintptr_t)qva_to_va(dev, vra->des=
c_user_addr);
-    vq->used =3D (struct vring_used *)(uintptr_t)qva_to_va(dev, vra->use=
d_user_addr);
-    vq->avail =3D (struct vring_avail *)(uintptr_t)qva_to_va(dev, vra->a=
vail_user_addr);
-    vq->log_guest_addr =3D vra->log_guest_addr;
-
-    DPRINT("Setting virtq addresses:\n");
-    DPRINT("    vring_desc  at %p\n", vq->desc);
-    DPRINT("    vring_used  at %p\n", vq->used);
-    DPRINT("    vring_avail at %p\n", vq->avail);
-
-    vq->last_used_index =3D vq->used->idx;
-
-    if (vq->last_avail_index !=3D vq->used->idx) {
-        DPRINT("Last avail index !=3D used index: %d !=3D %d, resuming",
-               vq->last_avail_index, vq->used->idx);
-        vq->last_avail_index =3D vq->used->idx;
+    if ((features & (1ULL << VIRTIO_F_VERSION_1)) ||
+        (features & (1ULL << VIRTIO_NET_F_MRG_RXBUF))) {
+        vubr->hdrlen =3D 12;
+    } else {
+        vubr->hdrlen =3D 10;
     }
-
-    return 0;
 }
=20
-static int
-vubr_set_vring_base_exec(VubrDev *dev, VhostUserMsg *vmsg)
-{
-    unsigned int index =3D vmsg->payload.state.index;
-    unsigned int num =3D vmsg->payload.state.num;
-
-    DPRINT("State.index: %d\n", index);
-    DPRINT("State.num:   %d\n", num);
-    dev->vq[index].last_avail_index =3D num;
-
-    return 0;
-}
-
-static int
-vubr_get_vring_base_exec(VubrDev *dev, VhostUserMsg *vmsg)
-{
-    unsigned int index =3D vmsg->payload.state.index;
-
-    DPRINT("State.index: %d\n", index);
-    vmsg->payload.state.num =3D dev->vq[index].last_avail_index;
-    vmsg->size =3D sizeof(vmsg->payload.state);
-    /* FIXME: this is a work-around for a bug in QEMU enabling
-     * too early vrings. When protocol features are enabled,
-     * we have to respect * VHOST_USER_SET_VRING_ENABLE request. */
-    dev->ready =3D 0;
-
-    if (dev->vq[index].call_fd !=3D -1) {
-        close(dev->vq[index].call_fd);
-        dev->vq[index].call_fd =3D -1;
-    }
-    if (dev->vq[index].kick_fd !=3D -1) {
-        close(dev->vq[index].kick_fd);
-        dispatcher_remove(&dev->dispatcher, dev->vq[index].kick_fd);
-        dev->vq[index].kick_fd =3D -1;
-    }
-
-    /* Reply */
-    return 1;
-}
-
-static int
-vubr_set_vring_kick_exec(VubrDev *dev, VhostUserMsg *vmsg)
+static uint64_t
+vubr_get_features(VuDev *dev)
 {
-    uint64_t u64_arg =3D vmsg->payload.u64;
-    int index =3D u64_arg & VHOST_USER_VRING_IDX_MASK;
-
-    DPRINT("u64: 0x%016"PRIx64"\n", vmsg->payload.u64);
-
-    assert((u64_arg & VHOST_USER_VRING_NOFD_MASK) =3D=3D 0);
-    assert(vmsg->fd_num =3D=3D 1);
-
-    if (dev->vq[index].kick_fd !=3D -1) {
-        close(dev->vq[index].kick_fd);
-        dispatcher_remove(&dev->dispatcher, dev->vq[index].kick_fd);
-    }
-    dev->vq[index].kick_fd =3D vmsg->fds[0];
-    DPRINT("Got kick_fd: %d for vq: %d\n", vmsg->fds[0], index);
-
-    if (index % 2 =3D=3D 1) {
-        /* TX queue. */
-        dispatcher_add(&dev->dispatcher, dev->vq[index].kick_fd,
-                       dev, vubr_kick_cb);
-
-        DPRINT("Waiting for kicks on fd: %d for vq: %d\n",
-               dev->vq[index].kick_fd, index);
-    }
-    /* We temporarily use this hack to determine that both TX and RX
-     * queues are set up and ready for processing.
-     * FIXME: we need to rely in VHOST_USER_SET_VRING_ENABLE and
-     * actual kicks. */
-    if (dev->vq[0].kick_fd !=3D -1 &&
-        dev->vq[1].kick_fd !=3D -1) {
-        dev->ready =3D 1;
-        DPRINT("vhost-user-bridge is ready for processing queues.\n");
-    }
-    return 0;
-
+    return 1ULL << VIRTIO_NET_F_GUEST_ANNOUNCE |
+        1ULL << VIRTIO_NET_F_MRG_RXBUF;
 }
=20
-static int
-vubr_set_vring_call_exec(VubrDev *dev, VhostUserMsg *vmsg)
+static void
+vubr_queue_set_started(VuDev *dev, int qidx, bool started)
 {
-    uint64_t u64_arg =3D vmsg->payload.u64;
-    int index =3D u64_arg & VHOST_USER_VRING_IDX_MASK;
+    VuVirtq *vq =3D vu_get_queue(dev, qidx);
=20
-    DPRINT("u64: 0x%016"PRIx64"\n", vmsg->payload.u64);
-    assert((u64_arg & VHOST_USER_VRING_NOFD_MASK) =3D=3D 0);
-    assert(vmsg->fd_num =3D=3D 1);
-
-    if (dev->vq[index].call_fd !=3D -1) {
-        close(dev->vq[index].call_fd);
+    if (qidx % 2 =3D=3D 1) {
+        vu_set_queue_handler(dev, vq, started ? vubr_handle_tx : NULL);
     }
-    dev->vq[index].call_fd =3D vmsg->fds[0];
-    DPRINT("Got call_fd: %d for vq: %d\n", vmsg->fds[0], index);
-
-    return 0;
-}
-
-static int
-vubr_set_vring_err_exec(VubrDev *dev, VhostUserMsg *vmsg)
-{
-    DPRINT("u64: 0x%016"PRIx64"\n", vmsg->payload.u64);
-    return 0;
-}
-
-static int
-vubr_get_protocol_features_exec(VubrDev *dev, VhostUserMsg *vmsg)
-{
-    vmsg->payload.u64 =3D 1ULL << VHOST_USER_PROTOCOL_F_LOG_SHMFD;
-    DPRINT("u64: 0x%016"PRIx64"\n", vmsg->payload.u64);
-    vmsg->size =3D sizeof(vmsg->payload.u64);
-
-    /* Reply */
-    return 1;
 }
=20
-static int
-vubr_set_protocol_features_exec(VubrDev *dev, VhostUserMsg *vmsg)
-{
-    /* FIXME: unimplented */
-    DPRINT("u64: 0x%016"PRIx64"\n", vmsg->payload.u64);
-    return 0;
-}
-
-static int
-vubr_get_queue_num_exec(VubrDev *dev, VhostUserMsg *vmsg)
-{
-    DPRINT("Function %s() not implemented yet.\n", __func__);
-    return 0;
-}
-
-static int
-vubr_set_vring_enable_exec(VubrDev *dev, VhostUserMsg *vmsg)
+static void
+vubr_panic(VuDev *dev, const char *msg)
 {
-    unsigned int index =3D vmsg->payload.state.index;
-    unsigned int enable =3D vmsg->payload.state.num;
+    VubrDev *vubr =3D container_of(dev, VubrDev, vudev);
=20
-    DPRINT("State.index: %d\n", index);
-    DPRINT("State.enable:   %d\n", enable);
-    dev->vq[index].enable =3D enable;
-    return 0;
-}
+    fprintf(stderr, "PANIC: %s\n", msg);
=20
-static int
-vubr_send_rarp_exec(VubrDev *dev, VhostUserMsg *vmsg)
-{
-    DPRINT("Function %s() not implemented yet.\n", __func__);
-    return 0;
+    dispatcher_remove(&vubr->dispatcher, dev->sock);
+    vubr->quit =3D 1;
 }
=20
-static int
-vubr_execute_request(VubrDev *dev, VhostUserMsg *vmsg)
-{
-    /* Print out generic part of the request. */
-    DPRINT(
-           "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   Vho=
st user message from QEMU   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D\n");
-    DPRINT("Request: %s (%d)\n", vubr_request_str[vmsg->request],
-           vmsg->request);
-    DPRINT("Flags:   0x%x\n", vmsg->flags);
-    DPRINT("Size:    %d\n", vmsg->size);
-
-    if (vmsg->fd_num) {
-        int i;
-        DPRINT("Fds:");
-        for (i =3D 0; i < vmsg->fd_num; i++) {
-            DPRINT(" %d", vmsg->fds[i]);
-        }
-        DPRINT("\n");
-    }
-
-    switch (vmsg->request) {
-    case VHOST_USER_NONE:
-        return vubr_none_exec(dev, vmsg);
-    case VHOST_USER_GET_FEATURES:
-        return vubr_get_features_exec(dev, vmsg);
-    case VHOST_USER_SET_FEATURES:
-        return vubr_set_features_exec(dev, vmsg);
-    case VHOST_USER_SET_OWNER:
-        return vubr_set_owner_exec(dev, vmsg);
-    case VHOST_USER_RESET_OWNER:
-        return vubr_reset_device_exec(dev, vmsg);
-    case VHOST_USER_SET_MEM_TABLE:
-        return vubr_set_mem_table_exec(dev, vmsg);
-    case VHOST_USER_SET_LOG_BASE:
-        return vubr_set_log_base_exec(dev, vmsg);
-    case VHOST_USER_SET_LOG_FD:
-        return vubr_set_log_fd_exec(dev, vmsg);
-    case VHOST_USER_SET_VRING_NUM:
-        return vubr_set_vring_num_exec(dev, vmsg);
-    case VHOST_USER_SET_VRING_ADDR:
-        return vubr_set_vring_addr_exec(dev, vmsg);
-    case VHOST_USER_SET_VRING_BASE:
-        return vubr_set_vring_base_exec(dev, vmsg);
-    case VHOST_USER_GET_VRING_BASE:
-        return vubr_get_vring_base_exec(dev, vmsg);
-    case VHOST_USER_SET_VRING_KICK:
-        return vubr_set_vring_kick_exec(dev, vmsg);
-    case VHOST_USER_SET_VRING_CALL:
-        return vubr_set_vring_call_exec(dev, vmsg);
-    case VHOST_USER_SET_VRING_ERR:
-        return vubr_set_vring_err_exec(dev, vmsg);
-    case VHOST_USER_GET_PROTOCOL_FEATURES:
-        return vubr_get_protocol_features_exec(dev, vmsg);
-    case VHOST_USER_SET_PROTOCOL_FEATURES:
-        return vubr_set_protocol_features_exec(dev, vmsg);
-    case VHOST_USER_GET_QUEUE_NUM:
-        return vubr_get_queue_num_exec(dev, vmsg);
-    case VHOST_USER_SET_VRING_ENABLE:
-        return vubr_set_vring_enable_exec(dev, vmsg);
-    case VHOST_USER_SEND_RARP:
-        return vubr_send_rarp_exec(dev, vmsg);
-
-    case VHOST_USER_MAX:
-        assert(vmsg->request !=3D VHOST_USER_MAX);
-    }
-    return 0;
-}
-
-static void
-vubr_receive_cb(int sock, void *ctx)
-{
-    VubrDev *dev =3D (VubrDev *) ctx;
-    VhostUserMsg vmsg;
-    int reply_requested;
-
-    vubr_message_read(sock, &vmsg);
-    reply_requested =3D vubr_execute_request(dev, &vmsg);
-    if (reply_requested) {
-        /* Set the version in the flags when sending the reply */
-        vmsg.flags &=3D ~VHOST_USER_VERSION_MASK;
-        vmsg.flags |=3D VHOST_USER_VERSION;
-        vmsg.flags |=3D VHOST_USER_REPLY_MASK;
-        vubr_message_write(sock, &vmsg);
-    }
-}
+static const VuDevIface vuiface =3D {
+    .get_features =3D vubr_get_features,
+    .set_features =3D vubr_set_features,
+    .process_msg =3D vubr_process_msg,
+    .queue_set_started =3D vubr_queue_set_started,
+};
=20
 static void
 vubr_accept_cb(int sock, void *ctx)
@@ -1199,6 +479,14 @@ vubr_accept_cb(int sock, void *ctx)
         vubr_die("accept()");
     }
     DPRINT("Got connection from remote peer on sock %d\n", conn_fd);
+
+    vu_init(&dev->vudev,
+            conn_fd,
+            vubr_panic,
+            vubr_set_watch,
+            vubr_remove_watch,
+            &vuiface);
+
     dispatcher_add(&dev->dispatcher, conn_fd, ctx, vubr_receive_cb);
     dispatcher_remove(&dev->dispatcher, sock);
 }
@@ -1207,29 +495,10 @@ static VubrDev *
 vubr_new(const char *path, bool client)
 {
     VubrDev *dev =3D (VubrDev *) calloc(1, sizeof(VubrDev));
-    dev->nregions =3D 0;
-    int i;
     struct sockaddr_un un;
     CallbackFunc cb;
     size_t len;
=20
-    for (i =3D 0; i < MAX_NR_VIRTQUEUE; i++) {
-        dev->vq[i] =3D (VubrVirtq) {
-            .call_fd =3D -1, .kick_fd =3D -1,
-            .size =3D 0,
-            .last_avail_index =3D 0, .last_used_index =3D 0,
-            .desc =3D 0, .avail =3D 0, .used =3D 0,
-            .enable =3D 0,
-        };
-    }
-
-    /* Init log */
-    dev->log_call_fd =3D -1;
-    dev->log_size =3D 0;
-    dev->log_table =3D 0;
-    dev->ready =3D 0;
-    dev->features =3D 0;
-
     /* Get a UNIX socket. */
     dev->sock =3D socket(AF_UNIX, SOCK_STREAM, 0);
     if (dev->sock =3D=3D -1) {
@@ -1257,10 +526,17 @@ vubr_new(const char *path, bool client)
         if (connect(dev->sock, (struct sockaddr *)&un, len) =3D=3D -1) {
             vubr_die("connect");
         }
+        vu_init(&dev->vudev,
+                dev->sock,
+                vubr_panic,
+                vubr_set_watch,
+                vubr_remove_watch,
+                &vuiface);
         cb =3D vubr_receive_cb;
     }
=20
     dispatcher_init(&dev->dispatcher);
+
     dispatcher_add(&dev->dispatcher, dev->sock, (void *)dev, cb);
=20
     return dev;
@@ -1341,7 +617,7 @@ vubr_backend_udp_setup(VubrDev *dev,
 static void
 vubr_run(VubrDev *dev)
 {
-    while (1) {
+    while (!dev->quit) {
         /* timeout 200ms */
         dispatcher_wait(&dev->dispatcher, 200000);
         /* Here one can try polling strategy. */
@@ -1417,6 +693,9 @@ main(int argc, char *argv[])
=20
     vubr_backend_udp_setup(dev, lhost, lport, rhost, rport);
     vubr_run(dev);
+
+    vu_deinit(&dev->vudev);
+
     return 0;
=20
 out:
diff --git a/tests/Makefile.include b/tests/Makefile.include
index e98d3b6..6554ef8 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -687,7 +687,7 @@ tests/test-filter-mirror$(EXESUF): tests/test-filter-=
mirror.o $(qtest-obj-y)
 tests/test-filter-redirector$(EXESUF): tests/test-filter-redirector.o $(=
qtest-obj-y)
 tests/test-x86-cpuid-compat$(EXESUF): tests/test-x86-cpuid-compat.o $(qt=
est-obj-y)
 tests/ivshmem-test$(EXESUF): tests/ivshmem-test.o contrib/ivshmem-server=
/ivshmem-server.o $(libqos-pc-obj-y)
-tests/vhost-user-bridge$(EXESUF): tests/vhost-user-bridge.o
+tests/vhost-user-bridge$(EXESUF): tests/vhost-user-bridge.o contrib/libv=
host-user/libvhost-user.o $(test-util-obj-y)
 tests/test-uuid$(EXESUF): tests/test-uuid.o $(test-util-obj-y)
 tests/test-arm-mptimer$(EXESUF): tests/test-arm-mptimer.o
=20
--=20
MST
