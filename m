Received: from eggs.gnu.org ([2001:4830:134:3::10]:45215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1d39W4-0003Ep-IM
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 19:05:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1d39W1-0004Ra-51
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 19:05:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51296
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1d39W0-0004RH-Vb
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 19:05:01 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3PN42pi063349
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 19:05:00 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2a2ebujym8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 19:04:59 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 25 Apr 2017 19:04:59 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 25 Apr 2017 18:04:38 -0500
In-Reply-To: <1493161481-29595-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1493161481-29595-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1493161481-29595-6-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PULL 5/8] qga: Add 'guest-get-host-name' command
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

Retrieving the guest host name is a very useful feature for virtual management
systems. This information can help to have more user friendly VM access
details, instead of an IP there would be the host name. Also the host name
reported can be used to have automated checks for valid SSL certificates.

virsh # qemu-agent-command F25 '{ "execute": "guest-get-host-name" }'
{"return":{"host-name":"F25.lab.evilissimo.net"}}

Signed-off-by: Vinzenz Feenstra <vfeenstr@redhat.com>
* minor whitespace fix-ups
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/commands.c       | 11 +++++++++++
 qga/qapi-schema.json | 26 ++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

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
index a02dbf2..6307ae2 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1042,3 +1042,29 @@
   'data':    { 'path': 'str', '*arg': ['str'], '*env': ['str'],
                '*input-data': 'str', '*capture-output': 'bool' },
   'returns': 'GuestExec' }
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
-- 
2.7.4
