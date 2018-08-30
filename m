Received: from eggs.gnu.org ([2001:4830:134:3::10]:33918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1fvOAP-0005zO-8U
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 10:43:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1fvNut-0003eS-8Q
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 10:27:24 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:37706)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1fvNus-0003d4-Ts
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 10:27:23 -0400
Received: by mail-wm0-x242.google.com with SMTP id n11-v6so2227062wmc.2
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 07:27:21 -0700 (PDT)
From: Sameeh Jubran <sameeh@daynix.com>
Date: Thu, 30 Aug 2018 17:27:07 +0300
Message-Id: <20180830142708.14311-6-sameeh@daynix.com>
In-Reply-To: <20180830142708.14311-1-sameeh@daynix.com>
References: <20180830142708.14311-1-sameeh@daynix.com>
Subject: [Qemu-devel] [RFC 5/6] virtio-net: steering mode: Implement rss
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>
Cc: Yan Vugenfirer <yan@daynix.com>

From: Sameeh Jubran <sjubran@redhat.com>

Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
---
 hw/net/virtio-net.c | 122 ++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 105 insertions(+), 17 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index e7c4ce6f66..4a52a6a1d0 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -972,41 +972,129 @@ static int virtio_net_handle_mq(VirtIONet *n, uint8_t cmd,
     return VIRTIO_NET_OK;
 }
 
-static int virtio_net_ctrl_steering_mode(VirtIONet *n, uint8_t cmd,
+
+static int virtio_net_ctrl_sm_rss(VirtIONet *n, uint32_t cmd,
                                 struct iovec *iov, unsigned int iov_cnt,
                                 struct iovec *iov_in, unsigned int iov_cnt_in,
-        size_t *size_in)
+                                size_t *size_in)
+{
+    size_t s;
+    uint32_t supported_hash_function = 0;
+
+    switch (cmd) {
+    case VIRTIO_NET_SM_CTRL_RSS_GET_SUPPORTED_FUNCTIONS:
+        supported_hash_function |= RSS_HASH_FUNCTION_TOEPLITZ;
+        if (!size_in) {
+            return VIRTIO_NET_ERR;
+        }
+        s = iov_from_buf(iov_in, iov_cnt_in, 0,
+        &supported_hash_function,
+        supported_hash_function);
+        if (s != sizeof(n->supported_modes) ||
+        !size_in) {
+            return VIRTIO_NET_ERR;
+        }
+        *size_in = s;
+        break;
+    case VIRTIO_NET_SM_CTRL_RSS_SET:
+        if (!n->rss_conf) {
+            n->rss_conf = g_malloc0(
+                    sizeof(struct virtio_net_rss_conf));
+        } else if (iov == NULL || iov_cnt == 0) {
+            g_free(n->rss_conf->ptrs.hash_key);
+            g_free(n->rss_conf->ptrs.indirection_table);
+            g_free(n->rss_conf);
+            return VIRTIO_NET_OK;
+        }
+        s = iov_to_buf(iov, iov_cnt, 0, n->rss_conf,
+                sizeof(struct virtio_net_rss_conf) -
+                sizeof(struct virtio_net_rss_conf_ptrs));
+
+        if (s != sizeof(struct virtio_net_rss_conf) -
+                sizeof(struct virtio_net_rss_conf_ptrs)) {
+            return VIRTIO_NET_ERR;
+        }
+        n->rss_conf->ptrs.hash_key = g_malloc0(sizeof(uint8_t) *
+                n->rss_conf->hash_key_length);
+        s = iov_to_buf(iov, iov_cnt, 0, n->rss_conf->ptrs.hash_key,
+                sizeof(uint8_t) * n->rss_conf->hash_key_length);
+        if (s != sizeof(uint8_t) * n->rss_conf->hash_key_length) {
+            g_free(n->rss_conf->ptrs.hash_key);
+            return VIRTIO_NET_ERR;
+        }
+        n->rss_conf->ptrs.indirection_table
+            = g_malloc0(sizeof(uint32_t) *
+                    n->rss_conf->indirection_table_length);
+        s = iov_to_buf(iov, iov_cnt, 0,
+                n->rss_conf->ptrs.indirection_table, sizeof(uint32_t) *
+                n->rss_conf->indirection_table_length);
+        if (s != sizeof(uint32_t) *
+                n->rss_conf->indirection_table_length) {
+            g_free(n->rss_conf->ptrs.hash_key);
+            g_free(n->rss_conf->ptrs.indirection_table);
+            return VIRTIO_NET_ERR;
+        }
+        /* do bpf magic */
+        break;
+    default:
+        return VIRTIO_NET_ERR;
+    }
+
+    return VIRTIO_NET_OK;
+}
+
+static int virtio_net_ctrl_steering_mode(VirtIONet *n, uint8_t cmd,
+                                struct iovec *iov, unsigned int iov_cnt,
+                                struct iovec *iov_in, unsigned int iov_in_cnt,
+                                size_t *size_in)
 {
     size_t s;
     struct virtio_net_steering_mode sm;
+    int status = 0;
+    size_t size_in_cmd = 0;
 
     switch (cmd) {
     case VIRTIO_NET_CTRL_SM_GET_SUPPORTED_MODES:
         if (!size_in) {
             return VIRTIO_NET_ERR;
         }
-                  s = iov_from_buf(iov_in, iov_cnt_in, 0,
-          &n->supported_modes, sizeof(n->supported_modes));
+        n->supported_modes.steering_modes |= STEERING_MODE_RSS |
+            STEERING_MODE_AUTO;
+        s = iov_from_buf(iov_in, iov_in_cnt, 0,
+        &n->supported_modes,
+        sizeof(n->supported_modes));
         if (s != sizeof(n->supported_modes) ||
-          !size_in) {
+        !size_in) {
             return VIRTIO_NET_ERR;
         }
-                  *size_in = s;
-      break;
+        *size_in = s;
+         break;
     case VIRTIO_NET_CTRL_SM_CONTROL:
-        s = iov_to_buf(iov, iov_cnt, 0, &sm, sizeof(sm) -
-                sizeof(union command_data));
-        if (s != sizeof(sm) - sizeof(union command_data)) {
+        s = iov_to_buf(iov, iov_cnt, 0, &sm, sizeof(sm));
+        if (s != sizeof(sm)) {
+            return VIRTIO_NET_ERR;
+        }
+        iov_discard_front(&iov, &iov_cnt, sizeof(sm));
+        /* TODO handle the case where we change mode, call the old */
+        /* mode function with null ptrs  should do the trick of */
+        /* freeing any resources */
+        switch (sm.steering_mode) {
+        case STEERING_MODE_AUTO:
+                    break;
+        case STEERING_MODE_RSS:
+            status = virtio_net_ctrl_sm_rss(n, sm.command,
+                   iov, iov_cnt, iov_in, iov_in_cnt,
+                   &size_in_cmd);
+            if (status == VIRTIO_NET_OK && size_in_cmd > 0) {
+                *size_in += size_in_cmd;
+            }
+            break;
+        default:
             return VIRTIO_NET_ERR;
         }
-        /* switch (cmd)
-             {
-                dafault:
-                return VIRTIO_NET_ERR;
-         } */
-      break;
+        break;
     default:
-                return VIRTIO_NET_ERR;
+        return VIRTIO_NET_ERR;
     }
 
     return VIRTIO_NET_OK;
-- 
2.13.6
