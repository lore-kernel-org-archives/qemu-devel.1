Received: from eggs.gnu.org ([2001:4830:134:3::10]:33468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eYYQA-0002xS-E9
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 09:29:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eYYQ7-0006AX-Nt
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 09:29:02 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33426
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eYYQ7-0006A4-JR
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 09:28:59 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.21) with SMTP id
	w08ESqIk126711
	for <qemu-devel@nongnu.org>; Mon, 8 Jan 2018 09:28:59 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fc85uy2qx-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 09:28:57 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Mon, 8 Jan 2018 14:28:53 -0000
From: Greg Kurz <groug@kaod.org>
Date: Mon,  8 Jan 2018 15:28:30 +0100
In-Reply-To: <20180108142831.6638-1-groug@kaod.org>
References: <20180108142831.6638-1-groug@kaod.org>
Message-Id: <20180108142831.6638-14-groug@kaod.org>
Subject: [Qemu-devel] [PULL 13/14] 9pfs: deprecate handle backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>

This backend raise some concerns:

- doesn't support symlinks
- fails +100 tests in the PJD POSIX file system test suite [1]
- requires the QEMU process to run with the CAP_DAC_READ_SEARCH
  capability, which isn't recommended for security reasons

This backend should not be used and wil be removed. The 'local'
backend is the recommended alternative.

[1] https://www.tuxera.com/community/posix-test-suite/

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 hw/9pfs/9p-handle.c | 2 ++
 qemu-doc.texi       | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/hw/9pfs/9p-handle.c b/hw/9pfs/9p-handle.c
index c5adfe6f3a96..c1681d3c8ac0 100644
--- a/hw/9pfs/9p-handle.c
+++ b/hw/9pfs/9p-handle.c
@@ -657,6 +657,8 @@ static int handle_parse_opts(QemuOpts *opts, FsDriverEntry *fse, Error **errp)
     const char *sec_model = qemu_opt_get(opts, "security_model");
     const char *path = qemu_opt_get(opts, "path");
 
+    warn_report("handle backend is deprecated");
+
     if (sec_model) {
         error_report("Invalid argument security_model specified with handle fsdriver");
         return -1;
diff --git a/qemu-doc.texi b/qemu-doc.texi
index ae90f7199eca..454a8313d0de 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2724,6 +2724,14 @@ default channel subsystem image for guests that do not support multiple
 channel subsystems, all devices can be put into the default channel
 subsystem image.
 
+@subsection -fsdev handle (since 2.12.0)
+
+The ``handle'' fsdev backend does not support symlinks and causes the 9p
+filesystem in the guest to fail a fair amount of tests from the PJD POSIX
+filesystem test suite. Also it requires the CAP_DAC_READ_SEARCH capability,
+which is not the recommended way to run QEMU. This backend should not be
+used and it will be removed with no replacement.
+
 @section qemu-img command line arguments
 
 @subsection convert -s (since 2.0.0)
-- 
2.13.6
