Received: from eggs.gnu.org ([2001:4830:134:3::10]:44779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eNGD9-0002zH-H4
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:48:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eNGD5-00060q-Ko
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:48:55 -0500
Received: from 5.mo173.mail-out.ovh.net ([46.105.40.148]:47026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eNGD5-00060B-EG
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 05:48:51 -0500
Received: from player739.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id D05A2924FD
	for <qemu-devel@nongnu.org>; Fri,  8 Dec 2017 11:48:47 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Fri, 08 Dec 2017 11:48:43 +0100
Message-ID: <151273012388.18940.9526309598594671231.stgit@bahia.lan>
In-Reply-To: <151273008711.18940.15284049324681529367.stgit@bahia.lan>
References: <151273008711.18940.15284049324681529367.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 4/5] 9pfs: fix some type definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>, Greg Kurz <groug@kaod.org>

To comply with the QEMU coding style.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/9p.c               |    6 +++---
 hw/9pfs/9p.h               |   12 ++++++------
 hw/9pfs/virtio-9p-device.c |    2 +-
 hw/9pfs/xen-9p-backend.c   |    2 +-
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 52d46632fe15..76f90f2b7863 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -99,10 +99,10 @@ static int omode_to_uflags(int8_t mode)
     return ret;
 }
 
-struct dotl_openflag_map {
+typedef struct DotlOpenflagMap {
     int dotl_flag;
     int open_flag;
-};
+} DotlOpenflagMap;
 
 static int dotl_to_open_flags(int flags)
 {
@@ -113,7 +113,7 @@ static int dotl_to_open_flags(int flags)
      */
     int oflags = flags & O_ACCMODE;
 
-    struct dotl_openflag_map dotl_oflag_map[] = {
+    DotlOpenflagMap dotl_oflag_map[] = {
         { P9_DOTL_CREATE, O_CREAT },
         { P9_DOTL_EXCL, O_EXCL },
         { P9_DOTL_NOCTTY , O_NOCTTY },
diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index cdfc4f4ce787..6e3b48391788 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -94,10 +94,10 @@ enum {
     P9_QTFILE = 0x00,
 };
 
-enum p9_proto_version {
+typedef enum P9ProtoVersion {
     V9FS_PROTO_2000U = 0x01,
     V9FS_PROTO_2000L = 0x02,
-};
+} P9ProtoVersion;
 
 #define P9_NOTAG    UINT16_MAX
 #define P9_NOFID    UINT32_MAX
@@ -118,6 +118,7 @@ static inline char *rpath(FsContext *ctx, const char *path)
 
 typedef struct V9fsPDU V9fsPDU;
 typedef struct V9fsState V9fsState;
+typedef struct V9fsTransport V9fsTransport;
 
 typedef struct {
     uint32_t size_le;
@@ -238,10 +239,10 @@ struct V9fsState
     FileOperations *ops;
     FsContext ctx;
     char *tag;
-    enum p9_proto_version proto_version;
+    P9ProtoVersion proto_version;
     int32_t msize;
     V9fsPDU pdus[MAX_REQ];
-    const struct V9fsTransport *transport;
+    const V9fsTransport *transport;
     /*
      * lock ensuring atomic path update
      * on rename.
@@ -367,8 +368,7 @@ struct V9fsTransport {
     void        (*push_and_notify)(V9fsPDU *pdu);
 };
 
-static inline int v9fs_register_transport(V9fsState *s,
-        const struct V9fsTransport *t)
+static inline int v9fs_register_transport(V9fsState *s, const V9fsTransport *t)
 {
     assert(!s->transport);
     s->transport = t;
diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index c3ae7de3a2d5..43f4e53f336f 100644
--- a/hw/9pfs/virtio-9p-device.c
+++ b/hw/9pfs/virtio-9p-device.c
@@ -184,7 +184,7 @@ static void virtio_init_out_iov_from_pdu(V9fsPDU *pdu, struct iovec **piov,
     *pniov = elem->out_num;
 }
 
-static const struct V9fsTransport virtio_9p_transport = {
+static const V9fsTransport virtio_9p_transport = {
     .pdu_vmarshal = virtio_pdu_vmarshal,
     .pdu_vunmarshal = virtio_pdu_vunmarshal,
     .init_in_iov_from_pdu = virtio_init_in_iov_from_pdu,
diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index ee87f08926a2..df2a4100bf55 100644
--- a/hw/9pfs/xen-9p-backend.c
+++ b/hw/9pfs/xen-9p-backend.c
@@ -233,7 +233,7 @@ static void xen_9pfs_push_and_notify(V9fsPDU *pdu)
     qemu_bh_schedule(ring->bh);
 }
 
-static const struct V9fsTransport xen_9p_transport = {
+static const V9fsTransport xen_9p_transport = {
     .pdu_vmarshal = xen_9pfs_pdu_vmarshal,
     .pdu_vunmarshal = xen_9pfs_pdu_vunmarshal,
     .init_in_iov_from_pdu = xen_9pfs_init_in_iov_from_pdu,
