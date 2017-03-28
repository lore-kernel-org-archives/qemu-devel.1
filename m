Received: from eggs.gnu.org ([2001:4830:134:3::10]:56832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vfeenstr@redhat.com>) id 1cslRl-0008D2-GK
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 03:21:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vfeenstr@redhat.com>) id 1cslRg-0003Xn-H6
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 03:21:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51186)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vfeenstr@redhat.com>) id 1cslRg-0003Xa-8R
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 03:21:36 -0400
From: Vinzenz 'evilissimo' Feenstra <vfeenstr@redhat.com>
Date: Tue, 28 Mar 2017 09:21:30 +0200
Message-Id: <20170328072130.17142-1-vfeenstr@redhat.com>
Subject: [Qemu-devel] [PATCH v1] qga: Add 'guest-get-users' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, Vinzenz Feenstra <vfeenstr@redhat.com>

From: Vinzenz Feenstra <vfeenstr@redhat.com>

A command that will list all currenctly logged in users having running
processes.

Examples:

virsh # qemu-agent-command F25 '{ "execute": "guest-get-users" }'
{"return":[{"user":"root"}]}

virsh # qemu-agent-command Win2k12r2 '{ "execute": "guest-get-users" }'
{"return":[{"domain":"LADIDA","user":"Administrator"}]}

Signed-off-by: Vinzenz Feenstra <vfeenstr@redhat.com>
---
 qga/commands-posix.c | 35 +++++++++++++++++++++++
 qga/commands-win32.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 qga/qapi-schema.json | 21 ++++++++++++++
 3 files changed, 136 insertions(+)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 73d93eb..8cb2094 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -15,6 +15,7 @@
 #include <sys/ioctl.h>
 #include <sys/wait.h>
 #include <dirent.h>
+#include <utmpx.h>
 #include "qga/guest-agent-core.h"
 #include "qga-qmp-commands.h"
 #include "qapi/qmp/qerror.h"
@@ -2515,3 +2516,37 @@ void ga_command_state_init(GAState *s, GACommandState *cs)
     ga_command_state_add(cs, NULL, guest_fsfreeze_cleanup);
 #endif
 }
+
+GuestUserList *qmp_guest_get_users(Error **err)
+{
+    GHashTable *cache = g_hash_table_new_full(g_str_hash, g_str_equal,
+                                              NULL, NULL);
+    GuestUserList *head = NULL, *cur_item = NULL;
+    setutxent();
+    for (;;) {
+        struct utmpx *user_info = getutxent();
+        if (user_info == NULL) {
+            break;
+        } else if (user_info->ut_type != USER_PROCESS) {
+            continue;
+        } else if (g_hash_table_contains(cache, user_info->ut_user)) {
+            continue;
+        }
+
+        g_hash_table_insert(cache, user_info->ut_user, NULL);
+
+        GuestUserList *item = g_new0(GuestUserList, 1);
+        item->value = g_new0(GuestUser, 1);
+        item->value->user = g_strdup(user_info->ut_user);
+
+        if (!cur_item) {
+            head = cur_item = item;
+        } else {
+            cur_item->next = item;
+            cur_item = item;
+        }
+    }
+    endutxent();
+    g_hash_table_unref(cache);
+    return head;
+}
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 19d72b2..46c038b 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -1536,3 +1536,83 @@ void ga_command_state_init(GAState *s, GACommandState *cs)
         ga_command_state_add(cs, NULL, guest_fsfreeze_cleanup);
     }
 }
+
+GuestUserList *qmp_guest_get_users(Error **err)
+{
+    GHashTable *cache = g_hash_table_new_full(g_str_hash, g_str_equal,
+                                              NULL, NULL);
+    GuestUserList *head = NULL, *cur_item = NULL;
+
+    LPWKSTA_USER_INFO_1 buffer = NULL, iter_buffer = 0;
+    DWORD level = 1; /* Level 1 has more information */
+    DWORD prefered_max_length = MAX_PREFERRED_LENGTH;
+    DWORD entries_read = 0;
+    DWORD total_entries = 0;
+    DWORD resume_handle = 0;
+    LPWSTR server_name = NULL;
+    NET_API_STATUS result = ERROR_MORE_DATA;
+
+    while (result == ERROR_MORE_DATA) {
+        result = NetWkstaUserEnum(
+            server_name,
+            level,
+            (LPBYTE *)&buffer,
+            prefered_max_length,
+            &entries_read,
+            &total_entries,
+            &resume_handle);
+
+        if (result != ERROR_MORE_DATA && result != ERROR_SUCCESS) {
+            error_setg_win32(err, result, "Failed to enumerate active users");
+            goto error;
+        }
+
+        iter_buffer = buffer;
+        DWORD i = 0;
+        for (i = 0; i < entries_read; ++i, ++iter_buffer) {
+            gchar *name = g_utf16_to_utf8(
+                iter_buffer->wkui1_username,
+                -1, NULL, NULL, NULL
+            );
+
+            if (name == NULL) {
+                continue;
+            }
+
+            if (g_hash_table_contains(cache, name)) {
+                g_free(name);
+                continue;
+            }
+
+            gchar *domain = g_utf16_to_utf8(
+                iter_buffer->wkui1_logon_domain,
+                -1, NULL, NULL, NULL
+            );
+
+            g_hash_table_insert(cache, name, NULL);
+            GuestUserList *item = g_new0(GuestUserList, 1);
+            item->value = g_new0(GuestUser, 1);
+            item->value->user = name;
+            item->value->domain = domain;
+            item->value->has_domain = true;
+
+            if (!cur_item) {
+                head = cur_item = item;
+            } else {
+                cur_item->next = item;
+                cur_item = item;
+            }
+        }
+    }
+    NetApiBufferFree(buffer);
+    g_hash_table_unref(cache);
+    return head;
+
+error:
+    if (buffer != NULL) {
+        NetApiBufferFree(buffer);
+    }
+    g_hash_table_unref(cache);
+    qapi_free_GuestUserList(head);
+    return NULL;
+}
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index a02dbf2..190e8b4 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1042,3 +1042,24 @@
   'data':    { 'path': 'str', '*arg': ['str'], '*env': ['str'],
                '*input-data': 'str', '*capture-output': 'bool' },
   'returns': 'GuestExec' }
+
+##
+# @GuestUser:
+# @user:      Username
+# @domain:    Logon domain (windows only)
+#
+# Since: 2.10
+##
+{ 'struct': 'GuestUser',
+  'data': { 'user': 'str', '*domain': 'str' } }
+
+##
+# @guest-get-users:
+# Retrieves a list of currently active user accounts on the VM.
+#
+# Returns: A unique list of users.
+#
+# Since: 2.10
+##
+{ 'command': 'guest-get-users',
+  'returns': ['GuestUser'] }
-- 
2.9.3
