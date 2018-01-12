Received: from eggs.gnu.org ([2001:4830:134:3::10]:41764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxYs-0007Vq-E2
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxYo-0005GZ-L2
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:50 -0500
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:37310)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eZxYo-0005DW-EN
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:46 -0500
Received: by mail-wr0-x230.google.com with SMTP id f8so5036628wre.4
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 03:31:46 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Jan 2018 12:30:46 +0100
Message-Id: <1515756676-3860-23-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
References: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 22/52] tests: fix qmp-test leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Direct leak of 913 byte(s) in 43 object(s) allocated from:
    #0 0x55880a15df60 in __interceptor_malloc (/home/elmarco/src/qq/build/tests/qmp-test+0x110f60)
    #1 0x7f3f20fd098f in _IO_vasprintf (/lib64/libc.so.6+0x8098f)

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20180104160523.22995-15-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/qmp-test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index c5a5c10..36feb22 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -271,7 +271,7 @@ static void add_query_tests(QmpSchema *schema)
 {
     SchemaInfoList *tail;
     SchemaInfo *si, *arg_type, *ret_type;
-    const char *test_name;
+    char *test_name;
 
     /* Test the query-like commands */
     for (tail = schema->list; tail; tail = tail->next) {
@@ -297,6 +297,7 @@ static void add_query_tests(QmpSchema *schema)
 
         test_name = g_strdup_printf("qmp/%s", si->name);
         qtest_add_data_func(test_name, si->name, test_query);
+        g_free(test_name);
     }
 }
 
-- 
1.8.3.1
