Received: from eggs.gnu.org ([2001:4830:134:3::10]:41810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxYw-0007cZ-HI
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxYv-0005Zj-Kl
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:54 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:33809)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eZxYv-0005Y3-Em
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:53 -0500
Received: by mail-wr0-x242.google.com with SMTP id 36so5057758wrh.1
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 03:31:53 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Jan 2018 12:30:52 +0100
Message-Id: <1515756676-3860-29-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
References: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 28/52] tests/boot-serial-test: Add tests for
 microblaze boards
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

This adds two simple TCG + UART tests for the microblaze boards,
one in big endian mode, and one in little endian mode.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1512031988-32490-5-git-send-email-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/Makefile.include   |  2 ++
 tests/boot-serial-test.c | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 39a4b53..561e14b 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -300,6 +300,8 @@ check-qtest-alpha-y = tests/boot-serial-test$(EXESUF)
 
 check-qtest-m68k-y = tests/boot-serial-test$(EXESUF)
 
+check-qtest-microblaze-y = tests/boot-serial-test$(EXESUF)
+
 check-qtest-mips-y = tests/endianness-test$(EXESUF)
 
 check-qtest-mips64-y = tests/endianness-test$(EXESUF)
diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
index dd3828c..a39273a 100644
--- a/tests/boot-serial-test.c
+++ b/tests/boot-serial-test.c
@@ -24,6 +24,22 @@ static const uint8_t kernel_mcf5208[] = {
     0x60, 0xfa                              /* bra.s  loop */
 };
 
+static const uint8_t kernel_pls3adsp1800[] = {
+    0xb0, 0x00, 0x84, 0x00,                 /* imm   0x8400 */
+    0x30, 0x60, 0x00, 0x04,                 /* addik r3,r0,4 */
+    0x30, 0x80, 0x00, 0x54,                 /* addik r4,r0,'T' */
+    0xf0, 0x83, 0x00, 0x00,                 /* sbi   r4,r3,0 */
+    0xb8, 0x00, 0xff, 0xfc                  /* bri   -4  loop */
+};
+
+static const uint8_t kernel_plml605[] = {
+    0xe0, 0x83, 0x00, 0xb0,                 /* imm   0x83e0 */
+    0x00, 0x10, 0x60, 0x30,                 /* addik r3,r0,0x1000 */
+    0x54, 0x00, 0x80, 0x30,                 /* addik r4,r0,'T' */
+    0x00, 0x00, 0x83, 0xf0,                 /* sbi   r4,r3,0 */
+    0xfc, 0xff, 0x00, 0xb8                  /* bri   -4  loop */
+};
+
 typedef struct testdef {
     const char *arch;       /* Target architecture */
     const char *machine;    /* Name of the machine */
@@ -50,6 +66,10 @@ static testdef_t tests[] = {
     { "s390x", "s390-ccw-virtio",
       "-nodefaults -device sclpconsole,chardev=serial0", "virtio device" },
     { "m68k", "mcf5208evb", "", "TT", sizeof(kernel_mcf5208), kernel_mcf5208 },
+    { "microblaze", "petalogix-s3adsp1800", "", "TT",
+      sizeof(kernel_pls3adsp1800), kernel_pls3adsp1800 },
+    { "microblazeel", "petalogix-ml605", "", "TT",
+      sizeof(kernel_plml605), kernel_plml605 },
 
     { NULL }
 };
-- 
1.8.3.1
