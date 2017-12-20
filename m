Received: from eggs.gnu.org ([2001:4830:134:3::10]:56445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhyO-0004hi-KB
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhyK-0007FU-LG
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:04 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33268)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eRhyK-0007F3-EG
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:00 -0500
Received: by mail-wm0-x242.google.com with SMTP id g130so16655981wme.0
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 09:16:00 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Dec 2017 18:14:35 +0100
Message-Id: <1513790098-9815-24-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
References: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 23/46] tests/boot-serial-test: Add a test for
 the moxiesim machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

Now that moxiesim supports the -bios parameter, we can check this machine
in the boot-serial tester, too, by supplying a mini bios that only writes
'T' characters to the UART.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1512031988-32490-7-git-send-email-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include   | 2 ++
 tests/boot-serial-test.c | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 5789911..02ca4b2 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -307,6 +307,8 @@ check-qtest-mips64-y = tests/endianness-test$(EXESUF)
 
 check-qtest-mips64el-y = tests/endianness-test$(EXESUF)
 
+check-qtest-moxie-y = tests/boot-serial-test$(EXESUF)
+
 check-qtest-ppc-y = tests/endianness-test$(EXESUF)
 check-qtest-ppc-y += tests/boot-order-test$(EXESUF)
 check-qtest-ppc-y += tests/prom-env-test$(EXESUF)
diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
index a39273a..1deddb8 100644
--- a/tests/boot-serial-test.c
+++ b/tests/boot-serial-test.c
@@ -40,6 +40,13 @@ static const uint8_t kernel_plml605[] = {
     0xfc, 0xff, 0x00, 0xb8                  /* bri   -4  loop */
 };
 
+static const uint8_t bios_moxiesim[] = {
+    0x20, 0x10, 0x00, 0x00, 0x03, 0xf8,     /* ldi.s r1,0x3f8 */
+    0x1b, 0x20, 0x00, 0x00, 0x00, 0x54,     /* ldi.b r2,'T' */
+    0x1e, 0x12,                             /* st.b  r1,r2 */
+    0x1a, 0x00, 0x00, 0x00, 0x10, 0x00      /* jmpa  0x1000 */
+};
+
 typedef struct testdef {
     const char *arch;       /* Target architecture */
     const char *machine;    /* Name of the machine */
@@ -70,6 +77,7 @@ static testdef_t tests[] = {
       sizeof(kernel_pls3adsp1800), kernel_pls3adsp1800 },
     { "microblazeel", "petalogix-ml605", "", "TT",
       sizeof(kernel_plml605), kernel_plml605 },
+    { "moxie", "moxiesim", "", "TT", sizeof(bios_moxiesim), 0, bios_moxiesim },
 
     { NULL }
 };
-- 
1.8.3.1
