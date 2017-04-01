Received: from eggs.gnu.org ([2001:4830:134:3::10]:55242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJZ5-0007op-Uj
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:59:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJZ4-0005HR-WB
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:59:40 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:36732)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <g.danil.anto@gmail.com>)
	id 1cuJZ4-0005Gq-Qv
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:59:38 -0400
Received: by mail-oi0-x244.google.com with SMTP id b187so13221229oif.3
	for <qemu-devel@nongnu.org>; Sat, 01 Apr 2017 06:59:38 -0700 (PDT)
MIME-Version: 1.0
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Sat, 1 Apr 2017 16:59:37 +0300
Message-ID: <CA+KKJYAdwLrCGKxrurARb5M1DQgHiEUFq587Enes8D5HFhvkxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] [PATCH 25/43] kvm-all: made printf always compile in
 debug output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

>From f818d3ef7db8cc5b99656fd1059c0d7d07dea571 Mon Sep 17 00:00:00 2001
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Wed, 29 Mar 2017 12:35:36 +0300
Subject: [PATCH 25/43] kvm-all: made printf always compile in debug output

Wrapped printf calls inside debug macros (DPRINTF) in `if` statement.
This will ensure that printf function will always compile even if debug
output is turned off and, in turn, will prevent bitrot of the format
strings.

Signed-off-by: Danil Antonov <g.danil.anto@gmail.com>
---
 kvm-all.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kvm-all.c b/kvm-all.c
index 90b8573..47940b5 100644
--- a/kvm-all.c
+++ b/kvm-all.c
@@ -50,16 +50,16 @@
  */
 #define PAGE_SIZE getpagesize()

-//#define DEBUG_KVM
-
-#ifdef DEBUG_KVM
-#define DPRINTF(fmt, ...) \
-    do { fprintf(stderr, fmt, ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) \
-    do { } while (0)
+#ifndef DEBUG_KVM
+#define DEBUG_KVM 0
 #endif

+#define DPRINTF(fmt, ...) do {                \
+    if (DEBUG_KVM) {                        \
+        fprintf(stderr, fmt, ## __VA_ARGS__); \
+    }                                         \
+} while (0);
+
 #define KVM_MSI_HASHTAB_SIZE    256

 struct KVMParkedVcpu {
-- 
2.8.0.rc3
