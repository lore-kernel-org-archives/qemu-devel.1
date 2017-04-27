Received: from eggs.gnu.org ([2001:4830:134:3::10]:60678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1d3cHF-0001Uy-Go
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 01:47:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1d3cHB-0003nb-Kg
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 01:47:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60537)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1d3cHB-0003nC-C0
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 01:47:37 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3R5hc6e090413
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 01:47:36 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a32j3r3jq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 01:47:35 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 26 Apr 2017 23:47:34 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Thu, 27 Apr 2017 00:46:36 -0500
In-Reply-To: <1493271996-23607-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1493271996-23607-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1493271996-23607-9-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PULL v2 8/8] qga: Add `guest-get-timezone` command
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

Adds a new command `guest-get-timezone` reporting the currently
configured timezone on the system. The information on what timezone is
currently is configured is useful in case of Windows VMs where the
offset of the hardware clock is required to have the same offset. This
can be used for management systems like `oVirt` to detect the timezone
difference and warn administrators of the misconfiguration.

Signed-off-by: Vinzenz Feenstra <vfeenstr@redhat.com>
Reviewed-by: Sameeh Jubran <sameeh@daynix.com>
Tested-by: Sameeh Jubran <sameeh@daynix.com>
* moved stub implementation to end of function for consistency
* document that timezone names are for informational use only.
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/commands.c       | 38 ++++++++++++++++++++++++++++++++++++++
 qga/qapi-schema.json | 25 +++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/qga/commands.c b/qga/commands.c
index 57a31bb..3333ed5 100644
--- a/qga/commands.c
+++ b/qga/commands.c
@@ -510,3 +510,41 @@ GuestHostName *qmp_guest_get_host_name(Error **err)
     }
     return result;
 }
+
+GuestTimezone *qmp_guest_get_timezone(Error **errp)
+{
+#if GLIB_CHECK_VERSION(2, 28, 0)
+    GuestTimezone *info = NULL;
+    GTimeZone *tz = NULL;
+    gint64 now = 0;
+    gint32 intv = 0;
+    gchar const *name = NULL;
+
+    info = g_new0(GuestTimezone, 1);
+    tz = g_time_zone_new_local();
+    if (tz == NULL) {
+        error_setg(errp, QERR_QGA_COMMAND_FAILED,
+                   "Couldn't retrieve local timezone");
+        goto error;
+    }
+
+    now = g_get_real_time() / G_USEC_PER_SEC;
+    intv = g_time_zone_find_interval(tz, G_TIME_TYPE_UNIVERSAL, now);
+    info->offset = g_time_zone_get_offset(tz, intv);
+    name = g_time_zone_get_abbreviation(tz, intv);
+    if (name != NULL) {
+        info->has_zone = true;
+        info->zone = g_strdup(name);
+    }
+    g_time_zone_unref(tz);
+
+    return info;
+
+error:
+    g_free(info);
+    return NULL;
+#else
+    error_setg(errp, QERR_UNSUPPORTED);
+    return NULL;
+#endif
+}
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index f25467a..03743ab 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1101,3 +1101,28 @@
 ##
 { 'command': 'guest-get-users',
   'returns': ['GuestUser'] }
+
+##
+# @GuestTimezone:
+#
+# @zone:    Timezone name. These values may differ depending on guest/OS and
+#           should only be used for informational purposes.
+# @offset:  Offset to UTC in seconds, negative numbers for time zones west of
+#           GMT, positive numbers for east
+#
+# Since: 2.10
+##
+{ 'struct': 'GuestTimezone',
+  'data':   { '*zone': 'str', 'offset': 'int' } }
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
2.7.4
