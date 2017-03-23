Received: from eggs.gnu.org ([2001:4830:134:3::10]:50464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vfeenstr@redhat.com>) id 1cr3d6-00089j-BO
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 10:22:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vfeenstr@redhat.com>) id 1cr3d2-0001le-9u
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 10:22:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vfeenstr@redhat.com>) id 1cr3d2-0001la-28
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 10:22:16 -0400
From: Vinzenz 'evilissimo' Feenstra <vfeenstr@redhat.com>
Date: Thu, 23 Mar 2017 01:27:04 +0100
Message-Id: <20170323002704.11167-2-vfeenstr@redhat.com>
In-Reply-To: <20170323002704.11167-1-vfeenstr@redhat.com>
References: <20170323002704.11167-1-vfeenstr@redhat.com>
Subject: [Qemu-devel] [PATCH v4] qga: Add `guest-get-timezone` command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, mdroth@linux.vnet.ibm.com, sameeh@daynix.com, marcandre.lureau@gmail.com, Vinzenz Feenstra <vfeenstr@redhat.com>

From: Vinzenz Feenstra <vfeenstr@redhat.com>

Adds a new command `guest-get-timezone` reporting the currently
configured timezone on the system. The information on what timezone is
currently is configured is useful in case of Windows VMs where the
offset of the hardware clock is required to have the same offset. This
can be used for management systems like `oVirt` to detect the timezone
difference and warn administrators of the misconfiguration.

Signed-off-by: Vinzenz Feenstra <vfeenstr@redhat.com>
---
 qga/commands.c       | 34 ++++++++++++++++++++++++++++++++++
 qga/qapi-schema.json | 26 ++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/qga/commands.c b/qga/commands.c
index 4d92946..8a0ff0a 100644
--- a/qga/commands.c
+++ b/qga/commands.c
@@ -499,3 +499,37 @@ int ga_parse_whence(GuestFileWhence *whence, Error **errp)
     error_setg(errp, "invalid whence code %"PRId64, whence->u.value);
     return -1;
 }
+
+GuestTimezone *qmp_guest_get_timezone(Error **errp)
+{
+    GuestTimezone *info = g_new0(GuestTimezone, 1);
+    GTimeZone *tz = g_time_zone_new_local();
+    if (tz == NULL) {
+        error_setg(errp, QERR_QGA_COMMAND_FAILED,
+                   "Couldn't retrieve local timezone");
+        goto error;
+    }
+
+    gint32 interval = g_time_zone_find_interval(tz, G_TIME_TYPE_STANDARD, 0);
+    if (interval != -1) {
+        info->offset = g_time_zone_get_offset(tz, interval);
+        gchar const *name = g_time_zone_get_abbreviation(tz, interval);
+        if (name != NULL) {
+            info->zone = g_strdup(name);
+        } else {
+            info->zone = NULL;
+        }
+    } else {
+        error_setg(errp, QERR_QGA_COMMAND_FAILED,
+                   "Failed to lookup timezone interval");
+        goto error;
+    }
+    g_time_zone_unref(tz);
+    return info;
+
+error:
+    g_time_zone_unref(tz);
+    g_free(info);
+    return NULL;
+}
+
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index a02dbf2..20d12a8 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1042,3 +1042,29 @@
   'data':    { 'path': 'str', '*arg': ['str'], '*env': ['str'],
                '*input-data': 'str', '*capture-output': 'bool' },
   'returns': 'GuestExec' }
+
+
+##
+# @GuestTimezone:
+#
+# @zone:    Timezone name
+# @offset:  Offset to UTC in seconds. For western timezones the offset has a
+#           negative value and for eastern the offset is positive value
+#
+# Since: 2.10
+##
+{ 'struct': 'GuestTimezone',
+  'data':   { '*zone': 'str', 'offset': 'int' } }
+
+
+##
+# @guest-get-timezone:
+#
+# Retrieves the timezone information from the guest.
+#
+# Returns: A GuestTimezone dictionary.
+#
+# Since: 2.10
+##
+{ 'command': 'guest-get-timezone',
+  'returns': 'GuestTimezone' }
-- 
2.9.3
