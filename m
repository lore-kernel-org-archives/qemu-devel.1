Received: from eggs.gnu.org ([2001:4830:134:3::10]:41308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1e55bD-0002sa-Ok
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 03:50:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1e55bA-0000jz-Lz
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 03:50:39 -0400
From: "Richard W.M. Jones" <rjones@redhat.com>
Date: Thu, 19 Oct 2017 08:50:31 +0100
Message-Id: <20171019075031.25507-1-rjones@redhat.com>
Subject: [Qemu-devel] [PATCH] tpm: Don't call tpm_cleanup unless CONFIG_TPM.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, amarnath.valluri@intel.com, pbonzini@redhat.com, marcandre.lureau@gmail.com, stefanb@linux.vnet.ibm.com

When compiling with --disable-tpm:

  ../vl.o: In function `main':
  /home/rjones/d/qemu/vl.c:4908: undefined reference to `tpm_cleanup'

This appears to have been introduced in commit c37cacabf228
("tpm: Move tpm_cleanup() to right place").

Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
---
 vl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/vl.c b/vl.c
index 0723835bbf..dbfd06d4bc 100644
--- a/vl.c
+++ b/vl.c
@@ -4905,7 +4905,9 @@ int main(int argc, char **argv, char **envp)
     res_free();
 
     /* vhost-user must be cleaned up before chardevs.  */
+#ifdef CONFIG_TPM
     tpm_cleanup();
+#endif
     net_cleanup();
     audio_cleanup();
     monitor_cleanup();
-- 
2.13.1
