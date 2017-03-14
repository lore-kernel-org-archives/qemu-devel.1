Received: from eggs.gnu.org ([2001:4830:134:3::10]:45166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <roman.penyaev@profitbricks.com>) id 1cnjO2-0006xb-EU
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 06:09:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <roman.penyaev@profitbricks.com>) id 1cnjNy-0007Vh-Cc
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 06:09:02 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:34368)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <roman.penyaev@profitbricks.com>)
	id 1cnjNy-0007Ug-5G
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 06:08:58 -0400
Received: by mail-wr0-x229.google.com with SMTP id l37so120572232wrc.1
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 03:08:57 -0700 (PDT)
From: Roman Pen <roman.penyaev@profitbricks.com>
Date: Tue, 14 Mar 2017 11:08:38 +0100
Message-Id: <20170314100838.12647-2-roman.penyaev@profitbricks.com>
In-Reply-To: <20170314100838.12647-1-roman.penyaev@profitbricks.com>
References: <20170314100838.12647-1-roman.penyaev@profitbricks.com>
Subject: [Qemu-devel] [PATCH 1/1] scripts/qemugdb/coroutine.py: get pthread
 pointer from '(gdb) thread info $id' output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Roman Pen <roman.penyaev@profitbricks.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

This is a first step towards coroutines debugging using corefiles.
It is much simpler to follow single path and always parse the line

 * 1    Thread 0x7f4475e33700 (LWP 7806)
               ^^^^^^^^^^^^^^

of a '(gdb) thread info $id' and get pthread pointer instead of rely
on libc debugging information, which is not always the case.

For sure under corefile debugging it is not possible to invoke
any syscalls, like arch_prctl(), so avoid doing that.  That will
simplify the script.

The other problem which is left unsolved for coroutines debugging
using corefiles is gdb restriction to modify registers (that is
only possible for live process, not for a corefile).  This problem
is solved in the next patch for a gdb project itself.

Signed-off-by: Roman Pen <roman.penyaev@profitbricks.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
---
 scripts/qemugdb/coroutine.py | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/scripts/qemugdb/coroutine.py b/scripts/qemugdb/coroutine.py
index ab699794abf6..1cfe3cd97e80 100644
--- a/scripts/qemugdb/coroutine.py
+++ b/scripts/qemugdb/coroutine.py
@@ -14,31 +14,22 @@
 # GNU GPL, version 2 or (at your option) any later version.
 
 import gdb
+import re
 
 VOID_PTR = gdb.lookup_type('void').pointer()
 
-def get_fs_base():
-    '''Fetch %fs base value using arch_prctl(ARCH_GET_FS).  This is
-       pthread_self().'''
-    # %rsp - 120 is scratch space according to the SystemV ABI
-    old = gdb.parse_and_eval('*(uint64_t*)($rsp - 120)')
-    gdb.execute('call arch_prctl(0x1003, $rsp - 120)', False, True)
-    fs_base = gdb.parse_and_eval('*(uint64_t*)($rsp - 120)')
-    gdb.execute('set *(uint64_t*)($rsp - 120) = %s' % old, False, True)
-    return fs_base
-
 def pthread_self():
-    '''Fetch pthread_self() from the glibc start_thread function.'''
-    f = gdb.newest_frame()
-    while f.name() != 'start_thread':
-        f = f.older()
-        if f is None:
-            return get_fs_base()
+    '''Get pthread_self() from '(gdb) info thread $id' output'''
 
+    num = gdb.selected_thread().num
+    thr = gdb.execute('info thread %d' % num, to_string=True)
+    thr = thr.split('\n')[1]
     try:
-        return f.read_var("arg")
-    except ValueError:
-        return get_fs_base()
+        return re.search('Thread ([0-9a-zx]+)', thr).group(1)
+    except:
+        raise ValueError("Unable to find pthread address in 'info thread %d' output.\n"
+                         "Probably version mismatch of libthread_db.so library?" %
+                         num)
 
 def get_glibc_pointer_guard():
     '''Fetch glibc pointer guard value'''
-- 
2.11.0
