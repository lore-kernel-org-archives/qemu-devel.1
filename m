Received: from eggs.gnu.org ([2001:4830:134:3::10]:59247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vfeenstr@redhat.com>) id 1cvHNh-0000mJ-Le
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 01:51:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vfeenstr@redhat.com>) id 1cvHNg-0003GY-0F
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 01:51:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39240)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vfeenstr@redhat.com>) id 1cvHNf-0003G4-Ok
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 01:51:51 -0400
From: Vinzenz 'evilissimo' Feenstra <vfeenstr@redhat.com>
Date: Tue,  4 Apr 2017 07:51:46 +0200
Message-Id: <20170404055146.8901-2-vfeenstr@redhat.com>
In-Reply-To: <20170404055146.8901-1-vfeenstr@redhat.com>
References: <20170404055146.8901-1-vfeenstr@redhat.com>
Subject: [Qemu-devel] [PATCH v3 1/1] qga: Add 'guest-get-users' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@gmail.com, eblake@redhat.com, mdroth@linux.vnet.ibm.com, Vinzenz Feenstra <vfeenstr@redhat.com>

From: Vinzenz Feenstra <vfeenstr@redhat.com>

A command that will list all currently logged in users, and the time
since when they are logged in.

Examples:

virsh # qemu-agent-command F25 '{ "execute": "guest-get-users" }'
{"return":[{"login-time":1490622289.903835,"user":"root"}]}

virsh # qemu-agent-command Win2k12r2 '{ "execute": "guest-get-users" }'
{"return":[{"login-time":1490351044.670552,"domain":"LADIDA",
"user":"Administrator"}]}

Signed-off-by: Vinzenz Feenstra <vfeenstr@redhat.com>
---
 configure             |  2 +-
 include/glib-compat.h |  5 +++
 qga/commands-posix.c  | 54 +++++++++++++++++++++++++++++++
 qga/commands-win32.c  | 89 +++++++++++++++++++++++++++++++++++++++++++++++++++
 qga/qapi-schema.json  | 24 ++++++++++++++
 5 files changed, 173 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index d1ce33b..779ebfd 100755
--- a/configure
+++ b/configure
@@ -737,7 +737,7 @@ if test "$mingw32" = "yes" ; then
   sysconfdir="\${prefix}"
   local_statedir=
   confsuffix=""
-  libs_qga="-lws2_32 -lwinmm -lpowrprof -liphlpapi -lnetapi32 $libs_qga"
+  libs_qga="-lws2_32 -lwinmm -lpowrprof -lwtsapi32 -liphlpapi -lnetapi32 $libs_qga"
 fi
 
 werror=""
diff --git a/include/glib-compat.h b/include/glib-compat.h
index 863c8cf..f8ee9dc 100644
--- a/include/glib-compat.h
+++ b/include/glib-compat.h
@@ -217,6 +217,11 @@ static inline void g_hash_table_add(GHashTable *hash_table, gpointer key)
 {
     g_hash_table_replace(hash_table, key, key);
 }
+
+static gboolean g_hash_table_contains(GHashTable *hash_table, gpointer key)
+{
+    return g_hash_table_lookup_extended(hash_table, key, NULL, NULL);
+}
 #endif
 
 #ifndef g_assert_true
diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 73d93eb..3081ee7 100644
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
@@ -2515,3 +2516,56 @@ void ga_command_state_init(GAState *s, GACommandState *cs)
     ga_command_state_add(cs, NULL, guest_fsfreeze_cleanup);
 #endif
 }
+
+#ifndef QGA_MICRO_SECOND_TO_SECOND
+#   define QGA_MICRO_SECOND_TO_SECOND 1000000
+#endif
+
+static double ga_get_login_time(struct utmpx *user_info)
+{
+    double seconds = (double)user_info->ut_tv.tv_sec;
+    double useconds = (double)user_info->ut_tv.tv_usec;
+    useconds /= QGA_MICRO_SECOND_TO_SECOND;
+    return seconds + useconds;
+}
+
+GuestUserList *qmp_guest_get_users(Error **err)
+{
+    GHashTable *cache = g_hash_table_new(g_str_hash, g_str_equal);
+    GuestUserList *head = NULL, *cur_item = NULL;
+    setutxent();
+    for (;;) {
+        struct utmpx *user_info = getutxent();
+        if (user_info == NULL) {
+            break;
+        } else if (user_info->ut_type != USER_PROCESS) {
+            continue;
+        } else if (g_hash_table_contains(cache, user_info->ut_user)) {
+            gpointer value = g_hash_table_lookup(cache, user_info->ut_user);
+            GuestUser *user = (GuestUser *)value;
+            double login_time = ga_get_login_time(user_info);
+            /* We're ensuring the earliest login time to be sent */
+            if (login_time < user->login_time) {
+                user->login_time = login_time;
+            }
+            continue;
+        }
+
+        GuestUserList *item = g_new0(GuestUserList, 1);
+        item->value = g_new0(GuestUser, 1);
+        item->value->user = g_strdup(user_info->ut_user);
+        item->value->login_time = ga_get_login_time(user_info);
+
+        g_hash_table_insert(cache, item->value->user, item->value);
+
+        if (!cur_item) {
+            head = cur_item = item;
+        } else {
+            cur_item->next = item;
+            cur_item = item;
+        }
+    }
+    endutxent();
+    g_hash_table_destroy(cache);
+    return head;
+}
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 19d72b2..8b84a90 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -11,6 +11,9 @@
  * See the COPYING file in the top-level directory.
  */
 
