Received: from eggs.gnu.org ([208.118.235.92]:33566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eR0PH-00022n-Kz
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 13:44:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eR0PD-0008Qz-F3
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 13:44:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56544)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1eR0PD-0008PL-6x
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 13:44:51 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBIIgYQr053124
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 13:44:47 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2exhuk3snu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 13:44:46 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Mon, 18 Dec 2017 13:44:45 -0500
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Mon, 18 Dec 2017 16:44:28 -0200
In-Reply-To: <20171218184428.15074-1-danielhb@linux.vnet.ibm.com>
References: <20171218184428.15074-1-danielhb@linux.vnet.ibm.com>
Message-Id: <20171218184428.15074-2-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 1/1] qmp: marking qmp_cpu as deprecated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, eblake@redhat.com, berrange@redhat.com, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

qmp_cpu is a nop that was created a while ago in commit 755f196898
("qapi: Convert the cpu command") for the sake of compatibility,
due to the existence of hmp_cpu.

Today, there is no need or requirement to keep it as is. QMP is
meant to be as stateless as possible, thus any QMP command that
needs a specific monitor CPU setup should provide it in its
arguments, instead of relying in the current QMP monitor state.

This patch flags qmp_cpu as deprecated in qemu-doc.texi,
qapi-schema.json and changes qmp_cpu body to show a deprecation
message if used.

Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
---
 qapi-schema.json |  5 ++++-
 qemu-doc.texi    | 10 ++++++++++
 qmp.c            |  2 +-
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index 18457954a8..b51b89e19b 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -1052,7 +1052,10 @@
 #
 # Since: 0.14.0
 #
-# Notes: Do not use this command.
+# Notes: Do not use this command. It was deprecated in release 2.12.0 and will
+#        be removed, with no replacement, at any time in the future. QMP
+#        commands that rely on the current CPU monitor should specify it as a
+#        parameter.
 ##
 { 'command': 'cpu', 'data': {'index': 'int'} }
 
diff --git a/qemu-doc.texi b/qemu-doc.texi
index f7317dfc66..09e6c5046a 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2516,6 +2516,16 @@ subsystem image.
 The ``convert -s snapshot_id_or_name'' argument is obsoleted
 by the ``convert -l snapshot_param'' argument instead.
 
+@section System emulator machine protocol commands
+
+@subsection qmp_cpu (since 2.12.0)
+
+The ``qmp_cpu'' command was implemented in release 0.14.0 as a functional
+no-op, remaining as such up to release 2.12.0 when it was deprecated and
+flagged for future removal. No replacement will be provided: any QMP command
+that uses the current CPU monitor should, instead, specify the CPU in its
+parameters.
+
 @section System emulator human monitor commands
 
 @subsection host_net_add (since 2.10.0)
diff --git a/qmp.c b/qmp.c
index e8c303116a..d8543d713d 100644
--- a/qmp.c
+++ b/qmp.c
@@ -115,7 +115,7 @@ void qmp_system_powerdown(Error **erp)
 
 void qmp_cpu(int64_t index, Error **errp)
 {
-    /* Just do nothing */
+    error_setg(errp, "qmp_cpu is deprecated, do not use this command");
 }
 
 void qmp_cpu_add(int64_t id, Error **errp)
-- 
2.13.6
