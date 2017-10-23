Received: from eggs.gnu.org ([2001:4830:134:3::10]:52157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1e6Zyu-0000M5-2p
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 06:29:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1e6Zyq-0005Tp-37
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 06:29:16 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:13316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1e6Zyp-0005Sh-SQ
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 06:29:12 -0400
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Mon, 23 Oct 2017 12:24:59 +0200
Message-Id: <20171023102903.256AF7456A0@zero.eik.bme.hu>
Subject: [Qemu-devel] [PATCH] Fix compile with --disable-tpm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 tpm.c | 7 ++++---
 vl.c  | 2 ++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/tpm.c b/tpm.c
index 45520f5..b625cd4 100644
--- a/tpm.c
+++ b/tpm.c
@@ -30,8 +30,6 @@ void tpm_register_model(enum TpmModel model)
     tpm_models[model] = true;
 }
 
-#ifdef CONFIG_TPM
-
 static const TPMBackendClass *
 tpm_be_find_by_type(enum TpmType type)
 {
@@ -48,6 +46,8 @@ tpm_be_find_by_type(enum TpmType type)
     return TPM_BACKEND_CLASS(oc);
 }
 
+#ifdef CONFIG_TPM
+
 /*
  * Walk the list of available TPM backend drivers and display them on the
  * screen.
@@ -208,8 +208,9 @@ TPMInfoList *qmp_query_tpm(Error **errp)
             continue;
         }
         info = g_new0(TPMInfoList, 1);
+#ifdef CONFIG_TPM
         info->value = tpm_backend_query_tpm(drv);
-
+#endif
         if (!cur_item) {
             head = cur_item = info;
         } else {
diff --git a/vl.c b/vl.c
index 0723835..dbfd06d 100644
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
2.7.6
