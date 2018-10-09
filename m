Received: from eggs.gnu.org ([2001:4830:134:3::10]:58172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g9tUK-0007Qo-Le
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:00:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g9tU2-0006P7-Q5
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:59:54 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41745)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g9tU2-0006Ni-Gw
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:59:38 -0400
Received: by mail-wr1-x444.google.com with SMTP id x12-v6so2178125wru.8
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 07:59:38 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  9 Oct 2018 15:59:33 +0100
Message-Id: <20181009145933.18925-4-alex.bennee@linaro.org>
In-Reply-To: <20181009145933.18925-1-alex.bennee@linaro.org>
References: <20181009145933.18925-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 3/3] tests/tcg: disable enterN insn tests
 for test-i386 with clang
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, f4bug@amsat.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

The enter[qwl] instructions aren't supported by clang's inline
assembler. Apply the hammer to work around it when we re-use our
system compiler to build tcg tests.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/i386/test-i386.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/tcg/i386/test-i386.c b/tests/tcg/i386/test-i386.c
index c5f67000e4..da632c9b67 100644
--- a/tests/tcg/i386/test-i386.c
+++ b/tests/tcg/i386/test-i386.c
@@ -2098,6 +2098,7 @@ long enter_stack[4096];
 
 static void test_enter(void)
 {
+#if !(defined __clang__)
 #if defined(__x86_64__)
     TEST_ENTER("q", uint64_t, 0);
     TEST_ENTER("q", uint64_t, 1);
@@ -2114,6 +2115,7 @@ static void test_enter(void)
     TEST_ENTER("w", uint16_t, 1);
     TEST_ENTER("w", uint16_t, 2);
     TEST_ENTER("w", uint16_t, 31);
+#endif
 }
 
 #ifdef TEST_SSE
-- 
2.17.1
