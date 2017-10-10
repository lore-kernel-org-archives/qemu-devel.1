Received: from eggs.gnu.org ([2001:4830:134:3::10]:41762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e1jRL-0003sD-ER
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 21:34:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e1jRI-0000MW-Bl
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 21:34:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40368)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e1jRI-0000KO-2o
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 21:34:32 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9A1Y88v112925
	for <qemu-devel@nongnu.org>; Mon, 9 Oct 2017 21:34:26 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dgg5d3d2b-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 21:34:26 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 9 Oct 2017 19:34:26 -0600
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon,  9 Oct 2017 21:33:54 -0400
In-Reply-To: <1507599235-25123-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1507599235-25123-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-Id: <1507599235-25123-10-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PULL v2 09/10] tpm: Move tpm_cleanup() to right place
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
index 3fed457..f238a30 100644
--- a/vl.c
+++ b/vl.c
@@ -4908,6 +4908,7 @@ int main(int argc, char **argv, char **envp)
     res_free();
 
     /* vhost-user must be cleaned up before chardevs.  */
+    tpm_cleanup();
     net_cleanup();
     audio_cleanup();
     monitor_cleanup();
-- 
2.5.5
