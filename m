Received: from eggs.gnu.org ([2001:4830:134:3::10]:50327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ebS42-00030X-Cp
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:18:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ebS3w-0004c2-HG
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:18:10 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:43646)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1ebS3w-0004bN-Ag
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:18:04 -0500
Received: by mail-wr0-x241.google.com with SMTP id t16so1685439wrc.10
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 06:18:04 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 16 Jan 2018 15:17:00 +0100
Message-Id: <1516112253-14480-19-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1516112253-14480-1-git-send-email-pbonzini@redhat.com>
References: <1516112253-14480-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 18/51] tests: fix migration-test leak
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

Direct leak of 12 byte(s) in 2 object(s) allocated from:
    #0 0x7f50d403c850 in malloc (/lib64/libasan.so.4+0xde850)
    #1 0x7f50d1ddf98f in vasprintf (/lib64/libc.so.6+0x8098f)

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20180104160523.22995-12-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/migration-test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/migration-test.c b/tests/migration-test.c
index be598d3..799e24e 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -358,13 +358,14 @@ static void migrate_check_parameter(QTestState *who, const char *parameter,
                                     const char *value)
 {
     QDict *rsp, *rsp_return;
-    const char *result;
+    char *result;
 
     rsp = wait_command(who, "{ 'execute': 'query-migrate-parameters' }");
     rsp_return = qdict_get_qdict(rsp, "return");
     result = g_strdup_printf("%" PRId64,
                              qdict_get_try_int(rsp_return,  parameter, -1));
     g_assert_cmpstr(result, ==, value);
+    g_free(result);
     QDECREF(rsp);
 }
 
-- 
1.8.3.1
