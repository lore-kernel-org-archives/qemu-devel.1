Received: from eggs.gnu.org ([2001:4830:134:3::10]:50240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vfeenstr@redhat.com>) id 1cvIEi-000098-BO
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 02:46:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vfeenstr@redhat.com>) id 1cvIEg-0007X7-Ko
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 02:46:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vfeenstr@redhat.com>) id 1cvIEg-0007VQ-FE
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 02:46:38 -0400
From: Vinzenz 'evilissimo' Feenstra <vfeenstr@redhat.com>
Date: Tue,  4 Apr 2017 08:46:31 +0200
Message-Id: <20170404064631.16287-2-vfeenstr@redhat.com>
In-Reply-To: <20170404064631.16287-1-vfeenstr@redhat.com>
References: <20170404064631.16287-1-vfeenstr@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/1] qga: Add 'guest-get-host-name' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: sameeh@daynix.com, mdroth@linux.vnet.ibm.com, Vinzenz Feenstra <vfeenstr@redhat.com>

From: Vinzenz Feenstra <vfeenstr@redhat.com>

Retrieving the guest host name is a very useful feature for virtual management
systems. This information can help to have more user friendly VM access
details, instead of an IP there would be the host name. Also the host name
reported can be used to have automated checks for valid SSL certificates.

virsh # qemu-agent-command F25 '{ "execute": "guest-get-host-name" }'
{"return":{"host-name":"F25.lab.evilissimo.net"}}

Signed-off-by: Vinzenz Feenstra <vfeenstr@redhat.com>
---
 qga/commands.c       | 11 +++++++++++
 qga/qapi-schema.json | 29 +++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/qga/commands.c b/qga/commands.c
index 4d92946..57a31bb 100644
--- a/qga/commands.c
+++ b/qga/commands.c
@@ -499,3 +499,14 @@ int ga_parse_whence(GuestFileWhence *whence, Error **errp)
     error_setg(errp, "invalid whence code %"PRId64, whence->u.value);
     return -1;
 }
+
+GuestHostName *qmp_guest_get_host_name(Error **err)
+{
+    GuestHostName *result = NULL;
+    gchar const *hostname = g_get_host_name();
+    if (hostname != NULL) {
+        result = g_new0(GuestHostName, 1);
+        result->host_name = g_strdup(hostname);
+    }
+    return result;
+}
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index a02dbf2..b9f99ae 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1042,3 +1042,32 @@
   'data':    { 'path': 'str', '*arg': ['str'], '*env': ['str'],
                '*input-data': 'str', '*capture-output': 'bool' },
   'returns': 'GuestExec' }
+
+
+
+##
+# @GuestHostName:
+# @host-name: Fully qualified domain name of the guest OS
+#
+# Since: 2.10
+##
+{ 'struct': 'GuestHostName',
+  'data':   { 'host-name': 'str' } }
+
+
+##
+# @guest-get-host-name:
+#
+# Return a name for the machine.
+#
+# The returned name is not necessarily a fully-qualified domain name, or even
+# present in DNS or some other name service at all. It need not even be unique
+# on your local network or site, but usually it is.
+#
+# Returns: the host name of the machine on success
+#
+# Since: 2.10
+##
+{ 'command': 'guest-get-host-name',
+  'returns': 'GuestHostName' }
+
-- 
2.9.3
