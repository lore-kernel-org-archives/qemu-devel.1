Received: from eggs.gnu.org ([2001:4830:134:3::10]:50700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1dFcRK-0006VE-6w
	for qemu-devel@nongnu.org; Tue, 30 May 2017 04:23:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1dFcRI-0001Pt-Qx
	for qemu-devel@nongnu.org; Tue, 30 May 2017 04:23:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1dFcRI-0001P4-IZ
	for qemu-devel@nongnu.org; Tue, 30 May 2017 04:23:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9F1B78123E
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 08:23:39 +0000 (UTC)
Received: from moe.brq.redhat.com (dhcp129-131.brq.redhat.com [10.34.129.131])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 23D4C17151
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 08:23:38 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
Date: Tue, 30 May 2017 10:23:35 +0200
Message-Id: <f8c84196122adc32f9067680e54a9de32a571756.1496132443.git.mprivozn@redhat.com>
In-Reply-To: <cover.1496132443.git.mprivozn@redhat.com>
References: <cover.1496132443.git.mprivozn@redhat.com>
In-Reply-To: <cover.1496132443.git.mprivozn@redhat.com>
References: <cover.1496132443.git.mprivozn@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] qemu-bridge-helper: Take ACL file gid into
 account
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

There's a problem with the way we currently parse ACL files. The
problem is, the bridge helper has usually SUID flag set and thus
runs as root in which case all the ACL files are parsed
(/etc/qemu/bridge.conf and all other files it includes).
Therefore, if there's say bob.conf owned by root:bob and I run
the bridge helper, it doesn't really matter whether I'm in the
bob group or not. Everything that is allowed to bob group is
allowed to me too.

The way this problem is fixed is whenever an ACL file is parsed,
the group owner of the file is stored among with the rules so
that it can be compared when evaluating.

There is one exception though. If an ACL file is owned by root
group the rules within apply to all groups. This is because
that's the usual setup currently (the bridge.conf is usually
owned by root:root) and anybody from root group can plug the
interface themselves anyway.

This idea of groups was introduced in bdef79a2994d6f0383 but got
broken by ditros setting SUID onto the binary.

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
---
 qemu-bridge-helper.c | 44 ++++++++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/qemu-bridge-helper.c b/qemu-bridge-helper.c
index a7f9bf06cc..eab9ad5096 100644
--- a/qemu-bridge-helper.c
+++ b/qemu-bridge-helper.c
@@ -48,6 +48,7 @@ enum {
 
 typedef struct ACLRule {
     int type;
+    gid_t group;
     char iface[IFNAMSIZ];
     QSIMPLEQ_ENTRY(ACLRule) entry;
 } ACLRule;
@@ -65,8 +66,13 @@ static int parse_acl_file(const char *filename, ACLList *acl_list)
     FILE *f;
     char line[4096];
     ACLRule *acl_rule;
+    struct stat stbuf;
     int ret = -1;
 
+    if (stat(filename, &stbuf) < 0) {
+        return -1;
+    }
+
     f = fopen(filename, "r");
     if (f == NULL) {
         return -1;
@@ -117,6 +123,7 @@ static int parse_acl_file(const char *filename, ACLList *acl_list)
                 acl_rule->type = ACL_DENY;
                 snprintf(acl_rule->iface, IFNAMSIZ, "%s", arg);
             }
+            acl_rule->group = stbuf.st_gid;
             QSIMPLEQ_INSERT_TAIL(acl_list, acl_rule, entry);
         } else if (strcmp(cmd, "allow") == 0) {
             acl_rule = g_malloc(sizeof(*acl_rule));
@@ -126,6 +133,7 @@ static int parse_acl_file(const char *filename, ACLList *acl_list)
                 acl_rule->type = ACL_ALLOW;
                 snprintf(acl_rule->iface, IFNAMSIZ, "%s", arg);
             }
+            acl_rule->group = stbuf.st_gid;
             QSIMPLEQ_INSERT_TAIL(acl_list, acl_rule, entry);
         } else if (strcmp(cmd, "include") == 0) {
             /* ignore errors */
@@ -229,6 +237,7 @@ int main(int argc, char **argv)
     ACLRule *acl_rule;
     ACLList acl_list;
     int access_allowed, access_denied;
+    gid_t group;
     int rv, ret = EXIT_FAILURE;
 
 #ifdef CONFIG_LIBCAP
@@ -275,24 +284,31 @@ int main(int argc, char **argv)
      */
     access_allowed = 0;
     access_denied = 0;
+    group = getgid();
     QSIMPLEQ_FOREACH(acl_rule, &acl_list, entry) {
-        switch (acl_rule->type) {
-        case ACL_ALLOW_ALL:
-            access_allowed = 1;
-            break;
-        case ACL_ALLOW:
-            if (strcmp(bridge, acl_rule->iface) == 0) {
+        /* If the acl policy file is owned by root group it
+         * applies to all groups. Otherwise it applies to that
+         * specific group. */
+        if (!acl_rule->group ||
+            (acl_rule->group && acl_rule->group == group)) {
+            switch (acl_rule->type) {
+            case ACL_ALLOW_ALL:
                 access_allowed = 1;
-            }
-            break;
-        case ACL_DENY_ALL:
-            access_denied = 1;
-            break;
-        case ACL_DENY:
-            if (strcmp(bridge, acl_rule->iface) == 0) {
+                break;
+            case ACL_ALLOW:
+                if (strcmp(bridge, acl_rule->iface) == 0) {
+                    access_allowed = 1;
+                }
+                break;
+            case ACL_DENY_ALL:
                 access_denied = 1;
+                break;
+            case ACL_DENY:
+                if (strcmp(bridge, acl_rule->iface) == 0) {
+                    access_denied = 1;
+                }
+                break;
             }
-            break;
         }
     }
 
-- 
2.13.0
