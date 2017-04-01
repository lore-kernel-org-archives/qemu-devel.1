Received: from eggs.gnu.org ([2001:4830:134:3::10]:49583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJJh-000727-E0
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:43:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <g.danil.anto@gmail.com>) id 1cuJJd-0005dw-6F
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:43:42 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:34772)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <g.danil.anto@gmail.com>)
	id 1cuJJd-0005cv-0l
	for qemu-devel@nongnu.org; Sat, 01 Apr 2017 09:43:41 -0400
Received: by mail-oi0-x242.google.com with SMTP id t11so13192066oib.1
	for <qemu-devel@nongnu.org>; Sat, 01 Apr 2017 06:43:40 -0700 (PDT)
MIME-Version: 1.0
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Sat, 1 Apr 2017 16:43:39 +0300
Message-ID: <CA+KKJYCJgdXhUpPLO4POBKta+xO3UGip1MiyOH99-vTNrn8m8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Qemu-devel] [PATCH 08/43] kvm: made printf always compile in debug
 output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com, rth@twiddle.net, ehabkost@redhat.com

>From 7aed02e5ee9662d4ff8e7857594fdf7b3b52c9e4 Mon Sep 17 00:00:00 2001
From: Danil Antonov <g.danil.anto@gmail.com>
Date: Wed, 29 Mar 2017 02:16:54 +0300
Subject: [PATCH 08/43] kvm: made printf always compile in debug output

Wrapped printf calls inside debug macros (DPRINTF) in `if` statement.
This will ensure that printf function will always compile even if debug
output is turned off and, in turn, will prevent bitrot of the format
strings.

Signed-off-by: Danil Antonov <g.danil.anto@gmail.com>
---
 target/i386/kvm.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 55865db..46762e2 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -47,15 +47,15 @@
 #include "exec/memattrs.h"
 #include "trace.h"

-//#define DEBUG_KVM
-
-#ifdef DEBUG_KVM
-#define DPRINTF(fmt, ...) \
-    do { fprintf(stderr, fmt, ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) \
-    do { } while (0)
-#endif
+#ifndef DEBUG_KVM
+#define DEBUG_KVM 0
+#endif
+
+#define DPRINTF(fmt, ...) do {                \
+    if (DEBUG_KVM) {                         \
+        fprintf(stderr, fmt, ## __VA_ARGS__); \
+    }                                         \
+} while (0);

 #define MSR_KVM_WALL_CLOCK  0x11
 #define MSR_KVM_SYSTEM_TIME 0x12
-- 
2.8.0.rc3
