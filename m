Received: from eggs.gnu.org ([2001:4830:134:3::10]:49328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dfmWl-0000VT-PP
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 08:25:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dfmWi-0006B2-LG
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 08:25:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dfmWi-00069x-F5
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 08:25:24 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 10 Aug 2017 14:25:20 +0200
Message-Id: <1502367921-17730-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1502367921-17730-1-git-send-email-armbru@redhat.com>
References: <1502367921-17730-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] vl: Factor object_create() out of main()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: el13635@mail.ntua.gr, kwolf@redhat.com, berrange@redhat.com, eblake@redhat.com, pbonzini@redhat.com

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 vl.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/vl.c b/vl.c
index 8e247cc..fd98ed1 100644
--- a/vl.c
+++ b/vl.c
@@ -2845,7 +2845,6 @@ static bool object_create_initial(const char *type)
     return true;
 }
 
-
 /*
  * The remainder of object creation happens after the
  * creation of chardev, fsdev, net clients and device data types.
@@ -2855,6 +2854,14 @@ static bool object_create_delayed(const char *type)
     return !object_create_initial(type);
 }
 
+static void object_create(bool (*type_predicate)(const char *))
+{
+    if (qemu_opts_foreach(qemu_find_opts("object"),
+                          user_creatable_add_opts_foreach,
+                          type_predicate, NULL)) {
+        exit(1);
+    }
+}
 
 static void set_memory_options(uint64_t *ram_slots, ram_addr_t *maxram_size,
                                MachineClass *mc)
@@ -4391,11 +4398,7 @@ int main(int argc, char **argv, char **envp)
     page_size_init();
     socket_init();
 
-    if (qemu_opts_foreach(qemu_find_opts("object"),
-                          user_creatable_add_opts_foreach,
-                          object_create_initial, NULL)) {
-        exit(1);
-    }
+    object_create(object_create_initial);
 
     if (qemu_opts_foreach(qemu_find_opts("chardev"),
                           chardev_init_func, NULL, NULL)) {
@@ -4520,11 +4523,7 @@ int main(int argc, char **argv, char **envp)
         exit(1);
     }
 
-    if (qemu_opts_foreach(qemu_find_opts("object"),
-                          user_creatable_add_opts_foreach,
-                          object_create_delayed, NULL)) {
-        exit(1);
-    }
+    object_create(object_create_delayed);
 
 #ifdef CONFIG_TPM
     if (tpm_init() < 0) {
-- 
2.7.5
