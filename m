Received: from eggs.gnu.org ([2001:4830:134:3::10]:49938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e6soi-0004SB-KF
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 02:36:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e6soe-0006qR-Mt
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 02:36:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49554)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e6soe-0006q5-GR
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 02:35:56 -0400
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 24 Oct 2017 08:35:49 +0200
Message-Id: <20171024063550.22441-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH v2] tpm: Fix compilation with --disable-tpm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, Amarnath Valluri <amarnath.valluri@intel.com>

Commit
   c37cacabf2285b0731b44c1f667781fdd4f2b658

broke compilation without tpm.  Just add an #ifdef

CC: Amarnath Valluri <amarnath.valluri@intel.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 tpm.c | 6 +++++-
 vl.c  | 2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tpm.c b/tpm.c
index 45520f555d..e2f3be2e08 100644
--- a/tpm.c
+++ b/tpm.c
@@ -223,8 +223,11 @@ TPMInfoList *qmp_query_tpm(Error **errp)
 
 TpmTypeList *qmp_query_tpm_types(Error **errp)
 {
+    TpmTypeList *head = NULL;
+
+#ifdef CONFIG_TPM
     unsigned int i = 0;
-    TpmTypeList *head = NULL, *prev = NULL, *cur_item;
+    TpmTypeList *prev = NULL, *cur_item;
 
     for (i = 0; i < TPM_TYPE__MAX; i++) {
         if (!tpm_be_find_by_type(i)) {
@@ -241,6 +244,7 @@ TpmTypeList *qmp_query_tpm_types(Error **errp)
         }
         prev = cur_item;
     }
+#endif
 
     return head;
 }
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
2.13.6
