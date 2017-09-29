Received: from eggs.gnu.org ([2001:4830:134:3::10]:52587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1dxtBe-00032Y-SF
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:10:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1dxtBe-0006Mf-3w
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:10:30 -0400
Received: from mga07.intel.com ([134.134.136.100]:42442)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarnath.valluri@intel.com>)
	id 1dxtBd-0005tE-QH
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:10:30 -0400
From: Amarnath Valluri <amarnath.valluri@intel.com>
Date: Fri, 29 Sep 2017 14:10:21 +0300
Message-Id: <1506683421-27004-10-git-send-email-amarnath.valluri@intel.com>
In-Reply-To: <1506683421-27004-1-git-send-email-amarnath.valluri@intel.com>
References: <1506683421-27004-1-git-send-email-amarnath.valluri@intel.com>
Subject: [Qemu-devel] [PATCH v10 9/9] tpm: Move tpm_cleanup() to right place
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanb@linux.vnet.ibm.com, marcandre.lureau@gmail.com, Amarnath Valluri <amarnath.valluri@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <qemu-devel.nongnu.org>

As Emulator TPM backend uses chardev, tpm cleanup should happen before chardev
similar to other vhost-users.

Signed-off-by: Amarnath Valluri <amarnath.valluri@intel.com>
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
index 9bb5058..ed86209 100644
--- a/vl.c
+++ b/vl.c
@@ -4893,6 +4893,7 @@ int main(int argc, char **argv, char **envp)
     res_free();
 
     /* vhost-user must be cleaned up before chardevs.  */
+    tpm_cleanup();
     net_cleanup();
     audio_cleanup();
     monitor_cleanup();
-- 
2.7.4
