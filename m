Received: from eggs.gnu.org ([2001:4830:134:3::10]:33710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4n-0002IK-SS
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4Y-0006s0-6x
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:11 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40233)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsA4X-00060q-DF
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:01 -0400
Received: by mail-wr1-x444.google.com with SMTP id n2-v6so6002026wrw.7
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:03:29 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Aug 2018 19:01:55 +0200
Message-Id: <1534870966-9287-24-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 23/74] tests/atomic_add-bench: add -p to enable
 sync profiler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

When used together with -m, this allows us to benchmark the
profiler's performance impact on qemu_mutex_lock.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/atomic_add-bench.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/atomic_add-bench.c b/tests/atomic_add-bench.c
index f96d448..2f6c72f 100644
--- a/tests/atomic_add-bench.c
+++ b/tests/atomic_add-bench.c
@@ -26,6 +26,7 @@ static bool test_stop;
 static const char commands_string[] =
     " -n = number of threads\n"
     " -m = use mutexes instead of atomic increments\n"
+    " -p = enable sync profiler\n"
     " -d = duration in seconds\n"
     " -r = range (will be rounded up to pow2)";
 
@@ -143,7 +144,7 @@ static void parse_args(int argc, char *argv[])
     int c;
 
     for (;;) {
-        c = getopt(argc, argv, "hd:n:mr:");
+        c = getopt(argc, argv, "hd:n:mpr:");
         if (c < 0) {
             break;
         }
@@ -160,6 +161,9 @@ static void parse_args(int argc, char *argv[])
         case 'm':
             use_mutex = true;
             break;
+        case 'p':
+            qsp_enable();
+            break;
         case 'r':
             range = pow2ceil(atoi(optarg));
             break;
-- 
1.8.3.1
