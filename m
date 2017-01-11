Received: from eggs.gnu.org ([2001:4830:134:3::10]:59711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cREbI-0000VR-27
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 03:49:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cREbE-0002Oa-Uk
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 03:49:44 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44103
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cREbE-0002JX-Mn
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 03:49:40 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v0B8mrQ0087881
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 03:49:37 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27weet7wcg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 03:49:37 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Wed, 11 Jan 2017 01:49:36 -0700
From: Greg Kurz <groug@kaod.org>
Date: Wed, 11 Jan 2017 09:49:32 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <148412457273.22750.983275587432075569.stgit@bahia>
Subject: [Qemu-devel] [PATCH] libqtest: handle zero length memwrite/memread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

Some recently added tests pass a zero length to qtest_memwrite().
Unfortunately, the qtest protocol doesn't implement an on-the-wire
syntax for zero-length writes and the current code happily sends
garbage to QEMU. This causes intermittent failures.

It isn't worth the pain to enhance the protocol, so this patch
simply fixes the issue by "just return, doing nothing". The same
fix is applied to qtest_memread() since the issue also exists in
the QEMU part of the "memread" command.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 qtest.c          |    2 ++
 tests/libqtest.c |   12 +++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/qtest.c b/qtest.c
index 46b99aed5291..bd9d4178129b 100644
--- a/qtest.c
+++ b/qtest.c
@@ -430,6 +430,8 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         g_assert(words[1] && words[2]);
         g_assert(qemu_strtoull(words[1], NULL, 0, &addr) == 0);
         g_assert(qemu_strtoull(words[2], NULL, 0, &len) == 0);
+        /* We'd send garbage to libqtest if len is 0 */
+        g_assert(len);
 
         data = g_malloc(len);
         cpu_physical_memory_read(addr, data, len);
diff --git a/tests/libqtest.c b/tests/libqtest.c
index 6f6975248fae..d8fba6647a17 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -768,6 +768,10 @@ void qtest_memread(QTestState *s, uint64_t addr, void *data, size_t size)
     gchar **args;
     size_t i;
 
+    if (!size) {
+        return;
+    }
+
     qtest_sendf(s, "read 0x%" PRIx64 " 0x%zx\n", addr, size);
     args = qtest_rsp(s, 2);
 
@@ -858,7 +862,13 @@ void qtest_memwrite(QTestState *s, uint64_t addr, const void *data, size_t size)
 {
     const uint8_t *ptr = data;
     size_t i;
-    char *enc = g_malloc(2 * size + 1);
+    char *enc;
+
+    if (!size) {
+        return;
+    }
+
+    enc = g_malloc(2 * size + 1);
 
     for (i = 0; i < size; i++) {
         sprintf(&enc[i * 2], "%02x", ptr[i]);
