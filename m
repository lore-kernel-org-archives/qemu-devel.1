Received: from eggs.gnu.org ([2001:4830:134:3::10]:34240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gMaZt-0004ID-3X
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 10:26:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gMaME-0003PY-82
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 10:12:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42600)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gMaME-0003P3-1r
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 10:12:02 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1818D3082E51
	for <qemu-devel@nongnu.org>; Tue, 13 Nov 2018 15:12:01 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 13 Nov 2018 16:11:44 +0100
Message-Id: <1542121904-17330-1-git-send-email-thuth@redhat.com>
In-Reply-To: <151f5fb1-98d4-5414-aad0-f6c7d704686a@redhat.com>
References: <151f5fb1-98d4-5414-aad0-f6c7d704686a@redhat.com>
Subject: [Qemu-devel] [PATCH] tests/ide: Free pcibus when finishing a test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Once a test has finished, the pcibus structure should be freed, to
avoid leaking memory and to make sure that the structure is properly
re-initialized when the next test starts.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/ide-test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/ide-test.c b/tests/ide-test.c
index 33cef61..f0280e6 100644
--- a/tests/ide-test.c
+++ b/tests/ide-test.c
@@ -142,6 +142,10 @@ static void ide_test_start(const char *cmdline_fmt, ...)
 
 static void ide_test_quit(void)
 {
+    if (pcibus) {
+        qpci_free_pc(pcibus);
+        pcibus = NULL;
+    }
     pc_alloc_uninit(guest_malloc);
     guest_malloc = NULL;
     qtest_end();
-- 
1.8.3.1
