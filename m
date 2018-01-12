Received: from eggs.gnu.org ([2001:4830:134:3::10]:41652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxYi-0007KQ-PQ
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxYh-0004tJ-Na
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:40 -0500
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:33737)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eZxYh-0004qw-Hw
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:39 -0500
Received: by mail-wr0-x22c.google.com with SMTP id p6so5052667wrd.0
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 03:31:39 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Jan 2018 12:30:40 +0100
Message-Id: <1515756676-3860-17-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
References: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 16/52] tests: fix check-qobject leak
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

/public/qobject_is_equal_conversion: OK

=================================================================
==14396==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 56 byte(s) in 1 object(s) allocated from:
    #0 0x7f07682c5850 in malloc (/lib64/libasan.so.4+0xde850)
    #1 0x7f0767d12f0c in g_malloc ../glib/gmem.c:94
    #2 0x7f0767d131cf in g_malloc_n ../glib/gmem.c:331
    #3 0x562bd767371f in do_test_equality /home/elmarco/src/qq/tests/check-qobject.c:49
    #4 0x562bd7674a35 in qobject_is_equal_dict_test /home/elmarco/src/qq/tests/check-qobject.c:267
    #5 0x7f0767d37b04 in test_case_run ../glib/gtestutils.c:2237
    #6 0x7f0767d37ec4 in g_test_run_suite_internal ../glib/gtestutils.c:2321
    #7 0x7f0767d37f6d in g_test_run_suite_internal ../glib/gtestutils.c:2333
    #8 0x7f0767d38184 in g_test_run_suite ../glib/gtestutils.c:2408
    #9 0x7f0767d36e0d in g_test_run ../glib/gtestutils.c:1674
    #10 0x562bd7674e75 in main /home/elmarco/src/qq/tests/check-qobject.c:327
    #11 0x7f0766009039 in __libc_start_main (/lib64/libc.so.6+0x21039)

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20180104160523.22995-9-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/check-qobject.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/check-qobject.c b/tests/check-qobject.c
index 03e9175..710f9e6 100644
--- a/tests/check-qobject.c
+++ b/tests/check-qobject.c
@@ -59,6 +59,8 @@ static void do_test_equality(bool expected, int _, ...)
             g_assert(qobject_is_equal(args[i], args[j]) == expected);
         }
     }
+
+    g_free(args);
 }
 
 #define check_equal(...) \
-- 
1.8.3.1
