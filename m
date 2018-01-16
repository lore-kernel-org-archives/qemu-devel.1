Received: from eggs.gnu.org ([2001:4830:134:3::10]:50278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ebS3x-0002ww-Ih
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:18:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ebS3t-0004aQ-Lo
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:18:05 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:34579)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1ebS3t-0004Zy-GE
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:18:01 -0500
Received: by mail-wr0-x243.google.com with SMTP id 36so15366375wrh.1
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 06:18:01 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 16 Jan 2018 15:16:58 +0100
Message-Id: <1516112253-14480-17-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1516112253-14480-1-git-send-email-pbonzini@redhat.com>
References: <1516112253-14480-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 16/51] vl: fix direct firmware directories leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Note that data_dir[] will now point to allocated strings.

Fixes:
Direct leak of 16 byte(s) in 1 object(s) allocated from:
    #0 0x7f1448181850 in malloc (/lib64/libasan.so.4+0xde850)
    #1 0x7f1446ed8f0c in g_malloc ../glib/gmem.c:94
    #2 0x7f1446ed91cf in g_malloc_n ../glib/gmem.c:331
    #3 0x7f1446ef739a in g_strsplit ../glib/gstrfuncs.c:2364
    #4 0x55cf276439d7 in main /home/elmarco/src/qq/vl.c:4311
    #5 0x7f143dfad039 in __libc_start_main (/lib64/libc.so.6+0x21039)

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180104160523.22995-10-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 vl.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/vl.c b/vl.c
index 444b750..3599485 100644
--- a/vl.c
+++ b/vl.c
@@ -2318,7 +2318,7 @@ static void qemu_add_data_dir(const char *path)
             return; /* duplicate */
         }
     }
-    data_dir[data_dir_idx++] = path;
+    data_dir[data_dir_idx++] = g_strdup(path);
 }
 
 static inline bool nonempty_str(const char *str)
@@ -3078,7 +3078,7 @@ int main(int argc, char **argv, char **envp)
     Error *main_loop_err = NULL;
     Error *err = NULL;
     bool list_data_dirs = false;
-    char **dirs;
+    char *dir, **dirs;
     typedef struct BlockdevOptions_queue {
         BlockdevOptions *bdo;
         Location loc;
@@ -4181,9 +4181,12 @@ int main(int argc, char **argv, char **envp)
     for (i = 0; dirs[i] != NULL; i++) {
         qemu_add_data_dir(dirs[i]);
     }
+    g_strfreev(dirs);
 
     /* try to find datadir relative to the executable path */
-    qemu_add_data_dir(os_find_datadir());
+    dir = os_find_datadir();
+    qemu_add_data_dir(dir);
+    g_free(dir);
 
     /* add the datadir specified when building */
     qemu_add_data_dir(CONFIG_QEMU_DATADIR);
-- 
1.8.3.1
