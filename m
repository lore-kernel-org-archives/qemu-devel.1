Received: from eggs.gnu.org ([2001:4830:134:3::10]:60647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1d3cHB-0001HD-7S
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 01:47:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1d3cH7-0003mh-N9
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 01:47:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51226
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1d3cH7-0003mD-GK
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 01:47:33 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3R5hhbf187328
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 01:47:32 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2a333hetvb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 01:47:32 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 26 Apr 2017 23:47:31 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Thu, 27 Apr 2017 00:46:35 -0500
In-Reply-To: <1493271996-23607-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1493271996-23607-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1493271996-23607-8-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PULL v2 7/8] qga: Add 'guest-get-users' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Vinzenz Feenstra <vfeenstr@redhat.com>

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
* make g_hash_table_contains compat func inline to avoid
  unused warnings
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 configure             |   2 +-
 include/glib-compat.h |   6 +++
 qga/commands-posix.c  |  60 +++++++++++++++++++++++++++++
 qga/commands-win32.c  | 103 ++++++++++++++++++++++++++++++++++++++++++++++++++
 qga/qapi-schema.json  |  25 ++++++++++++
 5 files changed, 195 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index c35acf1..80d17f3 100755
--- a/configure
+++ b/configure
@@ -743,7 +743,7 @@ if test "$mingw32" = "yes" ; then
   sysconfdir="\${prefix}"
   local_statedir=
   confsuffix=""
-  libs_qga="-lws2_32 -lwinmm -lpowrprof -liphlpapi -lnetapi32 $libs_qga"
+  libs_qga="-lws2_32 -lwinmm -lpowrprof -lwtsapi32 -liphlpapi -lnetapi32 $libs_qga"
 fi
 
 werror=""
diff --git a/include/glib-compat.h b/include/glib-compat.h
index 863c8cf..fcffcd3 100644
--- a/include/glib-compat.h
+++ b/include/glib-compat.h
@@ -217,6 +217,12 @@ static inline void g_hash_table_add(GHashTable *hash_table, gpointer key)
 {
     g_hash_table_replace(hash_table, key, key);
 }
+
+static inline gboolean g_hash_table_contains(GHashTable *hash_table,
+                                             gpointer key)
+{
+    return g_hash_table_lookup_extended(hash_table, key, NULL, NULL);
+}
 #endif
 
 #ifndef g_assert_true
diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 915df9e..ba06be4 100644
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
@@ -2517,3 +2518,62 @@ void ga_command_state_init(GAState *s, GACommandState *cs)
     ga_command_state_add(cs, NULL, guest_fsfreeze_cleanup);
 #endif
 }
+
+#define QGA_MICRO_SECOND_TO_SECOND 1000000
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
+    GHashTable *cache = NULL;
+    GuestUserList *head = NULL, *cur_item = NULL;
+    struct utmpx *user_info = NULL;
+    gpointer value = NULL;
+    GuestUser *user = NULL;
+    GuestUserList *item = NULL;
+    double login_time = 0;
+
+    cache = g_hash_table_new(g_str_hash, g_str_equal);
+    setutxent();
+
+    for (;;) {
+        user_info = getutxent();
+        if (user_info == NULL) {
+            break;
+        } else if (user_info->ut_type != USER_PROCESS) {
+            continue;
+        } else if (g_hash_table_contains(cache, user_info->ut_user)) {
+            value = g_hash_table_lookup(cache, user_info->ut_user);
+            user = (GuestUser *)value;
+            login_time = ga_get_login_time(user_info);
+            /* We're ensuring the earliest login time to be sent */
+            if (login_time < user->login_time) {
+                user->login_time = login_time;
+            }
+            continue;
+        }
+
+        item = g_new0(GuestUserList, 1);
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
index 9fec1fb..439d229 100644
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
@@ -1536,3 +1540,102 @@ void ga_command_state_init(GAState *s, GACommandState *cs)
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
+#define QGA_NANOSECONDS 10000000
+
+    GHashTable *cache = NULL;
+    GuestUserList *head = NULL, *cur_item = NULL;
+
+    DWORD buffer_size = 0, count = 0, i = 0;
+    GA_WTSINFOA *info = NULL;
+    WTS_SESSION_INFOA *entries = NULL;
+    GuestUserList *item = NULL;
+    GuestUser *user = NULL;
+    gpointer value = NULL;
+    INT64 login = 0;
+    double login_time = 0;
+
+    cache = g_hash_table_new(g_str_hash, g_str_equal);
+
+    if (WTSEnumerateSessionsA(NULL, 0, 1, &entries, &count)) {
+        for (i = 0; i < count; ++i) {
+            buffer_size = 0;
+            info = NULL;
+            if (WTSQuerySessionInformationA(
+                NULL,
+                entries[i].SessionId,
+                WTSSessionInfo,
+                (LPSTR *)&info,
+                &buffer_size
+            )) {
+
+                if (strlen(info->UserName) == 0) {
+                    WTSFreeMemory(info);
+                    continue;
+                }
+
+                login = info->LogonTime.QuadPart;
+                login -= W32_FT_OFFSET;
+                login_time = ((double)login) / QGA_NANOSECONDS;
+
+                if (g_hash_table_contains(cache, info->UserName)) {
+                    value = g_hash_table_lookup(cache, info->UserName);
+                    user = (GuestUser *)value;
+                    if (user->login_time > login_time) {
+                        user->login_time = login_time;
+                    }
+                } else {
+                    item = g_new0(GuestUserList, 1);
+                    item->value = g_new0(GuestUser, 1);
+
+                    item->value->user = g_strdup(info->UserName);
+                    item->value->domain = g_strdup(info->Domain);
+                    item->value->has_domain = true;
+
+                    item->value->login_time = login_time;
+
+                    g_hash_table_add(cache, item->value->user);
+
+                    if (!cur_item) {
+                        head = cur_item = item;
+                    } else {
+                        cur_item->next = item;
+                        cur_item = item;
+                    }
+                }
+            }
+            WTSFreeMemory(info);
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
index 0f4cba5..f25467a 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1076,3 +1076,28 @@
 ##
 { 'command': 'guest-get-host-name',
   'returns': 'GuestHostName' }
+
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
2.7.4
