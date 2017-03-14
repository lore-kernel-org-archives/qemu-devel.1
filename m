Received: from eggs.gnu.org ([2001:4830:134:3::10]:36646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cnp9d-0003SB-Pd
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:18:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cnp9c-0006bY-Qp
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:18:33 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:35653)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cnp9c-0006b0-KV
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:18:32 -0400
Received: by mail-wm0-x243.google.com with SMTP id z63so594445wmg.2
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 09:18:32 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 14 Mar 2017 17:18:09 +0100
Message-Id: <1489508300-48184-8-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1489508300-48184-1-git-send-email-pbonzini@redhat.com>
References: <1489508300-48184-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/18] scripts/dump-guest-memory.py: fix
 int128_get64 on recent gcc
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

The Int128 is no longer a struct, reaching a python exception:
Python Exception <class 'gdb.error'> Attempt to extract a component of a value that is not a (null).:

Replace struct access with a cast to uint64[] instead.

Fixes:
https://bugzilla.redhat.com/show_bug.cgi?id=1427466

Signed-off-by: Marc-AndrÃ© Lureau <marcandre.lureau@redhat.com>
Message-Id: <20170310112819.16760-1-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/dump-guest-memory.py | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/scripts/dump-guest-memory.py b/scripts/dump-guest-memory.py
index 9956fc0..f7c6635 100644
--- a/scripts/dump-guest-memory.py
+++ b/scripts/dump-guest-memory.py
@@ -314,8 +314,18 @@ def get_arch_phdr(endianness, elfclass):
 def int128_get64(val):
     """Returns low 64bit part of Int128 struct."""
 
-    assert val["hi"] == 0
-    return val["lo"]
+    try:
+        assert val["hi"] == 0
+        return val["lo"]
+    except gdb.error:
+        u64t = gdb.lookup_type('uint64_t').array(2)
+        u64 = val.cast(u64t)
+        if sys.byteorder == 'little':
+            assert u64[1] == 0
+            return u64[0]
+        else:
+            assert u64[0] == 0
+            return u64[1]
 
 
 def qlist_foreach(head, field_str):
-- 
1.8.3.1
