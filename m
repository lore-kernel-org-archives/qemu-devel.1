Received: from eggs.gnu.org ([2001:4830:134:3::10]:54834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dslae-00083R-IL
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:03:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dslaY-0000nk-JH
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:03:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dslaY-0000mi-Ak
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:03:02 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 15 Sep 2017 10:02:29 +0200
Message-Id: <1505462549-27298-10-git-send-email-thuth@redhat.com>
In-Reply-To: <1505462549-27298-1-git-send-email-thuth@redhat.com>
References: <1505462549-27298-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PULL 9/9] qtest: Avoid passing raw strings through
 hmp()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, John Snow <jsnow@redhat.com>

From: Eric Blake <eblake@redhat.com>

hmp() passes its string argument through the sprintf() family;
with a proper attribute, gcc -Wformat warns us when we do something
dangerous like passing a non-constant format string.  Fortunately,
all our strings were safe, but checking whether the string can
contain an unintended % is easy to avoid and therefore worth doing.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/libqtest.h | 8 ++++----
 tests/test-hmp.c | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/libqtest.h b/tests/libqtest.h
index 44803d7..86b3a3b 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -134,14 +134,14 @@ QDict *qtest_qmp_eventwait_ref(QTestState *s, const char *event);
 /**
  * qtest_hmp:
  * @s: #QTestState instance to operate on.
- * @fmt...: HMP command to send to QEMU
+ * @fmt...: HMP command to send to QEMU, formats arguments like sprintf().
  *
  * Send HMP command to QEMU via QMP's human-monitor-command.
  * QMP events are discarded.
  *
  * Returns: the command's output.  The caller should g_free() it.
  */
-char *qtest_hmp(QTestState *s, const char *fmt, ...);
+char *qtest_hmp(QTestState *s, const char *fmt, ...) GCC_FMT_ATTR(2, 3);
 
 /**
  * qtest_hmpv:
@@ -592,13 +592,13 @@ static inline QDict *qmp_eventwait_ref(const char *event)
 
 /**
  * hmp:
- * @fmt...: HMP command to send to QEMU
+ * @fmt...: HMP command to send to QEMU, formats arguments like sprintf().
  *
  * Send HMP command to QEMU via QMP's human-monitor-command.
  *
  * Returns: the command's output.  The caller should g_free() it.
  */
-char *hmp(const char *fmt, ...);
+char *hmp(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
 
 /**
  * get_irq:
diff --git a/tests/test-hmp.c b/tests/test-hmp.c
index 4156d61..5677fbf 100644
--- a/tests/test-hmp.c
+++ b/tests/test-hmp.c
@@ -81,7 +81,7 @@ static void test_commands(void)
         if (verbose) {
             fprintf(stderr, "\t%s\n", hmp_cmds[i]);
         }
-        response = hmp(hmp_cmds[i]);
+        response = hmp("%s", hmp_cmds[i]);
         g_free(response);
     }
 
@@ -104,7 +104,7 @@ static void test_info_commands(void)
         if (verbose) {
             fprintf(stderr, "\t%s\n", info);
         }
-        resp = hmp(info);
+        resp = hmp("%s", info);
         g_free(resp);
         /* And move forward to the next line */
         info = strchr(endp + 1, '\n');
-- 
1.8.3.1
