Received: from eggs.gnu.org ([2001:4830:134:3::10]:40069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fyLmS-0003iA-9w
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 14:46:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fyLmP-0004HJ-2v
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 14:46:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47966)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1fyLmO-0004FH-Q7
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 14:46:52 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w87IhrJp128172
	for <qemu-devel@nongnu.org>; Fri, 7 Sep 2018 14:46:51 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2mbuuuf747-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 07 Sep 2018 14:46:51 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 7 Sep 2018 12:46:50 -0600
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri,  7 Sep 2018 14:46:44 -0400
Message-Id: <20180907184644.2272491-1-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH] tests: Fix signalling race condition in TPM
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mjt@tlks.msk.ru, peter.maydell@linaro.org, Stefan Berger <stefanb@linux.vnet.ibm.com>

This patch fixes a race condition and test failure where the main process
waits for the signal of a thread but the thread already sent that signal
via a condition. Since these signals are non-sticky, we need to introduce a
separate variable to make this signal sticky.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 tests/tpm-crb-test.c |  1 +
 tests/tpm-emu.c      | 11 ++++++++++-
 tests/tpm-emu.h      |  1 +
 tests/tpm-tis-test.c |  1 +
 4 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/tests/tpm-crb-test.c b/tests/tpm-crb-test.c
index d8f9569203..6fde579bab 100644
--- a/tests/tpm-crb-test.c
+++ b/tests/tpm-crb-test.c
@@ -151,6 +151,7 @@ int main(int argc, char **argv)
     test.addr->u.q_unix.path = g_build_filename(tmp_path, "sock", NULL);
     g_mutex_init(&test.data_mutex);
     g_cond_init(&test.data_cond);
+    test.data_cond_signal = false;
 
     thread = g_thread_new(NULL, tpm_emu_ctrl_thread, &test);
     tpm_emu_test_wait_cond(&test);
diff --git a/tests/tpm-emu.c b/tests/tpm-emu.c
index 8c2bd53cad..125e697181 100644
--- a/tests/tpm-emu.c
+++ b/tests/tpm-emu.c
@@ -23,9 +23,14 @@ void tpm_emu_test_wait_cond(TestState *s)
     gint64 end_time = g_get_monotonic_time() + 5 * G_TIME_SPAN_SECOND;
 
     g_mutex_lock(&s->data_mutex);
-    if (!g_cond_wait_until(&s->data_cond, &s->data_mutex, end_time)) {
+
+    if (!s->data_cond_signal &&
+        !g_cond_wait_until(&s->data_cond, &s->data_mutex, end_time)) {
         g_assert_not_reached();
     }
+
+    s->data_cond_signal = false;
+
     g_mutex_unlock(&s->data_mutex);
 }
 
@@ -72,6 +77,10 @@ void *tpm_emu_ctrl_thread(void *data)
     QIOChannel *ioc;
 
     qio_channel_socket_listen_sync(lioc, s->addr, &error_abort);
+
+    g_mutex_lock(&s->data_mutex);
+    s->data_cond_signal = true;
+    g_mutex_unlock(&s->data_mutex);
     g_cond_signal(&s->data_cond);
 
     qio_channel_wait(QIO_CHANNEL(lioc), G_IO_IN);
diff --git a/tests/tpm-emu.h b/tests/tpm-emu.h
index 08f902485e..8eb802a79e 100644
--- a/tests/tpm-emu.h
+++ b/tests/tpm-emu.h
@@ -26,6 +26,7 @@ struct tpm_hdr {
 typedef struct TestState {
     GMutex data_mutex;
     GCond data_cond;
+    bool data_cond_signal;
     SocketAddress *addr;
     QIOChannel *tpm_ioc;
     GThread *emu_tpm_thread;
diff --git a/tests/tpm-tis-test.c b/tests/tpm-tis-test.c
index 14754d9706..c8ec14888f 100644
--- a/tests/tpm-tis-test.c
+++ b/tests/tpm-tis-test.c
@@ -446,6 +446,7 @@ int main(int argc, char **argv)
     test.addr->u.q_unix.path = g_build_filename(tmp_path, "sock", NULL);
     g_mutex_init(&test.data_mutex);
     g_cond_init(&test.data_cond);
+    test.data_cond_signal = false;
 
     thread = g_thread_new(NULL, tpm_emu_ctrl_thread, &test);
     tpm_emu_test_wait_cond(&test);
-- 
2.14.4
