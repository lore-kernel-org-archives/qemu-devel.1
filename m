Received: from eggs.gnu.org ([2001:4830:134:3::10]:35112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <krinkin.m.u@gmail.com>) id 1ff7VQ-0001K3-0G
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 13:41:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <krinkin.m.u@gmail.com>) id 1ff7VP-0004vz-B9
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 13:41:52 -0400
From: Mike Krinkin <krinkin.m.u@gmail.com>
Date: Mon, 16 Jul 2018 18:41:46 +0100
Message-Id: <20180716174146.19845-1-krinkin.m.u@gmail.com>
Subject: [Qemu-devel] [PATCH] opts: fix NULL pointer derefernce in
 get_opt_value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, berrange@redhat.com, pbonzini@redhat.com, qemu-trivial@nongnu.org, Mike Krinkin <krinkin.m.u@gmail.com>

The value argument can be NULL, for example, in hw/i386/multiboot.c
in the load_multiboot function get_opt_value is explicitly called
with NULL as the second argument.

The problem was introduced in commit 950c4e6c94b1 ("opts: don't
silently truncate long option values"). This change fixes the
problem by adding a check whether the value is NULL or not.

Signed-off-by: Mike Krinkin <krinkin.m.u@gmail.com>
---
 util/qemu-option.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/util/qemu-option.c b/util/qemu-option.c
index 19761e3eaf..834217fc75 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -75,7 +75,9 @@ const char *get_opt_value(const char *p, char **value)
     size_t capacity = 0, length;
     const char *offset;
 
-    *value = NULL;
+    if (value) {
+        *value = NULL;
+    }
     while (1) {
         offset = qemu_strchrnul(p, ',');
         length = offset - p;
-- 
2.17.1
