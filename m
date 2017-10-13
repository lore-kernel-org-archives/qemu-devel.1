Received: from eggs.gnu.org ([2001:4830:134:3::10]:50617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e2yPB-0007Ly-94
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 07:45:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e2yP7-0002sx-AM
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 07:45:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37938)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e2yP7-0002sC-02
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 07:45:25 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9DBhoAb137988
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 07:45:20 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2djtynfb6h-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 07:45:20 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 13 Oct 2017 07:45:19 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 13 Oct 2017 07:44:59 -0400
In-Reply-To: <1507895100-26457-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1507895100-26457-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-Id: <1507895100-26457-11-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PULL v3 10/11] tpm: Move tpm_cleanup() to right place
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, amarnath.valluri@intel.com, marcandre.lureau@gmail.com, Stefan Berger <stefanb@linux.vnet.ibm.com>

From: Amarnath Valluri <amarnath.valluri@intel.com>

As Emulator TPM backend uses chardev, tpm cleanup should happen before chardev
similar to other vhost-users.

Signed-off-by: Amarnath Valluri <amarnath.valluri@intel.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 tpm.c | 1 -
 vl.c  | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/tpm.c b/tpm.c
index 3b8c7ed..3122227 100644
--- a/tpm.c
+++ b/tpm.c
@@ -172,7 +172,6 @@ int tpm_init(void)
         return -1;
     }
 
-    atexit(tpm_cleanup);
     return 0;
 }
 
diff --git a/vl.c b/vl.c
index d7c3492..0723835 100644
--- a/vl.c
+++ b/vl.c
@@ -4905,6 +4905,7 @@ int main(int argc, char **argv, char **envp)
     res_free();
 
     /* vhost-user must be cleaned up before chardevs.  */
+    tpm_cleanup();
     net_cleanup();
     audio_cleanup();
     monitor_cleanup();
-- 
2.5.5
