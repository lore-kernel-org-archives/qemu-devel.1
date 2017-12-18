Received: from eggs.gnu.org ([2001:4830:134:3::10]:52028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eQt3H-0006o2-6j
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 05:53:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eQt3D-0003TN-8X
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 05:53:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54910)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1eQt3C-0003RJ-Vl
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 05:53:39 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBIAnCWB134517
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 05:53:36 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2exbagtuws-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 05:53:36 -0500
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Mon, 18 Dec 2017 05:53:35 -0500
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Mon, 18 Dec 2017 08:53:18 -0200
Message-Id: <20171218105318.30367-1-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v1 1/1] qmp: marking qmp_cpu as deprecated
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

This patch flags qmp_cpu as deprecated in qemu-doc.texi and changes
qmp_cpu body to show a deprecation message if used.

Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
---
Although I've changed the behavior of qmp_cpu to return an error
instead of doing nothing, no errors were found in the Travis
build of the patch. Code inspection confirms that qmp_cpu isn't
being used in QEMU.

A quick inspection in Libvirt code shows that there is no reference
to 'qmp_cpu' there either, but to be sure I've CCed Daniel here
so he can comment/confirm if Libvirt does not care for this change.

 qemu-doc.texi | 6 ++++++
 qmp.c         | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index f7317dfc66..2b63f9a325 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2516,6 +2516,12 @@ subsystem image.
 The ``convert -s snapshot_id_or_name'' argument is obsoleted
 by the ``convert -l snapshot_param'' argument instead.
 
+@section System emulator machine protocol commands
+
+@subsection qmp_cpu (since 2.12.0)
+
+The ``qmp_cpu'' command is deprecated. Do not use this command.
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
