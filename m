Received: from eggs.gnu.org ([2001:4830:134:3::10]:38916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drSP3-0007xi-7A
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:21:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1drSP2-0001Uk-AP
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:21:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:28635)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1drSP2-0001US-5G
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:21:44 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3BCF416483E
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 17:21:43 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Mon, 11 Sep 2017 12:20:14 -0500
Message-Id: <20170911172022.4738-31-eblake@redhat.com>
In-Reply-To: <20170911172022.4738-1-eblake@redhat.com>
References: <20170911172022.4738-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v7 30/38] qtest: Avoid passing raw strings
 through hmp()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, thuth@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

hmp() passes its string argument through the sprintf() family;
with a proper attribute, gcc -Wformat warns us when we do something
dangerous like passing a non-constant format string.  Fortunately,
all our strings were safe, but checking whether the string can
contain an unintended % is easy to avoid and therefore worth doing.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v7: add GCC_FMT_ATTR here, drop R-b
---
 tests/libqtest.h | 8 ++++----
 tests/test-hmp.c | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/libqtest.h b/tests/libqtest.h
index 2a21bf4605..5651b77d2f 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -153,14 +153,14 @@ QDict *qtest_qmp_eventwait_ref(QTestState *s, const char *event);
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
@@ -585,13 +585,13 @@ static inline QDict *qmp_eventwait_ref(const char *event)

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
index 7ff47eda13..b3102daea1 100644
--- a/tests/test-hmp.c
+++ b/tests/test-hmp.c
@@ -80,7 +80,7 @@ static void test_commands(void)
         if (verbose) {
             fprintf(stderr, "\t%s\n", hmp_cmds[i]);
         }
-        response = hmp(hmp_cmds[i]);
+        response = hmp("%s", hmp_cmds[i]);
         g_free(response);
     }

@@ -103,7 +103,7 @@ static void test_info_commands(void)
         if (verbose) {
             fprintf(stderr, "\t%s\n", info);
         }
-        resp = hmp(info);
+        resp = hmp("%s", info);
         g_free(resp);
         /* And move forward to the next line */
         info = strchr(endp + 1, '\n');
-- 
2.13.5