+#ifndef _WIN32_WINNT
+#   define _WIN32_WINNT 0x0600
+#endif
 #include "qemu/osdep.h"
 #include <wtypes.h>
 #include <powrprof.h>
@@ -25,6 +28,7 @@
 #include <initguid.h>
 #endif
 #include <lm.h>
+#include <wtsapi32.h>
 
 #include "qga/guest-agent-core.h"
 #include "qga/vss-win32.h"
@@ -1536,3 +1540,88 @@ void ga_command_state_init(GAState *s, GACommandState *cs)
         ga_command_state_add(cs, NULL, guest_fsfreeze_cleanup);
     }
 }
+
+/* MINGW is missing two fields: IncomingFrames & OutgoingFrames */
+typedef struct _GA_WTSINFOA {
+    WTS_CONNECTSTATE_CLASS State;
+    DWORD SessionId;
+    DWORD IncomingBytes;
+    DWORD OutgoingBytes;
+    DWORD IncomingFrames;
+    DWORD OutgoingFrames;
+    DWORD IncomingCompressedBytes;
+    DWORD OutgoingCompressedBy;
+    CHAR WinStationName[WINSTATIONNAME_LENGTH];
+    CHAR Domain[DOMAIN_LENGTH];
+    CHAR UserName[USERNAME_LENGTH + 1];
+    LARGE_INTEGER ConnectTime;
+    LARGE_INTEGER DisconnectTime;
+    LARGE_INTEGER LastInputTime;
+    LARGE_INTEGER LogonTime;
+    LARGE_INTEGER CurrentTime;
+
+} GA_WTSINFOA;
+
+GuestUserList *qmp_guest_get_users(Error **err)
+{
+#if (_WIN32_WINNT >= 0x0600)
+#ifndef QGA_NANOSECONDS
+#   define QGA_NANOSECONDS 10000000
+#endif
+#ifndef QGA_EPOCH_TIME_DIFF
+#   define QGA_EPOCH_TIME_DIFF 116444736000000000LL
+#endif
+
+    GHashTable *cache = g_hash_table_new(g_str_hash, g_str_equal);
+    GuestUserList *head = NULL, *cur_item = NULL;
+
+    DWORD count = 0;
+    WTS_SESSION_INFOA *entries = NULL;
+    if (WTSEnumerateSessionsA(NULL, 0, 1, &entries, &count)) {
+        for (DWORD i = 0; i < count; ++i) {
+            DWORD buffer_size = 0;
+            GA_WTSINFOA *session_info = NULL;
+            if (WTSQuerySessionInformationA(
+                NULL,
+                entries[i].SessionId,
+                WTSSessionInfo,
+                (LPSTR *)&session_info,
+                &buffer_size
+            )) {
+                if (strlen(session_info->UserName) == 0 ||
+                    g_hash_table_contains(cache, session_info->UserName)) {
+                    WTSFreeMemory(session_info);
+                    continue;
+                }
+
+                GuestUserList *item = g_new0(GuestUserList, 1);
+                item->value = g_new0(GuestUser, 1);
+
+                item->value->user = g_strdup(session_info->UserName);
+                item->value->domain = g_strdup(session_info->Domain);
+                item->value->has_domain = true;
+
+                INT64 login = session_info->LogonTime.QuadPart;
+                login -= QGA_EPOCH_TIME_DIFF;
+                item->value->login_time = ((double)login) / QGA_NANOSECONDS;
+
+                g_hash_table_add(cache, item->value->user);
+
+                if (!cur_item) {
+                    head = cur_item = item;
+                } else {
+                    cur_item->next = item;
+                    cur_item = item;
+                }
+            }
+            WTSFreeMemory(session_info);
+        }
+        WTSFreeMemory(entries);
+    }
+    g_hash_table_destroy(cache);
+    return head;
+#else
+    error_setg(err, QERR_UNSUPPORTED);
+    return NULL;
+#endif
+}
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index a02dbf2..27d10be 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1042,3 +1042,27 @@
   'data':    { 'path': 'str', '*arg': ['str'], '*env': ['str'],
                '*input-data': 'str', '*capture-output': 'bool' },
   'returns': 'GuestExec' }
+
+##
+# @GuestUser:
+# @user:       Username
+# @domain:     Logon domain (windows only)
+# @login-time: Time of login of this user on the computer. If multiple
+#              instances of the user are logged in, the earliest login time is
+#              reported. The value is in fractional seconds since epoch time.
+#
+# Since: 2.10
+##
+{ 'struct': 'GuestUser',
+  'data': { 'user': 'str', 'login-time': 'number', '*domain': 'str' } }
+
+##
+# @guest-get-users:
+# Retrieves a list of currently active users on the VM.
+#
+# Returns: A unique list of users.
+#
+# Since: 2.10
+##
+{ 'command': 'guest-get-users',
+  'returns': ['GuestUser'] }
-- 
2.9.3
