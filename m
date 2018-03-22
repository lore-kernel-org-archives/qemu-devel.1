Received: from eggs.gnu.org ([2001:4830:134:3::10]:38177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dionbosschieter@gmail.com>) id 1ez3tj-0007iX-Vf
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 13:21:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dionbosschieter@gmail.com>) id 1ez3te-0001cS-Uq
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 13:21:07 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:53715)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dionbosschieter@gmail.com>)
	id 1ez3te-0001aV-GR
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 13:21:02 -0400
Received: by mail-wm0-x241.google.com with SMTP id e194so17318308wmd.3
	for <qemu-devel@nongnu.org>; Thu, 22 Mar 2018 10:21:02 -0700 (PDT)
From: Dion Bosschieter <dionbosschieter@gmail.com>
Date: Thu, 22 Mar 2018 18:20:53 +0100
Message-Id: <20180322172053.7343-1-dionbosschieter@gmail.com>
Subject: [Qemu-devel] [PATCH 1/1] block/file-posix.c: fix not reopened lock
 file descriptor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, Dion Bosschieter <dionbosschieter@gmail.com>

In commit 244a5668106297378391b768e7288eb157616f64 another
file descriptor to BDRVRawState is added. When we try to issue the
reopen command only s->fd is reopened; lock_fd could still hold an old
file descriptor "possibly" pointing to another file.

- change raw_reopen_prepare so it checks use_lock from BDRVRawState and
tries to reopen lock_fd accordingly
- change raw_reopen_commit so it closes the old lock_fd on use_lock

Signed-off-by: Dion Bosschieter <dionbosschieter@gmail.com>
---
 block/file-posix.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index d7fb772c14..16d83fc49e 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -167,6 +167,7 @@ typedef struct BDRVRawState {
 
 typedef struct BDRVRawReopenState {
     int fd;
+    int lock_fd;
     int open_flags;
 } BDRVRawReopenState;
 
@@ -795,6 +796,7 @@ static int raw_reopen_prepare(BDRVReopenState *state,
     raw_parse_flags(state->flags, &rs->open_flags);
 
     rs->fd = -1;
+    rs->lock_fd = -1;
 
     int fcntl_flags = O_APPEND | O_NONBLOCK;
 #ifdef O_NOATIME
@@ -820,6 +822,17 @@ static int raw_reopen_prepare(BDRVReopenState *state,
                 rs->fd = -1;
             }
         }
+
+        if (s->use_lock) {
+            rs->lock_fd = qemu_dup(s->lock_fd);
+            if (rs->lock_fd >= 0) {
+                ret = fcntl_setfl(rs->lock_fd, rs->open_flags);
+                if (ret) {
+                    qemu_close(rs->lock_fd);
+                    rs->lock_fd = -1;
+                }
+            }
+        }
     }
 
     /* If we cannot use fcntl, or fcntl failed, fall back to qemu_open() */
@@ -835,6 +848,14 @@ static int raw_reopen_prepare(BDRVReopenState *state,
                 error_setg_errno(errp, errno, "Could not reopen file");
                 ret = -1;
             }
+
+            if (s->use_lock) {
+                rs->lock_fd = qemu_open(normalized_filename, rs->open_flags);
+                if (rs->lock_fd == -1) {
+                    error_setg_errno(errp, errno, "Could not reopen file for locking");
+                    ret = -1;
+                }
+            }
         }
     }
 
@@ -861,7 +882,11 @@ static void raw_reopen_commit(BDRVReopenState *state)
     s->open_flags = rs->open_flags;
 
     qemu_close(s->fd);
+    if (s->use_lock) {
+        qemu_close(s->lock_fd);
+    }
     s->fd = rs->fd;
+    s->lock_fd = rs->lock_fd;
 
     g_free(state->opaque);
     state->opaque = NULL;
-- 
2.14.2
