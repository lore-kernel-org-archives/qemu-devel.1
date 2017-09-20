Received: from eggs.gnu.org ([2001:4830:134:3::10]:40716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1duT9Z-0004RX-NV
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 20:46:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1duT9R-0005fu-FT
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 20:46:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57736
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1duT9R-0005eA-Ac
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 20:46:05 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8K0hbKD041251
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 20:46:02 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d39bk77y3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 20:46:02 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 19 Sep 2017 18:46:01 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 19 Sep 2017 19:45:13 -0500
In-Reply-To: <20170920004521.9417-1-mdroth@linux.vnet.ibm.com>
References: <20170920004521.9417-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20170920004521.9417-5-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 04/12] virtfs: error out gracefully when
 mandatory suboptions are missing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>

From: Greg Kurz <groug@kaod.org>

We internally convert -virtfs to -fsdev/-device. If the user doesn't
provide the path or security_model suboptions, and the fsdev backend
requires them, we hit an assertion when populating the internal -fsdev
option:

util/qemu-option.c:547: opt_set: Assertion `opt->str' failed.
Aborted (core dumped)

Let's test the suboption presence on the command line before trying
to set it in the internal -fsdev option, and let the backend code
error out gracefully (ie, like it already does when the user passes
-fsdev on the command line).

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit 32b6943699948f7adc35ada233fbd25daffad5e9)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 vl.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/vl.c b/vl.c
index 8e247cc2a2..d63269332f 100644
--- a/vl.c
+++ b/vl.c
@@ -3557,7 +3557,7 @@ int main(int argc, char **argv, char **envp)
             case QEMU_OPTION_virtfs: {
                 QemuOpts *fsdev;
                 QemuOpts *device;
-                const char *writeout, *sock_fd, *socket;
+                const char *writeout, *sock_fd, *socket, *path, *security_model;
 
                 olist = qemu_find_opts("virtfs");
                 if (!olist) {
@@ -3596,11 +3596,15 @@ int main(int argc, char **argv, char **envp)
                 }
                 qemu_opt_set(fsdev, "fsdriver",
                              qemu_opt_get(opts, "fsdriver"), &error_abort);
-                qemu_opt_set(fsdev, "path", qemu_opt_get(opts, "path"),
-                             &error_abort);
-                qemu_opt_set(fsdev, "security_model",
-                             qemu_opt_get(opts, "security_model"),
-                             &error_abort);
+                path = qemu_opt_get(opts, "path");
+                if (path) {
+                    qemu_opt_set(fsdev, "path", path, &error_abort);
+                }
+                security_model = qemu_opt_get(opts, "security_model");
+                if (security_model) {
+                    qemu_opt_set(fsdev, "security_model", security_model,
+                                 &error_abort);
+                }
                 socket = qemu_opt_get(opts, "socket");
                 if (socket) {
                     qemu_opt_set(fsdev, "socket", socket, &error_abort);
-- 
2.11.0
