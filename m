Received: from eggs.gnu.org ([2001:4830:134:3::10]:53155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vfeenstr@redhat.com>) id 1csR9O-0003Vq-66
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 05:41:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vfeenstr@redhat.com>) id 1csR9J-0004mA-7C
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 05:41:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47236)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vfeenstr@redhat.com>) id 1csR9J-0004lZ-1n
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 05:41:17 -0400
From: Vinzenz 'evilissimo' Feenstra <vfeenstr@redhat.com>
Date: Thu, 23 Mar 2017 19:51:07 +0100
Message-Id: <20170323185107.2261-1-vfeenstr@redhat.com>
Subject: [Qemu-devel] [PATCH v1] qga: Add 'guest-get-fqdn' command
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

Retrieving the guest OS fully qualified domain name (FQDN) is a very
useful feature for virtual management systems. This information can help
to have more user friendly VM access details, instead of an IP there
would be the FQDN. Also the FQDN reported can be used to have automated
checks for valid SSL certificates.

virsh # qemu-agent-command F25 '{ "execute": "guest-get-fqdn" }'
{"return":{"fqdn":"F25.lab.evilissimo.net"}}

Signed-off-by: Vinzenz Feenstra <vfeenstr@redhat.com>
---
 qga/commands.c       | 11 +++++++++++
 qga/qapi-schema.json | 25 +++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/qga/commands.c b/qga/commands.c
index 4d92946..61577af 100644
--- a/qga/commands.c
+++ b/qga/commands.c
@@ -499,3 +499,14 @@ int ga_parse_whence(GuestFileWhence *whence, Error **errp)
     error_setg(errp, "invalid whence code %"PRId64, whence->u.value);
     return -1;
 }
+
+GuestFQDN *qmp_guest_get_fqdn(Error **err)
+{
+    GuestFQDN *result = NULL;
+    gchar const *hostname = g_get_host_name();
+    if (hostname != NULL) {
+        result = g_new0(GuestFQDN, 1);
+        result->fqdn = g_strdup(hostname);
+    }
+    return result;
+}
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index a02dbf2..0a2c0a4 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1042,3 +1042,28 @@
   'data':    { 'path': 'str', '*arg': ['str'], '*env': ['str'],
                '*input-data': 'str', '*capture-output': 'bool' },
   'returns': 'GuestExec' }
+
+
+
+##
+# @GuestFQDN:
+# @fqdn: Fully qualified domain name of the guest OS
+#
+# Since: 2.10
+##
+{ 'struct': 'GuestFQDN',
+  'data':   { 'fqdn': 'str' } }
+
+
+##
+# @guest-get-fqdn:
+#
+# Request the FQDN (Fully Qualified Domain Name) of the guest operating system
+#
+# Returns: FQDN on success
+#
+# Since: 2.10
+##
+{ 'command': 'guest-get-fqdn',
+  'returns': 'GuestFQDN' }
+
-- 
2.9.3
