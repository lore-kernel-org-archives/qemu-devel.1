Received: from eggs.gnu.org ([2001:4830:134:3::10]:35337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cSs4r-0006EX-84
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 16:11:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cSs4o-0002rJ-2r
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 16:11:01 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:33108)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1cSs4n-0002rD-Tj
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 16:10:58 -0500
Received: by mail-pf0-x244.google.com with SMTP id e4so2469944pfg.0
	for <qemu-devel@nongnu.org>; Sun, 15 Jan 2017 13:10:57 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sun, 15 Jan 2017 13:10:17 -0800
Message-Id: <1484514617-11726-8-git-send-email-jcmvbkbc@gmail.com>
In-Reply-To: <1484514617-11726-1-git-send-email-jcmvbkbc@gmail.com>
References: <1484514617-11726-1-git-send-email-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 7/7] target/xtensa: tests: add ccount write
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
Cc: Max Filippov <jcmvbkbc@gmail.com>

Check that CCOUNT SR is writable and that CCOMPARE timers are updated
when CCOUNT is written to.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 tests/tcg/xtensa/test_timer.S | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tests/tcg/xtensa/test_timer.S b/tests/tcg/xtensa/test_timer.S
index 844c032..6cda71a 100644
--- a/tests/tcg/xtensa/test_timer.S
+++ b/tests/tcg/xtensa/test_timer.S
@@ -19,6 +19,40 @@ test ccount
     assert  ne, a3, a4
 test_end
 
+test ccount_write
+    rsr     a3, ccount
+    rsr     a4, ccount
+    sub     a4, a4, a3
+    movi    a2, 0x12345678
+    wsr     a2, ccount
+    esync
+    rsr     a3, ccount
+    sub     a3, a3, a2
+    slli    a4, a4, 2
+    assert  ltu, a3, a4
+test_end
+
+test ccount_update_deadline
+    movi    a2, 0
+    wsr     a2, intenable
+    rsr     a2, interrupt
+    wsr     a2, intclear
+    movi    a2, 0
+    wsr     a2, ccompare1
+    wsr     a2, ccompare2
+    movi    a2, 0x12345678
+    wsr     a2, ccompare0
+    rsr     a3, interrupt
+    assert  eqi, a3, 0
+    movi    a2, 0x12345677
+    wsr     a2, ccount
+    esync
+    nop
+    rsr     a2, interrupt
+    movi    a3, 1 << XCHAL_TIMER0_INTERRUPT
+    assert  eq, a2, a3
+test_end
+
 test ccompare
     movi    a2, 0
     wsr     a2, intenable
-- 
2.1.4
