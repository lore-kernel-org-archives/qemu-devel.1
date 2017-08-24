Received: from eggs.gnu.org ([2001:4830:134:3::10]:37156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dknmO-0003PP-OM
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:46:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dknmM-0000O6-5i
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:46:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dknmL-0000Mv-T1
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 04:46:18 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 24 Aug 2017 10:46:06 +0200
Message-Id: <1503564371-26090-12-git-send-email-armbru@redhat.com>
In-Reply-To: <1503564371-26090-1-git-send-email-armbru@redhat.com>
References: <1503564371-26090-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 11/16] qapi: Avoid unnecessary use of enum
 lookup table's sentinel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

Currently, the FOO_lookup[] generated for QAPI enum types are
terminated by a NULL sentinel.

A future patch will generate enums with "holes".  NULL-termination
will cease to work then.

To prepare for that, replace "have we reached the sentinel?"
predicates by "have we reached the FOO__MAX value?" predicates.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 monitor.c                          | 4 ++--
 tests/test-qobject-input-visitor.c | 2 +-
 tests/test-string-input-visitor.c  | 2 +-
 ui/input-legacy.c                  | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/monitor.c b/monitor.c
index e0f8801..b45f55d 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3249,7 +3249,7 @@ void netdev_add_completion(ReadLineState *rs, int nb_args, const char *str)
     }
     len = strlen(str);
     readline_set_completion_index(rs, len);
-    for (i = 0; NetClientDriver_lookup[i]; i++) {
+    for (i = 0; i < NET_CLIENT_DRIVER__MAX; i++) {
         add_completion_option(rs, str, NetClientDriver_lookup[i]);
     }
 }
@@ -3537,7 +3537,7 @@ void watchdog_action_completion(ReadLineState *rs, int nb_args, const char *str)
         return;
     }
     readline_set_completion_index(rs, strlen(str));
-    for (i = 0; WatchdogExpirationAction_lookup[i]; i++) {
+    for (i = 0; i < WATCHDOG_EXPIRATION_ACTION__MAX; i++) {
         add_completion_option(rs, str, WatchdogExpirationAction_lookup[i]);
     }
 }
diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-input-visitor.c
index bcf0261..5bbfb65 100644
--- a/tests/test-qobject-input-visitor.c
+++ b/tests/test-qobject-input-visitor.c
@@ -382,7 +382,7 @@ static void test_visitor_in_enum(TestInputVisitorData *data,
     Visitor *v;
     EnumOne i;
 
-    for (i = 0; EnumOne_lookup[i]; i++) {
+    for (i = 0; i < ENUM_ONE__MAX; i++) {
         EnumOne res = -1;
 
         v = visitor_input_test_init(data, "%s", EnumOne_lookup[i]);
diff --git a/tests/test-string-input-visitor.c b/tests/test-string-input-visitor.c
index 79313a7..e7a7b80 100644
--- a/tests/test-string-input-visitor.c
+++ b/tests/test-string-input-visitor.c
@@ -279,7 +279,7 @@ static void test_visitor_in_enum(TestInputVisitorData *data,
     Visitor *v;
     EnumOne i;
 
-    for (i = 0; EnumOne_lookup[i]; i++) {
+    for (i = 0; i < ENUM_ONE__MAX; i++) {
         EnumOne res = -1;
 
         v = visitor_input_test_init(data, EnumOne_lookup[i]);
diff --git a/ui/input-legacy.c b/ui/input-legacy.c
index 7159747..a5f1e82 100644
--- a/ui/input-legacy.c
+++ b/ui/input-legacy.c
@@ -61,7 +61,7 @@ int index_from_key(const char *key, size_t key_length)
 {
     int i;
 
-    for (i = 0; QKeyCode_lookup[i] != NULL; i++) {
+    for (i = 0; i < Q_KEY_CODE__MAX; i++) {
         if (!strncmp(key, QKeyCode_lookup[i], key_length) &&
             !QKeyCode_lookup[i][key_length]) {
             break;
-- 
2.7.5
