Received: from eggs.gnu.org ([2001:4830:134:3::10]:38635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dgCRG-0006uE-Jt
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 12:05:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dgCRD-0007eS-42
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 12:05:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dgCRC-0007e5-V1
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 12:05:27 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 11 Aug 2017 18:05:21 +0200
Message-Id: <1502467522-32237-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1502467522-32237-1-git-send-email-armbru@redhat.com>
References: <1502467522-32237-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 1/2] vl: Factor object_create() out of main()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: el13635@mail.ntua.gr, kwolf@redhat.com, berrange@redhat.com, eblake@redhat.com, pbonzini@redhat.com, f4bug@amsat.org

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 vl.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/vl.c b/vl.c
index 8e247cc..96c5da1 100644
--- a/vl.c
+++ b/vl.c
@@ -2855,6 +2855,14 @@ static bool object_create_delayed(const char *type=
)
     return !object_create_initial(type);
 }
=20
+static void object_create(bool (*type_predicate)(const char *))
+{
+    if (qemu_opts_foreach(qemu_find_opts("object"),
+                          user_creatable_add_opts_foreach,
+                          type_predicate, NULL)) {
+        exit(1);
+    }
+}
=20
 static void set_memory_options(uint64_t *ram_slots, ram_addr_t *maxram_s=
ize,
                                MachineClass *mc)
@@ -4391,11 +4399,7 @@ int main(int argc, char **argv, char **envp)
     page_size_init();
     socket_init();
=20
-    if (qemu_opts_foreach(qemu_find_opts("object"),
-                          user_creatable_add_opts_foreach,
-                          object_create_initial, NULL)) {
-        exit(1);
-    }
+    object_create(object_create_initial);
=20
     if (qemu_opts_foreach(qemu_find_opts("chardev"),
                           chardev_init_func, NULL, NULL)) {
@@ -4520,11 +4524,7 @@ int main(int argc, char **argv, char **envp)
         exit(1);
     }
=20
-    if (qemu_opts_foreach(qemu_find_opts("object"),
-                          user_creatable_add_opts_foreach,
-                          object_create_delayed, NULL)) {
-        exit(1);
-    }
+    object_create(object_create_delayed);
=20
 #ifdef CONFIG_TPM
     if (tpm_init() < 0) {
--=20
2.7.5
