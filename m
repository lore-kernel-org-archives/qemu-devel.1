Received: from eggs.gnu.org ([2001:4830:134:3::10]:32851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e09KR-0006fg-3p
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:48:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e09KO-0001sF-Fp
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:48:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37638
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e09KO-0001rO-AW
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:48:52 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v95GlMiu057240
	for <qemu-devel@nongnu.org>; Thu, 5 Oct 2017 12:48:50 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ddr3jhgf6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 12:48:50 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 5 Oct 2017 12:48:49 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu,  5 Oct 2017 12:48:31 -0400
In-Reply-To: <1507222112-20315-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1507222112-20315-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-Id: <1507222112-20315-10-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PULL v1 09/10] tpm: Move tpm_cleanup() to right place
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
