Received: from eggs.gnu.org ([2001:4830:134:3::10]:34642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.ibm.com>) id 1fFWt6-0000wa-UE
	for qemu-devel@nongnu.org; Sun, 06 May 2018 23:32:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.ibm.com>) id 1fFWt3-0002bN-Qo
	for qemu-devel@nongnu.org; Sun, 06 May 2018 23:32:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57112)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.ibm.com>)
	id 1fFWt3-0002ap-IU
	for qemu-devel@nongnu.org; Sun, 06 May 2018 23:32:29 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w473TWV2074178
	for <qemu-devel@nongnu.org>; Sun, 6 May 2018 23:32:27 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hte6c98ke-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 06 May 2018 23:32:27 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.ibm.com>;
	Sun, 6 May 2018 23:32:26 -0400
From: Yi Min Zhao <zyimin@linux.ibm.com>
Date: Mon,  7 May 2018 11:32:14 +0800
In-Reply-To: <20180507033214.19219-1-zyimin@linux.ibm.com>
References: <20180507033214.19219-1-zyimin@linux.ibm.com>
Message-Id: <20180507033214.19219-2-zyimin@linux.ibm.com>
Subject: [Qemu-devel] [PATCH 1/1] sandbox: avoid to compile options if
 CONFIG_SECCOMP undefined
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jtomko@redhat.com, jferlan@redhat.com, berrange@redhat.com, otubo@redhat.com, borntraeger@de.ibm.com, fiuczy@linux.ibm.com, zyimin@linux.ibm.com

If CONFIG_SECCOMP is undefined, the option 'elevatorprivileges' remains
complied. This would make libvirt set the corresponding capability and
then trigger the guest startup fails. So let's wrap the options with
CONFIG_SECCOMP.

Signed-off-by: Yi Min Zhao <zyimin@linux.ibm.com>
---
 vl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/vl.c b/vl.c
index fce1fd12d8..cb07b19c02 100644
--- a/vl.c
+++ b/vl.c
@@ -268,6 +268,7 @@ static QemuOptsList qemu_sandbox_opts = {
             .name = "enable",
             .type = QEMU_OPT_BOOL,
         },
+#ifdef CONFIG_SECCOMP
         {
             .name = "obsolete",
             .type = QEMU_OPT_STRING,
@@ -284,6 +285,7 @@ static QemuOptsList qemu_sandbox_opts = {
             .name = "resourcecontrol",
             .type = QEMU_OPT_STRING,
         },
+#endif
         { /* end of list */ }
     },
 };
-- 
2.15.1 (Apple Git-101)
