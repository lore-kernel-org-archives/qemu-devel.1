Received: from eggs.gnu.org ([209.51.188.92]:42416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gxY6m-0006Pu-1a
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 09:16:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gxY6l-0002Lp-3s
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 09:16:52 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:43490)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gxY6k-0002LP-RH
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 09:16:51 -0500
Received: by mail-wr1-x42e.google.com with SMTP id d17so5267676wre.10
	for <qemu-devel@nongnu.org>; Sat, 23 Feb 2019 06:16:50 -0800 (PST)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Sat, 23 Feb 2019 16:16:34 +0200
Message-Id: <20190223141644.6609-2-marcel.apfelbaum@gmail.com>
In-Reply-To: <20190223141644.6609-1-marcel.apfelbaum@gmail.com>
References: <20190223141644.6609-1-marcel.apfelbaum@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH PULL 01/11] contrib/rdmacm-mux: Fix
 out-of-bounds risk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, kamalheib1@gmail.com, philmd@redhat.com, dgilbert@redhat.com

From: Yuval Shaia <yuval.shaia@oracle.com>

The function get_fd extract context from the received MAD message and
uses it as a key to fetch the destination fd from the mapping table.
A context can be dgid in case of CM request message or comm_id in case
of CM SIDR response message.

When MAD message with a smaller size as expected for the message type
received we are hitting out-of-bounds where we are looking for the
context out of message boundaries.

Fix it by validating the message size.

Reported-by Sam Smith <sam.j.smith@oracle.com>
Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Message-Id: <20190212112347.1605-1-yuval.shaia@oracle.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 contrib/rdmacm-mux/main.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/contrib/rdmacm-mux/main.c b/contrib/rdmacm-mux/main.c
index ae88c77a1e..21cc804367 100644
--- a/contrib/rdmacm-mux/main.c
+++ b/contrib/rdmacm-mux/main.c
@@ -300,7 +300,7 @@ static void hash_tbl_remove_fd_ifid_pair(int fd)
     pthread_rwlock_unlock(&server.lock);
 }
 
-static int get_fd(const char *mad, int *fd, __be64 *gid_ifid)
+static int get_fd(const char *mad, int umad_len, int *fd, __be64 *gid_ifid)
 {
     struct umad_hdr *hdr = (struct umad_hdr *)mad;
     char *data = (char *)hdr + sizeof(*hdr);
@@ -308,13 +308,35 @@ static int get_fd(const char *mad, int *fd, __be64 *gid_ifid)
     uint16_t attr_id = be16toh(hdr->attr_id);
     int rc = 0;
 
+    if (umad_len <= sizeof(*hdr)) {
+        rc = -EINVAL;
+        syslog(LOG_DEBUG, "Ignoring MAD packets with header only\n");
+        goto out;
+    }
+
     switch (attr_id) {
     case UMAD_CM_ATTR_REQ:
+        if (unlikely(umad_len < sizeof(*hdr) + CM_REQ_DGID_POS +
+            sizeof(*gid_ifid))) {
+            rc = -EINVAL;
+            syslog(LOG_WARNING,
+                   "Invalid MAD packet size (%d) for attr_id 0x%x\n", umad_len,
+                    attr_id);
+            goto out;
+        }
         memcpy(gid_ifid, data + CM_REQ_DGID_POS, sizeof(*gid_ifid));
         rc = hash_tbl_search_fd_by_ifid(fd, gid_ifid);
         break;
 
     case UMAD_CM_ATTR_SIDR_REQ:
+        if (unlikely(umad_len < sizeof(*hdr) + CM_SIDR_REQ_DGID_POS +
+            sizeof(*gid_ifid))) {
+            rc = -EINVAL;
+            syslog(LOG_WARNING,
+                   "Invalid MAD packet size (%d) for attr_id 0x%x\n", umad_len,
+                    attr_id);
+            goto out;
+        }
         memcpy(gid_ifid, data + CM_SIDR_REQ_DGID_POS, sizeof(*gid_ifid));
         rc = hash_tbl_search_fd_by_ifid(fd, gid_ifid);
         break;
@@ -331,6 +353,13 @@ static int get_fd(const char *mad, int *fd, __be64 *gid_ifid)
         data += sizeof(comm_id);
         /* Fall through */
     case UMAD_CM_ATTR_SIDR_REP:
+        if (unlikely(umad_len < sizeof(*hdr) + sizeof(comm_id))) {
+            rc = -EINVAL;
+            syslog(LOG_WARNING,
+                   "Invalid MAD packet size (%d) for attr_id 0x%x\n", umad_len,
+                   attr_id);
+            goto out;
+        }
         memcpy(&comm_id, data, sizeof(comm_id));
         if (comm_id) {
             rc = hash_tbl_search_fd_by_comm_id(comm_id, fd, gid_ifid);
@@ -344,6 +373,7 @@ static int get_fd(const char *mad, int *fd, __be64 *gid_ifid)
 
     syslog(LOG_DEBUG, "mad_to_vm: %d 0x%x 0x%x\n", *fd, attr_id, comm_id);
 
+out:
     return rc;
 }
 
@@ -372,7 +402,8 @@ static void *umad_recv_thread_func(void *args)
         } while (rc && server.run);
 
         if (server.run) {
-            rc = get_fd(msg.umad.mad, &fd, &msg.hdr.sgid.global.interface_id);
+            rc = get_fd(msg.umad.mad, msg.umad_len, &fd,
+                        &msg.hdr.sgid.global.interface_id);
             if (rc) {
                 continue;
             }
-- 
2.17.1
